Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3F680A331
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 13:28:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBZwB-0002aQ-RS; Fri, 08 Dec 2023 07:26:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rBZw9-0002aB-9x
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 07:26:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rBZw6-0006l5-LD
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 07:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702038387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1YmEDaraCyEw/yn0G1V+MORxmniCMG2G9XqgZ019Nu8=;
 b=DeSs66pYi7emqMjUJKgsZCLbiW+qO21PwJhJCuen3KdJjMbaLzgxrDS6z/jCCiW9SoTh02
 Vy1rz1cOjN4O4gaepvDd8qnFqOwocIuanW36ew7Sgk3ynEGBfj4o6k8ip51xrs8+KxffbD
 Q5yt4vsfABdWF5UKrpqSbJzj14y0i8Y=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-h1YO23UZNKG7PClDPrJyoA-1; Fri, 08 Dec 2023 07:26:26 -0500
X-MC-Unique: h1YO23UZNKG7PClDPrJyoA-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-7b70c8b7314so97918839f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 04:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702038386; x=1702643186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1YmEDaraCyEw/yn0G1V+MORxmniCMG2G9XqgZ019Nu8=;
 b=R3tSzq9GYbFyQ9m5boSR4gox7I6TMWpmAJOTMem4ogCzddnsohLd+ewkjn0s7Jx6ol
 D/ZwCxzSPgdDQoOAgR0MHUn9Kdm6vuzKq2fBisFks0KCM3bKnGimIs+rXI6HrUzqrPr6
 ZNHN6BEl80P7pXeHGPdTe+ZbpcAuFTnA5NDoD1UyKh8tN4o6jI+vK73fBExuUp8ZYk5v
 deCRAiV5V8oAOGDSGoOrQ7Ke9qltjNyizG6aRhzh3dt30F8OqGIVc6UD7YPouRO3DaGD
 oUKQan9USZqr9o8C+8aJdWPvwLlK0PqcesR8na9TYrbcV+0X6JewdKoMWNMoDn1VVP9W
 yUlA==
X-Gm-Message-State: AOJu0YzuQvIK3k4ku60k9QcMKphMyMTpY65kz1wQ+j+uuPGWseWJTA4K
 IgFm3egMOoVOA9wL/om56eh4nGtZSawUE0aScLUspQMKkGI22hWuVHMQ3dWsybyY5sVwj+5NOpo
 sCKfsOS4igaZSkso=
X-Received: by 2002:a05:6e02:1b07:b0:35d:5995:798a with SMTP id
 i7-20020a056e021b0700b0035d5995798amr48960ilv.36.1702038385878; 
 Fri, 08 Dec 2023 04:26:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGD2I8Vw7VaYUfGcBy10Wx2++AjGGrJ1VP5DWLcjjBooxIhYVQ6IdDCNnzl6tWffZh6kO1npQ==
X-Received: by 2002:a05:6e02:1b07:b0:35d:5995:798a with SMTP id
 i7-20020a056e021b0700b0035d5995798amr48947ilv.36.1702038385522; 
 Fri, 08 Dec 2023 04:26:25 -0800 (PST)
Received: from localhost.localdomain ([115.96.133.105])
 by smtp.googlemail.com with ESMTPSA id
 x1-20020a63cc01000000b005742092c211sm1387572pgf.64.2023.12.08.04.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 04:26:25 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] pc: q35: Bump max_cpus to 4096
Date: Fri,  8 Dec 2023 17:56:11 +0530
Message-ID: <20231208122611.32311-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to allow up to 4096 vCPUs")
Linux kernel can support upto a maximum number of 4096 vCPUS when MAXSMP is
enabled in the kernel. So bump up the max_cpus value for q35 machines versions
8.3 and newer to 4096. Older q35 machines versions 8.2 and older continue to
support 1024 maximum vcpus as before.

If KVM is not able to support the specified number of vcpus, QEMU would
return the following error messages:

$ ./qemu-system-x86_64 -cpu host -accel kvm -machine q35 -smp 4096
qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested (4096) exceeds the recommended cpus supported by KVM (12)
Number of SMP cpus requested (4096) exceeds the maximum cpus supported by KVM (1024)

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Julia Suvorova <jusual@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/pc_q35.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 4f3e5412f6..2ed57814e1 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -375,7 +375,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->default_nic = "e1000e";
     m->default_kernel_irqchip_split = false;
     m->no_floppy = 1;
-    m->max_cpus = 1024;
+    m->max_cpus = 4096;
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
@@ -383,12 +383,22 @@ static void pc_q35_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
 }
 
-static void pc_q35_8_2_machine_options(MachineClass *m)
+static void pc_q35_8_3_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v8_3, "pc-q35-8.3", NULL,
+                   pc_q35_8_3_machine_options);
+
+static void pc_q35_8_2_machine_options(MachineClass *m)
+{
+    pc_q35_8_3_machine_options(m);
+    m->alias = NULL;
+    m->max_cpus = 1024;
+}
+
 DEFINE_Q35_MACHINE(v8_2, "pc-q35-8.2", NULL,
                    pc_q35_8_2_machine_options);
 
@@ -396,7 +406,6 @@ static void pc_q35_8_1_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_8_2_machine_options(m);
-    m->alias = NULL;
     pcmc->broken_32bit_mem_addr_check = true;
     compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
     compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
-- 
2.42.0


