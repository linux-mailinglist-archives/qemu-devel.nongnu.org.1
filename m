Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A2273EF32
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 01:23:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDvVV-0004aC-Us; Mon, 26 Jun 2023 19:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDvVM-0004Yy-3B
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 19:20:22 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDvVK-0008FS-JP
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 19:20:19 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51d7e8dd118so4075317a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 16:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687821617; x=1690413617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pRy1smRnPDEJWswv+qhjtEvNkpiteoMQEnPYOKlgw5s=;
 b=Bm75F9DoAmITIp/rLy4Q4YNk//DodWSRZMFlViS+JNP1vQPyZtqXpsErSKH6vO9Lcy
 Gb2FfJ4D/Avufq/mHF9zOnfOg954iMJL5//BFVDuFDCl9ggpGq+8rXKiYxZuzXR/CNsF
 oAu545PQj+fFrZX192CVZW2T6VxPIuzpRABbsY3f79M/XYSxqaV11mJ0aXwVV/PNqmCT
 RvSGJOWb/BTOmjGg8IUxVz2IPIS+Xc3wNDOTuHeFmY4ruLKNYmYoTmLOMJ/za90GMbWy
 ufTlhnwMlSdha7UbUBOGFzXQKOLhBDBvBljeWPwGI3c1YGTGNxh4tf5j7Sb3ylLIqDAt
 RKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687821617; x=1690413617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRy1smRnPDEJWswv+qhjtEvNkpiteoMQEnPYOKlgw5s=;
 b=AdE37fPTumYwyePthPklrEHUpBKauHW3wMmrFyYsRrynmHqZo1xfdQqFa+QCvLepUk
 LJb5stgeMjREKOpOe6EerMWCet/6yi0u74u0hwk7sGVuVQ3T4N7WsCSDpLa1C8zlWQdp
 mHchSbBqGv40Hr1PpkPi80b3dcIB85/8gINvcRuGuvEEVLccCFGlxhwh4L8X6kCuXWNJ
 BkHFDly5p+THYr3kD4kes3RX6TAL8uWCFyNbV05qk+E3uWuoLav3+IdK9AuZQlMROmnE
 ws6gks/6tZSpgfREgBFQwCUh/p/8A2Iw+Ptt1MPNDZR+ZtULMgp76IIRii8sMIAQVlD+
 M7tw==
X-Gm-Message-State: AC+VfDy7peUsZYkdBynHW94MqwScH5GdIL5p6/6rYxVxLPfZVryQW5MJ
 vq313GHIhO1rrdkwqKyjWAw+49kChWwRYBwX6KY=
X-Google-Smtp-Source: ACHHUZ6WgNvsIhiCSTxOr9Qv3jRK+vKujnm8cTxau+oX05bANew6dzUvg26t6lwJt61HQaLPSC62jg==
X-Received: by 2002:a17:907:160c:b0:991:e849:e13b with SMTP id
 hb12-20020a170907160c00b00991e849e13bmr2141227ejc.10.1687821617099; 
 Mon, 26 Jun 2023 16:20:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.226])
 by smtp.gmail.com with ESMTPSA id
 rp25-20020a170906d97900b0098e17ea781csm3057144ejb.94.2023.06.26.16.20.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Jun 2023 16:20:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org
Subject: [PATCH 01/16] target/riscv: Remove unused 'instmap.h' header in
 translate.c
Date: Tue, 27 Jun 2023 01:19:52 +0200
Message-Id: <20230626232007.8933-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230626232007.8933-1-philmd@linaro.org>
References: <20230626232007.8933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 8a33da811e..bd33bc3f51 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -30,7 +30,6 @@
 #include "exec/log.h"
 #include "semihosting/semihost.h"
 
-#include "instmap.h"
 #include "internals.h"
 
 #define HELPER_H "helper.h"
-- 
2.38.1


