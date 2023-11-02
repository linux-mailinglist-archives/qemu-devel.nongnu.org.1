Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7F67DEA6D
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:51:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMeV-000755-5C; Wed, 01 Nov 2023 21:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeM-0006LG-Rk
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:35 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeK-0004Jy-Mm
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:34 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b44befac59so1258913b3a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698889049; x=1699493849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExjsDSAVXPHl9Xgq+QdlGUyx4ksBZYfOfahGxiLtgN0=;
 b=GAH4msn5JfduD0z1BBRpwp2i+HGXH+cIONkajZZv9UHkBGfswE+lKpi8xltDB+7dbJ
 LbkOQcNrL6azsgn7AOY+Z6qTHkQ6i0klOQh/eFWjU8U949MUupSvrIP+w3iNs5V9Io7+
 Na1GyexkqIMUqp2XAgyW4SmkTHDzBYG0JtaGvgCwluVBoD4db+3ntBxb4n2aVqxgoJJ1
 lz7g3egaAGOlTjcJVyek6HZ3o6fOR63A4nTEwGaWQrj31WpS+SXh2Kk6UD1YBoKDaIM2
 8ALFqzDQ1QfbYa+Fd82PcKhUwCR8hYrrcQn74YtA+NVXBnO0Nt5BId4R4f6WaLEz8Eb8
 /1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698889049; x=1699493849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ExjsDSAVXPHl9Xgq+QdlGUyx4ksBZYfOfahGxiLtgN0=;
 b=OFDjjw4qVVNnlyeNwyWESgLUkgHj/RPdgqe1M7izsN5kTAqbapwvHujJ5CQ1VxPuvh
 R8Q/N6iNjGwq/Eo5t7UZATyg6/3PFUq9Ax5HvHt33jwiG3REMa2YRANdUaGqPoxfhOr0
 sH5bu7ZegE3gKY7g92EvXtPDMC0PRuCgLnXiZc6nJkZ7t7kfZxa9hFe//QW/5Sj+LxFv
 qqFhrytvDlbvuCiSykaElZ0MyIaX5csBIrR8ZEFDSBYbX+Nj5xwnU06atMdZ+B2T7mnG
 7epmNWkSz0S0YmMsCnuGOdW6IbRmJGXO06MxyCrKwzYbgzD5gG3GohFwrp/CMy61OR/D
 3HQg==
X-Gm-Message-State: AOJu0YxMSXCmIjG+4EoEMkohv3RGUkWB/oDQXi2neV/IQLg9VFBauiNq
 p5GxfSvxkks2rCWm/KsRDP4g4Z/VtmwCc9Hf4jw=
X-Google-Smtp-Source: AGHT+IHfhF8bnx0JF1s9kwLKXkoUL18xTEWon9qJvFJEocuNfu6th4iyx4MbrPzjFobGfk5msaxp7A==
X-Received: by 2002:a05:6a20:4325:b0:13e:debc:3657 with SMTP id
 h37-20020a056a20432500b0013edebc3657mr7908070pzk.30.1698889049425; 
 Wed, 01 Nov 2023 18:37:29 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v20-20020aa78514000000b006934e7ceb79sm1800230pfn.32.2023.11.01.18.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:37:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 85/88] hw/pci-host/astro: Trigger CPU irq on CPU HPA in
 high memory
Date: Wed,  1 Nov 2023 18:30:13 -0700
Message-Id: <20231102013016.369010-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

From: Helge Deller <deller@gmx.de>

The CPU HPA is in the high F-region on PA2.0 CPUs, so use F_EXTEND()
to trigger interrupt request at the right CPU HPA address.
Note that the cpu_hpa value comes out of the IRT, which doesn't store the
higher addresss bits.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/pci-host/astro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index df61386bd9..b19f0917c5 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -384,7 +384,7 @@ static void elroy_set_irq(void *opaque, int irq, int level)
         uint32_t ena = bit & ~old_ilr;
         s->ilr = old_ilr | bit;
         if (ena != 0) {
-            stl_be_phys(&address_space_memory, cpu_hpa, val & 63);
+            stl_be_phys(&address_space_memory, F_EXTEND(cpu_hpa), val & 63);
         }
     } else {
         s->ilr = old_ilr & ~bit;
-- 
2.34.1


