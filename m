Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FD474C706
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:31:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAS-0008I4-S8; Sun, 09 Jul 2023 14:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAO-0008FL-H3
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAL-0000Fo-TA
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82d9cso39245025e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927388; x=1691519388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZowV46RDd4UZGFRJaWN3kYV5vNiK42zQttdiJYmLHk=;
 b=MOvYnW5e1suGnFAHhS/xybBjtI5aw7Sqf74e8pT7LTfqjkEISNn4uMgXjWI+G0LrLZ
 BELzcneaIjZdRFAepURgVZhr9r2xBsFEVeD8F1/F0KsrseHvUWFRdjTOfqR8FM6rGDbe
 izNQYyRKYZOcTyUQecelp5rb2qs+Sv5xpCP7Pyy3ZyqoCSkopv8Nz/fhLzKTvYecp64r
 pX/LJYLpJUJ11ZZNeRh68gcBv2Q7+yyox1SrZHwBOy4oM0UJeqBg+uCqP9QX4Qu/2sl5
 w6MrqiR6i0Omunfm4/jHeZ3SQXDGEWXGZ8cQ0TcDJKyVLSmEvF9VqK9/8TOUEqwvCayb
 KIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927388; x=1691519388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZowV46RDd4UZGFRJaWN3kYV5vNiK42zQttdiJYmLHk=;
 b=AErLhq/mBKveKU5bmpS9uACIHa5PUfXWo43B94/Xo2TAqHgRieynI0Gzh4GbbWh/Ni
 +Dy3cgZSsJ+v0zmSC+FR7c2RE8KDLg5ZOlPSbUSZHx9TChdNV/Uq7EzPzqZmJ4tq65Wb
 qJDRrBrdoNMfeoYzM7beNgBwwa8RGc5mUyM/7UA5JI07coKoFKhUVRV2YEJ+1TI0jLSy
 tv/XhyLWhfe+fYHpFL/df/wc9cz03HRCsBIGJz+DaxrQiKmcRZBHN7KsDSCWNrPO3H24
 yLHlU8mZljQec20p2NzO5/pjHHGdizBNp7oIdtmdct9+iAW5dXoiclVZalpna6ylzXKd
 ZmrA==
X-Gm-Message-State: ABy/qLa37Efucfm4zyayJpjISKCd0fKXazzQqS2zbLn1v1L/oPuBh0Zp
 4mHKEjKzEk1fjHtx+N+0Z7Vm5gKZKElq87aiVUwdyA==
X-Google-Smtp-Source: APBJJlFnVgDV3+Z+qET6OJYYrxEXWWp6gm5jeG/+XvU+f6mpOqaW6NBM0/o0Q59vXr7rul8yOWaTrA==
X-Received: by 2002:a1c:7904:0:b0:3fc:a8:dc3c with SMTP id
 l4-20020a1c7904000000b003fc00a8dc3cmr6258873wme.37.1688927388242; 
 Sun, 09 Jul 2023 11:29:48 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 07/45] linux-user: Use abi_uint not unsigned int in
 syscall_defs.h
