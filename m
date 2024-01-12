Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA06C82BEFE
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:11:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFQm-0007Ss-JT; Fri, 12 Jan 2024 06:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFQi-0007PT-9k
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:10:29 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFQb-0003PQ-N5
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:10:24 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e5afc18f5so21342475e9.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057813; x=1705662613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQ63mOKGyVdAb42vG+HGq4RSz8K/M3rEjuthKoR8dtk=;
 b=vFrgSbzuSax7OlVOgDoCOfHAqUudUZu48zNjcnNDjjNqBZkq43mn9ZktC6MTlbj77z
 Q+sk86ndzGTJ7c24UD7h/O5xW676FGCXhLPbmVjF0GEXUqSgiihEhp1oeFnjq2cYAYkP
 qbior1oiKFORnYhTTSDKVvcbpr4BDxkM4yEW0W/mMrLYZeeMPSCqUNyIjQqGTJ7R29ZX
 e1e5KkSQUMo5OsHT8RFZMQGiGX+B7HjRMZ7NazdyfNqbswtrHQT/5H0VVOOCCUMbZH8O
 hWlzfJyCkS779q5rF+uXsxJD+0F3ONmICXfFkoCqmxoV5VqiXmGZGZVi2Bdm9XcyhvVe
 B+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057813; x=1705662613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XQ63mOKGyVdAb42vG+HGq4RSz8K/M3rEjuthKoR8dtk=;
 b=CCkBgMl8GJEeKW1cPfsB0fawppMqb7exyAasFDbkg97KfKuOWhYx95Calk8GJbxl19
 91KErpTrIISkw+RoveR5Owi66ix4PsyIbG1NWkTBzoEufsUmQgyGQjgPs8EWycUZx2Zm
 vAsGPT/pS+edZFt+219pNnRxJQNjfB2KHCPOr7oT9RqgbSdtyHKt8FuBa494dzUNNN7l
 Wh/PlTwinDyzMJaTdb5h8jDCGTFTkM6Qd40M32MyH3saXMWusXTxgYHfc/j0BF++63aU
 nQaUJ5rhCfRqXNx2miFGbsuHPEmw+YGDmZg09dTApRT4QNCvhJ0oKcnpq0f0hDL6fF9/
 mLRg==
X-Gm-Message-State: AOJu0YwXYYcudnu+oWN5TcZoaHESgfl+s4bQRYCbd1+4myNxts9Ua9sL
 uoJvrRhQLOqJvIN62btKbeiyr5PZjBsGgEWFMkqITv9Sgeg=
X-Google-Smtp-Source: AGHT+IGlXnmilfaCOnrFhJ7Tsoch+Vg9PmlVJC2jgwJSWYH0DSj9vbPPh870g/Yg0ooFjMv74Yek5g==
X-Received: by 2002:a05:600c:754:b0:40d:8557:8d85 with SMTP id
 j20-20020a05600c075400b0040d85578d85mr652785wmn.80.1705057813032; 
 Fri, 12 Jan 2024 03:10:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f15-20020a05600c154f00b0040e3b12052bsm9375391wmg.5.2024.01.12.03.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:10:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CDDBD5F9CC;
 Fri, 12 Jan 2024 11:04:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 20/22] mtest2make: stop disabling meson test timeouts
Date: Fri, 12 Jan 2024 11:04:33 +0000
Message-Id: <20240112110435.3801068-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

The mtest2make.py script passes the arg '-t 0' to 'meson test' which
disables all test timeouts. This is a major source of pain when running
in GitLab CI and a test gets stuck. It will stall until GitLab kills the
CI job. This leaves us with little easily consumable information about
the stalled test. The TAP format doesn't show the test name until it is
completed, and TAP output from multiple tests it interleaved. So we
have to analyse the log to figure out what tests had un-finished TAP
output present and thus infer which test case caused the hang. This is
very time consuming and error prone.

By allowing meson to kill stalled tests, we get a direct display of what
test program got stuck, which lets us more directly focus in on what
specific test case within the test program hung.

The other issue with disabling meson test timeouts by default is that it
makes it more likely that maintainers inadvertantly introduce slowdowns.
For example the recent-ish change that accidentally made migrate-test
take 15-20 minutes instead of around 1 minute.

The main risk of this change is that the individual test timeouts might
be too short to allow completion in high load scenarios. Thus, there is
likely to be some short term pain where we have to bump the timeouts for
certain tests to make them reliable enough. The preceeding few patches
raised the timeouts for all failures that were immediately apparent
in GitLab CI.

Even with the possible short term instability, this should still be a
net win for debuggability of failed CI pipelines over the long term.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230717182859.707658-13-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-17-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index 179dd548718..eb01a05ddbd 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -27,7 +27,8 @@ def names(self, base):
 .speed.slow = $(foreach s,$(sort $(filter-out %-thorough, $1)), --suite $s)
 .speed.thorough = $(foreach s,$(sort $1), --suite $s)
 
-.mtestargs = --no-rebuild -t 0
+TIMEOUT_MULTIPLIER = 1
+.mtestargs = --no-rebuild -t $(TIMEOUT_MULTIPLIER)
 ifneq ($(SPEED), quick)
 .mtestargs += --setup $(SPEED)
 endif
-- 
2.39.2


