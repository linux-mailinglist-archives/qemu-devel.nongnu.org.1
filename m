Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B61BF74C70C
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:32:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAV-0008JW-Ox; Sun, 09 Jul 2023 14:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAT-0008J5-T9
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:57 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAR-0000HT-2m
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:57 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31297125334so2802058f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927394; x=1691519394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqaRx6w8s1BHOWt7m2WQSS8nvFGbCNmvKUaaDRikQOU=;
 b=iexbbODY1GjwzOiZi7Zgc5eyX7cbplk4SQwjs16QcqT97C1nhte/Un7a1wPiDAoLy3
 euiXI5mvf4LQVOMVIBF1sil4Lc5hPS3Ugg+g6Q8HrGq0ay5ci6fg50RmyD5SRwG7ndTN
 4gb2fENQphyqlTZIQa+qvY8rgarYzRUpne6Fen9HPge9dbPIpBY4ZuSMR8u0NjUoupvp
 JngJFbyTyQQuYHSObArdfhPG+thOMK5yIJunX9on+flKACj4l/Orm/WGlVUENjy4nUkV
 Rtnrj3kJOkoCVNwpP+Ut4/NHmKMNDGQ/GsbKossXmYDIodNWJRghpY2ZeNOj/AcAifFI
 DArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927394; x=1691519394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qqaRx6w8s1BHOWt7m2WQSS8nvFGbCNmvKUaaDRikQOU=;
 b=J+kibS9Ug44UUbboQNMri7IigmBgXEcZD5g1hqvOpRuyFk2QgTCdHmLDTlf26E5xE5
 cGMlnlHR2m+SsErbv856mBfQ/F2A6Q7BFXT8GcoShFFnZbM0PLVZ5RaWm/yiFPR7KgSY
 Es/FcZ2SGzqLneKphwAGYHqaRsb69LMOGNfsfq/uOgqDcBbzJSXVNlCfT2/qK3+1FX+S
 P/tYdI0vbhm1lRYr1QN9/jAOtXZhTvZYzL8A5ESte1O8iWcRqpZl4/RrJzABijBYLoM0
 mzmvxYIPbiWHTIxf272BP0g4078uCBedNWZQbZ6/ct91o757qSMZcDposXwpSd4owdxV
 b9Jg==
X-Gm-Message-State: ABy/qLbAY/hdiEOfS0KHBDuvKkh0aLYRPkAYQ19Z5z3dns/4SPUEoTID
 uhZSF8mm0wx58D0mabujwI5PDwnmH4FReB2FqXZQnA==
X-Google-Smtp-Source: APBJJlFRhilRQVWGd53SKGDlunDmHB5I1d12O7ZXo0yCk+MZGmmw1d5e7bnV5Vce0q+9HInwNDhtNQ==
X-Received: by 2002:a5d:590f:0:b0:313:ed10:7f52 with SMTP id
 v15-20020a5d590f000000b00313ed107f52mr13066210wrd.18.1688927393678; 
 Sun, 09 Jul 2023 11:29:53 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 10/45] linux-user: Use abi_int not int in syscall_defs.h
