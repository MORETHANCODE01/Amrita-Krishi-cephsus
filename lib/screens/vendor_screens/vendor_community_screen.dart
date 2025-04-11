import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorCommunityScreen extends StatefulWidget {
  const VendorCommunityScreen({super.key});

  @override
  State<VendorCommunityScreen> createState() => _VendorCommunityScreenState();
}

class _VendorCommunityScreenState extends State<VendorCommunityScreen> {
  final TextEditingController _postController = TextEditingController();
  final List<CommunityPost> _posts = [
    CommunityPost(
      id: '1',
      vendorName: 'Punjab Trading Co.',
      vendorId: 'vendor1',
      avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=100&q=80',
      content: 'Is anyone attending the Grain Marketing Seminar next week in Chandigarh?',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      likes: 12,
      comments: [
        PostComment(
          id: 'c1',
          vendorName: 'Aggarwal Traders',
          vendorId: 'vendor2',
          content: 'Yes, our team will be there. Looking forward to discussing this season\'s wheat prices!',
          timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        ),
        PostComment(
          id: 'c2',
          vendorName: 'Modern Vegetables',
          vendorId: 'vendor3',
          content: 'What time is it starting? I might be able to make it for the afternoon session.',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        ),
      ],
    ),
    CommunityPost(
      id: '2',
      vendorName: 'Aggarwal Traders',
      vendorId: 'vendor2',
      avatarUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=100&q=80',
      content: 'Has anyone worked with farmers in the Amritsar region growing PR-126 paddy variety? How are the yields this season?',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      likes: 8,
      comments: [
        PostComment(
          id: 'c3',
          vendorName: 'Singh Rice Mills',
          vendorId: 'vendor4',
          content: 'We\'ve been working with several farmers there. The yields are about 5-10% better than last year with the favorable rains.',
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
        ),
      ],
    ),
    CommunityPost(
      id: '3',
      vendorName: 'Janta Vegetables',
      vendorId: 'vendor5',
      avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=100&q=80',
      content: 'Looking for transport partners for regular vegetable shipments from Jalandhar to Delhi. Anyone have good recommendations?',
      timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 8)),
      likes: 15,
      comments: [
        PostComment(
          id: 'c4',
          vendorName: 'Modern Vegetables',
          vendorId: 'vendor3',
          content: 'We use Speedy Logistics. They have refrigerated trucks and are reliable. Contact Manpreet at 9876543210.',
          timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 6)),
        ),
        PostComment(
          id: 'c5',
          vendorName: 'Punjab Trading Co.',
          vendorId: 'vendor1',
          content: 'I second Speedy Logistics. We\'ve been using them for 3 years with minimal issues.',
          timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 5)),
        ),
        PostComment(
          id: 'c6',
          vendorName: 'Aggarwal Traders',
          vendorId: 'vendor2',
          content: 'Falcon Transport is also good if you\'re shipping large volumes. They offer better rates for 10+ ton loads.',
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 12)),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Vendor Community',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange.shade700,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildPostComposer(),
          Expanded(
            child: _posts.isEmpty
                ? Center(
                    child: Text(
                      'No posts yet. Be the first to share something!',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      return _buildPostCard(_posts[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreatePostDialog();
        },
        backgroundColor: Colors.orange.shade700,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPostComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.orange.shade100,
            radius: 20,
            child: Icon(
              Icons.person,
              color: Colors.orange.shade700,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: InkWell(
              onTap: () {
                _showCreatePostDialog();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  'Share something with the vendor community...',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(CommunityPost post) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: post.avatarUrl != null
                      ? NetworkImage(post.avatarUrl!)
                      : null,
                  backgroundColor: Colors.orange.shade100,
                  child: post.avatarUrl == null
                      ? Icon(
                          Icons.person,
                          color: Colors.orange.shade700,
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.vendorName,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        _formatTimestamp(post.timestamp),
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.grey.shade600,
                  ),
                  onPressed: () {
                    _showPostOptions(post);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              post.content,
              style: GoogleFonts.poppins(
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      post.isLiked = !post.isLiked;
                      if (post.isLiked) {
                        post.likes++;
                      } else {
                        post.likes--;
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        post.isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                        size: 16,
                        color: post.isLiked ? Colors.orange.shade700 : Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        post.likes.toString(),
                        style: GoogleFonts.poppins(
                          color: post.isLiked ? Colors.orange.shade700 : Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    _showCommentSheet(post);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.comment_outlined,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        post.comments.length.toString(),
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    // TODO: Implement share functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Share functionality coming soon!')),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.share_outlined,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Share',
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (post.comments.isNotEmpty) const Divider(height: 1),
          if (post.comments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < min(2, post.comments.length); i++)
                    _buildCommentPreview(post.comments[i]),
                  if (post.comments.length > 2)
                    TextButton(
                      onPressed: () {
                        _showCommentSheet(post);
                      },
                      child: Text(
                        'View all ${post.comments.length} comments',
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCommentPreview(PostComment comment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.grey.shade200,
            child: Icon(
              Icons.person,
              color: Colors.grey.shade600,
              size: 16,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: comment.vendorName,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                      TextSpan(
                        text: ' ${comment.content}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  _formatTimestamp(comment.timestamp),
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCommentSheet(CommunityPost post) {
    final TextEditingController commentController = TextEditingController();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Comments',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: post.comments.length,
                        itemBuilder: (context, index) {
                          final comment = post.comments[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.grey.shade200,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey.shade600,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        comment.vendorName,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        comment.content,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _formatTimestamp(comment.timestamp),
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey.shade600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.orange.shade100,
                          child: Icon(
                            Icons.person,
                            color: Colors.orange.shade700,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              hintText: 'Add a comment...',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.orange.shade700,
                          ),
                          onPressed: () {
                            if (commentController.text.trim().isEmpty) return;
                            
                            // Add the comment (in a real app this would update a backend)
                            this.setState(() {
                              post.comments.add(
                                PostComment(
                                  id: 'new-${DateTime.now().millisecondsSinceEpoch}',
                                  vendorName: 'Aggarwal Traders', // Current vendor
                                  vendorId: 'vendor2', // Current vendor ID
                                  content: commentController.text.trim(),
                                  timestamp: DateTime.now(),
                                ),
                              );
                            });
                            
                            // Clear the input and close the sheet
                            commentController.clear();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showCreatePostDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Create Post',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: _postController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'What would you like to share with the vendor community?',
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_postController.text.trim().isEmpty) return;
                
                // Add the post (in a real app this would update a backend)
                setState(() {
                  _posts.insert(
                    0,
                    CommunityPost(
                      id: 'new-${DateTime.now().millisecondsSinceEpoch}',
                      vendorName: 'Aggarwal Traders', // Current vendor
                      vendorId: 'vendor2', // Current vendor ID
                      content: _postController.text.trim(),
                      timestamp: DateTime.now(),
                      likes: 0,
                      comments: [],
                    ),
                  );
                });
                
                // Clear the input and close the dialog
                _postController.clear();
                Navigator.pop(context);
                
                // Show a success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post shared successfully!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade700,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Post',
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPostOptions(CommunityPost post) {
    final bool isMyPost = post.vendorId == 'vendor2'; // Current vendor ID
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isMyPost) ...[
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: Text(
                    'Edit Post',
                    style: GoogleFonts.poppins(),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _showEditPostDialog(post);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: Text(
                    'Delete Post',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _showDeleteConfirmation(post);
                  },
                ),
              ],
              ListTile(
                leading: const Icon(Icons.bookmark_border),
                title: Text(
                  'Save Post',
                  style: GoogleFonts.poppins(),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Post saved!')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: Text(
                  'Share Post',
                  style: GoogleFonts.poppins(),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share functionality coming soon!')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.flag),
                title: Text(
                  'Report Post',
                  style: GoogleFonts.poppins(),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Post reported to moderators')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditPostDialog(CommunityPost post) {
    final TextEditingController editController = TextEditingController(text: post.content);
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Edit Post',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: editController,
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (editController.text.trim().isEmpty) return;
                
                setState(() {
                  post.content = editController.text.trim();
                  post.isEdited = true;
                });
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post updated successfully!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade700,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Save',
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(CommunityPost post) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Delete Post',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete this post? This action cannot be undone.',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _posts.removeWhere((p) => p.id == post.id);
                });
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post deleted successfully!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Delete',
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Filter Posts',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'All Posts',
                  style: GoogleFonts.poppins(),
                ),
                leading: const Icon(Icons.list),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Showing all posts')),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Most Popular',
                  style: GoogleFonts.poppins(),
                ),
                leading: const Icon(Icons.trending_up),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _posts.sort((a, b) => b.likes.compareTo(a.likes));
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Showing most popular posts')),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Most Recent',
                  style: GoogleFonts.poppins(),
                ),
                leading: const Icon(Icons.access_time),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Showing most recent posts')),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Most Discussed',
                  style: GoogleFonts.poppins(),
                ),
                leading: const Icon(Icons.chat_bubble_outline),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _posts.sort((a, b) => b.comments.length.compareTo(a.comments.length));
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Showing most discussed posts')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  int min(int a, int b) {
    return a < b ? a : b;
  }
}

class CommunityPost {
  final String id;
  final String vendorName;
  final String vendorId;
  final String? avatarUrl;
  String content;
  final DateTime timestamp;
  int likes;
  bool isLiked = false;
  bool isEdited = false;
  final List<PostComment> comments;

  CommunityPost({
    required this.id,
    required this.vendorName,
    required this.vendorId,
    this.avatarUrl,
    required this.content,
    required this.timestamp,
    required this.likes,
    required this.comments,
  });
}

class PostComment {
  final String id;
  final String vendorName;
  final String vendorId;
  final String content;
  final DateTime timestamp;

  PostComment({
    required this.id,
    required this.vendorName,
    required this.vendorId,
    required this.content,
    required this.timestamp,
  });
} 