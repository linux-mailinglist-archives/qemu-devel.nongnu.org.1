Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B2082C045
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:00:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH3t-0007fw-3F; Fri, 12 Jan 2024 07:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3m-0007eB-4p
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:54:54 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3j-0006QG-Ia
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jt2y0PgrrcIgnCVtfPN4JS85f4NUUFLJ2eLjR16bKV4=; b=v/kgi89KgRs3okHg9NouT8kUuI
 1donAzmZsVUpt1t+vg2uVwsDI6Ksoa2MmIGkW7lvqQkV/06z1dEvApsEvAEQg2+HtAaWAB9oGVsY4
 vT9hvBfpV6pAhMDdPsg/J+xeQDtJVlNibMhIgUORVjgkGYOL1deqXFhlpdZGk47akNM9zkrUQMt/E
 49jIWKb2Sm9Kd2rhwgk5wIa4drNcBtBXP0DrHmJetuDDpOQfi4R8W0fNATrp63GZ3DIDBRVatqy91
 XUl2OLfW26qFnVpftboMhCOfEAEcTh8ophRTor6k55tGtQUYrsW/j2Gc1lV4bby7yHd9eUIRpvlkm
 AhCF36ZYxQsRnxX+1Zoiic1GFqFf4F5xt+ASp5cGeEHhiRvUSYzy5g31i5k6MQCDaPFdK0FZOj9uI
 q5Xpcy+mbiUoU5l7+k1ADAv7atd2cKE++I14ZRPSq69fsnkhXqUSSaFRvf7FHU0ec405k1LMuhTug
 eSo+ueeNXgLq9xfN3RsUeG/hJNF5ZnnhpfkCfjGmSt83GsJCZqjn/175/9PNSxHseNBoeCJUwM0Ja
 LVcmnKpzJceDvcYYISeuPC8hKESKX9q50NUW/30dq8ClPBBU4TT3Y8bI7M6TDo3kaAoNh18qHB3Ds
 VU//W4iqK6fbfhGLJ71rJjtD+Y0KOvwQD1o7o1HV8=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH35-0008jM-Fo; Fri, 12 Jan 2024 12:54:15 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:52:56 +0000
Message-Id: <20240112125420.514425-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 04/88] esp: remove FIFO clear from esp_select()
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

The FIFO contents should not be affected by performing SCSI target selection.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 8d8f6a817a..89fce05e58 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -220,7 +220,6 @@ static int esp_select(ESPState *s)
     target = s->wregs[ESP_WBUSID] & BUSID_DID;
 
     s->ti_size = 0;
-    fifo8_reset(&s->fifo);
 
     if (s->current_req) {
         /* Started a new command before the old one finished. Cancel it. */
-- 
2.39.2


