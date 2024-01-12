Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C28E82BEE7
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:07:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFLp-0005lG-H3; Fri, 12 Jan 2024 06:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLI-0005jD-Mp
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:55 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLF-00005A-JU
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:51 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3375a236525so4859123f8f.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057488; x=1705662288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/MAq4VZo2MHxXNp59VgimCAE0d3Qh3p6Gwxt9Y6qaA=;
 b=fN+GRYu4ZeKd9bVrTX5lmLo5KimDIZucadCKYXJHEYsNx/FKWAOqYp4Jc++S5ZHzAy
 6euvKpK3kiAEk6Hlv0RSgIz4LcDY7IwgrAGytcjHThO628r5gTEUoEErRI/APKMOZfK9
 LkGN8AyO912kH7M7OTOQ8644sy2rbCbEQIvzRivk8Z02jIOQA94d4TRk/pdPNCxTCYVG
 fMdSYTVSLVKqZdJfCJpWZaDNRKpmnc819ehdCczmyYIw2b2jFI9mNGJLyfWjaQBIluCP
 qRHnGEEFWGx2TgvdLYisFTkCNM5jXL2qcsld9UaHe2HSgZvNLuLBHCKVUCzHOxMU3Yyf
 1smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057488; x=1705662288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M/MAq4VZo2MHxXNp59VgimCAE0d3Qh3p6Gwxt9Y6qaA=;
 b=MzJyKEze62IwhIjSECZaVw0EPNvhMSSIojCQYVSQd1083Bw3ePsDsj2q5zXhhmV5xY
 zuZwaAMUiAnZdqDVx3TTiegchXscTqGE5H96DaJg6MLfrfLoPzc08mxmuWpKoBia2fQW
 IWGQAU+0G7OJOcq9IDM1C4y7EHQyn8uWa3PsMzdU+rHTm+dZAHlXkpr9kWwGXd6Ksy4B
 e626qV0F+rx/7EgcefsFCSYNrPDo7YP2DHUQiwWNyKqDhstCVVlOqwRIlYfOfD+b/z/H
 bJscRA7purYxl80b/ihR38GorQXaY1qAakBXHXvwCqKnBO36KaIWvFbR5uCukRLxEJrE
 z5cA==
X-Gm-Message-State: AOJu0YzrZFMq+ubcT1oY/aRI/aDV5V55w8DCPkl8mb8V+DCh41ha/8W6
 CvmQKO8i9TyC8W+eK7c4Dll11VoeeLblzQ==
X-Google-Smtp-Source: AGHT+IH4ecJYRkEH/jvJB1PGaHt9KSMgSMAF3hHhBMaM/3lL2Y5OhLJtcIiyzrzD8a1UFUGcMpS6pg==
X-Received: by 2002:a5d:678b:0:b0:337:6255:472e with SMTP id
 v11-20020a5d678b000000b003376255472emr669284wru.64.1705057488262; 
 Fri, 12 Jan 2024 03:04:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p13-20020adf9d8d000000b003375c8f796bsm3590391wre.0.2024.01.12.03.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:04:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 632CE5F955;
 Fri, 12 Jan 2024 11:04:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 15/22] qtest: bump bios-table-test timeout to 9 minutes
Date: Fri, 12 Jan 2024 11:04:28 +0000
Message-Id: <20240112110435.3801068-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

This is reliably hitting the current 2 minute timeout in GitLab CI,
and for the TCI job, it even hits a 6 minute timeout.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20230717182859.707658-12-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-12-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c86a997b954..9e0ad15dfc9 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,6 +1,6 @@
 slow_qtests = {
   'aspeed_smc-test': 360,
-  'bios-tables-test' : 120,
+  'bios-tables-test' : 540,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
   'qom-test' : 900,
-- 
2.39.2


