Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC3582C095
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:12:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH6N-0005tu-ST; Fri, 12 Jan 2024 07:57:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6C-0005FG-Ed
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:24 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6A-0007zb-UW
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Do91i1z/vdEnPYun5SdZNLBnRTuoV6Reo+oomgiC/Oc=; b=CJvAKNcMOwiDK/i0z97v3E9hR8
 hveYyZE1M6Obk/4c8XZQcBkSH7u1cSvOF7EoM5j3raV4VMNulkPVhHKhE+3Ar4D1odlYgopdtSPCx
 PyLyod0pRGJTsEyegt/nYtCoBgrLUeOxb+DpoM4s7XL9Hkenor0DPH9rG1D/S9HinN/j6+aFCSTuT
 XDAxMEMiiBO5/L3R78KDiwTTmKguhEB5XSA4G43oh/ehVkETAPHwuJgstIFbInqywRx/vjj65oL7L
 U39NVnKZAzGDxOnWU5B+AvmS4JuYhAtVo825eRfa9yZTEjbIb560orxFjuqwIMlqFqsYQY8pPF9R+
 JkWUomvBsAhM8V4m8vzFQGVUkCMdAYTEOekthOp1SBQ1SCRPYX2embEk6znyWWXDA35/nP8rukk9R
 WrMGqHb3aqQ1zh0XlEhRuxRvUtCEby/39zz9/EPleKWlr9sDHiZjbhLFmZxISQr1b7rthdDyhT3j9
 hLbVt2uY0Q0tY+GwfEJ0XEzeY4mCMZGBwirnywtGGjuCxYpH++4QXm5ZbCx3IIPTJEnir/C595l14
 ok/wLIAl/negydQfKOaY7uVt/rZ+G44OO+kjS2KVjRJQsXOmlTSpbmBgMxk5dqNQ06+6HpqXh0flE
 qV/HYuRxt4pN//UF3nz5V9AjwA4km29KJt3frHl5s=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5E-0008jM-PX; Fri, 12 Jan 2024 12:56:28 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:36 +0000
Message-Id: <20240112125420.514425-45-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 44/88] esp.c: convert esp_reg_write() do_cmd path to check for
 SCSI phase instead
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

Currently do_cmd is used to determine whether MESSAGE OUT and COMMAND phase data
is being accumulated in cmdfifo. Update esp_do_dma() to check directly for these
two SCSI phases instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 14759ada78..e679b1c39b 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1207,7 +1207,7 @@ void esp_reg_write(ESPState *s, uint32_t saddr, uint64_t val)
         s->rregs[ESP_RSTAT] &= ~STAT_TC;
         break;
     case ESP_FIFO:
-        if (s->do_cmd) {
+        if (esp_get_phase(s) == STAT_MO || esp_get_phase(s) == STAT_CD) {
             if (!fifo8_is_full(&s->fifo)) {
                 esp_fifo_push(&s->fifo, val);
                 esp_fifo_push(&s->cmdfifo, fifo8_pop(&s->fifo));
-- 
2.39.2


