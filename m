Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 697837F16F0
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:14:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55tZ-0005vP-1S; Mon, 20 Nov 2023 10:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tA-0005jt-Gy
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:41 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55t6-0001BY-Tt
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:40 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32fdc5be26dso2925261f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492915; x=1701097715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWoiSiUm6iXSwHJIP4SnJtrzbg+5jh5ZVQXK2gBfc2c=;
 b=Hhcoy52llRt77nbZatzm5xotx6YpUx+At3GgXWAa5UEcgruEAkFL96RO9UoozHDSOD
 0b+v9mp1VZoNY/oHziClI0tlftCBcz/dheLPXelR1QcYzip+Y0gLUpIBmmYo6gNt3L+f
 VU/POFbUAvx0pcDMb8FzVVgJufs6cguGZY5lQ1Gtvr5rKv/jubpGsuG1VPsuhILbeWv3
 euyY4IKLNkZXdGEWRSgRkNVMEKe1Nc0EKdNcNxZEEzSL64PHz30DyRzatp/eS/t4wxup
 t8XkCN2A0lvlohFbCOZe1BeaTvtzUCJEnvuW9vgBduLOaeIzKn99PkA8UPVY112gu/l3
 4vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492915; x=1701097715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YWoiSiUm6iXSwHJIP4SnJtrzbg+5jh5ZVQXK2gBfc2c=;
 b=VKrNZZvhTVBLk+c8RbXb93tehUzZiacT5zfZ2/Sz+ERATQ61OjCPOpbsQVnZGAmc2j
 jNxran7jlkkQRTwSGnvlAOCW+xi45di/Lq55A2NYHOpAOKkRIU7SihyD0BJD6yHhoB5h
 9hs/W0T2D/8/y6jG2M49vKj5OcDuYDZo0BrJ3pFi7QaZjsCPM+vZPFnbU8mWgruiRuGW
 e7nQcs9TangEpDPS16J45bAzUjgE3Ls7eRq4TkZYKB2pq/gViqSdx+1kHplCFhZNWg2g
 KY5EtDeO4rLYX9wG5TPs9lPeI7jqqjwkqmTKs9w4FO8P7Wiz5e5FT3k2GFOEn1REZynZ
 ZIIA==
X-Gm-Message-State: AOJu0YybAK4rtT7Bcny1CTu+lPTrtrLW1vZk9cpom+yDVZT9ICOoRvu+
 ACHK6eSr+k7tljwIvGhSVVW5Cw==
X-Google-Smtp-Source: AGHT+IFLQr75NfFO9Sc81yES5PFhgTMfQo65fgZQhT5bo6ze2BaCw53TtNa9W/9Eddr7MJYhJ4LovA==
X-Received: by 2002:a5d:5cd1:0:b0:32d:9df1:6f68 with SMTP id
 cg17-20020a5d5cd1000000b0032d9df16f68mr4667230wrb.22.1700492915183; 
 Mon, 20 Nov 2023 07:08:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f3-20020a056000036300b003316ddedb6esm9699177wrf.22.2023.11.20.07.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 07:08:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2EFE565752;
 Mon, 20 Nov 2023 15:08:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 02/14] .gitlab-ci.d/cirrus: Upgrade macOS to 13 (Ventura)
Date: Mon, 20 Nov 2023 15:08:21 +0000
Message-Id: <20231120150833.2552739-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120150833.2552739-1-alex.bennee@linaro.org>
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

macOS 14 "Sonoma" was released on September 2023 [1].

According to QEMU's support policy, we stop supporting the
previous major release two years after the the new major
release has been published. Replace the macOS 12 (Monterey)
testing by macOS 13 (Ventura, released on October 2022, [2]).

Refresh the generated files by running:

  $ make lcitool-refresh

[1] https://www.apple.com/newsroom/2023/09/macos-sonoma-is-available-today/
[2] https://www.apple.com/newsroom/2022/10/macos-ventura-is-now-available/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20231108162022.76189-1-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/cirrus.yml                              | 6 +++---
 .gitlab-ci.d/cirrus/{macos-12.vars => macos-13.vars} | 2 +-
 tests/lcitool/refresh                                | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename .gitlab-ci.d/cirrus/{macos-12.vars => macos-13.vars} (95%)

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index e7f1f83c2c..07dc6edae1 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -59,13 +59,13 @@ x64-freebsd-13-build:
     INSTALL_COMMAND: pkg install -y
     TEST_TARGETS: check
 
-aarch64-macos-12-base-build:
+aarch64-macos-13-base-build:
   extends: .cirrus_build_job
   variables:
-    NAME: macos-12
+    NAME: macos-13
     CIRRUS_VM_INSTANCE_TYPE: macos_instance
     CIRRUS_VM_IMAGE_SELECTOR: image
-    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-monterey-base:latest
+    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-ventura-base:latest
     CIRRUS_VM_CPUS: 12
     CIRRUS_VM_RAM: 24G
     UPDATE_COMMAND: brew update
diff --git a/.gitlab-ci.d/cirrus/macos-12.vars b/.gitlab-ci.d/cirrus/macos-13.vars
similarity index 95%
rename from .gitlab-ci.d/cirrus/macos-12.vars
rename to .gitlab-ci.d/cirrus/macos-13.vars
index 5f3fb346d1..534f029956 100644
--- a/.gitlab-ci.d/cirrus/macos-12.vars
+++ b/.gitlab-ci.d/cirrus/macos-13.vars
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool variables macos-12 qemu
+#  $ lcitool variables macos-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 10c54a377c..7c211eba2e 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -203,7 +203,7 @@ try:
     # Cirrus packages lists for GitLab
     #
     generate_cirrus("freebsd-13")
-    generate_cirrus("macos-12")
+    generate_cirrus("macos-13")
 
     #
     # VM packages lists
-- 
2.39.2


