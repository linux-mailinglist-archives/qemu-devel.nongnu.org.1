Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED532A18C98
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Jan 2025 08:12:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUrt-0005BA-KP; Wed, 22 Jan 2025 02:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1taUrp-00056E-V5
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:09:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1taUro-0008O2-AG
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737529774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ayl2E/VrUl+Llrmlcin4PivEBLaP2DgTB+tiRIfVc+M=;
 b=UxlHcGS4XPvRTZIiEoscGx2M4QI0jnirPXAKUcgpKjWWVimGp8/FMGWINLlVH6FPeLB+2l
 VarziGobvR9XGELib2OcWSFAiIRvkJ/r9OoVMtSldnDm3jw6t49xPrbFIGJOY7gK3Rinwv
 /Codiz2nPgdEa2wg3eJ4ftPmb17gv4o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-sNhgmxi9NqGM0qr2kchdLw-1; Wed,
 22 Jan 2025 02:09:28 -0500
X-MC-Unique: sNhgmxi9NqGM0qr2kchdLw-1
X-Mimecast-MFC-AGG-ID: sNhgmxi9NqGM0qr2kchdLw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC6C619560A2; Wed, 22 Jan 2025 07:09:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C9233003FD1; Wed, 22 Jan 2025 07:09:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 3/9] hw/arm/aspeed: Invert sdhci write protected pin for
 AST2600 EVB
Date: Wed, 22 Jan 2025 08:09:03 +0100
Message-ID: <20250122070909.1138598-4-clg@redhat.com>
In-Reply-To: <20250122070909.1138598-1-clg@redhat.com>
References: <20250122070909.1138598-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The Write Protect pin of SDHCI model is default active low to match the SDHCI
spec. So, write enable the bit 19 should be 1 and write protected the bit 19
should be 0 at the Present State Register (0x24).

According to the design of AST2600 EVB, the Write Protected pin is active
high by default. To support it, introduces a new "sdhci_wp_inverted"
property in ASPEED MACHINE State and set it true for AST2600 EVB
and set "wp_inverted" property true of sdhci-generic model.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20241114094839.4128404-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed.h | 1 +
 hw/arm/aspeed.c         | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index cbeacb214ca4..9cae45a1c99c 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -39,6 +39,7 @@ struct AspeedMachineClass {
     uint32_t macs_mask;
     void (*i2c_init)(AspeedMachineState *bmc);
     uint32_t uart_default;
+    bool sdhci_wp_inverted;
 };
 
 
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 2662465ada4f..53a859a6e4aa 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -409,6 +409,12 @@ static void aspeed_machine_init(MachineState *machine)
                              OBJECT(get_system_memory()), &error_abort);
     object_property_set_link(OBJECT(bmc->soc), "dram",
                              OBJECT(machine->ram), &error_abort);
+    if (amc->sdhci_wp_inverted) {
+        for (i = 0; i < bmc->soc->sdhci.num_slots; i++) {
+            object_property_set_bool(OBJECT(&bmc->soc->sdhci.slots[i]),
+                                     "wp-inverted", true, &error_abort);
+        }
+    }
     if (machine->kernel_filename) {
         /*
          * When booting with a -kernel command line there is no u-boot
@@ -1415,6 +1421,7 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 1;
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON |
                      ASPEED_MAC3_ON;
+    amc->sdhci_wp_inverted = true;
     amc->i2c_init  = ast2600_evb_i2c_init;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
-- 
2.48.1


