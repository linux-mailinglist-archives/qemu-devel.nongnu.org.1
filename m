Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7534A99E34
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Apr 2025 03:28:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kr8-0001Bf-FO; Wed, 23 Apr 2025 20:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqB-0000yC-Ta
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:24 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kpv-0004gA-9Z
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:09 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so358263b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455986; x=1746060786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RK0p9wQfVgEVzHTMYQneP9tRo6BI56q+RabGlzQyjiM=;
 b=VP9gIAInymD4mqV5FYDtAwGFswjMeVsVg/e9bznvazBV1SHikZHHQ6aGQxuIizaM+T
 sWFx43UkhLCTZFW/3qW5QP0/zWiKEazIuOTzyd1xUg7vNpfxbHIvcxghloBgNjNGwMLG
 0rJMl4fq4Hnjjw6Lkts1Bnewv37M3kT3arfNd7TbBEo7xb3LqxPcivYO9iHHWLgDGpWf
 gkjTtxmeHZoHUk7mC3cUty4HrZGH5eKU5xPsCK/lXSyGbNzYLuj8l6BCOmI9CbX33GeD
 x92HyIRQcMd6Gsfm0KvshF+9cJ6Q0S5q5g2Bq/X0Jcr/SU9eWjl8OfQs9o86Dn2suvrW
 WUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455986; x=1746060786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RK0p9wQfVgEVzHTMYQneP9tRo6BI56q+RabGlzQyjiM=;
 b=W+0uLKx/OH1ZsZ+gRpfWzVAVPog4ZbE3jf/kKcBHS6GZwC+BmtY8L+jWZJcFHycrkw
 aM4K4Nv3kTnK7jAYV4UyiDgvs7TvZeeyEweZBcZXzB1JGZoblYlWtkacGm4n/Gecr1Fa
 f2/H71rIT3AdLrjEm5Oq+ipqqtfhZCrWpOYT+cQqAKxfLTYeTzxDZOn6im3Mq0mF6LWz
 rLXJgeAZVG8yTCUi/2G0SyEXNqb8Mob9PlC/A2FFesIp22rf9HrZqcUlLt6tdJBnCfYx
 ScEvwqcsFtqWDZYECnV0xHtxdYMPax4zabnamkW8Ep0LOLk7n4Lg9INaRiH84/T6uLGd
 I0mw==
X-Gm-Message-State: AOJu0YxP4mfUj/FRjpV5qgY2BzOEB6OKDUe+OeuBVL+PV+mPEV7w5cS1
 +485rLO5VHdydn6m/8xeCOG0YDgwuaPPgZUKzUOanEUWfxzL6dP4uK7EAnNyAl731DUXY4t2uk5
 H
X-Gm-Gg: ASbGnctN/+v/1cv1GnuK+eklLr4XKxpNB9iUHFjCazW4q1Aul9g49jN9rtVYxx3rYVu
 2UEjJVVyjR4uDR0XyVdruWw5riPpn8Vfx61euLxuc1xRNkE6EuiHXiG55IQVj7RVMFzZUU1bX89
 JMs9F0qPQ2/rojGK8915PZNjkUcR1uVYuTDLC8PAWd/DTmjNKYPoV0ZaNNUMRRjjTGsNS4eJWJW
 jjUHvk3L7IJ8pnJfMoRmSftNdlh8ICXNRSVqL4QJuqoqylR54A66bvHGOt9sOddSltHEox5SwR+
 u8yEcfRcK/AESf+pUqN9AoKBmLH6n2Mzlp+YCwqpqgcLO1PFzE/STREDMR6aIlkqj4Ib5LcJqZc
 =
X-Google-Smtp-Source: AGHT+IFquy11MKAxfeY+BJbZUZ83rtlUoNJr4uTExmR57Dq9AupNf2dzi3LSUACW+GhyAeC+aqIzyg==
X-Received: by 2002:a05:6a21:4a41:b0:1f3:26e5:55bc with SMTP id
 adf61e73a8af0-20444f4254cmr744523637.42.1745455985831; 
 Wed, 23 Apr 2025 17:53:05 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 041/148] meson: Introduce top-level libuser_ss and libsystem_ss
Date: Wed, 23 Apr 2025 17:47:46 -0700
Message-ID: <20250424004934.598783-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We already have two subdirectories for which we need
to build files twice, for user vs system modes.
Move this handling to the top level.

This cannot be combined with user_ss or system_ss,
because the formulation has not been extended to support
configuration symbols.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/meson.build | 32 ++++++++------------------------
 meson.build         | 22 ++++++++++++++++++++++
 tcg/meson.build     | 23 ++---------------------
 3 files changed, 32 insertions(+), 45 deletions(-)

diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index dff741ddd4..0e8099ae9c 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -4,32 +4,16 @@
 # types such as hwaddr.
 #
 
