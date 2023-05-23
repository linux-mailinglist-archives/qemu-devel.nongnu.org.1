Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E17D870E5FD
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 21:51:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Y16-00017L-9b; Tue, 23 May 2023 15:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y0z-00012A-Rc; Tue, 23 May 2023 15:49:49 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y0w-00047h-OI; Tue, 23 May 2023 15:49:49 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-96fab30d1e1so54585466b.0; 
 Tue, 23 May 2023 12:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684871382; x=1687463382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAoL9Xwljn85Sw7ICNUech4c35BoMKkS8qS/rd79d7s=;
 b=WSE32qvTGZJHI+QaF5AF8E60jiYWDSrIfbYYNxqlCiYzFk5N9eGs54KwO2r8DZxt7h
 vv9vvazWl0EioNqhSpolxFTVM/pGfeewIdqhIM/twPzGvc4XnkpSGMKPmT86WkWmO534
 9TvrZ8sBaPBrrp+glQZNB1iZtDOTOkKF8ZVlGlnOmBH/nDsdQVbNDQv9x8Tjt4BzY9Sw
 xr9evrFrHeLgkR7waOtrUgeJq7dPwzrqSESMHdTwmnFEtgdtEBsBsm1VsP5DZFRJSD/k
 /BNs8pskcKws6gpcayueMALYOzw3llJRbJVgFwE7HB9B5b4kLSHR6IV8So0uh2eBp/G6
 fK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684871382; x=1687463382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gAoL9Xwljn85Sw7ICNUech4c35BoMKkS8qS/rd79d7s=;
 b=g65MmEeVXFSbnMvaRzSPr1iauBZY33PPNGjNHYc+bC0UVYmE5zPK2H9iE+sKW2eGcU
 r99jVNGFAh/c5zti7Ow5cTqYeM0oE+dX1tyZn5vgWC3HlBHNzkGmX4utdC3UWTgyqx73
 Acbi3868jJaFkjyjOzUMTtwfrjpUH/zupn0vvRYccmW8Nw2z13iDbejCnB5RIOHVullX
 cqAnkrQa+57TBSC9RlrJ/h3ign7nWhmOFJGDCnB8h/xZXvjFBEk85p/TFrfTuCyCi7KH
 Z3achxPHlPVkZfOZ9jHWFOh+iUOYOGoSiKjTi0kpj0dpBrKAYSiX/yGCu0SRUhae9daK
 y3Eg==
X-Gm-Message-State: AC+VfDyZe+fnj/r9nACTkcQ2V8OxfdPumiJBnY5YiioK+8ERKDNpW5U+
 WYPPOUpt0ly9GveLjRxZOSd/5JwO3/8=
X-Google-Smtp-Source: ACHHUZ5vK+6vp9AuZlnhLm0hG8sDBTtx7OC4VrueTWgxVF+2GhR/somtAQDKaa3Kr76ZMwoAc39XUg==
X-Received: by 2002:a17:907:ea9:b0:96a:2b4:eb69 with SMTP id
 ho41-20020a1709070ea900b0096a02b4eb69mr15111127ejc.31.1684871382451; 
 Tue, 23 May 2023 12:49:42 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-183-025-113.77.183.pool.telefonica.de. [77.183.25.113])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a1709063e1100b0096f641a4c01sm4800593eji.179.2023.05.23.12.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 12:49:42 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, John Snow <jsnow@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v2 3/6] hw/isa/vt82c686: Remove via_isa_set_irq()
Date: Tue, 23 May 2023 21:49:27 +0200
Message-Id: <20230523194930.124352-4-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523194930.124352-1-shentey@gmail.com>
References: <20230523194930.124352-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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


