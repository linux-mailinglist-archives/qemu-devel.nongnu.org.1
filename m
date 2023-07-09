Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBBF74C71E
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:34:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAU-0008JG-W9; Sun, 09 Jul 2023 14:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAI-0008Do-Jk
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:46 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAC-0000DJ-VQ
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:46 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc59de009so39378525e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927378; x=1691519378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ucetWZKQxGf1H8/69kqF4wjbJkZDEr6t/e7SdhPKj/g=;
 b=C7rr5EnAaWgxrze5ZPQlS5ZLowlNAxvHmj5woL6en605SXdg4EDj3SIizqLzLu0UGs
 hueIN3Sy47jb8Ay5MT3yt/SSaNzJc8mdmHvvSnejnmlO8wHY1pQ8tszREFyDKcptojoJ
 z7Z5+YTNkbbI8yHsuIBUIbg1kSOk33seqxVnJX27YjTIrV5a+lWDJ65aJYkX1GKcisbS
 8hoKQJpeuDuFU9evdbvCAm4ikrF0mvwN/B6RcV/z55N4+1Dsn0sYY2wOzFqMP+BjM7MR
 HDmvQQ0CL4SUGCIVE5W603mekHH+l8RTh2/RkcL/+BEWu550FbYjxx3gWEvG9RtMf0S8
 ISNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927378; x=1691519378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucetWZKQxGf1H8/69kqF4wjbJkZDEr6t/e7SdhPKj/g=;
 b=NvbpCUtkni+DrsZIuMqjP+oOZVFSk6Vn5Ez+LWwf42rDmEtknjywvmaXWo9cDKwDib
 SwMorGSwsjw/BoTc+2DyuJVJ9O50rbEy7dgnqstWDA2PQXUNUgd/7g6hQdfxrJ+W4368
 5JYwlUiyA99XWBdGUEVVyb1iWOtGCguJLGHwK/NBnOTd9IBALQSDb3vTOVi2jih5xI9a
 z3MWgdLQB+l0zcblyI88UCiUgoM3PDSd1aN5tflowqGTELu+D/V5FFXQMLRQCcZzTFMz
 0+nwvtj7nsEBOMOtmMR5c4o7aQz3sm2c32YQtkS+XSpF3hzcy+wpnvdBw3FkSGcU1LLt
 W8eA==
X-Gm-Message-State: ABy/qLYmtxzGSoePsAG8WivBWhKu3HL2XNjuGck3CuOVw/iWZvUijJR/
 fjnX7y/UIZgGIXKKrbyRSB8rTnP8l342ylrid0m9mA==
X-Google-Smtp-Source: APBJJlEYdZyOrXtWSo0QByC7Rx1gH4cbBk2iUFGP34Mt32qNfFUFnMjbkfWW6wPvEDniPL3CWaE1Ng==
X-Received: by 2002:a7b:c04b:0:b0:3fb:f926:4937 with SMTP id
 u11-20020a7bc04b000000b003fbf9264937mr7665690wmc.31.1688927377342; 
 Sun, 09 Jul 2023 11:29:37 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/45] linux-user: Reformat syscall_defs.h
Date: Sun,  9 Jul 2023 19:28:13 +0100
Message-Id: <20230709182934.309468-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

Untabify and re-indent.
We had a mix of 2, 3, 4, and 8 space indentation.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall_defs.h | 1948 ++++++++++++++++++-------------------
 1 file changed, 974 insertions(+), 974 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index cc37054cb5..e80d54780b 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -33,18 +33,18 @@
 #define TARGET_SYS_SENDMMSG     20        /* sendmmsg()            */
 
 #define IPCOP_CALL(VERSION, OP) ((VERSION) << 16 | (OP))
-#define IPCOP_semop		1
-#define IPCOP_semget		2
-#define IPCOP_semctl		3
-#define IPCOP_semtimedop	4
-#define IPCOP_msgsnd		11
-#define IPCOP_msgrcv		12
-#define IPCOP_msgget		13
-#define IPCOP_msgctl		14
-#define IPCOP_shmat		21
-#define IPCOP_shmdt		22
-#define IPCOP_shmget		23
-#define IPCOP_shmctl		24
+#define IPCOP_semop             1
+#define IPCOP_semget            2
+#define IPCOP_semctl            3
+#define IPCOP_semtimedop        4
+#define IPCOP_msgsnd            11
+#define IPCOP_msgrcv            12
+#define IPCOP_msgget            13
+#define IPCOP_msgctl            14
+#define IPCOP_shmat             21
+#define IPCOP_shmdt             22
+#define IPCOP_shmget            23
+#define IPCOP_shmctl            24
 
 #define TARGET_SEMOPM     500
 
@@ -56,42 +56,42 @@
  * this explicit here.  Please be sure to use the decoding macros
  * below from now on.
  */
-#define TARGET_IOC_NRBITS	8
-#define TARGET_IOC_TYPEBITS	8
+#define TARGET_IOC_NRBITS       8
+#define TARGET_IOC_TYPEBITS     8
 
-#if (defined(TARGET_I386) && defined(TARGET_ABI32)) \
-    || (defined(TARGET_ARM) && defined(TARGET_ABI32)) \
-    || (defined(TARGET_SPARC) && defined(TARGET_ABI32)) \
+#if (defined(TARGET_I386) && defined(TARGET_ABI32))                     \
+    || (defined(TARGET_ARM) && defined(TARGET_ABI32))                   \
+    || (defined(TARGET_SPARC) && defined(TARGET_ABI32))                 \
     || defined(TARGET_M68K) || defined(TARGET_SH4) || defined(TARGET_CRIS)
-    /* 16 bit uid wrappers emulation */
+/* 16 bit uid wrappers emulation */
 #define USE_UID16
 #define target_id uint16_t
 #else
 #define target_id uint32_t
 #endif
 
-#if defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_SH4) \
-    || defined(TARGET_M68K) || defined(TARGET_CRIS) \
-    || defined(TARGET_S390X) || defined(TARGET_OPENRISC) \
-    || defined(TARGET_NIOS2) || defined(TARGET_RISCV) \
+#if defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_SH4)  \
+    || defined(TARGET_M68K) || defined(TARGET_CRIS)                     \
+    || defined(TARGET_S390X) || defined(TARGET_OPENRISC)                \
+    || defined(TARGET_NIOS2) || defined(TARGET_RISCV)                   \
     || defined(TARGET_XTENSA) || defined(TARGET_LOONGARCH64)
 
-#define TARGET_IOC_SIZEBITS	14
-#define TARGET_IOC_DIRBITS	2
+#define TARGET_IOC_SIZEBITS     14
+#define TARGET_IOC_DIRBITS      2
 
-#define TARGET_IOC_NONE	  0U
+#define TARGET_IOC_NONE   0U
 #define TARGET_IOC_WRITE  1U
-#define TARGET_IOC_READ	  2U
+#define TARGET_IOC_READ   2U
 
-#elif defined(TARGET_PPC) || defined(TARGET_ALPHA) || \
-      defined(TARGET_SPARC) || defined(TARGET_MICROBLAZE) || \
-      defined(TARGET_MIPS)
+#elif defined(TARGET_PPC) || defined(TARGET_ALPHA) ||           \
+    defined(TARGET_SPARC) || defined(TARGET_MICROBLAZE) ||      \
+    defined(TARGET_MIPS)
 
-#define TARGET_IOC_SIZEBITS	13
-#define TARGET_IOC_DIRBITS	3
+#define TARGET_IOC_SIZEBITS     13
+#define TARGET_IOC_DIRBITS      3
 
-#define TARGET_IOC_NONE	  1U
-#define TARGET_IOC_READ	  2U
+#define TARGET_IOC_NONE   1U
+#define TARGET_IOC_READ   2U
 #define TARGET_IOC_WRITE  4U
 
 #elif defined(TARGET_HPPA)
@@ -115,32 +115,32 @@
 #error unsupported CPU
 #endif
 
-#define TARGET_IOC_NRMASK	((1 << TARGET_IOC_NRBITS)-1)
-#define TARGET_IOC_TYPEMASK	((1 << TARGET_IOC_TYPEBITS)-1)
-#define TARGET_IOC_SIZEMASK	((1 << TARGET_IOC_SIZEBITS)-1)
-#define TARGET_IOC_DIRMASK	((1 << TARGET_IOC_DIRBITS)-1)
+#define TARGET_IOC_NRMASK       ((1 << TARGET_IOC_NRBITS)-1)
+#define TARGET_IOC_TYPEMASK     ((1 << TARGET_IOC_TYPEBITS)-1)
+#define TARGET_IOC_SIZEMASK     ((1 << TARGET_IOC_SIZEBITS)-1)
+#define TARGET_IOC_DIRMASK      ((1 << TARGET_IOC_DIRBITS)-1)
 
-#define TARGET_IOC_NRSHIFT	0
-#define TARGET_IOC_TYPESHIFT	(TARGET_IOC_NRSHIFT+TARGET_IOC_NRBITS)
-#define TARGET_IOC_SIZESHIFT	(TARGET_IOC_TYPESHIFT+TARGET_IOC_TYPEBITS)
-#define TARGET_IOC_DIRSHIFT	(TARGET_IOC_SIZESHIFT+TARGET_IOC_SIZEBITS)
+#define TARGET_IOC_NRSHIFT      0
+#define TARGET_IOC_TYPESHIFT    (TARGET_IOC_NRSHIFT+TARGET_IOC_NRBITS)
+#define TARGET_IOC_SIZESHIFT    (TARGET_IOC_TYPESHIFT+TARGET_IOC_TYPEBITS)
+#define TARGET_IOC_DIRSHIFT     (TARGET_IOC_SIZESHIFT+TARGET_IOC_SIZEBITS)
 
-#define TARGET_IOC(dir,type,nr,size) \
-	(((dir)  << TARGET_IOC_DIRSHIFT) | \
-	 ((type) << TARGET_IOC_TYPESHIFT) | \
-	 ((nr)   << TARGET_IOC_NRSHIFT) | \
-	 ((size) << TARGET_IOC_SIZESHIFT))
+#define TARGET_IOC(dir,type,nr,size)            \
+    (((dir)  << TARGET_IOC_DIRSHIFT) |          \
+     ((type) << TARGET_IOC_TYPESHIFT) |         \
+     ((nr)   << TARGET_IOC_NRSHIFT) |           \
+     ((size) << TARGET_IOC_SIZESHIFT))
 
 /* used to create numbers */
-#define TARGET_IO(type,nr)		TARGET_IOC(TARGET_IOC_NONE,(type),(nr),0)
-#define TARGET_IOR(type,nr,size)	TARGET_IOC(TARGET_IOC_READ,(type),(nr),sizeof(size))
-#define TARGET_IOW(type,nr,size)	TARGET_IOC(TARGET_IOC_WRITE,(type),(nr),sizeof(size))
-#define TARGET_IOWR(type,nr,size)	TARGET_IOC(TARGET_IOC_READ|TARGET_IOC_WRITE,(type),(nr),sizeof(size))
+#define TARGET_IO(type,nr)              TARGET_IOC(TARGET_IOC_NONE,(type),(nr),0)
+#define TARGET_IOR(type,nr,size)        TARGET_IOC(TARGET_IOC_READ,(type),(nr),sizeof(size))
+#define TARGET_IOW(type,nr,size)        TARGET_IOC(TARGET_IOC_WRITE,(type),(nr),sizeof(size))
+#define TARGET_IOWR(type,nr,size)       TARGET_IOC(TARGET_IOC_READ|TARGET_IOC_WRITE,(type),(nr),sizeof(size))
 
 /* the size is automatically computed for these defines */
-#define TARGET_IORU(type,nr)	TARGET_IOC(TARGET_IOC_READ,(type),(nr),TARGET_IOC_SIZEMASK)
-#define TARGET_IOWU(type,nr)	TARGET_IOC(TARGET_IOC_WRITE,(type),(nr),TARGET_IOC_SIZEMASK)
-#define TARGET_IOWRU(type,nr)	TARGET_IOC(TARGET_IOC_READ|TARGET_IOC_WRITE,(type),(nr),TARGET_IOC_SIZEMASK)
+#define TARGET_IORU(type,nr)    TARGET_IOC(TARGET_IOC_READ,(type),(nr),TARGET_IOC_SIZEMASK)
+#define TARGET_IOWU(type,nr)    TARGET_IOC(TARGET_IOC_WRITE,(type),(nr),TARGET_IOC_SIZEMASK)
+#define TARGET_IOWRU(type,nr)   TARGET_IOC(TARGET_IOC_READ|TARGET_IOC_WRITE,(type),(nr),TARGET_IOC_SIZEMASK)
 
 struct target_sockaddr {
     abi_ushort sa_family;
@@ -174,12 +174,12 @@ struct target_in_addr {
 };
 
 struct target_sockaddr_in {
-  abi_ushort sin_family;
-  abi_short sin_port; /* big endian */
-  struct target_in_addr sin_addr;
-  uint8_t __pad[sizeof(struct target_sockaddr) -
-                sizeof(abi_ushort) - sizeof(abi_short) -
-                sizeof(struct target_in_addr)];
+    abi_ushort sin_family;
+    abi_short sin_port; /* big endian */
+    struct target_in_addr sin_addr;
+    uint8_t __pad[sizeof(struct target_sockaddr) -
+                  sizeof(abi_ushort) - sizeof(abi_short) -
+                  sizeof(struct target_in_addr)];
 };
 
 struct target_sockaddr_in6 {
@@ -360,12 +360,12 @@ struct target_iovec {
 };
 
 struct target_msghdr {
-    abi_long	 msg_name;	 /* Socket name			*/
-    int		 msg_namelen;	 /* Length of name		*/
-    abi_long	 msg_iov;	 /* Data blocks			*/
-    abi_long	 msg_iovlen;	 /* Number of blocks		*/
-    abi_long     msg_control;	 /* Per protocol magic (eg BSD file descriptor passing) */
-    abi_long	 msg_controllen; /* Length of cmsg list */
+    abi_long     msg_name;       /* Socket name                 */
+    int          msg_namelen;    /* Length of name              */
+    abi_long     msg_iov;        /* Data blocks                 */
+    abi_long     msg_iovlen;     /* Number of blocks            */
+    abi_long     msg_control;    /* Per protocol magic (eg BSD file descriptor passing) */
+    abi_long     msg_controllen; /* Length of cmsg list */
     unsigned int msg_flags;
 };
 
@@ -376,10 +376,10 @@ struct target_cmsghdr {
 };
 
 #define TARGET_CMSG_DATA(cmsg) ((unsigned char *) ((struct target_cmsghdr *) (cmsg) + 1))
-#define TARGET_CMSG_NXTHDR(mhdr, cmsg, cmsg_start) \
-                               __target_cmsg_nxthdr(mhdr, cmsg, cmsg_start)
-#define TARGET_CMSG_ALIGN(len) (((len) + sizeof (abi_long) - 1) \
-                               & (size_t) ~(sizeof (abi_long) - 1))
+#define TARGET_CMSG_NXTHDR(mhdr, cmsg, cmsg_start)      \
+    __target_cmsg_nxthdr(mhdr, cmsg, cmsg_start)
+#define TARGET_CMSG_ALIGN(len) (((len) + sizeof (abi_long) - 1)         \
+                                & (size_t) ~(sizeof (abi_long) - 1))
 #define TARGET_CMSG_SPACE(len) (sizeof(struct target_cmsghdr) + \
                                 TARGET_CMSG_ALIGN(len))
 #define TARGET_CMSG_LEN(len) (sizeof(struct target_cmsghdr) + (len))
