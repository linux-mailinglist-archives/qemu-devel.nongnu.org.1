Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE7682BEE2
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:06:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFLw-0005uG-8k; Fri, 12 Jan 2024 06:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLC-0005eT-SH
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:46 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLB-0008VB-7g
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:46 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e5f615a32so15958645e9.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057483; x=1705662283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNOA0FwC927OPiE1JlIlLsnPwLt2e0Dl5gDPs5BlcFA=;
 b=AN4PjbDEk3Te5LuzA2LcKMBl0MGAwjtl7RrLQl4mX7dGlUBw0e/V1OzENFTtIHBNqR
 w2OqG+v69eXWLzRM23xaDe7nvR/db7KCMmKGGn+BH7jui3ZWaqDY4aVoZbTpjXiyQe/D
 zdQKonQHAXnscJJ48BPqVRMlY0GNp47JGJh0rokUGotWqsa54dAjiuTa4rbPfHs0C9H9
 Y3QkU6E5SRzXEHZQxrAyPvNTss9ZEeCU2d1b11VoAukNDA6Oi7Z42xH5qP3W8pqQ2Fw0
 Up41IhLZ9Vfp0N/JQlJrnaevMfq1LGc51BarSLXEVZ/ddCjHhlmZK8cwPRxGb6ZUS2h5
 hs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057483; x=1705662283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NNOA0FwC927OPiE1JlIlLsnPwLt2e0Dl5gDPs5BlcFA=;
 b=TtvzV/r04i4Cg0yni+wbXuvI1ELVdI8hVBGopY3tAiyEq3Yku58F7q+MtjbyegMv5l
 +vHU2v7ksazduAAfPeZiNXR6tNU6IIXkf2FNSz2lHCtCB6K1AFDY6uvnW5o35DbRPTnM
 f7ni9qjwxhPxCZBO298qJAwYpYsu29ojBURMhHM6IrhG982AnvIo6OJQmGx7cJZnbbKt
 MuOh1apLEB0MqxTQOhP+fkl0Shf1hcNOeg+ijDl2W0MuESYEbhxtvdN8f/Ocr3IvAYch
 MpFeNJVci5tp+vXNfn8LHBNT/tfNzpvD7T5KQbjewvyXGysU10HApGwtVKlNE2Ut0ppW
 h/cQ==
X-Gm-Message-State: AOJu0YxzWv/yOHAS0x6e0XTKMIusbngttW7NpD13YTe9hNPHXPCQRJ4L
 JzOeN2j3f0pmta8vV3zRgeB7HkeK1Uznyg==
X-Google-Smtp-Source: AGHT+IGZvtK9OqRDp3TMQIDTHgT9q+M4yGAVGVdaWBr4D0xdGZEHHtCYJskrkeWWKZ2rSyTXeeb/mQ==
X-Received: by 2002:a05:600c:331c:b0:40e:4391:dfbe with SMTP id
 q28-20020a05600c331c00b0040e4391dfbemr328765wmp.369.1705057483560; 
 Fri, 12 Jan 2024 03:04:43 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l22-20020a05600c4f1600b0040d6b91efd9sm9243542wmq.44.2024.01.12.03.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:04:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EC2085F7A9;
 Fri, 12 Jan 2024 11:04:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 10/22] qtest: bump pxe-test timeout to 10 minutes
Date: Fri, 12 Jan 2024 11:04:23 +0000
Message-Id: <20240112110435.3801068-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

The pxe-test uses the boot_sector_test() function, and that already
uses a timeout of 600 seconds. So adjust the timeout on the meson
side accordingly.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
[thuth: Bump timeout to 600s and adjust commit description]
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-7-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 3ea8279527c..3f56b205181 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -4,6 +4,7 @@ slow_qtests = {
   'npcm7xx_pwm-test': 300,
   'qom-test' : 900,
   'test-hmp' : 240,
+  'pxe-test': 600,
 }
 
 qtests_generic = [
-- 
2.39.2


