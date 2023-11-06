Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ABD7E1FAF
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:10:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxS3-0004Dl-1n; Mon, 06 Nov 2023 06:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxRr-0003Ej-OP
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:07:15 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxRq-0004f0-24
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:07:15 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4083740f92dso32048665e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268832; x=1699873632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ysTm3sVa8NXK5p6adWouAn7jMZtjrRCTYZ5tPCHuc7A=;
 b=SK9E1JI1dOxnqGGJCkijNACBPJw8IblqzpEN80ymUERXe5Ci4AtDUe/d88dvqF1cB3
 gB/wHBvevbGtb72RFpdYZwhSknCvlB+sZe0V7FjnWzGEdRb6AdzxLEl9CM0Z2VPMcF4B
 83oeBth1ED7cY1fYp0xW+HC81scKpHITX9NER3hwkesU6zFF76Pk7ct6UU/vCAUlZma8
 XT3jV+US6IPi3n25077Pb7PShULxrJ2SXnjwtNL4wRM7cSmeOF6YbmJJNOEK7hCM+xQ6
 9NbopSINGFcDUav1vUpOvCVM8aj9t18vsmYopmvnNkGUsZIMb0nwC3mTDhABfocCT8rO
 dgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268832; x=1699873632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ysTm3sVa8NXK5p6adWouAn7jMZtjrRCTYZ5tPCHuc7A=;
 b=ctnUrHC3lgehV8m9ZNe1dzEjzABe8aEkbitLDnRPwO/TmhFDk3aW7E+dlGZ+TAz07n
 OTbIfr1mO1piX2Z6Lg2nzghzenuBdn9zHpErJzCMiskmHarq4p4L+A8A6UexQ1zlitkF
 ryxIlvVguug6AUlfolz6nsbuKSfYNn5XpfBE/7PLmplszjfGBeFRkPO1LftEgyoOM3s0
 l1NdjdeY0yvdkKLE7TnwjlzAjp+Uq8vW43gDTLgok4TE/VIBefqCsb0h3fzIa6R6jGVr
 UYhXiZnE91EtkEXtVoldF2W8WEYwxzpfb1XsoDqaCVzFGbZpkFOaG2wYLh5F03UcSBJ3
 NRfA==
X-Gm-Message-State: AOJu0Yxx5PgmBMtSRG0Q6gwBPX1fDxY46tSBA/Kki/XZrbQ9X9S57JCE
 Eyxdn0A10OBM/ySsYXw+X83KI6t6fUyWFto5i1s=
X-Google-Smtp-Source: AGHT+IGkZmXraGC+Dqk5EDM2vOTL7rIZmIj2iksC9goOWR5dfHU27l8hEGkXXJizaXpag9YQzn2U8A==
X-Received: by 2002:a05:600c:4f55:b0:408:3707:b199 with SMTP id
 m21-20020a05600c4f5500b004083707b199mr21831254wmq.3.1699268832460; 
 Mon, 06 Nov 2023 03:07:12 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 jg2-20020a05600ca00200b004065daba6casm11958500wmb.46.2023.11.06.03.07.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:07:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PULL 31/60] target/mips: Fix TX79 LQ/SQ opcodes
Date: Mon,  6 Nov 2023 12:03:03 +0100
Message-ID: <20231106110336.358-32-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The base register address offset is *signed*.

Cc: qemu-stable@nongnu.org
Fixes: aaaa82a9f9 ("target/mips/tx79: Introduce LQ opcode (Load Quadword)")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230914090447.12557-1-philmd@linaro.org>
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


