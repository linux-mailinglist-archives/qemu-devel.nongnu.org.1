Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 697AF73E18C
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:06:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlNA-0005yM-Ez; Mon, 26 Jun 2023 08:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLj-0002x8-Bs
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLc-00037M-AE
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zk3bXCBrHhYRvZthO2EE5E3G0WSYNJpSlRqxYxH75A8=;
 b=XT1GCBBmNDvsY+UAaICNabdsDFB8ZgWJewqi9jDtczd6ntMaXuw808JjObvRvuz5cBUxeX
 ifXSaKBvwae6yGbbwMpdL/6qGuLX1eGQNmiMsbXn8umXhj8rFaA9beSKCghv9vFPMjkp6K
 EjwQbqXusheL7iWDdgo8jREDx2CaquM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-Fxbta0SDPWCld8JBWL2uNA-1; Mon, 26 Jun 2023 08:29:33 -0400
X-MC-Unique: Fxbta0SDPWCld8JBWL2uNA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31114af5e45so1873249f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782571; x=1690374571;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zk3bXCBrHhYRvZthO2EE5E3G0WSYNJpSlRqxYxH75A8=;
 b=IC/DqqBzDSlSGOTTPk8Nn3zn142XmyoOblKNR0JP4u+kgN/sC6zskLUInc7GSU+l+F
 qMsIqDx0HLuoMQtPPKnWQT4RCibdjbFfbCkbpHk1+Bb0g6hM3TDmKkJe5/BgrRnxgzNU
 vemMuLKltbkGXP/mC60S1GsQQ7V6Rp3ZFWri0eBi3lZvr2awOPWdvvIe+MH/ALOG+FY5
 TJbWFWqTbWx38TqyiQA8EnWZ+T1CzlyEepfWDQvQ6LnlpbZE8+XevaeQrrPKcU+roLgg
 +aJyeWbtviDZc0SBiL0mPY7Wc0pbQFzsdlWJnAHUh/1DcSSY5FhN8Fj3nN0kwWIfTmrN
 z5Hw==
X-Gm-Message-State: AC+VfDxmQjYNVphkNI9jzTehiRGprE3uAouyPcDCWIQJcUxS5O3TKJXe
 3ngvTkZv79gu0c8F39ZdQKeLtzQ8yq2aa7Eqo41U6USP8Nem01Num54u92s7ytFQ0eNBMkTCPoE
 zwy3xnqmWYYjbUE3jnF2fD2KMq2hKeTzE6hVjoGdRklPaiLfPdTTZ203wo/O0wynqw4s5
X-Received: by 2002:adf:f544:0:b0:30e:1fc4:d0c9 with SMTP id
 j4-20020adff544000000b0030e1fc4d0c9mr25845384wrp.9.1687782571691; 
 Mon, 26 Jun 2023 05:29:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7XSJqs72bemR8ZHGEm89pOWDPUw6uxfKhYgga/rmqH2gkmBpKjzNbt/KxSC4E8uU7pC2gtUQ==
X-Received: by 2002:adf:f544:0:b0:30e:1fc4:d0c9 with SMTP id
 j4-20020adff544000000b0030e1fc4d0c9mr25845371wrp.9.1687782571469; 
 Mon, 26 Jun 2023 05:29:31 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 e15-20020adfe7cf000000b0030fae360f14sm7267771wrn.68.2023.06.26.05.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:31 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 33/53] pc: q35: Bump max_cpus to 1024
Message-ID: <318ebd3629bc6a0a1a1b5d0c4642d523abe719e7.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Since KVM_MAX_VCPUS is currently defined to 1024 for x86 as shown in
arch/x86/include/asm/kvm_host.h, update QEMU limits to the same number.

In case KVM could not support the specified number of vcpus, QEMU would
return the following error message:

  qemu-system-x86_64: kvm_init_vcpu: kvm_get_vcpu failed (xxx): Invalid argument

Also, keep max_cpus at 288 for machine version 8.0 and older.

Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Julia Suvorova <jusual@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-Id: <20230607205717.737749-3-suravee.suthikulpanit@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/pc_q35.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index cf68b80974..11a7084ea1 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -368,12 +368,12 @@ static void pc_q35_machine_options(MachineClass *m)
     m->default_nic = "e1000e";
     m->default_kernel_irqchip_split = false;
     m->no_floppy = 1;
+    m->max_cpus = 1024;
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
-    m->max_cpus = 288;
 }
 
 static void pc_q35_8_1_machine_options(MachineClass *m)
@@ -396,6 +396,7 @@ static void pc_q35_8_0_machine_options(MachineClass *m)
 
     /* For pc-q35-8.0 and older, use SMBIOS 2.8 by default */
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
+    m->max_cpus = 288;
 }
 
 DEFINE_Q35_MACHINE(v8_0, "pc-q35-8.0", NULL,
-- 
MST


