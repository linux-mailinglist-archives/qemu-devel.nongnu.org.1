Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4277882C06E
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:05:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHBX-0006nb-2t; Fri, 12 Jan 2024 08:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHBN-00061K-IN
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:02:45 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHBL-00027H-LI
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YaFxIth4U9eE5pdikW1aXAmuWvCgiaPW5YzRJYFSYPk=; b=lMTeBHTkXtEMoe12dq9XcAEwZ9
 1W2yHNuecGRWusMXEJAdiyR1FPYEuMbOZmkumxetO51+fZZxt6i8ISWGuOwBR7prq62QPJ/6T3FuC
 CyRbVn4yGaI6FwsebYnrk8b/Z6MF90qO+9qdTX6LysHYNImMVE8CkxWzRblUroT5rY8d6dMvRaVai
 HFe0DziJmZKbMAxgJhoRYTDWR1xcuXyE1eeyid6UZ80efeb6SCU61SVNCKwiyqY4lovUlnDSAAJO5
 EFj4kxyd2XrxgCyxPkuvtFZdtSG3esgIsY0yKszcCfAYFXII48bq2Pu8JmCK+fOJ4AWSfkO+/4E+u
 +LiiodoHcqKKjOQaRQSVcwuQ6Bt/OCQmc6BuTg4fyMkkRj0toQevwAuP3DOgIYGYaL5V+mrI1d+T7
 Ikn69BK4i+5bIF+m+X0kgmejhWdtwb1v2VDn8wuKG08BirXPU28Sp9eOsUAOQevH4YHu660fWzNt4
 gm1jeRx5PQS+bffA4Yp8XVJCYg6zWoH0jrP8terWRaeZqZPeT01GgJFlRB9I47pY/hWrZC+E0psqJ
 /+9dea7bMwd+j1N9WQepBbFwhoUcg+S3Ie6zFHB/BxIgfMaM/YFUUpIES0pXrLQriba4FXpfie2mt
 9qQvtUvUJmsVx8Fw7w0nVOjlGN6mNcEs3UCasj2R4=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH60-0008jM-6e; Fri, 12 Jan 2024 12:57:14 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:51 +0000
Message-Id: <20240112125420.514425-60-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 59/88] esp.c: separate logic based upon ESP command in
 esp_transfer_data()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The handling of the INTR_FC and INTR_BS bits is different depending upon the
last command executed by the ESP. Note that currently INTR_FC is managed
elsewhere, but that will change soon.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 75538f5859..b6cf1b43db 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -862,13 +862,33 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
     s->async_buf = scsi_req_get_buf(req);
 
     if (!to_device && !s->data_ready) {
-        /*
-         * Initial incoming data xfer is complete so raise command
-         * completion interrupt
-         */
         s->data_ready = true;
-        s->rregs[ESP_RINTR] |= INTR_BS;
-        esp_raise_irq(s);
+
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_SEL | CMD_DMA:
+        case CMD_SEL:
+        case CMD_SELATN | CMD_DMA:
+        case CMD_SELATN:
+        case CMD_SELATNS | CMD_DMA:
+        case CMD_SELATNS:
+            /*
+             * Initial incoming data xfer is complete so raise command
+             * completion interrupt
+             */
+             s->rregs[ESP_RINTR] |= INTR_BS;
+             esp_raise_irq(s);
+             break;
+
+        case CMD_TI | CMD_DMA:
+        case CMD_TI:
+            /*
+             * Bus service interrupt raised because of initial change to
+             * DATA phase
+             */
+            s->rregs[ESP_RINTR] |= INTR_BS;
+            esp_raise_irq(s);
+            break;
+        }
     }
 
     /*
-- 
2.39.2


