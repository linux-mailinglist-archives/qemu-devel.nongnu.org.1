Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E30A7D7F21
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:58:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvwB5-0005jG-Nh; Thu, 26 Oct 2023 04:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvwB2-0005iG-LD
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:57:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvwAy-00061d-Ta
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RKgvM8BfA8HJdcm/PeCzGne0iIyf0WNTzf87F/1YudI=; b=m+yqbRjTQoUXO+uVgAJLWCaApb
 kFpdyTyuQPiz4cQV4NO5V/uL1KWULJOgWO5txtAzRD8UvISmItHs40pTX1a1vUeMNQpdbH5ijEVaj
 r/9lBiyyQQ/EUoWIQu+XD15i4n71NlFuLnRsaTCxB+oVO6v7QImWcssW0jJKJrJcDG23Gg2/WUMZr
 wh7OohOWWL8gC6KpS8hYXbXBgZTdCQK7eLqd3PrL3rxdW/4/lIW7w5PU18s5eneWA9vQ41d7sj0lC
 XpaACswLEFbNf4FrW6Ig4o8WVsNwjn30BAi/Ex1GiAgtpFiJj1pI2CWec7NyDR2CM/LU4kY4OY7Sp
 RDFhF4dlAfC2I5CMVONea/oAZI65fWQ9wefsqglJOp9myANn/Z7mCBKWbkjUPWpnaC9b/Nh9Td4Ea
 HEyNLUVOseLWqq1oIxzfHRGUjfmYlFxPqo6o0qC+XrHuDP4xeB0KUQsS9rrvoGdQbxUGmP5qvc7OX
 xhJrBWIMIBmTzJMckINjHtnsdqvlYJcjWA/qiNwEK6SYjc2iFNUTSiT5tzkG06UERO8xwK1rYnHI7
 p7mC2OWfVbDsNBJAHMw6W+qNnAc1Mb4sCtSz2uR/OOE4S759h+f+d1svtMqMNXI6a3CVCUG/YwddK
 IUq3ZWY092g39RA6/JrBUwP1oBdzu7K7EWjO7Rm4Y=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvwAn-0000md-Mi; Thu, 26 Oct 2023 09:57:05 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Thu, 26 Oct 2023 09:56:50 +0100
Message-Id: <20231026085650.917663-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026085650.917663-1-mark.cave-ayland@ilande.co.uk>
References: <20231026085650.917663-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 4/4] macfb: allow reads from the DAFB_LUT register
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

This enables A/UX to correctly retrieve the LUT entries when used with
applications that use the MacOS Device Manager Status (GetEntries) call.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/macfb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 4a1c75d572..d61541ccb5 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -537,6 +537,11 @@ static uint64_t macfb_ctrl_read(void *opaque,
     case DAFB_MODE_SENSE:
         val = macfb_sense_read(s);
         break;
+    case DAFB_LUT ... DAFB_LUT + 3:
+        val = s->color_palette[s->palette_current];
+        s->palette_current = (s->palette_current + 1) %
+                             ARRAY_SIZE(s->color_palette);
+        break;
     default:
         if (addr < MACFB_CTRL_TOPADDR) {
             val = s->regs[addr >> 2];
-- 
2.39.2


