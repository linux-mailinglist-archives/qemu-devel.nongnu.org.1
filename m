Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C6F78B93B
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:12:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiaY-0006kE-Av; Mon, 28 Aug 2023 16:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiaO-0005xA-EO
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:45 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiaM-0007qf-8b
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:44 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99c4923195dso446179966b.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253501; x=1693858301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Ypl95QnqSChBkm9Ln1newySi5XDxhD4faX84DGp29A=;
 b=MjAulb6XDnJU1vp2NEnHfrZv4+OWGUInfu2ra5KUqfQ1Boacij56+41IvJEpZhpxn4
 NhaeobeGODRQlKnTzsE8/ybYZCublxL0IQMPMz0zzv3eC02rGw+pEeb85Gnxh4sgftdV
 ZKPH5wm97l0DavSoTAvcl6s7jlCZs6vYSupPTdCYBTofLjSoEGqLmxbO6d1hQ6WHzIT1
 bSq9Uo1rZwqW8sJetraX2qpj3m9KMVQ4mGG4uo6lFZI+TmyUItvr+nv1K3Y9jPV4zb6r
 SOH4tjvwc21hrfnU6MzYbtuTYdGtU/bFj/uopM7Sq/uMNjEFjsm3XHN/rlZvcMfye7W0
 97JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253501; x=1693858301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Ypl95QnqSChBkm9Ln1newySi5XDxhD4faX84DGp29A=;
 b=Fif0x8QWsAxdg50c4BLe4zkrVNxNhZZqUO81shCA7i4oo/JtMuppY5JTsI7fxIUbrJ
 TSbbqce/wlc713P6iKZnSzmymxhaDyliFj9wvMS6DdXOuZaV3W6EMaOrpPomHHGg+pNp
 vdKSRTPDojcyLqWG3ivULKYCA8L74x4ir2dbVu0YaVuVftd33KGr/6IHmIEQpG9vADfl
 BpbULB/yEQ+JgXBncRsjcktuekt1qxv+98PO1BFPkdfnLV8TynuxdZ5PMGYau87egDxM
 RWE55BWaRwUE7Eyasp1z/sFGiAJPZIpFnlctr2rJgW/pjdYJ2BqOM+nhq+2e+dSkps+3
 6GjA==
X-Gm-Message-State: AOJu0YylMljQpC6h6nRgULIUn5/Pgb8dZ964vpx//VUY4ucSkQsRfR+i
 Vtchd0rrCVJsHTUUxjQKx8GsjnfbzSAkcw==
X-Google-Smtp-Source: AGHT+IHP6q8GvNxPOIz9BbvG8MZeiVVqOIVI/gDBYBnf3WhOqIW2TSHhzCNnp2VJ3X8h5de9ZMwxaQ==
X-Received: by 2002:a17:906:5392:b0:9a1:debe:6b9b with SMTP id
 g18-20020a170906539200b009a1debe6b9bmr11693642ejo.35.1693253500489; 
 Mon, 28 Aug 2023 13:11:40 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:11:40 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 31/32] bsd-user: Implement rfork(2) system call.
Date: Sun, 27 Aug 2023 17:57:45 +0200
Message-Id: <20230827155746.84781-32-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.h    | 38 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 42 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 385fc15adf..94824d737a 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -210,4 +210,42 @@ static inline abi_long do_freebsd_vfork(void *cpu_env)
     return do_freebsd_fork(cpu_env);
 }
 
+/* rfork(2) */
+static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
+{
+    abi_long ret;
+    abi_ulong child_flag;
+
+    /*
+     * XXX We need to handle RFMEM here, as well.  Neither are safe to execute
+     * as-is on x86 hosts because they'll split memory but not the stack,
+     * wreaking havoc on host architectures that use the stack to store the
+     * return address as both threads try to pop it off.  Rejecting RFSPAWN
+     * entirely for now is ok, the only consumer at the moment is posix_spawn
+     * and it will fall back to classic vfork(2) if we return EINVAL.
+     */
+    if ((flags & TARGET_RFSPAWN) != 0)
+        return -TARGET_EINVAL;
+    fork_start();
+    ret = rfork(flags);
+    if (ret == 0) {
+        /* child */
+        child_flag = 1;
+        target_cpu_clone_regs(cpu_env, 0);
+    } else {
+        /* parent */
+        child_flag = 0;
+    }
+
+    /*
+     * The fork system call sets a child flag in the second return
+     * value: 0 for parent process, 1 for child process.
+     */
+    set_second_rval(cpu_env, child_flag);
+    fork_end(child_flag);
+
+    return ret;
+
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 84c9bffff5..4464b3369c 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -232,6 +232,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_vfork(cpu_env);
         break;
 
+    case TARGET_FREEBSD_NR_rfork: /* rfork(2) */
+        ret = do_freebsd_rfork(cpu_env, arg1);
+        break;
+
     case TARGET_FREEBSD_NR_execve: /* execve(2) */
         ret = do_freebsd_execve(arg1, arg2, arg3);
         break;
-- 
2.40.0


