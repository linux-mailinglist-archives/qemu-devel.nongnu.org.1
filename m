Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AB3718A89
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 21:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Ro7-00014j-Ha; Wed, 31 May 2023 15:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4Ro5-00014H-3B
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4Ro3-0002ZW-FV
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685562506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOQ3qUI6u0ZiSdZl/ogv+WP+K/JrIOYVS2c+U3Wz4Bc=;
 b=Q/RcYnsGP145fFihcWuc7LEpbjVkKMpf3eF4X3TC8ZopKk1mTsyMw0/WkX9cxdCQbQSXnM
 imik2o/8Rk2NCBFF1KEkTfU4DeMK/uLw+giZA8/q36dYTGXkTQc9pEfObl7wHp48NR1cPi
 Uou1yN9MKQA8FXJJk+xSG+ir2Fvia2U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-14OD7mFjPgeDmnFarueAHA-1; Wed, 31 May 2023 15:48:21 -0400
X-MC-Unique: 14OD7mFjPgeDmnFarueAHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E85BF85A5BE;
 Wed, 31 May 2023 19:48:20 +0000 (UTC)
Received: from localhost (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A81A40CFD45;
 Wed, 31 May 2023 19:48:20 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Warner Losh <imp@bsdimp.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, libvir-list@redhat.com,
 Greg Kurz <groug@kaod.org>, Yanan Wang <wangyanan55@huawei.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 01/11] *-user: remove the guest_user_syscall tracepoints
Date: Wed, 31 May 2023 15:48:05 -0400
Message-Id: <20230531194815.1508961-2-stefanha@redhat.com>
In-Reply-To: <20230531194815.1508961-1-stefanha@redhat.com>
References: <20230531194815.1508961-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Alex Bennée <alex.bennee@linaro.org>

This is pure duplication now. Both bsd-user and linux-user have
builtin strace support and we can also track syscalls via the plugins
system.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20230526165401.574474-2-alex.bennee@linaro.org
Message-Id: <20230524133952.3971948-2-alex.bennee@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.40.1


