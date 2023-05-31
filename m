Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D96718B9E
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 23:12:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4T5z-0006VY-0e; Wed, 31 May 2023 17:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q4T5x-0006U3-14; Wed, 31 May 2023 17:11:01 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q4T5u-0001Eg-IT; Wed, 31 May 2023 17:11:00 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-96f99222e80so43480566b.1; 
 Wed, 31 May 2023 14:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685567456; x=1688159456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAoL9Xwljn85Sw7ICNUech4c35BoMKkS8qS/rd79d7s=;
 b=qLBiPq4yTp5j4RT1+Azdo6XTkYo/DMQ3Jl5OL4RsjgvFmMU28DR7HDHCevpXphifhr
 ejX6DEkTpr3AWF6BJjdLFM9RemeYprI74IPARU0pzl4ckW6dSu+Uz4yhVg8xNNue3wE5
 c1ur09Ia/by1mbfJ2CCcp47v+aWMrtRYFtktkH+Q9pyi9zfFhtwgAarmKHKA4vRhuflb
 QcOS76XpZEtMRSjoBSON50zkA4cJ+tcPYntkLQEV4uMruOUlCNtcmbf2FPYQcOG7WyX+
 nYwnP3Yzlq/Te9cJuLIBLD22GBvsVDeHIiQJDiV94+iri1tZNofLlHeQnKWkG8679esB
 +J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685567456; x=1688159456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gAoL9Xwljn85Sw7ICNUech4c35BoMKkS8qS/rd79d7s=;
 b=PmkXKpAguXTtm4rYv9wXHribWhp/9rl8iQS3fZqIC0+XYAWYB+Z4ODVVvPqgwFrKYO
 XHMfnfnoKetezp9eBJfBkLS3103u0oMoJ3IuC/gVTjIturn/oQL9zmrFtKSkw+VfAIgm
 ek7dVxhZ1DCchUBhdCNi56bh9MJcxcfdHo4I7TEJQJ9N5BQvGbsWcHoR5zP9EYk9+PQQ
 pu9/GH5fR7PWjf7BteLo/vJoKSTiNSP1eXD+oZoOXhtkgi6TFAtVolCekaQ2MkmfsEa1
 tstqz8ZKwW/KhpCo/sc1lrpjQZQKwCZOM2OOIMh2wAWKOmd7i55TGsd/3kgrrZC8Q1S7
 HsOQ==
X-Gm-Message-State: AC+VfDwJgkK6heeRnM0ZzrTuriQXo9G/iOzaz4q/fVtQ+dTuxgRSg1/j
 x/8apMLa8Gw9Zi5laGb8PYh+PVUVn0w=
X-Google-Smtp-Source: ACHHUZ6HrPL2CpTUyb9PXhkve7HhN2mByx4q7BoaZxBgEQzmip9JP+YK8yBxDbB4GAaaF6qkn5UuUA==
X-Received: by 2002:a17:907:980c:b0:966:5fac:2e52 with SMTP id
 ji12-20020a170907980c00b009665fac2e52mr12848785ejc.9.1685567456110; 
 Wed, 31 May 2023 14:10:56 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-159-078.78.54.pool.telefonica.de. [78.54.159.78])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a1709064d4800b00965f31ff894sm9463054ejv.137.2023.05.31.14.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 14:10:55 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v3 3/7] hw/isa/vt82c686: Remove via_isa_set_irq()
Date: Wed, 31 May 2023 23:10:39 +0200
Message-Id: <20230531211043.41724-4-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531211043.41724-1-shentey@gmail.com>
References: <20230531211043.41724-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
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

Now that via_isa_set_irq() is unused it can be removed.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 include/hw/isa/vt82c686.h | 2 --
 hw/isa/vt82c686.c         | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/include/hw/isa/vt82c686.h b/include/hw/isa/vt82c686.h
index da1722daf2..b6e95b2851 100644
--- a/include/hw/isa/vt82c686.h
+++ b/include/hw/isa/vt82c686.h
@@ -34,6 +34,4 @@ struct ViaAC97State {
     uint32_t ac97_cmd;
 };
 
-void via_isa_set_irq(PCIDevice *d, int n, int level);
-
 #endif
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 8016c71315..57bdfb4e78 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -592,12 +592,6 @@ static const TypeInfo via_isa_info = {
     },
 };
 
-void via_isa_set_irq(PCIDevice *d, int n, int level)
-{
-    ViaISAState *s = VIA_ISA(d);
-    qemu_set_irq(s->isa_irqs_in[n], level);
-}
-
 static void via_isa_request_i8259_irq(void *opaque, int irq, int level)
 {
     ViaISAState *s = opaque;
-- 
2.40.1


