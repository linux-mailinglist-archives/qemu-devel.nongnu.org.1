Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE00173EBCC
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 22:26:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDsmG-0005qp-O7; Mon, 26 Jun 2023 16:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDsm4-0005c1-DU
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 16:25:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDsm0-00055L-HE
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 16:25:23 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fa9850bfebso12645155e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 13:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687811118; x=1690403118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PkkwaC5weGbOgI6TyHV8oGFM7+1AeUMfWTRfSlmxtvc=;
 b=mDaGz5jUFVjy4wOdgoQO36PtD35lqRYewem3qlYGLWlSMw4g92vVp3+pzFU9kXjrGe
 2/wxdpneS/M8wT3ZS7KYOVdlXhblzKzMDr0FndcYO7CkgKjso5fQIUcQtnE/LuHCdhE5
 WveJMKvEXqXyGzOGwRPCC8xkBnoWWQzWVIwRI3lycPzq6ie4lGUd4QufOZPkyvcfHPV3
 Z+bnZ/RZKI8Fe/Lh/nAx3a0NJK7fFdvp3yRhVcWLAwZSFTefLL5cEe2Nk1Jo07Kvj/Ti
 aFM/H5HCWqVA9szm3t2lzLRp8T1N2ogbN+i0UEfqfuC66PZOdT0s5rYrWfbytqbDKfOn
 ahCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687811118; x=1690403118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PkkwaC5weGbOgI6TyHV8oGFM7+1AeUMfWTRfSlmxtvc=;
 b=HUmCbIjtPzLPC9DEjYi3T+467btis2jR7YiWOQmEwEIylS2DZb1bo4VtrG8mCTrM/W
 TGAzJP4bB/Us+iDDOtZdnUBynbX00PDEh4CFTra0d8TaGIQl4C+azpn6gE0iGvpu4T97
 D4kEf4UWQgcjTgHV9fv+NsN4RPBskPb2egX4X8Cxd4yonef+4SNer6wZ5BtP4nSsQYVv
 jJJW0T6vhU7RW7rGFCDLMqoeeQeU3MoCbDrK88Q6S17UmlXFkODhPXn1giDBYq4moKwc
 I5wbi438n/MKh8xmv9TGUWeOYwTa7RGbmt3NccA5ep3bO8h/3GZQG7lvf8u+CzQFQf6k
 JV2A==
X-Gm-Message-State: AC+VfDwgItMVEAqnzXpCicMpYSQ1OGDnqU5GiFlep4prLKuxKowpBI4x
 3QpVGrXhny65Jy7InAdITFGEgg==
X-Google-Smtp-Source: ACHHUZ4QUZ7VWYymdsjfMJpXTA4tXou6NDi36JgTmd9wHZrdTyLUnXrmdQYJeU9JOtihf/DlzjW+Gw==
X-Received: by 2002:a7b:c409:0:b0:3fa:934c:8350 with SMTP id
 k9-20020a7bc409000000b003fa934c8350mr3236246wmi.27.1687811117937; 
 Mon, 26 Jun 2023 13:25:17 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a05600c238500b003f900678815sm8700257wma.39.2023.06.26.13.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 13:25:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 588C61FFBD;
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
Subject: [PATCH v2 2/6] gitlab: ensure coverage job also publishes meson log
Date: Mon, 26 Jun 2023 21:25:11 +0100
Message-Id: <20230626202516.2507915-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626202516.2507915-1-alex.bennee@linaro.org>
References: <20230626202516.2507915-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The coverage job wants to publish a coverage report on success, but the
tests might fail and in that case we need the meson logs for debugging.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230623122100.1640995-3-alex.bennee@linaro.org>
Message-Id: <20230503145535.91325-3-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 24bba061cd..a8fd9a0c1f 100644
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


