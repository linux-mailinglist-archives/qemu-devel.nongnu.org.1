Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33718740066
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:09:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBDn-0000ET-HM; Tue, 27 Jun 2023 12:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDe-000092-VL
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:07 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDb-00055x-GH
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:06 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f90b8ace97so64168375e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882022; x=1690474022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PkkwaC5weGbOgI6TyHV8oGFM7+1AeUMfWTRfSlmxtvc=;
 b=e5d3YYQj7/zoKz5nduBkPvRVT48ov8rDmTZNfhWDFYZ3QWAonn1VFnFbkRYr9ccL3g
 NVQU3mYHZgnFWIHfxEl9ynLLKQx/PmU7onsgYhRitN4ZTZ+SnIaY2550DMXen87CN+DQ
 JQU91i6BcwmR5ERbOYwqkJ8ebSyUKyByj9h69pbbnwRKQJb3VidTn2mPKKFfaGEyk+6Q
 GoYSeWOD4e8mBvn9+S0PwOoLs7kwJs32fPDq9Q9W8XeF1rbT5ORXnQQwNg8cdRovZIrj
 RhVeheRidtl0xSwrTWJ8A1h24Z1VnQBuWWV1rcsqmylYJ7GnLWS2/rCoFa9E/UaXRBHu
 WMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882022; x=1690474022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PkkwaC5weGbOgI6TyHV8oGFM7+1AeUMfWTRfSlmxtvc=;
 b=M/hlcHRgDG6iUaqTVjY0MfMFY0M/spsxayt/rTtOFXGXPy090DZ2e3W5XSNlQ10BLq
 9793UYfS+/c1ORmoVn5oArKBV+nADozzkBhENFNGOvCrUOcJuDzEPKAEgUe0m7FEX6lM
 UAS/aKfUMEu2rhjSbsrGxg02iBBg0/7n22+nvM0rg6bDM0iDNXkJUBIYJOH0ZBZiotu0
 Cz/I5uCWHT1V9ZbWImmjWWBKF9kB0ud14uvVmNx0tP1gz2rHp5WTFjn7SfX6dB9AT2mW
 4DnfI1CZ8iWju7FaOCCgwyg3O2A6rH1Kbvwe+MKvWbK6O5+lVPxJTku8fyNzJ4tY9xkC
 IHBQ==
X-Gm-Message-State: AC+VfDwYKBtV5gruIF1e+I5+TqajAttWg50hQY/3YFDkyag37Zw4nXtd
 Fn54Pdnk3gFm0rFpjvd9XLBEEA==
X-Google-Smtp-Source: ACHHUZ7RsVo16w1vK5PhAuR4twiRw3BBVr2ozf2ZHbo0Y1SEmMuDQxshdgR4OPvmokwepNQflDJpmw==
X-Received: by 2002:a7b:c8c9:0:b0:3f9:b8df:26ae with SMTP id
 f9-20020a7bc8c9000000b003f9b8df26aemr17695408wml.34.1687882022063; 
 Tue, 27 Jun 2023 09:07:02 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 cx16-20020a056000093000b00301a351a8d6sm10926631wrb.84.2023.06.27.09.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:07:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1024D1FFBD;
 Tue, 27 Jun 2023 17:07:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Leonardo Bras <leobras@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bandan Das <bsd@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Juan Quintela <quintela@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v3 02/36] gitlab: ensure coverage job also publishes meson log
Date: Tue, 27 Jun 2023 17:06:26 +0100
Message-Id: <20230627160700.2955547-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160700.2955547-1-alex.bennee@linaro.org>
References: <20230627160700.2955547-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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


