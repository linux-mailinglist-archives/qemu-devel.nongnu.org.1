Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 694E1706FF9
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:51:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLEc-0000lW-7b; Wed, 17 May 2023 13:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLE9-0007mn-0X
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLE7-0004Hg-5d
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gagIyj+ohvBxTGckPPYIFm5V3ZHBPriTT/5noq/lqAw=;
 b=KraDh1cfOLqjGrScnzHeW5+Lw+S5uSVJIZon9iETiXw/1cB/OL7DDP4OiBsMc5pzg+Tqia
 pEqVexXV1rvcZpckSzl0Re3hzEgf00b0btNDClKuqVs1P85DslPg2fyZCYKxE9llRoBM5S
 VhhfWhD4EJNX70SxgCO4iiyEfJqymTY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-GCwVbUYuPCKPRHZnCKxdrg-1; Wed, 17 May 2023 13:46:13 -0400
X-MC-Unique: GCwVbUYuPCKPRHZnCKxdrg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f4245ffb03so6963025e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345572; x=1686937572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gagIyj+ohvBxTGckPPYIFm5V3ZHBPriTT/5noq/lqAw=;
 b=ZO5E1KiXGT8qtN0Kof2Lag72LABHz6dzCiz90iuH02bOnqVeRrmVIqbleGGUQe7p/z
 FoAsyL57tHL2bFr0t+0nJCTNyYFIv3u+b7j55inBIv4rZp/aQrVOQm9AOpgQsXYoGtqZ
 D3C8pHKLwqYO68JsQY2HndRJvp9cl7LwzdmWxrjQAeZSXW2hgbejv3DxyyObXSBMc4yz
 aySn4hgNs7B5AngvCGDsxf6jYPvWmWs5o2mN5U7hzvuhBYQ6TIbgbf4Xxni1OrBtKNsl
 Vh7KwYNbUW8rrKEoxx2BUxqvggplABu5YP0RBESSlu7Pp4dBSlmP1knqAMUZUuE+mqXI
 teiA==
X-Gm-Message-State: AC+VfDwuFKR6izaaBaWY16Yr1UC9xZ2dbCKW8fMghPktnG3Ap68E5F9b
 CtpHIl8kmSvsnyxux89BMInF6YuGidl/KQ+OWohNx30mr2eWNSboUM4imv7s9k3DA2UI+sJPw5k
 3c5+oF81Dm75wtVPo37PXDmhZYY0JqoBrr+Xemjc/LeCxiQpMrbaE4st2cNV4Th9QC6HLnVq2Qc
 c=
X-Received: by 2002:a05:600c:b4d:b0:3f4:253f:c3d9 with SMTP id
 k13-20020a05600c0b4d00b003f4253fc3d9mr22313250wmr.25.1684345571780; 
 Wed, 17 May 2023 10:46:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Ud8wd/NgkrqMF7GGJXFch6Ul9+xLqTnzu9pAxGOtlLs3G3hx3QOt1D7yY/jXZkQgqxDUQuQ==
X-Received: by 2002:a05:600c:b4d:b0:3f4:253f:c3d9 with SMTP id
 k13-20020a05600c0b4d00b003f4253fc3d9mr22313238wmr.25.1684345571459; 
 Wed, 17 May 2023 10:46:11 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 z26-20020a7bc7da000000b003f50d6ee334sm2832355wmk.47.2023.05.17.10.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 29/68] tests/docker: add python3-venv dependency
Date: Wed, 17 May 2023 19:44:41 +0200
Message-Id: <20230517174520.887405-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Several debian-based tests need the python3-venv dependency as a
consequence of Debian debundling the "ensurepip" module normally
included with Python.

As mkvenv.py stands as of this commit, Debian requires EITHER:

(A) setuptools and pip, or
(B) ensurepip

mkvenv is a few seconds faster if you have setuptools and pip, so
developers should prefer the first requirement. For the purposes of CI,
the time-save is a wash; it's only a matter of who is responsible for
installing pip and when; the timing is about the same.

Arbitrarily, I chose adding ensurepip to the test configuration because
it is normally part of the Python stdlib, and always having it allows us
a more consistent cross-platform environment.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230511035435.734312-12-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker | 3 ++-
 tests/docker/dockerfiles/debian-hexagon-cross.docker  | 3 ++-
 tests/docker/dockerfiles/debian-riscv64-cross.docker  | 3 ++-
 tests/docker/dockerfiles/debian-tricore-cross.docker  | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 981e9bdc7b0e..f9f401544a05 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -57,7 +57,8 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         gcc-sh4-linux-gnu \
         libc6-dev-sh4-cross \
         gcc-sparc64-linux-gnu \
-        libc6-dev-sparc64-cross
+        libc6-dev-sparc64-cross \
+        python3-venv
 
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
 ENV DEF_TARGET_LIST aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index b99d99f94365..c2cfb6a5d0fa 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -20,7 +20,8 @@ RUN apt-get update && \
         bison \
         flex \
         git \
-        ninja-build && \
+        ninja-build \
+        python3-venv && \
 # Install QEMU build deps for use in CI
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt build-dep -yy --arch-only qemu
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 803afb957345..081404e01410 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -28,7 +28,8 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata apt install -yy \
     libglib2.0-dev \
     ninja-build \
     pkg-config \
-    python3
+    python3 \
+    python3-venv
 
 # Add ports and riscv64 architecture
 RUN echo "deb http://ftp.ports.debian.org/debian-ports/ sid main" >> /etc/apt/sources.list
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index cfd2faf9a803..269bfa8d4230 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -33,7 +33,8 @@ RUN apt update && \
        pkgconf \
        python3-pip \
        python3-setuptools \
-       python3-wheel
+       python3-wheel \
+       python3-venv
 
 RUN curl -#SL https://github.com/bkoppelmann/package_940/releases/download/tricore-toolchain-9.40/tricore-toolchain-9.4.0.tar.gz \
     | tar -xzC /usr/local/
-- 
2.40.1


