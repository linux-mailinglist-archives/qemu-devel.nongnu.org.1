Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E72782BEE6
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:06:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFLp-0005lP-Gx; Fri, 12 Jan 2024 06:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLB-0005ZW-Hm
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:46 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFL8-0008U8-0r
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:44 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-336c9acec03so5232015f8f.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057480; x=1705662280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgNqctglhx1zAZQR9u6mYAzXg5Zm8xAv3CCYj1ivE8I=;
 b=An1fWTISzpojJ6hN0GBXiW5gUc0WjauOcV6ZrIbuml1J65EYDnNcFmxJQXdqeZ2PqV
 7WJ7MZ4RH2Svf/GRMdUrdv7+2UF9+iPTQH4O0RtM4KGwj9p7Ltdd+e2SPhZwbLlr+Lvq
 c0rbzXlzZvrsfwIMjdojB0hmxIbm8OgY+Xtqlax7XPHU+9WU2M1fo/jUuOCCA5mOhwcf
 TlJk6Ski+fn0e7nvkthj9GYhyJOh76GW8iSn2R9GZKPqTtdtNzXMzEyuXp2mHHnOTUMg
 f67aw5mTolxF5tIpHbOWPqkjG/RlrMNLj9Kackm7ud+c7XMyJ6l9O/bufR0i8TtpLgwV
 mH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057480; x=1705662280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgNqctglhx1zAZQR9u6mYAzXg5Zm8xAv3CCYj1ivE8I=;
 b=ZHjeH9EoFNWjXeyFtMYS2fdTAUBV5Ln+34HYNzTSIGPiu0IBKOP22BAdZJukhRG/dm
 GXeSXdlzUzxJ9sdkHpY09BKPtziWZnsmEG7gFuIQCVzJG5IvopgCvPXeELalBc5uUgHy
 EZeFHlUCmP6DfCu/xmeteuBEqgN9v5dPtyz6O7+l2tKsiqiLcX3VEEFE5h5qiz46Y+Q0
 hTLHMt6vTUIco3sSOGnBebQQ0UnwY6wdkw5py2igW7W/PJCEx4UN24T/UmZJZxnPsTa4
 Kphnu6einKw3X5rGRYEuL1nkNuJZB0QfBlswf6noBp/Z6d4Ar34kYDufC2hd2T3NwZ5+
 aZbw==
X-Gm-Message-State: AOJu0Yx0G4hW9vd4n9w6WNGU0INOvRmg6Cr/Pc51QKpcgonLgeRd1dAM
 9BzJhf+LYD+TnZa7BO4l2tWqjErk+GSZGkLvhZwaHyq1TR4=
X-Google-Smtp-Source: AGHT+IFU8mRD7HH4bvxnt8QwWpuhWSptA7BUd55UYnjIjBY6zCoXdIYsoa7OQmknUtCLiEpk0aWvZA==
X-Received: by 2002:a05:600c:35d0:b0:40e:4d76:7fd3 with SMTP id
 r16-20020a05600c35d000b0040e4d767fd3mr674090wmq.166.1705057480484; 
 Fri, 12 Jan 2024 03:04:40 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 s17-20020a05600c45d100b0040d3db8186fsm5459008wmo.5.2024.01.12.03.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:04:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AADB25F94A;
 Fri, 12 Jan 2024 11:04:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 07/22] qtest: bump qom-test timeout to 15 minutes
Date: Fri, 12 Jan 2024 11:04:20 +0000
Message-Id: <20240112110435.3801068-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

The qom-test is periodically hitting the 5 minute timeout when running
on the aarch64 emulator under GitLab CI. With an --enable-debug build
it can take over 10 minutes for arm/aarch64 targets. Setting timeout
to 15 minutes gives enough headroom to hopefully make it reliable.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20230717182859.707658-4-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-4-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 2d2b37c2a78..bb9d599e4dc 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -2,7 +2,7 @@ slow_qtests = {
   'bios-tables-test' : 120,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 150,
-  'qom-test' : 300,
+  'qom-test' : 900,
   'test-hmp' : 120,
 }
 
-- 
2.39.2


