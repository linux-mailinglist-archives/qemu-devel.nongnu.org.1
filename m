Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0437804DC
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 05:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWqIT-0001og-Pv; Thu, 17 Aug 2023 23:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqIP-0001o6-40
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:37:09 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqIM-0005lH-Ds
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:37:08 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-689e6fce70dso428473b3a.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 20:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692329825; x=1692934625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDgcaTMJn76IqBG3wvUQ8hqaBU+41zfZWx/0YdFh8Js=;
 b=c7pfO67bYGep/CCalwpSzQG73w6V+Wq8aUEy1/TqMFx8xgzK28E+fDPp8pfIVeG8rC
 wk0RhCkymVULa08xi2JB0CM0XGMHosMmbNW+xL4TmPxXF3mwJrNKRU9AcVinI8oN/n5S
 sO3kwc+26u5FrTWSnzVPVdbNVCi9MSPZ3h2+/DY77FFjL8tb8UV+oP6zT5I532eOzyYp
 f05tFCkne7kfeJilswYf5n5yg1vwA8BvYNESzKm5HGUBfHxAfKOL4Bx+u78zbOKf05Ar
 swVbG0Vv6U7vmovlaRHCCKemmW88YUvKM8mhyjlNTdcAcU9DVedGqENLiM7CryZ5sJC9
 hbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692329825; x=1692934625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDgcaTMJn76IqBG3wvUQ8hqaBU+41zfZWx/0YdFh8Js=;
 b=WGLu4EXKfW0VIZc3iYgqzVi19UnyNp5t8sDWaa804B5iM/v5zs3PN1T23wlh7f0dhg
 P0VS4PAYFjYyH9aG0BpGP3vj+sLtKjh4qicABUlYmfZgK2J5HxGG0wzRWvCoWx7uEjL/
 hXWCpnIssgjxcdpcQA/6uI1/+ZiUe1+E7aTio1tbpVJo1wrGKPToWUWli1WOT/49IKZV
 RmBRhAQpkZvpbZtjII5ykdRLk46XVBi/JrQz8+RUetH33JNOrFOJuvDoZezCxzb3jyBb
 aYHSruUt2GL6rtZxGmrZsHwSDU28KEzTUgbKZQ2NVKfJ07vshNiO0U2VLBIYrp+r9525
 P6mg==
X-Gm-Message-State: AOJu0YzssWLIYggsw5sDMMw0PpgKJUT76zCa7l70njy9zTIDRvU3cakz
 CCNh+qVTP28EDhc1WWd/Q9uqxw==
X-Google-Smtp-Source: AGHT+IFa3N0QJqMVNgBzjvZogXkFwo/w52Z3xa2M3kQCbTREqvBV/Uu6/tDrmpVOIgYgwPr/0jK66w==
X-Received: by 2002:a05:6a00:290c:b0:67e:18c6:d2c6 with SMTP id
 cg12-20020a056a00290c00b0067e18c6d2c6mr1390306pfb.5.1692329825194; 
 Thu, 17 Aug 2023 20:37:05 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c24-20020aa781d8000000b00686a80f431dsm484135pfn.126.2023.08.17.20.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 20:37:04 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH RESEND v5 05/26] target/arm: Move the reference to arm-core.xml
Date: Fri, 18 Aug 2023 12:36:24 +0900
Message-ID: <20230818033648.8326-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818033648.8326-1-akihiko.odaki@daynix.com>
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Some subclasses overwrite gdb_core_xml_file member but others don't.
Always initialize the member in the subclasses for consistency.

This especially helps for AArch64; in a following change, the file
specified by gdb_core_xml_file is always looked up even if it's going to
be overwritten later. Looking up arm-core.xml results in an error as
it will not be embedded in the AArch64 build.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 93c28d50e5..d71a162070 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2354,7 +2354,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->sysemu_ops = &arm_sysemu_ops;
 #endif
     cc->gdb_num_core_regs = 26;
-    cc->gdb_core_xml_file = "arm-core.xml";
     cc->gdb_arch_name = arm_gdb_arch_name;
     cc->gdb_get_dynamic_xml = arm_gdb_get_dynamic_xml;
     cc->gdb_stop_before_watchpoint = true;
@@ -2376,8 +2375,10 @@ static void arm_cpu_instance_init(Object *obj)
 static void cpu_register_class_init(ObjectClass *oc, void *data)
 {
     ARMCPUClass *acc = ARM_CPU_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(acc);
 
     acc->info = data;
+    cc->gdb_core_xml_file = "arm-core.xml";
 }
 
 void arm_cpu_register(const ARMCPUInfo *info)
-- 
2.41.0


