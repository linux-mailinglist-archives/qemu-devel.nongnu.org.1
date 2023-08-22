Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A384B783D0C
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 11:39:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYNpr-0000XY-Ah; Tue, 22 Aug 2023 05:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYNpp-0000Wt-Ah
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:38:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYNpn-0001jx-6w
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:38:01 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fee5ddc23eso28687265e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 02:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697077; x=1693301877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XE9v7foDNFxPe4946YxN3Nb7epPtd1r5RF+iq2i5yko=;
 b=cso+sRbOVwJhQ5sWKY78qogSQx+0FyJXIY04LJlWwODOf8canyw29dTgwAz1bk8T5i
 8tJfCKY1/K8IWZBMKak3GRsedGt2VO/hPl/p9LozNrf6/8gP2CfTBk59zmf2zhD1MiXr
 7+cvQ5NwUfrHMMpG+KQ2zPdewr5PEgEp8tMr3Qr0waqvD9y09Ft/RJtc2IPlQSBknVyi
 ONLKno0Oi4cS3pODEL7t/ExCRsnqoqfeHghBijkGw+o5QE7pmTr/cx84eVEE9Xhw78VJ
 3xNlp3h0RsUUFNePzj0bp9DtA2oUa7cF/0Hd+S7uLusDNmA6l/t68u42DFIllFhw5XQ6
 DwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697077; x=1693301877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XE9v7foDNFxPe4946YxN3Nb7epPtd1r5RF+iq2i5yko=;
 b=NrOPQ0g4N0GF+tcuUfqjXifHPBXnWfDPQ63kZSW8Fac3a3MO4eVm76dd/9Ca2Q3ucb
 M3znXlVzMD3oHHdX3AjeWIM+uSr7ZtaAuzf0Yhn4cTEM5fYKDuIEkSu7WzvUezeLV6cL
 8FYfaj5mVBQB7Ie/7vGxrh4rDgdQkLxugJYbYsgc8KYbgjL4hSfiz/4PHMuoEvblAJ6/
 7kWPWnVu65Hf76mtylbwuTKueUrY8hbXHxclOLgQBn2eO6CoTWuFkZfGqJM50NL4ShBX
 4VoxGi5kIQ3ABivkRBRyfmO/L4W7emGjbYN+Kh1SPYfn2RL2EVSvJgYkt81PJEi9gri0
 f04g==
X-Gm-Message-State: AOJu0Yyti5R+YjV4ttbd6NEnCsE+T6dM23EbmjUANk36Jxezs6YF2Wpa
 lBX28bACbXWQMgrDsVhd+aUkkFeDnNxrMADiW/BfGA==
X-Google-Smtp-Source: AGHT+IGsjoxUOYPdjAYgJm69U2YAiNo2gb26M8LDKMcWkpCfqzb9Ntc9GXEQO6yCvr/OOPNNtk+Trw==
X-Received: by 2002:a1c:7908:0:b0:3fe:111b:7fc4 with SMTP id
 l8-20020a1c7908000000b003fe111b7fc4mr6823728wme.21.1692697077420; 
 Tue, 22 Aug 2023 02:37:57 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a7bc84f000000b003feeb082a9fsm8688005wml.3.2023.08.22.02.37.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 02:37:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/7] target/cris: Fix a typo in gen_swapr()
Date: Tue, 22 Aug 2023 11:37:12 +0200
Message-ID: <20230822093712.38922-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822093712.38922-1-philmd@linaro.org>
References: <20230822093712.38922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/cris/translate.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index 0b3d724281..42103b5558 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -411,15 +411,17 @@ static inline void t_gen_swapw(TCGv d, TCGv s)
     tcg_gen_or_tl(d, d, t);
 }
 
-/* Reverse the within each byte.
-   T0 = (((T0 << 7) & 0x80808080) |
-   ((T0 << 5) & 0x40404040) |
-   ((T0 << 3) & 0x20202020) |
-   ((T0 << 1) & 0x10101010) |
-   ((T0 >> 1) & 0x08080808) |
-   ((T0 >> 3) & 0x04040404) |
-   ((T0 >> 5) & 0x02020202) |
-   ((T0 >> 7) & 0x01010101));
+/*
+ * Reverse the bits within each byte.
+ *
+ *  T0 = ((T0 << 7) & 0x80808080)
+ *     | ((T0 << 5) & 0x40404040)
+ *     | ((T0 << 3) & 0x20202020)
+ *     | ((T0 << 1) & 0x10101010)
+ *     | ((T0 >> 1) & 0x08080808)
+ *     | ((T0 >> 3) & 0x04040404)
+ *     | ((T0 >> 5) & 0x02020202)
+ *     | ((T0 >> 7) & 0x01010101);
  */
 static void t_gen_swapr(TCGv d, TCGv s)
 {
-- 
2.41.0


