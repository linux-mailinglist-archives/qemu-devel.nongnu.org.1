Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F677C8139
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDtP-000192-KT; Fri, 13 Oct 2023 04:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsf-00077O-Sc
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:52 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsX-0001a0-4i
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:42 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3231dff4343so1172186f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187039; x=1697791839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQXVrBFR4Nwny/tbdcs164fr1C6qe6qdz9T2PiayD/I=;
 b=zVQ5X9Zv5zHKTXmHjBP2iFChuRDGWHBOg+zfJWtUSnFJJEHuY8INwMyVJPjCSNB4f5
 dzuEz6sHQ/9Da7MKNA3sNnHZxmgnr9xD3Rw+GUEpSe/i95Rr+53H/2vgjBqLhQYscRtm
 1a73PQDVH2ZtSi/mgLSRNTI8JDXXFeSmYlKcVKPYUj/Drk9ESF9TfyuIxBoov/DcoPxl
 saP45AxUzP//m3AmZMGEa2l27mtiiokAL9kALNxkXl777IVGRTqr7XdPgLlCwtFOHpSx
 hL59AWJ/KVN4gGgzGxB/iOTt7FbGimd2W3ZkAaGNp7jiHgW44fiOOHG8EFKQX2df1mr1
 AY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187039; x=1697791839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oQXVrBFR4Nwny/tbdcs164fr1C6qe6qdz9T2PiayD/I=;
 b=vgf/idzVYc0W96diMda+74EB5mih+NeSR6VGb1LlEQyobOI3huovh55X2dd3e0WdBy
 4m2AbRJbpkl8XQCtFeFUw/IszuQgyK/PfqbMyMx/d9s1ViHbBFYtCohZn5syZiQMUn6f
 CLbpWpL0hUfRccp/AIBW2RDt6gtVD5b4NeQLNlpFEciVNAuUOfnjWgv5Up1IBYIcLt3P
 C8zNHIVMoSihFr8dZSGbJSUi3QvY9h4nVWmAY4MSvFhDsvhaIpLJcY6povj8wtsWaqus
 HxcvQB9waudg3z07UJGQ5dtx9hZjNixtsP3Xl8ICHASD9F6c8vkeYGtCM0UcpATyERep
 FrOg==
X-Gm-Message-State: AOJu0Yz5/YvQziJ2Dnpubpj5RDefsFUXmXNleCnmCdQ1COM3b7n6YmsR
 Q2x+IqFxm8074yrdYy9WiIKaWoqMY3qac/QUp+o=
X-Google-Smtp-Source: AGHT+IHwJ8wv+o2owFv83ke4mezupO9pWpl1e45XAX4IxfgaEtg2LPqJsMRinMD56HjkgldF+OFOIA==
X-Received: by 2002:a05:6000:1a45:b0:31f:f8a7:a26c with SMTP id
 t5-20020a0560001a4500b0031ff8a7a26cmr20442765wry.25.1697187039625; 
 Fri, 13 Oct 2023 01:50:39 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:39 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [RFC PATCH v3 67/78] hw/pci-host/pnv_phb3.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:35 +0300
Message-Id: <31805fc4062d997c2d2131154b51a470da88f9e2.1697186560.git.manos.pitsidianakis@linaro.org>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/pci-host/pnv_phb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index c5e58f4086..6a805d3900 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -531,7 +531,7 @@ void pnv_phb3_reg_write(void *opaque, hwaddr off, uint64_t val, unsigned size)
         if (changed) {
             pnv_phb3_update_all_msi_regions(phb);
         }
-        /* fall through */
+        fallthrough;
     case PHB_M32_BASE_ADDR:
     case PHB_M32_BASE_MASK:
     case PHB_M32_START_ADDR:
-- 
2.39.2