@@ -389,16 +389,16 @@ __target_cmsg_nxthdr(struct target_msghdr *__mhdr,
                      struct target_cmsghdr *__cmsg,
                      struct target_cmsghdr *__cmsg_start)
 {
-  struct target_cmsghdr *__ptr;
+    struct target_cmsghdr *__ptr;
 
-  __ptr = (struct target_cmsghdr *)((unsigned char *) __cmsg
-                                    + TARGET_CMSG_ALIGN (tswapal(__cmsg->cmsg_len)));
-  if ((unsigned long)((char *)(__ptr+1) - (char *)__cmsg_start)
-      > tswapal(__mhdr->msg_controllen)) {
-    /* No more entries.  */
-    return (struct target_cmsghdr *)0;
-  }
-  return __ptr;
+    __ptr = (struct target_cmsghdr *)((unsigned char *) __cmsg
+                                      + TARGET_CMSG_ALIGN (tswapal(__cmsg->cmsg_len)));
+    if ((unsigned long)((char *)(__ptr+1) - (char *)__cmsg_start)
+        > tswapal(__mhdr->msg_controllen)) {
+        /* No more entries.  */
+        return (struct target_cmsghdr *)0;
+    }
+    return __ptr;
 }
 
 struct target_mmsghdr {
@@ -407,55 +407,55 @@ struct target_mmsghdr {
 };
 
 struct  target_rusage {
-        struct target_timeval ru_utime;        /* user time used */
-        struct target_timeval ru_stime;        /* system time used */
-        abi_long    ru_maxrss;                 /* maximum resident set size */
-        abi_long    ru_ixrss;                  /* integral shared memory size */
-        abi_long    ru_idrss;                  /* integral unshared data size */
-        abi_long    ru_isrss;                  /* integral unshared stack size */
-        abi_long    ru_minflt;                 /* page reclaims */
-        abi_long    ru_majflt;                 /* page faults */
-        abi_long    ru_nswap;                  /* swaps */
-        abi_long    ru_inblock;                /* block input operations */
-        abi_long    ru_oublock;                /* block output operations */
-        abi_long    ru_msgsnd;                 /* messages sent */
-        abi_long    ru_msgrcv;                 /* messages received */
-        abi_long    ru_nsignals;               /* signals received */
-        abi_long    ru_nvcsw;                  /* voluntary context switches */
-        abi_long    ru_nivcsw;                 /* involuntary " */
+    struct target_timeval ru_utime;        /* user time used */
+    struct target_timeval ru_stime;        /* system time used */
+    abi_long    ru_maxrss;                 /* maximum resident set size */
+    abi_long    ru_ixrss;                  /* integral shared memory size */
+    abi_long    ru_idrss;                  /* integral unshared data size */
+    abi_long    ru_isrss;                  /* integral unshared stack size */
+    abi_long    ru_minflt;                 /* page reclaims */
+    abi_long    ru_majflt;                 /* page faults */
+    abi_long    ru_nswap;                  /* swaps */
+    abi_long    ru_inblock;                /* block input operations */
+    abi_long    ru_oublock;                /* block output operations */
+    abi_long    ru_msgsnd;                 /* messages sent */
+    abi_long    ru_msgrcv;                 /* messages received */
+    abi_long    ru_nsignals;               /* signals received */
+    abi_long    ru_nvcsw;                  /* voluntary context switches */
+    abi_long    ru_nivcsw;                 /* involuntary " */
 };
 
 typedef struct {
-        int     val[2];
+    int     val[2];
 } kernel_fsid_t;
 
 struct target_dirent {
-        abi_long        d_ino;
-        abi_long        d_off;
-        unsigned short  d_reclen;
-        char            d_name[];
+    abi_long        d_ino;
+    abi_long        d_off;
+    unsigned short  d_reclen;
+    char            d_name[];
 };
 
 struct target_dirent64 {
-	abi_ullong      d_ino;
-	abi_llong       d_off;
-	abi_ushort      d_reclen;
-	unsigned char	d_type;
-	char		d_name[];
+    abi_ullong      d_ino;
+    abi_llong       d_off;
+    abi_ushort      d_reclen;
+    unsigned char   d_type;
+    char            d_name[];
 };
 
 
 /* mostly generic signal stuff */
-#define TARGET_SIG_DFL	((abi_long)0)	/* default signal handling */
-#define TARGET_SIG_IGN	((abi_long)1)	/* ignore signal */
-#define TARGET_SIG_ERR	((abi_long)-1)	/* error return from signal */
+#define TARGET_SIG_DFL  ((abi_long)0)   /* default signal handling */
+#define TARGET_SIG_IGN  ((abi_long)1)   /* ignore signal */
+#define TARGET_SIG_ERR  ((abi_long)-1)  /* error return from signal */
 
 #ifdef TARGET_MIPS
-#define TARGET_NSIG	   128
+#define TARGET_NSIG        128
 #else
-#define TARGET_NSIG	   64
+#define TARGET_NSIG        64
 #endif
-#define TARGET_NSIG_BPW	   TARGET_ABI_BITS
+#define TARGET_NSIG_BPW    TARGET_ABI_BITS
 #define TARGET_NSIG_WORDS  (TARGET_NSIG / TARGET_NSIG_BPW)
 
 typedef struct {
@@ -508,71 +508,71 @@ typedef abi_ulong target_old_sa_flags;
 
 #if defined(TARGET_MIPS)
 struct target_sigaction {
-	uint32_t	sa_flags;
+    uint32_t        sa_flags;
 #if defined(TARGET_ABI_MIPSN32)
-	uint32_t	_sa_handler;
+    uint32_t        _sa_handler;
 #else
-	abi_ulong	_sa_handler;
+    abi_ulong       _sa_handler;
 #endif
-	target_sigset_t	sa_mask;
+    target_sigset_t sa_mask;
 #ifdef TARGET_ARCH_HAS_SA_RESTORER
-        /* ??? This is always present, but ignored unless O32.  */
-        abi_ulong sa_restorer;
+    /* ??? This is always present, but ignored unless O32.  */
+    abi_ulong sa_restorer;
 #endif
 };
 #else
 struct target_old_sigaction {
-        abi_ulong _sa_handler;
-        abi_ulong sa_mask;
-        target_old_sa_flags sa_flags;
+    abi_ulong _sa_handler;
+    abi_ulong sa_mask;
+    target_old_sa_flags sa_flags;
 #ifdef TARGET_ARCH_HAS_SA_RESTORER
-        abi_ulong sa_restorer;
+    abi_ulong sa_restorer;
 #endif
 };
 
 struct target_sigaction {
-        abi_ulong _sa_handler;
-        abi_ulong sa_flags;
+    abi_ulong _sa_handler;
+    abi_ulong sa_flags;
 #ifdef TARGET_ARCH_HAS_SA_RESTORER
-        abi_ulong sa_restorer;
+    abi_ulong sa_restorer;
 #endif
-        target_sigset_t sa_mask;
+    target_sigset_t sa_mask;
 #ifdef TARGET_ARCH_HAS_KA_RESTORER
-        abi_ulong ka_restorer;
+    abi_ulong ka_restorer;
 #endif
 };
 #endif
 
 typedef union target_sigval {
-	int sival_int;
-        abi_ulong sival_ptr;
+    int sival_int;
+    abi_ulong sival_ptr;
 } target_sigval_t;
 #if 0
 #if defined (TARGET_SPARC)
 typedef struct {
-	struct {
-		abi_ulong psr;
-		abi_ulong pc;
-		abi_ulong npc;
-		abi_ulong y;
-		abi_ulong u_regs[16]; /* globals and ins */
-	}		si_regs;
-	int		si_mask;
+    struct {
+        abi_ulong psr;
+        abi_ulong pc;
+        abi_ulong npc;
+        abi_ulong y;
+        abi_ulong u_regs[16]; /* globals and ins */
+    }               si_regs;
+    int             si_mask;
 } __siginfo_t;
 
 typedef struct {
-	unsigned   long si_float_regs [32];
-	unsigned   long si_fsr;
-	unsigned   long si_fpqdepth;
-	struct {
-		unsigned long *insn_addr;
-		unsigned long insn;
-	} si_fpqueue [16];
+    unsigned   long si_float_regs [32];
+    unsigned   long si_fsr;
+    unsigned   long si_fpqdepth;
+    struct {
+        unsigned long *insn_addr;
+        unsigned long insn;
+    } si_fpqueue [16];
 } __siginfo_fpu_t;
 #endif
 #endif
 
-#define TARGET_SI_MAX_SIZE	128
+#define TARGET_SI_MAX_SIZE      128
 
 #if TARGET_ABI_BITS == 32
 #define TARGET_SI_PREAMBLE_SIZE (3 * sizeof(int))
@@ -599,82 +599,82 @@ typedef struct {
 
 typedef struct target_siginfo {
 #ifdef TARGET_MIPS
-	int si_signo;
-	int si_code;
-	int si_errno;
+    int si_signo;
+    int si_code;
+    int si_errno;
 #else
-	int si_signo;
-	int si_errno;
-	int si_code;
+    int si_signo;
+    int si_errno;
+    int si_code;
 #endif
 
-	union {
-		int _pad[TARGET_SI_PAD_SIZE];
+    union {
+        int _pad[TARGET_SI_PAD_SIZE];
 
-		/* kill() */
-		struct {
-			pid_t _pid;		/* sender's pid */
-			uid_t _uid;		/* sender's uid */
-		} _kill;
+        /* kill() */
+        struct {
+            pid_t _pid;             /* sender's pid */
+            uid_t _uid;             /* sender's uid */
+        } _kill;
 
-		/* POSIX.1b timers */
-		struct {
-			unsigned int _timer1;
-			unsigned int _timer2;
-		} _timer;
+        /* POSIX.1b timers */
+        struct {
+            unsigned int _timer1;
+            unsigned int _timer2;
+        } _timer;
 
-		/* POSIX.1b signals */
-		struct {
-			pid_t _pid;		/* sender's pid */
-			uid_t _uid;		/* sender's uid */
-			target_sigval_t _sigval;
-		} _rt;
+        /* POSIX.1b signals */
+        struct {
+            pid_t _pid;             /* sender's pid */
+            uid_t _uid;             /* sender's uid */
+            target_sigval_t _sigval;
+        } _rt;
 
-		/* SIGCHLD */
-		struct {
-			pid_t _pid;		/* which child */
-			uid_t _uid;		/* sender's uid */
-			int _status;		/* exit code */
-			target_clock_t _utime;
-                        target_clock_t _stime;
-		} _sigchld;
+        /* SIGCHLD */
+        struct {
+            pid_t _pid;             /* which child */
+            uid_t _uid;             /* sender's uid */
+            int _status;            /* exit code */
+            target_clock_t _utime;
+            target_clock_t _stime;
+        } _sigchld;
 
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-		struct {
-			abi_ulong _addr; /* faulting insn/memory ref. */
-		} _sigfault;
+        /* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
+        struct {
+            abi_ulong _addr; /* faulting insn/memory ref. */
+        } _sigfault;
 
-		/* SIGPOLL */
-		struct {
-			int _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-	} _sifields;
+        /* SIGPOLL */
+        struct {
+            int _band;      /* POLL_IN, POLL_OUT, POLL_MSG */
+            int _fd;
+        } _sigpoll;
+    } _sifields;
 } target_siginfo_t;
 
 /*
  * si_code values
  * Digital reserves positive values for kernel-generated signals.
  */
-#define TARGET_SI_USER		0	/* sent by kill, sigsend, raise */
-#define TARGET_SI_KERNEL	0x80	/* sent by the kernel from somewhere */
-#define TARGET_SI_QUEUE	-1		/* sent by sigqueue */
+#define TARGET_SI_USER          0       /* sent by kill, sigsend, raise */
+#define TARGET_SI_KERNEL        0x80    /* sent by the kernel from somewhere */
+#define TARGET_SI_QUEUE -1              /* sent by sigqueue */
 #define TARGET_SI_TIMER -2              /* sent by timer expiration */
-#define TARGET_SI_MESGQ	-3		/* sent by real time mesq state change */
-#define TARGET_SI_ASYNCIO	-4	/* sent by AIO completion */
-#define TARGET_SI_SIGIO	-5		/* sent by queued SIGIO */
+#define TARGET_SI_MESGQ -3              /* sent by real time mesq state change */
+#define TARGET_SI_ASYNCIO       -4      /* sent by AIO completion */
+#define TARGET_SI_SIGIO -5              /* sent by queued SIGIO */
 
 /*
  * SIGILL si_codes
  */
-#define TARGET_ILL_ILLOPC	(1)	/* illegal opcode */
-#define TARGET_ILL_ILLOPN	(2)	/* illegal operand */
-#define TARGET_ILL_ILLADR	(3)	/* illegal addressing mode */
-#define TARGET_ILL_ILLTRP	(4)	/* illegal trap */
-#define TARGET_ILL_PRVOPC	(5)	/* privileged opcode */
-#define TARGET_ILL_PRVREG	(6)	/* privileged register */
-#define TARGET_ILL_COPROC	(7)	/* coprocessor error */
-#define TARGET_ILL_BADSTK	(8)	/* internal stack error */
+#define TARGET_ILL_ILLOPC       (1)     /* illegal opcode */
+#define TARGET_ILL_ILLOPN       (2)     /* illegal operand */
+#define TARGET_ILL_ILLADR       (3)     /* illegal addressing mode */
+#define TARGET_ILL_ILLTRP       (4)     /* illegal trap */
+#define TARGET_ILL_PRVOPC       (5)     /* privileged opcode */
+#define TARGET_ILL_PRVREG       (6)     /* privileged register */
+#define TARGET_ILL_COPROC       (7)     /* coprocessor error */
+#define TARGET_ILL_BADSTK       (8)     /* internal stack error */
 
 /*
  * SIGFPE si_codes
@@ -700,9 +700,9 @@ typedef struct target_siginfo {
 /*
  * SIGBUS si_codes
  */
-#define TARGET_BUS_ADRALN       (1)	/* invalid address alignment */
-#define TARGET_BUS_ADRERR       (2)	/* non-existent physical address */
-#define TARGET_BUS_OBJERR       (3)	/* object specific hardware error */
+#define TARGET_BUS_ADRALN       (1)     /* invalid address alignment */
+#define TARGET_BUS_ADRERR       (2)     /* non-existent physical address */
+#define TARGET_BUS_OBJERR       (3)     /* object specific hardware error */
 /* hardware memory error consumed on a machine check: action required */
 #define TARGET_BUS_MCEERR_AR    (4)
 /* hardware memory error detected in process but not consumed: action optional*/
@@ -711,8 +711,8 @@ typedef struct target_siginfo {
 /*
  * SIGTRAP si_codes
  */
-#define TARGET_TRAP_BRKPT	(1)	/* process breakpoint */
-#define TARGET_TRAP_TRACE	(2)	/* process trace trap */
+#define TARGET_TRAP_BRKPT       (1)     /* process breakpoint */
+#define TARGET_TRAP_TRACE       (2)     /* process trace trap */
 #define TARGET_TRAP_BRANCH      (3)     /* process taken branch trap */
 #define TARGET_TRAP_HWBKPT      (4)     /* hardware breakpoint/watchpoint */
 #define TARGET_TRAP_UNK         (5)     /* undiagnosed trap */
@@ -731,18 +731,18 @@ struct target_pollfd {
 };
 
 /* virtual terminal ioctls */
-#define TARGET_KIOCSOUND       0x4B2F	/* start sound generation (0 for off) */
-#define TARGET_KDMKTONE	       0x4B30	/* generate tone */
+#define TARGET_KIOCSOUND       0x4B2F   /* start sound generation (0 for off) */
+#define TARGET_KDMKTONE        0x4B30   /* generate tone */
 #define TARGET_KDGKBTYPE       0x4b33
 #define TARGET_KDSETMODE       0x4b3a
 #define TARGET_KDGKBMODE       0x4b44
 #define TARGET_KDSKBMODE       0x4b45
-#define TARGET_KDGKBENT	       0x4B46	/* gets one entry in translation table */
-#define TARGET_KDGKBSENT       0x4B48	/* gets one function key string entry */
-#define TARGET_KDGKBLED        0x4B64	/* get led flags (not lights) */
-#define TARGET_KDSKBLED        0x4B65	/* set led flags (not lights) */
-#define TARGET_KDGETLED        0x4B31	/* return current led state */
-#define TARGET_KDSETLED        0x4B32	/* set led state [lights, not flags] */
+#define TARGET_KDGKBENT        0x4B46   /* gets one entry in translation table */
+#define TARGET_KDGKBSENT       0x4B48   /* gets one function key string entry */
+#define TARGET_KDGKBLED        0x4B64   /* get led flags (not lights) */
+#define TARGET_KDSKBLED        0x4B65   /* set led flags (not lights) */
+#define TARGET_KDGETLED        0x4B31   /* return current led state */
+#define TARGET_KDSETLED        0x4B32   /* set led state [lights, not flags] */
 #define TARGET_KDSIGACCEPT     0x4B4E
 
 struct target_rtc_pll_info {
@@ -774,15 +774,15 @@ struct target_rtc_pll_info {
 #define TARGET_RTC_EPOCH_SET        TARGET_IOW('p', 0x0e, abi_ulong)
 #define TARGET_RTC_WKALM_RD         TARGET_IOR('p', 0x10, struct rtc_wkalrm)
 #define TARGET_RTC_WKALM_SET        TARGET_IOW('p', 0x0f, struct rtc_wkalrm)
-#define TARGET_RTC_PLL_GET          TARGET_IOR('p', 0x11,                      \
+#define TARGET_RTC_PLL_GET          TARGET_IOR('p', 0x11,               \
                                                struct target_rtc_pll_info)
-#define TARGET_RTC_PLL_SET          TARGET_IOW('p', 0x12,                      \
+#define TARGET_RTC_PLL_SET          TARGET_IOW('p', 0x12,               \
                                                struct target_rtc_pll_info)
 #define TARGET_RTC_VL_READ          TARGET_IOR('p', 0x13, int)
 #define TARGET_RTC_VL_CLR           TARGET_IO('p', 0x14)
 
-#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
-       defined(TARGET_XTENSA)
+#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) || \
+    defined(TARGET_XTENSA)
 #define TARGET_FIOGETOWN       TARGET_IOR('f', 123, int)
 #define TARGET_FIOSETOWN       TARGET_IOW('f', 124, int)
 #define TARGET_SIOCATMARK      TARGET_IOR('s', 7, int)
@@ -932,8 +932,8 @@ struct target_rtc_pll_info {
 #define TARGET_BLKBSZGET  TARGET_IOR(0x12, 112, abi_ulong)
 #define TARGET_BLKBSZSET  TARGET_IOW(0x12, 113, abi_ulong)
 #define TARGET_BLKGETSIZE64 TARGET_IOR(0x12,114,abi_ulong)
-                                             /* return device size in bytes
-                                                (u64 *arg) */
+/* return device size in bytes
+   (u64 *arg) */
 
 #define TARGET_BLKDISCARD TARGET_IO(0x12, 119)
 #define TARGET_BLKIOMIN TARGET_IO(0x12, 120)
@@ -991,11 +991,11 @@ struct target_rtc_pll_info {
 #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
 #define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 15)
 #define TARGET_BTRFS_IOC_INO_LOOKUP             TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 18)
-#define TARGET_BTRFS_IOC_DEFAULT_SUBVOL         TARGET_IOW(BTRFS_IOCTL_MAGIC, 19,\
+#define TARGET_BTRFS_IOC_DEFAULT_SUBVOL         TARGET_IOW(BTRFS_IOCTL_MAGIC, 19, \
                                                            abi_ullong)
-#define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
+#define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25, \
                                                            abi_ullong)
-#define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
+#define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26, \
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_SCRUB                  TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 27)
 #define TARGET_BTRFS_IOC_SCRUB_CANCEL           TARGET_IO(BTRFS_IOCTL_MAGIC, 28)
@@ -1049,56 +1049,56 @@ struct target_rtc_pll_info {
 #define TARGET_USBDEVFS_GET_SPEED TARGET_IO('U', 31)
 
 /* cdrom commands */
-#define TARGET_CDROMPAUSE		0x5301 /* Pause Audio Operation */
-#define TARGET_CDROMRESUME		0x5302 /* Resume paused Audio Operation */
-#define TARGET_CDROMPLAYMSF		0x5303 /* Play Audio MSF (struct cdrom_msf) */
-#define TARGET_CDROMPLAYTRKIND		0x5304 /* Play Audio Track/index
-                                           (struct cdrom_ti) */
-#define TARGET_CDROMREADTOCHDR		0x5305 /* Read TOC header
-                                           (struct cdrom_tochdr) */
-#define TARGET_CDROMREADTOCENTRY	0x5306 /* Read TOC entry
-                                           (struct cdrom_tocentry) */
-#define TARGET_CDROMSTOP		0x5307 /* Stop the cdrom drive */
-#define TARGET_CDROMSTART		0x5308 /* Start the cdrom drive */
-#define TARGET_CDROMEJECT		0x5309 /* Ejects the cdrom media */
-#define TARGET_CDROMVOLCTRL		0x530a /* Control output volume
-                                           (struct cdrom_volctrl) */
-#define TARGET_CDROMSUBCHNL		0x530b /* Read subchannel data
-                                           (struct cdrom_subchnl) */
-#define TARGET_CDROMREADMODE2		0x530c /* Read TARGET_CDROM mode 2 data (2336 Bytes)
-                                           (struct cdrom_read) */
-#define TARGET_CDROMREADMODE1		0x530d /* Read TARGET_CDROM mode 1 data (2048 Bytes)
-                                           (struct cdrom_read) */
-#define TARGET_CDROMREADAUDIO		0x530e /* (struct cdrom_read_audio) */
-#define TARGET_CDROMEJECT_SW		0x530f /* enable(1)/disable(0) auto-ejecting */
-#define TARGET_CDROMMULTISESSION	0x5310 /* Obtain the start-of-last-session
-                                           address of multi session disks
-                                           (struct cdrom_multisession) */
-#define TARGET_CDROM_GET_MCN		0x5311 /* Obtain the "Universal Product Code"
-                                           if available (struct cdrom_mcn) */
-#define TARGET_CDROM_GET_UPC		TARGET_CDROM_GET_MCN  /* This one is deprecated,
-                                          but here anyway for compatibility */
-#define TARGET_CDROMRESET		0x5312 /* hard-reset the drive */
-#define TARGET_CDROMVOLREAD		0x5313 /* Get the drive's volume setting
-                                          (struct cdrom_volctrl) */
-#define TARGET_CDROMREADRAW		0x5314	/* read data in raw mode (2352 Bytes)
-                                           (struct cdrom_read) */
+#define TARGET_CDROMPAUSE               0x5301 /* Pause Audio Operation */
+#define TARGET_CDROMRESUME              0x5302 /* Resume paused Audio Operation */
+#define TARGET_CDROMPLAYMSF             0x5303 /* Play Audio MSF (struct cdrom_msf) */
+#define TARGET_CDROMPLAYTRKIND          0x5304 /* Play Audio Track/index
+                                                  (struct cdrom_ti) */
+#define TARGET_CDROMREADTOCHDR          0x5305 /* Read TOC header
+                                                  (struct cdrom_tochdr) */
+#define TARGET_CDROMREADTOCENTRY        0x5306 /* Read TOC entry
+                                                  (struct cdrom_tocentry) */
+#define TARGET_CDROMSTOP                0x5307 /* Stop the cdrom drive */
+#define TARGET_CDROMSTART               0x5308 /* Start the cdrom drive */
+#define TARGET_CDROMEJECT               0x5309 /* Ejects the cdrom media */
+#define TARGET_CDROMVOLCTRL             0x530a /* Control output volume
+                                                  (struct cdrom_volctrl) */
+#define TARGET_CDROMSUBCHNL             0x530b /* Read subchannel data
+                                                  (struct cdrom_subchnl) */
+#define TARGET_CDROMREADMODE2           0x530c /* Read TARGET_CDROM mode 2 data (2336 Bytes)
+                                                  (struct cdrom_read) */
+#define TARGET_CDROMREADMODE1           0x530d /* Read TARGET_CDROM mode 1 data (2048 Bytes)
+                                                  (struct cdrom_read) */
+#define TARGET_CDROMREADAUDIO           0x530e /* (struct cdrom_read_audio) */
+#define TARGET_CDROMEJECT_SW            0x530f /* enable(1)/disable(0) auto-ejecting */
+#define TARGET_CDROMMULTISESSION        0x5310 /* Obtain the start-of-last-session
+                                                  address of multi session disks
+                                                  (struct cdrom_multisession) */
+#define TARGET_CDROM_GET_MCN            0x5311 /* Obtain the "Universal Product Code"
+                                                  if available (struct cdrom_mcn) */
+#define TARGET_CDROM_GET_UPC            TARGET_CDROM_GET_MCN  /* This one is deprecated,
+                                                                 but here anyway for compatibility */
+#define TARGET_CDROMRESET               0x5312 /* hard-reset the drive */
+#define TARGET_CDROMVOLREAD             0x5313 /* Get the drive's volume setting
+                                                  (struct cdrom_volctrl) */
+#define TARGET_CDROMREADRAW             0x5314  /* read data in raw mode (2352 Bytes)
+                                                   (struct cdrom_read) */
 /*
  * These ioctls are used only used in aztcd.c and optcd.c
  */
-#define TARGET_CDROMREADCOOKED		0x5315	/* read data in cooked mode */
-#define TARGET_CDROMSEEK		0x5316  /* seek msf address */
+#define TARGET_CDROMREADCOOKED          0x5315  /* read data in cooked mode */
+#define TARGET_CDROMSEEK                0x5316  /* seek msf address */
 
 /*
  * This ioctl is only used by the scsi-cd driver.
-   It is for playing audio in logical block addressing mode.
- */
-#define TARGET_CDROMPLAYBLK		0x5317	/* (struct cdrom_blk) */
+ It is for playing audio in logical block addressing mode.
+*/
+#define TARGET_CDROMPLAYBLK             0x5317  /* (struct cdrom_blk) */
 
 /*
  * These ioctls are only used in optcd.c
  */
-#define TARGET_CDROMREADALL		0x5318	/* read all 2646 bytes */
+#define TARGET_CDROMREADALL             0x5318  /* read all 2646 bytes */
 
 /*
  * These ioctls are (now) only in ide-cd.c for controlling
@@ -1115,35 +1115,35 @@ struct target_rtc_pll_info {
  * They _will_ be adopted by all CD-ROM drivers, when all the CD-ROM
  * drivers are eventually ported to the uniform CD-ROM driver interface.
  */
-#define TARGET_CDROMCLOSETRAY		0x5319	/* pendant of CDROMEJECT */
-#define TARGET_CDROM_SET_OPTIONS	0x5320  /* Set behavior options */
-#define TARGET_CDROM_CLEAR_OPTIONS	0x5321  /* Clear behavior options */
-#define TARGET_CDROM_SELECT_SPEED	0x5322  /* Set the CD-ROM speed */
-#define TARGET_CDROM_SELECT_DISC	0x5323  /* Select disc (for juke-boxes) */
-#define TARGET_CDROM_MEDIA_CHANGED	0x5325  /* Check is media changed  */
-#define TARGET_CDROM_DRIVE_STATUS	0x5326  /* Get tray position, etc. */
-#define TARGET_CDROM_DISC_STATUS	0x5327  /* Get disc type, etc. */
+#define TARGET_CDROMCLOSETRAY           0x5319  /* pendant of CDROMEJECT */
+#define TARGET_CDROM_SET_OPTIONS        0x5320  /* Set behavior options */
+#define TARGET_CDROM_CLEAR_OPTIONS      0x5321  /* Clear behavior options */
+#define TARGET_CDROM_SELECT_SPEED       0x5322  /* Set the CD-ROM speed */
+#define TARGET_CDROM_SELECT_DISC        0x5323  /* Select disc (for juke-boxes) */
+#define TARGET_CDROM_MEDIA_CHANGED      0x5325  /* Check is media changed  */
+#define TARGET_CDROM_DRIVE_STATUS       0x5326  /* Get tray position, etc. */
+#define TARGET_CDROM_DISC_STATUS        0x5327  /* Get disc type, etc. */
 #define TARGET_CDROM_CHANGER_NSLOTS    0x5328  /* Get number of slots */
-#define TARGET_CDROM_LOCKDOOR		0x5329  /* lock or unlock door */
-#define TARGET_CDROM_DEBUG		0x5330	/* Turn debug messages on/off */
-#define TARGET_CDROM_GET_CAPABILITY	0x5331	/* get capabilities */
+#define TARGET_CDROM_LOCKDOOR           0x5329  /* lock or unlock door */
+#define TARGET_CDROM_DEBUG              0x5330  /* Turn debug messages on/off */
+#define TARGET_CDROM_GET_CAPABILITY     0x5331  /* get capabilities */
 
 /* Note that scsi/scsi_ioctl.h also uses 0x5382 - 0x5386.
  * Future CDROM ioctls should be kept below 0x537F
  */
 
 /* This ioctl is only used by sbpcd at the moment */
-#define TARGET_CDROMAUDIOBUFSIZ        0x5382	/* set the audio buffer size */
-					/* conflict with SCSI_IOCTL_GET_IDLUN */
+#define TARGET_CDROMAUDIOBUFSIZ        0x5382   /* set the audio buffer size */
+/* conflict with SCSI_IOCTL_GET_IDLUN */
 
 /* DVD-ROM Specific ioctls */
-#define TARGET_DVD_READ_STRUCT		0x5390  /* Read structure */
-#define TARGET_DVD_WRITE_STRUCT	0x5391  /* Write structure */
-#define TARGET_DVD_AUTH		0x5392  /* Authentication */
+#define TARGET_DVD_READ_STRUCT          0x5390  /* Read structure */
+#define TARGET_DVD_WRITE_STRUCT 0x5391  /* Write structure */
+#define TARGET_DVD_AUTH         0x5392  /* Authentication */
 
-#define TARGET_CDROM_SEND_PACKET	0x5393	/* send a packet to the drive */
-#define TARGET_CDROM_NEXT_WRITABLE	0x5394	/* get next writable block */
-#define TARGET_CDROM_LAST_WRITTEN	0x5395	/* get last block written on disc */
+#define TARGET_CDROM_SEND_PACKET        0x5393  /* send a packet to the drive */
+#define TARGET_CDROM_NEXT_WRITABLE      0x5394  /* get next writable block */
+#define TARGET_CDROM_LAST_WRITTEN       0x5395  /* get last block written on disc */
 
 /* HD commands */
 
@@ -1234,19 +1234,19 @@ struct target_rtc_pll_info {
 
 #define TARGET_NCC 8
 struct target_termio {
-	unsigned short c_iflag;		/* input mode flags */
-	unsigned short c_oflag;		/* output mode flags */
-	unsigned short c_cflag;		/* control mode flags */
-	unsigned short c_lflag;		/* local mode flags */
-	unsigned char c_line;		/* line discipline */
-	unsigned char c_cc[TARGET_NCC];	/* control characters */
+    unsigned short c_iflag;         /* input mode flags */
+    unsigned short c_oflag;         /* output mode flags */
+    unsigned short c_cflag;         /* control mode flags */
+    unsigned short c_lflag;         /* local mode flags */
+    unsigned char c_line;           /* line discipline */
+    unsigned char c_cc[TARGET_NCC]; /* control characters */
 };
 
 struct target_winsize {
-	unsigned short ws_row;
-	unsigned short ws_col;
-	unsigned short ws_xpixel;
-	unsigned short ws_ypixel;
+    unsigned short ws_row;
+    unsigned short ws_col;
+    unsigned short ws_xpixel;
+    unsigned short ws_ypixel;
 };
 
 #include "termbits.h"
@@ -1263,115 +1263,115 @@ struct target_winsize {
 #endif
 
 /* Common */
-#define TARGET_MAP_SHARED	0x01		/* Share changes */
-#define TARGET_MAP_PRIVATE	0x02		/* Changes are private */
+#define TARGET_MAP_SHARED       0x01            /* Share changes */
+#define TARGET_MAP_PRIVATE      0x02            /* Changes are private */
 #if defined(TARGET_HPPA)
-#define TARGET_MAP_TYPE         0x03		/* Mask for type of mapping */
+#define TARGET_MAP_TYPE         0x03            /* Mask for type of mapping */
 #else
-#define TARGET_MAP_TYPE         0x0f		/* Mask for type of mapping */
+#define TARGET_MAP_TYPE         0x0f            /* Mask for type of mapping */
 #endif
 
 /* Target specific */
 #if defined(TARGET_MIPS)
-#define TARGET_MAP_FIXED	0x10		/* Interpret addr exactly */
-#define TARGET_MAP_ANONYMOUS	0x0800		/* don't use a file */
-#define TARGET_MAP_GROWSDOWN	0x1000		/* stack-like segment */
-#define TARGET_MAP_DENYWRITE	0x2000		/* ETXTBSY */
-#define TARGET_MAP_EXECUTABLE	0x4000		/* mark it as an executable */
-#define TARGET_MAP_LOCKED	0x8000		/* pages are locked */
-#define TARGET_MAP_NORESERVE	0x0400		/* don't check for reservations */
-#define TARGET_MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
-#define TARGET_MAP_NONBLOCK	0x20000		/* do not block on IO */
+#define TARGET_MAP_FIXED        0x10            /* Interpret addr exactly */
+#define TARGET_MAP_ANONYMOUS    0x0800          /* don't use a file */
+#define TARGET_MAP_GROWSDOWN    0x1000          /* stack-like segment */
+#define TARGET_MAP_DENYWRITE    0x2000          /* ETXTBSY */
+#define TARGET_MAP_EXECUTABLE   0x4000          /* mark it as an executable */
+#define TARGET_MAP_LOCKED       0x8000          /* pages are locked */
+#define TARGET_MAP_NORESERVE    0x0400          /* don't check for reservations */
+#define TARGET_MAP_POPULATE     0x10000         /* populate (prefault) pagetables */
+#define TARGET_MAP_NONBLOCK     0x20000         /* do not block on IO */
 #define TARGET_MAP_STACK        0x40000         /* ignored */
 #define TARGET_MAP_HUGETLB      0x80000         /* create a huge page mapping */
 #elif defined(TARGET_PPC)
-#define TARGET_MAP_FIXED	0x10		/* Interpret addr exactly */
-#define TARGET_MAP_ANONYMOUS	0x20		/* don't use a file */
-#define TARGET_MAP_GROWSDOWN	0x0100		/* stack-like segment */
-#define TARGET_MAP_DENYWRITE	0x0800		/* ETXTBSY */
-#define TARGET_MAP_EXECUTABLE	0x1000		/* mark it as an executable */
-#define TARGET_MAP_LOCKED	0x0080		/* pages are locked */
-#define TARGET_MAP_NORESERVE	0x0040		/* don't check for reservations */
-#define TARGET_MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define TARGET_MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define TARGET_MAP_FIXED        0x10            /* Interpret addr exactly */
+#define TARGET_MAP_ANONYMOUS    0x20            /* don't use a file */
+#define TARGET_MAP_GROWSDOWN    0x0100          /* stack-like segment */
+#define TARGET_MAP_DENYWRITE    0x0800          /* ETXTBSY */
+#define TARGET_MAP_EXECUTABLE   0x1000          /* mark it as an executable */
+#define TARGET_MAP_LOCKED       0x0080          /* pages are locked */
+#define TARGET_MAP_NORESERVE    0x0040          /* don't check for reservations */
+#define TARGET_MAP_POPULATE     0x8000          /* populate (prefault) pagetables */
+#define TARGET_MAP_NONBLOCK     0x10000         /* do not block on IO */
 #define TARGET_MAP_STACK        0x20000         /* ignored */
 #define TARGET_MAP_HUGETLB      0x40000         /* create a huge page mapping */
 #elif defined(TARGET_ALPHA)
-#define TARGET_MAP_ANONYMOUS	0x10		/* don't use a file */
-#define TARGET_MAP_FIXED	0x100		/* Interpret addr exactly */
-#define TARGET_MAP_GROWSDOWN	0x01000		/* stack-like segment */
-#define TARGET_MAP_DENYWRITE	0x02000		/* ETXTBSY */
-#define TARGET_MAP_EXECUTABLE	0x04000		/* mark it as an executable */
-#define TARGET_MAP_LOCKED	0x08000		/* lock the mapping */
-#define TARGET_MAP_NORESERVE	0x10000		/* no check for reservations */
-#define TARGET_MAP_POPULATE	0x20000		/* pop (prefault) pagetables */
-#define TARGET_MAP_NONBLOCK	0x40000		/* do not block on IO */
+#define TARGET_MAP_ANONYMOUS    0x10            /* don't use a file */
+#define TARGET_MAP_FIXED        0x100           /* Interpret addr exactly */
+#define TARGET_MAP_GROWSDOWN    0x01000         /* stack-like segment */
+#define TARGET_MAP_DENYWRITE    0x02000         /* ETXTBSY */
+#define TARGET_MAP_EXECUTABLE   0x04000         /* mark it as an executable */
+#define TARGET_MAP_LOCKED       0x08000         /* lock the mapping */
+#define TARGET_MAP_NORESERVE    0x10000         /* no check for reservations */
+#define TARGET_MAP_POPULATE     0x20000         /* pop (prefault) pagetables */
+#define TARGET_MAP_NONBLOCK     0x40000         /* do not block on IO */
 #define TARGET_MAP_STACK        0x80000         /* ignored */
 #define TARGET_MAP_HUGETLB      0x100000        /* create a huge page mapping */
 #elif defined(TARGET_HPPA)
-#define TARGET_MAP_ANONYMOUS	0x10		/* don't use a file */
-#define TARGET_MAP_FIXED	0x04		/* Interpret addr exactly */
-#define TARGET_MAP_GROWSDOWN	0x08000		/* stack-like segment */
-#define TARGET_MAP_DENYWRITE	0x00800		/* ETXTBSY */
-#define TARGET_MAP_EXECUTABLE	0x01000		/* mark it as an executable */
-#define TARGET_MAP_LOCKED	0x02000		/* lock the mapping */
-#define TARGET_MAP_NORESERVE	0x04000		/* no check for reservations */
-#define TARGET_MAP_POPULATE	0x10000		/* pop (prefault) pagetables */
-#define TARGET_MAP_NONBLOCK	0x20000		/* do not block on IO */
+#define TARGET_MAP_ANONYMOUS    0x10            /* don't use a file */
+#define TARGET_MAP_FIXED        0x04            /* Interpret addr exactly */
+#define TARGET_MAP_GROWSDOWN    0x08000         /* stack-like segment */
+#define TARGET_MAP_DENYWRITE    0x00800         /* ETXTBSY */
+#define TARGET_MAP_EXECUTABLE   0x01000         /* mark it as an executable */
+#define TARGET_MAP_LOCKED       0x02000         /* lock the mapping */
+#define TARGET_MAP_NORESERVE    0x04000         /* no check for reservations */
+#define TARGET_MAP_POPULATE     0x10000         /* pop (prefault) pagetables */
+#define TARGET_MAP_NONBLOCK     0x20000         /* do not block on IO */
 #define TARGET_MAP_STACK        0x40000         /* ignored */
 #define TARGET_MAP_HUGETLB      0x80000         /* create a huge page mapping */
 #elif defined(TARGET_XTENSA)
-#define TARGET_MAP_FIXED	0x10		/* Interpret addr exactly */
-#define TARGET_MAP_ANONYMOUS	0x0800		/* don't use a file */
-#define TARGET_MAP_GROWSDOWN	0x1000		/* stack-like segment */
-#define TARGET_MAP_DENYWRITE	0x2000		/* ETXTBSY */
-#define TARGET_MAP_EXECUTABLE	0x4000		/* mark it as an executable */
-#define TARGET_MAP_LOCKED	0x8000		/* pages are locked */
-#define TARGET_MAP_NORESERVE	0x0400		/* don't check for reservations */
-#define TARGET_MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
-#define TARGET_MAP_NONBLOCK	0x20000		/* do not block on IO */
-#define TARGET_MAP_STACK	0x40000
+#define TARGET_MAP_FIXED        0x10            /* Interpret addr exactly */
+#define TARGET_MAP_ANONYMOUS    0x0800          /* don't use a file */
+#define TARGET_MAP_GROWSDOWN    0x1000          /* stack-like segment */
+#define TARGET_MAP_DENYWRITE    0x2000          /* ETXTBSY */
+#define TARGET_MAP_EXECUTABLE   0x4000          /* mark it as an executable */
+#define TARGET_MAP_LOCKED       0x8000          /* pages are locked */
+#define TARGET_MAP_NORESERVE    0x0400          /* don't check for reservations */
+#define TARGET_MAP_POPULATE     0x10000         /* populate (prefault) pagetables */
+#define TARGET_MAP_NONBLOCK     0x20000         /* do not block on IO */
+#define TARGET_MAP_STACK        0x40000
 #define TARGET_MAP_HUGETLB  0x80000         /* create a huge page mapping */
 #else
-#define TARGET_MAP_FIXED	0x10		/* Interpret addr exactly */
-#define TARGET_MAP_ANONYMOUS	0x20		/* don't use a file */
-#define TARGET_MAP_GROWSDOWN	0x0100		/* stack-like segment */
-#define TARGET_MAP_DENYWRITE	0x0800		/* ETXTBSY */
-#define TARGET_MAP_EXECUTABLE	0x1000		/* mark it as an executable */
-#define TARGET_MAP_LOCKED	0x2000		/* pages are locked */
-#define TARGET_MAP_NORESERVE	0x4000		/* don't check for reservations */
-#define TARGET_MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define TARGET_MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define TARGET_MAP_FIXED        0x10            /* Interpret addr exactly */
+#define TARGET_MAP_ANONYMOUS    0x20            /* don't use a file */
+#define TARGET_MAP_GROWSDOWN    0x0100          /* stack-like segment */
+#define TARGET_MAP_DENYWRITE    0x0800          /* ETXTBSY */
+#define TARGET_MAP_EXECUTABLE   0x1000          /* mark it as an executable */
+#define TARGET_MAP_LOCKED       0x2000          /* pages are locked */
+#define TARGET_MAP_NORESERVE    0x4000          /* don't check for reservations */
+#define TARGET_MAP_POPULATE     0x8000          /* populate (prefault) pagetables */
+#define TARGET_MAP_NONBLOCK     0x10000         /* do not block on IO */
 #define TARGET_MAP_STACK        0x20000         /* ignored */
 #define TARGET_MAP_HUGETLB      0x40000         /* create a huge page mapping */
-#define TARGET_MAP_UNINITIALIZED 0x4000000	/* for anonymous mmap, memory could be uninitialized */
+#define TARGET_MAP_UNINITIALIZED 0x4000000      /* for anonymous mmap, memory could be uninitialized */
 #endif
 
-#if (defined(TARGET_I386) && defined(TARGET_ABI32)) \
-    || (defined(TARGET_ARM) && defined(TARGET_ABI32)) \
+#if (defined(TARGET_I386) && defined(TARGET_ABI32))     \
+    || (defined(TARGET_ARM) && defined(TARGET_ABI32))   \
     || defined(TARGET_CRIS)
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
-	unsigned short st_dev;
-	unsigned short __pad1;
-	abi_ulong st_ino;
-	unsigned short st_mode;
-	unsigned short st_nlink;
-	unsigned short st_uid;
-	unsigned short st_gid;
-	unsigned short st_rdev;
-	unsigned short __pad2;
-	abi_ulong  st_size;
-	abi_ulong  st_blksize;
-	abi_ulong  st_blocks;
-	abi_ulong  target_st_atime;
-	abi_ulong  target_st_atime_nsec;
-	abi_ulong  target_st_mtime;
-	abi_ulong  target_st_mtime_nsec;
-	abi_ulong  target_st_ctime;
-	abi_ulong  target_st_ctime_nsec;
-	abi_ulong  __unused4;
-	abi_ulong  __unused5;
+    unsigned short st_dev;
+    unsigned short __pad1;
+    abi_ulong st_ino;
+    unsigned short st_mode;
+    unsigned short st_nlink;
+    unsigned short st_uid;
+    unsigned short st_gid;
+    unsigned short st_rdev;
+    unsigned short __pad2;
+    abi_ulong  st_size;
+    abi_ulong  st_blksize;
+    abi_ulong  st_blocks;
+    abi_ulong  target_st_atime;
+    abi_ulong  target_st_atime_nsec;
+    abi_ulong  target_st_mtime;
+    abi_ulong  target_st_mtime_nsec;
+    abi_ulong  target_st_ctime;
+    abi_ulong  target_st_ctime_nsec;
+    abi_ulong  __unused4;
+    abi_ulong  __unused5;
 };
 
 /* This matches struct stat64 in glibc2.1, hence the absolutely
@@ -1379,239 +1379,239 @@ struct target_stat {
  */
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
-	unsigned short	st_dev;
-	unsigned char	__pad0[10];
+    unsigned short  st_dev;
+    unsigned char   __pad0[10];
 
-#define TARGET_STAT64_HAS_BROKEN_ST_INO	1
-	abi_ulong	__st_ino;
+#define TARGET_STAT64_HAS_BROKEN_ST_INO 1
+    abi_ulong       __st_ino;
 
-	unsigned int	st_mode;
-	unsigned int	st_nlink;
+    unsigned int    st_mode;
+    unsigned int    st_nlink;
 
-	abi_ulong	st_uid;
-	abi_ulong	st_gid;
+    abi_ulong       st_uid;
+    abi_ulong       st_gid;
 
-	unsigned short	st_rdev;
-	unsigned char	__pad3[10];
+    unsigned short  st_rdev;
+    unsigned char   __pad3[10];
 
-	long long	st_size;
-	abi_ulong	st_blksize;
+    long long       st_size;
+    abi_ulong       st_blksize;
 
-	abi_ulong	st_blocks;	/* Number 512-byte blocks allocated. */
-	abi_ulong	__pad4;		/* future possible st_blocks high bits */
+    abi_ulong       st_blocks;      /* Number 512-byte blocks allocated. */
+    abi_ulong       __pad4;         /* future possible st_blocks high bits */
 
-	abi_ulong	target_st_atime;
-	abi_ulong	target_st_atime_nsec;
+    abi_ulong       target_st_atime;
+    abi_ulong       target_st_atime_nsec;
 
-	abi_ulong	target_st_mtime;
-	abi_ulong	target_st_mtime_nsec;
+    abi_ulong       target_st_mtime;
+    abi_ulong       target_st_mtime_nsec;
 
-	abi_ulong	target_st_ctime;
-	abi_ulong	target_st_ctime_nsec;
+    abi_ulong       target_st_ctime;
+    abi_ulong       target_st_ctime_nsec;
 
-	unsigned long long	st_ino;
+    unsigned long long      st_ino;
 } QEMU_PACKED;
 
 #ifdef TARGET_ARM
 #define TARGET_HAS_STRUCT_STAT64
 struct target_eabi_stat64 {
-        unsigned long long st_dev;
-        unsigned int    __pad1;
-        abi_ulong    __st_ino;
-        unsigned int    st_mode;
-        unsigned int    st_nlink;
+    unsigned long long st_dev;
+    unsigned int    __pad1;
+    abi_ulong    __st_ino;
+    unsigned int    st_mode;
+    unsigned int    st_nlink;
 
-        abi_ulong    st_uid;
-        abi_ulong    st_gid;
+    abi_ulong    st_uid;
+    abi_ulong    st_gid;
 
-        unsigned long long st_rdev;
-        unsigned int    __pad2[2];
+    unsigned long long st_rdev;
+    unsigned int    __pad2[2];
 
-        long long       st_size;
-        abi_ulong    st_blksize;
-        unsigned int    __pad3;
-        unsigned long long st_blocks;
+    long long       st_size;
+    abi_ulong    st_blksize;
+    unsigned int    __pad3;
+    unsigned long long st_blocks;
 
-        abi_ulong    target_st_atime;
-        abi_ulong    target_st_atime_nsec;
+    abi_ulong    target_st_atime;
+    abi_ulong    target_st_atime_nsec;
 
-        abi_ulong    target_st_mtime;
-        abi_ulong    target_st_mtime_nsec;
+    abi_ulong    target_st_mtime;
+    abi_ulong    target_st_mtime_nsec;
 
-        abi_ulong    target_st_ctime;
-        abi_ulong    target_st_ctime_nsec;
+    abi_ulong    target_st_ctime;
+    abi_ulong    target_st_ctime_nsec;
 
-        unsigned long long st_ino;
+    unsigned long long st_ino;
 } QEMU_PACKED;
 #endif
 
 #elif defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
 struct target_stat {
-	unsigned int	st_dev;
-	abi_ulong	st_ino;
-	unsigned int	st_mode;
-	unsigned int	st_nlink;
-	unsigned int	st_uid;
-	unsigned int	st_gid;
-	unsigned int	st_rdev;
-	abi_long	st_size;
-	abi_long	target_st_atime;
-	abi_long	target_st_mtime;
-	abi_long	target_st_ctime;
-	abi_long	st_blksize;
-	abi_long	st_blocks;
-	abi_ulong	__unused4[2];
+    unsigned int    st_dev;
+    abi_ulong       st_ino;
+    unsigned int    st_mode;
+    unsigned int    st_nlink;
+    unsigned int    st_uid;
+    unsigned int    st_gid;
+    unsigned int    st_rdev;
+    abi_long        st_size;
+    abi_long        target_st_atime;
+    abi_long        target_st_mtime;
+    abi_long        target_st_ctime;
+    abi_long        st_blksize;
+    abi_long        st_blocks;
+    abi_ulong       __unused4[2];
 };
 
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
-	unsigned char	__pad0[6];
-	unsigned short	st_dev;
+    unsigned char   __pad0[6];
+    unsigned short  st_dev;
 
-	uint64_t	st_ino;
-	uint64_t	st_nlink;
+    uint64_t        st_ino;
+    uint64_t        st_nlink;
 
-	unsigned int	st_mode;
+    unsigned int    st_mode;
 
-	unsigned int	st_uid;
-	unsigned int	st_gid;
+    unsigned int    st_uid;
+    unsigned int    st_gid;
 
-	unsigned char	__pad2[6];
-	unsigned short	st_rdev;
+    unsigned char   __pad2[6];
+    unsigned short  st_rdev;
 
-        int64_t		st_size;
-	int64_t		st_blksize;
+    int64_t         st_size;
+    int64_t         st_blksize;
 
-	unsigned char	__pad4[4];
-	unsigned int	st_blocks;
+    unsigned char   __pad4[4];
+    unsigned int    st_blocks;
 
-	abi_ulong	target_st_atime;
-	abi_ulong	target_st_atime_nsec;
+    abi_ulong       target_st_atime;
+    abi_ulong       target_st_atime_nsec;
 
-	abi_ulong	target_st_mtime;
-	abi_ulong	target_st_mtime_nsec;
+    abi_ulong       target_st_mtime;
+    abi_ulong       target_st_mtime_nsec;
 
-	abi_ulong	target_st_ctime;
-	abi_ulong	target_st_ctime_nsec;
+    abi_ulong       target_st_ctime;
+    abi_ulong       target_st_ctime_nsec;
 
-	abi_ulong	__unused4[3];
+    abi_ulong       __unused4[3];
 };
 
 #elif defined(TARGET_SPARC)
 
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
-	unsigned short	st_dev;
-	abi_ulong	st_ino;
-	unsigned short	st_mode;
-	short		st_nlink;
-	unsigned short	st_uid;
-	unsigned short	st_gid;
-	unsigned short	st_rdev;
-	abi_long	st_size;
-	abi_long	target_st_atime;
-	abi_ulong	target_st_atime_nsec;
-	abi_long	target_st_mtime;
-	abi_ulong	target_st_mtime_nsec;
-	abi_long	target_st_ctime;
-	abi_ulong	target_st_ctime_nsec;
-	abi_long	st_blksize;
-	abi_long	st_blocks;
-	abi_ulong	__unused1[2];
+    unsigned short  st_dev;
+    abi_ulong       st_ino;
+    unsigned short  st_mode;
+    short           st_nlink;
+    unsigned short  st_uid;
+    unsigned short  st_gid;
+    unsigned short  st_rdev;
+    abi_long        st_size;
+    abi_long        target_st_atime;
+    abi_ulong       target_st_atime_nsec;
+    abi_long        target_st_mtime;
+    abi_ulong       target_st_mtime_nsec;
+    abi_long        target_st_ctime;
+    abi_ulong       target_st_ctime_nsec;
+    abi_long        st_blksize;
+    abi_long        st_blocks;
+    abi_ulong       __unused1[2];
 };
 
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
-	unsigned char	__pad0[6];
-	unsigned short	st_dev;
+    unsigned char   __pad0[6];
+    unsigned short  st_dev;
 
-	uint64_t st_ino;
+    uint64_t st_ino;
 
-	unsigned int	st_mode;
-	unsigned int	st_nlink;
+    unsigned int    st_mode;
+    unsigned int    st_nlink;
 
-	unsigned int	st_uid;
-	unsigned int	st_gid;
+    unsigned int    st_uid;
+    unsigned int    st_gid;
 
-	unsigned char	__pad2[6];
-	unsigned short	st_rdev;
+    unsigned char   __pad2[6];
+    unsigned short  st_rdev;
 
-	unsigned char	__pad3[8];
+    unsigned char   __pad3[8];
 
-        int64_t	st_size;
-	unsigned int	st_blksize;
+    int64_t st_size;
+    unsigned int    st_blksize;
 
-	unsigned char	__pad4[8];
-	unsigned int	st_blocks;
+    unsigned char   __pad4[8];
+    unsigned int    st_blocks;
 
-	unsigned int	target_st_atime;
-	unsigned int	target_st_atime_nsec;
+    unsigned int    target_st_atime;
+    unsigned int    target_st_atime_nsec;
 
-	unsigned int	target_st_mtime;
-	unsigned int	target_st_mtime_nsec;
+    unsigned int    target_st_mtime;
+    unsigned int    target_st_mtime_nsec;
 
-	unsigned int	target_st_ctime;
-	unsigned int	target_st_ctime_nsec;
+    unsigned int    target_st_ctime;
+    unsigned int    target_st_ctime_nsec;
 
-	unsigned int	__unused1;
-	unsigned int	__unused2;
+    unsigned int    __unused1;
+    unsigned int    __unused2;
 };
 
 #elif defined(TARGET_PPC)
 
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
-	abi_ulong st_dev;
-	abi_ulong st_ino;
+    abi_ulong st_dev;
+    abi_ulong st_ino;
 #if defined(TARGET_PPC64)
-	abi_ulong st_nlink;
-	unsigned int st_mode;
+    abi_ulong st_nlink;
+    unsigned int st_mode;
 #else
-	unsigned int st_mode;
-	unsigned short st_nlink;
+    unsigned int st_mode;
+    unsigned short st_nlink;
 #endif
-	unsigned int st_uid;
-	unsigned int st_gid;
-	abi_ulong  st_rdev;
-	abi_ulong  st_size;
-	abi_ulong  st_blksize;
-	abi_ulong  st_blocks;
-	abi_ulong  target_st_atime;
-	abi_ulong  target_st_atime_nsec;
-	abi_ulong  target_st_mtime;
-	abi_ulong  target_st_mtime_nsec;
-	abi_ulong  target_st_ctime;
-	abi_ulong  target_st_ctime_nsec;
-	abi_ulong  __unused4;
-	abi_ulong  __unused5;
+    unsigned int st_uid;
+    unsigned int st_gid;
+    abi_ulong  st_rdev;
+    abi_ulong  st_size;
+    abi_ulong  st_blksize;
+    abi_ulong  st_blocks;
+    abi_ulong  target_st_atime;
+    abi_ulong  target_st_atime_nsec;
+    abi_ulong  target_st_mtime;
+    abi_ulong  target_st_mtime_nsec;
+    abi_ulong  target_st_ctime;
+    abi_ulong  target_st_ctime_nsec;
+    abi_ulong  __unused4;
+    abi_ulong  __unused5;
 #if defined(TARGET_PPC64)
-	abi_ulong  __unused6;
+    abi_ulong  __unused6;
 #endif
 };
 
 #if !defined(TARGET_PPC64)
 #define TARGET_HAS_STRUCT_STAT64
 struct QEMU_PACKED target_stat64 {
-	unsigned long long st_dev;
-        unsigned long long st_ino;
-	unsigned int st_mode;
-	unsigned int st_nlink;
-	unsigned int st_uid;
-	unsigned int st_gid;
-	unsigned long long st_rdev;
-	unsigned long long __pad0;
-	long long      st_size;
-	int	       st_blksize;
-	unsigned int   __pad1;
-	long long      st_blocks;	/* Number 512-byte blocks allocated. */
-	int	       target_st_atime;
-        unsigned int   target_st_atime_nsec;
-	int	       target_st_mtime;
-        unsigned int   target_st_mtime_nsec;
-	int            target_st_ctime;
-        unsigned int   target_st_ctime_nsec;
-        unsigned int   __unused4;
-        unsigned int   __unused5;
+    unsigned long long st_dev;
+    unsigned long long st_ino;
+    unsigned int st_mode;
+    unsigned int st_nlink;
+    unsigned int st_uid;
+    unsigned int st_gid;
+    unsigned long long st_rdev;
+    unsigned long long __pad0;
+    long long      st_size;
+    int            st_blksize;
+    unsigned int   __pad1;
+    long long      st_blocks;       /* Number 512-byte blocks allocated. */
+    int            target_st_atime;
+    unsigned int   target_st_atime_nsec;
+    int            target_st_mtime;
+    unsigned int   target_st_mtime_nsec;
+    int            target_st_ctime;
+    unsigned int   target_st_ctime_nsec;
+    unsigned int   __unused4;
+    unsigned int   __unused5;
 };
 #endif
 
