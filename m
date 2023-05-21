Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EEE70AE12
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 14:33:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0iDT-000237-Ak; Sun, 21 May 2023 08:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0iDI-0001ve-D8; Sun, 21 May 2023 08:31:05 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0iDG-0001kP-Og; Sun, 21 May 2023 08:31:04 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-96fab30d1e1so189865766b.0; 
 Sun, 21 May 2023 05:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684672260; x=1687264260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iS6IllWr8xotqYJ+kDfnN1bLpimUHqJGv84Pvf7+lk4=;
 b=a/jNERZFkl+kJSIwUXyJzXDh4DSKma9BEljQQzTxsBjhukBUK/ysk4ZUHZK7L4NP22
 8yu6odfXYDZPq3pBiL4Y2RiSRec0oHnbYQcpwTb6SwLDlhnF+tl2MpP4M475+OiLb98O
 DcbE//auu8+ZXtrfhaR/gFU4dPT17b/8wSU5V7TjPSZKt5bpaYy3trEa5yNqTIBXIBMy
 fk97INAkXGEMFWp1toN4BAC92xnriPb/S2iCo4X+rlLZS4z60Ai611xoBQsPxgTS825H
 fPL58gMriZ0Vl0aLf6SQudt2fXdhqHQMxe884Mrbg4oj+8Dk/Jmgi5/XFQ0dZNmcM411
 /XJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684672260; x=1687264260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iS6IllWr8xotqYJ+kDfnN1bLpimUHqJGv84Pvf7+lk4=;
 b=TCRIHZzkIFlAQAwZDiKqYU2S0tfkTukKdYYKDN9e0X3xuvGMyKxs9b1XA8113e/jQJ
 4yTL+kohkDUlN2I5FK2lohJLFu8ejUvrYBBimnl0YPcQZB5YYKfI0WiIBVYvkv7vVfvL
 m4DI5A2xiVHayuKfXUn0LDZvOYWrpnRnkpJxOaoLGpZ2OhKOazSA5BlHECtcyQlvo7OW
 a41OE4u2aZ/DBx2zMU+LXptBNUTZKKeKvvSO+1j4IBNxHWHv+p7Y17XiIF6ZGzGWFY80
 EnQiQ2PxQ5VAt8pEcKFwEtP1w25VsFKybHdpkWkYxKlc2QN25mOSd0f9qEmbp7G+wg/9
 GluA==
X-Gm-Message-State: AC+VfDyRAKrs262Q2ZfNkd4EI9Pv94PV+aDn9G2CysWO1PhXJCGAfyAD
 iOV7cKdAFmk7MBwn+3e3fsvHDrl/Fno=
X-Google-Smtp-Source: ACHHUZ42H06+SnWQSEWDenwjJxBuXx+mHeiphUa1vfu5nOi2EHaouOvZIDLNmi6yBsjbzSgtRwqxfA==
X-Received: by 2002:a17:907:1688:b0:965:d7c7:24db with SMTP id
 hc8-20020a170907168800b00965d7c724dbmr6541782ejc.32.1684672259921; 
 Sun, 21 May 2023 05:30:59 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-191-145-122.77.191.pool.telefonica.de. [77.191.145.122])
 by smtp.gmail.com with ESMTPSA id
 b19-20020a170906729300b00965ec1faf27sm1882678ejl.74.2023.05.21.05.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 May 2023 05:30:59 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/6] hw/arm/omap: Remove unused omap_uart_attach()
Date: Sun, 21 May 2023 14:30:45 +0200
Message-Id: <20230521123049.312349-3-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230521123049.312349-1-shentey@gmail.com>
References: <20230521123049.312349-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
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


