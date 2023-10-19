Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 085A27CFAAE
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:15:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSrG-0001Fw-7s; Thu, 19 Oct 2023 09:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSqO-0007hq-RW
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:13:51 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSqH-0002UW-ON
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:13:41 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40838915cecso18255755e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721213; x=1698326013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13jcJG8DaQUc9qe6s2Cd1zPqXFNLL5Z03Tjf5LEdf1E=;
 b=C32TxjN1j6CbvNORGeMxSIoO9Md93gPtxhCcAPz4M2QWKDhJJ8LcOdSK+cjtD7wOC6
 M6jRaZQUgGzhU4HcvvSF1tQl9szimmWr4yUToMZ0JnmdwK2B0Cwml6wzQ7mtedJDUZ6Z
 Dhy8qjW8sgmJj9tUmtWVeBsCHM2G7QZfjBvxmnrAA9RI4Bt6k1jnD8OKW8JnL67Ks/M8
 PpiGj4JBA7XsHqdhg8KtGh0a3eUAq4vab8jkqB0K1I/5XXuJUagLaiP92sBsiUtJClRN
 7K/zHOezhfcnsozymJbi31lNHVyVtndsRNgF99JBBSRJmqw1M5/ONDNMdMNJP6Axn9vM
 vnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721213; x=1698326013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=13jcJG8DaQUc9qe6s2Cd1zPqXFNLL5Z03Tjf5LEdf1E=;
 b=AVHwLCvVk22bVEun6KIMnDPukbWP54MNqefwGFOarn43R+aDseUW+3nKtjyRNS2OZc
 OLSoULhhFoPhAKdjJljYPIaOU2Npi+MDrznB48yIVS6qsRIzXk84Nhf+5+v3cWfpj3kw
 3ZbxDpeOgN9au4fy2v7C5hU/EUbY8mslfZiwXGwID9Oh6FdJ3lUUZxP/VT9RXohj2/KU
 QJO0dLVyDz0O9/+rAXtuQZOe6ivg7Uxl/sN4L6Hcck2CVqGVrCCm/8DKQc+cS4h/25Wb
 0RSlOqNxF8oTXkymPULDtYIIMKB2YelsZrRAZXtPSZLlm1OGPwihXf3da29sfNTZvx3V
 2VqQ==
X-Gm-Message-State: AOJu0Yx88DKf2c+SN7EuVYkVrEZuNj0C9+zYZq9HwseE5rcD+xgfpcT9
 vEZFf/aKdi8yQO5aoCtg0vyBSceGbmXmZ5QINppKsg==
X-Google-Smtp-Source: AGHT+IG9eVYMo9cIlVp8dtuBn5PwWJ70ufsiBi9q+ILLxm0wY1MvD+DqKgWH1nR32OHgoEjQPoYAyw==
X-Received: by 2002:a05:6000:12d1:b0:32d:a2c3:19f3 with SMTP id
 l17-20020a05600012d100b0032da2c319f3mr1297196wrx.41.1697721212999; 
 Thu, 19 Oct 2023 06:13:32 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 f19-20020adfb613000000b003232380ffd7sm4431399wre.102.2023.10.19.06.13.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:13:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/7] hw/ppc/pnv_xscom: Do not use SysBus API to map local
 MMIO region
Date: Thu, 19 Oct 2023 15:13:02 +0200
Message-ID: <20231019131305.19157-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019131305.19157-1-philmd@linaro.org>
References: <20231019131305.19157-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

There is no point in exposing an internal MMIO region via
SysBus and directly mapping it in the very same device.

Just map it without using the SysBus API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 hw/ppc/pnv_xscom.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index cf892c9fe8..805b1d0c87 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -223,14 +223,12 @@ const MemoryRegionOps pnv_xscom_ops = {
 
 void pnv_xscom_init(PnvChip *chip, uint64_t size, hwaddr addr)
 {
-    SysBusDevice *sbd = SYS_BUS_DEVICE(chip);
     char *name;
 
     name = g_strdup_printf("xscom-%x", chip->chip_id);
     memory_region_init_io(&chip->xscom_mmio, OBJECT(chip), &pnv_xscom_ops,
                           chip, name, size);
-    sysbus_init_mmio(sbd, &chip->xscom_mmio);
-    sysbus_mmio_map(sbd, 0, addr);
+    memory_region_add_subregion(get_system_memory(), addr, &chip->xscom_mmio);
 
     memory_region_init(&chip->xscom, OBJECT(chip), name, size);
     address_space_init(&chip->xscom_as, &chip->xscom, name);
-- 
2.41.0