@@ -1619,78 +1619,78 @@ struct QEMU_PACKED target_stat64 {
 
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
-	abi_ulong st_dev;
-	abi_ulong st_ino;
-	unsigned int st_mode;
-	unsigned short st_nlink;
-	unsigned int st_uid;
-	unsigned int st_gid;
-	abi_ulong  st_rdev;
-	abi_ulong  st_size;
-	abi_ulong  st_blksize;
-	abi_ulong  st_blocks;
-	abi_ulong  target_st_atime;
-	abi_ulong  target_st_atime_nsec;
-	abi_ulong  target_st_mtime;
-	abi_ulong  target_st_mtime_nsec;
-	abi_ulong  target_st_ctime;
-	abi_ulong  target_st_ctime_nsec;
-	abi_ulong  __unused4;
-	abi_ulong  __unused5;
+    abi_ulong st_dev;
+    abi_ulong st_ino;
+    unsigned int st_mode;
+    unsigned short st_nlink;
+    unsigned int st_uid;
+    unsigned int st_gid;
+    abi_ulong  st_rdev;
+    abi_ulong  st_size;
+    abi_ulong  st_blksize;
+    abi_ulong  st_blocks;
+    abi_ulong  target_st_atime;
+    abi_ulong  target_st_atime_nsec;
+    abi_ulong  target_st_mtime;
+    abi_ulong  target_st_mtime_nsec;
+    abi_ulong  target_st_ctime;
+    abi_ulong  target_st_ctime_nsec;
+    abi_ulong  __unused4;
+    abi_ulong  __unused5;
 };
 
 /* FIXME: Microblaze no-mmu user-space has a difference stat64 layout...  */
 #define TARGET_HAS_STRUCT_STAT64
 struct QEMU_PACKED target_stat64 {
-	uint64_t st_dev;
+    uint64_t st_dev;
 #define TARGET_STAT64_HAS_BROKEN_ST_INO 1
-	uint32_t pad0;
-	uint32_t __st_ino;
+    uint32_t pad0;
+    uint32_t __st_ino;
 
-	uint32_t st_mode;
-	uint32_t st_nlink;
-	uint32_t st_uid;
-	uint32_t st_gid;
-	uint64_t st_rdev;
-	uint64_t __pad1;
+    uint32_t st_mode;
+    uint32_t st_nlink;
+    uint32_t st_uid;
+    uint32_t st_gid;
+    uint64_t st_rdev;
+    uint64_t __pad1;
 
-	int64_t  st_size;
-	int32_t  st_blksize;
-	uint32_t __pad2;
-	int64_t st_blocks;	/* Number 512-byte blocks allocated. */
+    int64_t  st_size;
+    int32_t  st_blksize;
+    uint32_t __pad2;
+    int64_t st_blocks;      /* Number 512-byte blocks allocated. */
 
-	int	       target_st_atime;
-	unsigned int   target_st_atime_nsec;
-	int	       target_st_mtime;
-	unsigned int   target_st_mtime_nsec;
-	int            target_st_ctime;
-	unsigned int   target_st_ctime_nsec;
-	uint64_t st_ino;
+    int            target_st_atime;
+    unsigned int   target_st_atime_nsec;
+    int            target_st_mtime;
+    unsigned int   target_st_mtime_nsec;
+    int            target_st_ctime;
+    unsigned int   target_st_ctime_nsec;
+    uint64_t st_ino;
 };
 
 #elif defined(TARGET_M68K)
 
 struct target_stat {
-	unsigned short st_dev;
-	unsigned short __pad1;
-	abi_ulong st_ino;
-	unsigned short st_mode;
-	unsigned short st_nlink;
-	unsigned short st_uid;
-	unsigned short st_gid;
-	unsigned short st_rdev;
-	unsigned short __pad2;
-	abi_ulong  st_size;
-	abi_ulong  st_blksize;
-	abi_ulong  st_blocks;
-	abi_ulong  target_st_atime;
-	abi_ulong  __unused1;
-	abi_ulong  target_st_mtime;
-	abi_ulong  __unused2;
-	abi_ulong  target_st_ctime;
-	abi_ulong  __unused3;
-	abi_ulong  __unused4;
-	abi_ulong  __unused5;
+    unsigned short st_dev;
+    unsigned short __pad1;
+    abi_ulong st_ino;
+    unsigned short st_mode;
+    unsigned short st_nlink;
+    unsigned short st_uid;
+    unsigned short st_gid;
+    unsigned short st_rdev;
+    unsigned short __pad2;
+    abi_ulong  st_size;
+    abi_ulong  st_blksize;
+    abi_ulong  st_blocks;
+    abi_ulong  target_st_atime;
+    abi_ulong  __unused1;
+    abi_ulong  target_st_mtime;
+    abi_ulong  __unused2;
+    abi_ulong  target_st_ctime;
+    abi_ulong  __unused3;
+    abi_ulong  __unused4;
+    abi_ulong  __unused5;
 };
 
 /* This matches struct stat64 in glibc2.1, hence the absolutely
@@ -1698,37 +1698,37 @@ struct target_stat {
  */
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
-	unsigned long long	st_dev;
-	unsigned char	__pad1[2];
+    unsigned long long      st_dev;
+    unsigned char   __pad1[2];
 
