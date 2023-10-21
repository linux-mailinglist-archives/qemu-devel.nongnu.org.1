Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDFA7D1AE3
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:33:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4ao-00076r-G3; Sat, 21 Oct 2023 01:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4am-00076K-28
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:08 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4aj-0008LT-I3
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:07 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5840bb16101so921390eaf.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866324; x=1698471124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jct63rFb48sV+5hvOO6V2h6GbxQHLHhpSIfreHhtJXo=;
 b=BL0Lq/nwJYggoLzWsUm25qPAH5DNXdKYhpdPPjG9Xm1I3IBRq2cNYOQKUN6w8HDsey
 zt29qB6m8G8PQvGxp2q79HwWotHS+QKAdu+cc5d73b3DknakcjaHJqtTddWByb99TV3T
 XIjIAds+HmORMkwrZuqiKYO5HUXJvaoRMzHdq1ZspYEXje0uslphvt/0HlUG+T09Rba4
 aqjWsAaCYO6g3+4PVAMDnrxyeHaVmAdQZNUHiPLMqU88r/AnhkxBmBGnuCviUTTs9Chn
 DEjOeJikOR4LHx+HPSkYRvcl/U7RlvfiE8g74AGhBtAbcN9LeHPD2Lw3PjB+yjd1X6jA
 wK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866324; x=1698471124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jct63rFb48sV+5hvOO6V2h6GbxQHLHhpSIfreHhtJXo=;
 b=jMpeMuT7QUBppBysD8IvuS7rw9RWkclECGMEiUXAiCsAhuUi6JkIDCjqQn+mrjtOer
 wKywc4qL0BInwdMjjFIFhK4rYHTf3gbsMcsdYU0iIi4xjhQLJryufiTb/8xS2XXhlRxQ
 5+wT6KS9gCIeTUoYqwZDVnPe12GSLTBTiI6gG3lm+OX22DUfZCuDukTjdght+zATC1Qk
 5W2t9KvvAbOV4ffhtOlm6OePyL+7pBCV/JC0MO20mJ3nTYIdx/Sp5OfL4SbHyNtBSYYS
 0cR7NyQLtZE2DN3T3AJnuA8U3Ob1wzsTdS+taOP+CLUjYXTYOt1S/DDMeIh0VQjgMvs6
 sa+Q==
X-Gm-Message-State: AOJu0YzS8sexn1WEylNW/z3DSBULolS/F568Qi7qjmPmyPFsRuc2y3tG
 GVXM5jYnViFfZnmMiEb97xdPm8tkEVsroWF75oI=
X-Google-Smtp-Source: AGHT+IG6b6gyEWh6ipP1yQ5U6RlxjE+Aq/RUkxP/3V72yTpH1uarKM8/D1egIT+7R3tlG74kKrGj/A==
X-Received: by 2002:a05:6870:10c5:b0:1eb:e8b:73cb with SMTP id
 5-20020a05687010c500b001eb0e8b73cbmr2050935oar.58.1697866324231; 
 Fri, 20 Oct 2023 22:32:04 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 05/90] configs: Enable MTTCG for sparc, sparc64
Date: Fri, 20 Oct 2023 22:30:33 -0700
Message-Id: <20231021053158.278135-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

This will be of small comfort to sparc64, because both
sun4u and sun4v board models force max_cpus = 1.
But it does enable actual smp for sparc32 sun4m.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/sparc-softmmu.mak   | 1 +
 configs/targets/sparc64-softmmu.mak | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index 454eb35499..a5d9200382 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
+TARGET_SUPPORTS_MTTCG=y
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index d3f8a3b710..36ca64ec41 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
+TARGET_SUPPORTS_MTTCG=y
-- 
2.34.1


