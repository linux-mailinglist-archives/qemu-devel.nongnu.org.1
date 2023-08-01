Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A4776BFA9
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxKw-00049g-6u; Tue, 01 Aug 2023 17:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKt-000451-H9
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:55:23 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKp-000525-79
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:55:21 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3178dd771ceso4635814f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926913; x=1691531713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxy5Yn/JsCpPFvBWg/TvifCvOz534Lkl3K0+WTl0qy8=;
 b=j2ZO/9RSPZ4OW5Fnn0l+NMxpcJ6rqKi3/cfLXUT85R9nUgrkxzmEGedDM6YLIXl2Mf
 4j3zT0dOOJQjcuDYSMekPo+m6URA4im+/czDpES+KZQTpQ0gCUZuAF7zvEN6SwJ+oBWU
 7NVaX6k3D1IGYsN0c/vS9scTQPJtplO8JYNrbNBetWsZ09YGuUyYzc4Br5uDOqSuwIbe
 v+33poJHrqN/JkQljwSa/g17Bw8I6qlA/7DMTFDx6ZpO9GmBtJW1a/Y3PdnfbgRA6vWg
 qA5KCqMQcpg58SgOkQv6VCyjBwk5i6XXgGBGh9/eLdjmxKkBg7qSo3pVIipJbsC38HJj
 AaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926913; x=1691531713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pxy5Yn/JsCpPFvBWg/TvifCvOz534Lkl3K0+WTl0qy8=;
 b=Toewt5tcrlX0VGXwd9kA7VdihyGcxigm5iEhlm1cbjRHhX9BcTo6dAUT8/5DEqqbVP
 H7GTEHVC7Ez/hpv3xw2SGTsMR4f07wHa5dkClXWpJwmEgklRvIXkvNLYrAxBA557W1KK
 lYG3GEtXvh4pJJa2YdGTCcpgQoz0PDZlELq8AUZ3tbluF9x0SLwC607tVN0yExUN/1TE
 lfjchv4UW6+tZ4+jlcI46N5OfLDf4WrdnzbUHXKbNS4OwQxef5/LP7UUO2GBR4jEh+B0
 GIWzuWSw/CYIJqlT/apvcFtQp7f+wayCYNgqQ10OvOuXb6gUZ8Fx5riZ1SVlgbteisU2
 xfjg==
X-Gm-Message-State: ABy/qLbA2nea1Om06DzifO88sxT0oZYiDoXVYrNp9MMQcQk6RuIrKPHf
 lmYWVsDxCMzdOKuRrAat+5HS+Yh0n/HmXo5Ag30=
X-Google-Smtp-Source: APBJJlHNBNyKI1rn1bOjtvZ/jSwLbfQRuDFZpNXF9K+ebYpX1aTNF9PP1TSJlSf0ADn8TyzALhevJg==
X-Received: by 2002:a5d:608a:0:b0:313:e8b6:1699 with SMTP id
 w10-20020a5d608a000000b00313e8b61699mr3328575wrt.55.1690926913384; 
 Tue, 01 Aug 2023 14:55:13 -0700 (PDT)
Received: from localhost.localdomain ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 r8-20020adfe688000000b0031434c08bb7sm17004764wrm.105.2023.08.01.14.55.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Aug 2023 14:55:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 Keith Packard <keithp@keithp.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/10] target/nios2: Pass semihosting arg to exit
Date: Tue,  1 Aug 2023 23:54:19 +0200
Message-Id: <20230801215421.60133-9-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801215421.60133-1-philmd@linaro.org>
References: <20230801215421.60133-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Keith Packard <keithp@keithp.com>

Instead of using R_ARG0 (the semihost function number), use R_ARG1
(the provided exit status).

Signed-off-by: Keith Packard <keithp@keithp.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230801152245.332749-1-keithp@keithp.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/nios2/nios2-semi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
index 3738774976..f3b7aee4f1 100644
--- a/target/nios2/nios2-semi.c
+++ b/target/nios2/nios2-semi.c
@@ -133,8 +133,8 @@ void do_nios2_semihosting(CPUNios2State *env)
     args = env->regs[R_ARG1];
     switch (nr) {
     case HOSTED_EXIT:
-        gdb_exit(env->regs[R_ARG0]);
-        exit(env->regs[R_ARG0]);
+        gdb_exit(env->regs[R_ARG1]);
+        exit(env->regs[R_ARG1]);
 
     case HOSTED_OPEN:
         GET_ARG(0);
-- 
2.38.1


