Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 374FB70F7E0
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 15:41:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1oim-0008S2-Ex; Wed, 24 May 2023 09:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1oid-0008Ck-96
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:40:01 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1oia-0003la-Jm
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:39:58 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3078cc99232so838672f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684935594; x=1687527594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VrRa3Xy6DTZtfJYVIdsX3CmIb/NP6vmSmbITjRkKdS4=;
 b=Ypc3l46t2R84xQ8C/QGyYmD7k3C78NAyl6rI/RHp8QlQTDtQDvOcBQHZSN7jthuSWO
 qNZffMqnP+OX0BF7AB0ALSh96Zmi7YKc7kgZFtiRGmqDe+TUsPNF6w4a590r/3xBsVlf
 Ulk8mLzRV8pVAm5Iw1u5e3bplZWQMML7lmSNr3Bc/cmA1v4SGM5dVwF78kYXT5X/5jmb
 kZkzam2HSzIGq/SKgXe/Sb4lCzTfCA7WkpSmDR4fD1TlpAlymt/00HpvMZ/ZIGLJmx/j
 Wt5k21qDUyKtgmB8NGXyj0wKq6b/opaDdaz9za16llw1ATIqs9Pir/iL04slCJVKLOV1
 39ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684935594; x=1687527594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VrRa3Xy6DTZtfJYVIdsX3CmIb/NP6vmSmbITjRkKdS4=;
 b=jalPal/V8oDoW/ckhuBGT4/WdFxfn86Ct4UKcoL95OQhKzvD7lbwr0bu9cOS+zr6V7
 NmEDUWuo4oNqgmgK+Lvj+44Tl6VUbv/INEKTwOkZ/WO6sO1j9WBVpl9NrbKwl0IfDxJc
 XFAJQpeqrNtN9LV4co7Pukn6nIZBdZvOePgwR3+RZeD8YhOOIeneADSiYhzt+btLkvoX
 YIHXgOeJUSMZRmFEJ3lWig+yt5X2Xjj4x3DXvaPV4Tz42/0ZkcdqeeNuXSjogl5MTS2O
 EguYVNCJtA5uvVjEnW5g3lV3xsp2GFcQ7MGhSgBP5WCr8MS4HBPOszyNpa4xQZ/Yodvn
 h5sA==
X-Gm-Message-State: AC+VfDyVTVjcKcjUK2QC0tJRfyy5jl3F41hw1l8Yt+uImQhHs+YxAlJK
 nPZrhjqS8mpusnbQyT828QO5Lg==
X-Google-Smtp-Source: ACHHUZ59bLDEd7cTkhwBD9YLXA6j5kJW95QvwfMXSAGKQbJPAhzeSUcg4RoTtBvv5lwad2UlmnU5lg==
X-Received: by 2002:adf:ef42:0:b0:307:c0c4:108f with SMTP id
 c2-20020adfef42000000b00307c0c4108fmr13648871wrp.33.1684935593873; 
 Wed, 24 May 2023 06:39:53 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a5d458f000000b003090cb7a9e6sm14550611wrq.31.2023.05.24.06.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 06:39:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0ABB91FFBC;
 Wed, 24 May 2023 14:39:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v5 01/10] *-user: remove the guest_user_syscall tracepoints
Date: Wed, 24 May 2023 14:39:43 +0100
Message-Id: <20230524133952.3971948-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524133952.3971948-1-alex.bennee@linaro.org>
References: <20230524133952.3971948-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

This is pure duplication now. Both bsd-user and linux-user have
builtin strace support and we can also track syscalls via the plugins
system.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230523125000.3674739-2-alex.bennee@linaro.org>
---
 include/user/syscall-trace.h  |  4 ----
 bsd-user/freebsd/os-syscall.c |  2 --
 trace-events                  | 19 -------------------
 3 files changed, 25 deletions(-)

diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
index 90bda7631c..557f881a79 100644
--- a/include/user/syscall-trace.h
+++ b/include/user/syscall-trace.h
@@ -26,9 +26,6 @@ static inline void record_syscall_start(void *cpu, int num,
                                         abi_long arg5, abi_long arg6,
                                         abi_long arg7, abi_long arg8)
 {
-    trace_guest_user_syscall(cpu, num,
-                             arg1, arg2, arg3, arg4,
-                             arg5, arg6, arg7, arg8);
     qemu_plugin_vcpu_syscall(cpu, num,
                              arg1, arg2, arg3, arg4,
                              arg5, arg6, arg7, arg8);
@@ -36,7 +33,6 @@ static inline void record_syscall_start(void *cpu, int num,
 
 static inline void record_syscall_return(void *cpu, int num, abi_long ret)
 {
-    trace_guest_user_syscall_ret(cpu, num, ret);
     qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
 }
 
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index c8f998ecec..b0ae43766f 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -531,7 +531,6 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
     CPUState *cpu = env_cpu(cpu_env);
     abi_long ret;
 
-    trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
     if (do_strace) {
         print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
     }
@@ -541,7 +540,6 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
     if (do_strace) {
         print_freebsd_syscall_ret(num, ret);
     }
-    trace_guest_user_syscall_ret(cpu, num, ret);
 
     return ret;
 }
diff --git a/trace-events b/trace-events
index b6b84b175e..691c3533e4 100644
--- a/trace-events
+++ b/trace-events
@@ -85,22 +85,3 @@ vcpu guest_cpu_exit(void)
 # Targets: all
 vcpu guest_cpu_reset(void)
 
-# include/user/syscall-trace.h
-
-# @num: System call number.
-# @arg*: System call argument value.
-#
-# Start executing a guest system call in syscall emulation mode.
-#
-# Mode: user
-# Targets: TCG(all)
-vcpu guest_user_syscall(uint64_t num, uint64_t arg1, uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t arg7, uint64_t arg8) "num=0x%016"PRIx64" arg1=0x%016"PRIx64" arg2=0x%016"PRIx64" arg3=0x%016"PRIx64" arg4=0x%016"PRIx64" arg5=0x%016"PRIx64" arg6=0x%016"PRIx64" arg7=0x%016"PRIx64" arg8=0x%016"PRIx64
-
-# @num: System call number.
-# @ret: System call result value.
-#
-# Finish executing a guest system call in syscall emulation mode.
-#
-# Mode: user
-# Targets: TCG(all)
-vcpu guest_user_syscall_ret(uint64_t num, uint64_t ret) "num=0x%016"PRIx64" ret=0x%016"PRIx64
-- 
2.39.2


