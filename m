Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C31E07C7FB4
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:12:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD5H-00074X-0G; Fri, 13 Oct 2023 03:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5D-0006go-L0
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5B-0007LB-N1
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:43 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40675f06f1fso18639275e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183980; x=1697788780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHd17lK0WSLpUO0PshZpTk4b1bfLZ9seHeVYIVeUnz8=;
 b=SZeu2xzITDe+fkpUxlz/HKzGsZ4EGgFwrd0i3CdhXblTewb5h1F6taXSZp9o48eJfX
 8am3uZTrANmOskTGrg66XaNPk7a/bITjv2k9x6TXW5nHzSoTtadAzE7kwklr4sMqE26v
 1SPDafpMyd+3UW2qVK9RCquuI1nPuqyxQq4vDyLPyrP3Gf+1o73iGct5A8zyusEoNvmN
 utTBCLdBsGMBkr7k8213INau3IrCaqiocxgThbTbsVJDuYnumXpenD5x1TkWAqqOx/I4
 gjda9YCwuMThfHwiEfUEvhaFcTE01X8V0Fbny4ccUcvD30nu0ULe3xK69nfpdDFVI7FW
 oHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183980; x=1697788780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UHd17lK0WSLpUO0PshZpTk4b1bfLZ9seHeVYIVeUnz8=;
 b=s7yuQsWkKOUKZ505JtEgDarI17OAtW5eGlyi/3++UWQv4LjGCMv6AF54uBd+lESR4c
 ArPZhsZOJBIL7vA8+2Uud68tleD8pb0veMXqdPJV5pGqUBHLcd2rHIN1wztch5P/GKp3
 nGJ6kVKz0x+EI/EIhiNtkT0GveQzweiWdxiSTSAChT4Rl3zVu82vWvfhze7kOJg99IOZ
 mJCiqqpMoXb2KPE8ar6vNRWLElBtvIb6Wh8Twr4g2Q4uJ4zAqVnEvYEBmksEqboSioaU
 CScDcOoKTb08mdA7ou66QUeWl24Ip/viHM9NzjR4R5CB91mG5Phx49y7TAVOjNd4/UR2
 ECDA==
X-Gm-Message-State: AOJu0YyITtIFBMgNcNqJVRYqYl2J19kxnZTtFghUsms8EeYA4quei9Ai
 f08CMyZcHpB1Mx2kQ8UNun+Bo5HS3UHlYDQahf0=
X-Google-Smtp-Source: AGHT+IFIS8tT0D/RG/L81bZoviXK1ZoNg1tihJbWFrD3C1d8EP/y1WfuZm4qnywWBPKc+cLlMGZcgA==
X-Received: by 2002:a05:600c:450a:b0:401:c7ec:b930 with SMTP id
 t10-20020a05600c450a00b00401c7ecb930mr18120973wmo.10.1697183980139; 
 Fri, 13 Oct 2023 00:59:40 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:39 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [RFC PATCH v2 58/78] hw/ppc: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:25 +0300
Message-Id: <a8b851d14520d857fccaadb9097e9aa71bb7e1bc.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/ppc/pnv_bmc.c      | 2 +-
 hw/ppc/spapr_events.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index 99f1e8d7f9..9bff7d03cb 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -172,69 +172,69 @@ static int hiomap_erase(PnvPnor *pnor, uint32_t offset, uint32_t size)
 static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cmd, unsigned int cmd_len,
                        RspBuffer *rsp)
 {
     PnvPnor *pnor = PNV_PNOR(object_property_get_link(OBJECT(ibs), "pnor",
                                                       &error_abort));
     uint32_t pnor_size = pnor->size;
     uint32_t pnor_addr = PNOR_SPI_OFFSET;
     bool readonly = false;
 
     rsp_buffer_push(rsp, cmd[2]);
     rsp_buffer_push(rsp, cmd[3]);
 
     switch (cmd[2]) {
     case HIOMAP_C_MARK_DIRTY:
     case HIOMAP_C_FLUSH:
     case HIOMAP_C_ACK:
         break;
 
     case HIOMAP_C_ERASE:
         if (hiomap_erase(pnor, blocks_to_bytes(cmd[5] << 8 | cmd[4]),
                         blocks_to_bytes(cmd[7] << 8 | cmd[6]))) {
             rsp_buffer_set_error(rsp, IPMI_CC_UNSPECIFIED);
         }
         break;
 
     case HIOMAP_C_GET_INFO:
         rsp_buffer_push(rsp, 2);  /* Version 2 */
         rsp_buffer_push(rsp, BLOCK_SHIFT); /* block size */
         rsp_buffer_push(rsp, 0);  /* Timeout */
         rsp_buffer_push(rsp, 0);  /* Timeout */
         break;
 
     case HIOMAP_C_GET_FLASH_INFO:
         rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) & 0xFF);
         rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) >> 8);
         rsp_buffer_push(rsp, 0x01);  /* erase size */
         rsp_buffer_push(rsp, 0x00);  /* erase size */
         break;
 
     case HIOMAP_C_CREATE_READ_WINDOW:
         readonly = true;
-        /* Fall through */
+        fallthrough;
 
     case HIOMAP_C_CREATE_WRITE_WINDOW:
         memory_region_set_readonly(&pnor->mmio, readonly);
         memory_region_set_enabled(&pnor->mmio, true);
 
         rsp_buffer_push(rsp, bytes_to_blocks(pnor_addr) & 0xFF);
         rsp_buffer_push(rsp, bytes_to_blocks(pnor_addr) >> 8);
         rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) & 0xFF);
         rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) >> 8);
         rsp_buffer_push(rsp, 0x00); /* offset */
         rsp_buffer_push(rsp, 0x00); /* offset */
         break;
 
     case HIOMAP_C_CLOSE_WINDOW:
         memory_region_set_enabled(&pnor->mmio, false);
         break;
 
     case HIOMAP_C_DEVICE_NAME:
     case HIOMAP_C_RESET:
     case HIOMAP_C_LOCK:
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "HIOMAP: unknown command %02X\n", cmd[2]);
         break;
     }
 }
 
 #define HIOMAP   0x5a
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 4508e40814..9d51746daf 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -411,25 +411,26 @@ static const SpaprEventSource *
 rtas_event_log_to_source(SpaprMachineState *spapr, int log_type)
 {
     const SpaprEventSource *source;
 
     g_assert(spapr->event_sources);
 
     switch (log_type) {
     case RTAS_LOG_TYPE_HOTPLUG:
         source = spapr_event_sources_get_source(spapr->event_sources,
                                                 EVENT_CLASS_HOT_PLUG);
         if (spapr_ovec_test(spapr->ov5_cas, OV5_HP_EVT)) {
             g_assert(source->enabled);
             break;
         }
         /* fall through back to epow for legacy hotplug interrupt source */
+        fallthrough;
     case RTAS_LOG_TYPE_EPOW:
         source = spapr_event_sources_get_source(spapr->event_sources,
                                                 EVENT_CLASS_EPOW);
         break;
     default:
         source = NULL;
     }
 
     return source;
 }
-- 
2.39.2


