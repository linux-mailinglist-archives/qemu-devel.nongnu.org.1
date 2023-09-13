Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7604579F314
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 22:46:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgWj3-0007x7-7u; Wed, 13 Sep 2023 16:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qgWj1-0007wz-Jp
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:44:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qgWit-0007a7-G8
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jndB8n2H6Bo7XmQ+0Mz5XDVcRQkLTrjD1HFlDra3TIA=; b=ciSGGjY2Kr9HY3y0VpCroENdWH
 ArgPTvRgntsnM/J5V4mvkiKN0gL6y9OvwY1eCdInhjrwsUbMV+3CC8bU6bDW/ly2AFjZAT5wkHccM
 +rvBYQKK7fEGehZx3VJeK20o9M10xXmvLM+yath5Kd0UF4RXbmOR2Ek0J0ZHIUKhUNJhy4mgTUa+w
 RgHk79N2obhCvELKak35CxihrMPhNfMQQSmiAOuK8aTzyMKeJ8g/Iv5DFZg92edLZFrl8+qkju7Yd
 EKHW6GzvuY5KnWNLi3RmIriNB1e+RTKbAXtKkoQKYmCsWQTSI4N0bLhxpzc3oiC+JgUkwsHPeF4/i
 tka5pPfRAl5uw0VasHpysNhoOTHF6BlfRqwEggJMKuYYPYopT6K3yNrTAVWYLDdBCRl63KwvkVMUC
 /KDlMpZgDSkXk8uH/wd60uLzVRPy7CHV0BeFT7MFZfdAaTFmrg4CHmPIjg/6mdhnIzDVYX/GX4WsW
 SOLOAiuNGAiiHIhkMxErFCvi0nMNaHPUGNlrU/zQCc8KqXdG/C9OrCVe7bih7mVs8I8BShQ0zEYZN
 JlY0BAcZvzWwkhHiEIyiqE80NDIiccGRVDWRg6HuOYwQAQ7PRo9Fo6R+yn83csf6GGKaxeCNUAITl
 4KHQkndkZ+5ubhR4Ik1GEFgOTl8VSZ5VeR9/psGzc=;
Received: from [2a00:23c4:8baf:5f00:38a1:1ac:b42:501a]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qgWih-0003uU-VY; Wed, 13 Sep 2023 21:44:24 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Wed, 13 Sep 2023 21:44:09 +0100
Message-Id: <20230913204410.65650-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913204410.65650-1-mark.cave-ayland@ilande.co.uk>
References: <20230913204410.65650-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:38a1:1ac:b42:501a
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 2/3] esp: restrict non-DMA transfer length to that of
 available data
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

In the case where a SCSI layer transfer is incorrectly terminated, it is
possible for a TI command to cause a SCSI buffer overflow due to the
expected transfer data length being less than the available data in the
FIFO. When this occurs the unsigned async_len variable underflows and
becomes a large offset which writes past the end of the allocated SCSI
buffer.

Restrict the non-DMA transfer length to be the smallest of the expected
transfer length and the available FIFO data to ensure that it is no longer
possible for the SCSI buffer overflow to occur.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1810
---
 hw/scsi/esp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 4218a6a960..9b11d8c573 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -759,7 +759,8 @@ static void esp_do_nodma(ESPState *s)
     }
 
     if (to_device) {
-        len = MIN(fifo8_num_used(&s->fifo), ESP_FIFO_SZ);
+        len = MIN(s->async_len, ESP_FIFO_SZ);
+        len = MIN(len, fifo8_num_used(&s->fifo));
         esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
         s->async_buf += len;
         s->async_len -= len;
-- 
2.39.2


