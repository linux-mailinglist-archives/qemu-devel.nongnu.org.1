Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 781AD82BEF0
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:09:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFM0-0006DG-9h; Fri, 12 Jan 2024 06:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLE-0005fW-Fg
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:48 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLC-0008Vg-9l
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:47 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e54f233abso32224915e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057485; x=1705662285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nRGRa9fRdg2SpkW9XRIXR0+ewv+KZ7YF3r/IZ1KuDE=;
 b=BG5dTGbydsN9bA87GUfmMxcJupQ9lm7A/JiAzytnV4vqvYSzLwmZcqBNDnzCdCtgj0
 5ZRmB8WIil3R1rXtVvnYuh3u33wtyWOcv0WEMDq1WzFxADDbGLH2m5xCHckkkZbg2B4e
 btaum5hwnfI5XYOYmK5fBzHyavWdSojBhtHcCsUeA3Lj5IzOszWjZuMqnMoXq/8xzu72
 aiTqKjpXbSurpgwWgJNMN0QBCS0Gau/m3Vl5Mz9nncFOQdm26u/O8tpgmVPj6OYK0Y4D
 tl2nG7Ouxv2m0zDPqvyh6V7EczOL6NDM7yrcRyAi19QfQUG8Eb9CmS/z8PLiJ9s3JBKt
 n8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057485; x=1705662285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7nRGRa9fRdg2SpkW9XRIXR0+ewv+KZ7YF3r/IZ1KuDE=;
 b=CoPMJABLxm87SWDL/7EDqVzV8S8VVn6IzTLZtFI1Ef/gE8r57MLMXpsk7mDClTyLW2
 sdBccKXJvplBmsfa1Wx9c0eSMlWKawfnf0jhmvJBBb0JNytyZpGQ3W/LexTaDBYL3fZG
 +SP6k0l+OWELNot/FTpCfsE43zfjB+MBNvgUeBEDRNaxELsz/CjAxwlJgtJ5zl/668Rn
 O9rmbvrxzHD0dt/9bnEIvp9gWUg1N3IqLCR/eB1RVLX61TvGdaUhSZCYmGtGgO/u9qHX
 DLnntW8uZiLxZCFNRuRwdACxWgZO7Rt9GuDaVeKFK9TWMXoaab71fSKTn3ZwqrRyQHUZ
 OBOg==
X-Gm-Message-State: AOJu0YxQWhY+Dp+UdcQeGJN8BRtsL8wgAHouy/EzokQC7p9Ips8aUTPX
 P0fL7/XDd2fxnzbBYJRPBrqeNNvIUtNtCA==
X-Google-Smtp-Source: AGHT+IGXuhZDwyFYfFZmJeSSMz03RkNpPVrvKJx5n6HvIhnhOqt4FLAmNer3UploAHKmKZTHCuC6ig==
X-Received: by 2002:a05:600c:217:b0:40e:3ad9:c139 with SMTP id
 23-20020a05600c021700b0040e3ad9c139mr640277wmi.81.1705057484930; 
 Fri, 12 Jan 2024 03:04:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t5-20020a05600c450500b0040d6d755c90sm5391554wmo.42.2024.01.12.03.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:04:43 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4D98A5F944;
 Fri, 12 Jan 2024 11:04:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 14/22] qtest: bump aspeed_smc-test timeout to 6 minutes
Date: Fri, 12 Jan 2024 11:04:27 +0000
Message-Id: <20240112110435.3801068-15-alex.bennee@linaro.org>
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

On a loaded system with --enable-debug, this test can take longer than
5 minutes. Raising the timeout to 6 minutes gives greater headroom for
such situations.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
[thuth: Increase the timeout to 6 minutes for very loaded systems]
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-11-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index eaa2cf64a3f..c86a997b954 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,4 +1,5 @@
 slow_qtests = {
+  'aspeed_smc-test': 360,
   'bios-tables-test' : 120,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
-- 
2.39.2


