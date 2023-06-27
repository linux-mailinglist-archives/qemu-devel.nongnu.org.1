Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2150474007F
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:12:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBGV-0000N0-Rf; Tue, 27 Jun 2023 12:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGQ-00005I-FH
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGK-0005pe-K1
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:58 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fa99f6a4a1so23895565e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882190; x=1690474190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrxZa7XFEUbEabq4wBcL7gzCxqp+QvBtMc1otNNsIiU=;
 b=rEcvdMIKVD3+c9CuHBOrBYBoq0anuNfXBfzbv2q3r9FpbASKmS8ITnh53TmiFYCdqU
 fMc9Fe85bh7wl5z6J5lFpakelGDpTiUm5qSpxQ+w7pwLibzOiJzGwaysFH981TVwDmuu
 TZZDdUcwZQosMFSO14TSQsAahxQmTYTK/aAHrTPSoFR3xJEYxMHymewlDOWqJhXAGLEf
 m8MuQfwzByiT1SlBbjJgDGkYQ/O3tgubY1NPhHz7ywTvgZc3pyD5528dZao0K2rTckhm
 kd5GwEa4KbN78k0u19Z6/evDG5amvm3d2qlffjDqWZKgd4c8znKmJ2snBRT7lNZK4qtA
 mGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882190; x=1690474190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrxZa7XFEUbEabq4wBcL7gzCxqp+QvBtMc1otNNsIiU=;
 b=Zp6RdAfCIRKyTaRtUoN+JZpSpjk/0BDAUlbWhJbYEK4OlxDKM8mfBfnevOYwcktTWs
 MogNtthEVm55FoLES5CLxKrFTrmU3uHIczvAeMko44Z2vCEBpx4vaIYZoz18nXX13fkN
 pLsOT9oPXszhDI7nTSf/TFfqD6EvrZUNM8oQfWvQu5P+p5+o7nveHw/FSwf1vXY6H736
 sEJYL/Kx+etM7E7YiLFpkR/Bw6YPLTDdaU0kwYqGSszWGwSWnZi6UCoHpmprV1Aj5Qwo
 s1m+lYqLFAoHGnURDXub52njMUlCbtlr9PUE/+LXq3PIS3mufOs2tt9yds9lHYNvsD+c
 uZsw==
X-Gm-Message-State: AC+VfDxBbkLaLB/L+bKUKNNtp1vI4u8+GKHec03QHPPQeKrTqIDVkVUE
 FGazDmUhZsbmZGQILwErlQvoHA==
X-Google-Smtp-Source: ACHHUZ6vURMegkNUu5RlT7u/WsOwilHRY+Novs9f2KR8hNdjlfct5Yp/knaoW4d/cs4s5xFIcIZwyg==
X-Received: by 2002:a7b:c392:0:b0:3fa:8fb1:50fe with SMTP id
 s18-20020a7bc392000000b003fa8fb150femr5676627wmj.15.1687882190595; 
 Tue, 27 Jun 2023 09:09:50 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a05600c204900b003f93c450657sm11187352wmg.38.2023.06.27.09.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:09:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 87DA21FFBF;
 Tue, 27 Jun 2023 17:09:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 14/36] tests/lcitool: introduce qemu-minimal
Date: Tue, 27 Jun 2023 17:09:21 +0100
Message-Id: <20230627160943.2956928-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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


