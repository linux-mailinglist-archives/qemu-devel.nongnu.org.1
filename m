Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2DD7C80AD
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:49:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDq9-0007ev-0a; Fri, 13 Oct 2023 04:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpY-0007LU-FK
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:37 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpV-0000mz-Jv
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:36 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3232be274a0so1957981f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186851; x=1697791651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmMqxE9ZBv9fV9A5jTTC7v3DP3ST0zzJbjdcUDse/ZA=;
 b=M16GhSMaxY0sc52Ao11clPXIfvsT1nVLOLOXq2B+Jd7mJ4JAIEJiCN/mKUhH4VHH/d
 9+IdlNQT9W7BAaERgcbZmaE8jT/lsDQPSTIesQgG2SzD/y2V6JOnt9Sx8mRIdKMQl5F9
 jX+4e4x1hD/8hNmnQWziUdsKZq2trB1Hn9RFEWGrXN+MmuO+PYYuiwNcJAyd5UjSHqSE
 +o+eVPHcybH2EFn4ThpJLJEo06WfwnJnSp/LyQSbI52vXYrNXMLiNcDGSEO/76Mr/yUW
 jEMkixHmOqdAsYhE+DfgE2AdmnaMSoRx3eSWJwEYJCm9yUMokWRN9eQDDhusthZntF4J
 Cztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186851; x=1697791651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jmMqxE9ZBv9fV9A5jTTC7v3DP3ST0zzJbjdcUDse/ZA=;
 b=kADCyfkKqswu4xlwqgzRR2TqFXaytM40UcEuTIF3vizD57qqhHPAPbQlK9In2R5MTh
 cUzZxE5Sme210VjGkMIp1wxSXmbTzr1LYaEms8i9sjbz2oUGN8aTse59phAVXNs1hzr2
 t9fnouhV2c6/FX70UqOUFx4Gn4rltCBKKnHFenVhdOlQgoMtKBOspzdKs8RUh9insKmd
 CbOgUgH0QmQ+jNWnWDJbNw8CgITBCULWerRiLBNL8FTikUo07diSSavX62cZXpF7Zi0C
 dGaKIC1KefMOwpqkCD9ZWe3ndk/rMxILDLT0nqQ33wMEhe8rLF/ublp83r6jHsMtX6Uq
 vRSw==
X-Gm-Message-State: AOJu0YzbbCyUfyQ0ghDUB8Ws7CvTvA6Dd5QdS3HAnlta7VCTzj1MyIXC
 L0aG4OoEx2OMZpONCOpJPWqSmAAqPK4AsTrGNyY=
X-Google-Smtp-Source: AGHT+IFyydWOW/w1cWa9yT6MvMLDU/j1qkCNNnc5GuyDQGvCG7oxhuyer1BqLdHxRjdkbOAobSINyw==
X-Received: by 2002:a5d:500d:0:b0:317:dadc:4a63 with SMTP id
 e13-20020a5d500d000000b00317dadc4a63mr19416570wrt.8.1697186851528; 
 Fri, 13 Oct 2023 01:47:31 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:31 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org (open list:IDE)
Subject: [RFC PATCH v3 10/78] hw/ide/atapi.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:38 +0300
Message-Id: <96ebdb3ecc533a7f0867b695ff08891fa78f44b3.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/ide/atapi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index dcc39df9a4..85c74a5ffe 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -1225,6 +1225,7 @@ static void cmd_read_dvd_structure(IDEState *s, uint8_t* buf)
                 break;
             }
             /* TODO: BD support, fall through for now */
+            fallthrough;
 
         /* Generic disk structures */
         case 0x80: /* TODO: AACS volume identifier */
-- 
2.39.2


