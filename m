Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 778727BE6D9
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 18:45:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qptM7-0001W2-SY; Mon, 09 Oct 2023 12:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qptK4-0005OQ-2D
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:41:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qptJf-0001WN-5y
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:41:30 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32487efc319so4553146f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696869670; x=1697474470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDyM/F5z2PX4t5z6swT9o+aFYE3lKyvYgeKJZjudJGU=;
 b=KVQF/6OJtZAecL7Rj9FJcNABY7chR/mxJjK+dGdtIo0/03mTQADhHPyjiJGYdhXJgg
 pX+r2v2Z8GYmszKqIi44bOHSFBSjCFPe8yEk+v+gS3SRujX4TpQEnTIU6mnfJpaHicw9
 U5f/ObeP+5fylPdSLGNVoHstdQNuvTdgaqw9qFm4Az7zyUgeD4Cf8Rkvi85Lg3oB/2it
 OEvBn/AzWmNCflgMe8bGLPxptazUF3oL8J09RZB0laaTFFkJoRajPanRSqBLembdEooJ
 WOdLm5wSTbxNqmctCr7AA4Y9rbOUn1nXEsJvd+3OmSnG7GPIE2xWG9BGC+VBsstTbwfn
 a88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696869670; x=1697474470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDyM/F5z2PX4t5z6swT9o+aFYE3lKyvYgeKJZjudJGU=;
 b=Z6O+A14KFp07G1CRRABWBOI7SFw7WKEmsuvg6LYsORFc0jrcJPGNA+OFYHUEW8Spo3
 yI0bc0aPFSJd+EPxqPgfmOrqNEsvZXF5j1t9Mmhc0MwST09Yi3QagiFIV4y+WL8YSU0a
 EMNjASzeQd5jd2wlc2+oEINHeHb9iIYPKsinoW+CObSbt9zIKY0iFv+DgOHejsD9p9lj
 1x86TO8FttOHK1pMQ4TFyd7f5ftVYJdxkij+ME9UuwLuLmovwebr7ix0H9miE2Cd+wTR
 Kp2OPk32HewUeFnxXHvdXmcJUtmyaMv3v3ipKuo9lu7ZmAKwNV0LWc59hOD8b41cFt5h
 oFeA==
X-Gm-Message-State: AOJu0YwuzmQDd40v5Kb61niXhqysgA9jS7efKGWP4xzdmPvkGroMtK08
 5YyKgQerlDcAfs9MvV3se1TNoQ==
X-Google-Smtp-Source: AGHT+IFbzMb9dBVLvXKeQVvKU1l2iZlF5Ezmak2MWAKzXM+bLqo+Drt1j9SVzaXM9FIi8STfjf/nKA==
X-Received: by 2002:adf:f845:0:b0:31f:e74d:c82a with SMTP id
 d5-20020adff845000000b0031fe74dc82amr13985515wrq.31.1696869669785; 
 Mon, 09 Oct 2023 09:41:09 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a5d534b000000b003232380ffd5sm10071994wrv.106.2023.10.09.09.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 09:41:07 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D6C7A1FFC1;
 Mon,  9 Oct 2023 17:41:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Brad Smith <brad@comstyle.com>, Radoslaw Biernacki <rad@semihalf.com>,
 David Hildenbrand <david@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Nicholas Piggin <npiggin@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/25] configure: allow user to override docker engine
Date: Mon,  9 Oct 2023 17:40:45 +0100
Message-Id: <20231009164104.369749-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009164104.369749-1-alex.bennee@linaro.org>
References: <20231009164104.369749-1-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If you have both engines installed but one is broken you are stuck
with the automagic. Allow the user to override the engine for this
case.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 707132a3ae..ebad155d9e 100755
--- a/configure
+++ b/configure
@@ -180,6 +180,7 @@ fi
 # some defaults, based on the host environment
 
 # default parameters
+container_engine="auto"
 cpu=""
 cross_compile="no"
 cross_prefix=""
@@ -787,6 +788,8 @@ for opt do
   ;;
   --disable-containers) use_containers="no"
   ;;
+  --container-engine=*) container_engine="$optarg"
+  ;;
   --gdb=*) gdb_bin="$optarg"
   ;;
   # everything else has the same name in configure and meson
@@ -921,6 +924,7 @@ Advanced options (experts only):
   --enable-plugins
                            enable plugins via shared library loading
   --disable-containers     don't use containers for cross-building
+  --container-engine=TYPE  which container engine to use [$container_engine]
   --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
 EOF
   meson_options_help
@@ -1195,14 +1199,14 @@ fi
 container="no"
 runc=""
 if test $use_containers = "yes" && (has "docker" || has "podman"); then
-    case $($python "$source_path"/tests/docker/docker.py probe) in
+    case $($python "$source_path"/tests/docker/docker.py --engine "$container_engine" probe) in
         *docker) container=docker ;;
         podman) container=podman ;;
         no) container=no ;;
     esac
     if test "$container" != "no"; then
         docker_py="$python $source_path/tests/docker/docker.py --engine $container"
-        runc=$($python "$source_path"/tests/docker/docker.py probe)
+        runc=$container
     fi
 fi
 
-- 
2.39.2


