Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5797C8119
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:58:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqA-0007yf-DA; Fri, 13 Oct 2023 04:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpY-0007LS-Eu
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:37 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpV-0000mj-JA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:36 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53d9b94731aso3431887a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186850; x=1697791650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u7FjRAtmCoE4Lyv+I2CUeplHMPuAgwwCJPsZclUQJjQ=;
 b=e2nLQiuMN2VO1JHnGkEcoU3u9+BxASmNYuFiui+Jd+TngRjUaeiDQmIe2rxwniDTCN
 Pp5Y3LVRK2s0eBQ0YxFXzkY4z3DwrUsyTtFN41iVvB1YAbJHKFLXVTShfETxtWrqeFcs
 a8Px6phVMcgDQmh/agrsHiFk+kCzmsmQG2EDVvr+BuRB8kPHqHIB67UthqklQ9EDfS1V
 YOZuAscTfgMv4Klq8FKWB8vrnnpG+w0XwuElnxm65/fJY7KErJYzaMgmjYHviGn2jPmq
 FNVPXZRAensKwxlFSJIOTVR5f+hNP6WIf7EeRvq7dIdj1g4Yijshr48KcEUrnQ8AWzQG
 47XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186850; x=1697791650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u7FjRAtmCoE4Lyv+I2CUeplHMPuAgwwCJPsZclUQJjQ=;
 b=nMRHbT7xbdAalykzEGV3475+DDU3Pq82EAPUGKTFYBMufth66LwhmW5TtyifL0l/qn
 brdPpfX6FHQE1pHZipaek/ekSbv6MmQb6JrfLBrFFjzIcRHkx4MYevzdAuBJlqrJl392
 rQZNBr0QU4hSLy0xVa4rMFVxlUunLGeB05jgpd/HwUiCLE/2F55a8m26TCN4jTBzeUkK
 9C9cqEW2mk3EWr2EhZbeqGyb1Mcm8VokHqFV3lhClu+/Y/UKNR+BJwlJxTCrNHG2ASY3
 HUbjG+FTincWDBzRBBS1SQdqExXDSJNXRk9La14QNYFMqDd2pkoPWdn3wEqyWWu32qna
 YYvA==
X-Gm-Message-State: AOJu0YyqNpidFPlukSA2zaJtztnnJP4ofqLuZEohcMz2HMKtwTrwR8/4
 7LeoFCbu06EKUm6fWtMVnKmp+M401J7rYl48h1Q=
X-Google-Smtp-Source: AGHT+IGNG1VBKlLjD2HT4mtn5Im/1PwwYrAAE1GW0/Z41k8a4y0P3jlM3EG6v0Nj7+7/l9SVT/V8zw==
X-Received: by 2002:a17:906:da:b0:9ae:5253:175b with SMTP id
 26-20020a17090600da00b009ae5253175bmr23332020eji.34.1697186850032; 
 Fri, 13 Oct 2023 01:47:30 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:29 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [RFC PATCH v3 09/78] hw/acpi/aml-build.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:37 +0300
Message-Id: <4e765b488f59391b94da71a7cbaaebedc3a0a18f.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
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
 hw/acpi/aml-build.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index af66bde0f5..b0cf0c6073 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -326,17 +326,16 @@ build_prepend_package_length(GArray *package, unsigned length, bool incl_self)
         byte = length >> PACKAGE_LENGTH_4BYTE_SHIFT;
         build_prepend_byte(package, byte);
         length &= (1 << PACKAGE_LENGTH_4BYTE_SHIFT) - 1;
-        /* fall through */
+        fallthrough;
     case 3:
         byte = length >> PACKAGE_LENGTH_3BYTE_SHIFT;
         build_prepend_byte(package, byte);
         length &= (1 << PACKAGE_LENGTH_3BYTE_SHIFT) - 1;
-        /* fall through */
+        fallthrough;
     case 2:
         byte = length >> PACKAGE_LENGTH_2BYTE_SHIFT;
         build_prepend_byte(package, byte);
         length &= (1 << PACKAGE_LENGTH_2BYTE_SHIFT) - 1;
-        /* fall through */
     }
     /*
      * Most significant two bits of byte zero indicate how many following bytes
@@ -528,6 +527,7 @@ void aml_append(Aml *parent_ctx, Aml *child)
          */
         build_append_byte(buf, 0);
         /* fall through, to pack resources in buffer */
+        fallthrough;
     case AML_BUFFER:
         build_buffer(buf, child->op);
         break;
-- 
2.39.2


