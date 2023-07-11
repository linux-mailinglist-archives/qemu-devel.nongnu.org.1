Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EBD74F2AB
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 16:50:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJEgL-0001FW-UY; Tue, 11 Jul 2023 10:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJEgJ-0001Ev-Ef
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:49:35 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJEgH-0002mU-L9
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:49:35 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b69f958ef3so92874621fa.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689086971; x=1691678971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3Kb8EGzX+FYyoa01i/LLklvXAPWnwahDSy93HfoU3M=;
 b=h7AJPPbAtRR0fgeagkHwflPaWZjBjeBYN1x+wmn5GLEKcc3fCVLLJ3TYvZaJJyzloH
 ROj3hrKTXiCKVoeBKCLHFvC04g3jxXkGdqrgVeTT1CFMVwqI74gGOikLMrOoKZ6zF3Tb
 EpFHs+EeYcnhM2t0JElWavAhqRYHuXLl3Xd1+lpPDn8QBhu5GELDqrbSiuknOEeosJkF
 IXbjDOlJTcVzrcC8N3xJmtU2EZ5ROsNGb0SNDkP9kIVq4Ct23siNaP+IlWFPowWpuARC
 XHn0kCNTE4+ZdNdwFy5tDxVJJEha4GzOsui8fM81qin9NcXnS4chc7nnREBvOP1E1nIK
 mpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689086971; x=1691678971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a3Kb8EGzX+FYyoa01i/LLklvXAPWnwahDSy93HfoU3M=;
 b=eSnYJLLtT4isUswcp5s77FPYHz6LPV6fbHqIWR2MQ9WfpXs60RlpxogS1+72OxN72A
 egZG9u9C5RQ9rWZx3+2caKOd9zWgvSwEFb/cp2gsxfh0Vp27ooXoG5hSRFV+S5A6sRni
 2ngC9zP+RJzZrHrPDt1D3aHnySR86XpQLEE4L4WSi82vIYLw7lSlDT3BfYL99HISlt0s
 9KJqbPYjp7hpCIxAwM+tpjaqEfFX2+xOJetPIYmNSmgHK0W0ItPbTIr7sMFZUJl5cDVx
 N4lCnYs38YC0J4fCKXjVyjZ9e3y2cc9u1gt+LYygmgxWQgX0QJ81Zp8ca/6gME0ArJ9r
 7rdQ==
X-Gm-Message-State: ABy/qLY0PHX/hqhsrHiXCd2Lv10nz9vt3B2i704dYn7l5rAN240T7Wp0
 nHDp4YIh+Xs35kou0l0/msW2PuUWd57aOrTlVXI=
X-Google-Smtp-Source: APBJJlEWe2n4zLwD3LbXK1gD2JwPKIRqKDLofAiaokd8kzCE7JJdAZ5cGpbyruDpOSzhXHDnvFyxcQ==
X-Received: by 2002:a2e:b04a:0:b0:2b6:d0fc:ee18 with SMTP id
 d10-20020a2eb04a000000b002b6d0fcee18mr11620888ljl.19.1689086971524; 
 Tue, 11 Jul 2023 07:49:31 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a170906830800b009927d4d7a6bsm1260851ejx.53.2023.07.11.07.49.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 07:49:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v3 1/4] tests/lcitool: Generate distribution packages list in
 JSON format
Date: Tue, 11 Jul 2023 16:49:19 +0200
Message-Id: <20230711144922.67491-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230711144922.67491-1-philmd@linaro.org>
References: <20230711144922.67491-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

Add the generate_pkglist() helper to generate a list of packages
required by a distribution to build QEMU.

Since we can not add a "THIS FILE WAS AUTO-GENERATED" comment in
JSON, create the files under tests/vm/generated/ sub-directory;
add a README mentioning the files are generated.

Suggested-by: Erik Skultety <eskultet@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/lcitool/refresh     | 11 +++++++++++
 tests/vm/generated/README |  5 +++++
 2 files changed, 16 insertions(+)
 create mode 100644 tests/vm/generated/README

diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index b54566edcc..4584870ea1 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -84,6 +84,12 @@ def generate_cirrus(target, trailer=None):
     generate(filename, cmd, trailer)
 
 
+def generate_pkglist(vm, target):
+    filename = Path(src_dir, "tests", "vm", "generated", vm + ".json")
+    cmd = lcitool_cmd + ["variables", "--format", "json", target, "qemu"]
+    generate(filename, cmd, None)
+
+
 # Netmap still needs to be manually built as it is yet to be packaged
 # into a distro. We also add cscope and gtags which are used in the CI
 # test
@@ -191,6 +197,11 @@ try:
     generate_cirrus("freebsd-13")
     generate_cirrus("macos-12")
 
+    #
+    # VM packages lists
+    #
+    generate_pkglist("freebsd", "freebsd-13")
+
     sys.exit(0)
 except Exception as ex:
     print(str(ex), file=sys.stderr)
diff --git a/tests/vm/generated/README b/tests/vm/generated/README
new file mode 100644
index 0000000000..7ccc6ffd3d
--- /dev/null
+++ b/tests/vm/generated/README
@@ -0,0 +1,5 @@
+# FILES IN THIS FOLDER WERE AUTO-GENERATED
+#
+#  $ make lcitool-refresh
+#
+# https://gitlab.com/libvirt/libvirt-ci
-- 
2.38.1


