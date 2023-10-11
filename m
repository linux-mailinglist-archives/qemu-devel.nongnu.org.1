Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 960407C5049
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:36:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWXG-0001Wm-I1; Wed, 11 Oct 2023 06:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX5-0001KQ-1t
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:41 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX0-0005Ak-IX
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-406618d0992so64284585e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697020413; x=1697625213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gONP7pJxs9GGiNZgo4EWoYPfXNPiQDYcL6QIKvi4tFo=;
 b=Oz5XCvd4GLEFMxSYySdfnY8/RcZ+BerRGkvInGqcraJDGDfWiwaAWG1AyaxsBauAp+
 cIVd5liYKwEsRNjRQFwROHG8i0MK62rrRrcA9ObLHVoVta46lsNBqWlz5xSOEOsptKAc
 0JTfK8RFv8UYj7l6OQoObtnpj7jBk+Rnb//IdLhoDBVL9JiVh8NxI8/yzi5w3nsuQDhI
 JmiFLqAXGP9XjP+6uKrOQaEWf3EwS4LQZ/E0D1IXJjIRtM3M4wZzvoMS6HskYDCuxu+m
 CsNeEgoPcsqQ8EmisEQbyyiwIWej/l45dfBkj1oxrFYKQvcVYv21sxHLLSSATYYo59YA
 E/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697020413; x=1697625213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gONP7pJxs9GGiNZgo4EWoYPfXNPiQDYcL6QIKvi4tFo=;
 b=f/zXJ/vhxGLrkF/c3XhyM6GFcA06IlLcIi2nq313axnk+E+QuH9OsPUqipdTUxddF+
 oOsipVmY/JK6RDNb+OJqE2mXlBri2j/Xvl+od37ycNY+p1oNawUDHB4lYD7Qzl72JQ6X
 aBK5IIPw1OZFM7vXRjOTIR4uIAIDo8gTnFfzLMz/TtynQzog8bVJVkJqDsEU/j1v/v1+
 lM8A7b20oz+I62aTtl9DnsBCx+W3EeksGE7maLSHCQIEx71AI8Rjt2au/DvF6je94lTE
 MwwMfWPltYDg/1j2Hv9e+JCb3ZhU4JWuARp+cyWjSyiVsCHvtFCKQ3etm+acx8EGYKXC
 428A==
X-Gm-Message-State: AOJu0YyFSMfL8H8siCSBEWPYOHlZPipVInt1bBPvuwJquMApnaP1WBUT
 hWYVFcg644p2BVY5mjyhKZ9bYA==
X-Google-Smtp-Source: AGHT+IF8F1ehKk9bBfUYWVz7BJa2gTXeXfIcpciTHESWvFmAbkO9942urfy5SYkF9OEoihjxaQ8X3g==
X-Received: by 2002:a05:6000:114d:b0:323:37a8:d085 with SMTP id
 d13-20020a056000114d00b0032337a8d085mr17367577wrx.58.1697020412974; 
 Wed, 11 Oct 2023 03:33:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a5d6b0b000000b00324853fc8adsm14993219wrw.104.2023.10.11.03.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:33:32 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B95601FFC0;
 Wed, 11 Oct 2023 11:33:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 05/25] tests/docker: make docker engine choice entirely
 configure driven
Date: Wed, 11 Oct 2023 11:33:09 +0100
Message-Id: <20231011103329.670525-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Since 0b1a649047 (tests/docker: use direct RUNC call to build
containers) we ended up with the potential for the remaining docker.py
script calls to deviate from the direct RUNC calls. Fix this by
dropping the use of ENGINE in the makefile and rely entirely on what
we detect at configure time.

We also tweak the RUNC detection so podman users can still run things
from the source tree.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20231009164104.369749-6-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 97a5e8de49..1f26639e4f 100755
--- a/configure
+++ b/configure
@@ -1694,7 +1694,6 @@ if test -n "$gdb_bin"; then
 fi
 
 if test "$container" != no; then
-    echo "ENGINE=$container" >> $config_host_mak
     echo "RUNC=$runc" >> $config_host_mak
 fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index dfabafab92..ab68b2dbad 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -16,9 +16,8 @@ DOCKER_DEFAULT_REGISTRY := registry.gitlab.com/qemu-project/qemu
 endif
 DOCKER_REGISTRY := $(if $(REGISTRY),$(REGISTRY),$(DOCKER_DEFAULT_REGISTRY))
 
-RUNC ?= docker
-ENGINE ?= auto
-DOCKER_SCRIPT=$(SRC_PATH)/tests/docker/docker.py --engine $(ENGINE)
+RUNC ?= $(if $(shell command -v docker), docker, podman)
+DOCKER_SCRIPT=$(SRC_PATH)/tests/docker/docker.py --engine $(RUNC)
 
 CUR_TIME := $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
 DOCKER_SRC_COPY := $(BUILD_DIR)/docker-src.$(CUR_TIME)
@@ -158,7 +157,7 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)), \
 )
 
 docker:
-	@echo 'Build QEMU and run tests inside Docker or Podman containers'
+	@echo 'Build QEMU and run tests inside $(RUNC) containers'
 	@echo
 	@echo 'Available targets:'
 	@echo
@@ -198,8 +197,6 @@ docker:
 	@echo '    EXECUTABLE=<path>    Include executable in image.'
 	@echo '    EXTRA_FILES="<path> [... <path>]"'
 	@echo '                         Include extra files in image.'
-	@echo '    ENGINE=auto/docker/podman'
-	@echo '                         Specify which container engine to run.'
 	@echo '    REGISTRY=url         Cache builds from registry (default:$(DOCKER_REGISTRY))'
 
 docker-help: docker
-- 
2.39.2