-# We need to build the core gdb code via a library to be able to tweak
-# cflags so:
-
-gdb_user_ss = ss.source_set()
-gdb_system_ss = ss.source_set()
-
 # We build two versions of gdbstub, one for each mode
-gdb_user_ss.add(files('gdbstub.c', 'user.c'))
-gdb_system_ss.add(files('gdbstub.c', 'system.c'))
+libuser_ss.add(files(
+  'gdbstub.c',
+  'user.c'
+))
 
-gdb_user_ss = gdb_user_ss.apply({})
-gdb_system_ss = gdb_system_ss.apply({})
-
-libgdb_user = static_library('gdb_user',
-                             gdb_user_ss.sources() + genh,
-                             c_args: '-DCONFIG_USER_ONLY',
-                             build_by_default: false)
-
-libgdb_system = static_library('gdb_system',
-                                gdb_system_ss.sources() + genh,
-                                build_by_default: false)
-
-gdb_user = declare_dependency(objects: libgdb_user.extract_all_objects(recursive: false))
-user_ss.add(gdb_user)
-gdb_system = declare_dependency(objects: libgdb_system.extract_all_objects(recursive: false))
-system_ss.add(gdb_system)
+libsystem_ss.add(files(
+  'gdbstub.c',
+  'system.c'
+))
 
 common_ss.add(files('syscalls.c'))
 
diff --git a/meson.build b/meson.build
index 41f68d3806..7e22afe135 100644
--- a/meson.build
+++ b/meson.build
@@ -3662,12 +3662,14 @@ io_ss = ss.source_set()
 qmp_ss = ss.source_set()
 qom_ss = ss.source_set()
 system_ss = ss.source_set()
+libsystem_ss = ss.source_set()
 specific_fuzz_ss = ss.source_set()
 specific_ss = ss.source_set()
 rust_devices_ss = ss.source_set()
 stub_ss = ss.source_set()
 trace_ss = ss.source_set()
 user_ss = ss.source_set()
+libuser_ss = ss.source_set()
 util_ss = ss.source_set()
 
 # accel modules
@@ -4045,6 +4047,26 @@ common_ss.add(qom, qemuutil)
 common_ss.add_all(when: 'CONFIG_SYSTEM_ONLY', if_true: [system_ss])
 common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
 
+libuser_ss = libuser_ss.apply({})
+libuser = static_library('user',
+                         libuser_ss.sources() + genh,
+                         c_args: '-DCONFIG_USER_ONLY',
+                         dependencies: libuser_ss.dependencies(),
+                         build_by_default: false)
+libuser = declare_dependency(objects: libuser.extract_all_objects(recursive: false),
+                             dependencies: libuser_ss.dependencies())
+common_ss.add(when: 'CONFIG_USER_ONLY', if_true: libuser)
+
+libsystem_ss = libsystem_ss.apply({})
+libsystem = static_library('system',
+                           libsystem_ss.sources() + genh,
+                           c_args: '-DCONFIG_SOFTMMU',
+                           dependencies: libsystem_ss.dependencies(),
+                           build_by_default: false)
+libsystem = declare_dependency(objects: libsystem.extract_all_objects(recursive: false),
+                               dependencies: libsystem_ss.dependencies())
+common_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: libsystem)
+
 # Note that this library is never used directly (only through extract_objects)
 # and is not built by default; therefore, source files not used by the build
 # configuration will be in build.ninja, but are never built by default.
diff --git a/tcg/meson.build b/tcg/meson.build
index 69ebb4908a..7df378d773 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -27,24 +27,5 @@ if host_os == 'linux'
   tcg_ss.add(files('perf.c'))
 endif
 
-tcg_ss = tcg_ss.apply({})
-
-libtcg_user = static_library('tcg_user',
-                             tcg_ss.sources() + genh,
-                             dependencies: tcg_ss.dependencies(),
-                             c_args: '-DCONFIG_USER_ONLY',
-                             build_by_default: false)
-
-tcg_user = declare_dependency(objects: libtcg_user.extract_all_objects(recursive: false),
-                              dependencies: tcg_ss.dependencies())
-user_ss.add(tcg_user)
-
-libtcg_system = static_library('tcg_system',
-                                tcg_ss.sources() + genh,
-                                dependencies: tcg_ss.dependencies(),
-                                c_args: '-DCONFIG_SOFTMMU',
-                                build_by_default: false)
-
-tcg_system = declare_dependency(objects: libtcg_system.extract_all_objects(recursive: false),
-                                dependencies: tcg_ss.dependencies())
-system_ss.add(tcg_system)
+libuser_ss.add_all(tcg_ss)
+libsystem_ss.add_all(tcg_ss)
-- 
2.43.0


