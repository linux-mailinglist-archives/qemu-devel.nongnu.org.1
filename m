Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C697DACE5
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:57:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx7DH-00036y-8J; Sun, 29 Oct 2023 10:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx7DC-00035L-1q
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:56:23 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx7D9-0006GW-9s
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:56:21 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50910346557so1376177e87.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591376; x=1699196176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHsqkB0IASk68fTXpXP2OAO5XJadiYMzafZ5IwzftpE=;
 b=JieZsGbGevS6gKt0ikfIn6TTNzH9l+czU94/RJOEE4xmkqXMTgXViK0bh0sjWKJqg0
 98In06fiUfE4ZOapyVC7QppBdEWONSDuRve2QV61dkB/N7b7v5X7HeyJzRsxLMkTa+p/
 DRxrdMQhbKRlVuCYHYeQpYXMnILPbkY6537QvKbdQLXRcC1nTRb0eIcgvoSdw4dybQ3D
 Sbyv2C52iQh/YGOJgDG/9dqJgwHNoCUjKo8F5JfuY+21sRqqqFhzKC8zXJ50CIKehGDl
 bYjIVPfWMOxrtwRt9dx29IUSt2xVYnW0w5yQ/EvhG7NmrVjLWMaX/15+B4BTCZq/UnmD
 /IKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591376; x=1699196176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gHsqkB0IASk68fTXpXP2OAO5XJadiYMzafZ5IwzftpE=;
 b=nR9sUK++STLTEdnZj4fnnrd/JC25PpDe3efx7RxkmEk6D8KhgmV1WLkB84R0md2mUd
 KYFx1mPeweGeluUOGTT9qthtVmmGlTMgqeT+tzHvKgW9YaWJ7n6fbYg3SvA/sG5sbSgb
 pOMvJTj7L6uJQ6qgyp2sytRSYRBluQwE0wDu1YZZ81OkmShHgEpTh75cTi+wdCowFsuo
 663/GE1aqZ//0U8lNo+WzJwQldc/nays3FEHDLU+dY4XG6sAEsoxnbvArZfT30i1nV89
 zVH3uT/vVLjprSn77jrV3Zj6i2gYpTjYl0Ox7OHP0dyzeybc/HBpFSrRxrso31nciXBA
 4pfg==
X-Gm-Message-State: AOJu0YzPKGfYr/cf4I8EycWl2J1vKHy6UFLBCWa0AEnd0IagDyagSz6L
 /xYW2mrDtYuoLGfF1VuyAMA1/w==
X-Google-Smtp-Source: AGHT+IGO2VZsprgaC871t+Q+aNvNkO0buR9RWn/ao7FwMO/UR2x2eyeujob15Cz4MpzxlOeV3jSseA==
X-Received: by 2002:a05:6512:234f:b0:509:b3f:8a7c with SMTP id
 p15-20020a056512234f00b005090b3f8a7cmr3572562lfu.7.1698591376453; 
 Sun, 29 Oct 2023 07:56:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o8-20020a056000010800b0032d8354fb43sm2271548wrx.76.2023.10.29.07.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:56:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C59406570A;
 Sun, 29 Oct 2023 14:50:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kyle Evans <kevans@freebsd.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Brian Cain <bcain@quicinc.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 18/19] plugins: Remove an extra parameter
Date: Sun, 29 Oct 2023 14:50:32 +0000
Message-Id: <20231029145033.592566-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

copy_call() has an unused parameter so remove it.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20231019101030.128431-7-akihiko.odaki@daynix.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231028103311.347104-17-alex.bennee@linaro.org>
---
 accel/tcg/plugin-gen.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 39b3c9351f..78b331b251 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -327,8 +327,7 @@ static TCGOp *copy_st_ptr(TCGOp **begin_op, TCGOp *op)
     return op;
 }
 
-static TCGOp *copy_call(TCGOp **begin_op, TCGOp *op, void *empty_func,
-                        void *func, int *cb_idx)
+static TCGOp *copy_call(TCGOp **begin_op, TCGOp *op, void *func, int *cb_idx)
 {
     TCGOp *old_op;
     int func_idx;
@@ -372,8 +371,7 @@ static TCGOp *append_udata_cb(const struct qemu_plugin_dyn_cb *cb,
     }
 
     /* call */
-    op = copy_call(&begin_op, op, HELPER(plugin_vcpu_udata_cb),
-                   cb->f.vcpu_udata, cb_idx);
+    op = copy_call(&begin_op, op, cb->f.vcpu_udata, cb_idx);
 
     return op;
 }
@@ -420,8 +418,7 @@ static TCGOp *append_mem_cb(const struct qemu_plugin_dyn_cb *cb,
 
     if (type == PLUGIN_GEN_CB_MEM) {
         /* call */
-        op = copy_call(&begin_op, op, HELPER(plugin_vcpu_mem_cb),
-                       cb->f.vcpu_udata, cb_idx);
+        op = copy_call(&begin_op, op, cb->f.vcpu_udata, cb_idx);
     }
 
     return op;
-- 
2.39.2


