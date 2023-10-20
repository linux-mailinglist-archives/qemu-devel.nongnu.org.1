Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B417D179A
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:54:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwM2-0007yG-Q4; Fri, 20 Oct 2023 16:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLr-0007p4-BF
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:11 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLo-0008H1-Kw
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:10 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso996768b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834647; x=1698439447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=294vPIKF0FsD09j8ptlM9k8sVT1xnHuXBETXznmUOGw=;
 b=q7sQ+Qe0tyDPQ7OiLpaybxiuCXWsbU+etjPJzE13fjmMOIOa7VK9puvRvPynErA1Tp
 GymwD0RxXfwc0E3148xSE34Igh8RpPahkvrDV1exemQt2jZbayOrBQwhT/ydnnKcEva7
 8RUBGC7lXJnfR/iMTM/Qg7OjpkN9fdfzR823+BiweLEavbHZJWSKlES62B9cEgKQPuFs
 3Vm8N07yL752GVK0W8mKy4J//gCf3PweQwaByGYkMbaBr9RjrJ2R3rLCcHpl+hyQm+48
 crCCbaS5NBno6jiFWbA4CDd5sMOz8WIdO+yvLvk47yIZjDSH+4MShimU7jxbieS22M7p
 TUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834647; x=1698439447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=294vPIKF0FsD09j8ptlM9k8sVT1xnHuXBETXznmUOGw=;
 b=w4WZGhprq1F8KiaqlMAsjQ4hhIHsSKJ3NYWnqhSJipVDzE7aamhIJmHgGoP/Go7MIR
 5YFDKwEjgypkMjVBb9x3uSiKp5fQFzqvbIoST5haITA6DMnyX1rWkRPxUWi2+an/o3aI
 KEzRwQPjdIDKuk7f36pT58FTshiqsmnmpQAa7s+YWx9HNtc8McgF8KCCjdp9Q9kw9Ysn
 xrgAgEFMIa08zbstdF/zVsokwBLeL0QDWmZp2vrtEjvGMCq29iqKaFGf23YyShMV+9JP
 fpv2xArmduwjPBvdfBmUQ30e21JwCYqG4FXNxABT2wbiIQDhgfVxXXmvX3qUDQXoJPHb
 yvbQ==
X-Gm-Message-State: AOJu0YylE9WKt0RKxUa3iG1e3bxXjnKgum+Tr5TtBrNJ+Mo3PaYku7sk
 xGGv5bffhVfHnju+4POeF7k8gK3BFamGbN8hdu8=
X-Google-Smtp-Source: AGHT+IG+VSPYC3u74zY6+P4uO+3p+CcAvCdOnVqO67SSlikH8WCOicqhAmvas1MefGGbs2qf06+DEA==
X-Received: by 2002:a05:6a20:394a:b0:17b:a34d:5b56 with SMTP id
 r10-20020a056a20394a00b0017ba34d5b56mr3777882pzg.19.1697834646996; 
 Fri, 20 Oct 2023 13:44:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:44:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 38/65] target/hppa: Decode ADDB double-word
Date: Fri, 20 Oct 2023 13:43:04 -0700
Message-Id: <20231020204331.139847-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
index bb55718a4d..21f2819d12 100644
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


