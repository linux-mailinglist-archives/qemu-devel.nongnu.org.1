Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEDA723141
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:26:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GgN-0007QH-Ps; Mon, 05 Jun 2023 16:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gg9-00071c-3k
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:49 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfv-0005nK-GH
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:47 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b04949e4e9so25177415ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996373; x=1688588373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cVUkf4/bpXGdLPrfKhU6xJtb3KDITtWli9I9WGefa/0=;
 b=N9mDjfNsXWSz4Boafb8M0ae/2t8lbhJzNqZtX6YI6nLAyEn1Bje9SCP0a3PPdrLIim
 DY6JfcQY4JB1dtXxRjLOJ2252SoXP6oy3b5uDG+SexHv14iHFOoDddTI0kYSnyzq1sOV
 qWOZ68NEEj2UqfTlSeIWi/dEi8tKOYax//bBSey3gqI+hpMS2OKNNOmYv4vaYTmRCK12
 3VdcBVwCSx/iu5X0s3w5ZLI/qIEulKpyrm6/SLk2REMUflAbbiQA6Qoa8f/WSFETYMRX
 S8z0M7qo1ii0fVtKGyqMnVHNO9pAxcSQw/u079EOpu+hG2yc3abLPiVFu9jYSsr20bQs
 4Vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996373; x=1688588373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cVUkf4/bpXGdLPrfKhU6xJtb3KDITtWli9I9WGefa/0=;
 b=W+BbEoYPeHDR0hunmcTlZlsaEzSNJ4NJWtaoIG1+rf23Cke0cUnDDR/lgtv2d6no35
 MMbcoXKfK7YmoIVSHO0JzwI2vM0psqWjTKXpujpyQi46fm5ddbcvsVHLZL1W/Q+8Gx36
 cQyBLkYCvAKdytxUAytfDNYNxmiohdmAuS2U3znrW33sFWh3e5n18opoC5R1Dtz4oZI0
 c2UroJfkYBG3gIuk/z6+s4Ga1hyL6Q5I+qb+0fvMMLdwhxTqXbLB8EjIpK3IdKEtwac7
 4eo2mYzwUfGTVumE/6qgiys1kDvDYqxTCMHNB4UsVeH5FYZe4w5lmrMPVbJo72EJ9g78
 3BuQ==
X-Gm-Message-State: AC+VfDys84I6Axrg+FDRMOso6TR4a0Fo/NoKIRwgADBWZrJcF+Yzf9ck
 jQlM+3tZ8r7KJzxrtKjKzwD5Bzl4U4KcS1NEQEY=
X-Google-Smtp-Source: ACHHUZ6ajgOnxQWvuyA/jRcm1ocURj6tjhTgksjP5si3htQUIUPdVWpsT+D3XsrROUG3c6Sm5rkswg==
X-Received: by 2002:a17:903:2602:b0:1af:b049:b32e with SMTP id
 jd2-20020a170903260200b001afb049b32emr3550862plb.56.1685996373090; 
 Mon, 05 Jun 2023 13:19:33 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a170902c79400b001a980a23802sm7018184pla.111.2023.06.05.13.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:19:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 50/52] tcg: Build once for system and once for user-only
Date: Mon,  5 Jun 2023 13:15:46 -0700
Message-Id: <20230605201548.1596865-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Create two static libraries for use by each execution mode.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/meson.build | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tcg/meson.build b/tcg/meson.build
index bdc185a485..565c60bc96 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -1,3 +1,7 @@
+if not get_option('tcg').allowed()
+   subdir_done()
+endif
+
 tcg_ss = ss.source_set()
 
 tcg_ss.add(files(
@@ -14,8 +18,28 @@ tcg_ss.add(files(
 if get_option('tcg_interpreter')
   libffi = dependency('libffi', version: '>=3.0', required: true,
                       method: 'pkg-config')
-  specific_ss.add(libffi)
-  specific_ss.add(files('tci.c'))
+  tcg_ss.add(libffi)
+  tcg_ss.add(files('tci.c'))
 endif
 
-specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
+tcg_ss = tcg_ss.apply(config_host, strict: false)
+
+libtcg_user = static_library('tcg_user',
+                             tcg_ss.sources() + genh,
+                             name_suffix: 'fa',
+                             c_args: '-DCONFIG_USER_ONLY',
+                             build_by_default: have_user)
+
+tcg_user = declare_dependency(link_with: libtcg_user,
+                              dependencies: tcg_ss.dependencies())
+user_ss.add(tcg_user)
+
+libtcg_softmmu = static_library('tcg_softmmu',
+                                tcg_ss.sources() + genh,
+                                name_suffix: 'fa',
+                                c_args: '-DCONFIG_SOFTMMU',
+                                build_by_default: have_system)
+
+tcg_softmmu = declare_dependency(link_with: libtcg_softmmu,
+                                 dependencies: tcg_ss.dependencies())
+softmmu_ss.add(tcg_softmmu)
-- 
2.34.1


