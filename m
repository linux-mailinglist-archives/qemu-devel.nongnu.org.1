Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2F273EBCB
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 22:26:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDsmH-0005t3-Lw; Mon, 26 Jun 2023 16:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDsm5-0005d9-Bv
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 16:25:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDsm2-00055U-Fd
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 16:25:25 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f9b4bf99c2so48109095e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 13:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687811118; x=1690403118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTHkiiEsGJjQzyOMxbcLNdH7rkjQKhZ4rW+u2UfYIYE=;
 b=MKK8zG4Q7FCjDHFPB1PNyce92Z+i1ui3ci07HtDI7m+wTT0RlHMLS6r0aDFkF72QE5
 H+pQ0lSDHUdeLayVAKcbKnxYElXJch5SO/dP5Yt9iJxhQbF6mVXofxD9wWa2HK1g5P6t
 g1DhYP/Mkl/0fNGbkQVgrLNuIMcJMFDAHUq5nPLlwKTKAvtYd7JWeTallz43Q8dT9Xq/
 G88/YFGOX27hNy9ne85XSU1wzaXWVuBBAkNDvJ16205HzFv013U+52C1grVZHkl7/K52
 kEoCG658XXoklxhW47HLz15LX0jylwmO6miqQVHRI44+oS25HaPzIqoUipbzvtf7aruS
 T4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687811118; x=1690403118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTHkiiEsGJjQzyOMxbcLNdH7rkjQKhZ4rW+u2UfYIYE=;
 b=l3FCBXoJ2bX8KFyAQrnYr1c9wlBGD0r5Ddcx1jR7BZj5ZrLRqz+gm7qVPK5tvmOYnS
 bnogwRFVQxLlNF1Lym+pr7SQLYXGBg4J64uyt9QN/Wo0mrFQ++RXGV6EpC2NpocHui4J
 mUhTEYbnay9NDBAFQWUEcG6FpDRzIBRsBfA/aBeJrUtZZxjtrF7A+AQ/+fhBZjtKNvRD
 Nvtxll2Ly86R54Kq/KXXr46ZmsR6P0edqpw9A9j2iyt504z3ftbt+cOSfyJp0bql0LBP
 zJ73frTGpFcCIBI0MeLIyU+f/rHuFWdasPtY4Qf9y2hT34h95W0Cy/a6OZelnyYCFixJ
 62OQ==
X-Gm-Message-State: AC+VfDzvjrB3wg1/ovLAZjjMNzPt6tsag9Gk82ITMGSS6F0k7mPqBEd2
 RsgLCzQXPt1fQDGyQUDXqg9JZA==
X-Google-Smtp-Source: ACHHUZ7rByVNZ9USQd0sazcRQfCdEfHL5SViOE4UgA+1WQvibiSdRfBlzBhZaDGF9Fa1SRSoRXe7sQ==
X-Received: by 2002:a1c:7507:0:b0:3f7:678c:74b0 with SMTP id
 o7-20020a1c7507000000b003f7678c74b0mr22472542wmc.12.1687811118336; 
 Mon, 26 Jun 2023 13:25:18 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a05600c204900b003f93c450657sm8626035wmg.38.2023.06.26.13.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 13:25:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 71B171FFBE;
 Mon, 26 Jun 2023 21:25:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Qiuhao Li <Qiuhao.Li@outlook.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Xu <peterx@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Cleber Rosa <crosa@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 3/6] gitlab: reduce testing scope of check-gcov
Date: Mon, 26 Jun 2023 21:25:12 +0100
Message-Id: <20230626202516.2507915-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626202516.2507915-1-alex.bennee@linaro.org>
References: <20230626202516.2507915-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

This keeps timing out on gitlab due to some qtests taking a long time.
As this is just ensuring the gcov machinery is working and not
attempting to be comprehensive lets skip qtest in this run.

Message-Id: <20230623122100.1640995-4-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index a8fd9a0c1f..77dc83a6be 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -454,7 +454,7 @@ gcov:
     IMAGE: ubuntu2204
     CONFIGURE_ARGS: --enable-gcov
     TARGETS: aarch64-softmmu ppc64-softmmu s390x-softmmu x86_64-softmmu
-    MAKE_CHECK_ARGS: check
+    MAKE_CHECK_ARGS: check-unit check-softfloat
   after_script:
     - cd build
     - gcovr --xml-pretty --exclude-unreachable-branches --print-summary
-- 
2.39.2


