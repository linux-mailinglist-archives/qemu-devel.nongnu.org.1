Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C52488D8847
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jun 2024 19:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBse-0007C2-Nl; Mon, 03 Jun 2024 13:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsI-0006zb-U8
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:40 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsF-00008W-1S
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:38 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4213870aafdso15695265e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717437212; x=1718042012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MEDsayo7NSvvEmt4K5zlu3UsH8icNWfLL5qp5044iow=;
 b=nj7sF3JzL0BFceZH0kRhx/XBoBSJq2pG5//Kb+3pbUvo0VYLmCsz00NKVYFXSSUF1M
 eup6zQHjMZwLWAWb3XmcirKteypoLUdbNhoqTmV+rvZHiVAfNQ3oPhnQ8WlYw+krPwqr
 cqjwxHGEHv4dY0EXdWBz9yGLqj2VPCgbS6CI/MwKcF+x6QRpSE6AjWUvMl14ZTwM0h3r
 t8uiNBTGxS+UZtWaHGHDbP2eitbefhbjU8inCPQaHV6/PQamrc4nYpd4xePaVo7tiZZ3
 JcGDysM7E/e7sio3FuHqakz73XDtaRyDD2XUsikIO4MZJiawNVHpNlpmhPedGGpwp2sm
 mUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717437212; x=1718042012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MEDsayo7NSvvEmt4K5zlu3UsH8icNWfLL5qp5044iow=;
 b=NJnCf3VjhcxvjsO8qopSlXir0btK3hjtPWbDFNhj8+2qdjVbpnwv0mtLbj+miVjldp
 V9S/DFU2c49JH6oS2f+HMAfaCdOhuPc82RszJUspNKIxzW2jFRBdRVggJCMXt7NhOOWn
 CUgo8vUNn+fx48oxxtW94U09gAak9JeVzlUPcsvKACRPhPzIKdjRIQbvAfbJuKOBhnf7
 gfxPLn2skVInLjTjDhfzXz3BL65RRRxpsDYsa3sWPB8i6Q7QBLvkI3TGSVLq4DiamdQn
 ksEur6b7a6RbztmuP/KbkkdQQxB5JN73oq0oItfzIe0yW2QM+8sKOidA07v9CR5ODp9o
 infg==
X-Gm-Message-State: AOJu0Yw+LBgSPWzWxcIAXEOanSp9+Tt8RCFcy9VcKUppygxDPkIZksQb
 VUKSc7s7QJKF3i8LVHCOVzrz7ue8+eirZW9vg8LewiBXUJvRfY1D662kIb3L/Cs=
X-Google-Smtp-Source: AGHT+IERiTSdG3H7X3KPmYK5n8quAaVjMbWuBd7ihGPz7tNBugwkl5/nbcKxFODqOKlo1KVSfO2XXw==
X-Received: by 2002:a05:600c:190b:b0:41f:e2c5:6618 with SMTP id
 5b1f17b1804b1-4212e0a5330mr81922565e9.32.1717437212379; 
 Mon, 03 Jun 2024 10:53:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b858424sm126070505e9.21.2024.06.03.10.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:53:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DC60B5F9F3;
 Mon,  3 Jun 2024 18:53:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Leif Lindholm <quic_llindhol@quicinc.com>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH v3 04/12] tests/vm: remove plain centos image
Date: Mon,  3 Jun 2024 18:53:20 +0100
Message-Id: <20240603175328.3823123-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603175328.3823123-1-alex.bennee@linaro.org>
References: <20240603175328.3823123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

This isn't really used and we have lighter weight docker containers
for testing this stuff directly.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240521125314.1255403-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240529160934.982373-5-alex.bennee@linaro.org>
---
 tests/vm/Makefile.include |  1 -
 tests/vm/centos           | 51 ---------------------------------------
 2 files changed, 52 deletions(-)
 delete mode 100755 tests/vm/centos

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index ac56824a87..13ed80f72d 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -45,7 +45,6 @@ vm-help vm-test:
 	@echo "  vm-build-netbsd                 - Build QEMU in NetBSD VM"
 	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM"
 ifneq ($(GENISOIMAGE),)
-	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, with Docker"
 ifneq ($(EFI_AARCH64),)
 	@echo "  vm-build-ubuntu.aarch64         - Build QEMU in ubuntu aarch64 VM"
 	@echo "  vm-build-centos.aarch64         - Build QEMU in CentOS aarch64 VM"
diff --git a/tests/vm/centos b/tests/vm/centos
deleted file mode 100755
index d25c8f8b5b..0000000000
--- a/tests/vm/centos
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/usr/bin/env python3
-#
-# CentOS 8 Stream image
-#
-# Copyright 2018, 2022 Red Hat Inc.
-#
-# Authors:
-#  Fam Zheng <famz@redhat.com>
-#
-# This code is licensed under the GPL version 2 or later.  See
-# the COPYING file in the top-level directory.
-#
-
-import os
-import sys
-import subprocess
-import basevm
-import time
-
-class CentosVM(basevm.BaseVM):
-    name = "centos"
-    arch = "x86_64"
-    BUILD_SCRIPT = """
-        set -e;
-        cd $(mktemp -d);
-        export SRC_ARCHIVE=/dev/vdb;
-        sudo chmod a+r $SRC_ARCHIVE;
-        tar -xf $SRC_ARCHIVE;
-        make docker-test-block@centos9 {verbose} J={jobs} NETWORK=1;
-        make docker-test-quick@centos9 {verbose} J={jobs} NETWORK=1;
-    """
-
-    def build_image(self, img):
-        cimg = self._download_with_cache("https://cloud.centos.org/centos/8-stream/x86_64/images/CentOS-Stream-GenericCloud-8-20220125.1.x86_64.qcow2")
-        img_tmp = img + ".tmp"
-        subprocess.check_call(['cp', '-f', cimg, img_tmp])
-        self.exec_qemu_img("resize", img_tmp, "50G")
-        self.boot(img_tmp, extra_args = ["-cdrom", self.gen_cloud_init_iso()])
-        self.wait_ssh()
-        self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
-        self.ssh_root_check("dnf update -y")
-        self.ssh_root_check("dnf install -y dnf-plugins-core")
-        self.ssh_root_check("dnf config-manager --set-enabled powertools")
-        self.ssh_root_check("dnf install -y podman make ninja-build git python3")
-        self.ssh_root("poweroff")
-        self.wait()
-        os.rename(img_tmp, img)
-        return 0
-
-if __name__ == "__main__":
-    sys.exit(basevm.main(CentosVM))
-- 
2.39.2


