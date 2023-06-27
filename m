Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C210F74007C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:11:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBE5-0000K7-4j; Tue, 27 Jun 2023 12:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDl-0000CJ-3z
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:13 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDf-00059J-D8
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:12 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-313f58d6652so2161098f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882026; x=1690474026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DudiICXjsv3m9urKUi2tH2RtAEiqXNFzr67H4vIREuA=;
 b=Zj9BiacGSsQbUoy+1hmbtgTv9C6XKYE4VM6iM4uWgXdyGb3nB2cvVe5Z3NxMJeYu0O
 j8ub5SRHTZDJG8b++4ah6Y7fM0ytkEt5INo2qDMyyG4RapGRQWFHba3s6ngZjerAKTQl
 6kIn+CXII+FjuwsD7w6GkQdUvBNMPA0WHqGm1KQhVrrnhI57QW1XoFkONfFWUHC9/fw8
 T5MFChQM2hRnY1e+oMeggVi8VHCAAPue6eODYN3fvz02tSDURf+bB36mDRJl9W/fd6F+
 qtEbHvV7mFFHLIvpY4cNhCuySVhkXPDbeyc6/gYufotX0Jn3tywrLRJLtzoMYFn+X+vp
 G+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882026; x=1690474026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DudiICXjsv3m9urKUi2tH2RtAEiqXNFzr67H4vIREuA=;
 b=BEkXXteTCvvdosvbtUBQV1NQADBBnwKbUbvtpn+rRMjEA9/Mf1NYJt5j1Xv2UI6PDL
 42XEgxpSy9Nx9nAsrlG5teYR4Z+Pkh377wrnemU+iWJJ4c8BUZ/OCt6/1ROMbiXGTr0o
 zN5pLD53TtYkGTyTOMh8FWjGxZGHCIQ2nsIbpQotIPeQ1q3AWg8tjO4GelMp/PD5QXyH
 DxsxYbWQNkmTx3Trqko3mogqPgQp8DxMgbk317rD8q2KRWH0eIRB7Wp408IoNDlX2Dnr
 uqlA5FWLOol4bpFUit9EZRpk/oSwNddiDaxVlCwOhnLudOhIvLjwCUkbGoggOujJPA6h
 bJ4w==
X-Gm-Message-State: AC+VfDxt1GU/aCdoNb1X2WLw/C5Rb2WwahW8ZTFkZRzfu6En9Uv/B7U6
 /rssvt/dvJo8aJVhZOyc9ff8Kwo4GHXcfyISFrQ=
X-Google-Smtp-Source: ACHHUZ6NJEbj4Pavd9euPADNqICWcK0q3NsEZbWjG22vAT/ec1GFXvHnIQOag8RZ9qGkOYLoKajc9Q==
X-Received: by 2002:a05:6000:1202:b0:313:eadf:b82d with SMTP id
 e2-20020a056000120200b00313eadfb82dmr6383791wrx.69.1687882026087; 
 Tue, 27 Jun 2023 09:07:06 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 21-20020a05600c22d500b003f9cb3c8958sm14296534wmg.3.2023.06.27.09.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:07:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 20F731FFC5;
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
 Alexander Bulekov <alxndr@bu.edu>, Erik Skultety <eskultet@redhat.com>
Subject: [PATCH v3 12/36] tests/lcitool: Bump fedora container versions
Date: Tue, 27 Jun 2023 17:06:36 +0100
Message-Id: <20230627160700.2955547-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160700.2955547-1-alex.bennee@linaro.org>
References: <20230627160700.2955547-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

From: Erik Skultety <eskultet@redhat.com>

Fedora 37 -> 38

Signed-off-by: Erik Skultety <eskultet@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230623122100.1640995-14-alex.bennee@linaro.org>
Message-Id: <c9b00e573a7a80fc6ce5c68595382f5c916a9195.1685528076.git.eskultet@redhat.com>
[AJB: Dropped alpine (in prev commit), reflow commit msg]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/fedora-win32-cross.docker | 4 ++--
 tests/docker/dockerfiles/fedora-win64-cross.docker | 4 ++--
 tests/docker/dockerfiles/fedora.docker             | 4 ++--
 tests/lcitool/refresh                              | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora-win32-cross.docker b/tests/docker/dockerfiles/fedora-win32-cross.docker
index dc72ae9cc9..a0a3cd9e5b 100644
--- a/tests/docker/dockerfiles/fedora-win32-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win32-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross mingw32 fedora-37 qemu
+#  $ lcitool dockerfile --layers all --cross mingw32 fedora-38 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:37
+FROM registry.fedoraproject.org/fedora:38
 
 RUN dnf install -y nosync && \
     printf '#!/bin/sh\n\
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 7eb4a5dba2..b6c1a6a339 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross mingw64 fedora-37 qemu
+#  $ lcitool dockerfile --layers all --cross mingw64 fedora-38 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:37
+FROM registry.fedoraproject.org/fedora:38
 
 RUN dnf install -y nosync && \
     printf '#!/bin/sh\n\
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 3a69eefdda..8a35a17617 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all fedora-37 qemu
+#  $ lcitool dockerfile --layers all fedora-38 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:37
+FROM registry.fedoraproject.org/fedora:38
 
 RUN dnf install -y nosync && \
     printf '#!/bin/sh\n\
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 5d36a62b10..5e06fb2cf5 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -119,7 +119,7 @@ try:
     generate_dockerfile("centos8", "centos-stream-8")
     generate_dockerfile("debian-amd64", "debian-11",
                         trailer="".join(debian11_extras))
-    generate_dockerfile("fedora", "fedora-37")
+    generate_dockerfile("fedora", "fedora-38")
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
     generate_dockerfile("ubuntu2004", "ubuntu-2004")
     generate_dockerfile("ubuntu2204", "ubuntu-2204")
@@ -169,12 +169,12 @@ try:
                         trailer=cross_build("s390x-linux-gnu-",
                                             "s390x-softmmu,s390x-linux-user"))
 
-    generate_dockerfile("fedora-win32-cross", "fedora-37",
+    generate_dockerfile("fedora-win32-cross", "fedora-38",
                         cross="mingw32",
                         trailer=cross_build("i686-w64-mingw32-",
                                             "i386-softmmu"))
 
-    generate_dockerfile("fedora-win64-cross", "fedora-37",
+    generate_dockerfile("fedora-win64-cross", "fedora-38",
                         cross="mingw64",
                         trailer=cross_build("x86_64-w64-mingw32-",
                                             "x86_64-softmmu"))
-- 
2.39.2


