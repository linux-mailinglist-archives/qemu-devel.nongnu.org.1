Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6312C82BEEE
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:08:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFLy-0005w3-Q5; Fri, 12 Jan 2024 06:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLG-0005hV-3k
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:50 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLE-0008WM-Co
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:49 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e60e137aaso15520095e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057487; x=1705662287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YkJAnJVL8Hu0vr1D6U/FTgZ+gsEc0ZWklZcYzaaxgVg=;
 b=Oh0IAO+L8uBnzfjKkUu1dxW7dtRbAee7FBN6ryotkxnMRu5vMBqDQXkDB2XFm7ZJMa
 1Z1hJCMRp3iob5TOeKp+GyJYruICFv9QM+GRrzLgrvJq7fkxi+BmwKQoZDb9QS9IBbGq
 fp1dGLPHds83bJkSxKuGR8IPi0+NFCmKazPXTQDoG+bJR7NTna1JYVVWndsaQ/6izDtR
 88nwk5TWHMNA4xCqYqN173Y8LBd/UlIwcv6UwLd/6HOEWl/gZtd9zo0fs6c0B64hv67R
 MpPeko5wesolIAf6sviMLn48rP+M9HrCzqbNxgwLeHAwNQCJYDebPS97VV0DUZ+LajgJ
 Z2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057487; x=1705662287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YkJAnJVL8Hu0vr1D6U/FTgZ+gsEc0ZWklZcYzaaxgVg=;
 b=BojFj8vY2Mm68oWxc9eOW/6VLjRLrDCr1L01eRerS9lqV3uaT1PdqEFvViZxj5yDyG
 MQLx2tIenhruN5BEszTzOeaZUNyo3uWB7TgOq/3JOYSe104ppOV9HtwkoCQ/JHTWzwCR
 +ESsWhaDdf2dft10L2JdN2wtPbUY1ZQ0gRHX2HHW47F6f23dugEcsMlQK/sH3YnWHgrT
 ekzXyqP5LkU7GM7t21jy/imF89BbM1frcawdPMiWInGTnDse+hkf9DIN1Y7x1fDENBOK
 pdY2L7GbjvcafhCZ0KMyOmYEgnQAPYxsDqgEdiYfVoQlX5ESK1GuvUiB3pmzi8JXGHoH
 gCyg==
X-Gm-Message-State: AOJu0Yxv67kDDmnoIDcZ5C1L7CXUxO7CBekcCYIOMOCv7ro5e25rOWkJ
 vO+lwP5Juq/9+tFVhM9rT//fK1ZcNbq9yA==
X-Google-Smtp-Source: AGHT+IFdWlaKyNnhaUHyXsXA94GYKtss1lYFJP47YTaLAK3KLCWXfL7Bl3o/tIWmBDvsPehTHzziNg==
X-Received: by 2002:a05:600c:3b87:b0:40e:6275:e6be with SMTP id
 n7-20020a05600c3b8700b0040e6275e6bemr684078wms.43.1705057486984; 
 Fri, 12 Jan 2024 03:04:46 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j17-20020a05600c1c1100b0040c46719966sm9306627wms.25.2024.01.12.03.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:04:43 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7748B5F957;
 Fri, 12 Jan 2024 11:04:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 16/22] tests/qtest: Bump the device-introspect-test timeout to
 12 minutes
Date: Fri, 12 Jan 2024 11:04:29 +0000
Message-Id: <20240112110435.3801068-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

When running the test in slow mode on a very loaded system with the
arm/aarch64 target and with --enable-debug, it can take longer than
10 minutes to finish the introspection test. Bump the timeout to twelve
minutes to make sure that it also finishes in such situations.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-13-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 9e0ad15dfc9..fd40136fa9c 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,6 +1,7 @@
 slow_qtests = {
   'aspeed_smc-test': 360,
   'bios-tables-test' : 540,
+  'device-introspect-test' : 720,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
   'qom-test' : 900,
-- 
2.39.2


