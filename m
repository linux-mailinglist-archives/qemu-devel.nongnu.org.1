Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF237745DEA
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:54:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJzm-0000Zf-2r; Mon, 03 Jul 2023 09:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzh-0000WS-Un
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzg-00082P-8g
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc77e76abso40419475e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688392410; x=1690984410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BaNMUangs5gWtxxq2cv83Ymb8o2XEiPMP7DPTxDoR+U=;
 b=k8cnn9utKjqhc/wB4hnl10+Vki/oGFcndUUuw+pIP9f/5PWw0lP4PsnNMgXLtH1O7W
 dTSwmCkvvG031Tsjw4akbpvKBa7EW8vsWknwLiozhYm5dN+oNiIqKZdCA9/x8WHCo4qY
 vWmKl2k3rrjmiL4GjBJCJT4vuwaB3N5feZlj3YxpDEw8OXqzwBZMMLc+1Ai8Rt/AQeZq
 cHze8c3tizT4kAN5PaAcj4m1ZtA8IMve1KnQaC7fNGamyfYsOlpUUi4/1MI0jT5V/t8z
 UXL7gMCGcaT04CJOKFXG8ti2ckYyrRIEanZKAybHs8bUcSqTKoex3o39bYOJsCzhPGb0
 yFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392410; x=1690984410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BaNMUangs5gWtxxq2cv83Ymb8o2XEiPMP7DPTxDoR+U=;
 b=gR3JULA8Xwk5/IpvYBIjwZ6Jz0TpVUEFnL3PHPBqbPHxBCipI9tlxRuQrHMH5dFV5h
 Y65MxEaiUkbtkZcURQmWvCSAimWSZDMzB6mWHyvOKFKZdgtjU0gZkFgawS9r7tXWELK4
 fMcYsEchQKNefeTyn47D+Cf1T4aGkLCG9uoUNC9vWfzUfeHsQZQRadAnwoyqAdUYzKqI
 VaX0f5QLgqJ889Nl2iqlAPrUBYggxcYdh6iye4DucqHyWxFNpHc2owVJWv0NcJWoG71u
 kNWskVbyT9CfwPiSVW+UynTRdzKZYTpwVA0Sv9L0WNxreHtcMUckT4HklH3ge/dluSRr
 jt7Q==
X-Gm-Message-State: ABy/qLb3zCYJTWS9o0pkWUrpD8fBS+/3o1nIka6+RYO8PhIst7VRYBgv
 zJQdgMstEMzNt6GvKMAAQ6vIOQ==
X-Google-Smtp-Source: APBJJlFxuL+HfYd5sI70sHeztTfo6np0kCG61rGkK4CBM4sHwh+FspeZ6y0vPxgHtWpjGqSOzH+2Cg==
X-Received: by 2002:a5d:6305:0:b0:314:1e86:e75d with SMTP id
 i5-20020a5d6305000000b003141e86e75dmr8223727wru.34.1688392410722; 
 Mon, 03 Jul 2023 06:53:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 da16-20020a056000197000b0031274a184d5sm25819195wrb.109.2023.07.03.06.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:53:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D11691FFBE;
 Mon,  3 Jul 2023 14:44:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 18/38] target/arm: make arm_casq_ptw CONFIG_TCG only
Date: Mon,  3 Jul 2023 14:44:07 +0100
Message-Id: <20230703134427.1389440-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

The ptw code is accessed by non-TCG code (specifically arm_pamax and
arm_cpu_get_phys_page_attrs_debug) but most of it is really only for
TCG emulation. Seeing as we already assert for a non TARGET_AARCH64
build lets extend the test rather than further messing with the ifdef
ladder.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-19-alex.bennee@linaro.org>

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6015121b99..42355caa9b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -628,7 +628,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
                              uint64_t new_val, S1Translate *ptw,
                              ARMMMUFaultInfo *fi)
 {
-#ifdef TARGET_AARCH64
+#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
     uint64_t cur_val;
     void *host = ptw->out_host;
 
@@ -709,7 +709,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
 
     return cur_val;
 #else
-    /* AArch32 does not have FEAT_HADFS. */
+    /* AArch32 does not have FEAT_HADFS; non-TCG guests only use debug-mode. */
     g_assert_not_reached();
 #endif
 }
-- 
2.39.2


