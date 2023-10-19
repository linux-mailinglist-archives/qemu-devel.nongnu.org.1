Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BA97D03F3
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:25:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaUD-0007af-4S; Thu, 19 Oct 2023 17:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaUB-0007QK-Aq
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:23:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaU8-0001i8-Uj
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:23:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso944555e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750595; x=1698355395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcTE23/7CBludJrePacG9mm/Zbftrzi7RnP1Te5vq18=;
 b=c84m79qiAcxGNeHcS5CHOZ3epS2ziNiMcJY5LMusxxjkfj+ueB6k+wz2uMifd9RELe
 YumwVSYKC3t6okSDtVnFG/MCNbo45dOMMAdQq9DWGIPFr8LU5vmx1PoB8NDx6+kaQ8Di
 ZNDEwlWcz8Ub5J9yPmODzWmyrX9holf1uTPX5xXuEvcaF4UfyfLGxgU5WwaUWjPszrhO
 qlKTFVv2VzcPA187M6PWucTthvaKi6+jV3NbTsNzfUpV57HJ9YRcaVoDYQ/hJoZSzOmn
 pXkN9+1tSHS88Y2+JpGUfkCVWY8WiHvMfWG5ndtlnjVUnPuH/u/XFsj3tJnpPFU+CmZU
 OAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750595; x=1698355395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcTE23/7CBludJrePacG9mm/Zbftrzi7RnP1Te5vq18=;
 b=e0Wx1LF2XmQguWKxrC+3YdrPB0aiSciNuaayxYumuOPEAOpYiudF0lDzrEgQGXLme3
 D/N098r23VcuLc2qlWonRwKDkJGhcK1nGkDEM5vydED9Zm7kQr1BYttuk59IauzOXeAy
 NLXN+fhsBUKRfCEsLkf9B2UGMx9SA74SZdbJeT8TRYoE0Yel1a7CRjHdYyBdIupy3+M7
 KIzuOH/KSvWtV765iLOTX4DuEcOzBa6SCuNJoRgC55VGEz4r+mtBJRkRgwUIfVkgXB5r
 7bTwTij3l52k2Nfs19ZFGzwodNsAtPLSCJJrwEgasAB95FUuQYaJKbgNABkasXQ8xO7g
 lx0Q==
X-Gm-Message-State: AOJu0Yw/oiOPYa9R8meTzibwHQ4C2gyJ5jr3n+IRefz2xmJ0IMHZXhBH
 HZPFkUwFVoh+q5hGqWxmVWlmr8Xd8pslDD5/cFImAA==
X-Google-Smtp-Source: AGHT+IF48BV4sXFjWLCsLUkwD7lvbcKOGu68xLJospRK5h7prj0Qutj4B4cLRmsO4B13wJH/SSq8nA==
X-Received: by 2002:a05:600c:4585:b0:407:6911:447c with SMTP id
 r5-20020a05600c458500b004076911447cmr55922wmo.4.1697750595411; 
 Thu, 19 Oct 2023 14:23:15 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a05600c4fcc00b0040775501256sm530314wmq.16.2023.10.19.14.23.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:23:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 45/46] hw/net: Declare link using static DEFINE_PROP_LINK()
 macro
Date: Thu, 19 Oct 2023 23:18:10 +0200
Message-ID: <20231019211814.30576-46-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Declare link statically using DEFINE_PROP_LINK().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231017140150.44995-7-philmd@linaro.org>
---
 hw/net/cadence_gem.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index f445d8bb5e..37e209cda6 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1654,11 +1654,6 @@ static void gem_init(Object *obj)
                           "enet", sizeof(s->regs));
 
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
-
-    object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
-                             (Object **)&s->dma_mr,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_STRONG);
 }
 
 static const VMStateDescription vmstate_cadence_gem = {
@@ -1691,6 +1686,8 @@ static Property gem_properties[] = {
                       num_type2_screeners, 4),
     DEFINE_PROP_UINT16("jumbo-max-len", CadenceGEMState,
                        jumbo_max_len, 10240),
+    DEFINE_PROP_LINK("dma", CadenceGEMState, dma_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


