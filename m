Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B78970E61E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 21:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Y7O-0000QL-12; Tue, 23 May 2023 15:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y7L-0000PL-Ie; Tue, 23 May 2023 15:56:23 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y7J-0006Sf-Pf; Tue, 23 May 2023 15:56:23 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-96f5d651170so1069796666b.1; 
 Tue, 23 May 2023 12:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684871779; x=1687463779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iS6IllWr8xotqYJ+kDfnN1bLpimUHqJGv84Pvf7+lk4=;
 b=noYpsQ38ZTHGFEc4EdG9nozXZHSKxaIFk5ZE03hFwGNk4fnAWEPS+Zri61YEBXBzIP
 /c8FwTuQjSkUF9H9sV0LpGQMQ2S9jJP6JgBoqgS4Delf3Wn/2wLx9anYaXFb8pJAReir
 X9pGmNn9yRwWmDXjslE/mYVXQj/qh0LVsQi0gEMZbxz2e8sbas7iw/mFoRraqvId2uEZ
 nN2E6826CbhBgcDuMbFJ1835C23jYNK9GeTFa0R8wJ1SoiUj2NOxnm0qRKJUJohQSxhn
 x5BHVyrm3f+EBgOlJ0yQF67xs3eByd2cqFLbwj8MR0ZlElMsJKoe3S1nLUquwI7NBzbL
 Fv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684871779; x=1687463779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iS6IllWr8xotqYJ+kDfnN1bLpimUHqJGv84Pvf7+lk4=;
 b=GNz0pViaTbRL5YbzDQJPlcDhu9ah9Ki+De0pJrDoGTTf+/Jt6D73i1BA55yRfKZMAL
 fSd78rgokRiHix4POCfcG/eW1dLBhCR8v+zsYzpFuYmDbz9IyRZt8DGnYQKgR+R2Ih2W
 /Ndm9SoFoQQaG0BZia9I40S8WvNDpZlO19sELjXUx6KDmM7K1AuwInA3W9N6A+adq7Eu
 5+tXncdASQWkwmx1ihpbCpDr5WvN8pTIHHxgTOm1QBmQUIrSbDJNAqdfvo6n8ohxoWlE
 /E2KrY0PiMUJxzjknTF3SeXjuVzDk00bIFE7afMvBNFBfEiaiiDTeVT9/hOPqTCVzq3L
 nvdA==
X-Gm-Message-State: AC+VfDzMe/J1rb0YyMCddAEZmVT6Gkldwb9Of9UGOBAC+iQv1DHh86N6
 kT/a63rUFNLo50vEf5E8ROPWZKkSfmA=
X-Google-Smtp-Source: ACHHUZ5ftlxumZm0nTwAfRd4UNE9Cbg4NAs/E0kx40xKu0kP60UAZIOWIPXln9ZLAXy3Af+H1wbeOg==
X-Received: by 2002:a17:907:d15:b0:966:4669:7e8d with SMTP id
 gn21-20020a1709070d1500b0096646697e8dmr15182949ejc.16.1684871779340; 
 Tue, 23 May 2023 12:56:19 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-183-025-113.77.183.pool.telefonica.de. [77.183.25.113])
 by smtp.gmail.com with ESMTPSA id
 dk13-20020a170906f0cd00b00965af4c7f07sm4737740ejb.20.2023.05.23.12.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 12:56:19 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/3] hw/arm/omap: Remove unused omap_uart_attach()
Date: Tue, 23 May 2023 21:56:07 +0200
Message-Id: <20230523195608.125820-3-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523195608.125820-1-shentey@gmail.com>
References: <20230523195608.125820-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The function is unused since commit
bdad3654d3c55f478e538037d9eccd204e5fc8ee ('hw/arm/nseries: Remove
invalid/unnecessary n8x0_uart_setup()').

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/omap.h | 1 -
 hw/char/omap_uart.c   | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index c275d9b681..067e9419f7 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -724,7 +724,6 @@ struct omap_uart_s *omap2_uart_init(MemoryRegion *sysmem,
                 qemu_irq txdma, qemu_irq rxdma,
                 const char *label, Chardev *chr);
 void omap_uart_reset(struct omap_uart_s *s);
-void omap_uart_attach(struct omap_uart_s *s, Chardev *chr);
 
 struct omap_mpuio_s;
 qemu_irq *omap_mpuio_in_get(struct omap_mpuio_s *s);
diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index 1c890b9201..6848bddb4e 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -175,12 +175,3 @@ struct omap_uart_s *omap2_uart_init(MemoryRegion *sysmem,
 
     return s;
 }
-
-void omap_uart_attach(struct omap_uart_s *s, Chardev *chr)
-{
-    /* TODO: Should reuse or destroy current s->serial */
-    s->serial = serial_mm_init(get_system_memory(), s->base, 2, s->irq,
-                               omap_clk_getrate(s->fclk) / 16,
-                               chr ?: qemu_chr_new("null", "null", NULL),
-                               DEVICE_NATIVE_ENDIAN);
-}
-- 
2.40.1


