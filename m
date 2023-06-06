Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABC2725018
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 00:46:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6fRX-0005Eq-HN; Tue, 06 Jun 2023 18:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6fRV-0005DP-FY
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 18:46:21 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6fRR-0001GC-0w
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 18:46:21 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso6057154a12.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 15:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686091573; x=1688683573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkTYcH4LNlY/B3s1+2jz5JvJQylcIE4mksKLEpxuLsc=;
 b=PndiyLv+BMaZ34O7m0V3FKkn4UxjU+qWLG9c3F2GaCbvOSj5soChsPABNRbQjGvi6j
 vwLbZaVQaAnLQ5ZXX4uFGsO5/I7SGA3dr+wBwYrsoMDOu4rf9mnSkhCTBFMNd9YXilFt
 FgbyxF+mjVXJeXnCxIM6+b+4+uOIc0HYZ8NGid8q89x9uAfcYzdYEbYzOt0iUWnsbPZy
 CuWDa6gNwzQOoCnN8ImwdsDFi1ae3BS0YCgcGnKflXlKWr69q8BCMaVzaZti2Bsb4DIK
 yOkpx4hCs7FwMiTbUEj3IYv/Sy0Agb9LVUTaTWCZHtZTadYcP4Gwm+jShuOQcmXdJ/kl
 AHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686091573; x=1688683573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DkTYcH4LNlY/B3s1+2jz5JvJQylcIE4mksKLEpxuLsc=;
 b=PP3P+AtsxHG0LGkKl/I4CQsPra+RkGkC9sjekQiBGsd6tcq2fow0EV5sfNPPN7+aaB
 qsdgvXgUoOAzooRH01VJadGZvlguRMVhV86WyoupN7NRB42w4yfNssXXS2XBlxkG2SwJ
 IVMYkkQEtXpzFwgPnGc5v/OXjpPIexcwoD9KJe07Y1KzmWGtXwdKZzwCYmjYPiF7D+vc
 X5p33kjqpLAdFE8RAbRsGJ6dsk70eSReRnyZHQgtWa4Iqp1NrjKxTIIW3i9YqaobrdhL
 mg4+e6T7l9wQfTO1vMvK0Nj3Eo/e8V0NZ7jFbw/HGHYWNN9jyfuvjOmr10SOGw6nwM/K
 48lA==
X-Gm-Message-State: AC+VfDzc15drIx/1uwxyCsl/OXIiAb03dm51hNT9TiG/GukaUWA+0SjY
 kMlIwaF/DT0YPEg+ppkm6co75wnKvH6iZm0q7OI=
X-Google-Smtp-Source: ACHHUZ4EKEHvWf07z0wKDpHEhVU3e3QWZOgDsV1LeHDDf9kRtGmnSI+O/Vo8TQDto7VTETyOvfHFng==
X-Received: by 2002:a05:6a20:734f:b0:10e:440:6d36 with SMTP id
 v15-20020a056a20734f00b0010e04406d36mr1314939pzc.1.1686091572870; 
 Tue, 06 Jun 2023 15:46:12 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 t8-20020aa79388000000b0065cfd5cbef3sm3346969pfe.15.2023.06.06.15.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 15:46:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	alex.bennee@linaro.org,
	thuth@redhat.com
Subject: [PATCH 2/2] gitlab: Add cross-arm64-kvm-only
Date: Tue,  6 Jun 2023 15:46:09 -0700
Message-Id: <20230606224609.208550-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606224609.208550-1-richard.henderson@linaro.org>
References: <20230606224609.208550-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We are not currently running a --disable-tcg test for arm64,
like we are for mips, ppc and s390x.  We have a job for the
native aarch64 runner, but it is not run by default and it
is not helpful for normal developer testing without access
to qemu's private runner.

Use --without-default-features to eliminate most tests.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/crossbuilds.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 61b8ac86ee..1e0e6c7f2c 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -29,6 +29,14 @@ cross-arm64-user:
   variables:
     IMAGE: debian-arm64-cross
 
+cross-arm64-kvm-only:
+  extends: .cross_accel_build_job
+  needs:
+    job: arm64-debian-cross-container
+  variables:
+    IMAGE: debian-arm64-cross
+    EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
+
 cross-i386-user:
   extends:
     - .cross_user_build_job
-- 
2.34.1


