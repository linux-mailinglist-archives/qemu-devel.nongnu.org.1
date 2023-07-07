Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA1074B01B
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:44:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHji7-0004Se-3d; Fri, 07 Jul 2023 07:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHji4-0004BD-7W; Fri, 07 Jul 2023 07:33:12 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHji1-0006pp-FA; Fri, 07 Jul 2023 07:33:11 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6b73c2b6dcfso1401831a34.2; 
 Fri, 07 Jul 2023 04:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729579; x=1691321579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d0RYFo5oi3sfSkX8z3IXMaD1SoISEg37Beg8/IEFmIY=;
 b=TVyvvT+HP7FOtkxFmRJXoN0tXiSnypTg2xBnhMqbpv8h32KEnFB7EwgElLC4gb3zKj
 p3sdQ3Sy9akiFxbq/+bnqZmOOcxZERBsduA8ObI0++Jf3ZyXOHHeh3oSMkdBLeoV90yx
 Dv52JsnOtgFyCAKQ38BzoFbHRkcCGr2vXIQgSKe83wLD9ZQIrTcqFjQiN+E9kpfMBHCO
 g4lQKfMEVSAzGZq8FDdSheVcSCLbt/UjGZktQO4Mt2Qlp1mZ9Gf5ztbCDaOUbMlLMQfI
 tWw78b9M6T7Lh40KTr+gnIVH9HkngOzmr1ZfuduPlnLXWc12Gu4/JCevYkjn1GrGbCv6
 dLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729579; x=1691321579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d0RYFo5oi3sfSkX8z3IXMaD1SoISEg37Beg8/IEFmIY=;
 b=CaqVG/Whog/Bg7cfbK4NatGsNIGmomdGH3skCrdba276cTWmnxKhmkVHUIi5p0mgpK
 7iTtWN9ZKCV5qMBo+J6dHds0kRihRJ5/Lg07uMd2e/6zHMAXnZfTwTfE2lGIYhcW0T8v
 drs66k9UEZZ2UBRB6fOXckYPO9wrtdXrkQmuL5Ba+DZo75WiLzfawzWZdw08FA7MWABx
 +9pGePe48p6MwBLa7G5ahbvNb6Ut6piSIrPuawY4U3iRcNzrUfkgiybcyHrvDCCquTHj
 NNcZMwJTHY2BQ8zR1cwn6D4+hhEXwvJsr4IY6tCaPvij92Ma4cO5E+j05MCxRe8hqagv
 v07g==
X-Gm-Message-State: ABy/qLZ0BvH6GKsRr2UW/Lw3WL9GC82+1cbC7Q6zBHV3B/Y6pOnbUQAb
 /4RYZuHukg0vU+JzTfAcbB9+4O/33ww=
X-Google-Smtp-Source: APBJJlGQ7fxcBoygAqQoEA52w6uJnuk3juaCbY0arfzlAVLKhg5mKFmNcPVy2Blgg49UHm666ehfLQ==
X-Received: by 2002:a05:6830:2007:b0:6b7:4a5a:2711 with SMTP id
 e7-20020a056830200700b006b74a5a2711mr4074322otp.36.1688729579572; 
 Fri, 07 Jul 2023 04:32:59 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:59 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/60] ppc440: Rename parent field of PPC460EXPCIEState to
 match code style
Date: Fri,  7 Jul 2023 08:30:46 -0300
Message-ID: <20230707113108.7145-39-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

QOM prefers to call the parent field parent_obj, change
PPC460EXPCIEState ro match that convention.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <6995f28215d2a489a661b7d91a1783048829d467.1688586835.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc440_uc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index b36dc409d7..22c74839ae 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -774,7 +774,7 @@ void ppc4xx_dma_init(CPUPPCState *env, int dcr_base)
 OBJECT_DECLARE_SIMPLE_TYPE(PPC460EXPCIEState, PPC460EX_PCIE_HOST)
 
 struct PPC460EXPCIEState {
-    PCIExpressHost host;
+    PCIExpressHost parent_obj;
 
     MemoryRegion iomem;
     qemu_irq irq[4];
-- 
2.41.0


