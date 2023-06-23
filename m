Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 674B173B72E
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:27:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfnu-0004DF-0U; Fri, 23 Jun 2023 08:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmo-0003ka-Q9
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:12 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmi-0003g4-1n
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:08 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4f95bf5c493so643317e87.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687522862; x=1690114862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hazNgz+WePYWHkhh7hg5TUrtV6hneANQlKnUGSMVRh8=;
 b=JxY8Ckni1IdB7XbgrIy88BRa58Vs8563Fik3dG7t6C/UfBb0UdyUKrQNaaMeIboIU4
 FpOmqN84ZVLkUoRd/WC0lxt8kcwsKcwrHS5HkomLdtlCfzUPC/N0B9cheV/ZFNQEiAla
 /er2xFPQ0DXtsDfBN0+gN0ADZTAziKTLhdqyfdgHFMW/acUzOU3JjAq1NH/DPnhriNcu
 V5yse+9/PGXALqQ2s0M/+oJypCrRFKm50ZR6KdSGypSwxVwiCgYQJD7mf9PgrFq4bdfS
 KG7w9EU/e+9Oot+APY3aPRpVWTPhh3ySxD6HH4ZOl8/gYZV/6VH5Q3P7u4UykkE2GUxK
 X0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522862; x=1690114862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hazNgz+WePYWHkhh7hg5TUrtV6hneANQlKnUGSMVRh8=;
 b=I7cCc4VHSkNcac+ELFFPmtI8sjk5clbQaVqulmGp8IYWBEgZMBu+olrng6PiJsjoxX
 fXRrAWi9YAA/vbUWNaAPVAxkmfgdm8RKNLvu0iRK6al+fTRkdTMvs7sY6qPRozmMe7nZ
 W7oc+b5PpI40ykCqSR0XmuL4DTzuoFy6norGM3jeTucnwLDSITQ31k2aRSa//CQt+/AH
 atSRM0CEC7K41D1KXUEh+RPSylenED15KyOYJnGl+JuESGpXau5/E72FL7/ZaGzsUwmL
 bXjMv17rHSK+dCSUAr3pGFo7pUpeOc3PnuGu05OGiSr4R0FLGMGFBEnb/6E/O+yRAf9N
 +h4w==
X-Gm-Message-State: AC+VfDxyI6J0M/v9MZKZZh7HnHrpQTrr80a/7UK6WMfXBEhmdoheMWZX
 LatWCThRUKTd8LNMRPWDSdNy9g==
X-Google-Smtp-Source: ACHHUZ5ekkCOO/IajQC9TtB/InL9aFVaPMrK3gZnAcYlN4yRA5s3AafMlFuey9dZfZKjVNCluG+umA==
X-Received: by 2002:a19:8c01:0:b0:4f8:6d99:f4f3 with SMTP id
 o1-20020a198c01000000b004f86d99f4f3mr9499463lfd.52.1687522861765; 
 Fri, 23 Jun 2023 05:21:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a1ccc0b000000b003fa8158135esm17256wmb.11.2023.06.23.05.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:21:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C15FA1FFBD;
 Fri, 23 Jun 2023 13:21:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Riku Voipio <riku.voipio@iki.fi>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 02/26] gitlab: ensure coverage job also publishes meson log
Date: Fri, 23 Jun 2023 13:20:36 +0100
Message-Id: <20230623122100.1640995-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The coverage job wants to publish a coverage report on success, but the
tests might fail and in that case we need the meson logs for debugging.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230503145535.91325-3-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index fcaa3869df..528c0c62aa 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -462,9 +462,12 @@ gcov:
   coverage: /^\s*lines:\s*\d+.\d+\%/
   artifacts:
     name: ${CI_JOB_NAME}-${CI_COMMIT_REF_NAME}-${CI_COMMIT_SHA}
-    when: on_success
+    when: always
     expire_in: 2 days
+    paths:
+      - build/meson-logs/testlog.txt
     reports:
+      junit: build/meson-logs/testlog.junit.xml
       coverage_report:
         coverage_format: cobertura
         path: build/coverage.xml
-- 
2.39.2


