Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9262B7E3404
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:15:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRt-0005gt-9E; Mon, 06 Nov 2023 22:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRj-0005A9-BW
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:07 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRe-0001Qt-Aj
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:06 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6bd0e1b1890so3930463b3a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326481; x=1699931281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6nb5z1bOhjJXS74t913bHs6v1Hgkf4qLkO9s5h/keU=;
 b=FOZrriYi4FWzG9aE7/e/a5o+EBUQdqp8rnzASn93DbuZyxPE6YelnNLIceydzaIEHE
 UC+EwmCQtKTIp8kcT6YrjMKuLse89m7G8X4d/nj3Qevuqg5fGUUpF1xjYiqfPz4lsU4n
 bLsGggB3n2PTcTIiQYmqMhwQTdOH1KJZ9ndEUXsahyBjR35TPR4kFPjzCwjs4joNW0MS
 NzYcA9E4lCoJ8+Kh3aZu4byDJ4euoUWFDR6cG6Slm1BgUnSHX5mp+1kQxbuFu5dnaINc
 cvw1KD6jHnKhKZ13c4cOseLOO6CnsEBuZWlJyAICGNBV5/3J3pPUUjExyj1sHBpPwBhl
 Qipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326481; x=1699931281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w6nb5z1bOhjJXS74t913bHs6v1Hgkf4qLkO9s5h/keU=;
 b=k0tO44uJZyhbToE6S3qud4uPACtRNh2R64wErYiQEZSGRZL5LS7jaRLCdaGzE6mVqs
 Jb1dl1bH1mFI/H4U09YXLT/vr7YkyNW2UriJTRV/jY9+8WX20VuTAjAvazwDeucM8quP
 llpjJ+lLHnX1yqDez+9UVuQI3mnsOlzuf/dOngLX1gTMquhgIQfMAj6JxxNBhCNUaaV9
 zPitjtCR4VtIgo/DPWfPqql3TeUt3eb6C5BIBap3bvSx+Y/VGPag+49mexWUYbZoitxA
 Lc0hFfkFK0L3b8L+EdyCMkFTNplvbs3OzDaStA18U2zc01ZWUXRcNzC53hg/ZD+Jo8Yb
 cCqg==
X-Gm-Message-State: AOJu0Yz7IdUA8/lSoG+Eua0gR5WCL5R+gZH7mczUxhzDYncVw77/Um25
 ja031wXnBFx8cme37ssO7ElOm1XHba0ff6532dY=
X-Google-Smtp-Source: AGHT+IFdYwk3UaKVcViGrSiAmFmJwr9MM7qxi4Vk7iR+dxAn5pRAaLzpcBVyHaTDxpB741IMLyUYhw==
X-Received: by 2002:a05:6a20:ae17:b0:15e:986:d92b with SMTP id
 dp23-20020a056a20ae1700b0015e0986d92bmr18605217pzb.16.1699326480850; 
 Mon, 06 Nov 2023 19:08:00 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:08:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 70/85] target/hppa: Return zero for r0 from load_gpr
Date: Mon,  6 Nov 2023 19:03:52 -0800
Message-Id: <20231107030407.8979-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b04a5bc444..ba15cf6ab8 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -307,9 +307,7 @@ static void cond_free(DisasCond *cond)
 static TCGv_i64 load_gpr(DisasContext *ctx, unsigned reg)
 {
     if (reg == 0) {
-        TCGv_i64 t = tcg_temp_new_i64();
-        tcg_gen_movi_i64(t, 0);
-        return t;
+        return ctx->zero;
     } else {
         return cpu_gr[reg];
     }
-- 
2.34.1


