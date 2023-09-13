Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDEB79F313
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 22:46:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgWj8-0007xa-N8; Wed, 13 Sep 2023 16:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qgWj5-0007xN-5o
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:44:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qgWiy-0007ix-WC
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2iS8Qzhbb8035J7C/TqM8tWwK2buTw+wyqXr6GpMqIo=; b=zLA56ecOlNizbt0g3BRGtcL958
 EYZD21oBZ+hYeuNTWQs2XY4nfuUftNfULmyTVWazejmHfI0vgSR32WOYfvQg4CctW/4IGg0//XHW6
 nioanceA7+48rzKkz1gHlUR0ALRT3WxXbEH7SeZXMMe2H+aTym5vKntqkkC/1pkNuKa/m5wn9oUda
 zc/jjY4zRrCDr8MIpHIg+nXmfn9D9WU8Wa6/MkF3DLPjQN4QdKAKLO/02DYaNFGZANnqnQ3e65JVd
 zNDjxiSi8KnnAnAklMEaRnCm7FXV1ZprL6ZsFOeYz2AaWDXWN73poq2Wm2BhL8Fdz3fE4xv8lDkW0
 IaC5VBQfPvFDB07GqGPm57OyEDny7x1J8DRqpRkNn/iXoTQb/r/07XV2o/NoNQf6p7tjDt6nb+T3j
 ZpOpQqUHULadSZygc620kJC3wSkqQJqU2jAx3bosHhxbfImsNROpi95n3Vm+e1D08v0ZFAag7w1R+
 Jp5n+ZN2fTsDMhsvmJCP1Lt9OSaK48RH5aga7bYBqvv/hfM9kxiJCfd2HLpBbzG3lq/NXcS5FiYLh
 uS2oNTTn7eIHbAutkeJgRUwsB7M/tuUJGtWVBmVFHj7PeX80pgdB50hV/AUGlsWc0qJwcu6adykma
 cl2zvEmSZoSIAtr0YlUC7YYZYzQS43ahH6bijbbe0=;
Received: from [2a00:23c4:8baf:5f00:38a1:1ac:b42:501a]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qgWim-0003uU-5b; Wed, 13 Sep 2023 21:44:28 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Wed, 13 Sep 2023 21:44:10 +0100
Message-Id: <20230913204410.65650-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913204410.65650-1-mark.cave-ayland@ilande.co.uk>
References: <20230913204410.65650-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:38a1:1ac:b42:501a
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 3/3] scsi-disk: ensure that FORMAT UNIT commands are terminated
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

Otherwise when a FORMAT UNIT command is issued, the SCSI layer can become
confused because it can find itself in the situation where it thinks there
is still data to be transferred which can cause the next emulated SCSI
command to fail.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: 6ab71761 ("scsi-disk: add FORMAT UNIT command")
---
 hw/scsi/scsi-disk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e0d79c7966..4484ee8271 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1958,6 +1958,10 @@ static void scsi_disk_emulate_write_data(SCSIRequest *req)
         scsi_disk_emulate_write_same(r, r->iov.iov_base);
         break;
 
+    case FORMAT_UNIT:
+        scsi_req_complete(&r->req, GOOD);
+        break;
+
     default:
         abort();
     }
-- 
2.39.2