-#define TARGET_STAT64_HAS_BROKEN_ST_INO	1
-	abi_ulong	__st_ino;
+#define TARGET_STAT64_HAS_BROKEN_ST_INO 1
+    abi_ulong       __st_ino;
 
-	unsigned int	st_mode;
-	unsigned int	st_nlink;
+    unsigned int    st_mode;
+    unsigned int    st_nlink;
 
-	abi_ulong	st_uid;
-	abi_ulong	st_gid;
+    abi_ulong       st_uid;
+    abi_ulong       st_gid;
 
-	unsigned long long	st_rdev;
-	unsigned char	__pad3[2];
+    unsigned long long      st_rdev;
+    unsigned char   __pad3[2];
 
-	long long	st_size;
-	abi_ulong	st_blksize;
+    long long       st_size;
+    abi_ulong       st_blksize;
 
-	abi_ulong	__pad4;		/* future possible st_blocks high bits */
-	abi_ulong	st_blocks;	/* Number 512-byte blocks allocated. */
+    abi_ulong       __pad4;         /* future possible st_blocks high bits */
+    abi_ulong       st_blocks;      /* Number 512-byte blocks allocated. */
 
-	abi_ulong	target_st_atime;
-	abi_ulong	target_st_atime_nsec;
+    abi_ulong       target_st_atime;
+    abi_ulong       target_st_atime_nsec;
 
