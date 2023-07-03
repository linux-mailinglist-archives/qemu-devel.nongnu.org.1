Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAE7745DA7
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:45:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJrO-0007xP-Ub; Mon, 03 Jul 2023 09:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJrA-0007a6-Lk
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:44 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr3-0005j7-Pc
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:42 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31434226a2eso2173446f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391876; x=1690983876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKf4Hmc0LoALYt5gF/daH2iR5ELuErLCAXXDVmfzwLI=;
 b=C8Yloh7HfS9kwwuB9RSijUKO3Qja1RNkQfSB3egVPGBct8nlLfWJ8nKpcMAHPU2KP1
 iSvU2+O0L8opaVxfXV0frCcq3jTTgiMNUk+bxL9e8UHjbEHDRq0j4EHmYxpyceaqacO+
 mHT/dPgODtslOiLaY/cNMeRbpHFn+M1UXEPq6xpvO+JEkla8jMytAv2/T1ZsVNS51hQx
 csy0b8/5FcePfwej0LVUZNWaY/qkTXyy27V86OZ0QJ1cjEPt/P1SarJ7kPPeRt13dHaM
 CZ9cXOABKFqHGBHEyFwP1MxEbLM2bslyGZg0fetZO7a3prklY3F/UA6AceN7oMdG0nd8
 asFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391876; x=1690983876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LKf4Hmc0LoALYt5gF/daH2iR5ELuErLCAXXDVmfzwLI=;
 b=SLgtu7fM9+/jZ0oA4moRWest4/MuSVHcQeKJ7Y3Aa5p2YizU6MpskOsEXNxYoa+Y5z
 C1uKOdzorX5dq1U8Zk/9lMCTgM3IdcazOd7fs4jp3gi6Aags5JaVnpn7AQnpPDFhK75e
 h9LGIWv7OKR15LGQZDU0rPdhOpFP1eqycF7VOgFzQCztmMNnyDWNRv0r5PL2cTFRBibF
 JbuOUPUTrFEWJY2Z2O9Q7+nnbsJmMx7Fq+WrfCLQfxsHwO+ffO1sZud0rQ8BXTAdhqSc
 ibZIahULIO4tGJDxHDje0LBHyQqwjVW6WN+sAOTytt/gv+qKIVyE0Q2I77KVbGMr+unm
 YZJg==
X-Gm-Message-State: ABy/qLYxM46SX+AeU9YDLZr/NFg6pSKc9zybHk+vt8grYZD0rO6tKcFw
 vtgTpgFzWZZMHs3+lMcRvi5aLA==
X-Google-Smtp-Source: APBJJlHTRRwBY+9VLdCJs+sbq7diSPRx2c7QHBJUGzVNd15tCyo9nJk+2sZFSZ2txAUGMJYcVcvC3g==
X-Received: by 2002:a5d:4f08:0:b0:313:dfa3:4f7b with SMTP id
 c8-20020a5d4f08000000b00313dfa34f7bmr12893609wru.20.1688391876524; 
 Mon, 03 Jul 2023 06:44:36 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v1-20020adfe281000000b00311299df211sm25652592wri.77.2023.07.03.06.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 541691FFCB;
 Mon,  3 Jul 2023 14:44:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 21/38] plugins: update lockstep to use g_memdup2
Date: Mon,  3 Jul 2023 14:44:10 +0100
Message-Id: <20230703134427.1389440-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

The old g_memdup is deprecated, use the replacement.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-22-alex.bennee@linaro.org>

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index e36f0b9562..3614c3564c 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -130,7 +130,7 @@ static void report_divergance(ExecState *us, ExecState *them)
         }
     }
     divergence_log = g_slist_prepend(divergence_log,
-                                     g_memdup(&divrec, sizeof(divrec)));
+                                     g_memdup2(&divrec, sizeof(divrec)));
 
     /* Output short log entry of going out of sync... */
     if (verbose || divrec.distance == 1 || diverged) {
-- 
2.39.2


