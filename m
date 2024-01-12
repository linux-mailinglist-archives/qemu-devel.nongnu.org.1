Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7672A82BF00
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:11:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFQl-0007SV-3Z; Fri, 12 Jan 2024 06:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFQg-0007Oa-Bh
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:10:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFQa-0003PF-Mh
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:10:23 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d5336986cso80678685e9.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057813; x=1705662613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vdKmk3lZX5tqvHRdpjb2MVW+8JPyrfi4VG0gycml1xU=;
 b=pP7+9iOdXCjt+AmEz9ONTbONLVBg7SFbnOhZYY/QMDlo0yHnHYNga8l+0ekai1QuGm
 g6SW+O1MKmtrcWQyFdH2vD0CmbKbMuoUT1J2TzHcLThg5jV0tpaGvTpe3AT8Gu/tYn3x
 s3GZecSqrTE0SJd0PPC4Eq2HsEHUKDkHRL2UllwP7pQk80To/QpOM8s+9hGNLCzL//kV
 k9j61DH6GrJLDQKj4wDDBPZ5JlW7YoY/O6VskudTH5MEM3vcatg+AHG3CO41kjhPv9rj
 EtA5RiAOtcOWtk4+YgDzdpN5PrABntgndYS3RN0cd2CojuvW1G5aLLeFGYwv4OeaAzJL
 GpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057813; x=1705662613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vdKmk3lZX5tqvHRdpjb2MVW+8JPyrfi4VG0gycml1xU=;
 b=we2fLFHSfyDAkCoxgThuvP3H07nExd2WmrG9blSPSuxMs5U8OVGYnQLEY10kkXeQUX
 vPaziBoqblktgXlrkYo6nX40KhMS1GnqGO/NI1nosWpZsb6L/BNj20gi5xa3s6OFzRT2
 4giklXCRowfVp8abC0zEirOTPHKnDTpAlR5Wac89dOaVe/KDMU8BYtzfKo+4twKQ0rUd
 k1XTytkAzAv5aPhLbilABKJ2/BWoj2KZkPOzlR9i5dTgtvo0m+Rq1lgMJXxyDMeUwlaE
 E8THWGQaFdDfJexEQAAgDNqSHWvKyxkMpFC7mI5/iwC0PcWTgk3bt/pmJM0NXC4HECAm
 lAiQ==
X-Gm-Message-State: AOJu0YyCjbk7gm0vBZHoXdMIkLSFp5SzKCe8sNPKFRLJMoFJ23Cx0r57
 AaCRFe8Cre7D/d3MO36zEZtI6yaw7lNVrw==
X-Google-Smtp-Source: AGHT+IFAQYi14vrd7xxxWVm8V80Gmj6gt+XSEHNZ7ld/qvfnkCFm+XDztFtwXlaHT9fhqcaAADBN+Q==
X-Received: by 2002:a05:600c:3f9b:b0:40e:45aa:30d6 with SMTP id
 fs27-20020a05600c3f9b00b0040e45aa30d6mr653197wmb.38.1705057812822; 
 Fri, 12 Jan 2024 03:10:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 cw3-20020a056000090300b003367a5b6b69sm3591210wrb.106.2024.01.12.03.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:10:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B7CD75F9CB;
 Fri, 12 Jan 2024 11:04:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 19/22] tests/fp: Bump fp-test-mulAdd test timeout to 3 minutes
Date: Fri, 12 Jan 2024 11:04:32 +0000
Message-Id: <20240112110435.3801068-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

From: Thomas Huth <thuth@redhat.com>

When running the tests in slow mode with --enable-debug on a very loaded
system, the  fp-test-mulAdd test can take longer than 2 minutes. Bump the
timeout to three minutes to make sure it passes in such situations, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-16-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/fp/meson.build b/tests/fp/meson.build
index 4ab89aaa960..114b4b483ea 100644
--- a/tests/fp/meson.build
+++ b/tests/fp/meson.build
@@ -124,7 +124,7 @@ test('fp-test-mulAdd', fptest,
      # no fptest_rounding_args
      args: fptest_args +
            ['f16_mulAdd', 'f32_mulAdd', 'f64_mulAdd', 'f128_mulAdd'],
-     suite: ['softfloat-slow', 'softfloat-ops-slow', 'slow'], timeout: 90)
+     suite: ['softfloat-slow', 'softfloat-ops-slow', 'slow'], timeout: 180)
 
 executable(
   'fp-bench',
-- 
2.39.2