-	abi_ulong	target_st_mtime;
-	abi_ulong	target_st_mtime_nsec;
+    abi_ulong       target_st_mtime;
+    abi_ulong       target_st_mtime_nsec;
 
-	abi_ulong	target_st_ctime;
-	abi_ulong	target_st_ctime_nsec;
+    abi_ulong       target_st_ctime;
+    abi_ulong       target_st_ctime_nsec;
 
-	unsigned long long	st_ino;
+    unsigned long long      st_ino;
 } QEMU_PACKED;
 
 #elif defined(TARGET_ABI_MIPSN64)
@@ -1736,94 +1736,94 @@ struct target_stat64 {
 #define TARGET_STAT_HAVE_NSEC
 /* The memory layout is the same as of struct stat64 of the 32-bit kernel.  */
 struct target_stat {
-	unsigned int		st_dev;
-	unsigned int		st_pad0[3]; /* Reserved for st_dev expansion */
+    unsigned int            st_dev;
+    unsigned int            st_pad0[3]; /* Reserved for st_dev expansion */
 
-	abi_ulong		st_ino;
+    abi_ulong               st_ino;
 
-	unsigned int		st_mode;
-	unsigned int		st_nlink;
+    unsigned int            st_mode;
+    unsigned int            st_nlink;
 
-	int			st_uid;
-	int			st_gid;
+    int                     st_uid;
+    int                     st_gid;
 
-	unsigned int		st_rdev;
-	unsigned int		st_pad1[3]; /* Reserved for st_rdev expansion */
+    unsigned int            st_rdev;
+    unsigned int            st_pad1[3]; /* Reserved for st_rdev expansion */
 
-	abi_ulong		st_size;
+    abi_ulong               st_size;
 
-	/*
-	 * Actually this should be timestruc_t st_atime, st_mtime and st_ctime
-	 * but we don't have it under Linux.
-	 */
-	unsigned int		target_st_atime;
-	unsigned int		target_st_atime_nsec;
+    /*
+     * Actually this should be timestruc_t st_atime, st_mtime and st_ctime
+     * but we don't have it under Linux.
+     */
+    unsigned int            target_st_atime;
+    unsigned int            target_st_atime_nsec;
 
-	unsigned int		target_st_mtime;
-	unsigned int		target_st_mtime_nsec;
+    unsigned int            target_st_mtime;
+    unsigned int            target_st_mtime_nsec;
 
-	unsigned int		target_st_ctime;
-	unsigned int		target_st_ctime_nsec;
+    unsigned int            target_st_ctime;
+    unsigned int            target_st_ctime_nsec;
 
-	unsigned int		st_blksize;
-	unsigned int		st_pad2;
+    unsigned int            st_blksize;
+    unsigned int            st_pad2;
 
-	abi_ulong		st_blocks;
+    abi_ulong               st_blocks;
 };
 
 #elif defined(TARGET_ABI_MIPSN32)
 
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
-        abi_ulong    st_dev;
-        abi_ulong    st_pad0[3]; /* Reserved for st_dev expansion */
-        uint64_t     st_ino;
-        unsigned int st_mode;
-        unsigned int st_nlink;
-        int          st_uid;
-        int          st_gid;
-        abi_ulong    st_rdev;
-        abi_ulong    st_pad1[3]; /* Reserved for st_rdev expansion */
-        int64_t      st_size;
-        abi_long     target_st_atime;
-        abi_ulong    target_st_atime_nsec; /* Reserved for st_atime expansion */
-        abi_long     target_st_mtime;
-        abi_ulong    target_st_mtime_nsec; /* Reserved for st_mtime expansion */
-        abi_long     target_st_ctime;
-        abi_ulong    target_st_ctime_nsec; /* Reserved for st_ctime expansion */
-        abi_ulong    st_blksize;
-        abi_ulong    st_pad2;
-        int64_t      st_blocks;
+    abi_ulong    st_dev;
+    abi_ulong    st_pad0[3]; /* Reserved for st_dev expansion */
+    uint64_t     st_ino;
+    unsigned int st_mode;
+    unsigned int st_nlink;
+    int          st_uid;
+    int          st_gid;
+    abi_ulong    st_rdev;
+    abi_ulong    st_pad1[3]; /* Reserved for st_rdev expansion */
+    int64_t      st_size;
+    abi_long     target_st_atime;
+    abi_ulong    target_st_atime_nsec; /* Reserved for st_atime expansion */
+    abi_long     target_st_mtime;
+    abi_ulong    target_st_mtime_nsec; /* Reserved for st_mtime expansion */
+    abi_long     target_st_ctime;
+    abi_ulong    target_st_ctime_nsec; /* Reserved for st_ctime expansion */
+    abi_ulong    st_blksize;
+    abi_ulong    st_pad2;
+    int64_t      st_blocks;
 };
 
 #elif defined(TARGET_ABI_MIPSO32)
 
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
-	unsigned	st_dev;
-	abi_long	st_pad1[3];		/* Reserved for network id */
-	abi_ulong	st_ino;
-	unsigned int	st_mode;
-	unsigned int	st_nlink;
-	int		st_uid;
-	int		st_gid;
-	unsigned 	st_rdev;
-	abi_long	st_pad2[2];
-	abi_long	st_size;
-	abi_long	st_pad3;
-	/*
-	 * Actually this should be timestruc_t st_atime, st_mtime and st_ctime
-	 * but we don't have it under Linux.
-	 */
-	abi_long		target_st_atime;
-	abi_long		target_st_atime_nsec;
-	abi_long		target_st_mtime;
-	abi_long		target_st_mtime_nsec;
-	abi_long		target_st_ctime;
-	abi_long		target_st_ctime_nsec;
-	abi_long		st_blksize;
-	abi_long		st_blocks;
-	abi_long		st_pad4[14];
+    unsigned        st_dev;
+    abi_long        st_pad1[3];             /* Reserved for network id */
+    abi_ulong       st_ino;
+    unsigned int    st_mode;
+    unsigned int    st_nlink;
+    int             st_uid;
+    int             st_gid;
+    unsigned        st_rdev;
+    abi_long        st_pad2[2];
+    abi_long        st_size;
+    abi_long        st_pad3;
+    /*
+     * Actually this should be timestruc_t st_atime, st_mtime and st_ctime
+     * but we don't have it under Linux.
+     */
+    abi_long                target_st_atime;
+    abi_long                target_st_atime_nsec;
+    abi_long                target_st_mtime;
+    abi_long                target_st_mtime_nsec;
+    abi_long                target_st_ctime;
+    abi_long                target_st_ctime_nsec;
+    abi_long                st_blksize;
+    abi_long                st_blocks;
+    abi_long                st_pad4[14];
 };
 
 /*
@@ -1834,107 +1834,107 @@ struct target_stat {
 
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
-	abi_ulong	st_dev;
-	abi_ulong	st_pad0[3];	/* Reserved for st_dev expansion  */
+    abi_ulong       st_dev;
+    abi_ulong       st_pad0[3];     /* Reserved for st_dev expansion  */
 
