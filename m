Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E75F17E5D4B
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 19:34:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0nMQ-0007RN-4f; Wed, 08 Nov 2023 13:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0nMO-0007Qu-D5
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 13:33:04 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0nMM-0002xK-OM
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 13:33:04 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32f7c44f6a7so4252542f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 10:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699468381; x=1700073181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=viJPlpU3vzxbCgCk3OGKl1HnEwyjYeL1NL/uBJdjxBI=;
 b=Yie5K7JUAkhkUHsiojXPuKnl/snW/A1GMbQeMLyiA1qouIPQz6fB2W8xwTzPKtmUqI
 u9VEJGWclU1OW9FKG7jZbVi+XAhcwmu1tPeTt1l5k2gWTl7T3YcdIOIdDsYcl7mdjFow
 bCE7ZW4WyCUHY+o8+civgxJtNKolsLo/pTLnSq3fkEt+0EP18fqXzz58RTQuNrYJv29s
 1BGOzKW6phZKlok7wJDsO7QVk4je2n2KDKr+w1ucHY6/Prd1QkyEO/dfk17drwJ6b2RZ
 +3f9p8HbNGU+aef7HgzJRrs+y1yvYQIu4rofpy/k4wse+vDVNcztyEZW+BPqDE/vg6dY
 rshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699468381; x=1700073181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=viJPlpU3vzxbCgCk3OGKl1HnEwyjYeL1NL/uBJdjxBI=;
 b=kezGu5MBlN0V3m/uQ2zz04tGLBRI/Ytqzl+FybvjRZG+H8ltduVuJnWjdz+bIR4C3o
 175ZEGrq4QhW5eJGpkiYJlNMds60VfQC5NuZjUFGf/x48dlq2Z7Fbw4STs6Tojw5aSF1
 oK0EHoaTBCemrJNmt+xSvw/NUJfDN/4k+vUZ+8cc2liTskCVY8mZhHXnvqcZcc433iVl
 Fe0gSqv6O/96lsEuHWSCTBkxldszrLmXqhhT45vJTghCek/V8fE9SpU3H5krJPXfwAF6
 tkQOWbuNoCMQprZjnppVf4IeV9tRHZM/XpH8ZsRYYrBU0VwC/At8Er53vst05bk3nZwu
 ILeQ==
X-Gm-Message-State: AOJu0YywkbjBR1QMmBGXIvlzw8mnkwm23gs7uaX/m6GpSlxo4vsvRQFD
 ZpqSq5OaCHupAw/Rvp/pDmFDJD7YdrQ/zpuVHVg=
X-Google-Smtp-Source: AGHT+IE59wbPvgVnbA1Dwt75BV1AIqQf1/OLk/OHqxO4DdL0qR7TNaX95C7XCleLT5uUh8RTb78nuQ==
X-Received: by 2002:a05:6000:402c:b0:32f:79e5:8109 with SMTP id
 cp44-20020a056000402c00b0032f79e58109mr2281480wrb.2.1699468380703; 
 Wed, 08 Nov 2023 10:33:00 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 g16-20020a5d5550000000b0032de6f95fb3sm5487253wrw.40.2023.11.08.10.32.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Nov 2023 10:33:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rene Engel <ReneEngel80@emailn.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Subject: [NOTFORMERGE PATCH 1/2] configure: Use distrib meson
Date: Wed,  8 Nov 2023 19:32:50 +0100
Message-ID: <20231108183251.80572-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231108183251.80572-1-philmd@linaro.org>
References: <20231108183251.80572-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configure | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/configure b/configure
index f1456f6123..93735b7661 100755
--- a/configure
+++ b/configure
@@ -955,15 +955,8 @@ if $python -c 'import sys; sys.exit(sys.version_info >= (3,11))'; then
     $mkvenv ensure --dir "${source_path}/python/wheels" \
         'tomli>=1.2.0' || exit 1
 fi
-$mkvenv ensuregroup --dir "${source_path}/python/wheels" \
-     ${source_path}/pythondeps.toml meson || exit 1
 
-# At this point, we expect Meson to be installed and available.
-# We expect mkvenv or pip to have created pyvenv/bin/meson for us.
-# We ignore PATH completely here: we want to use the venv's Meson
-# *exclusively*.
-
-meson="$(cd pyvenv/bin; pwd)/meson"
+meson="$(which meson)"
 
 # Conditionally ensure Sphinx is installed.
 
-- 
2.41.0