Date: Sun,  9 Jul 2023 19:28:26 +0100
Message-Id: <20230709182934.309468-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall_defs.h | 290 +++++++++++++++++++-------------------
 1 file changed, 145 insertions(+), 145 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 2846a8cfa5..20986bd1d3 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -366,7 +366,7 @@ struct target_msghdr {
     abi_long     msg_iovlen;     /* Number of blocks            */
     abi_long     msg_control;    /* Per protocol magic (eg BSD file descriptor passing) */
     abi_long     msg_controllen; /* Length of cmsg list */
-    unsigned int msg_flags;
+    abi_uint     msg_flags;
 };
 
 struct target_cmsghdr {
@@ -403,7 +403,7 @@ __target_cmsg_nxthdr(struct target_msghdr *__mhdr,
 
 struct target_mmsghdr {
     struct target_msghdr msg_hdr;              /* Message header */
-    unsigned int         msg_len;              /* Number of bytes transmitted */
+    abi_uint             msg_len;              /* Number of bytes transmitted */
 };
 
 struct  target_rusage {
@@ -595,8 +595,8 @@ typedef struct target_siginfo {
 
         /* POSIX.1b timers */
         struct {
-            unsigned int _timer1;
-            unsigned int _timer2;
+            abi_uint _timer1;
+            abi_uint _timer2;
         } _timer;
 
         /* POSIX.1b signals */
@@ -857,10 +857,10 @@ struct target_rtc_pll_info {
 #define TARGET_TUNSETOWNER        TARGET_IOW('T', 204, int)
 #define TARGET_TUNSETLINK         TARGET_IOW('T', 205, int)
 #define TARGET_TUNSETGROUP        TARGET_IOW('T', 206, int)
-#define TARGET_TUNGETFEATURES     TARGET_IOR('T', 207, unsigned int)
-#define TARGET_TUNSETOFFLOAD      TARGET_IOW('T', 208, unsigned int)
-#define TARGET_TUNSETTXFILTER     TARGET_IOW('T', 209, unsigned int)
-#define TARGET_TUNGETIFF          TARGET_IOR('T', 210, unsigned int)
+#define TARGET_TUNGETFEATURES     TARGET_IOR('T', 207, abi_uint)
+#define TARGET_TUNSETOFFLOAD      TARGET_IOW('T', 208, abi_uint)
+#define TARGET_TUNSETTXFILTER     TARGET_IOW('T', 209, abi_uint)
+#define TARGET_TUNGETIFF          TARGET_IOR('T', 210, abi_uint)
 #define TARGET_TUNGETSNDBUF       TARGET_IOR('T', 211, int)
 #define TARGET_TUNSETSNDBUF       TARGET_IOW('T', 212, int)
 /*
@@ -870,7 +870,7 @@ struct target_rtc_pll_info {
 #define TARGET_TUNGETVNETHDRSZ    TARGET_IOR('T', 215, int)
 #define TARGET_TUNSETVNETHDRSZ    TARGET_IOW('T', 216, int)
 #define TARGET_TUNSETQUEUE        TARGET_IOW('T', 217, int)
-#define TARGET_TUNSETIFINDEX      TARGET_IOW('T', 218, unsigned int)
+#define TARGET_TUNSETIFINDEX      TARGET_IOW('T', 218, abi_uint)
 /* TUNGETFILTER is not supported: see TUNATTACHFILTER. */
 #define TARGET_TUNSETVNETLE       TARGET_IOW('T', 220, int)
 #define TARGET_TUNGETVNETLE       TARGET_IOR('T', 221, int)
@@ -1361,8 +1361,8 @@ struct target_stat64 {
 #define TARGET_STAT64_HAS_BROKEN_ST_INO 1
     abi_ulong       __st_ino;
 
-    unsigned int    st_mode;
-    unsigned int    st_nlink;
+    abi_uint        st_mode;
+    abi_uint        st_nlink;
 
     abi_ulong       st_uid;
     abi_ulong       st_gid;
@@ -1392,20 +1392,20 @@ struct target_stat64 {
 #define TARGET_HAS_STRUCT_STAT64
 struct target_eabi_stat64 {
     unsigned long long st_dev;
-    unsigned int    __pad1;
+    abi_uint     __pad1;
     abi_ulong    __st_ino;
-    unsigned int    st_mode;
-    unsigned int    st_nlink;
+    abi_uint     st_mode;
+    abi_uint     st_nlink;
 
     abi_ulong    st_uid;
     abi_ulong    st_gid;
 
     unsigned long long st_rdev;
-    unsigned int    __pad2[2];
+    abi_uint     __pad2[2];
 
     long long       st_size;
     abi_ulong    st_blksize;
-    unsigned int    __pad3;
+    abi_uint     __pad3;
     unsigned long long st_blocks;
 
     abi_ulong    target_st_atime;
@@ -1423,13 +1423,13 @@ struct target_eabi_stat64 {
 
 #elif defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
 struct target_stat {
-    unsigned int    st_dev;
+    abi_uint        st_dev;
     abi_ulong       st_ino;
-    unsigned int    st_mode;
-    unsigned int    st_nlink;
-    unsigned int    st_uid;
-    unsigned int    st_gid;
-    unsigned int    st_rdev;
+    abi_uint        st_mode;
+    abi_uint        st_nlink;
+    abi_uint        st_uid;
+    abi_uint        st_gid;
+    abi_uint        st_rdev;
     abi_long        st_size;
     abi_long        target_st_atime;
     abi_long        target_st_mtime;
@@ -1447,10 +1447,10 @@ struct target_stat64 {
     abi_ullong      st_ino;
     abi_ullong      st_nlink;
 
-    unsigned int    st_mode;
+    abi_uint        st_mode;
 
-    unsigned int    st_uid;
-    unsigned int    st_gid;
+    abi_uint        st_uid;
+    abi_uint        st_gid;
 
     unsigned char   __pad2[6];
     unsigned short  st_rdev;
@@ -1459,7 +1459,7 @@ struct target_stat64 {
     abi_llong       st_blksize;
 
     unsigned char   __pad4[4];
-    unsigned int    st_blocks;
+    abi_uint        st_blocks;
 
     abi_ulong       target_st_atime;
     abi_ulong       target_st_atime_nsec;
@@ -1503,11 +1503,11 @@ struct target_stat64 {
 
     abi_ullong      st_ino;
 
-    unsigned int    st_mode;
-    unsigned int    st_nlink;
+    abi_uint        st_mode;
+    abi_uint        st_nlink;
 
-    unsigned int    st_uid;
-    unsigned int    st_gid;
+    abi_uint        st_uid;
+    abi_uint        st_gid;
 
     unsigned char   __pad2[6];
     unsigned short  st_rdev;
@@ -1515,22 +1515,22 @@ struct target_stat64 {
     unsigned char   __pad3[8];
 
     abi_llong       st_size;
-    unsigned int    st_blksize;
+    abi_uint        st_blksize;
 
     unsigned char   __pad4[8];
-    unsigned int    st_blocks;
+    abi_uint        st_blocks;
 
-    unsigned int    target_st_atime;
-    unsigned int    target_st_atime_nsec;
+    abi_uint        target_st_atime;
+    abi_uint        target_st_atime_nsec;
 
-    unsigned int    target_st_mtime;
-    unsigned int    target_st_mtime_nsec;
+    abi_uint        target_st_mtime;
+    abi_uint        target_st_mtime_nsec;
 
-    unsigned int    target_st_ctime;
-    unsigned int    target_st_ctime_nsec;
+    abi_uint        target_st_ctime;
+    abi_uint        target_st_ctime_nsec;
 
-    unsigned int    __unused1;
-    unsigned int    __unused2;
+    abi_uint        __unused1;
+    abi_uint        __unused2;
 };
 
 #elif defined(TARGET_PPC)
@@ -1541,13 +1541,13 @@ struct target_stat {
     abi_ulong st_ino;
 #if defined(TARGET_PPC64)
     abi_ulong st_nlink;
-    unsigned int st_mode;
+    abi_uint  st_mode;
 #else
-    unsigned int st_mode;
+    abi_uint  st_mode;
     unsigned short st_nlink;
 #endif
-    unsigned int st_uid;
-    unsigned int st_gid;
+    abi_uint   st_uid;
+    abi_uint   st_gid;
     abi_ulong  st_rdev;
     abi_ulong  st_size;
     abi_ulong  st_blksize;
@@ -1570,24 +1570,24 @@ struct target_stat {
 struct QEMU_PACKED target_stat64 {
     unsigned long long st_dev;
     unsigned long long st_ino;
-    unsigned int st_mode;
-    unsigned int st_nlink;
-    unsigned int st_uid;
-    unsigned int st_gid;
+    abi_uint st_mode;
+    abi_uint st_nlink;
+    abi_uint st_uid;
+    abi_uint st_gid;
     unsigned long long st_rdev;
     unsigned long long __pad0;
     long long      st_size;
     int            st_blksize;
-    unsigned int   __pad1;
+    abi_uint       __pad1;
     long long      st_blocks;       /* Number 512-byte blocks allocated. */
     int            target_st_atime;
-    unsigned int   target_st_atime_nsec;
+    abi_uint       target_st_atime_nsec;
     int            target_st_mtime;
-    unsigned int   target_st_mtime_nsec;
+    abi_uint       target_st_mtime_nsec;
     int            target_st_ctime;
-    unsigned int   target_st_ctime_nsec;
-    unsigned int   __unused4;
-    unsigned int   __unused5;
+    abi_uint       target_st_ctime_nsec;
+    abi_uint       __unused4;
+    abi_uint       __unused5;
 };
 #endif
 
@@ -1597,10 +1597,10 @@ struct QEMU_PACKED target_stat64 {
 struct target_stat {
     abi_ulong st_dev;
     abi_ulong st_ino;
-    unsigned int st_mode;
+    abi_uint st_mode;
     unsigned short st_nlink;
-    unsigned int st_uid;
-    unsigned int st_gid;
+    abi_uint st_uid;
+    abi_uint st_gid;
     abi_ulong  st_rdev;
     abi_ulong  st_size;
     abi_ulong  st_blksize;
@@ -1636,11 +1636,11 @@ struct QEMU_PACKED target_stat64 {
     abi_llong st_blocks;
 
     int            target_st_atime;
-    unsigned int   target_st_atime_nsec;
+    abi_uint   target_st_atime_nsec;
     int            target_st_mtime;
-    unsigned int   target_st_mtime_nsec;
+    abi_uint   target_st_mtime_nsec;
     int            target_st_ctime;
-    unsigned int   target_st_ctime_nsec;
+    abi_uint   target_st_ctime_nsec;
     abi_ullong st_ino;
 };
 
@@ -1680,8 +1680,8 @@ struct target_stat64 {
 #define TARGET_STAT64_HAS_BROKEN_ST_INO 1
     abi_ulong       __st_ino;
 
-    unsigned int    st_mode;
-    unsigned int    st_nlink;
+    abi_uint    st_mode;
+    abi_uint    st_nlink;
 
     abi_ulong       st_uid;
     abi_ulong       st_gid;
@@ -1712,19 +1712,19 @@ struct target_stat64 {
 #define TARGET_STAT_HAVE_NSEC
 /* The memory layout is the same as of struct stat64 of the 32-bit kernel.  */
 struct target_stat {
-    unsigned int            st_dev;
-    unsigned int            st_pad0[3]; /* Reserved for st_dev expansion */
+    abi_uint                st_dev;
+    abi_uint                st_pad0[3]; /* Reserved for st_dev expansion */
 
     abi_ulong               st_ino;
 
-    unsigned int            st_mode;
-    unsigned int            st_nlink;
+    abi_uint                st_mode;
+    abi_uint                st_nlink;
 
     int                     st_uid;
     int                     st_gid;
 
-    unsigned int            st_rdev;
-    unsigned int            st_pad1[3]; /* Reserved for st_rdev expansion */
+    abi_uint                st_rdev;
+    abi_uint                st_pad1[3]; /* Reserved for st_rdev expansion */
 
     abi_ulong               st_size;
 
@@ -1732,17 +1732,17 @@ struct target_stat {
      * Actually this should be timestruc_t st_atime, st_mtime and st_ctime
      * but we don't have it under Linux.
      */
-    unsigned int            target_st_atime;
-    unsigned int            target_st_atime_nsec;
+    abi_uint                target_st_atime;
+    abi_uint                target_st_atime_nsec;
 
-    unsigned int            target_st_mtime;
-    unsigned int            target_st_mtime_nsec;
+    abi_uint                target_st_mtime;
+    abi_uint                target_st_mtime_nsec;
 
-    unsigned int            target_st_ctime;
-    unsigned int            target_st_ctime_nsec;
+    abi_uint                target_st_ctime;
+    abi_uint                target_st_ctime_nsec;
 
-    unsigned int            st_blksize;
-    unsigned int            st_pad2;
+    abi_uint                st_blksize;
+    abi_uint                st_pad2;
 
     abi_ulong               st_blocks;
 };
@@ -1754,8 +1754,8 @@ struct target_stat {
     abi_ulong    st_dev;
     abi_ulong    st_pad0[3]; /* Reserved for st_dev expansion */
     abi_ullong   st_ino;
-    unsigned int st_mode;
-    unsigned int st_nlink;
+    abi_uint     st_mode;
+    abi_uint     st_nlink;
     int          st_uid;
     int          st_gid;
     abi_ulong    st_rdev;
@@ -1779,8 +1779,8 @@ struct target_stat {
     unsigned        st_dev;
     abi_long        st_pad1[3];             /* Reserved for network id */
     abi_ulong       st_ino;
-    unsigned int    st_mode;
-    unsigned int    st_nlink;
+    abi_uint        st_mode;
+    abi_uint        st_nlink;
     int             st_uid;
     int             st_gid;
     unsigned        st_rdev;
@@ -1815,8 +1815,8 @@ struct target_stat64 {
 
     abi_ullong      st_ino;
 
-    unsigned int    st_mode;
-    unsigned int    st_nlink;
+    abi_uint        st_mode;
+    abi_uint        st_nlink;
 
     int             st_uid;
     int             st_gid;
@@ -1848,21 +1848,21 @@ struct target_stat64 {
 #elif defined(TARGET_ALPHA)
 
 struct target_stat {
-    unsigned int    st_dev;
-    unsigned int    st_ino;
-    unsigned int    st_mode;
-    unsigned int    st_nlink;
-    unsigned int    st_uid;
-    unsigned int    st_gid;
-    unsigned int    st_rdev;
+    abi_uint     st_dev;
+    abi_uint     st_ino;
+    abi_uint     st_mode;
+    abi_uint     st_nlink;
+    abi_uint     st_uid;
+    abi_uint     st_gid;
+    abi_uint     st_rdev;
     abi_long     st_size;
     abi_ulong    target_st_atime;
     abi_ulong    target_st_mtime;
     abi_ulong    target_st_ctime;
-    unsigned int    st_blksize;
-    unsigned int    st_blocks;
-    unsigned int    st_flags;
-    unsigned int    st_gen;
+    abi_uint     st_blksize;
+    abi_uint     st_blocks;
+    abi_uint     st_flags;
+    abi_uint     st_gen;
 };
 
 #define TARGET_HAS_STRUCT_STAT64
@@ -1873,12 +1873,12 @@ struct target_stat64 {
     abi_long     st_size;
     abi_ulong    st_blocks;
 
-    unsigned int    st_mode;
-    unsigned int    st_uid;
-    unsigned int    st_gid;
-    unsigned int    st_blksize;
-    unsigned int    st_nlink;
-    unsigned int    __pad0;
+    abi_uint     st_mode;
+    abi_uint     st_uid;
+    abi_uint     st_gid;
+    abi_uint     st_blksize;
+    abi_uint     st_nlink;
+    abi_uint     __pad0;
 
     abi_ulong    target_st_atime;
     abi_ulong    target_st_atime_nsec;
@@ -1924,8 +1924,8 @@ struct QEMU_PACKED target_stat64 {
 #define TARGET_STAT64_HAS_BROKEN_ST_INO 1
     abi_ulong       __st_ino;
 
-    unsigned int    st_mode;
-    unsigned int    st_nlink;
+    abi_uint        st_mode;
+    abi_uint        st_nlink;
 
     abi_ulong       st_uid;
     abi_ulong       st_gid;
@@ -1957,10 +1957,10 @@ struct target_stat {
     abi_ulong       st_ino;
     abi_ulong       st_nlink;
 
-    unsigned int    st_mode;
-    unsigned int    st_uid;
-    unsigned int    st_gid;
-    unsigned int    __pad0;
+    abi_uint        st_mode;
+    abi_uint        st_uid;
+    abi_uint        st_gid;
+    abi_uint        __pad0;
     abi_ulong       st_rdev;
     abi_long        st_size;
     abi_long        st_blksize;
@@ -1980,10 +1980,10 @@ struct target_stat {
     abi_ulong  st_dev;
     abi_ulong  st_ino;
     abi_ulong  st_nlink;
-    unsigned int   st_mode;
-    unsigned int   st_uid;
-    unsigned int   st_gid;
-    unsigned int   __pad1;
+    abi_uint   st_mode;
+    abi_uint   st_uid;
+    abi_uint   st_gid;
+    abi_uint   __pad1;
     abi_ulong  st_rdev;
     abi_ulong  st_size;
     abi_ulong  target_st_atime;
@@ -2001,10 +2001,10 @@ struct target_stat {
 struct target_stat {
     abi_ulong  st_dev;
     abi_ulong  st_ino;
-    unsigned int st_mode;
-    unsigned int st_nlink;
-    unsigned int   st_uid;
-    unsigned int   st_gid;
+    abi_uint   st_mode;
+    abi_uint   st_nlink;
+    abi_uint   st_uid;
+    abi_uint   st_gid;
     abi_ulong  st_rdev;
     abi_ulong  _pad1;
     abi_long  st_size;
@@ -2017,17 +2017,17 @@ struct target_stat {
     abi_ulong  target_st_mtime_nsec;
     abi_long  target_st_ctime;
     abi_ulong  target_st_ctime_nsec;
-    unsigned int __unused[2];
+    abi_uint __unused[2];
 };
 #elif defined(TARGET_XTENSA)
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
     abi_ulong       st_dev;
     abi_ulong       st_ino;
-    unsigned int    st_mode;
-    unsigned int    st_nlink;
-    unsigned int    st_uid;
-    unsigned int    st_gid;
+    abi_uint        st_mode;
+    abi_uint        st_nlink;
+    abi_uint        st_uid;
+    abi_uint        st_gid;
     abi_ulong       st_rdev;
     abi_long        st_size;
     abi_ulong       st_blksize;
@@ -2046,10 +2046,10 @@ struct target_stat {
 struct target_stat64  {
     abi_ullong st_dev;          /* Device */
     abi_ullong st_ino;          /* File serial number */
-    unsigned int  st_mode;      /* File mode. */
-    unsigned int  st_nlink;     /* Link count. */
-    unsigned int  st_uid;       /* User ID of the file's owner. */
-    unsigned int  st_gid;       /* Group ID of the file's group. */
+    abi_uint  st_mode;          /* File mode. */
+    abi_uint  st_nlink;         /* Link count. */
+    abi_uint  st_uid;           /* User ID of the file's owner. */
+    abi_uint  st_gid;           /* Group ID of the file's group. */
     abi_ullong st_rdev;         /* Device number, if device. */
     abi_llong st_size;          /* Size of file, in bytes. */
     abi_ulong st_blksize;       /* Optimal block size for I/O. */
@@ -2074,10 +2074,10 @@ struct target_stat64  {
 struct target_stat {
     abi_ulong st_dev;
     abi_ulong st_ino;
-    unsigned int st_mode;
-    unsigned int st_nlink;
-    unsigned int st_uid;
-    unsigned int st_gid;
+    abi_uint st_mode;
+    abi_uint st_nlink;
+    abi_uint st_uid;
+    abi_uint st_gid;
     abi_ulong st_rdev;
     abi_ulong __pad1;
     abi_long st_size;
@@ -2090,8 +2090,8 @@ struct target_stat {
     abi_ulong target_st_mtime_nsec;
     abi_long target_st_ctime;
     abi_ulong target_st_ctime_nsec;
-    unsigned int __unused4;
-    unsigned int __unused5;
+    abi_uint __unused4;
+    abi_uint __unused5;
 };
 
 #if !defined(TARGET_RISCV64)
@@ -2099,10 +2099,10 @@ struct target_stat {
 struct target_stat64 {
     abi_ullong st_dev;
     abi_ullong st_ino;
-    unsigned int st_mode;
-    unsigned int st_nlink;
-    unsigned int st_uid;
-    unsigned int st_gid;
+    abi_uint st_mode;
+    abi_uint st_nlink;
+    abi_uint st_uid;
+    abi_uint st_gid;
     abi_ullong st_rdev;
     abi_ullong __pad1;
     abi_llong st_size;
@@ -2110,13 +2110,13 @@ struct target_stat64 {
     int __pad2;
     abi_llong st_blocks;
     int target_st_atime;
-    unsigned int target_st_atime_nsec;
+    abi_uint target_st_atime_nsec;
     int target_st_mtime;
-    unsigned int target_st_mtime_nsec;
+    abi_uint target_st_mtime_nsec;
     int target_st_ctime;
-    unsigned int target_st_ctime_nsec;
-    unsigned int __unused4;
-    unsigned int __unused5;
+    abi_uint target_st_ctime_nsec;
+    abi_uint __unused4;
+    abi_uint __unused5;
 };
 #endif
 
@@ -2498,7 +2498,7 @@ struct target_snd_timer_id {
 
 struct target_snd_timer_ginfo {
     struct target_snd_timer_id tid;
-    unsigned int flags;
+    abi_uint flags;
     int card;
     unsigned char id[64];
     unsigned char name[80];
@@ -2506,7 +2506,7 @@ struct target_snd_timer_ginfo {
     abi_ulong resolution;
     abi_ulong resolution_min;
     abi_ulong resolution_max;
-    unsigned int clients;
+    abi_uint clients;
     unsigned char reserved[32];
 };
 
@@ -2531,7 +2531,7 @@ struct target_snd_timer_select {
 };
 
 struct target_snd_timer_info {
-    unsigned int flags;
+    abi_uint flags;
     int card;
     unsigned char id[64];
     unsigned char name[80];
@@ -2542,10 +2542,10 @@ struct target_snd_timer_info {
 
 struct target_snd_timer_status {
     struct target_timespec tstamp;
-    unsigned int resolution;
-    unsigned int lost;
-    unsigned int overrun;
-    unsigned int queue;
+    abi_uint resolution;
+    abi_uint lost;
+    abi_uint overrun;
+    abi_uint queue;
     unsigned char reserved[64];
 };
 
@@ -2623,7 +2623,7 @@ struct target_sysinfo {
     unsigned short pad;             /* explicit padding for m68k */
     abi_ulong totalhigh;            /* Total high memory size */
     abi_ulong freehigh;             /* Available high memory size */
-    unsigned int mem_unit;          /* Memory unit size in bytes */
+    abi_uint mem_unit;              /* Memory unit size in bytes */
     char _f[20-2*sizeof(abi_long)-sizeof(int)]; /* Padding: libc5 uses this.. */
 };
 
-- 
2.34.1


