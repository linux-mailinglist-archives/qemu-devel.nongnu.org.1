Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BED8245D9
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:09:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQHr-0006aI-Vc; Thu, 04 Jan 2024 11:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQHN-0006Qt-RM
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:09:09 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQHL-0007wf-Vr
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:09:09 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a1915034144so79890266b.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704384546; x=1704989346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efH3EwEIJk0cqjaLTWeXPZwgMrle+x/TDtx5ReZFUsQ=;
 b=CewWtGkBdlAFsRyhB6r4tdzdHhf+lQRTjXhRX8KHgciU9tFgwV/hKekhsvmwLJ7IrY
 WwOcAj9ewi6Dp4ESa+Qg3byqQWWQQceFl+oOqjdIu3N759A/OUKP0c6SQyTPRCCrAuPF
 N/Bkg75UdWFHPXxaRCZjoXJDL3R2Jd9FrmXqWwAfkzJcRiwGVFel0GGIxzNDfBIfIJ3T
 27VKEGMsP+rtrJI/qMXOq7DQK5pNngOJ25/UUi0nWrxY6pSYolNY8gol/S4/htB5Vs87
 GlfFqRZ1EiukFkZB92xxSOuvbdCZyV5lL7EMuMIwbmhjd7HtrkXRs+Lnnrml+D2YkKOP
 9nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384546; x=1704989346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=efH3EwEIJk0cqjaLTWeXPZwgMrle+x/TDtx5ReZFUsQ=;
 b=tbmkTm7k7NR02h5EZssZWkPpALWN5+VKls9xSAftkz4RFl9EyaO/YtffYzsRK72EgN
 HMS6KB8kqPHBBpuTqKfciyAZtM2g61+uldJZUu9lWoO60JvagZeM0j/SdDSWG1egTkDK
 8Qn1/knXB/FkKFz0NW0UmO2S3OioekzKKqydAg9A1UUCADSHbNOaHT5iEe/j5h6xQA5Y
 NufI5BeK3IjeizJ3P5q0JSCVKl76Ni/1Gphs5x3CaZyCBLSe/Rk3yXpG5qrvl7Y78krl
 +B3vzkSJKXPkaS8AJrVm6ng96qOi7n0BmaHSb9bElZN9uuWXkJyKH3a/N86L7LZZVqUr
 ZPgA==
X-Gm-Message-State: AOJu0YzW7UNRneCC0IFUPS2oZ0r5sX2o9s8W3kHXRKD2XDede0xzQOx8
 GAPtWuRwXN+iE7MTPD2sSzxflBIfiDjiyoTdqQHQs3EYdDJ8Yg==
X-Google-Smtp-Source: AGHT+IEr0z3q1RG2AzqxjljHQyqOTIMgSltIzaCdEnqjlFzBqDySkY3l5bJZNaZIt+cAjDaeAKTfFw==
X-Received: by 2002:a17:906:3e5b:b0:a28:c148:d79f with SMTP id
 t27-20020a1709063e5b00b00a28c148d79fmr464409eji.60.1704384546372; 
 Thu, 04 Jan 2024 08:09:06 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 ey7-20020a1709070b8700b00a269d26f278sm7720417ejc.161.2024.01.04.08.09.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Jan 2024 08:09:05 -0800 (PST)
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
Subject: [RFC PATCH 9/9] scripts/ci: Restrict libpmem-dev and libxen-dev
 packages to x86 hosts
Date: Thu,  4 Jan 2024 17:08:05 +0100
Message-ID: <20240104160805.56856-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240104160805.56856-1-philmd@linaro.org>
References: <20240104160805.56856-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

libpmem-dev / libxen-dev are not available for all host archs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/ci/setup/build-environment.yml | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
index 988aef3a07..8b5b8e1dbd 100644
--- a/scripts/ci/setup/build-environment.yml
+++ b/scripts/ci/setup/build-environment.yml
@@ -96,7 +96,6 @@
           - libpcre2-dev
           - libpipewire-0.3-dev
           - libpixman-1-dev
-          - libpmem-dev
           - libpng-dev
           - libpulse-dev
           - librbd-dev
@@ -120,7 +119,6 @@
           - libvdeplug-dev
           - libvirglrenderer-dev
           - libvte-2.91-dev
-          - libxen-dev
           - libxml2-dev
           - libzstd-dev
           - llvm
@@ -158,6 +156,17 @@
         - ansible_facts['distribution'] == 'Ubuntu'
         - ansible_facts['distribution_version'] == '22.04'
 
+    - name: Install arch-specific packages (Ubuntu 22.04)
+      dnf:
+        name:
+          - libpmem-dev
+          - libxen-dev
+      when:
+        - ansible_facts['distribution'] == 'Ubuntu'
+        - ansible_facts['distribution_version'] == '22.04'
+        - ansible_facts['architecture'] == 'x86_64'
+
+
     - name: Install armhf cross-compile packages to build QEMU on AArch64 Ubuntu 22.04
       package:
         name:
-- 
2.41.0