-	uint64_t	st_ino;
+    uint64_t        st_ino;
 
-        unsigned int	st_mode;
-        unsigned int	st_nlink;
+    unsigned int    st_mode;
+    unsigned int    st_nlink;
 
-	int		st_uid;
-	int		st_gid;
+    int             st_uid;
+    int             st_gid;
 
-	abi_ulong	st_rdev;
-	abi_ulong	st_pad1[3];	/* Reserved for st_rdev expansion  */
+    abi_ulong       st_rdev;
+    abi_ulong       st_pad1[3];     /* Reserved for st_rdev expansion  */
 
-	int64_t 	st_size;
+    int64_t         st_size;
 
-	/*
-	 * Actually this should be timestruc_t st_atime, st_mtime and st_ctime
-	 * but we don't have it under Linux.
-	 */
-	abi_long	target_st_atime;
-	abi_ulong	target_st_atime_nsec;	/* Reserved for st_atime expansion  */
+    /*
+     * Actually this should be timestruc_t st_atime, st_mtime and st_ctime
+     * but we don't have it under Linux.
+     */
+    abi_long        target_st_atime;
+    abi_ulong       target_st_atime_nsec;   /* Reserved for st_atime expansion  */
 
-	abi_long	target_st_mtime;
-	abi_ulong	target_st_mtime_nsec;	/* Reserved for st_mtime expansion  */
+    abi_long        target_st_mtime;
+    abi_ulong       target_st_mtime_nsec;   /* Reserved for st_mtime expansion  */
 
-	abi_long	target_st_ctime;
-	abi_ulong	target_st_ctime_nsec;	/* Reserved for st_ctime expansion  */
+    abi_long        target_st_ctime;
+    abi_ulong       target_st_ctime_nsec;   /* Reserved for st_ctime expansion  */
 
-	abi_ulong	st_blksize;
-	abi_ulong	st_pad2;
+    abi_ulong       st_blksize;
+    abi_ulong       st_pad2;
 
-	int64_t  	st_blocks;
+    int64_t         st_blocks;
 };
 
 #elif defined(TARGET_ALPHA)
 
 struct target_stat {
-       unsigned int    st_dev;
-       unsigned int    st_ino;
-       unsigned int    st_mode;
-       unsigned int    st_nlink;
-       unsigned int    st_uid;
-       unsigned int    st_gid;
-       unsigned int    st_rdev;
-       abi_long     st_size;
-       abi_ulong    target_st_atime;
-       abi_ulong    target_st_mtime;
-       abi_ulong    target_st_ctime;
-       unsigned int    st_blksize;
-       unsigned int    st_blocks;
-       unsigned int    st_flags;
-       unsigned int    st_gen;
+    unsigned int    st_dev;
+    unsigned int    st_ino;
+    unsigned int    st_mode;
+    unsigned int    st_nlink;
+    unsigned int    st_uid;
+    unsigned int    st_gid;
+    unsigned int    st_rdev;
+    abi_long     st_size;
+    abi_ulong    target_st_atime;
+    abi_ulong    target_st_mtime;
+    abi_ulong    target_st_ctime;
+    unsigned int    st_blksize;
+    unsigned int    st_blocks;
+    unsigned int    st_flags;
+    unsigned int    st_gen;
 };
 
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
-       abi_ulong    st_dev;
-       abi_ulong    st_ino;
-       abi_ulong    st_rdev;
-       abi_long     st_size;
-       abi_ulong    st_blocks;
+    abi_ulong    st_dev;
+    abi_ulong    st_ino;
+    abi_ulong    st_rdev;
+    abi_long     st_size;
+    abi_ulong    st_blocks;
 
-       unsigned int    st_mode;
-       unsigned int    st_uid;
-       unsigned int    st_gid;
-       unsigned int    st_blksize;
-       unsigned int    st_nlink;
-       unsigned int    __pad0;
+    unsigned int    st_mode;
+    unsigned int    st_uid;
+    unsigned int    st_gid;
+    unsigned int    st_blksize;
+    unsigned int    st_nlink;
+    unsigned int    __pad0;
 
-       abi_ulong    target_st_atime;
-       abi_ulong    target_st_atime_nsec;
-       abi_ulong    target_st_mtime;
-       abi_ulong    target_st_mtime_nsec;
-       abi_ulong    target_st_ctime;
-       abi_ulong    target_st_ctime_nsec;
-       abi_long     __unused[3];
+    abi_ulong    target_st_atime;
+    abi_ulong    target_st_atime_nsec;
+    abi_ulong    target_st_mtime;
+    abi_ulong    target_st_mtime_nsec;
+    abi_ulong    target_st_ctime;
+    abi_ulong    target_st_ctime_nsec;
+    abi_long     __unused[3];
 };
 
 #elif defined(TARGET_SH4)
 
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
-	abi_ulong  st_dev;
-	abi_ulong  st_ino;
-	unsigned short st_mode;
-	unsigned short st_nlink;
-	unsigned short st_uid;
-	unsigned short st_gid;
-	abi_ulong  st_rdev;
-	abi_ulong  st_size;
-	abi_ulong  st_blksize;
-	abi_ulong  st_blocks;
-	abi_ulong  target_st_atime;
-	abi_ulong  target_st_atime_nsec;
-	abi_ulong  target_st_mtime;
-	abi_ulong  target_st_mtime_nsec;
-	abi_ulong  target_st_ctime;
-	abi_ulong  target_st_ctime_nsec;
-	abi_ulong  __unused4;
-	abi_ulong  __unused5;
+    abi_ulong  st_dev;
+    abi_ulong  st_ino;
+    unsigned short st_mode;
+    unsigned short st_nlink;
+    unsigned short st_uid;
+    unsigned short st_gid;
+    abi_ulong  st_rdev;
+    abi_ulong  st_size;
+    abi_ulong  st_blksize;
+    abi_ulong  st_blocks;
+    abi_ulong  target_st_atime;
+    abi_ulong  target_st_atime_nsec;
+    abi_ulong  target_st_mtime;
+    abi_ulong  target_st_mtime_nsec;
+    abi_ulong  target_st_ctime;
+    abi_ulong  target_st_ctime_nsec;
+    abi_ulong  __unused4;
+    abi_ulong  __unused5;
 };
 
 /* This matches struct stat64 in glibc2.1, hence the absolutely
@@ -1942,62 +1942,62 @@ struct target_stat {
  */
 #define TARGET_HAS_STRUCT_STAT64
 struct QEMU_PACKED target_stat64 {
-	unsigned long long	st_dev;
-	unsigned char	__pad0[4];
+    unsigned long long      st_dev;
+    unsigned char   __pad0[4];
 
-#define TARGET_STAT64_HAS_BROKEN_ST_INO	1
-	abi_ulong	__st_ino;
+#define TARGET_STAT64_HAS_BROKEN_ST_INO 1
+    abi_ulong       __st_ino;
 
-	unsigned int	st_mode;
-	unsigned int	st_nlink;
+    unsigned int    st_mode;
+    unsigned int    st_nlink;
 
-	abi_ulong	st_uid;
-	abi_ulong	st_gid;
+    abi_ulong       st_uid;
+    abi_ulong       st_gid;
 
-	unsigned long long	st_rdev;
-	unsigned char	__pad3[4];
+    unsigned long long      st_rdev;
+    unsigned char   __pad3[4];
 
-	long long	st_size;
-	abi_ulong	st_blksize;
+    long long       st_size;
+    abi_ulong       st_blksize;
 
-	unsigned long long	st_blocks;	/* Number 512-byte blocks allocated. */
+    unsigned long long      st_blocks;      /* Number 512-byte blocks allocated. */
 
-	abi_ulong	target_st_atime;
-	abi_ulong	target_st_atime_nsec;
+    abi_ulong       target_st_atime;
+    abi_ulong       target_st_atime_nsec;
 
-	abi_ulong	target_st_mtime;
-	abi_ulong	target_st_mtime_nsec;
+    abi_ulong       target_st_mtime;
+    abi_ulong       target_st_mtime_nsec;
 
-	abi_ulong	target_st_ctime;
-	abi_ulong	target_st_ctime_nsec;
+    abi_ulong       target_st_ctime;
+    abi_ulong       target_st_ctime_nsec;
 
-	unsigned long long	st_ino;
+    unsigned long long      st_ino;
 };
 
 #elif defined(TARGET_I386) && !defined(TARGET_ABI32)
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
-	abi_ulong	st_dev;
-	abi_ulong	st_ino;
-	abi_ulong	st_nlink;
+    abi_ulong       st_dev;
+    abi_ulong       st_ino;
+    abi_ulong       st_nlink;
 
