Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C6172E9F8
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 19:36:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q97v6-000545-MH; Tue, 13 Jun 2023 13:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ld.adecy@gmail.com>)
 id 1q97v4-00053H-5Y; Tue, 13 Jun 2023 13:35:02 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ld.adecy@gmail.com>)
 id 1q97v2-0007yi-HM; Tue, 13 Jun 2023 13:35:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f8d2bfed53so6295215e9.1; 
 Tue, 13 Jun 2023 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686677698; x=1689269698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K2ccc/wqhwCA1YAGQmwbG5QorzKggXSs3sWg65QUAPc=;
 b=INuPFEctuMJxBYqxyevMZYBn4wHLxJmR9t2zO+9yXLCQRtqbKiil2sBYVUsbtDpXmz
 S94wWDMEQBTjvtlKvMaatC0nQIz4nmwQ4msHkZUJ3JoJSEFMOqgpE3nbp+o6EVp8+J5t
 wumHyZQccUW7c+VMEW/z3aGHi2LgwPw7ABbzEaJtMzPR5GLYoTuUR2cBEcmI+JZIdHsI
 xXX7smZ8ctI3QqkYTqMsKHARqHp8KorfGowFs2dPvs9tnIDp8y005skW2DUgMFyVJ8gu
 5vMp7p/D/uH+LQ1l0aMPq+gtCqgwlH3hRJJlh2nmDPpxXiMNIuq8mijn2/QHD9em+DHr
 tUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686677698; x=1689269698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K2ccc/wqhwCA1YAGQmwbG5QorzKggXSs3sWg65QUAPc=;
 b=l1KHRo2xiJ5FLPt1Y5hlWDxiMNpNxnuFlkBkehLaxKpU0PQO40Ln6Mb1hGMx3OvJc3
 OjYRodVJ7xLjHNKR8Gm/xR8jdvqt7Wijy4/emPXX+vY8l54KItgL7JaNsz+bKQq/8h1n
 1JV6RRD/x78tDnLKyqVGrQxQxTAl+SWIRL7iU5TGZorMB72bRrUiG/ZRXiKdeWTzlraj
 sjDUuRna7OULK7SD6OSvleSl5ct3XrpMo1hObxxnyRGTxCpgU48emc6Lw9pcLZsrGLb+
 DtoHQ9TCniRsOL3A26Zlyw72P7UfC21rZStXt6+CguKhKs8/X0ZQww2L+OVqhStAx+w3
 L5og==
X-Gm-Message-State: AC+VfDw3pTej450tvehEhFn6uN+bBWsWVHABH2xATv856gMtab8izrjl
 8LdrcaU5ZJ5g81cHP0eA55k=
X-Google-Smtp-Source: ACHHUZ6T+mLQsupJ4bvlsLUDSnDRWW4rs/m9NtNeO0rC4/TzwARyeQZ8edUvXi3MDH5+yGOzOs+esw==
X-Received: by 2002:a05:600c:4f13:b0:3f7:f2df:4e50 with SMTP id
 l19-20020a05600c4f1300b003f7f2df4e50mr12434651wmq.7.1686677697653; 
 Tue, 13 Jun 2023 10:34:57 -0700 (PDT)
Received: from fedora.local.lan (aamiens-551-1-4-122.w92-131.abo.wanadoo.fr.
 [92.131.75.122]) by smtp.gmail.com with ESMTPSA id
 n5-20020a7bcbc5000000b003f7eafe9d76sm15155777wmi.37.2023.06.13.10.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 10:34:57 -0700 (PDT)
From: Lucas Dietrich <ld.adecy@gmail.com>
To: philmd@linaro.org
Cc: qemu-devel@nongnu.org, mrolnik@gmail.com, qemu-trivial@nongnu.org,
 Lucas Dietrich <ld.adecy@gmail.com>
Subject: [PATCH] Fix handling of AVR interrupts above 33.
Date: Tue, 13 Jun 2023 21:34:46 +0200
Message-Id: <20230613193446.4372-1-ld.adecy@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=ld.adecy@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit addresses a bug in the AVR interrupt handling code.
The modification involves replacing the usage of the ctz32 function
with ctz64 to ensure proper handling of interrupts above 33 in the AVR
target.

