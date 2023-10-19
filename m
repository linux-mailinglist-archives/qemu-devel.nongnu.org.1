Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EDB7D03F9
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:26:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaQx-000701-Gm; Thu, 19 Oct 2023 17:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaQr-0006q4-H5
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:19:53 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaQp-00059T-NL
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:19:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so1012695e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750390; x=1698355190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8cFSDOivNgHcSX8AYNeAVwR9ly4r/Wc+Ax9HhfRkEQg=;
 b=XcKljRmtB2u3/ZGfT6kCgCtsyjNX+rIcWuRmdx54JpRfxhT8cL5tCtKc42R/zcwkcZ
 TePWU9cq/EeAkWH0NP/DznUJnFYQKUoQmjWVZ5/KEUE7W4L1XCZ6Bt2Os+QDhuZP48W9
 quAY7f9skv4DzOVDcgMtk/E6WOjipKBZLmN31NPs+/czeHv8bVv7MrUqho6WTXB/oYM6
 20TjSXYxRl2eabpTcMcKWsEoqvOSd8LgUhjafxiQlpuSowVv3KPzdT8ReQHpcyuxTNnv
 FkVPEiDbZpp9jaEQLAY3155FaEUmuo27PXPlqAkKr3t+xHV0awkFR8aQJiH3OveYbTP/
 LtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750390; x=1698355190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8cFSDOivNgHcSX8AYNeAVwR9ly4r/Wc+Ax9HhfRkEQg=;
 b=OL8PVZb2gLdnou1dxMc7fMEu1efb2QPF91aYa+YreDC24Ell89hGzCTqZVtVv2SJLp
 FMZzPb6Tzy24iPspkEnV/WHK6axp91YwSCoVyiatNKIrKRnGCRVkCH500oE2uOsrZi2z
 h3+z7+HzCS96YjFKIAZRUzxfrSjNvCAf2VA9KRGTQ1xHtonpTAWoh5VTbXgiFwDkVhOs
 YYgfUWj9oPsYANflcgObNzpcoQc7Pr+c0ji7grB0W9ZM6AFoUvPx7L+6BwflpdrWn7US
 9UQLMvrb1+7mzhBfCk4QY3362Rl0hZ4jiUXV8HbzPGtAOTcMqAddB4XzOwq6km5yM9FM
 yFqA==
X-Gm-Message-State: AOJu0YwsiLqiCvnCqZRXpJLBU9272hOE1tiwo8ZmReRTpM1UumjUvKSH
 ajYP+JSzJo4zqHTgviV1EABWParWz9YAp3KT3n41sw==
X-Google-Smtp-Source: AGHT+IEuyiYEdZ0+ynIic1gJW+sfNYKiP0HuMZcZWCh5Z79qNf42KrrVrExBF8FgN1KH+VzrQ0LPog==
X-Received: by 2002:a05:600c:4f8d:b0:401:a0b1:aef6 with SMTP id
 n13-20020a05600c4f8d00b00401a0b1aef6mr67528wmq.2.1697750390242; 
 Thu, 19 Oct 2023 14:19:50 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a05600c3b9000b003fee6e170f9sm496411wms.45.2023.10.19.14.19.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:19:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 14/46] hw/misc/mips_itu: Make MIPSITUState target agnostic
Date: Thu, 19 Oct 2023 23:17:39 +0200
Message-ID: <20231019211814.30576-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

When prototyping a heterogenous machine including the ITU,
we get:

  include/hw/misc/mips_itu.h:76:5: error: unknown type name 'MIPSCPU'
      MIPSCPU *cpu0;
      ^

MIPSCPU is declared in the target specific "cpu.h" header,
but we don't want to include it, because "cpu.h" is target
specific and its inclusion taints all files including
"mips_itu.h", which become target specific too. We can
however use the 'ArchCPU *' type in the public header.
By keeping the TYPE_MIPS_CPU QOM type check in the link
property declaration, QOM core code will still check the
property is a correct MIPS CPU.

TYPE_MIPS_ITU is still built per-(MIPS)target, but its header
can now be included by other targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231009171443.12145-4-philmd@linaro.org>
---
 include/hw/misc/mips_itu.h | 2 +-
 hw/misc/mips_itu.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index a413789151..5caed6cc36 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -73,7 +73,7 @@ struct MIPSITUState {
 
     /* SAAR */
     uint64_t *saar;
-    MIPSCPU *cpu0;
+    ArchCPU *cpu0;
 };
 
 /* Get ITC Configuration Tag memory region. */
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 0eda302db4..5a83ccc4e8 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -532,7 +532,7 @@ static void mips_itu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    env = &s->cpu0->env;
+    env = &MIPS_CPU(s->cpu0)->env;
     if (env->saarp) {
         s->saar = env->CP0_SAAR;
     }
@@ -563,7 +563,7 @@ static Property mips_itu_properties[] = {
                       ITC_FIFO_NUM_MAX),
     DEFINE_PROP_UINT32("num-semaphores", MIPSITUState, num_semaphores,
                       ITC_SEMAPH_NUM_MAX),
-    DEFINE_PROP_LINK("cpu[0]", MIPSITUState, cpu0, TYPE_MIPS_CPU, MIPSCPU *),
+    DEFINE_PROP_LINK("cpu[0]", MIPSITUState, cpu0, TYPE_MIPS_CPU, ArchCPU *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


