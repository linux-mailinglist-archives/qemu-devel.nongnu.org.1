Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EC072ABC3
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:36:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhI-0004TT-KQ; Sat, 10 Jun 2023 09:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhF-0004SU-MW; Sat, 10 Jun 2023 09:32:02 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhE-0007b4-4u; Sat, 10 Jun 2023 09:32:01 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-39c7f5706f0so1293768b6e.3; 
 Sat, 10 Jun 2023 06:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403918; x=1688995918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HpVKM5ZS+L3DRrs4U+nZbX0qDPmKbeyqLUjQBiUiYd4=;
 b=fZiSccjKz6qNwDmN+7xJyYyZ6PD5KNUHONoK4XWdcKOdv/VXP0UnFPUufUwn/0qoWY
 ko9WyNBtUxlBTuh/hEleC4JBIGwjMKZu+J2jMALaXDvoW12a0rhTMiD9HJPI7BCjpgxc
 jR5UiORl5oG3XfaUjidNWahnvDEpX5qMNWrcLrBwSPsqFMjbuepw6ln3ZDqJEmZiBUSI
 qlNgbwx5v1Z8Ty7dvt0wJjUtxxDHdNa8kCRYTpjUR7BBPYHeJQrbOwAWHUY4OPOu4MW3
 GgSqoOb/C6jYofiCGMS7zhiHJZkm734Vy65kJKSoOixjCHkyiNx2Tn/8CwrmqpKFoCbO
 Z7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403918; x=1688995918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HpVKM5ZS+L3DRrs4U+nZbX0qDPmKbeyqLUjQBiUiYd4=;
 b=I7pyh8sCjzqbUCxHNxEx5CWtfLem0ECER9xSzmHbwvkOw35M6iS8ZJ4q40HSLW+zlw
 x2Bol/JNZQGPfzjh03mCCVbb6vpMfSwxrXoQ+IGFrehktPg52VMeFCIo0Zh0QMWDGSWS
 sABHEUuJrcJGO1VLTqMt3B2YI1nzxcpn2j398uRkPdtZxasgcLb0Qqt/gi6CL9dbVV++
 JykPNY6i5wIPouJNqeqroOipXbG3PgJWtOulofRelQTNUDlFoa+OEIRMxb30QMzMQjFi
 P8JwAb1wAvgL2oiSKWC32QkvjJEd4t9llqQ4wH16gR4vKG+gRbxJU0FvhkPMZatvCMnP
 OIaw==
X-Gm-Message-State: AC+VfDySMKHUQs/TUsfOlft7bkt/t7KWVjwVJKA2JS9H0a4dT17rODM1
 SK3gpLwdXFiJnC+xDYSsiy1JZQ7iVcQ=
X-Google-Smtp-Source: ACHHUZ67vdSTOs+z054c5bf4PoLSHU3WRRb5bSGMcS/Iiof/CwWiWySbmsYQ7LefhpGS89zskp8G2w==
X-Received: by 2002:a05:6808:1414:b0:39a:98ea:43c9 with SMTP id
 w20-20020a056808141400b0039a98ea43c9mr1434272oiv.20.1686403918381; 
 Sat, 10 Jun 2023 06:31:58 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:31:58 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 07/29] pnv/xive2: Quiet down some error messages
Date: Sat, 10 Jun 2023 10:31:10 -0300
Message-Id: <20230610133132.290703-8-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22c.google.com
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

When dumping the END and NVP tables ("info pic" from the HMP) on the
P10 model, we're likely to be flooded with error messages such as:

  XIVE[0] - VST: invalid NVPT entry f33800 !?

The error is printed when finding an empty VSD in an indirect
table (thus END and NVP tables with skiboot), which is going to happen
when dumping the xive state. So let's tune down those messages. They
can be re-enabled easily with a macro if needed.

Those errors were already hidden on xive/P9, for the same reason.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20230531150537.369350-1-fbarrat@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/intc/pnv_xive2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index e5a028c1e6..ec1edeb385 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -163,7 +163,9 @@ static uint64_t pnv_xive2_vst_addr_indirect(PnvXive2 *xive, uint32_t type,
     ldq_be_dma(&address_space_memory, vsd_addr, &vsd, MEMTXATTRS_UNSPECIFIED);
 
     if (!(vsd & VSD_ADDRESS_MASK)) {
+#ifdef XIVE2_DEBUG
         xive2_error(xive, "VST: invalid %s entry %x !?", info->name, idx);
+#endif
         return 0;
     }
 
@@ -185,7 +187,9 @@ static uint64_t pnv_xive2_vst_addr_indirect(PnvXive2 *xive, uint32_t type,
                    MEMTXATTRS_UNSPECIFIED);
 
         if (!(vsd & VSD_ADDRESS_MASK)) {
+#ifdef XIVE2_DEBUG
             xive2_error(xive, "VST: invalid %s entry %x !?", info->name, idx);
+#endif
             return 0;
         }
 
-- 
2.40.1