Previously, timers 3, 4, and 5 interrupts were not functioning correctly
because most of their interrupt vectors are numbered above 33.

Signed-off-by: Lucas Dietrich <ld.adecy@gmail.com>
---
 capstone                      | 1 +
 dtc                           | 1 +
 meson                         | 1 +
 roms/sgabios                  | 1 +
 slirp                         | 1 +
 target/avr/helper.c           | 4 ++--
 tests/fp/berkeley-softfloat-3 | 1 +
 tests/fp/berkeley-testfloat-3 | 1 +
 ui/keycodemapdb               | 1 +
 9 files changed, 10 insertions(+), 2 deletions(-)
 create mode 160000 capstone
 create mode 160000 dtc
 create mode 160000 meson
 create mode 160000 roms/sgabios
 create mode 160000 slirp
 create mode 160000 tests/fp/berkeley-softfloat-3
 create mode 160000 tests/fp/berkeley-testfloat-3
 create mode 160000 ui/keycodemapdb

diff --git a/capstone b/capstone
new file mode 160000
index 0000000000..f8b1b83301
--- /dev/null
+++ b/capstone
@@ -0,0 +1 @@
+Subproject commit f8b1b833015a4ae47110ed068e0deb7106ced66d
diff --git a/dtc b/dtc
new file mode 160000
index 0000000000..b6910bec11
--- /dev/null
+++ b/dtc
@@ -0,0 +1 @@
+Subproject commit b6910bec11614980a21e46fbccc35934b671bd81
diff --git a/meson b/meson
new file mode 160000
index 0000000000..12f9f04ba0
--- /dev/null
+++ b/meson
@@ -0,0 +1 @@
+Subproject commit 12f9f04ba0decfda425dbbf9a501084c153a2d18
diff --git a/roms/sgabios b/roms/sgabios
new file mode 160000
index 0000000000..cbaee52287
--- /dev/null
+++ b/roms/sgabios
@@ -0,0 +1 @@
+Subproject commit cbaee52287e5f32373181cff50a00b6c4ac9015a
diff --git a/slirp b/slirp
new file mode 160000
index 0000000000..a88d9ace23
--- /dev/null
+++ b/slirp
@@ -0,0 +1 @@
+Subproject commit a88d9ace234a24ce1c17189642ef9104799425e0
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 2bad242a66..e6e7d51487 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -52,7 +52,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         if (cpu_interrupts_enabled(env) && env->intsrc != 0) {
-            int index = ctz32(env->intsrc);
+            int index = ctz64(env->intsrc);
             cs->exception_index = EXCP_INT(index);
             avr_cpu_do_interrupt(cs);
 
@@ -79,7 +79,7 @@ void avr_cpu_do_interrupt(CPUState *cs)
     if (cs->exception_index == EXCP_RESET) {
         vector = 0;
     } else if (env->intsrc != 0) {
-        vector = ctz32(env->intsrc) + 1;
+        vector = ctz64(env->intsrc) + 1;
     }
 
     if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
diff --git a/tests/fp/berkeley-softfloat-3 b/tests/fp/berkeley-softfloat-3
new file mode 160000
index 0000000000..b64af41c32
--- /dev/null
+++ b/tests/fp/berkeley-softfloat-3
@@ -0,0 +1 @@
+Subproject commit b64af41c3276f97f0e181920400ee056b9c88037
diff --git a/tests/fp/berkeley-testfloat-3 b/tests/fp/berkeley-testfloat-3
new file mode 160000
index 0000000000..5a59dcec19
--- /dev/null
+++ b/tests/fp/berkeley-testfloat-3
@@ -0,0 +1 @@
+Subproject commit 5a59dcec19327396a011a17fd924aed4fec416b3
diff --git a/ui/keycodemapdb b/ui/keycodemapdb
new file mode 160000
index 0000000000..d21009b1c9
--- /dev/null
+++ b/ui/keycodemapdb
@@ -0,0 +1 @@
+Subproject commit d21009b1c9f94b740ea66be8e48a1d8ad8124023
-- 
2.40.1


