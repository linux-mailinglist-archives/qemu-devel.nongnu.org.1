Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F38D712B33
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:56:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ahg-0002yI-8q; Fri, 26 May 2023 12:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2aha-0002vZ-Qj
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:54:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2ahZ-0002Fm-2y
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:54:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f611ccd06eso7185495e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685120043; x=1687712043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JSph40thfd9YqqHizrdfQZmv5A6L4soqJWF31SYGqc=;
 b=TQnAxAayZ/v8EufDD5rMAZOo+wrgQhi/NEuEVxDnwa/rLjw4ef9wF7+e+3IUQfK9CX
 xdzeyhp2YfsyCNXOw/XiwAvU1ZCpvrK+cQoq+xqpdAgdmIRYYJz3V+0Xo8nx89bk4vvU
 au1Kx3ttnLgiTCkB+HtN8hzLg9cAgp36d/WnSHyGwD8IZT2pvxICwLymel9bMX10QK4J
 qty3u8bi40QpxgCAS+rjAH0CvPQVE/1xH4y8NPPdtwsWU42Fw+9zGATwhhb3iNlgINvx
 zFJEAP5/Fhuc3787ZsayGnC1G7s2Rvm1el2ZSAhU/vRnMIKJzzL1U3q+FR6qDF7OKZe6
 ExKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685120043; x=1687712043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JSph40thfd9YqqHizrdfQZmv5A6L4soqJWF31SYGqc=;
 b=X9Np0y24pHCFyVmAF2p2WJw9g73AXHRB3f7AfvgYDBPunp/knyGZY2bw0hZBP3LF43
 15trlR8AZl/UqQDJlxr9t5EA5X3gWYYyHgKBD5m0m/sWghrHnyzy7tV1dKsXI9jYuKQQ
 UuL0Gl9IEOwT9MDnnLTW2giNP63TZf6cR/ptDUD6g7swYOC2hMfFZMN5OIhqLxqZqygI
 LnJ5QNtnCajydcF23zXCftsZ0NSWi8jEqKf2MHP2ayoqQleW9vANa7J41ve71347K2L2
 vMQUs4t5UwTBTi2rCKp6LSnYH9rJEvX0cVcPCfA5vAnxSj+Th3ZxW/j4wNNS9YdmN8MS
 Jo1Q==
X-Gm-Message-State: AC+VfDwe6bu84XjzGEg0QEW9I1aZkRS42qoAHHjgVzg96XbB5rfI/+TA
 LcsZ/0Ixi86pol1KjkBUHab7WA==
X-Google-Smtp-Source: ACHHUZ7hQ6gED/2dPZVbusmqhKVjpdc5qjlM9qK7O2gL+IKbfMWh4CpixfXBlARCipmW+El9SDTbRA==
X-Received: by 2002:a1c:4c0f:0:b0:3f6:13f5:d1ea with SMTP id
 z15-20020a1c4c0f000000b003f613f5d1eamr1715999wmf.11.1685120043138; 
 Fri, 26 May 2023 09:54:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v24-20020a1cf718000000b003f60b328417sm5780501wmh.17.2023.05.26.09.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:54:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 396C21FFBC;
 Fri, 26 May 2023 17:54:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Markus Armbruster <armbru@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 01/11] *-user: remove the guest_user_syscall tracepoints
Date: Fri, 26 May 2023 17:53:51 +0100
Message-Id: <20230526165401.574474-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526165401.574474-1-alex.bennee@linaro.org>
References: <20230526165401.574474-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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
Message-Id: <20230524133952.3971948-2-alex.bennee@linaro.org>
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


