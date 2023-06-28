Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 283E27415FF
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:04:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXX0-0003KE-TQ; Wed, 28 Jun 2023 11:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXW7-0002jj-0S
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:55:41 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXW1-0001mw-Uc
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:55:35 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbac8b01b3so10596425e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967732; x=1690559732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qz29A1ML+XjIA5GtszhnA3DMxy9UGUE/LdJiJcvkUvk=;
 b=pccSA1CjL+LQWMKoqD430Xejhvf3cHydHRWuHTGkP2TmWmkpY+4r+JD1VMKKVvzkp7
 9zpVSRonrvKmcctiDb59HlfL07fAGonido50NY/CD6+MlQmyVVV5gK5zwbTaYPgxGwtO
 VZSXWPvMrM2r+iWHDdSDquYJJqbYwdkBs1g215cZJUozQxT2Lr3vOdTgimB/AG4eT2NT
 73AmfVFWVlQt5J60V4memIFpqfSJFPgEP942ZcHUgXleMIOqsCPx4H7c+YwddZdr00r4
 EB26pVc7d0zaxnrvEqki9cOypQ8y4F7bmUMgIDcjjAZxEtsEukkwOCeFCa8FUlTiFH7D
 sBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967732; x=1690559732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qz29A1ML+XjIA5GtszhnA3DMxy9UGUE/LdJiJcvkUvk=;
 b=cJevW1yih5KjjkGXjYRzJkvm9MUfg/8crGcpFg1hDPPDaeSmzW1hbN0mtE15CxRQjc
 8wzpOUSVQX+krUXapt2YODGnvmDVgYAT8rrtHWhAaUhkUrU6JqpTD43p3hoxoz5jOFZr
 LAaivKssAEDCEr6EIj6kr1kLXB7qriTXEH95C2yDseZivwUMomARGzr+fFAD5qybNQx3
 uQYegUeuO9xtf+LQBlVkpFlJRkB8EXhYAzvW8cS9ZATKZIsJ5CDt4eGdJnKShHu8BRvr
 FpTz3hs3BQnnd1fCA7qyVah8x10llIHIegU0dlV701PmzcJwNgelUv4Hy7sXGLZ5C55n
 hH4w==
X-Gm-Message-State: AC+VfDySvR4+mvbSyjcNrmshs8V/pvALMjl6GnC+mdFR6bJQeaNsP3dc
 if+E8FEDIE8XAN95kvgWMuR04fJJeioe8PKBqG8=
X-Google-Smtp-Source: ACHHUZ6bDUpCN6Q/eCZOeLE2hcMgF0hI0xR/1fw4j4W+CDNpFb6IlB3+9l3LWFAq6t2tG3NECi6R/g==
X-Received: by 2002:a05:600c:4196:b0:3fa:ef97:1fa5 with SMTP id
 p22-20020a05600c419600b003faef971fa5mr2108083wmh.6.1687967732236; 
 Wed, 28 Jun 2023 08:55:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a5d4f8d000000b003063db8f45bsm13616182wru.23.2023.06.28.08.55.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:55:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/30] hw/arm/sbsa-ref: Include missing 'sysemu/kvm.h' header
Date: Wed, 28 Jun 2023 17:53:06 +0200
Message-Id: <20230628155313.71594-24-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
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

"sysemu/kvm.h" is indirectly pulled in. Explicit its
inclusion to avoid when refactoring include/:

  hw/arm/sbsa-ref.c:693:9: error: implicit declaration of function 'kvm_enabled' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
    if (kvm_enabled()) {
        ^

Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230405160454.97436-6-philmd@linaro.org>
---
 hw/arm/sbsa-ref.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 66500a5b08..82a28b2e0b 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -23,6 +23,7 @@
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "sysemu/device_tree.h"
+#include "sysemu/kvm.h"
 #include "sysemu/numa.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
-- 
2.38.1


