Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C797CEA77
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVe-0002AK-HG; Wed, 18 Oct 2023 17:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVY-0001jF-IG
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:16 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVV-00050F-NE
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:16 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so4163920b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666112; x=1698270912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHgm4YY+daCPYhOY55WgMv7HyI7x+VabMfn6WJVOWQA=;
 b=BQbLR0lO9c2m3Hboom8DuU7ZGZjj5EbLuduDwVMhQEct9MKL7hhRlBoV6OjtH1lH88
 ljHQlhroOh0zIZnXPh8G8nynb6lwSSe6LZIN1Co7fsEXmWKFYQo2gYT8EdKOCZFJkxS5
 oIfngqKauUQdvwoDUwV+1RdvOyjQkk5AHP0tsOG8zetHK3iLBbgRjcEJvjca/+UHV/bH
 oky34RNDev3rmQUVVngB8JTs7y/zVUonjAIRA9YrkBjXXfZJNcFaTksRdLVHrdpuWC9D
 ZjPpFXp6Aq0gkkVZ9hv0yK8So7sHkbhRLzruAQ9YlAYORaDMSClhP/kRRx8IGM/IXumd
 bkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666112; x=1698270912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHgm4YY+daCPYhOY55WgMv7HyI7x+VabMfn6WJVOWQA=;
 b=umqB/mcMqJynaMbRwuQJ8S2+YE1oQ5aEt4AQXRkpgKw8u3TsW/2Cco1LuejOCMIXil
 bizyffH5tlomOm2vQiFkCpxUBD853frDaJqKdwE7lHgV3Pv5pxx8Rah9S6sVy5i7noXc
 x8H1c4g7W6rAOkKl39rI/JIqVi0I4Psd7frDInFzw3JG02rhTHRPyp3M1VSA6D9d2jxd
 oiPHdPf/zFmCeCAGwsYJS3vR3clytu6W/s/zo+0Kwd8YpywlLTG7bBkEhKlkyO7rRM3V
 oPFgDSBYtytOXiE3LRit28Xl/vSs3TX9cOdB4wc1fHeYkQIoV/iw51ZLB2Q/NsG6nRwl
 dwoA==
X-Gm-Message-State: AOJu0YwM0Tm9l8tIXCFNyfTPGBgpLxfLvUxaal9gK3bdBNQbjgpe3s4q
 yM7tu3Q+o8yuPnJ12WdDm8gsLMPTws8euWNvGfI=
X-Google-Smtp-Source: AGHT+IGkOQ4IuT0qlvNubkbAepjrKgzzvhLNdm8ZE5wyN7mlah2FmXOjIPcQ5gFuUIzaXyKetOur+g==
X-Received: by 2002:a05:6a00:2daa:b0:68c:4e22:8f78 with SMTP id
 fb42-20020a056a002daa00b0068c4e228f78mr312713pfb.25.1697666112191; 
 Wed, 18 Oct 2023 14:55:12 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 43/61] target/hppa: Implement CLRBTS, POPBTS, PUSHBTS, PUSHNOM
Date: Wed, 18 Oct 2023 14:51:17 -0700
Message-Id: <20231018215135.1561375-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 target/hppa/insns.decode | 2 ++
 target/hppa/translate.c  | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 6f0c3f6ea5..ba7731b517 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -381,6 +381,8 @@ bl              111010 ..... ..... 101 ........... n:1 .        &BL l=2 \
                 disp=%assemble_22
 b_gate          111010 ..... ..... 001 ........... .   .        @bl
 blr             111010 l:5   x:5   010 00000000000 n:1 0
+nopbts          111010 00000 00000 010 0---------1   0 1    # clrbts/popbts
+nopbts          111010 00000 ----- 010 00000000000   0 1    # pushbts/pushnom
 bv              111010 b:5   x:5   110 00000000000 n:1 0
 bve             111010 b:5   00000 110 10000000000 n:1 -        l=0
 bve             111010 b:5   00000 111 10000000000 n:1 -        l=2
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a23c44e3d6..56c0a4fea1 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3746,6 +3746,12 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
 #endif
 }
 
+static bool trans_nopbts(DisasContext *ctx, arg_nopbts *a)
+{
+    /* All branch target stack instructions implement as nop. */
+    return ctx->is_pa20;
+}
+
 /*
  * Float class 0
  */
-- 
2.34.1


