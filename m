Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9F0823355
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:35:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL58D-0003eY-NL; Wed, 03 Jan 2024 12:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL586-0003Xh-Cn
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:34:11 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL57s-0002Ph-O5
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:34:10 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40d87ecf579so29154995e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704303234; x=1704908034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1cgT7e6lhcwn0WzM/v6sP8+3M2uDQNBjem+V+EXl+Sc=;
 b=t8zTw1ZBsXS8uWS7GqilvMx62gMAQ+8G+C37YzNdWczxpbjfn1aYmGOfnfN8rDU8//
 pqlD7V91/i8WmuzyBr/VlJEmPebH/6KcyA/mF1CS1bMwKft8fQ3rirKF9uUEXVPODbYH
 L0PWzcHlytY5a8sOz6l79Di1lsTUk7XG9cEPY2SH7d/Eh+XGLUqQZ8tsz3HV6ZwmL4qf
 dacV7Uk8zBtUOCZKga9pBp55+7eNQ88NNUu/D+I2TQ7RbV0zuq3WSlF8oIf4ew0VeBbT
 LLAt+U/v6ERGEAuo6sA27SDHCSkzPolfp8iD0q3/dK0kYfCQPHMKVNS0T+nzO1oIMULt
 H0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303234; x=1704908034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1cgT7e6lhcwn0WzM/v6sP8+3M2uDQNBjem+V+EXl+Sc=;
 b=v4qfqhsQNoYN/zYKu82a0C4/zpilt0ak26nga/ethI/o09H8DLNkiouGE7yz94c+M8
 tVjiP3wht62+aF0Gh8Nn8/FUjB81wdzAbE0fhOyPOpzTy1vqQ6GNf69cUgMyCWB8oOQ4
 v6OBwkY2CIOH48Ymo8bjzeSRfVy7qG/Yq4uaC4EBPVvAhHpRNWpBprHiq5l/txb8VuQR
 +tGrD5yd5tTiHQ5AaXHGwUVwicqPkd2dYQLDs+82EoROg15HLURTTeFjglEC78EUPGWf
 WLnP/YDfeRJ2XAsj3VspOoAMYuf5U5qpwqAiTjj4mMnnOyJe/omaMyU0Pb2NMP6Lxzl/
 iB1Q==
X-Gm-Message-State: AOJu0YwOWWDz//KtayeoBiHD6vvasSByOtqH93WafKI7F68F5tpQ/RYB
 jg00ryid3DOGNpiQwONYvu0H4QGP2hVaLg==
X-Google-Smtp-Source: AGHT+IGkwXIQRawekDSFyRyWEKfYmmSXmGibqTrySkN7welWZBSJP4sDdxZro5vRiKtYsxi4fgV1RA==
X-Received: by 2002:a7b:cb8d:0:b0:40d:8501:276e with SMTP id
 m13-20020a7bcb8d000000b0040d8501276emr2069593wmi.130.1704303234402; 
 Wed, 03 Jan 2024 09:33:54 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g18-20020a05600c311200b0040d85a1fad9sm2964211wmo.46.2024.01.03.09.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:33:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C17AE5F936;
 Wed,  3 Jan 2024 17:33:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <lvivier@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, David Woodhouse <dwmw2@infradead.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, Paul Durrant <paul@xen.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 05/43] qtest: bump min meson timeout to 60 seconds
Date: Wed,  3 Jan 2024 17:33:11 +0000
Message-Id: <20240103173349.398526-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103173349.398526-1-alex.bennee@linaro.org>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Even some of the relatively fast qtests can sometimes hit the 30 second
timeout in GitLab CI under high parallelism/load conditions. Bump the
min to 60 seconds to give a higher margin for reliability.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20230717182859.707658-2-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-2-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/meson.build | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 47dabf91d04..366872ed57b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,12 +1,7 @@
 slow_qtests = {
-  'ahci-test' : 60,
   'bios-tables-test' : 120,
-  'boot-serial-test' : 60,
   'migration-test' : 150,
   'npcm7xx_pwm-test': 150,
-  'prom-env-test' : 60,
-  'pxe-test' : 60,
-  'qos-test' : 60,
   'qom-test' : 300,
   'test-hmp' : 120,
 }
@@ -383,8 +378,8 @@ foreach dir : target_dirs
          env: qtest_env,
          args: ['--tap', '-k'],
          protocol: 'tap',
-         timeout: slow_qtests.get(test, 30),
-         priority: slow_qtests.get(test, 30),
+         timeout: slow_qtests.get(test, 60),
+         priority: slow_qtests.get(test, 60),
          suite: ['qtest', 'qtest-' + target_base])
   endforeach
 endforeach
-- 
2.39.2


