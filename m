Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE0A82C043
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:59:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH4t-0000qS-1B; Fri, 12 Jan 2024 07:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4q-0000lk-8Z
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:00 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4o-00075I-A4
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JkX7WGFxHLJ8aWALorhF1bcRcASoyBoUM32C8OS0urY=; b=SMxQuEhoW0x2jrwwhW7PL4gFE1
 kOLSrFbX4OfUeAHRsb3b3XpGYFbNr8Md5NLEmbD7z7RY6Mqj391aq4qmGKtNCQmfTXoG0KA5HtJwd
 awwpawexwVz74Gty+JuqJp6DkYtcN/HYcckucGQCEyFBRGxo7BOBNW7M/bI4Cri1gzSab4fPdCq8y
 4BoNsEnDGJf/4kB1Z8LVvd/05SanFFCpqeY/89ic6nR4V+apeRAmUBUtAXizUnuFh3taaoXLqFX3/
 1EF/LzikYOAPuFE2IV9zFqWfdFYnqdgYtm/Mk3Dsfzg/gxrNdFukIlhfeP6SiUHPfG5HOkj1VvXHh
 cQQlQCe4KdtCHJ/smR04JBN+38AUNy2mtRLxPzobaqP5sPp+8j1GK6v0ENkIYkysHE6jTBDpTIBtn
 TpM6am24MBawXYSq9qW/bC+boOpe+dH8Vi8wWqxVVu3FMBQaKqfaGjYEAn/euTwzqIGus2Trk+5P1
 YlTkc6aObc5fjm0F2BfDWQBFSEmRvHbwcCzT9YI3H3uI/eFpYd37bsUkf8vSA/4OLSw2Smpg11kJb
 jsDZaUA6tnsPy9fm7VtZcXLV0eTUY1caYyTFzh5OOYJjAQuXc34wnP2YQurcYKuGVxXgvueVdfxxe
 bdOykqrX4hz2xvHTGjQb58ulb6dMWFeTMhQjDxPjw=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH40-0008jM-6s; Fri, 12 Jan 2024 12:55:12 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:11 +0000
Message-Id: <20240112125420.514425-20-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 19/88] esp: remove zero transfer size check from esp_do_dma()
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

The TI end of transfer interrupt only occurs when the TC reaches zero and is
not related to the SCSI layer transfer.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 5b9c3f1e5e..dc515e6435 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -748,7 +748,7 @@ static void esp_do_dma(ESPState *s)
                  * complete the DMA operation immediately.  Otherwise defer
                  * until the scsi layer has completed.
                  */
-                if (esp_get_tc(s) != 0 || s->ti_size == 0) {
+                if (esp_get_tc(s) != 0) {
                     return;
                 }
             }
-- 
2.39.2


