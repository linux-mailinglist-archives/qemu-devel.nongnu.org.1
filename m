Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B547CEAEF
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:04:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESj-0001mx-0n; Wed, 18 Oct 2023 17:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESZ-0001UI-3Q
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:11 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESX-0004Tu-GQ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:10 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6cd0964a994so634817a34.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665928; x=1698270728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zRIf7kxBmxh1/shdoAtqyWNqtUTU3VEXUB+/Zv/YIyE=;
 b=XZ92CgZclert3cgqBL5tB79Da/Y3lv+XTYEDjjtgyiyar+wh8g65AQzWxHljssM4Jf
 9RnKi78/EdAf3OYLYAXhVE8xCPd6e7qEZ8LkFz1AABhqVpbZjPlDph4NNZcghGYHysjX
 MGKyZVrGPxAc+LqT70HzbGve8DfyUYUcH15qIpSXOnx9DsZsoj7gysnm9wRHR8mr6iE/
 ruB5NOo8s5cgWOVLSz1SP8BIh1FGQILTM3mHr/inoIpw/Jm2EkPYlIbC1rzh5KPCaVjX
 kuQv/j2Z+yhD1ljGexxb3umNj7P2pzUdPKvRyfgGWQR57AL2zCbqzXQE6HplGSoVaGX0
 v7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665928; x=1698270728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zRIf7kxBmxh1/shdoAtqyWNqtUTU3VEXUB+/Zv/YIyE=;
 b=pXr9c6pgBemWOjQBSgl6wjdLmalP2v0a/5NsZly+1yuyvpGyoq+wOP1mK3sJkq7jiw
 awCFUUYdjIm5cr+bGc9gZWLwuGeYlqSON3ypNLMsY9hoaG/uigXn6s2yKOro+WQoBzxC
 oymjYxg2VkOc/l+5mgTlpFpaLXQOjRXG8UkYAqnYJbf2qjZq/6USruDbkY+aFWLe0/PJ
 9PSCiQh6EYtM6jHF0Z1S5Rx/9L1z/wWX4x+aNtw2QPBybi4eKW0Qy6vxGmkhOQ43t4qm
 srmE/S6vl5gUU1FtEsFdKSqqDodrcjhgtfWi1Z5oF/7W7oky1YBc1kKH1TMp6eCmijYz
 IjMA==
X-Gm-Message-State: AOJu0Yx45Y8Eg9QKGYgPeztxZJkOOCGg5hdn6kMWlIb5jzIVpArHuOb0
 19gSj1aUmYODs3tCeq088eAH7XZ2cDvpWrDNSWQ=
X-Google-Smtp-Source: AGHT+IF93ADW7xCKdqHsi13QNHFREG8ip7ZzEum6jRW6dTN+wLMmvdCn4GjfONQHQTMPJI8hO0IDEA==
X-Received: by 2002:a05:6830:209:b0:6c6:50d0:1104 with SMTP id
 em9-20020a056830020900b006c650d01104mr527805otb.27.1697665928091; 
 Wed, 18 Oct 2023 14:52:08 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:52:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 38/61] target/hppa: Decode ADDB double-word
Date: Wed, 18 Oct 2023 14:51:12 -0700
Message-Id: <20231018215135.1561375-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 753748082b..7e723dcd24 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3122,6 +3122,17 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
     DisasCond cond;
     bool d = false;
 
+    /*
+     * For hppa64, the ADDB conditions change, dropping ZNV, SV, OD
+     * in favor of double-word EQ, LT, LE.
+     */
+    if (ctx->is_pa20) {
+        d = c >= 5;
+        if (d) {
+            c &= 3;
+        }
+    }
+
     in2 = load_gpr(ctx, r);
     dest = tcg_temp_new();
     sv = NULL;
-- 
2.34.1


