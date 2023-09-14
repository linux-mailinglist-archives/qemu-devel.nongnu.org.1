Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1039E79FF7C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 11:05:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgiHS-0003td-0i; Thu, 14 Sep 2023 05:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgiHP-0003t7-4o
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 05:04:55 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgiHL-0001UO-Ur
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 05:04:54 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9a9cd066db5so100699766b.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694682290; x=1695287090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=51FdxLwj9DM+cKefw16e9y75Z71vVSnRdo16xzNGKro=;
 b=u4dhUkY/x1ZzgEno4JX3kFj56Dg9BqonSpXV/x8BxHacse7b0KWwwMUp/F9P8nu/8D
 o6krf6CAx+bwnI3EAQytDPeNVvi7yXyH9KjO1KotiVn9GRPkyurvkQDxdgZ+AlT40ue4
 CLLIMchH87mchNW4hQbO8poZ7blT9SlKmEECBD0fOafhx770RB9QgSJstGZp3oHxm6fD
 Yg7E4NdM9gffN+NEsZloZCIijS6HQyflzZsyatYQ7MxgwxrqZox5D9ewYv+giAdS6dSf
 KQLQOCFLkjc4goOFy/nNH0ijX82uz2LooBdevkvViPE9eJ1MN8e3FCTbWtkm29SyyhpC
 p+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694682290; x=1695287090;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=51FdxLwj9DM+cKefw16e9y75Z71vVSnRdo16xzNGKro=;
 b=o/8w/691RuVijHIq2ENsYnhAwVcgarKORKBX7TMwiFvxizpqolOjy9CQWB5g6G04lI
 WvbtnBYcVRMNuY4Io3xeAOlCMpnfaV7cbAhhg93P1gZNePSwAi/msm59AhgWEKANemzH
 krY62LpWpZBN0wxAdep80jVA5sgtkKI4cnaNGh1Nd5xfVD+ItZ/FXt7hUtm/Kjyji7X+
 r0wMhBWXAvL7TMgLMfQisTCm1F8pTZFDuOg6tosmmKPdmBzjaAqgzPMC3iaRBcVJVJEu
 ygdYg26kUdGSNa3fNLo7MgbNbX7aZYqsTi96h2+jnz6HX0FoJUAZMP9UGqjnscH8pB9d
 9rjw==
X-Gm-Message-State: AOJu0YwzqOEJGiEwipyzlxxxTOnE1XHignBmCqKuF2Q7G2Ty7LWfPqBT
 LLR+d8IZwzLBZjxgFlCqdQIp93gnc2cMx9ASn4M=
X-Google-Smtp-Source: AGHT+IHmZeSz/PD/dhmfuHnF4rAozqkpwxpJmuNvcIhY3xUJihxDRwTRl2nvOhMnNzxl/H4clFx6DQ==
X-Received: by 2002:a17:907:75e5:b0:9a1:d0bb:d215 with SMTP id
 jz5-20020a17090775e500b009a1d0bbd215mr3772627ejc.5.1694682290003; 
 Thu, 14 Sep 2023 02:04:50 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 jp27-20020a170906f75b00b0099bd046170fsm704625ejb.104.2023.09.14.02.04.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 02:04:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-stable@nongnu.org
Subject: [PATCH] target/mips: Fix TX79 LQ/SQ opcodes
Date: Thu, 14 Sep 2023 11:04:47 +0200
Message-ID: <20230914090447.12557-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

The base register address offset is *signed*.

Cc: qemu-stable@nongnu.org
Fixes: aaaa82a9f9 ("target/mips/tx79: Introduce LQ opcode (Load Quadword)")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/tx79.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/tx79.decode b/target/mips/tcg/tx79.decode
index 57d87a2076..578b8c54c0 100644
--- a/target/mips/tcg/tx79.decode
+++ b/target/mips/tcg/tx79.decode
@@ -24,7 +24,7 @@
 @rs             ...... rs:5  ..... ..........  ......   &r sa=0      rt=0 rd=0
 @rd             ...... ..........  rd:5  ..... ......   &r sa=0 rs=0 rt=0
 
-@ldst            ...... base:5 rt:5 offset:16           &i
+@ldst            ...... base:5 rt:5 offset:s16          &i
 
 ###########################################################################
 
-- 
2.41.0


