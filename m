Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E31D70DEF5
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:16:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SVn-0003VJ-K0; Tue, 23 May 2023 09:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVi-0003O5-Dp
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:10 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVg-0004E8-JU
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:10 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d44b198baso2527851b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850227; x=1687442227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nI2w8QPEk+92crMZ+axm4/ERglLN4PhhZ5orQ1/925g=;
 b=n+oI1x49R+cr4UbKa9yA+wahQcPCTjr1AU9phksY2VT9JISvKojbmuS1t60OV99Am6
 yPxIzx+xcLzehh/WdtX3wJCb0CP+Op6+on0aKK3cJPCZ8d8QdURnQNMM8/2k8+vfRV4A
 PGg3Th+ezTYfEYkSj0QwN11C6mXeSWdWtR62j4g4B81yqc6QWfNr9bpM6wREQ0PrhCGD
 hBYWj97bjJH6zknsEApKg6vLI73EmK9jgoWY2+0b45xEq2Ny/jDDgIcsuGz4zgYNH+D0
 YU2UywxdLJp4oNr6hDBF379vghLScSzuUQHDPEJW79dQlqI4J/4jgt3HE+8A1NU6JEHo
 3wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850227; x=1687442227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nI2w8QPEk+92crMZ+axm4/ERglLN4PhhZ5orQ1/925g=;
 b=d1JEoi2Y7FV83dvm6suJJqLSA1Ryj9O7ItcImgEa7Duokv0Xrh2YP8GUl9VBYwfFro
 wVRqnedG5bE/xnb1SKpNGkwKF9KsPqticJsm9cSGM7NEB8wppI5Yku6mHvJwnK8NJBYF
 6wSVfFz5+aD2lBpv36txlWTB8/UYj/gaV9/6/InR5YI9us3YXDoDhN/y0OiyTKEGFYi5
 pde0OkPWwP4jhdvHylaavOHGfoRaMKHG9ICCd1I1dIXhwWLtKJPPEHGxZCv7m5faGlTG
 +6QoMYJrtNV34vUjhNxOSYsMjG9UKj5QnECjbvC+2jMLEzLo+HopObZ8czvY3rQx1Nn4
 ZxLg==
X-Gm-Message-State: AC+VfDyIcP0d8HR2uuDOQPI7JwMDbeEVqyH9tCekDagSDo2EJxd5EKck
 IwOr/nw03MPV+ji1UEI42z7o5KV2W2puNMNUHKQ=
X-Google-Smtp-Source: ACHHUZ4seqKdKG93f6idSOVuVFZdQh3tAS71RKcUorBD6gjXUG6nGtj1RItxKQhQnxQMVOgVOQNXAQ==
X-Received: by 2002:a05:6a00:13a7:b0:63d:6744:8cae with SMTP id
 t39-20020a056a0013a700b0063d67448caemr17906298pfg.2.1684850227229; 
 Tue, 23 May 2023 06:57:07 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a62a50b000000b0063799398eaesm5805790pfm.51.2023.05.23.06.57.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:57:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 52/52] tcg: Build once for system and once for user-only
Date: Tue, 23 May 2023 06:53:22 -0700
Message-Id: <20230523135322.678948-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Create two static libraries for use by each execution mode.

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


