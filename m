Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0C97BD7FB
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:06:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpn72-0003Qx-Gd; Mon, 09 Oct 2023 06:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn6l-0003Bi-7K
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:03:30 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn6V-00009P-BP
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:03:24 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2bffa8578feso51914931fa.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 03:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696845786; x=1697450586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zRojbwnUlDvXIlWaYRNObAm149GLlZOkoyr1o1S54zA=;
 b=CB8yS5HL9TFgucBwsoEMCMJZXm9I3uQ/xQcGPzTAY76ip6G0ZFxOmICMH0crMa16XV
 IncQ6CQOND1qNV7R5EuMX31WB37oeOXVkkRnsS6wpFa9igKAlmuMx+DPlF6VkDgOha95
 GbK8YIdg5J2WPqIRGZFlDNknQGhq4YGwEt8eG1p4RC5MRihG1OkLQzAumw8KwwYVHCvR
 Clpj6gK/cWvyg4wumhjw8IxPbJy1w1DVSMxSTR/tykh+7yxGy2ZdnLY3EV5bx6k1UU3t
 kyHxCiNMXDkhCMoYxrk49fNeMTn+Tn15YUhMaqfssMnNDAJiW0CUG56pN30fOtctORyV
 fbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845786; x=1697450586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zRojbwnUlDvXIlWaYRNObAm149GLlZOkoyr1o1S54zA=;
 b=DocqqOULvAWDt2nI9NLDmw5rOocvTMzV5U5iDRT3geMxCsZ89Nmm7ItfzSbZ4CshyQ
 i9DjyJ0QSpEkeR1uK5qwh6XTz6o43lbxgUqDnioKC3RnUg+IYGWrA0cQIePKuRcosib+
 ciNgW+TpsCX2O8oPoyWlOyRbpu5LeiBCz6AzAj9/0Ca2L8EaZ5VlQah/bpwZ4Sc+Q0P5
 yXMRACQHyG47kdOL3Qjl1wb5xM72ABUd8XWJ0XfJjH3gGI5/G8L2FsFWIQN8vcqJH2yl
 Q42swun2yPXjgbt4oLkBZunF6NGRZl1XLd1TEBYEwGlNbeuqz8Nd8cpx2TFuFAryEEoX
 DAjw==
X-Gm-Message-State: AOJu0YyKAh7v9YOipYGb/588GatOIlpj/qOOiH1BUmvI2+5nL199HL3i
 pcIX2UbmFCumB7qJ6/G9VaAiDbUfcDTyH/di9o4=
X-Google-Smtp-Source: AGHT+IEgTNUVksOYqKDUwkDF8wBv+wI99yUEB2BpfktJ5354uiq5gGdtA30CQ1wxFo2ljRQromq7EQ==
X-Received: by 2002:a05:6512:3447:b0:500:7efe:313c with SMTP id
 j7-20020a056512344700b005007efe313cmr11157068lfr.24.1696845786199; 
 Mon, 09 Oct 2023 03:03:06 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 e17-20020a05600c219100b0040646a708dasm10696156wme.15.2023.10.09.03.03.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 03:03:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Hao Wu <wuhaotsh@google.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Tyrone Ting <kfting@nuvoton.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/10] tests/throttle: Clean up global variable shadowing
Date: Mon,  9 Oct 2023 12:02:43 +0200
Message-ID: <20231009100251.56019-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009100251.56019-1-philmd@linaro.org>
References: <20231009100251.56019-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Follow all other tests pattern from this file, use the
global 'cfg' variable to fix:

  tests/unit/test-throttle.c:621:20: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      ThrottleConfig cfg;
                     ^
  tests/unit/test-throttle.c:28:23: note: previous declaration is here
  static ThrottleConfig cfg;
                        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-throttle.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index ac35d65d19..2146cfacd3 100644
--- a/tests/unit/test-throttle.c
+++ b/tests/unit/test-throttle.c
@@ -618,7 +618,6 @@ static bool do_test_accounting(bool is_ops, /* are we testing bps or ops */
                                  { THROTTLE_OPS_TOTAL,
                                    THROTTLE_OPS_READ,
                                    THROTTLE_OPS_WRITE, } };
-    ThrottleConfig cfg;
     BucketType index;
     int i;
 
-- 
2.41.0


