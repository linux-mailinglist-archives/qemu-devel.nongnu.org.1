Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAB870AE14
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 14:33:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0iDR-0001yi-6p; Sun, 21 May 2023 08:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0iDN-0001w0-Lh; Sun, 21 May 2023 08:31:09 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0iDI-0001kq-5C; Sun, 21 May 2023 08:31:05 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9659e9bbff5so928451366b.1; 
 Sun, 21 May 2023 05:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684672261; x=1687264261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+kzg83eZnbuI0aq/ydKr/xkgLTYwwbEGaXyAFBj3HY=;
 b=BmgtQd0RMO9XNHqBY+gMCT+AyQVCDrENTFVH2KwG7cY+lvuYEmytLTpixcXOQPCU6F
 9EUwq4lqSoKfBoTbB9xZ6rA6G6Vswzer71DYQ/e9p8gw6h8qDqqJn8iFAD2NfqMRn/50
 wkej6Vsvse6AbEY2jXo0jshUyRtYapOUTCJ1azDv/OjfCc1drQ2tkGwYE7oyS7WbPNza
 d7KaCdizDwX3J8SrqBrz4JFkXRBngzKo27oD0y9HSW1zSixVz8ppUq39BwJL1GNR/ofq
 px7ReGtvwp75vTpY2Mmy3Vj1BICGY4peJHGCnirbTTOMSvBwZW4KuR+VxCJsgWkAxPoh
 2VhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684672261; x=1687264261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+kzg83eZnbuI0aq/ydKr/xkgLTYwwbEGaXyAFBj3HY=;
 b=XcryUl2YFcMltXeKOYnTAxCehIJZUslZJLQWz2DG3I0Yac9bXH9PNxQZvYWRRR60Vy
 WsksOEQ2Wtb8pT0N5maaJFikyGD3U7B61Fft8IPw3mEMsPo5u62o/luuPmecxeS4543n
 cfha26Nwv6FvIl6/GSyf7pNvd/A39Wl08N5FaV34YaY2PnT88oLLyrhH0FWrt9F34hLZ
 6Wr5S/Is2TsW6HkIStG2ZzwaQkfktdb5FIG0Kyt5MLsEhHEyB0tOLBuAP7N6Zo8xQXvO
 +owFPhFh4a2p3AeUmeA7/0CQLdZ3tG5+ehviYsdl2luHFaWCMcRQTv16cMGTRB7NKdc/
 CgVg==
X-Gm-Message-State: AC+VfDy+JZ0m8kJ0CWWl189vM9pVjwMdh7y8SWtuWmH9j11kZP5tA5XZ
 NLs+ef9vKbTLrQFVvrQH205fMwm9hEM=
X-Google-Smtp-Source: ACHHUZ4Oy2LcvaRUIKkFK6Zn/pgNeyDkk4bjuEpAHu6aR8n2C4VxI49AgRDT/EbkEkE9I7sf1XMxnQ==
X-Received: by 2002:a17:907:25c2:b0:969:edf8:f73b with SMTP id
 ae2-20020a17090725c200b00969edf8f73bmr6672640ejc.60.1684672261339; 
 Sun, 21 May 2023 05:31:01 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-191-145-122.77.191.pool.telefonica.de. [77.191.145.122])
 by smtp.gmail.com with ESMTPSA id
 b19-20020a170906729300b00965ec1faf27sm1882678ejl.74.2023.05.21.05.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 May 2023 05:31:00 -0700 (PDT)
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v2 3/6] hw/isa/i82378: Remove unused "io" attribute
Date: Sun, 21 May 2023 14:30:46 +0200
Message-Id: <20230521123049.312349-4-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230521123049.312349-1-shentey@gmail.com>
References: <20230521123049.312349-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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

The attribute isn't used since commit 5c9736789b79ea49cd236ac326f0a414f63b1015
"i82378: Cleanup implementation".

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/isa/i82378.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 5432ab5065..63e0857208 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -34,7 +34,6 @@ struct I82378State {
 
     qemu_irq cpu_intr;
     qemu_irq *isa_irqs_in;
-    MemoryRegion io;
 };
 
 static const VMStateDescription vmstate_i82378 = {
-- 
2.40.1


