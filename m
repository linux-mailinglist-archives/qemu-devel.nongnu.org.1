Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CF570BC52
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:51:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1449-0005OQ-5z; Mon, 22 May 2023 07:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143a-0005Ar-PC
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143Z-0007YM-6n
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684756226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9TUBy2p4PDarpT0yz0zuGi964WBe9oJMbUcG1jrgHg4=;
 b=TMRTk98eUb1iskds+GtyW6oSgpx51F9ZA/NOTdVXwREChbqK954Pz+7hglb48Ez2aHwho5
 Stu6e1IgKoaBmCAAbWN29ACCf00g3RPtrARDthdX4DSWZT7fEo3FMHvVpF/WTMZOkqrrvj
 JxVd9DsAEYVzocuDh/i9HEEHv8V4agI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-r8r8E_4ZPd2CEVGx4kjOow-1; Mon, 22 May 2023 07:50:25 -0400
X-MC-Unique: r8r8E_4ZPd2CEVGx4kjOow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 134D7101A53B;
 Mon, 22 May 2023 11:50:25 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36C1B2166B27;
 Mon, 22 May 2023 11:50:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 07/20] hw/sh4: Use MachineClass->default_nic in the sh4 r2d
 machine
Date: Mon, 22 May 2023 13:50:01 +0200
Message-Id: <20230522115014.1110840-8-thuth@redhat.com>
In-Reply-To: <20230522115014.1110840-1-thuth@redhat.com>
References: <20230522115014.1110840-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Mark the default NIC via the new MachineClass->default_nic setting
so that the machine-defaults code in vl.c can decide whether the
default NIC is usable or not (for example when compiling with the
"--without-default-devices" configure switch).

Message-Id: <20230512124033.502654-8-thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/sh4/r2d.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 826a0a31b5..4944994e9c 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -232,6 +232,7 @@ static void r2d_init(MachineState *machine)
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     SuperHCPU *cpu;
     CPUSH4State *env;
     ResetData *reset_info;
@@ -310,7 +311,7 @@ static void r2d_init(MachineState *machine)
     /* NIC: rtl8139 on-board, and 2 slots. */
     for (i = 0; i < nb_nics; i++)
         pci_nic_init_nofail(&nd_table[i], pci_bus,
-                            "rtl8139", i == 0 ? "2" : NULL);
+                            mc->default_nic, i == 0 ? "2" : NULL);
 
     /* USB keyboard */
     usb_create_simple(usb_bus_find(-1), "usb-kbd");
@@ -375,6 +376,7 @@ static void r2d_machine_init(MachineClass *mc)
     mc->init = r2d_init;
     mc->block_default_type = IF_IDE;
     mc->default_cpu_type = TYPE_SH7751R_CPU;
+    mc->default_nic = "rtl8139";
 }
 
 DEFINE_MACHINE("r2d", r2d_machine_init)
-- 
2.31.1


