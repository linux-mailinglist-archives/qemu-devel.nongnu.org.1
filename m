Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C2682BEEA
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:07:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFLp-0005mM-Uv; Fri, 12 Jan 2024 06:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLC-0005eN-CE
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:46 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLA-0008Uu-43
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:45 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-337984681bcso178238f8f.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057483; x=1705662283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9gmO/N7AqjHxDubRTh6T8E3wbiz0nv6J3bLW5kwUXO4=;
 b=A18KeUIeDXmZD91wImEugy0sdauFTUnH2xHn6kaK8UlCsNFhRNHE6YvFygJBuBI5bz
 I66me23JPqBsJkjY3DAFqmwU3tXkKdD3TaaBXEd99ugV/YZweq8PF59UhAqzqtiAHH0d
 9pA4T/CsvBMCtSmnV2ApCkt0RZrfuW1oKtBZhxrCvkviNdiq8Y1ApoGdU9kflr0oYAQO
 ZRqZXSOiWx/Ov2rV0KmeVRGlFgP7ZCZNaqTnHoNCziIf5OG3YrLMn+b4b9falfmMPU+R
 6eemttghV2iIa5V88RXFaV8dykbyrl1T68x4yRYTmIcSV2PLMrGJEeyFJOHgjcilF+Ej
 Ghew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057483; x=1705662283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9gmO/N7AqjHxDubRTh6T8E3wbiz0nv6J3bLW5kwUXO4=;
 b=r5nJYYgDgHdWrf5vnujYc0PLzotmS8/2AgYy+meLVPcKtTD1xZ6HY91nEDnsH63Mm4
 qbzM8eLcqoO560de3W1heNS0p3CWRtMt1j/NAamEui9VnjfI/qQmY9XybZd/nsQ11Pv3
 qK9aIAsPEOlT8/RXLLCUMeSHbSRAu1UgqHdAkBYp/uubcigFjKej2ZCW62UYSGrSNs0q
 1d29I55RkxZEl/YQodRu5TmUyWtIXCnTielNN9+okZ6Mtq5RSO1O1l0tvdNznV2ww/KP
 B5JS0OWHi2sK1KHU7DEqEoJ1GTALfVrdQj6wLqGVr6xju7BDJ+h2NbxzyHxa1ENSvS7O
 bgFg==
X-Gm-Message-State: AOJu0YxTahaF9R0TMETzmzbwuFPcX9t4kjdqk/BwAbV4wylkzNk+ENDZ
 8383i1+y/XIaxSgQvz5loH5ELtiTXcGdXA==
X-Google-Smtp-Source: AGHT+IEGyKr8rehIx6RsbQ6fHxNqTWxmigzhLWJ6VsT3GBSXM6IJgxOznv7QeU45Qx/9ZqSIliS2Xw==
X-Received: by 2002:a5d:598b:0:b0:337:7af8:33c3 with SMTP id
 n11-20020a5d598b000000b003377af833c3mr664240wri.6.1705057482820; 
 Fri, 12 Jan 2024 03:04:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm3596000wra.44.2024.01.12.03.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:04:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D75615F950;
 Fri, 12 Jan 2024 11:04:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 09/22] qtest: bump test-hmp timeout to 4 minutes
Date: Fri, 12 Jan 2024 11:04:22 +0000
Message-Id: <20240112110435.3801068-10-alex.bennee@linaro.org>
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

The hmp test takes just under 3 minutes in a --enable-debug
build. Bumping to 4 minutes will give more headroom.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230717182859.707658-6-berrange@redhat.com>
[thuth: fix copy-n-paste error in the description]
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-6-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 823a8ac38d0..3ea8279527c 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -3,7 +3,7 @@ slow_qtests = {
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
   'qom-test' : 900,
-  'test-hmp' : 120,
+  'test-hmp' : 240,
 }
 
 qtests_generic = [
-- 
2.39.2


