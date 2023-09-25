Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A05157ADAA0
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:52:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmtp-0001Xs-I9; Mon, 25 Sep 2023 10:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkmtg-0001Cw-VY
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:49:17 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkmtQ-0008FV-OM
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:49:15 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-405417465aaso54028345e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695653337; x=1696258137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDyM/F5z2PX4t5z6swT9o+aFYE3lKyvYgeKJZjudJGU=;
 b=cCNg6Q0qhqTAXvA+V86/0R0uu7KraCgNMGFtz2jlCgoxV+Vjl/G/ThAChc4Qi2KUOD
 9grxTxk5RwsVzNl6abwc+bBWtOTP6aTry4fpQPuYaafUo97fbO1xB6G4+7DYoCznnGcR
 M7BR2PTSEJlq3tqOS2mDTq48/zvQsVJbAc2dy4uqDRlfe+QQb/D2nucHrX46s+XzQQxT
 pswFbA44bp7GnY3Ab9BUw9Y+lRE7yOaf2rZSPvNNecRuBsa70lPMITpOL2DwHQKtx17i
 oa38ETV4HFFdVqnoUlchIFRo5GUCBphSgV/XKNrCx7Lva+Q5NqRPvnHT3/Qiq257ihfj
 PdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653337; x=1696258137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDyM/F5z2PX4t5z6swT9o+aFYE3lKyvYgeKJZjudJGU=;
 b=h1XF4XN6AKOBxChTxQuAJNpsmt87j3ykQavnwTVMMRd1kTazRGlWZGeNh7kDsIOkSi
 B20Gz2923QHbigjcwxirraYIbf0cprC/os/272OcVBQzaQFMpUdr3JaAiFmxOA9DxBV5
 5MkIOEfhVyCxIXf+WB/Rr3YI9QNkU+WjccOhDtumekgWx3BeHHb5QC4lP3/OVstZ2PtT
 HbRw+ijq2Yhgh5HLqT1hUdk6pGKngDxPsJ/b0n/z2Sy7Cr1aYYyG7A2r5yqDUQBa3Kol
 HU65hdgkWMBv2dTwFQq8MO7jbkpLg6cxNUmCuZZ2a5xCMf1sBSOV1edCKMG1sbGhegBO
 znkQ==
X-Gm-Message-State: AOJu0YwmtkNrFi3ZY6yndKYeTmV77oXr0yrHQ5C80lRTEF64/0xQNERw
 txd54vBWqcECOZzpley4rfw+mQ==
X-Google-Smtp-Source: AGHT+IFoUDF3xaSfQcn6ibrc1NNHdt07R94Aer1qgTYlNbBFBvCxtP/nwf9vmP/Kia7l8NcB4i+a8Q==
X-Received: by 2002:adf:fcd0:0:b0:31f:f8c1:f43c with SMTP id
 f16-20020adffcd0000000b0031ff8c1f43cmr6112503wrs.41.1695653337674; 
 Mon, 25 Sep 2023 07:48:57 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a5d608c000000b003179d5aee67sm12080936wrt.94.2023.09.25.07.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:48:57 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C02DE1FFC1;
 Mon, 25 Sep 2023 15:48:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 John Snow <jsnow@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Nicholas Piggin <npiggin@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bin.meng@windriver.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 06/31] configure: allow user to override docker engine
Date: Mon, 25 Sep 2023 15:48:29 +0100
Message-Id: <20230925144854.1872513-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925144854.1872513-1-alex.bennee@linaro.org>
References: <20230925144854.1872513-1-alex.bennee@linaro.org>
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


