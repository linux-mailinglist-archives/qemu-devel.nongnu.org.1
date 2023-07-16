Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D49754ED4
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 15:37:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qL1ul-0001c6-5f; Sun, 16 Jul 2023 09:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qL1uh-0001bn-Ms
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 09:35:52 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qL1uf-0007IW-FG
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 09:35:51 -0400
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-99357737980so520555466b.2
 for <qemu-devel@nongnu.org>; Sun, 16 Jul 2023 06:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689514546; x=1692106546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=We2n9WQvoGrrZmo3ZhgFvy3phFiDh5U7AmKN8h7uQqU=;
 b=RFdOK+5C9J8L6BJekFJUU/gubjuOvqzVj7Z1AFJxfdbq4rvzwGTQuSCV1sEq1QXTRJ
 PF9BCdMdyXfkQwBkMTVET0zfdsQUJ6J437G5p5O0PFxMZBUC6XlNCOiDzJCSUhKLxg+G
 WUvXCy+lTsoVaaZQlJHr5kFX8P6bsPfC7GFiPjV/QZIJDeChCHJFrdGiVOzwjMcKBEKK
 o7wvtJmVM+I83IEk7c2t7fu3k2K9YP6sgJrqAiFRD/z4B8CMG9Qk1RVrovkk/IVHtvF7
 4zAdcG/BP5TUkwY9/PbFrSzpBBgb0HOlmmxA80atfdgvwW7DVUgeGMRJOAuXIplp84IV
 qeKA==
X-Gm-Message-State: ABy/qLbDlbppOfkFfcjwC6OiHMhavdct19/wLuhWNeX5wyGCOxSpksde
 KqXyxRT8mH+hxSeUgZFMAVg=
X-Google-Smtp-Source: APBJJlGz1Es7Lrz79asB7yVuyTEnpmbO96BE2wC6tcoO/fYZFke67sdXomCv/Kq6XimpGIqonjWzSg==
X-Received: by 2002:a17:906:225c:b0:993:dd1d:8251 with SMTP id
 28-20020a170906225c00b00993dd1d8251mr11141302ejr.28.1689514546176; 
 Sun, 16 Jul 2023 06:35:46 -0700 (PDT)
Received: from fedora.. (tmo-097-144.customers.d1-online.com. [80.187.97.144])
 by smtp.gmail.com with ESMTPSA id
 t23-20020a1709066bd700b00992025654c1sm7965379ejs.179.2023.07.16.06.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Jul 2023 06:35:45 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH] hw/char/escc: Implement loopback mode
Date: Sun, 16 Jul 2023 17:35:19 +0200
Message-ID: <20230716153519.31722-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.42; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f42.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The firmware of the m68k next-cube machine uses the loopback mode
for self-testing the hardware and currently fails during this step.
By implementing the loopback mode, we can make the firmware pass
to the next step.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/char/escc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index 4f3872bfe9..4be66053c1 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -653,7 +653,9 @@ static void escc_mem_write(void *opaque, hwaddr addr,
         escc_update_irq(s);
         s->tx = val;
         if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { /* tx enabled */
-            if (qemu_chr_fe_backend_connected(&s->chr)) {
+            if (s->wregs[W_MISC2] & MISC2_LCL_LOOP) {
+                serial_receive_byte(s, s->tx);
+            } else if (qemu_chr_fe_backend_connected(&s->chr)) {
                 /*
                  * XXX this blocks entire thread. Rewrite to use
                  * qemu_chr_fe_write and background I/O callbacks
-- 
2.41.0