-	unsigned int	st_mode;
-	unsigned int	st_uid;
-	unsigned int	st_gid;
-	unsigned int	__pad0;
-	abi_ulong	st_rdev;
-	abi_long	st_size;
-	abi_long	st_blksize;
-	abi_long	st_blocks;	/* Number 512-byte blocks allocated. */
+    unsigned int    st_mode;
+    unsigned int    st_uid;
+    unsigned int    st_gid;
+    unsigned int    __pad0;
+    abi_ulong       st_rdev;
+    abi_long        st_size;
+    abi_long        st_blksize;
+    abi_long        st_blocks;      /* Number 512-byte blocks allocated. */
 
-	abi_ulong	target_st_atime;
-	abi_ulong 	target_st_atime_nsec; 
-	abi_ulong	target_st_mtime;
-	abi_ulong	target_st_mtime_nsec;
-	abi_ulong	target_st_ctime;
-	abi_ulong       target_st_ctime_nsec;
+    abi_ulong       target_st_atime;
+    abi_ulong       target_st_atime_nsec;
+    abi_ulong       target_st_mtime;
+    abi_ulong       target_st_mtime_nsec;
+    abi_ulong       target_st_ctime;
+    abi_ulong       target_st_ctime_nsec;
 
-	abi_long	__unused[3];
+    abi_long        __unused[3];
 };
 #elif defined(TARGET_S390X)
 struct target_stat {
@@ -2090,7 +2090,7 @@ struct target_stat64  {
 };
 
 #elif defined(TARGET_OPENRISC) || defined(TARGET_NIOS2) \
-        || defined(TARGET_RISCV) || defined(TARGET_HEXAGON)
+    || defined(TARGET_RISCV) || defined(TARGET_HEXAGON)
 
 /* These are the asm-generic versions of the stat and stat64 structures */
 
@@ -2210,93 +2210,93 @@ struct target_stat64 {
 #endif
 
 typedef struct {
-        int     val[2];
+    int     val[2];
 } target_fsid_t;
 
 #ifdef TARGET_MIPS
 #ifdef TARGET_ABI_MIPSN32
 struct target_statfs {
-	int32_t			f_type;
-	int32_t			f_bsize;
-	int32_t			f_frsize;	/* Fragment size - unsupported */
-	int32_t			f_blocks;
-	int32_t			f_bfree;
-	int32_t			f_files;
-	int32_t			f_ffree;
-	int32_t			f_bavail;
+    int32_t                 f_type;
+    int32_t                 f_bsize;
+    int32_t                 f_frsize;       /* Fragment size - unsupported */
+    int32_t                 f_blocks;
+    int32_t                 f_bfree;
+    int32_t                 f_files;
+    int32_t                 f_ffree;
+    int32_t                 f_bavail;
 
-	/* Linux specials */
-	target_fsid_t		f_fsid;
-	int32_t			f_namelen;
-	int32_t			f_flags;
-	int32_t			f_spare[5];
+    /* Linux specials */
+    target_fsid_t           f_fsid;
+    int32_t                 f_namelen;
+    int32_t                 f_flags;
+    int32_t                 f_spare[5];
 };
 #else
 struct target_statfs {
-	abi_long		f_type;
-	abi_long		f_bsize;
-	abi_long		f_frsize;	/* Fragment size - unsupported */
-	abi_long		f_blocks;
-	abi_long		f_bfree;
-	abi_long		f_files;
-	abi_long		f_ffree;
-	abi_long		f_bavail;
+    abi_long                f_type;
+    abi_long                f_bsize;
+    abi_long                f_frsize;       /* Fragment size - unsupported */
+    abi_long                f_blocks;
+    abi_long                f_bfree;
+    abi_long                f_files;
+    abi_long                f_ffree;
+    abi_long                f_bavail;
 
-	/* Linux specials */
-	target_fsid_t		f_fsid;
-	abi_long		f_namelen;
-	abi_long		f_flags;
-	abi_long		f_spare[5];
+    /* Linux specials */
+    target_fsid_t           f_fsid;
+    abi_long                f_namelen;
+    abi_long                f_flags;
+    abi_long                f_spare[5];
 };
 #endif
 
 struct target_statfs64 {
-	uint32_t	f_type;
-	uint32_t	f_bsize;
-	uint32_t	f_frsize;	/* Fragment size - unsupported */
-	uint32_t	__pad;
-	uint64_t	f_blocks;
-	uint64_t	f_bfree;
-	uint64_t	f_files;
-	uint64_t	f_ffree;
-	uint64_t	f_bavail;
-	target_fsid_t	f_fsid;
-	uint32_t	f_namelen;
-	uint32_t	f_flags;
-	uint32_t	f_spare[5];
+    uint32_t        f_type;
+    uint32_t        f_bsize;
+    uint32_t        f_frsize;       /* Fragment size - unsupported */
+    uint32_t        __pad;
+    uint64_t        f_blocks;
+    uint64_t        f_bfree;
+    uint64_t        f_files;
+    uint64_t        f_ffree;
+    uint64_t        f_bavail;
+    target_fsid_t   f_fsid;
+    uint32_t        f_namelen;
+    uint32_t        f_flags;
+    uint32_t        f_spare[5];
 };
-#elif (defined(TARGET_PPC64) || defined(TARGET_X86_64) || \
-       defined(TARGET_SPARC64) || defined(TARGET_AARCH64) || \
+#elif (defined(TARGET_PPC64) || defined(TARGET_X86_64) ||       \
+       defined(TARGET_SPARC64) || defined(TARGET_AARCH64) ||    \
        defined(TARGET_RISCV) || defined(TARGET_LOONGARCH64)) && \
-       !defined(TARGET_ABI32)
+    !defined(TARGET_ABI32)
 struct target_statfs {
-	abi_long f_type;
-	abi_long f_bsize;
-	abi_long f_blocks;
-	abi_long f_bfree;
-	abi_long f_bavail;
-	abi_long f_files;
-	abi_long f_ffree;
-	target_fsid_t f_fsid;
-	abi_long f_namelen;
-	abi_long f_frsize;
-	abi_long f_flags;
-	abi_long f_spare[4];
+    abi_long f_type;
+    abi_long f_bsize;
+    abi_long f_blocks;
+    abi_long f_bfree;
+    abi_long f_bavail;
+    abi_long f_files;
+    abi_long f_ffree;
+    target_fsid_t f_fsid;
+    abi_long f_namelen;
+    abi_long f_frsize;
+    abi_long f_flags;
+    abi_long f_spare[4];
 };
 
 struct target_statfs64 {
-	abi_long f_type;
-	abi_long f_bsize;
-	abi_long f_blocks;
-	abi_long f_bfree;
-	abi_long f_bavail;
-	abi_long f_files;
-	abi_long f_ffree;
-	target_fsid_t f_fsid;
-	abi_long f_namelen;
-	abi_long f_frsize;
-	abi_long f_flags;
-	abi_long f_spare[4];
+    abi_long f_type;
+    abi_long f_bsize;
+    abi_long f_blocks;
+    abi_long f_bfree;
+    abi_long f_bavail;
+    abi_long f_files;
+    abi_long f_ffree;
+    target_fsid_t f_fsid;
+    abi_long f_namelen;
+    abi_long f_frsize;
+    abi_long f_flags;
+    abi_long f_spare[4];
 };
 #elif defined(TARGET_S390X)
 struct target_statfs {
@@ -2331,33 +2331,33 @@ struct target_statfs64 {
 };
 #else
 struct target_statfs {
-	uint32_t f_type;
-	uint32_t f_bsize;
-	uint32_t f_blocks;
-	uint32_t f_bfree;
-	uint32_t f_bavail;
-	uint32_t f_files;
-	uint32_t f_ffree;
-	target_fsid_t f_fsid;
-	uint32_t f_namelen;
-	uint32_t f_frsize;
-	uint32_t f_flags;
-	uint32_t f_spare[4];
+    uint32_t f_type;
+    uint32_t f_bsize;
+    uint32_t f_blocks;
+    uint32_t f_bfree;
+    uint32_t f_bavail;
+    uint32_t f_files;
+    uint32_t f_ffree;
+    target_fsid_t f_fsid;
+    uint32_t f_namelen;
+    uint32_t f_frsize;
+    uint32_t f_flags;
+    uint32_t f_spare[4];
 };
 
 struct target_statfs64 {
-	uint32_t f_type;
-	uint32_t f_bsize;
-	uint64_t f_blocks;
-	uint64_t f_bfree;
-	uint64_t f_bavail;
-	uint64_t f_files;
-	uint64_t f_ffree;
-	target_fsid_t f_fsid;
-        uint32_t f_namelen;
-	uint32_t f_frsize;
-	uint32_t f_flags;
-	uint32_t f_spare[4];
+    uint32_t f_type;
+    uint32_t f_bsize;
+    uint64_t f_blocks;
+    uint64_t f_bfree;
+    uint64_t f_bavail;
+    uint64_t f_files;
+    uint64_t f_ffree;
+    target_fsid_t f_fsid;
+    uint32_t f_namelen;
+    uint32_t f_frsize;
+    uint32_t f_flags;
+    uint32_t f_spare[4];
 };
 #endif
 
@@ -2454,63 +2454,63 @@ struct target_statfs64 {
 #define TARGET_SOUND_MIXER_PRIVATE4       TARGET_IOWR('M', 114, int)
 #define TARGET_SOUND_MIXER_PRIVATE5       TARGET_IOWR('M', 115, int)
 
-#define TARGET_MIXER_READ(dev)	TARGET_IOR('M', dev, int)
+#define TARGET_MIXER_READ(dev)  TARGET_IOR('M', dev, int)
 
-#define TARGET_SOUND_MIXER_READ_VOLUME		TARGET_MIXER_READ(SOUND_MIXER_VOLUME)
-#define TARGET_SOUND_MIXER_READ_BASS		TARGET_MIXER_READ(SOUND_MIXER_BASS)
-#define TARGET_SOUND_MIXER_READ_TREBLE		TARGET_MIXER_READ(SOUND_MIXER_TREBLE)
-#define TARGET_SOUND_MIXER_READ_SYNTH		TARGET_MIXER_READ(SOUND_MIXER_SYNTH)
-#define TARGET_SOUND_MIXER_READ_PCM		TARGET_MIXER_READ(SOUND_MIXER_PCM)
-#define TARGET_SOUND_MIXER_READ_SPEAKER	        TARGET_MIXER_READ(SOUND_MIXER_SPEAKER)
-#define TARGET_SOUND_MIXER_READ_LINE		TARGET_MIXER_READ(SOUND_MIXER_LINE)
-#define TARGET_SOUND_MIXER_READ_MIC		TARGET_MIXER_READ(SOUND_MIXER_MIC)
-#define TARGET_SOUND_MIXER_READ_CD		TARGET_MIXER_READ(SOUND_MIXER_CD)
-#define TARGET_SOUND_MIXER_READ_IMIX		TARGET_MIXER_READ(SOUND_MIXER_IMIX)
-#define TARGET_SOUND_MIXER_READ_ALTPCM		TARGET_MIXER_READ(SOUND_MIXER_ALTPCM)
-#define TARGET_SOUND_MIXER_READ_RECLEV		TARGET_MIXER_READ(SOUND_MIXER_RECLEV)
-#define TARGET_SOUND_MIXER_READ_IGAIN		TARGET_MIXER_READ(SOUND_MIXER_IGAIN)
-#define TARGET_SOUND_MIXER_READ_OGAIN		TARGET_MIXER_READ(SOUND_MIXER_OGAIN)
-#define TARGET_SOUND_MIXER_READ_LINE1		TARGET_MIXER_READ(SOUND_MIXER_LINE1)
-#define TARGET_SOUND_MIXER_READ_LINE2		TARGET_MIXER_READ(SOUND_MIXER_LINE2)
-#define TARGET_SOUND_MIXER_READ_LINE3		TARGET_MIXER_READ(SOUND_MIXER_LINE3)
+#define TARGET_SOUND_MIXER_READ_VOLUME          TARGET_MIXER_READ(SOUND_MIXER_VOLUME)
+#define TARGET_SOUND_MIXER_READ_BASS            TARGET_MIXER_READ(SOUND_MIXER_BASS)
+#define TARGET_SOUND_MIXER_READ_TREBLE          TARGET_MIXER_READ(SOUND_MIXER_TREBLE)
+#define TARGET_SOUND_MIXER_READ_SYNTH           TARGET_MIXER_READ(SOUND_MIXER_SYNTH)
+#define TARGET_SOUND_MIXER_READ_PCM             TARGET_MIXER_READ(SOUND_MIXER_PCM)
+#define TARGET_SOUND_MIXER_READ_SPEAKER         TARGET_MIXER_READ(SOUND_MIXER_SPEAKER)
+#define TARGET_SOUND_MIXER_READ_LINE            TARGET_MIXER_READ(SOUND_MIXER_LINE)
+#define TARGET_SOUND_MIXER_READ_MIC             TARGET_MIXER_READ(SOUND_MIXER_MIC)
+#define TARGET_SOUND_MIXER_READ_CD              TARGET_MIXER_READ(SOUND_MIXER_CD)
+#define TARGET_SOUND_MIXER_READ_IMIX            TARGET_MIXER_READ(SOUND_MIXER_IMIX)
+#define TARGET_SOUND_MIXER_READ_ALTPCM          TARGET_MIXER_READ(SOUND_MIXER_ALTPCM)
+#define TARGET_SOUND_MIXER_READ_RECLEV          TARGET_MIXER_READ(SOUND_MIXER_RECLEV)
+#define TARGET_SOUND_MIXER_READ_IGAIN           TARGET_MIXER_READ(SOUND_MIXER_IGAIN)
+#define TARGET_SOUND_MIXER_READ_OGAIN           TARGET_MIXER_READ(SOUND_MIXER_OGAIN)
+#define TARGET_SOUND_MIXER_READ_LINE1           TARGET_MIXER_READ(SOUND_MIXER_LINE1)
+#define TARGET_SOUND_MIXER_READ_LINE2           TARGET_MIXER_READ(SOUND_MIXER_LINE2)
+#define TARGET_SOUND_MIXER_READ_LINE3           TARGET_MIXER_READ(SOUND_MIXER_LINE3)
 
 /* Obsolete macros */
-#define TARGET_SOUND_MIXER_READ_MUTE		TARGET_MIXER_READ(SOUND_MIXER_MUTE)
-#define TARGET_SOUND_MIXER_READ_ENHANCE	        TARGET_MIXER_READ(SOUND_MIXER_ENHANCE)
-#define TARGET_SOUND_MIXER_READ_LOUD		TARGET_MIXER_READ(SOUND_MIXER_LOUD)
+#define TARGET_SOUND_MIXER_READ_MUTE            TARGET_MIXER_READ(SOUND_MIXER_MUTE)
+#define TARGET_SOUND_MIXER_READ_ENHANCE         TARGET_MIXER_READ(SOUND_MIXER_ENHANCE)
+#define TARGET_SOUND_MIXER_READ_LOUD            TARGET_MIXER_READ(SOUND_MIXER_LOUD)
 
-#define TARGET_SOUND_MIXER_READ_RECSRC		TARGET_MIXER_READ(SOUND_MIXER_RECSRC)
-#define TARGET_SOUND_MIXER_READ_DEVMASK	        TARGET_MIXER_READ(SOUND_MIXER_DEVMASK)
-#define TARGET_SOUND_MIXER_READ_RECMASK	        TARGET_MIXER_READ(SOUND_MIXER_RECMASK)
-#define TARGET_SOUND_MIXER_READ_STEREODEVS	TARGET_MIXER_READ(SOUND_MIXER_STEREODEVS)
-#define TARGET_SOUND_MIXER_READ_CAPS		TARGET_MIXER_READ(SOUND_MIXER_CAPS)
+#define TARGET_SOUND_MIXER_READ_RECSRC          TARGET_MIXER_READ(SOUND_MIXER_RECSRC)
+#define TARGET_SOUND_MIXER_READ_DEVMASK         TARGET_MIXER_READ(SOUND_MIXER_DEVMASK)
+#define TARGET_SOUND_MIXER_READ_RECMASK         TARGET_MIXER_READ(SOUND_MIXER_RECMASK)
+#define TARGET_SOUND_MIXER_READ_STEREODEVS      TARGET_MIXER_READ(SOUND_MIXER_STEREODEVS)
+#define TARGET_SOUND_MIXER_READ_CAPS            TARGET_MIXER_READ(SOUND_MIXER_CAPS)
 
-#define TARGET_MIXER_WRITE(dev)		TARGET_IOWR('M', dev, int)
+#define TARGET_MIXER_WRITE(dev)         TARGET_IOWR('M', dev, int)
 
-#define TARGET_SOUND_MIXER_WRITE_VOLUME	TARGET_MIXER_WRITE(SOUND_MIXER_VOLUME)
-#define TARGET_SOUND_MIXER_WRITE_BASS		TARGET_MIXER_WRITE(SOUND_MIXER_BASS)
-#define TARGET_SOUND_MIXER_WRITE_TREBLE	TARGET_MIXER_WRITE(SOUND_MIXER_TREBLE)
-#define TARGET_SOUND_MIXER_WRITE_SYNTH		TARGET_MIXER_WRITE(SOUND_MIXER_SYNTH)
-#define TARGET_SOUND_MIXER_WRITE_PCM		TARGET_MIXER_WRITE(SOUND_MIXER_PCM)
-#define TARGET_SOUND_MIXER_WRITE_SPEAKER	TARGET_MIXER_WRITE(SOUND_MIXER_SPEAKER)
-#define TARGET_SOUND_MIXER_WRITE_LINE		TARGET_MIXER_WRITE(SOUND_MIXER_LINE)
-#define TARGET_SOUND_MIXER_WRITE_MIC		TARGET_MIXER_WRITE(SOUND_MIXER_MIC)
-#define TARGET_SOUND_MIXER_WRITE_CD		TARGET_MIXER_WRITE(SOUND_MIXER_CD)
-#define TARGET_SOUND_MIXER_WRITE_IMIX		TARGET_MIXER_WRITE(SOUND_MIXER_IMIX)
-#define TARGET_SOUND_MIXER_WRITE_ALTPCM	TARGET_MIXER_WRITE(SOUND_MIXER_ALTPCM)
-#define TARGET_SOUND_MIXER_WRITE_RECLEV	TARGET_MIXER_WRITE(SOUND_MIXER_RECLEV)
-#define TARGET_SOUND_MIXER_WRITE_IGAIN		TARGET_MIXER_WRITE(SOUND_MIXER_IGAIN)
-#define TARGET_SOUND_MIXER_WRITE_OGAIN		TARGET_MIXER_WRITE(SOUND_MIXER_OGAIN)
-#define TARGET_SOUND_MIXER_WRITE_LINE1		TARGET_MIXER_WRITE(SOUND_MIXER_LINE1)
-#define TARGET_SOUND_MIXER_WRITE_LINE2		TARGET_MIXER_WRITE(SOUND_MIXER_LINE2)
-#define TARGET_SOUND_MIXER_WRITE_LINE3		TARGET_MIXER_WRITE(SOUND_MIXER_LINE3)
+#define TARGET_SOUND_MIXER_WRITE_VOLUME TARGET_MIXER_WRITE(SOUND_MIXER_VOLUME)
+#define TARGET_SOUND_MIXER_WRITE_BASS           TARGET_MIXER_WRITE(SOUND_MIXER_BASS)
+#define TARGET_SOUND_MIXER_WRITE_TREBLE TARGET_MIXER_WRITE(SOUND_MIXER_TREBLE)
+#define TARGET_SOUND_MIXER_WRITE_SYNTH          TARGET_MIXER_WRITE(SOUND_MIXER_SYNTH)
+#define TARGET_SOUND_MIXER_WRITE_PCM            TARGET_MIXER_WRITE(SOUND_MIXER_PCM)
+#define TARGET_SOUND_MIXER_WRITE_SPEAKER        TARGET_MIXER_WRITE(SOUND_MIXER_SPEAKER)
+#define TARGET_SOUND_MIXER_WRITE_LINE           TARGET_MIXER_WRITE(SOUND_MIXER_LINE)
+#define TARGET_SOUND_MIXER_WRITE_MIC            TARGET_MIXER_WRITE(SOUND_MIXER_MIC)
+#define TARGET_SOUND_MIXER_WRITE_CD             TARGET_MIXER_WRITE(SOUND_MIXER_CD)
+#define TARGET_SOUND_MIXER_WRITE_IMIX           TARGET_MIXER_WRITE(SOUND_MIXER_IMIX)
+#define TARGET_SOUND_MIXER_WRITE_ALTPCM TARGET_MIXER_WRITE(SOUND_MIXER_ALTPCM)
+#define TARGET_SOUND_MIXER_WRITE_RECLEV TARGET_MIXER_WRITE(SOUND_MIXER_RECLEV)
+#define TARGET_SOUND_MIXER_WRITE_IGAIN          TARGET_MIXER_WRITE(SOUND_MIXER_IGAIN)
+#define TARGET_SOUND_MIXER_WRITE_OGAIN          TARGET_MIXER_WRITE(SOUND_MIXER_OGAIN)
+#define TARGET_SOUND_MIXER_WRITE_LINE1          TARGET_MIXER_WRITE(SOUND_MIXER_LINE1)
+#define TARGET_SOUND_MIXER_WRITE_LINE2          TARGET_MIXER_WRITE(SOUND_MIXER_LINE2)
+#define TARGET_SOUND_MIXER_WRITE_LINE3          TARGET_MIXER_WRITE(SOUND_MIXER_LINE3)
 
 /* Obsolete macros */
-#define TARGET_SOUND_MIXER_WRITE_MUTE		TARGET_MIXER_WRITE(SOUND_MIXER_MUTE)
-#define TARGET_SOUND_MIXER_WRITE_ENHANCE	TARGET_MIXER_WRITE(SOUND_MIXER_ENHANCE)
-#define TARGET_SOUND_MIXER_WRITE_LOUD		TARGET_MIXER_WRITE(SOUND_MIXER_LOUD)
+#define TARGET_SOUND_MIXER_WRITE_MUTE           TARGET_MIXER_WRITE(SOUND_MIXER_MUTE)
+#define TARGET_SOUND_MIXER_WRITE_ENHANCE        TARGET_MIXER_WRITE(SOUND_MIXER_ENHANCE)
+#define TARGET_SOUND_MIXER_WRITE_LOUD           TARGET_MIXER_WRITE(SOUND_MIXER_LOUD)
 
-#define TARGET_SOUND_MIXER_WRITE_RECSRC	TARGET_MIXER_WRITE(SOUND_MIXER_RECSRC)
+#define TARGET_SOUND_MIXER_WRITE_RECSRC TARGET_MIXER_WRITE(SOUND_MIXER_RECSRC)
 
 struct target_snd_timer_id {
     int dev_class;
@@ -2575,22 +2575,22 @@ struct target_snd_timer_status {
 
 /* alsa timer ioctls */
 #define TARGET_SNDRV_TIMER_IOCTL_PVERSION     TARGET_IOR('T', 0x00, int)
-#define TARGET_SNDRV_TIMER_IOCTL_NEXT_DEVICE  TARGET_IOWR('T', 0x01,           \
-                                                struct snd_timer_id)
-#define TARGET_SNDRV_TIMER_IOCTL_GINFO        TARGET_IOWR('T', 0x03,           \
-                                                struct target_snd_timer_ginfo)
-#define TARGET_SNDRV_TIMER_IOCTL_GPARAMS      TARGET_IOW('T', 0x04,            \
-                                                struct target_snd_timer_gparams)
-#define TARGET_SNDRV_TIMER_IOCTL_GSTATUS      TARGET_IOWR('T', 0x05,           \
-                                                struct target_snd_timer_gstatus)
-#define TARGET_SNDRV_TIMER_IOCTL_SELECT       TARGET_IOW('T', 0x10,            \
-                                                struct target_snd_timer_select)
-#define TARGET_SNDRV_TIMER_IOCTL_INFO         TARGET_IOR('T', 0x11,            \
-                                                struct target_snd_timer_info)
-#define TARGET_SNDRV_TIMER_IOCTL_PARAMS       TARGET_IOW('T', 0x12,            \
-                                                struct snd_timer_params)
-#define TARGET_SNDRV_TIMER_IOCTL_STATUS       TARGET_IOR('T', 0x14,            \
-                                                struct target_snd_timer_status)
+#define TARGET_SNDRV_TIMER_IOCTL_NEXT_DEVICE  TARGET_IOWR('T', 0x01,    \
+                                                          struct snd_timer_id)
+#define TARGET_SNDRV_TIMER_IOCTL_GINFO        TARGET_IOWR('T', 0x03,    \
+                                                          struct target_snd_timer_ginfo)
+#define TARGET_SNDRV_TIMER_IOCTL_GPARAMS      TARGET_IOW('T', 0x04,     \
+                                                         struct target_snd_timer_gparams)
+#define TARGET_SNDRV_TIMER_IOCTL_GSTATUS      TARGET_IOWR('T', 0x05,    \
+                                                          struct target_snd_timer_gstatus)
+#define TARGET_SNDRV_TIMER_IOCTL_SELECT       TARGET_IOW('T', 0x10,     \
+                                                         struct target_snd_timer_select)
+#define TARGET_SNDRV_TIMER_IOCTL_INFO         TARGET_IOR('T', 0x11,     \
+                                                         struct target_snd_timer_info)
+#define TARGET_SNDRV_TIMER_IOCTL_PARAMS       TARGET_IOW('T', 0x12,     \
+                                                         struct snd_timer_params)
+#define TARGET_SNDRV_TIMER_IOCTL_STATUS       TARGET_IOR('T', 0x14,     \
+                                                         struct target_snd_timer_status)
 #define TARGET_SNDRV_TIMER_IOCTL_START        TARGET_IO('T', 0xa0)
 #define TARGET_SNDRV_TIMER_IOCTL_STOP         TARGET_IO('T', 0xa1)
 #define TARGET_SNDRV_TIMER_IOCTL_CONTINUE     TARGET_IO('T', 0xa2)
