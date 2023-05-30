Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB07161BC
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNN-0006n1-LK; Tue, 30 May 2023 09:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMr-0005e7-Ql
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:32 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMo-0001OW-Oa
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:29 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4f4d6aee530so4702446e87.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453183; x=1688045183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tZZp8qZUnh7rN2MKTpirZeB50VkCYddXBSRoN/swsXM=;
 b=rnMxpHjOfpzZScZ2fn9OnKFLjNtklExaIa1fBI63+u4bT6K1PxLJJzfFvBUBh/97PD
 pryI9WogbXnD1vD2YzY4ICwQ7E+UJzILdSrPl636MhfYSoyEDtDK/nW3iAGzqkoy76qt
 mjn9FiMMq9gx23wWxtpVfHIp4GaAIG1dEGm4G3sBRFnJvIOKDPemcBj7Eg7P3NewLF0V
 FxfxmVmxYMrQCdPIUQD0wRvsUsfsAPtv9YkLrNIycWBHXlHW0HNWzNWoIj5JvFcwG91U
 z3T+nYCJqpPxkzTgo5q2ZbsvVJeVxPcW7TabfBbIusmENWbvUqM6gfANM44Nrp1oV9qN
 fqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453183; x=1688045183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZZp8qZUnh7rN2MKTpirZeB50VkCYddXBSRoN/swsXM=;
 b=QvBha2EycGHOOO6MBHSYtPtyIdCCTdbs5Jv00ENmFApw3ECnDLxRMptg4ZbS8EdhpT
 DUdzDCIcvWEUq9CnlqmRlEzP+G5KBMbZliuLuF3LmoYpV48mZi8e1uic6coQZzFzP5kp
 7BUc+3mq/QXGspK547LCUh7JPjUZhx5QqcRCWdwx9IRwMT7ufCXQqsB0c6jSV4RQBuJg
 UKxMSDve9kjH5uiJxcL/acSAz6sQ0VVaZpRbAod1mt4NQgJ2fcNAARB2ecE8Utp4ZPFe
 slqKcAgxmCofU5yhXji1HSEAM3mVvkVOWTOu71yoD1Pa7kvrkFAn8fYvIJpiEOiKXlT0
 etkw==
X-Gm-Message-State: AC+VfDxvtdGXKj1tMKmTCZodOwjrEYzx4g40b5Qt4Q3MHj6uL6BsecmB
 scs0fIYuzLOiRAUSXK8RAQwrxz00KYKt0jUY3h4=
X-Google-Smtp-Source: ACHHUZ7LGDClTLJ1v+D1Kv0pMYHmHyG4BsgmK2MJgyimd6SHZNfKeGvSDabIjO16U8v2aSQHcShCPw==
X-Received: by 2002:ac2:5637:0:b0:4f3:af46:1941 with SMTP id
 b23-20020ac25637000000b004f3af461941mr767664lff.34.1685453182889; 
 Tue, 30 May 2023 06:26:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/21] hw/arm/smmuv3: Add missing fields for IDR0
Date: Tue, 30 May 2023 14:26:01 +0100
Message-Id: <20230530132620.1583658-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

From: Mostafa Saleh <smostafa@google.com>

In preparation for adding stage-2 support.
Add IDR0 fields related to stage-2.

VMID16: 16-bit VMID supported.
S2P: Stage-2 translation supported.

They are described in 6.3.1 SMMU_IDR0.

No functional change intended.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-id: 20230516203327.2051088-2-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index e8f0ebf25e3..183d5ac8dca 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -34,10 +34,12 @@ typedef enum SMMUTranslationStatus {
 /* MMIO Registers */
 
 REG32(IDR0,                0x0)
+    FIELD(IDR0, S2P,         0 , 1)
     FIELD(IDR0, S1P,         1 , 1)
     FIELD(IDR0, TTF,         2 , 2)
     FIELD(IDR0, COHACC,      4 , 1)
     FIELD(IDR0, ASID16,      12, 1)
+    FIELD(IDR0, VMID16,      18, 1)
     FIELD(IDR0, TTENDIAN,    21, 2)
     FIELD(IDR0, STALL_MODEL, 24, 2)
     FIELD(IDR0, TERM_MODEL,  26, 1)
-- 
2.34.1


