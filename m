Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 163AE70E9F7
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 02:04:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1btl-0004Ik-OM; Tue, 23 May 2023 19:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btf-0004Gi-AD
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:31 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btS-0001oD-7G
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:31 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64d3578c25bso162306b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886296; x=1687478296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+VrjHOrusR8Ccf+/cO3Nyi/RyoonOjF8bnygB9K0pI=;
 b=czmXDrrh7tx4ODpM2K55eUXihYngN0Yvrr7nO96dMcUYopRf6gxylD0zaN5xpi1OnV
 vbscGG7lX41pGF/ZDnpKaj5eBPhS2cvrOfelTJTHTNvz8m4z8lcYF4hRisDv/6w8U8Y2
 6x1q+9VgRtEd8JcGlY9vhsdOsVcS6yvhFC+CbjjRv2lJQaPvAiropuyNrluoahzO+xfj
 lSDnNTJH8/PcRJa/EvLJCbOTSr0RQs7P0yjYCDO1sIJ5fCHpQ/sGeqleXDEk8QT36zWB
 glFWSrds4yIt6Et202k+qLk1fmOZpu+3zJuE2jBgGlagaCpNNLmLGPuVJmLiUaUpAn4z
 oWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886296; x=1687478296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y+VrjHOrusR8Ccf+/cO3Nyi/RyoonOjF8bnygB9K0pI=;
 b=QXO/GuCVKOXX1oXDp6WuvqPGh08Bk9Pk3+zukS7PN7lgW1M97ycopnhLnXcoxxbd9T
 Mv+U0vkuTTnjI/fpWxGRV+vE6w5JozEdDJOBO6t1Z1qh2e0HSYBO1J7nx2SJPXOLOIal
 f6jUuQY6+1wJ3BFesx+HnYqFZJUJdKtzXm2CNsB1Tt4tBcm68L6OA7sBET/H9HmO6E0M
 SOldlOrADSbN5Ht5gIMxArpR9A8MGdCdUANooyZx6YO0bRDuSvx1iNcAnS0dPb2eloXw
 F38Vn44TcCK1rV6hOC8hnK05xp/VR82eLSUI0CNIpWBC3gB2vIPSqgcHFZbOpKYA2gNa
 ForQ==
X-Gm-Message-State: AC+VfDzttWitd6iIRLwJlXeCEW6JubaqOUjYxJ+hM204YkEHDaJJEJpM
 B/YhNVz5hf0Wa2jz94YnhXGLkHBDTQvDBxm+tI4=
X-Google-Smtp-Source: ACHHUZ48IrMm0O1RKgG+G50+EkFkvUPF7dJdX2L3UyoKUHB70jDICYjMAf1x2SBjWoLT/8FhRuhSew==
X-Received: by 2002:a05:6a00:1303:b0:64c:c5c0:6e01 with SMTP id
 j3-20020a056a00130300b0064cc5c06e01mr815871pfu.31.1684886296215; 
 Tue, 23 May 2023 16:58:16 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 12/28] meson: Fix detect atomic128 support with optimization
Date: Tue, 23 May 2023 16:57:48 -0700
Message-Id: <20230523235804.747803-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Silly typo: sizeof(16) != 16.

Fixes: e61f1efeb730 ("meson: Detect atomic128 support with optimization")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index c516b911d9..ef181ff2df 100644
--- a/meson.build
+++ b/meson.build
@@ -2557,7 +2557,7 @@ if has_int128
   # __alignof(unsigned __int128) for the host.
   atomic_test_128 = '''
     int main(int ac, char **av) {
-      unsigned __int128 *p = __builtin_assume_aligned(av[ac - 1], sizeof(16));
+      unsigned __int128 *p = __builtin_assume_aligned(av[ac - 1], 16);
       p[1] = __atomic_load_n(&p[0], __ATOMIC_RELAXED);
       __atomic_store_n(&p[2], p[3], __ATOMIC_RELAXED);
       __atomic_compare_exchange_n(&p[4], &p[5], p[6], 0, __ATOMIC_RELAXED, __ATOMIC_RELAXED);
-- 
2.34.1