@@ -2750,12 +2750,12 @@ typedef int32_t target_timer_t;
 #ifdef TARGET_MIPS
 #define TARGET_SIGEV_PREAMBLE_SIZE (sizeof(int32_t) * 2 + sizeof(abi_long))
 #else
-#define TARGET_SIGEV_PREAMBLE_SIZE (sizeof(int32_t) * 2 \
+#define TARGET_SIGEV_PREAMBLE_SIZE (sizeof(int32_t) * 2         \
                                     + sizeof(target_sigval_t))
 #endif
 
-#define TARGET_SIGEV_PAD_SIZE ((TARGET_SIGEV_MAX_SIZE \
-                                - TARGET_SIGEV_PREAMBLE_SIZE) \
+#define TARGET_SIGEV_PAD_SIZE ((TARGET_SIGEV_MAX_SIZE           \
+                                - TARGET_SIGEV_PREAMBLE_SIZE)   \
                                / sizeof(int32_t))
 
 struct target_sigevent {
@@ -2814,40 +2814,40 @@ struct target_user_cap_data {
 #define TARGET_SYSLOG_ACTION_SIZE_BUFFER   10
 
 struct target_statx_timestamp {
-   int64_t tv_sec;
-   uint32_t tv_nsec;
-   int32_t __reserved;
+    int64_t tv_sec;
+    uint32_t tv_nsec;
+    int32_t __reserved;
 };
 
 struct target_statx {
-   /* 0x00 */
-   uint32_t stx_mask;       /* What results were written [uncond] */
-   uint32_t stx_blksize;    /* Preferred general I/O size [uncond] */
-   uint64_t stx_attributes; /* Flags conveying information about the file */
-   /* 0x10 */
-   uint32_t stx_nlink;      /* Number of hard links */
-   uint32_t stx_uid;        /* User ID of owner */
-   uint32_t stx_gid;        /* Group ID of owner */
-   uint16_t stx_mode;       /* File mode */
-   uint16_t __spare0[1];
-   /* 0x20 */
-   uint64_t stx_ino;        /* Inode number */
-   uint64_t stx_size;       /* File size */
-   uint64_t stx_blocks;     /* Number of 512-byte blocks allocated */
-   uint64_t stx_attributes_mask; /* Mask to show what is supported */
-   /* 0x40 */
-   struct target_statx_timestamp  stx_atime;  /* Last access time */
-   struct target_statx_timestamp  stx_btime;  /* File creation time */
-   struct target_statx_timestamp  stx_ctime;  /* Last attribute change time */
-   struct target_statx_timestamp  stx_mtime;  /* Last data modification time */
-   /* 0x80 */
-   uint32_t stx_rdev_major;   /* Device ID of special file [if bdev/cdev] */
-   uint32_t stx_rdev_minor;
-   uint32_t stx_dev_major; /* ID of device containing file [uncond] */
-   uint32_t stx_dev_minor;
-   /* 0x90 */
-   uint64_t __spare2[14];  /* Spare space for future expansion */
-   /* 0x100 */
+    /* 0x00 */
+    uint32_t stx_mask;       /* What results were written [uncond] */
+    uint32_t stx_blksize;    /* Preferred general I/O size [uncond] */
+    uint64_t stx_attributes; /* Flags conveying information about the file */
+    /* 0x10 */
+    uint32_t stx_nlink;      /* Number of hard links */
+    uint32_t stx_uid;        /* User ID of owner */
+    uint32_t stx_gid;        /* Group ID of owner */
+    uint16_t stx_mode;       /* File mode */
+    uint16_t __spare0[1];
+    /* 0x20 */
+    uint64_t stx_ino;        /* Inode number */
+    uint64_t stx_size;       /* File size */
+    uint64_t stx_blocks;     /* Number of 512-byte blocks allocated */
+    uint64_t stx_attributes_mask; /* Mask to show what is supported */
+    /* 0x40 */
+    struct target_statx_timestamp  stx_atime;  /* Last access time */
+    struct target_statx_timestamp  stx_btime;  /* File creation time */
+    struct target_statx_timestamp  stx_ctime;  /* Last attribute change time */
+    struct target_statx_timestamp  stx_mtime;  /* Last data modification time */
+    /* 0x80 */
+    uint32_t stx_rdev_major;   /* Device ID of special file [if bdev/cdev] */
+    uint32_t stx_rdev_minor;
+    uint32_t stx_dev_major; /* ID of device containing file [uncond] */
+    uint32_t stx_dev_minor;
+    /* 0x90 */
+    uint64_t __spare2[14];  /* Spare space for future expansion */
+    /* 0x100 */
 };
 
 /* from kernel's include/linux/sched/types.h */
-- 
2.34.1


