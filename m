Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AF178F711
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:26:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtpA-0006ZS-Ck; Thu, 31 Aug 2023 22:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp7-0006Xj-2U
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:49 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp1-0001Pc-R1
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:48 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68730bafa6bso1786130b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535022; x=1694139822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBDFYDN4txkYXCl4MK4JvDX5trolAszB5+TZawsyMV0=;
 b=cChTyy1ZzMTqIxYW36kM2ctmYcGNgrUMgrBzielzvrybjpy9XA5pWQOk4vLXE9XF7m
 aUI68YPcvgddjUEA+dXAq1Komp4Ya+HWfbdxnw4pIwogl4BabJkmkyOSOppgZjw7xLGO
 2Nr//IGZGQx8qgtH69WWe0Shp7ZomOVOTbfo9E0H/a92YV4nRc7ekQIGd4TACAWXvIEI
 n4Z+zqsaNvGffVNupyJycTDGpsLumZgPxui7N97eBk7nUqu99MW+RM25AJYWEI01orRv
 KYR0OAQkileief2hUDKcI6zDERev+ne7Cmii8ZzHkZFdAuJkwz6tw7Nm1cyjTyxs+CV0
 CtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535022; x=1694139822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jBDFYDN4txkYXCl4MK4JvDX5trolAszB5+TZawsyMV0=;
 b=bGA/GadQI0faOysTm4ScWwhWST8TFFHRjaZqqJ44oZ9/ZhkmY5numbYMrGRDv/b1aR
 SLpNMxEm1LonAzugX5SVar1wyu4tMiJcZ/uEfupnp8UKvSmSQaHdhpeNYMUTCMgJ0mcy
 NbyMCwcu9hDLoqI9TrMmL8fsJbnYY8sm6ehi8VpXg4Q8GLiZ7ghnO6zd3dNfKgzvqQMG
 NpcNS4d7qmYPDmjaVvEioUa7rBlVobbf8ZA7f55TUsoodctrGB8m4uTRrgxIrKxp2W41
 SoNpW0ACzY6obkZF4UP9KX/JlKbMjQMM9qgWPFVPfwzIn/Xm3l5S6Wi8XwflswpSRzx2
 pxNg==
X-Gm-Message-State: AOJu0Ywxp48cMrT9P6lzEtM4/QOHvjMVu3MNnUKEofMEdWGbpjsIZ4Uu
 uqFrpt7zYMSuAw9eL9W0iztMNLWiQi8iN3palAI=
X-Google-Smtp-Source: AGHT+IH6iwMuURxNzBZkaYXQO9hbFaUxfXYntU6ovCngMyrsofTVshvFFLJ9CkTY3qij/dq3qMUr/A==
X-Received: by 2002:a05:6a20:7b03:b0:13f:c159:63ec with SMTP id
 s3-20020a056a207b0300b0013fc15963ecmr1183911pzh.24.1693535022590; 
 Thu, 31 Aug 2023 19:23:42 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 12/33] hw/tpm: Remove HOST_PAGE_ALIGN from tpm_ppi_init
Date: Thu, 31 Aug 2023 19:23:10 -0700
Message-Id: <20230901022331.115247-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The size of the allocation need not match the alignment.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/tpm/tpm_ppi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
index 7f74e26ec6..91eeafd53a 100644
--- a/hw/tpm/tpm_ppi.c
+++ b/hw/tpm/tpm_ppi.c
@@ -47,8 +47,7 @@ void tpm_ppi_reset(TPMPPI *tpmppi)
 void tpm_ppi_init(TPMPPI *tpmppi, MemoryRegion *m,
                   hwaddr addr, Object *obj)
 {
-    tpmppi->buf = qemu_memalign(qemu_real_host_page_size(),
-                                HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
+    tpmppi->buf = qemu_memalign(qemu_real_host_page_size(), TPM_PPI_ADDR_SIZE);
     memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
                                       TPM_PPI_ADDR_SIZE, tpmppi->buf);
     vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
-- 
2.34.1


