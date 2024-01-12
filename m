Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E1C82C0B0
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:18:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHOe-0004fp-EZ; Fri, 12 Jan 2024 08:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHO8-000489-Dc
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:15:58 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHO6-0008Qm-CL
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cPFSvw0wPN9INdytdMaa3N76yZW184wgmgBIri0iNeg=; b=fg2rpQnwN+JJ1TKdoZEvviTY9T
 lFhUnLyLxunOXKLPWZOxzckRqeEYWuVEEAJ86cSfEIzprpX+t6N83kf3JM62CaOrF6/8bnEHobs4W
 8Ffvy4dp9SfU6YLTUsNEzoU07/voVRH0SigdlcUcR/B4KjuWhOl9NUcz9qG7Q9YxfyhZxLteF96bw
 OAGWBftordJBs4z4LBn2vbYbmvEfavIWYXy9tN4MLbYLkVDVwSj9AgcVaxFesPAFawHCY8WAAOPwn
 OH2W616dHolu9jijkOHneM7P1V4sCwBOe+fwJmhKpn/3qc4dW/J+lj7kRoTz/efey/5T7mWo53YBw
 g5DJZDxIDm6bUtCcjA4fQtFqWFy1XNhcGI/8PpKVRg+2h8td1oyCracVBPMuSHBpGpiufMj/GmO5U
 a/iUEhgDlmE3E7obm4U63JdkNtGM/WWuTn1pBKgFAhyK62LE6Fv6KuNwBltv5ncEfgPj622qZxYL6
 4JzeDfMrQKi6DE30zFHYN9F8Ww4OFuii4474YG7lT7hJQmyJgADft2zwoEHOqSHMtCWM3EarQFO5p
 zINCgC5AX2rNmlvqymXXCjh7z+pq1ISfudPs+Rv4VQi4iE6zkTiNXAwIG7rdYI8ssbEI1cTnhmLwf
 FfzvgXVWZdpa8kzAr67YZ02Qje3s1pVqU/6VnPWzk=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHNR-0009Gy-S7; Fri, 12 Jan 2024 13:15:17 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org, deller@gmx.de,
 linux@roeck-us.net, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 13:15:29 +0000
Message-Id: <20240112131529.515642-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112131529.515642-1-mark.cave-ayland@ilande.co.uk>
References: <20240112131529.515642-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 4/4] esp-pci.c: set DMA_STAT_BCMBLT when BLAST command issued
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

Even though the BLAST command isn't fully implemented in QEMU, the DMA_STAT_BCMBLT
bit should be set after the command has been issued to indicate that the command
has completed.

This fixes an issue with the DC390 DOS driver which issues the BLAST command as
part of its normal error recovery routine at startup, and otherwise sits in a
tight loop waiting for DMA_STAT_BCMBLT to be set before continuing.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 875a49199d..42d9d2e483 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -124,6 +124,7 @@ static void esp_pci_handle_blast(PCIESPState *pci, uint32_t val)
 {
     trace_esp_pci_dma_blast(val);
     qemu_log_mask(LOG_UNIMP, "am53c974: cmd BLAST not implemented\n");
+    pci->dma_regs[DMA_STAT] |= DMA_STAT_BCMBLT;
 }
 
 static void esp_pci_handle_abort(PCIESPState *pci, uint32_t val)
-- 
2.39.2


