Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F2674168A
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:36:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEY7y-0005Tx-N3; Wed, 28 Jun 2023 12:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=C+FE=CQ=kaod.org=clg@ozlabs.org>)
 id 1qEY7w-0005TR-Pe; Wed, 28 Jun 2023 12:34:44 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=C+FE=CQ=kaod.org=clg@ozlabs.org>)
 id 1qEY7u-0001HM-H2; Wed, 28 Jun 2023 12:34:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QrnGz5dH5z4wp2;
 Thu, 29 Jun 2023 02:34:35 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QrnGv75Pnz4wgk;
 Thu, 29 Jun 2023 02:34:31 +1000 (AEST)
Message-ID: <75e183e9-f253-60f3-c7bd-a064b8887ca1@kaod.org>
Date: Wed, 28 Jun 2023 18:34:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH qemu] aspeed add montblanc bmc reference from fuji
Content-Language: en-US
To: Sittisak Sinprem <ssinprem@celestica.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 andrew@aj.id.au, srikanth@celestica.com, ssumet@celestica.com,
 thangavelu.v@celestica.com, kgengan@celestica.com,
 anandaramanv@celestica.com, Joel Stanley <joel@jms.id.au>
References: <168794501779.28884.3336012012258765799-0@git.sr.ht>
 <cd38a154-d5c3-1e22-c94f-9e1d74069f6b@kaod.org>
 <CAE+aGtVDXtPbZxC-OJvQ0R+dOk0S=_gx+0wfyJ+wbA_xn=NLMg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CAE+aGtVDXtPbZxC-OJvQ0R+dOk0S=_gx+0wfyJ+wbA_xn=NLMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=C+FE=CQ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/28/23 12:07, Sittisak Sinprem wrote:
> Got it Cedric, I just know for it,
> 
> I am fixing, and will re-send the patch as V2.

Could you please use the patch below and send in your series ?

Thanks,

C.


 From cfbc865ffe8a4dffe4ac764eb10416aa906a7170 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 28 Jun 2023 18:32:20 +0200
Subject: [PATCH] aspeed: Introduce ASPEED_RAM_SIZE helper for 32-bit hosts
  limitation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 32-bit hosts, RAM has a 2047 MB limit. Use a macro to define the
default ram size of machines (AST2600 SoC) that can have 2 GB.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
  hw/arm/aspeed.c | 21 +++++++++------------
  1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index eefd2e275015..0ae252232597 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -49,6 +49,13 @@ struct AspeedMachineState {
      uint32_t hw_strap1;
  };
  
+/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
+#if HOST_LONG_BITS == 32
+#define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)
+#else
+#define ASPEED_RAM_SIZE(sz) (sz)
+#endif
+
  /* Palmetto hardware value: 0x120CE416 */
  #define PALMETTO_BMC_HW_STRAP1 (                                        \
          SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_256MB) |               \
@@ -1504,12 +1511,7 @@ static void aspeed_machine_rainier_class_init(ObjectClass *oc, void *data)
      aspeed_machine_ast2600_class_init(oc, data);
  };
  
-/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
-#if HOST_LONG_BITS == 32
-#define FUJI_BMC_RAM_SIZE (1 * GiB)
-#else
-#define FUJI_BMC_RAM_SIZE (2 * GiB)
-#endif
+#define FUJI_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
  
  static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
  {
@@ -1533,12 +1535,7 @@ static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
      aspeed_machine_ast2600_class_init(oc, data);
  };
  
-/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
-#if HOST_LONG_BITS == 32
-#define BLETCHLEY_BMC_RAM_SIZE (1 * GiB)
-#else
-#define BLETCHLEY_BMC_RAM_SIZE (2 * GiB)
-#endif
+#define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
  
  static void aspeed_machine_bletchley_class_init(ObjectClass *oc, void *data)
  {
-- 
2.41.0



