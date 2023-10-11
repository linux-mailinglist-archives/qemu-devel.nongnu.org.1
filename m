Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 713837C503B
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:34:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWXK-0001ZQ-Sx; Wed, 11 Oct 2023 06:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX6-0001Kx-IE
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:41 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX4-0005DA-BS
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40651a72807so64230715e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697020415; x=1697625215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=knFp3LFINV+DnPYFBJemRPHvlmKP+IRj/bDUqX8B+FM=;
 b=j7NCSXdaSX33SewiQGSxXHf3gH1iK9b5xmsmluSswS2zUz5dSd/jAXZkxqThG0KLZ4
 2UK3pbisK8h19F/0QVJlJkCaLlbRR0u3ADBJkg/e7AV1a1oyIntXp/0aIeiqLW1TFJyt
 y9hYul4rTMk7XSAtIqwX+sCBGa6ZOPBrC2yeOJvGDNgNwLPAEgsuKNQ0Fm0APeKOIP/e
 mjbX5iZe48SevJqTz70YoOLp3zmTnSmVTrAH1IEM0wR8ca8PIKMidk4bSqeVoYX6ZpFe
 aLrjZXtV2fb2Z5Vv4mWItbdy1wWPvmFehzfaENRMIyZqw/iHSzMCxYXUzUChOAkaivum
 FOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697020415; x=1697625215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=knFp3LFINV+DnPYFBJemRPHvlmKP+IRj/bDUqX8B+FM=;
 b=AecgAML/ox5H8dVpzdR8hJR5jrIN+CYYGjgLIRfazmL1oNDgF6LgkHQ3D2ka9ujyQC
 +svARSaO9yrN7JpWav4/cnji1gBcjZpQTDJAhDa0CuDA2r9amdLtz+5NVDLTPp6TUkE7
 VYh3Q9xMJ9XmWUQGCZyaqu7oIufLHlNLu+3h4bSjLRjKRFzCLgsA8c2EkRQvhQI1H3ko
 KBeAOcYRT8HVE9afTDUWiAqucftfnzf1hsmpNBhzGkoTOrDVW97vRrOD1z3hYb5wJsHl
 T2A6os9R9kk1lZwnK2pN+RyPbSJbfRwXZsWDht3wehF07bxz8JPumewRm3FG/zSznCrT
 fj5g==
X-Gm-Message-State: AOJu0Yz7Uoq9WbfkiqrxYVEF0G6MXdLXFyFO2W0D5PQ9Fl4Nry/ityo0
 XwBvLR08rMZAGT5yvDnTucEX6A==
X-Google-Smtp-Source: AGHT+IE05LgAF7qJTdU+U17qtCngRR2ascteGNgpVItdD2nMthXkW2hc6429wEmREi7PUCv3nmCTWQ==
X-Received: by 2002:a05:600c:214f:b0:405:4002:825a with SMTP id
 v15-20020a05600c214f00b004054002825amr17839437wml.13.1697020415526; 
 Wed, 11 Oct 2023 03:33:35 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x2-20020a1c7c02000000b003fe23b10fdfsm18592230wmc.36.2023.10.11.03.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:33:32 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D05511FFC1;
 Wed, 11 Oct 2023 11:33:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 06/25] configure: allow user to override docker engine
Date: Wed, 11 Oct 2023 11:33:10 +0100
Message-Id: <20231011103329.670525-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20231009164104.369749-7-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 1f26639e4f..5c04e63bab 100755
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


