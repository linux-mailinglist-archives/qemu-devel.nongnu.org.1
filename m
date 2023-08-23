Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5FD78616E
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:26:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOi-0000Hs-0g; Wed, 23 Aug 2023 16:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOb-0008RG-8p
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:05 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOV-0005TU-HU
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c0bae4da38so1811355ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822210; x=1693427010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7loHC2CVphFZ2VQ7U0c6/4a/FgpsUAqIthrt73VkroA=;
 b=cYZgAojiow4xVWv/z2SVJh+VLAZOSqqFfQ1VjrL98S57l3b9h9VW7krFosgfwjPx0o
 MPF5CxUAoj6A3B6YQZga3i2UJrZE3Tahb7KkrxsEUyZDsSdwBHSt18AYFy0RHYNOY3J1
 UB7A+z6tXni0BcHeWO80lX492dntN29F2Vuhg0R7EoqG2PGVyjzsOULf3YnW0LZJBIX0
 Z78VadbZGz8Ugdd34ZRW/QvV/dRUBDQEs+YMFEG0kiYejfVj+dZ1drDDKGNf58KP1Hws
 +KZqbTXH8VKn1LmkLNd0zlOoZU37FiIKwHvSioAfoXcy2Vjeda9MpFm3jmV/CHBvTo3O
 arzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822210; x=1693427010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7loHC2CVphFZ2VQ7U0c6/4a/FgpsUAqIthrt73VkroA=;
 b=Sf7nK5C8JZLUqkKLFWMYtBioYaIXTXYYq/vXryxrtDIHFlvmlu6IFpBwRS9gLSMJBa
 ChMHIbt5sE4i6w32HfZRa2g9c1umY9xnzuybCFdBL/YMSBGdQ0L0+6EDJraYJ30Koyje
 QUkhmChzHPJl5O+ns/WJaCn+P3GIWyzw/fyoJcr3CiDicroyj0mrlQpm55tKxuy0ZC8B
 HjallWT6d951E9SSJFSmai2EhL9If1Y9zhRw3mNZytzW3nsfQ+5PU06fskpIlab1hnG3
 bseSAZfQD/AMIRYvhPhkMaCkabZ9VOr7WklZTb7hdtuqt/SQfOZ0Ru6xLsOtvf7oiF4G
 6uKA==
X-Gm-Message-State: AOJu0Yz0+bbxElijuoErzazeic83MPjd48scHnfcTUjBV7K3gPURe/7G
 eZ+PJvyMes+DW8eangC606bAW+X2QhTlQ5cMwAI=
X-Google-Smtp-Source: AGHT+IGvOyCGi1lj4ojEgYQaHa5KDLqo1Rr5+yD/oOK8NG/j0knrKoDb3G0mfbh5X/lfw2SWnP5TEQ==
X-Received: by 2002:a17:902:64cf:b0:1bc:17ab:8d68 with SMTP id
 y15-20020a17090264cf00b001bc17ab8d68mr16449996pli.16.1692822210001; 
 Wed, 23 Aug 2023 13:23:30 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 02/48] accel/hvf: Widen pc/saved_insn for hvf_sw_breakpoint
Date: Wed, 23 Aug 2023 13:22:40 -0700
Message-Id: <20230823202326.1353645-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

From: Anton Johansson via <qemu-devel@nongnu.org>

Widens the pc and saved_insn fields of hvf_sw_breakpoint from
target_ulong to vaddr. Other hvf_* functions accessing hvf_sw_breakpoint
are also widened to match.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230807155706.9580-3-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/sysemu/hvf.h      | 6 +++---
 accel/hvf/hvf-accel-ops.c | 4 ++--
 accel/hvf/hvf-all.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 70549b9158..4cbae87ced 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -39,14 +39,14 @@ DECLARE_INSTANCE_CHECKER(HVFState, HVF_STATE,
 
 #ifdef NEED_CPU_H
 struct hvf_sw_breakpoint {
-    target_ulong pc;
-    target_ulong saved_insn;
+    vaddr pc;
+    vaddr saved_insn;
     int use_count;
     QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
 };
 
 struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu,
-                                                 target_ulong pc);
+                                                 vaddr pc);
 int hvf_sw_breakpoints_active(CPUState *cpu);
 
 int hvf_arch_insert_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index a44cf1c144..3c94c79747 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -474,7 +474,7 @@ static void hvf_start_vcpu_thread(CPUState *cpu)
                        cpu, QEMU_THREAD_JOINABLE);
 }
 
-static int hvf_insert_breakpoint(CPUState *cpu, int type, hwaddr addr, hwaddr len)
+static int hvf_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
 {
     struct hvf_sw_breakpoint *bp;
     int err;
@@ -512,7 +512,7 @@ static int hvf_insert_breakpoint(CPUState *cpu, int type, hwaddr addr, hwaddr le
     return 0;
 }
 
-static int hvf_remove_breakpoint(CPUState *cpu, int type, hwaddr addr, hwaddr len)
+static int hvf_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
 {
     struct hvf_sw_breakpoint *bp;
     int err;
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 4920787af6..db05b81be5 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -51,7 +51,7 @@ void assert_hvf_ok(hv_return_t ret)
     abort();
 }
 
-struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, target_ulong pc)
+struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, vaddr pc)
 {
     struct hvf_sw_breakpoint *bp;
 
-- 
2.34.1


