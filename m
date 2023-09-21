Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 465AC7A92AD
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:37:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFA3-00069n-Q4; Thu, 21 Sep 2023 04:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjF9g-0005vs-DV; Thu, 21 Sep 2023 04:35:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjF9d-0001CC-CP; Thu, 21 Sep 2023 04:35:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7BEEA23DA5;
 Thu, 21 Sep 2023 11:35:33 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2E11E299FF;
 Thu, 21 Sep 2023 11:35:12 +0300 (MSK)
Received: (nullmailer pid 509088 invoked by uid 1000);
 Thu, 21 Sep 2023 08:35:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org,
 Kyle Evans <kevans@FreeBSD.org>, Warner Losh <imp@bsdimp.com>
Subject: [PULL 02/17] bsd-user: spelling fixes
Date: Thu, 21 Sep 2023 11:34:51 +0300
Message-Id: <20230921083506.509032-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230921083506.509032-1-mjt@tls.msk.ru>
References: <20230921083506.509032-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Kyle Evans <kevans@FreeBSD.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/errno_defs.h                | 2 +-
 bsd-user/freebsd/target_os_siginfo.h | 2 +-
 bsd-user/freebsd/target_os_stack.h   | 4 ++--
 bsd-user/freebsd/target_os_user.h    | 2 +-
 bsd-user/qemu.h                      | 2 +-
 bsd-user/signal-common.h             | 4 ++--
 bsd-user/signal.c                    | 6 +++---
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/bsd-user/errno_defs.h b/bsd-user/errno_defs.h
index f3e8ac3488..abe70119d9 100644
--- a/bsd-user/errno_defs.h
+++ b/bsd-user/errno_defs.h
@@ -149,7 +149,7 @@
 #define TARGET_ELAST            90              /* Must be equal largest errno */
 
 /* Internal errors: */
-#define TARGET_EJUSTRETURN      254             /* Just return without modifing regs */
+#define TARGET_EJUSTRETURN      254             /* Just return without modifying regs */
 #define TARGET_ERESTART         255             /* Restart syscall */
 
 #include "special-errno.h"
diff --git a/bsd-user/freebsd/target_os_siginfo.h b/bsd-user/freebsd/target_os_siginfo.h
index 4573738752..6c282d8502 100644
--- a/bsd-user/freebsd/target_os_siginfo.h
+++ b/bsd-user/freebsd/target_os_siginfo.h
@@ -72,7 +72,7 @@ typedef struct target_siginfo {
             int32_t _mqd;
         } _mesgp;
 
-        /* SIGPOLL -- Not really genreated in FreeBSD ??? */
+        /* SIGPOLL -- Not really generated in FreeBSD ??? */
         struct {
             int _band;  /* POLL_IN, POLL_OUT, POLL_MSG */
         } _poll;
diff --git a/bsd-user/freebsd/target_os_stack.h b/bsd-user/freebsd/target_os_stack.h
index 0590133291..d15fc3263f 100644
--- a/bsd-user/freebsd/target_os_stack.h
+++ b/bsd-user/freebsd/target_os_stack.h
@@ -25,7 +25,7 @@
 #include "qemu/guest-random.h"
 
 /*
- * The inital FreeBSD stack is as follows:
+ * The initial FreeBSD stack is as follows:
  * (see kern/kern_exec.c exec_copyout_strings() )
  *
  *  Hi Address -> char **ps_argvstr  (struct ps_strings for ps, w, etc.)
@@ -59,7 +59,7 @@ static inline int setup_initial_stack(struct bsd_binprm *bprm,
     /* Save some space for ps_strings. */
     p -= sizeof(struct target_ps_strings);
 
-    /* Add machine depedent sigcode. */
+    /* Add machine dependent sigcode. */
     p -= TARGET_SZSIGCODE;
     if (setup_sigtramp(p, (unsigned)offsetof(struct target_sigframe, sf_uc),
             TARGET_FREEBSD_NR_sigreturn)) {
diff --git a/bsd-user/freebsd/target_os_user.h b/bsd-user/freebsd/target_os_user.h
index f036a32343..1ca7b5ab17 100644
--- a/bsd-user/freebsd/target_os_user.h
+++ b/bsd-user/freebsd/target_os_user.h
@@ -26,7 +26,7 @@
 struct target_priority {
     uint8_t     pri_class;      /* Scheduling class. */
     uint8_t     pri_level;      /* Normal priority level. */
-    uint8_t     pri_native;     /* Priority before propogation. */
+    uint8_t     pri_native;     /* Priority before propagation. */
     uint8_t     pri_user;       /* User priority based on p_cpu and p_nice. */
 };
 
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index d3158bc2ed..d9507137cc 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -116,7 +116,7 @@ extern const char *qemu_uname_release;
 /*
  * TARGET_ARG_MAX defines the number of bytes allocated for arguments
  * and envelope for the new program. 256k should suffice for a reasonable
- * maxiumum env+arg in 32-bit environments, bump it up to 512k for !ILP32
+ * maximum env+arg in 32-bit environments, bump it up to 512k for !ILP32
  * platforms.
  */
 #if TARGET_ABI_BITS > 32
diff --git a/bsd-user/signal-common.h b/bsd-user/signal-common.h
index 6f90345bb2..c044e81165 100644
--- a/bsd-user/signal-common.h
+++ b/bsd-user/signal-common.h
@@ -49,11 +49,11 @@ void target_to_host_sigset(sigset_t *d, const target_sigset_t *s);
  * union in target_siginfo is valid. This only applies between
  * host_to_target_siginfo_noswap() and tswap_siginfo(); it does not appear
  * either within host siginfo_t or in target_siginfo structures which we get
- * from the guest userspace program. Linux kenrels use this internally, but BSD
+ * from the guest userspace program. Linux kernels use this internally, but BSD
  * kernels don't do this, but its a useful abstraction.
  *
  * The linux-user version of this uses the top 16 bits, but FreeBSD's SI_USER
- * and other signal indepenent SI_ codes have bit 16 set, so we only use the top
+ * and other signal independent SI_ codes have bit 16 set, so we only use the top
  * byte instead.
  *
  * For FreeBSD, we have si_pid, si_uid, si_status, and si_addr always. Linux and
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index 4db85a3485..b6beab659e 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -44,7 +44,7 @@ static inline int sas_ss_flags(TaskState *ts, unsigned long sp)
 }
 
 /*
- * The BSD ABIs use the same singal numbers across all the CPU architectures, so
+ * The BSD ABIs use the same signal numbers across all the CPU architectures, so
  * (unlike Linux) these functions are just the identity mapping. This might not
  * be true for XyzBSD running on AbcBSD, which doesn't currently work.
  */
@@ -241,7 +241,7 @@ static inline void host_to_target_siginfo_noswap(target_siginfo_t *tinfo,
 #endif
         /*
          * Unsure that this can actually be generated, and our support for
-         * capsicum is somewhere between weak and non-existant, but if we get
+         * capsicum is somewhere between weak and non-existent, but if we get
          * one, then we know what to save.
          */
 #ifdef QEMU_SI_CAPSICUM
@@ -319,7 +319,7 @@ int block_signals(void)
     /*
      * It's OK to block everything including SIGSEGV, because we won't run any
      * further guest code before unblocking signals in
-     * process_pending_signals(). We depend on the FreeBSD behaivor here where
+     * process_pending_signals(). We depend on the FreeBSD behavior here where
      * this will only affect this thread's signal mask. We don't use
      * pthread_sigmask which might seem more correct because that routine also
      * does odd things with SIGCANCEL to implement pthread_cancel().
-- 
2.39.2


