Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCF670DD05
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:51:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RTG-0007ZK-P4; Tue, 23 May 2023 08:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RTF-0007ZB-Iu
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:33 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RT9-00058i-PA
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f6077660c6so13723885e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684846202; x=1687438202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wquG6em70tm69qFH0/HLZzEpZaZNtHpQCT4NEow+nqk=;
 b=U5hUDlGJ68D8xRrxDFsRzJeAHSjsWlN/UaL3FREBsvaoE2ssQX4NkyAN+y+1d4Qlnv
 ANmOi55pSOi5+E+BzOFFDaKb6CVTkT4GNIpkgoekfHJXlWZ4nx7ZnTQX7UzsVL6LfOEt
 WZbVeYmQ0xcSkjKdXDu5/XyCVGFQlAmOg8hexnXkVq4h8dElVOIBDZ88ig3aTRlULDSK
 ZtdQ9uuFQkPE+NBaqBz2LvhT0GflGWMsW9p37SImQLXEErVx2FEkDSW90pp+f1ZiTP4b
 dbJOjHhjOAiqOvaMG8aEViDZpN45m7O4OVu8gJjE9uy8DOGbPtt2CMznmRrbFLSevQ7l
 JAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684846202; x=1687438202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wquG6em70tm69qFH0/HLZzEpZaZNtHpQCT4NEow+nqk=;
 b=PDD7hoSpQLmazLmoATvL3Bxuyj2fBNwjuO4+I+I/EY9SXNH1VBiEQoGBz4pFyV8Asf
 73ihoINe9yZMbjd5CD+Yb1E5D+w785ec75PxwWGg5Qb3MHuNZxJ19dcpY+oR6OdFtUfS
 Mb+bwSPfB8QwN0gS3iH4z4Tmw/s7EA/gWI1IjARiFiPqXYa51AtFzz7VNOGjSkEZcYOd
 yxSm/3BSa4VJxbwEU69DOtUQxI4YosTRvY9w3HWDKcq3VnHYSmgaO8+u5waN4CFnzjo+
 6cZoXJ4N6zlpv/7gcHN+tH6aVZmN315bI/cHSc3pkEkL+8ewMlmbMFQlzTwhTPwSJsGX
 05aQ==
X-Gm-Message-State: AC+VfDzDRPwsniQjfhCiW+WJ0xV2v7wA0UqWQGQDDuVZdxhzmbXZkFIf
 7vP2n+YSAH/BBgRFiNAJff13AhFA51/GnGQtH8YOJA==
X-Google-Smtp-Source: ACHHUZ6gAWwrycvnrr6jeLur/D4YiFDzFM+fCe5BW8KakFuZ9hEulFAqfbs/yAt1uYXRcg7lalDWug==
X-Received: by 2002:a05:600c:3797:b0:3f4:2819:7777 with SMTP id
 o23-20020a05600c379700b003f428197777mr10079447wmr.38.1684846201838; 
 Tue, 23 May 2023 05:50:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a1cf710000000b003f4fe09aa43sm14973884wmh.8.2023.05.23.05.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:50:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0AE011FFBC;
 Tue, 23 May 2023 13:50:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Warner Losh <imp@bsdimp.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Eric Blake <eblake@redhat.com>,
 libvir-list@redhat.com, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 01/10] *-user: remove the guest_user_syscall tracepoints
Date: Tue, 23 May 2023 13:49:51 +0100
Message-Id: <20230523125000.3674739-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523125000.3674739-1-alex.bennee@linaro.org>
References: <20230523125000.3674739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Message-Id: <20230420150009.1675181-2-alex.bennee@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230503091756.1453057-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230505155336.137393-2-alex.bennee@linaro.org>
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


