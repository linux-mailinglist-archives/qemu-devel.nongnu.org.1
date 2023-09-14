Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A678D7A09DF
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:56:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgofz-0001dH-5S; Thu, 14 Sep 2023 11:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofu-0001VS-PV
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:39 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofn-00086x-Rr
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:38 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31fa15f4cc6so1032198f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694706864; x=1695311664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k21Hb8AoJTRuQjBs5reis/Cuxx3HBqeBNhgdjuMaPj0=;
 b=qr/qoZaaD07wUY/M7Zid5aNXLmkibMIXs1hAkqeZ7rumx59db4YUOknDv034aqA4el
 P0TVOsZGrNBIwy1CWx/pKb7qAG1o385ErSvQXdsGecLNaKjy9eybLHiim6H7nHfrwOaO
 hlz8ZSR0OQw2j+xcN+tUu5kT+1yynu8G0Mv3QBxa2rcI/x3PBANeTXYS3VqtT2ZWuBih
 hpKSPM0WeF+/tEryGhOzvNG52kxjSKmVGx5wLG8OKG0BF79qFcC9IVy9rz1gW60u7Jwj
 Qc7OD57stJhtSncspMO57liav9WgHa9iCD3fvJDg2AJZbZAZAN7hEbpN24v0uOYQ6PFL
 kTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694706864; x=1695311664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k21Hb8AoJTRuQjBs5reis/Cuxx3HBqeBNhgdjuMaPj0=;
 b=Npois9cf8CuUJT2O//iv2ZZZKw8Axn6UdedDGsxQiWhPzWqypl52jF8DIylBcLE4Td
 s0ugHGK8bc1Z6lqeWA0HBUEaaxgRcy9YD1uE5XAjPquaPab9GAUVqThbJa53LNpyKKXI
 gbKJFEAKRAeI324ir/5MvHIAS3MNtHtx2HcsWvXPNHyX+is3HVOPDNnYzkG45G+bVp2+
 Cmehk0qGOux23YG+WX9XxxRkF0mMCgN8+bS2PDeeEnjQ0DxaI61U/i4G62DhWEOeSdAV
 oDa0FlnfjtCY0kIUXJHSPIGz/MG5ms9dfu0D0eclyi3l55sPsznXeQLXppztuwOULnAG
 wUow==
X-Gm-Message-State: AOJu0YyV6cZfY+0vRRiRvv2tDUptfv2seFY5OGqKLGEQaT9jkygf96LE
 NHbjRy/3q/VHQGPELqgfgXqeTw==
X-Google-Smtp-Source: AGHT+IFTR0DduEb1HKr9P2zx0HxGoNIb7sgAfOtUu6Nt3aqVw7gzzcKJkQFwfJktJqz6vDBwObwrNw==
X-Received: by 2002:a5d:4903:0:b0:319:6e3f:d5f0 with SMTP id
 x3-20020a5d4903000000b003196e3fd5f0mr5503850wrq.44.1694706863974; 
 Thu, 14 Sep 2023 08:54:23 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f21-20020a7bcd15000000b003fe24441e23sm2320842wmj.24.2023.09.14.08.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 08:54:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C66921FFBE;
 Thu, 14 Sep 2023 16:54:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 3/9] tests/docker: Update docker-loongarch-cross toolchain
Date: Thu, 14 Sep 2023 16:54:16 +0100
Message-Id: <20230914155422.426639-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914155422.426639-1-alex.bennee@linaro.org>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Update from clfs 5.0 to clfs 8.1, which includes updates
to binutils 2.41, gcc 13.2, and glibc 2.38.

See https://github.com/loongson/build-tools

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230829220228.928506-2-richard.henderson@linaro.org>
---
 tests/docker/dockerfiles/debian-loongarch-cross.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index 9d957547b5..b4bf265717 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -20,7 +20,7 @@ RUN apt-get update && \
         git \
         python3-minimal
 
-RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2022.05.29/loongarch64-clfs-5.0-cross-tools-gcc-glibc.tar.xz \
+RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2023.08.08/CLFS-loongarch64-8.1-x86_64-cross-tools-gcc-glibc.tar.xz \
     | tar -xJC /opt
 
 ENV PATH $PATH:/opt/cross-tools/bin
-- 
2.39.2