Date: Sun,  9 Jul 2023 19:28:32 +0100
Message-Id: <20230709182934.309468-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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
 linux-user/syscall_defs.h | 216 +++++++++++++++++++-------------------
 1 file changed, 108 insertions(+), 108 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index e4fcbd16d2..442a8aefe3 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -361,7 +361,7 @@ struct target_iovec {
 
 struct target_msghdr {
     abi_long     msg_name;       /* Socket name                 */
-    int          msg_namelen;    /* Length of name              */
+    abi_int      msg_namelen;    /* Length of name              */
     abi_long     msg_iov;        /* Data blocks                 */
     abi_long     msg_iovlen;     /* Number of blocks            */
     abi_long     msg_control;    /* Per protocol magic (eg BSD file descriptor passing) */
@@ -371,8 +371,8 @@ struct target_msghdr {
 
 struct target_cmsghdr {
     abi_long     cmsg_len;
-    int          cmsg_level;
-    int          cmsg_type;
+    abi_int      cmsg_level;
+    abi_int      cmsg_type;
 };
 
 #define TARGET_CMSG_DATA(cmsg) ((unsigned char *) ((struct target_cmsghdr *) (cmsg) + 1))
@@ -426,7 +426,7 @@ struct  target_rusage {
 };
 
 typedef struct {
-    int     val[2];
+    abi_int val[2];
 } kernel_fsid_t;
 
 struct target_dirent {
@@ -544,7 +544,7 @@ struct target_sigaction {
 #endif
 
 typedef union target_sigval {
-    int sival_int;
+    abi_int sival_int;
     abi_ulong sival_ptr;
 } target_sigval_t;
 
@@ -575,17 +575,17 @@ typedef union target_sigval {
 
 typedef struct target_siginfo {
 #ifdef TARGET_MIPS
-    int si_signo;
-    int si_code;
-    int si_errno;
+    abi_int si_signo;
+    abi_int si_code;
+    abi_int si_errno;
 #else
-    int si_signo;
-    int si_errno;
-    int si_code;
+    abi_int si_signo;
+    abi_int si_errno;
+    abi_int si_code;
 #endif
 
     union {
-        int _pad[TARGET_SI_PAD_SIZE];
+        abi_int _pad[TARGET_SI_PAD_SIZE];
 
         /* kill() */
         struct {
@@ -610,7 +610,7 @@ typedef struct target_siginfo {
         struct {
             pid_t _pid;             /* which child */
             uid_t _uid;             /* sender's uid */
-            int _status;            /* exit code */
+            abi_int _status;        /* exit code */
             target_clock_t _utime;
             target_clock_t _stime;
         } _sigchld;
@@ -622,8 +622,8 @@ typedef struct target_siginfo {
 
         /* SIGPOLL */
         struct {
-            int _band;      /* POLL_IN, POLL_OUT, POLL_MSG */
-            int _fd;
+            abi_int _band;   /* POLL_IN, POLL_OUT, POLL_MSG */
+            abi_int _fd;
         } _sigpoll;
     } _sifields;
 } target_siginfo_t;
@@ -701,7 +701,7 @@ typedef struct target_siginfo {
 #include "target_resource.h"
 
 struct target_pollfd {
-    int fd;           /* file descriptor */
+    abi_int fd;       /* file descriptor */
     short events;     /* requested events */
     short revents;    /* returned events */
 };
@@ -722,12 +722,12 @@ struct target_pollfd {
 #define TARGET_KDSIGACCEPT     0x4B4E
 
 struct target_rtc_pll_info {
-    int pll_ctrl;
-    int pll_value;
-    int pll_max;
-    int pll_min;
-    int pll_posmult;
-    int pll_negmult;
+    abi_int pll_ctrl;
+    abi_int pll_value;
+    abi_int pll_max;
+    abi_int pll_min;
+    abi_int pll_posmult;
+    abi_int pll_negmult;
     abi_long pll_clock;
 };
 
@@ -754,14 +754,14 @@ struct target_rtc_pll_info {
                                                struct target_rtc_pll_info)
 #define TARGET_RTC_PLL_SET          TARGET_IOW('p', 0x12,               \
                                                struct target_rtc_pll_info)
-#define TARGET_RTC_VL_READ          TARGET_IOR('p', 0x13, int)
+#define TARGET_RTC_VL_READ          TARGET_IOR('p', 0x13, abi_int)
 #define TARGET_RTC_VL_CLR           TARGET_IO('p', 0x14)
 
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) || \
     defined(TARGET_XTENSA)
-#define TARGET_FIOGETOWN       TARGET_IOR('f', 123, int)
-#define TARGET_FIOSETOWN       TARGET_IOW('f', 124, int)
-#define TARGET_SIOCATMARK      TARGET_IOR('s', 7, int)
+#define TARGET_FIOGETOWN       TARGET_IOR('f', 123, abi_int)
+#define TARGET_FIOSETOWN       TARGET_IOW('f', 124, abi_int)
+#define TARGET_SIOCATMARK      TARGET_IOR('s', 7, abi_int)
 #define TARGET_SIOCSPGRP       TARGET_IOW('s', 8, pid_t)
 #define TARGET_SIOCGPGRP       TARGET_IOR('s', 9, pid_t)
 #else
@@ -851,40 +851,40 @@ struct target_rtc_pll_info {
 
 /* From <linux/if_tun.h> */
 
-#define TARGET_TUNSETDEBUG        TARGET_IOW('T', 201, int)
-#define TARGET_TUNSETIFF          TARGET_IOW('T', 202, int)
-#define TARGET_TUNSETPERSIST      TARGET_IOW('T', 203, int)
-#define TARGET_TUNSETOWNER        TARGET_IOW('T', 204, int)
-#define TARGET_TUNSETLINK         TARGET_IOW('T', 205, int)
-#define TARGET_TUNSETGROUP        TARGET_IOW('T', 206, int)
+#define TARGET_TUNSETDEBUG        TARGET_IOW('T', 201, abi_int)
+#define TARGET_TUNSETIFF          TARGET_IOW('T', 202, abi_int)
+#define TARGET_TUNSETPERSIST      TARGET_IOW('T', 203, abi_int)
+#define TARGET_TUNSETOWNER        TARGET_IOW('T', 204, abi_int)
+#define TARGET_TUNSETLINK         TARGET_IOW('T', 205, abi_int)
+#define TARGET_TUNSETGROUP        TARGET_IOW('T', 206, abi_int)
 #define TARGET_TUNGETFEATURES     TARGET_IOR('T', 207, abi_uint)
 #define TARGET_TUNSETOFFLOAD      TARGET_IOW('T', 208, abi_uint)
 #define TARGET_TUNSETTXFILTER     TARGET_IOW('T', 209, abi_uint)
 #define TARGET_TUNGETIFF          TARGET_IOR('T', 210, abi_uint)
-#define TARGET_TUNGETSNDBUF       TARGET_IOR('T', 211, int)
-#define TARGET_TUNSETSNDBUF       TARGET_IOW('T', 212, int)
+#define TARGET_TUNGETSNDBUF       TARGET_IOR('T', 211, abi_int)
+#define TARGET_TUNSETSNDBUF       TARGET_IOW('T', 212, abi_int)
 /*
  * TUNATTACHFILTER and TUNDETACHFILTER are not supported. Linux kernel keeps a
  * user pointer in TUNATTACHFILTER, which we are not able to correctly handle.
  */
-#define TARGET_TUNGETVNETHDRSZ    TARGET_IOR('T', 215, int)
-#define TARGET_TUNSETVNETHDRSZ    TARGET_IOW('T', 216, int)
-#define TARGET_TUNSETQUEUE        TARGET_IOW('T', 217, int)
+#define TARGET_TUNGETVNETHDRSZ    TARGET_IOR('T', 215, abi_int)
+#define TARGET_TUNSETVNETHDRSZ    TARGET_IOW('T', 216, abi_int)
+#define TARGET_TUNSETQUEUE        TARGET_IOW('T', 217, abi_int)
 #define TARGET_TUNSETIFINDEX      TARGET_IOW('T', 218, abi_uint)
 /* TUNGETFILTER is not supported: see TUNATTACHFILTER. */
-#define TARGET_TUNSETVNETLE       TARGET_IOW('T', 220, int)
-#define TARGET_TUNGETVNETLE       TARGET_IOR('T', 221, int)
-#define TARGET_TUNSETVNETBE       TARGET_IOW('T', 222, int)
-#define TARGET_TUNGETVNETBE       TARGET_IOR('T', 223, int)
-#define TARGET_TUNSETSTEERINGEBPF TARGET_IOR('T', 224, int)
-#define TARGET_TUNSETFILTEREBPF   TARGET_IOR('T', 225, int)
-#define TARGET_TUNSETCARRIER      TARGET_IOW('T', 226, int)
+#define TARGET_TUNSETVNETLE       TARGET_IOW('T', 220, abi_int)
+#define TARGET_TUNGETVNETLE       TARGET_IOR('T', 221, abi_int)
+#define TARGET_TUNSETVNETBE       TARGET_IOW('T', 222, abi_int)
+#define TARGET_TUNGETVNETBE       TARGET_IOR('T', 223, abi_int)
+#define TARGET_TUNSETSTEERINGEBPF TARGET_IOR('T', 224, abi_int)
+#define TARGET_TUNSETFILTEREBPF   TARGET_IOR('T', 225, abi_int)
+#define TARGET_TUNSETCARRIER      TARGET_IOW('T', 226, abi_int)
 #define TARGET_TUNGETDEVNETNS     TARGET_IO('T', 227)
 
 /* From <linux/random.h> */
 
-#define TARGET_RNDGETENTCNT    TARGET_IOR('R', 0x00, int)
-#define TARGET_RNDADDTOENTCNT  TARGET_IOW('R', 0x01, int)
+#define TARGET_RNDGETENTCNT    TARGET_IOR('R', 0x00, abi_int)
+#define TARGET_RNDADDTOENTCNT  TARGET_IOW('R', 0x01, abi_int)
 #define TARGET_RNDZAPENTCNT    TARGET_IO('R', 0x04)
 #define TARGET_RNDCLEARPOOL    TARGET_IO('R', 0x06)
 #define TARGET_RNDRESEEDCRNG   TARGET_IO('R', 0x07)
@@ -940,7 +940,7 @@ struct target_rtc_pll_info {
 #define TARGET_FIBMAP     TARGET_IO(0x00,1)  /* bmap access */
 #define TARGET_FIGETBSZ   TARGET_IO(0x00,2)  /* get the block size used for bmap */
 
-#define TARGET_FICLONE    TARGET_IOW(0x94, 9, int)
+#define TARGET_FICLONE    TARGET_IOW(0x94, 9, abi_int)
 #define TARGET_FICLONERANGE TARGET_IOW(0x94, 13, struct file_clone_range)
 
 /*
@@ -952,10 +952,10 @@ struct target_rtc_pll_info {
 #define TARGET_FS_IOC_GETVERSION TARGET_IOR('v', 1, abi_long)
 #define TARGET_FS_IOC_SETVERSION TARGET_IOW('v', 2, abi_long)
 #define TARGET_FS_IOC_FIEMAP TARGET_IOWR('f',11,struct fiemap)
-#define TARGET_FS_IOC32_GETFLAGS TARGET_IOR('f', 1, int)
-#define TARGET_FS_IOC32_SETFLAGS TARGET_IOW('f', 2, int)
-#define TARGET_FS_IOC32_GETVERSION TARGET_IOR('v', 1, int)
-#define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
+#define TARGET_FS_IOC32_GETFLAGS TARGET_IOR('f', 1, abi_int)
+#define TARGET_FS_IOC32_SETFLAGS TARGET_IOW('f', 2, abi_int)
+#define TARGET_FS_IOC32_GETVERSION TARGET_IOR('v', 1, abi_int)
+#define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, abi_int)
 
 /* btrfs ioctls */
 #ifdef HAVE_BTRFS_H
@@ -1577,14 +1577,14 @@ struct QEMU_PACKED target_stat64 {
     abi_ullong st_rdev;
     abi_ullong __pad0;
     abi_llong      st_size;
-    int            st_blksize;
+    abi_int        st_blksize;
     abi_uint       __pad1;
     abi_llong      st_blocks;       /* Number 512-byte blocks allocated. */
-    int            target_st_atime;
+    abi_int        target_st_atime;
     abi_uint       target_st_atime_nsec;
-    int            target_st_mtime;
+    abi_int        target_st_mtime;
     abi_uint       target_st_mtime_nsec;
-    int            target_st_ctime;
+    abi_int        target_st_ctime;
     abi_uint       target_st_ctime_nsec;
     abi_uint       __unused4;
     abi_uint       __unused5;
@@ -1635,11 +1635,11 @@ struct QEMU_PACKED target_stat64 {
     abi_uint __pad2;
     abi_llong st_blocks;
 
-    int            target_st_atime;
+    abi_int    target_st_atime;
     abi_uint   target_st_atime_nsec;
-    int            target_st_mtime;
+    abi_int    target_st_mtime;
     abi_uint   target_st_mtime_nsec;
-    int            target_st_ctime;
+    abi_int    target_st_ctime;
     abi_uint   target_st_ctime_nsec;
     abi_ullong st_ino;
 };
@@ -1720,8 +1720,8 @@ struct target_stat {
     abi_uint                st_mode;
     abi_uint                st_nlink;
 
-    int                     st_uid;
-    int                     st_gid;
+    abi_int                 st_uid;
+    abi_int                 st_gid;
 
     abi_uint                st_rdev;
     abi_uint                st_pad1[3]; /* Reserved for st_rdev expansion */
@@ -1756,8 +1756,8 @@ struct target_stat {
     abi_ullong   st_ino;
     abi_uint     st_mode;
     abi_uint     st_nlink;
-    int          st_uid;
-    int          st_gid;
+    abi_int      st_uid;
+    abi_int      st_gid;
     abi_ulong    st_rdev;
     abi_ulong    st_pad1[3]; /* Reserved for st_rdev expansion */
     abi_llong    st_size;
@@ -1781,8 +1781,8 @@ struct target_stat {
     abi_ulong       st_ino;
     abi_uint        st_mode;
     abi_uint        st_nlink;
-    int             st_uid;
-    int             st_gid;
+    abi_int         st_uid;
+    abi_int         st_gid;
     unsigned        st_rdev;
     abi_long        st_pad2[2];
     abi_long        st_size;
@@ -1818,8 +1818,8 @@ struct target_stat64 {
     abi_uint        st_mode;
     abi_uint        st_nlink;
 
-    int             st_uid;
-    int             st_gid;
+    abi_int         st_uid;
+    abi_int         st_gid;
 
     abi_ulong       st_rdev;
     abi_ulong       st_pad1[3];     /* Reserved for st_rdev expansion  */
@@ -2008,8 +2008,8 @@ struct target_stat {
     abi_ulong  st_rdev;
     abi_ulong  _pad1;
     abi_long  st_size;
-    int        st_blksize;
-    int        __pad2;
+    abi_int    st_blksize;
+    abi_int    __pad2;
     abi_long   st_blocks;
     abi_long  target_st_atime;
     abi_ulong  target_st_atime_nsec;
@@ -2081,8 +2081,8 @@ struct target_stat {
     abi_ulong st_rdev;
     abi_ulong __pad1;
     abi_long st_size;
-    int st_blksize;
-    int __pad2;
+    abi_int st_blksize;
+    abi_int __pad2;
     abi_long st_blocks;
     abi_long target_st_atime;
     abi_ulong target_st_atime_nsec;
@@ -2106,14 +2106,14 @@ struct target_stat64 {
     abi_ullong st_rdev;
     abi_ullong __pad1;
     abi_llong st_size;
-    int st_blksize;
-    int __pad2;
+    abi_int st_blksize;
+    abi_int __pad2;
     abi_llong st_blocks;
-    int target_st_atime;
+    abi_int target_st_atime;
     abi_uint target_st_atime_nsec;
-    int target_st_mtime;
+    abi_int target_st_mtime;
     abi_uint target_st_mtime_nsec;
-    int target_st_ctime;
+    abi_int target_st_ctime;
     abi_uint target_st_ctime_nsec;
     abi_uint __unused4;
     abi_uint __unused5;
@@ -2186,7 +2186,7 @@ struct target_stat64 {
 #endif
 
 typedef struct {
-    int     val[2];
+    abi_int val[2];
 } target_fsid_t;
 
 #ifdef TARGET_MIPS
@@ -2351,7 +2351,7 @@ struct target_statfs64 {
 
 /* soundcard defines */
 /* XXX: convert them all to arch independent entries */
-#define TARGET_SNDCTL_COPR_HALT           TARGET_IOWR('C',  7, int);
+#define TARGET_SNDCTL_COPR_HALT           TARGET_IOWR('C',  7, abi_int);
 #define TARGET_SNDCTL_COPR_LOAD           0xcfb04301
 #define TARGET_SNDCTL_COPR_RCODE          0xc0144303
 #define TARGET_SNDCTL_COPR_RCVMSG         0x8fa44309
@@ -2363,20 +2363,20 @@ struct target_statfs64 {
 #define TARGET_SNDCTL_COPR_WDATA          0x40144304
 #define TARGET_SNDCTL_DSP_RESET           TARGET_IO('P', 0)
 #define TARGET_SNDCTL_DSP_SYNC            TARGET_IO('P', 1)
-#define TARGET_SNDCTL_DSP_SPEED           TARGET_IOWR('P', 2, int)
-#define TARGET_SNDCTL_DSP_STEREO          TARGET_IOWR('P', 3, int)
-#define TARGET_SNDCTL_DSP_GETBLKSIZE      TARGET_IOWR('P', 4, int)
-#define TARGET_SNDCTL_DSP_SETFMT          TARGET_IOWR('P', 5, int)
-#define TARGET_SNDCTL_DSP_CHANNELS        TARGET_IOWR('P', 6, int)
-#define TARGET_SOUND_PCM_WRITE_FILTER     TARGET_IOWR('P', 7, int)
+#define TARGET_SNDCTL_DSP_SPEED           TARGET_IOWR('P', 2, abi_int)
+#define TARGET_SNDCTL_DSP_STEREO          TARGET_IOWR('P', 3, abi_int)
+#define TARGET_SNDCTL_DSP_GETBLKSIZE      TARGET_IOWR('P', 4, abi_int)
+#define TARGET_SNDCTL_DSP_SETFMT          TARGET_IOWR('P', 5, abi_int)
+#define TARGET_SNDCTL_DSP_CHANNELS        TARGET_IOWR('P', 6, abi_int)
+#define TARGET_SOUND_PCM_WRITE_FILTER     TARGET_IOWR('P', 7, abi_int)
 #define TARGET_SNDCTL_DSP_POST            TARGET_IO('P', 8)
-#define TARGET_SNDCTL_DSP_SUBDIVIDE       TARGET_IOWR('P', 9, int)
-#define TARGET_SNDCTL_DSP_SETFRAGMENT     TARGET_IOWR('P',10, int)
-#define TARGET_SNDCTL_DSP_GETFMTS         TARGET_IOR('P', 11, int)
+#define TARGET_SNDCTL_DSP_SUBDIVIDE       TARGET_IOWR('P', 9, abi_int)
+#define TARGET_SNDCTL_DSP_SETFRAGMENT     TARGET_IOWR('P',10, abi_int)
+#define TARGET_SNDCTL_DSP_GETFMTS         TARGET_IOR('P', 11, abi_int)
 #define TARGET_SNDCTL_DSP_GETOSPACE       TARGET_IORU('P',12)
 #define TARGET_SNDCTL_DSP_GETISPACE       TARGET_IORU('P',13)
-#define TARGET_SNDCTL_DSP_GETCAPS         TARGET_IOR('P', 15, int)
-#define TARGET_SNDCTL_DSP_GETTRIGGER      TARGET_IOR('P',16, int)
+#define TARGET_SNDCTL_DSP_GETCAPS         TARGET_IOR('P', 15, abi_int)
+#define TARGET_SNDCTL_DSP_GETTRIGGER      TARGET_IOR('P',16, abi_int)
 #define TARGET_SNDCTL_DSP_GETIPTR         TARGET_IORU('P',17)
 #define TARGET_SNDCTL_DSP_GETOPTR         TARGET_IORU('P',18)
 #define TARGET_SNDCTL_DSP_MAPINBUF        TARGET_IORU('P', 19)
@@ -2424,13 +2424,13 @@ struct target_statfs64 {
 #define TARGET_SOUND_PCM_READ_FILTER      0x80045007
 #define TARGET_SOUND_MIXER_INFO           TARGET_IOR ('M', 101, mixer_info)
 #define TARGET_SOUND_MIXER_ACCESS         0xc0804d66
-#define TARGET_SOUND_MIXER_PRIVATE1       TARGET_IOWR('M', 111, int)
-#define TARGET_SOUND_MIXER_PRIVATE2       TARGET_IOWR('M', 112, int)
-#define TARGET_SOUND_MIXER_PRIVATE3       TARGET_IOWR('M', 113, int)
-#define TARGET_SOUND_MIXER_PRIVATE4       TARGET_IOWR('M', 114, int)
-#define TARGET_SOUND_MIXER_PRIVATE5       TARGET_IOWR('M', 115, int)
+#define TARGET_SOUND_MIXER_PRIVATE1       TARGET_IOWR('M', 111, abi_int)
+#define TARGET_SOUND_MIXER_PRIVATE2       TARGET_IOWR('M', 112, abi_int)
+#define TARGET_SOUND_MIXER_PRIVATE3       TARGET_IOWR('M', 113, abi_int)
+#define TARGET_SOUND_MIXER_PRIVATE4       TARGET_IOWR('M', 114, abi_int)
+#define TARGET_SOUND_MIXER_PRIVATE5       TARGET_IOWR('M', 115, abi_int)
 
-#define TARGET_MIXER_READ(dev)  TARGET_IOR('M', dev, int)
+#define TARGET_MIXER_READ(dev)  TARGET_IOR('M', dev, abi_int)
 
 #define TARGET_SOUND_MIXER_READ_VOLUME          TARGET_MIXER_READ(SOUND_MIXER_VOLUME)
 #define TARGET_SOUND_MIXER_READ_BASS            TARGET_MIXER_READ(SOUND_MIXER_BASS)
@@ -2461,7 +2461,7 @@ struct target_statfs64 {
 #define TARGET_SOUND_MIXER_READ_STEREODEVS      TARGET_MIXER_READ(SOUND_MIXER_STEREODEVS)
 #define TARGET_SOUND_MIXER_READ_CAPS            TARGET_MIXER_READ(SOUND_MIXER_CAPS)
 
-#define TARGET_MIXER_WRITE(dev)         TARGET_IOWR('M', dev, int)
+#define TARGET_MIXER_WRITE(dev)         TARGET_IOWR('M', dev, abi_int)
 
 #define TARGET_SOUND_MIXER_WRITE_VOLUME TARGET_MIXER_WRITE(SOUND_MIXER_VOLUME)
 #define TARGET_SOUND_MIXER_WRITE_BASS           TARGET_MIXER_WRITE(SOUND_MIXER_BASS)
@@ -2489,17 +2489,17 @@ struct target_statfs64 {
 #define TARGET_SOUND_MIXER_WRITE_RECSRC TARGET_MIXER_WRITE(SOUND_MIXER_RECSRC)
 
 struct target_snd_timer_id {
-    int dev_class;
-    int dev_sclass;
-    int card;
-    int device;
-    int subdevice;
+    abi_int dev_class;
+    abi_int dev_sclass;
+    abi_int card;
+    abi_int device;
+    abi_int subdevice;
 };
 
 struct target_snd_timer_ginfo {
     struct target_snd_timer_id tid;
     abi_uint flags;
-    int card;
+    abi_int card;
     unsigned char id[64];
     unsigned char name[80];
     abi_ulong reserved0;
@@ -2532,7 +2532,7 @@ struct target_snd_timer_select {
 
 struct target_snd_timer_info {
     abi_uint flags;
-    int card;
+    abi_int card;
     unsigned char id[64];
     unsigned char name[80];
     abi_ulong reserved0;
@@ -2550,7 +2550,7 @@ struct target_snd_timer_status {
 };
 
 /* alsa timer ioctls */
-#define TARGET_SNDRV_TIMER_IOCTL_PVERSION     TARGET_IOR('T', 0x00, int)
+#define TARGET_SNDRV_TIMER_IOCTL_PVERSION     TARGET_IOR('T', 0x00, abi_int)
 #define TARGET_SNDRV_TIMER_IOCTL_NEXT_DEVICE  TARGET_IOWR('T', 0x01,    \
                                                           struct snd_timer_id)
 #define TARGET_SNDRV_TIMER_IOCTL_GINFO        TARGET_IOWR('T', 0x03,    \
@@ -2650,9 +2650,9 @@ struct target_mq_attr {
 };
 
 struct target_drm_version {
-    int version_major;
-    int version_minor;
-    int version_patchlevel;
+    abi_int version_major;
+    abi_int version_minor;
+    abi_int version_patchlevel;
     abi_ulong name_len;
     abi_ulong name;
     abi_ulong date_len;
@@ -2662,7 +2662,7 @@ struct target_drm_version {
 };
 
 struct target_drm_i915_getparam {
-    int param;
+    abi_int param;
     abi_ulong value;
 };
 
@@ -2755,7 +2755,7 @@ struct target_sigevent {
 
 struct target_user_cap_header {
     abi_uint version;
-    int pid;
+    abi_int  pid;
 };
 
 struct target_user_cap_data {
-- 
2.34.1


