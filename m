Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7C37E1FBA
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:15:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxPb-0007P5-Jd; Mon, 06 Nov 2023 06:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxPW-0007E0-Te
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:04:53 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxPQ-0003r0-CL
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:04:50 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32d81864e3fso2500003f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268683; x=1699873483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=edoh0A4VIBHnomUl2UTL+gBl3YX8JThMwON2libfRQU=;
 b=mOi5+AJF2xz9OJV0kmOdWIhifUOk9CCzXvww3K8+CYgk43hxnbXLDknRg+VC/erPxb
 PpxWxbtg0kablkYcxWKqAvqjvbWVIzLD293aNWIY3++eAB+DwjC/5v196BZqztrJVvhG
 T66TqGFbh232mndE41cYJ/xrx8aVsKTOwhv1GYlMxt87fw37WBuChQBxAFcEexmCgM8s
 fNWOz1sGrU8P7Og/84lo4VnhANEe4QZxFDsQTShuQxdXV9TM7R0bTV4d7y/bxzvoVrJk
 5DZt8STN3ypP2bdLmrzyKw2ewIBW7PRXckToBltbsYVPwyYG2d5WV9OlDqoEfB5OtoQ1
 xozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268683; x=1699873483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edoh0A4VIBHnomUl2UTL+gBl3YX8JThMwON2libfRQU=;
 b=Wvbzv/FqWwlWuWSj8dUfSVm47p07Au1vUh3K/sQvREy8nTxcudKekdenRu+5CcVvF5
 1Zm0k3JrZ38Y49fF03nhEoekcf3R+R7p3dZaBdm8sj1RbFP0/Qsph8HxcesQQGF7RqQ6
 uHY99YdG7wgUWjYK9xk+dlKRaEJqb4xtunJwU5LoXHvJTt/oq70JyIOg9RkOPK0g6eOy
 fG3M7NPA29Sczou8vHoFdD9/qwMFUdqonHRqzagG7/iIL5FUjTx5r/NExyNoVs6q9duS
 7fETgHFJK+YN7YkP7cncsH1E4L3LEsyVbZwuoQ8k0OzMqA37hS3YKlZtDbBjf/DqZLFg
 f+8g==
X-Gm-Message-State: AOJu0YzzfSuYjMpyOLWNewFTVWkvr3842loJTefYPO2n+ywtkpc4c2y/
 NtI9Dg0M1peCK7EezY6c1sLcZkqLcDDDv4u7iLw=
X-Google-Smtp-Source: AGHT+IFlBVNG2dMbfKa3SmCrF8WLEs8NXPQC60vm5+BiWuQcq5Hh8zZkMSTj4OjAvWykBZy1YCBg/g==
X-Received: by 2002:adf:f0c8:0:b0:32d:a2a3:9533 with SMTP id
 x8-20020adff0c8000000b0032da2a39533mr23224446wro.59.1699268682776; 
 Mon, 06 Nov 2023 03:04:42 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 y3-20020adfe6c3000000b003140f47224csm9111991wrm.15.2023.11.06.03.04.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:04:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PULL 09/60] target: Mention 'cpu-qom.h' is target agnostic
Date: Mon,  6 Nov 2023 12:02:41 +0100
Message-ID: <20231106110336.358-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

"target/foo/cpu-qom.h" is supposed to be target agnostic
(include-able by any target). Add such mention in the
header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231013140116.255-3-philmd@linaro.org>
---
 target/arm/cpu-qom.h        | 2 +-
 target/hppa/cpu-qom.h       | 2 +-
 target/microblaze/cpu-qom.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 153865d1bb..dfb9d5b827 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -1,5 +1,5 @@
 /*
- * QEMU ARM CPU
+ * QEMU ARM CPU QOM header (target agnostic)
  *
  * Copyright (c) 2012 SUSE LINUX Products GmbH
  *
diff --git a/target/hppa/cpu-qom.h b/target/hppa/cpu-qom.h
index 67f12422c4..4b1d48f7ca 100644
--- a/target/hppa/cpu-qom.h
+++ b/target/hppa/cpu-qom.h
@@ -1,5 +1,5 @@
 /*
- * QEMU HPPA CPU
+ * QEMU HPPA CPU QOM header (target agnostic)
  *
  * Copyright (c) 2016 Richard Henderson <rth@twiddle.net>
  *
diff --git a/target/microblaze/cpu-qom.h b/target/microblaze/cpu-qom.h
index 2a734e644d..78f549b57d 100644
--- a/target/microblaze/cpu-qom.h
+++ b/target/microblaze/cpu-qom.h
@@ -1,5 +1,5 @@
 /*
- * QEMU MicroBlaze CPU
+ * QEMU MicroBlaze CPU QOM header (target agnostic)
  *
  * Copyright (c) 2012 SUSE LINUX Products GmbH
  *
-- 
2.41.0


