Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E743740056
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:08:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBDw-0000Is-U0; Tue, 27 Jun 2023 12:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDm-0000FK-C6
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:14 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDg-0005A4-JM
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:14 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fba8e2a9ecso6762105e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882027; x=1690474027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrxZa7XFEUbEabq4wBcL7gzCxqp+QvBtMc1otNNsIiU=;
 b=qV/h+v2fw4V5Wrmwe/TeT7Zb0YSfKEr83bF1bApS8qiyYaR6UuEB2KNakZD7I2yJqn
 e9SJ+fbpuKagfZeJbzcxx8k8GxqeSuXWU7WyhddtY9Zy0E+mqsgAPpVYSMvLYfcnLVow
 lIELghh39M00e1UVTST9FIW+++PbrHGiZRgoPQw7jEud/yDvsyi3I+Y0OpUAZnKEf8os
 2dvFe9lddOBZHA4ch4hqpKB5TPbKo+sIBWC02k+8sAgwrH5/2pRKL714f/MY0PQiaShW
 bLrATQf0GRwEUYRq4rKPtOQf2dJprEqmX6h7aMlPNkxj2G+nW45M1i2OcpKD37hSn1Y5
 cN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882027; x=1690474027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrxZa7XFEUbEabq4wBcL7gzCxqp+QvBtMc1otNNsIiU=;
 b=N73ZLG6Rm+dmj4OePXw6DkBYG9v6hp1tcVVTeCGVndH4/I0Q8Qht6sXL+/LDff+4KK
 4PaMYpRQqvc8YtBn8CwkEMCwS8KmkqPLb3Wsw2ERpSmMVoBW9u8zBt2QsS02Wu+o9+qS
 J/WikOLM22eQPa/9A3AAgQ+KNrwlPyFbQARnX9ihdEI3GkvqS4Yt/mzWYYdmOvxCNpEX
 st+EJqO9lR5/VCzj+vdA2xp7BMDdRej0do7ebAurV3Pdn4bQMLP7QfDpFUzfGPdm9THS
 /33Pd13GcLNtUMnry27f+AbKzdEjeXVZ1Knw/kLZ6Yhwa7kk/Y5cEi38dujQCrPZcV36
 +uIw==
X-Gm-Message-State: AC+VfDywLF5faslY1cOhI8X9GWg34E0qKjX8YqAzNi1wP3HYYidBh//l
 JnkQ+qCxMwmxwmpA9DrAmsr0Aw==
X-Google-Smtp-Source: ACHHUZ7H98cGVTfL57wakAdyZKaaL3eP75y6S4E1zBD1CyyYumDhSmFxgHgDD62+3cd+j8B5ofjlVg==
X-Received: by 2002:a7b:c017:0:b0:3f7:aad8:4e05 with SMTP id
 c23-20020a7bc017000000b003f7aad84e05mr26348503wmb.11.1687882027154; 
 Tue, 27 Jun 2023 09:07:07 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z26-20020a1c4c1a000000b003f91e32b1ebsm1868903wmf.17.2023.06.27.09.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:07:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6B6121FFC6;
 Tue, 27 Jun 2023 17:07:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Leonardo Bras <leobras@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bandan Das <bsd@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Juan Quintela <quintela@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v3 14/36] tests/lcitool: introduce qemu-minimal
Date: Tue, 27 Jun 2023 17:06:38 +0100
Message-Id: <20230627160700.2955547-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160700.2955547-1-alex.bennee@linaro.org>
References: <20230627160700.2955547-1-alex.bennee@linaro.org>
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

This is a very bare bones set of dependencies for a minimal build of
QEMU. This will be useful for minimal cross-compile sanity check based
on things like Debian Sid where stuff isn't always in sync.

Message-Id: <20230623122100.1640995-16-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - minor rewording
---
 tests/lcitool/projects/qemu-minimal.yml | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 tests/lcitool/projects/qemu-minimal.yml

diff --git a/tests/lcitool/projects/qemu-minimal.yml b/tests/lcitool/projects/qemu-minimal.yml
new file mode 100644
index 0000000000..b60fec715c
--- /dev/null
+++ b/tests/lcitool/projects/qemu-minimal.yml
@@ -0,0 +1,23 @@
+# Very minimal set of qemu packages, used for minimal cross-compile sanity checks
+---
+packages:
+ - bash
+ - bc
+ - bison
+ - flex
+ - g++
+ - gcc
+ - gcc-native
+ - glib2
+ - glib2-native
+ - glib2-static
+ - libc-static
+ - libfdt
+ - libffi
+ - make
+ - meson
+ - ninja
+ - pixman
+ - pkg-config
+ - python3
+ - python3-venv
-- 
2.39.2


