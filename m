Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B30A7E6BFD
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:04:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15bw-0003RF-V3; Thu, 09 Nov 2023 09:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15ar-0006Nh-M8; Thu, 09 Nov 2023 09:01:20 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15al-000623-To; Thu, 09 Nov 2023 09:01:13 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6E69831BC8;
 Thu,  9 Nov 2023 16:59:42 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 77E8B34501;
 Thu,  9 Nov 2023 16:59:34 +0300 (MSK)
Received: (nullmailer pid 1462809 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 18/62] esp: restrict non-DMA transfer length to that of
 available data
Date: Thu,  9 Nov 2023 16:58:46 +0300
Message-Id: <20231109135933.1462615-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230913204410.65650-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 77668e4b9bca03a856c27ba899a2513ddf52bb52)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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


