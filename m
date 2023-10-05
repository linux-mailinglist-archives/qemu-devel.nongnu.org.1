Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD89B7B9AD8
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 07:03:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGL6-0006K6-DR; Thu, 05 Oct 2023 00:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGL4-0006J0-RJ
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:51:54 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGL1-0005kE-JD
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:51:54 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3231dff4343so315392f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 21:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696481509; x=1697086309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1SNFnHlL4hvCYTsSAUCxKg7fEKq/31KjVEaRB5Pubfs=;
 b=Xf6XmpCmohYv++AKHPstdOGLlht5RJPKVY47+f8QCMsQ1wruQTY2nKOYxtyeki05dE
 Y+DiYTV7ZfGiDRi0xk+AuH4eTREWPj+XcplZe9UveAn69JCeJZr4ipljD5BFzZiHid54
 OiIiLdxTEhya4brN9GzeK2Zs21QZjXVsukerZSDS1aWEPrYRCqhEeW6PidqlOBCpna7f
 HJufYL1wGzFdEtkY9yUnMZ9VEo4OB9K5WHqT6Y+7Wr/MVDX6Awrhqv2jBZXoP+5lqhbB
 4n2tLRqumupXzEpYlIkJyJxMJzr+HYAMHXrhxYgi3ts2xRsqOzbsv+Eh3zDNSno2t/wU
 aW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696481509; x=1697086309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1SNFnHlL4hvCYTsSAUCxKg7fEKq/31KjVEaRB5Pubfs=;
 b=MTx/oCLFqx2Kdwxd7kpAVYqtZPv++rmy1CMn63iA4oVaq6u6ovCi5mbAGTIBKfDUOA
 jvJaix0hbPhMOnPPjc4fT53My1MZ9BiUsg/bOdksSALAv5gSW36AeTluTFSgcKaX0b5c
 S7eKqylgQubolwf3M/ANEJxXxO3KKr0BOmGDi45TIGz4mLi774WB+6/+dn6rxg6Gmo4U
 m5GqOkNq9zxUDWRu+Zzjj/C0fFF3d2y4pW2/XmAHnSRJmgy5XCTpsAtL32WMkMag/JSj
 6Gz/Am5tFFk4RmLzwa7B/Dcl67d52tzsbkJyLLRPphn1I7WNcn2ETV9x+tUihbhDLt+1
 uZxg==
X-Gm-Message-State: AOJu0YxjxML0Neh8jpUEQRI9oA84BxglxJn4yHctOMP3vRxlnhKyzhUl
 KwpaPkLjKfhwBTuDRCVhqyHc/f2j0r/+3AyJWDU=
X-Google-Smtp-Source: AGHT+IHWqF8fD6iwsftSuMnrbiD9cyVVMTS6dqbyKhCVksFbvAyMpasB1cToEpVcoiog75RWUhM6gw==
X-Received: by 2002:a5d:4dc9:0:b0:321:f74d:ade3 with SMTP id
 f9-20020a5d4dc9000000b00321f74dade3mr159772wru.32.1696481509352; 
 Wed, 04 Oct 2023 21:51:49 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr.
 [176.171.211.120]) by smtp.gmail.com with ESMTPSA id
 s4-20020adff804000000b00327db11731csm753246wrp.22.2023.10.04.21.51.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 21:51:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 10/22] qapi: Correct error message for 'vcpu_dirty_limit'
 parameter
Date: Thu,  5 Oct 2023 06:50:27 +0200
Message-ID: <20231005045041.52649-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005045041.52649-1-philmd@linaro.org>
References: <20231005045041.52649-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

QERR_INVALID_PARAMETER_VALUE is defined as:

  #define QERR_INVALID_PARAMETER_VALUE \
      "Parameter '%s' expects %s"

The current error is formatted as:

  "Parameter 'vcpu_dirty_limit' expects is invalid, it must greater then 1 MB/s"

Replace by:

  "Parameter 'vcpu_dirty_limit' is invalid, it must greater then 1 MB/s"

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 migration/options.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 1d1e1321b0..79fce0c3a9 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1163,9 +1163,8 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     if (params->has_vcpu_dirty_limit &&
         (params->vcpu_dirty_limit < 1)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "vcpu_dirty_limit",
-                   "is invalid, it must greater then 1 MB/s");
+        error_setg(errp, "Parameter 'vcpu_dirty_limit' is invalid,"
+                         " it must greater then 1 MB/s");
         return false;
     }
 
-- 
2.41.0


