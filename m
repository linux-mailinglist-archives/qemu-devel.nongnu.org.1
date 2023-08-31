Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F3478F5E9
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 00:58:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbqb7-0004Ug-TE; Thu, 31 Aug 2023 18:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqb5-0004TJ-89
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:57:07 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqb3-00038C-3w
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:57:07 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9a1de3417acso551233766b.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 15:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693522623; x=1694127423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KLx6XBhwZsbEqcvd2/L0DAF2KnkpBlHb/IZBmOztIQ=;
 b=YeGwrBIuzjOTSmCeVjJ0kHsDobcKC4tY5b8eMQbxApar//mN0cp3kZIni6gJHA82s0
 v3V64jpK/XFDcYolINV+s8QhM59Bq3a5/2ls1J11O8kjsapmtLiEX5cxPWXkmp8BRjRm
 Uv8yOPwmEtxUoLZXBKnTohZjfaXfrSDqocKkaCOG16cYptDz8Hnl2G9bTr3Ga3ydKg/3
 ZU2ayDxvrPn1UwdqF/qQ6Shqf7slVdOBqUVzDNQ2E7VeDB4yd60SxfXtOIcRwsTKd8Fn
 RhpeBDKN6AVseHlnMBcj1vN/QR1Z309JdZiByDAimgeKjp1XiRff0B8lhBDL3nyy8Axf
 mbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693522623; x=1694127423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4KLx6XBhwZsbEqcvd2/L0DAF2KnkpBlHb/IZBmOztIQ=;
 b=jMVzwoS2H+mAtYkZE8L37/8zzzD18LGU2lITD2a2dM/Y73NTUskjA3luWxHrEK2H0t
 p1fuCtBDzGSrspDib40WrMuA/08kHT+jNwmutFYIYxJoJwci06u3osh2CPwJ62h4AsHl
 AtzVU89iHnarn6jfS6fEV6aLUHSyAdyBLaUrGQqSHLFDZ9eUkIIJ1Z6bQhdWOz+/dwlc
 WapOhG2BOR4u8TZH/RTNG6rXTFE3sCB8sZVoGO9X2Zr2H6Wb2jAL1HPJ74HzTDbK7vLC
 +Z8/eFyBwY42yUYvD1qXQyChz1nltf5dKKGVgu9sQEUmMtS9c9cBbWhVNb6rsepGyAc8
 c+dw==
X-Gm-Message-State: AOJu0YyqPtJwO5IFAXEs26diCWzchs+R1Krr+W5cDxIUmhQ35Y7d0LCz
 HzNzYYQP0Js+ByCyRRsQiZk+GGrINLEML9IELJI=
X-Google-Smtp-Source: AGHT+IGMXhGYgjabc1iv+BK9NV5ShYwxyM6hQ9l8TFMZu/K64adbK1KE/ZkfvRW9Nn39KykvNHCxgw==
X-Received: by 2002:a17:906:73d5:b0:99e:afd:f2ba with SMTP id
 n21-20020a17090673d500b0099e0afdf2bamr1190360ejl.35.1693522623707; 
 Thu, 31 Aug 2023 15:57:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a1709064f1800b00992b1c93279sm1244368eju.110.2023.08.31.15.57.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 15:57:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 09/11] hw/ide/ahci: Clean up local variable shadowing
Date: Fri,  1 Sep 2023 00:56:04 +0200
Message-ID: <20230831225607.30829-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831225607.30829-1-philmd@linaro.org>
References: <20230831225607.30829-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

  hw/ide/ahci.c:1577:23: error: declaration shadows a local variable [-Werror,-Wshadow]
            IDEState *s = &ad->port.ifs[j];
                      ^
  hw/ide/ahci.c:1569:29: note: previous declaration is here
    void ahci_uninit(AHCIState *s)
                                ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/ahci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 48d550f633..8c9a7c2117 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1573,10 +1573,8 @@ void ahci_uninit(AHCIState *s)
     for (i = 0; i < s->ports; i++) {
         AHCIDevice *ad = &s->dev[i];
 
-        for (j = 0; j < 2; j++) {
-            IDEState *s = &ad->port.ifs[j];
-
-            ide_exit(s);
+        for (j = 0; j < ARRAY_SIZE(ad->port.ifs); j++) {
+            ide_exit(&ad->port.ifs[j]);
         }
         object_unparent(OBJECT(&ad->port));
     }
-- 
2.41.0


