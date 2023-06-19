Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36674735975
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:25:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFnI-0004EN-WC; Mon, 19 Jun 2023 10:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBFnC-0004Df-3w
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:23:42 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBFnA-0000jG-B8
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:23:41 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f63ab1ac4aso4428948e87.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184618; x=1689776618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5BMeKkCZ73ncSnRSQ8wFapQINfHHQYDpYeSup4OEv0g=;
 b=StgFz48uCx+29aZCuPdBk7TolilPjz6pkV4RLCWgmLBfA/PH29H3JJRO1Od5FzLwxq
 u1LujkyV3chv1WvKBzyC6y50VWf3C2gZMmmRZhIstL/lhijFHvnQXTMlup7Tqm126Rqa
 cJIhwvTGyQL4M/i1NClzx61ie8Qn3IroX1Q5GF+sKHomnfHQ5zSrqGkCk8XdjWH5l8qC
 7TuyAzcBHWoWll8UXTeiulMlyzJj6gQSe5xSsX0gfA+tkznmwR1CpX6e9oVu5cbcSZbj
 EomW/qRznw1jzIJeWiPLkgt2A8y507dWnvYANp4eup5PBK/kllD5r/chZ6nEsnNkK5l5
 qtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184618; x=1689776618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5BMeKkCZ73ncSnRSQ8wFapQINfHHQYDpYeSup4OEv0g=;
 b=LaDQZCX875Hzu3D7pCEJkTt7ByZeAydWc/5VXZzFjMLKCQElJ0bGfs/0JD+kIx1iXM
 iYQ2vQih3Ob1R/Rj2cOmxUmmFVCw3G9IiUEThUTZRHPUfd46SdKW5JwHLXZGbI8ODl2u
 Tx6phMTKtU1hRWtUPXU4zt9rL5JMlbG76m4lTnh4+lT63NJ+FnpCwh7KYNrmjeikEuRO
 gA2Tb1y0MYRKyYvbeq7Pnbxlopcdy3BDl9JHsdwrwnpxP5x2vP9RuOn+0Q7JwlouxrFa
 lcoYM6iu72NrfKxIxSSbtaKGniIGwt5mU6n+r5fqcA6quIm5KfT6ZY3HC+ow6FphBTXn
 hMbw==
X-Gm-Message-State: AC+VfDwuoCBn6HMXczLpx+Io8TMeaYv95wF6luSS+GxLO3jrHUOnOPtK
 euEz/NGWcSaJeWlI5VWA2Da3yr3OkWba9dTJJ/NFNZQV
X-Google-Smtp-Source: ACHHUZ5pTjQSEzrHyBXQudaj3As8CWTos97EyiP19H3PtZEGsZvvApugJjPkd8vmGnwuC0p+gCx6kg==
X-Received: by 2002:a05:6512:55a:b0:4f3:94b5:3274 with SMTP id
 h26-20020a056512055a00b004f394b53274mr6201824lfl.63.1687184618283; 
 Mon, 19 Jun 2023 07:23:38 -0700 (PDT)
Received: from stoup.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 k25-20020a7bc419000000b003f96d10eafbsm4143467wmi.12.2023.06.19.07.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:23:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v3 1/5] target/microblaze: Define TCG_GUEST_DEFAULT_MO
Date: Mon, 19 Jun 2023 16:23:29 +0200
Message-Id: <20230619142333.429028-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142333.429028-1-richard.henderson@linaro.org>
References: <20230619142333.429028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x135.google.com
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

The microblaze architecture does not reorder instructions.
While there is an MBAR wait-for-data-access instruction,
this concerns synchronizing with DMA.

This should have been defined when enabling MTTCG.

Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Fixes: d449561b130 ("configure: microblaze: Enable mttcg")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 88324d0bc1..b474abcc2a 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -24,6 +24,9 @@
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 
+/* MicroBlaze is always in-order. */
+#define TCG_GUEST_DEFAULT_MO  TCG_MO_ALL
+
 typedef struct CPUArchState CPUMBState;
 #if !defined(CONFIG_USER_ONLY)
 #include "mmu.h"
-- 
2.34.1


