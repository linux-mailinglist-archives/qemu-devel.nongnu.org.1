Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E1C8295C1
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:07:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUTj-0003Yg-Qy; Wed, 10 Jan 2024 04:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSb-000380-T7
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:19 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSa-0005Uz-7s
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:17 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6daa822be30so1734934b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877275; x=1705482075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+OG6UZAqD9KMd4LJIr4sSC1wfQDaNJBfhbmtsdNuSKw=;
 b=KWW0MV0S24BWrRZYC8y5z4QktUDCr/Jkk4Gvu+RYT8qyCOU/X5u5lwpzBFakCWn6m/
 jIBsOysyjux+cz/DTLOB1tT4s/WhgbVI+UT1LAy3HOPYptCNESuLk4VRk/FnyEpycEgz
 OLISph2br7tNSN22ASzZkNbbujDWgauTj6tOFfaaxFW3lrLlYsKehQ/L55USxWGX1meb
 RNfjSx3376ISsV1CrbGxwx9ABbC7mOUIdCkpNyz22DiwnuVoxPYpAQooB7Wf9jKOv/5q
 Ft9ocM2m6SA/zYKv/Km7q/w+stUkK+aQykK6HtKBFRRlRnV5twSlehKxVxSNZT+S5Bg7
 FL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877275; x=1705482075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+OG6UZAqD9KMd4LJIr4sSC1wfQDaNJBfhbmtsdNuSKw=;
 b=CO4I4hy1msS3ePebNh8aJ8G5zKnFlL93VYQUiMv6WnSlHfc79hVohs7iU+y8AjH7Tq
 CJMxHvCXSo8YHkHXadbojT3oHh+gMddd3NsNnKlZyikLcafcLAsK631zBVJT8vJN5FZm
 UMUqjrtZGY8yuVV0odsg6c2jh3VGznxI74Zc9Ooz8GHHZixXsZAQ0tknVvpHxdY0cdRu
 FiChW7B6b4yL38VuFoeFPNdOuC/CKaU7C2rPGORJIdFNU9sBI8jFX64QIjMT8zLjh9bg
 hmfHJU8sTueS0DggI8Bvomt4ILKvEtiHjNi//WSCcnI08Hp42xFBgtIVBchCdUigExLS
 wyvg==
X-Gm-Message-State: AOJu0Yzrp/o85YheKI9ciQQboawwqS/0bv5ntRp8Wc53X2N8i0RrCSWe
 SdbxNjR8Xw2TVo/m3NYLPD4koFjaFwjI3rR4
X-Google-Smtp-Source: AGHT+IGHl9onGMqqb2zZQITYFAWM6hr3XWZ0/h/okS9ZLZTN2FQhwFK2RBkWJru6QfP+/xLl1wjr7g==
X-Received: by 2002:a05:6a00:3d4f:b0:6d9:b11e:dae0 with SMTP id
 lp15-20020a056a003d4f00b006d9b11edae0mr683708pfb.14.1704877274679; 
 Wed, 10 Jan 2024 01:01:14 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:01:14 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 55/65] target/riscv/kvm.c: remove group setting of KVM AIA if
 the machine only has 1 socket
Date: Wed, 10 Jan 2024 18:57:23 +1000
Message-ID: <20240110085733.1607526-56-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

The emulated AIA within the Linux kernel restores the HART index
of the IMSICs according to the configured AIA settings. During
this process, the group setting is used only when the machine
partitions harts into groups. It's unnecessary to set the group
configuration if the machine has only one socket, as its address
space might not contain the group shift.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231218090543.22353-2-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 2c5217102c..841756ab9b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1390,21 +1390,24 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
         exit(1);
     }
 
-    socket_bits = find_last_bit(&socket_count, BITS_PER_LONG) + 1;
-    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
-                            KVM_DEV_RISCV_AIA_CONFIG_GROUP_BITS,
-                            &socket_bits, true, NULL);
-    if (ret < 0) {
-        error_report("KVM AIA: failed to set group_bits");
-        exit(1);
-    }
 
-    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
-                            KVM_DEV_RISCV_AIA_CONFIG_GROUP_SHIFT,
-                            &group_shift, true, NULL);
-    if (ret < 0) {
-        error_report("KVM AIA: failed to set group_shift");
-        exit(1);
+    if (socket_count > 1) {
+        socket_bits = find_last_bit(&socket_count, BITS_PER_LONG) + 1;
+        ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
+                                KVM_DEV_RISCV_AIA_CONFIG_GROUP_BITS,
+                                &socket_bits, true, NULL);
+        if (ret < 0) {
+            error_report("KVM AIA: failed to set group_bits");
+            exit(1);
+        }
+
+        ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
+                                KVM_DEV_RISCV_AIA_CONFIG_GROUP_SHIFT,
+                                &group_shift, true, NULL);
+        if (ret < 0) {
+            error_report("KVM AIA: failed to set group_shift");
+            exit(1);
+        }
     }
 
     guest_bits = guest_num == 0 ? 0 :
-- 
2.43.0


