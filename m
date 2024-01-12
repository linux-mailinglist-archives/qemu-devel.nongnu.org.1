Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F141782C052
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:01:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH3u-0007gD-6h; Fri, 12 Jan 2024 07:55:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3q-0007fV-Lg
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:54:58 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3p-0006U8-6W
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bOun1zsF8nfOtU07eyhiinZkCZ4tXaO6uzVOI4lszwk=; b=1Nd+JOCPOX2pf1nv45tYLjiI43
 l2vnwwnt3+uPvZe/CQK+wvIOKr7GOtafcyHE+Goo9DRY+k0ASrcqwd2rEmBGG/+Exs+9mxCQAJZfJ
 Egwe4gXxhmTQsPh0ip/49k0Ksn2LJvewuqqH0oxJmfFPYIQ4nPF6m48QQdAImnAjFt1nJcupQ4MlR
 PMIH5PJ8G+VahV9Atf+kChO1VGcfbEY4XTEoHy3VGQpYy7oV/YY0++HOolC6P+XM25o0VNAdIfQze
 iFsP9X7amFiP1iS2kUFHMsqcN+Hizh5VGMx/myf0APFgpHFKvThcDA21q23itiVT3QBqZVcZOHLGW
 xlYY93LLbLyl1HtYsUKHx/Ni6QKxPy1UcvEjfbYkMpcaG6QntV6KBjBtImd0jFGdvqSfu4ry61Y5i
 HDagprjEhFhTCfAQFiSIl7K6fRiENMFpeKrf86kyGiWOiGOs3xVBgt0zwUoueoYw3H4Ps6n8qSsNN
 iwG8uBDytehP1+U6rtaIMeY77CwiDykYb+eeWT+xzU2DgnICxt8MKod3raaCrriVBOFSk2qdMlsKe
 UtlZ2sJzX4JeRX1Sf5ROxrJQWpJeWRVDkFvY3dOtRFYskMMtHLz/9dHWebdyVgOogOI+VYYsRmNU2
 FKPKjQksefKnwfzcZoyuYaHMrMJWGBacmer0989J8=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3A-0008jM-5l; Fri, 12 Jan 2024 12:54:20 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:52:58 +0000
Message-Id: <20240112125420.514425-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 06/88] esp: update esp_set_tc() to set STAT_TC flag
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

This flag is set once the transfer counter counts down to zero.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 8c1c6bfc1c..c7b79a2949 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -161,9 +161,15 @@ static uint32_t esp_get_tc(ESPState *s)
 
 static void esp_set_tc(ESPState *s, uint32_t dmalen)
 {
+    uint32_t old_tc = esp_get_tc(s);
+
     s->rregs[ESP_TCLO] = dmalen;
     s->rregs[ESP_TCMID] = dmalen >> 8;
     s->rregs[ESP_TCHI] = dmalen >> 16;
+
+    if (old_tc && dmalen == 0) {
+        s->rregs[ESP_RSTAT] |= STAT_TC;
+    }
 }
 
 static uint32_t esp_get_stc(ESPState *s)
-- 
2.39.2


