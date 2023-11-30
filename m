Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 638B57FF1BB
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 15:26:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8hzM-0006II-JB; Thu, 30 Nov 2023 09:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8hz4-0006HA-H8
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 09:25:42 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8hz2-0008Ue-97
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 09:25:42 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a00f67f120aso139350366b.2
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 06:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701354338; x=1701959138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIkyywCV84pixVtgL1sg5DGw0uU59TDxgCkewEW8ZWA=;
 b=x+h5n80jNYvLNFDbTDUSqEOuvy4Xwe7SIP3w4w6ZkMPz6gB8fMJbmlwvbpTD0JtKAb
 n4onOvvL/Jk4e2HLEgqp7Grk/d4mf3ao3nEAt2j+rTC0tFHTg1zUr7nWL5UGAZrCgNzG
 2JqOgE7ErniQGfZc4RiapsBSNt0TDEIsSpEMLq041dof6sltz2kjoADPbpWyhzdlddEd
 Idy1N6gYsNhbA+xWFlMr03u1aXjXZLB6hPYj+Bbq906kGMPWu6FxdrSKWSm2F3VsTi4n
 +lb5R2vRx0hQpexuk6qvr4wKocbBChflV7TiY9dUAjEcPntv54XlyAeCPzsAWVYjwGdd
 gCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701354338; x=1701959138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xIkyywCV84pixVtgL1sg5DGw0uU59TDxgCkewEW8ZWA=;
 b=dKFxcGCEBtNG5urk5RYsDf89XK+bWUXTZjeUke7XqScGRPO/8+ftdPTN+yJf67DzjW
 4OoZ7FNS+d/tEitQz33Xjxx/xXmCIhkE6qaxfwKcmALZQvy3JgIz81TG/qBhAedenBXD
 nTOHD0PKFq9G27Bt9hT8lLlPDDKWsuUrtyPAmOV0m61v++sFBxYDviZDJRpAsrp6Ky6a
 azUjOQH2VvCdIWWxLH1GdwbnZ7AkH816VH1TKYw3DBrR4jpZkwnIMjFDWSMFx9xgXuaj
 8llh1uE0AfvYThLxJ/nfxCJKADK+Ykc0HAnPBeNCwrs9T3pbqGwSPr3vP3nzwzQ8m/nQ
 kKTQ==
X-Gm-Message-State: AOJu0YwLs4k2oDyCF18cBskqASTx1hONayG8gst25yL23g6vwayohEC7
 GBAXlzO5Lrk8mwMi5BqpJ5ieU3TfwZ6JcBIDoxgK3g==
X-Google-Smtp-Source: AGHT+IEpyAnrNBvuMziOwmmwDC1iNrqxscHHuoDGifVRWcovxZN51cUU10YATP1nmC1osU6RFMv2Eg==
X-Received: by 2002:a17:906:738b:b0:9f8:2f30:d74f with SMTP id
 f11-20020a170906738b00b009f82f30d74fmr14711296ejl.7.1701354338665; 
 Thu, 30 Nov 2023 06:25:38 -0800 (PST)
Received: from m1x-phil.lan (sev93-h02-176-184-17-116.dsl.sta.abo.bbox.fr.
 [176.184.17.116]) by smtp.gmail.com with ESMTPSA id
 n23-20020a170906089700b0099297782aa9sm726356eje.49.2023.11.30.06.25.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Nov 2023 06:25:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 3/3] target/arm/tcg: Including missing
 'exec/exec-all.h' header
Date: Thu, 30 Nov 2023 15:25:19 +0100
Message-ID: <20231130142519.28417-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130142519.28417-1-philmd@linaro.org>
References: <20231130142519.28417-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

translate_insn() ends up calling probe_access_full(), itself
declared in "exec/exec-all.h":

  TranslatorOps::translate_insn
    -> aarch64_tr_translate_insn()
      -> is_guarded_page()
        -> probe_access_full()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/translate-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a2e49c39f9..f3b5b9124d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 
+#include "exec/exec-all.h"
 #include "translate.h"
 #include "translate-a64.h"
 #include "qemu/log.h"
-- 
2.41.0


