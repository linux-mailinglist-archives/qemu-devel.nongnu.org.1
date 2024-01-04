Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8358245D3
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:09:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQGu-0005PY-GO; Thu, 04 Jan 2024 11:08:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQGr-0005P3-VF
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:08:37 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQGq-0007u6-6p
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:08:37 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50e7dff3e9fso757340e87.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704384514; x=1704989314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7++Y7va51Qj/c1w7IkyF5ARAG45RNZAlgZr3RWGqoII=;
 b=qfOUrqXpQT/SQRo8CLVDyuOzZ9FtgYLpTzPmdPtVDn0NQxMsaBAD9GNwpZAM5+ikYa
 wUT/vydBO+p+jA5l23S/VnENUPuS2Sm97a0pTz9rf9PSCxq67m35KBs3tclyPBDsBfEv
 +883vO8rkEvRO44cCcjsyBF9/NJIDBZp1bvFolDIE9KxYG7bN2RKSGoqcApIM6B8UcCN
 Vq3ApOanIvQCH5HacTOO9zl8jTafvpii9RC+o2+IDV2eneWnqHe0FiUkW1x94iYgwu5L
 xpxuc0YX3ZRRrxbVB5K51kxS1HBCeCJwDjFa86lj1cydO3lBNo59adoOrXktSs2yKf35
 smFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384514; x=1704989314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7++Y7va51Qj/c1w7IkyF5ARAG45RNZAlgZr3RWGqoII=;
 b=WaBJ0kUTmaE8OUF+9uGTbmIDKzZSR4fij9k2mZrALUqBUfOqUDz6QlhKD632OiE8H3
 64Azm2l9Jr1wQvALV61hNNn3lxHS7XChi9M60UWWN8ZZtqxG05TX4UFVb75vU1rKC+dp
 NrA0uU/GbmSET20W0BxWbqmJQihMus08XECa+Sei7H/Y5We+hrVL/akYoD0ZOKG/N1Vk
 TjVVmILRg5pfpdhsODunDw3A3TAjp05r6/qllZZoAYGzwwMCugUE/d10TW2AsrIjTsli
 VaCiiHWRzmp+0wi/hLBDY5pIQYiEzRZqiIkY+Qu3JG2eDUNRT2oc1O7XjhKReYmNZbzY
 PD5g==
X-Gm-Message-State: AOJu0Yx1EhFYz35ag0O72NLeonTOBZtDHX2LyddJqD5bvOUOnzRgO/Xs
 0SNfOTAPyzeqUQ74byoZ8UbmYSuynb3+Hc73zAPyC5/kgUSQ8A==
X-Google-Smtp-Source: AGHT+IEpW84q3GfkP1YI0oh68pSSCVRdx0TFch3tFPfDpwwxEIxGZ855yyMPgxlLNF1l2PJjh+Ozzw==
X-Received: by 2002:a2e:a588:0:b0:2cc:c7fb:ce0d with SMTP id
 m8-20020a2ea588000000b002ccc7fbce0dmr539622ljp.93.1704384514151; 
 Thu, 04 Jan 2024 08:08:34 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 x7-20020aa7cd87000000b00555b548c3fesm9082233edv.29.2024.01.04.08.08.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Jan 2024 08:08:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Xianglai Li <lixianglai@loongson.cn>, Zhiguo Wu <wuzhiguo@loongson.cn>,
 Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH 4/9] scripts/ci: Update Centos8 package list
Date: Thu,  4 Jan 2024 17:08:00 +0100
Message-ID: <20240104160805.56856-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240104160805.56856-1-philmd@linaro.org>
References: <20240104160805.56856-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

Update Centos 8 package list running:

 $ lcitool variables -f json centos-stream-8 qemu \
   | jq -r '.pkgs[]' \
   | xargs -n 1 echo "          -"

On libvirt-ci commit e9e7d3bf ("facts: enable gtk-vnc2-devel
on almalinux 8 / centos stream 8").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/ci/setup/build-environment.yml | 75 +++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 7 deletions(-)

diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
index 60b751018f..9518cc55a5 100644
--- a/scripts/ci/setup/build-environment.yml
+++ b/scripts/ci/setup/build-environment.yml
@@ -195,53 +195,114 @@
 
     - name: Install basic packages to build QEMU on EL8
       dnf:
-        # This list of packages start with tests/docker/dockerfiles/centos8.docker
-        # but only include files that are common to all distro variants and present
-        # in the standard repos (no add-ons)
         name:
+          - SDL2-devel
+          - alsa-lib-devel
+          - bash
+          - bc
+          - bison
+          - brlapi-devel
           - bzip2
           - bzip2-devel
+          - ca-certificates
           - capstone-devel
+          - ccache
+          - clang
+          - ctags
+          - cyrus-sasl-devel
+          - daxctl-devel
           - dbus-daemon
           - device-mapper-multipath-devel
           - diffutils
+          - findutils
+          - flex
           - gcc
           - gcc-c++
           - genisoimage
           - gettext
           - git
           - glib2-devel
+          - glib2-static
+          - glibc-langpack-en
+          - glibc-static
           - glusterfs-api-devel
           - gnutls-devel
+          - gtk3-devel
+          - hostname
+          - jemalloc-devel
+          - json-c-devel
           - libaio-devel
+          - libasan
+          - libattr-devel
+          - libbpf-devel
+          - libcacard-devel
           - libcap-ng-devel
+          - libcmocka-devel
           - libcurl-devel
+          - libdrm-devel
           - libepoxy-devel
           - libfdt-devel
+          - libffi-devel
           - libgcrypt-devel
           - libiscsi-devel
+          - libjpeg-devel
+          - libnfs-devel
           - libpmem-devel
-          - librados-devel
+          - libpng-devel
           - librbd-devel
           - libseccomp-devel
+          - libslirp-devel
           - libssh-devel
-          - libxkbcommon-devel
+          - libtasn1-devel
+          - libubsan
+          - liburing-devel
+          - libusbx-devel
+          - libxdp-devel
+          - libxml2-devel
+          - libzstd-devel
+          - llvm
+          - lttng-ust-devel
           - lzo-devel
           - make
-          - mesa-libEGL-devel
+          - mesa-libgbm-devel
+          - meson
+          - ncurses-devel
           - nettle-devel
           - ninja-build
           - nmap-ncat
           - numactl-devel
+          - openssh-clients
+          - pam-devel
+          - pcre-static
+          - pipewire-devel
           - pixman-devel
+          - pkgconfig
+          - pulseaudio-libs-devel
+          - python3
+          - python3-PyYAML
+          - python3-numpy
+          - python3-pillow
+          - python3-pip
           - python3-sphinx
+          - python3-sphinx_rtd_theme
+          - python3-tomli
           - rdma-core-devel
+          - sed
           - snappy-devel
-          - spice-glib-devel
+          - spice-protocol
+          - spice-server-devel
           - systemd-devel
           - systemtap-sdt-devel
           - tar
+          - texinfo
+          - usbredir-devel
+          - util-linux
+          - virglrenderer-devel
+          - vte291-devel
+          - which
+          - xfsprogs-devel
           - zlib-devel
+          - zlib-static
         state: present
       when:
         - ansible_facts['distribution_file_variety'] in ['RedHat', 'CentOS']
-- 
2.41.0


