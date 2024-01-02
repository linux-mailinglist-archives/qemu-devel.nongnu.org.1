Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADC4821630
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:00:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3H-0003Jo-JT; Mon, 01 Jan 2024 20:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3F-0003JY-Ls
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:41 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3E-00071D-6a
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:41 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bbd1f9e0b8so2631243b6e.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160718; x=1704765518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jBDFYDN4txkYXCl4MK4JvDX5trolAszB5+TZawsyMV0=;
 b=uDF82imLYBepCEfXFvcLfB9u9YqZe0xZYwaeE+0prisb2eFGZSGK69IUPIctCA7F7k
 /4ELreAyE8RdFdPEVwJlKXInwvMbv0+KYRv2oI93gihL+j6vkVMV2ytAYoZQi2I1m3zE
 T6pNU4H4H4X9W9gP7NmKd2iWLlJHzRAMraXeHHsayD5Mna6MqlbhCPFUVBcRdRnpF+oo
 NS7vFoN0nUffQBPOuonk+Nu1NGRxXLFhzvAKRKygAWS5t2yt922c6kXxyXblNo1kesOP
 KnL1F0JNEFLaK+ux5ufLD3DW6SADwUvSTtGwSzgx0GgY6Zc4ejFX6HEO6T3z2pnt3Omk
 Pj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160718; x=1704765518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jBDFYDN4txkYXCl4MK4JvDX5trolAszB5+TZawsyMV0=;
 b=qnsjyXLwEDWjySbV0MzvI3iep7Y/QM88b181R12gAMWLc2JLCRB7qyninIOwBG1G0M
 hs2mWMHyRVXgOqFJrY33aJFFdjzPH7RxGQLTsePo4bm77vLinn3FRaOWPiwZnJrV1ZhT
 eP+yd+LWeKYfujK88sJ6vwjohIGzbKALYRgf90thXxV4m3tNWi2s297MzolByHnK63A4
 NnTOw48qqJnZI6KcS2McLlhK0x0/dDKlwXZaRTvR14RMBrGuUuTRlhOeDoRZFWA3LCbu
 8WjuefFFNmA+9Nvw75dCg1Wljid2tSwEp35GcfS8r0sPDARU729fVYIM4KneRuk2vF4E
 ++Zg==
X-Gm-Message-State: AOJu0Yw4ohRealh++vsIw8xrX8P0BwuuNPHAa+8emU837uXtw+4kwjtB
 BuuYobc/EHD2Za1i277AwLFYVBqMrH9iEqimyxHCXM2G2ZU=
X-Google-Smtp-Source: AGHT+IFTwfSQI7z8JWiFFfhWd0VVozOgzsc21xzNgSU6Fq1vYoO+L39xDzTrakM4BWwV56AqXC/goQ==
X-Received: by 2002:a05:6808:148b:b0:3bb:cc89:3fa9 with SMTP id
 e11-20020a056808148b00b003bbcc893fa9mr8869508oiw.43.1704160717985; 
 Mon, 01 Jan 2024 17:58:37 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/33] hw/tpm: Remove HOST_PAGE_ALIGN from tpm_ppi_init
Date: Tue,  2 Jan 2024 12:57:47 +1100
Message-Id: <20240102015808.132373-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


