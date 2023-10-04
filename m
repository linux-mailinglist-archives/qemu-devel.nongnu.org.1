Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 361A47B7E9D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:03:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0aJ-0000Ib-7e; Wed, 04 Oct 2023 08:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0YQ-0008Tq-0Q
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:00:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0YO-0000xi-IH
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:00:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-405417465aaso20780485e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420835; x=1697025635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCSsB1yBxNop9ElFEQPzo8eRpaAPTBMtrtJV+7OJslM=;
 b=t4338tGYkiUc6DA3kdmPzoUcnvxTiagrrCHzwn4Jl2V3xLzOME4aasw+DmzOryX4ZL
 Z6AGUL8bGPWxf7IKMLk4Q7ClvH/CQwZ9WIHUCIpl7N8ePhdPMGzA8MWxOc5HJYnoZAnn
 UCtQhuyfpL/vkmr6QP4OS9357288pZ/hDOorJmP3/AZA8EEc7Uqq4F81NpevsrUalnSL
 1Zl8acIb3Qqy5pXQwawdZ8cL/rSRrOfz0R0rj/RvP78BZ7/Xnu1YRlJk2AkelNVZLjHJ
 juUVdmFTwso9UNmlJD53ekzDT/ZZKsWWwvQAmPYUEHdO5cq4CEQkK6rpP9Fc/zJUcs3C
 MsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420835; x=1697025635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCSsB1yBxNop9ElFEQPzo8eRpaAPTBMtrtJV+7OJslM=;
 b=YGcgXAeicZwMF01lherRn221PuDE9aP+E/761W3RENZanHUk1rXQh9dIsuXai1+v0m
 sw1UkRfglHIc+cGQ0UOuwVS6fH7bCjpsOVGmDir+H/UcchItoTAnaizk+vbqPcapgtdI
 64AY8BuUE9qwGZ0BgAYyu11LbqmIdfPByJV2UryYQ54ZV6LCahFDGXucjoTwS53JfZBb
 O/NO1CV4ffNaIt8ExWG4Ulrb1gYfrjXKnTsRvcsZWPvRkEjfzvlu+AGM1yGIE9wNdUqA
 cmUj7i+4zziV68gIcZdiq0CpXAa6lnURny4S4pZQ7RG9253ucbgfs/GncdrhEf0nhcss
 Zw9g==
X-Gm-Message-State: AOJu0YwcsajUNz/Gct70kk9q86fOt6p68yung8zmj9x8HSZbJI3wH2cb
 uuw7GJXX8HYZPEwyuvl1TYteRRpfMj93IKuFKGE=
X-Google-Smtp-Source: AGHT+IGK8aYCctUtCXrj5L0wSBym/N9vDYk5wPrTb/m2SCQX7FAR+R2IYm5MnEmO2FY+x7+HAEZs0w==
X-Received: by 2002:a5d:6a4c:0:b0:31f:8a6d:e527 with SMTP id
 t12-20020a5d6a4c000000b0031f8a6de527mr1957218wrw.45.1696420834925; 
 Wed, 04 Oct 2023 05:00:34 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 v11-20020adfedcb000000b0031fd849e797sm3845151wro.105.2023.10.04.05.00.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:00:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 02/16] hw/ide/ahci: Clean up local variable shadowing
Date: Wed,  4 Oct 2023 14:00:05 +0200
Message-ID: <20231004120019.93101-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
References: <20231004120019.93101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Fix:

  hw/ide/ahci.c:1577:23: error: declaration shadows a local variable [-Werror,-Wshadow]
            IDEState *s = &ad->port.ifs[j];
                      ^
  hw/ide/ahci.c:1569:29: note: previous declaration is here
    void ahci_uninit(AHCIState *s)
                                ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/ahci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index d0a774bc17..fcc5476e9e 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1622,9 +1622,7 @@ void ahci_uninit(AHCIState *s)
         AHCIDevice *ad = &s->dev[i];
 
         for (j = 0; j < 2; j++) {
-            IDEState *s = &ad->port.ifs[j];
-
-            ide_exit(s);
+            ide_exit(&ad->port.ifs[j]);
         }
         object_unparent(OBJECT(&ad->port));
     }
-- 
2.41.0


