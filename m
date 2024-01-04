Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 982F28245CF
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:08:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQGm-0005OJ-T5; Thu, 04 Jan 2024 11:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQGl-0005OB-NB
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:08:31 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQGj-0007sL-U1
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:08:31 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50e7dd8bce8so763247e87.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704384508; x=1704989308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGjQWJGQLmAl7EsKd4gss7GidQfzjVVMOp135hQS5aE=;
 b=UzIBHmKLGuztYhNv0gCz8C+7F5qsP7mSRUt5o6XNnybuccsecupRHNrF/hN4e3CY4O
 Gqm+eb/0CL9HQ2H/3qV5I7a1RrhVKOKYXEs0Ft8h2Lw8yJop2Upe5bZkk882EPKuQ5nP
 a8D3HTvp59Fdrt0853HLALWsjaFNVjX/hrHzTXFvOMI0hHNnkM2RmxPlnOhRMppioHvd
 L2MVEJ9kGeUytCb0ekO3gab1ttQl/+rjGSKmpOTCE7X9YXgdnpoDOYOVIAaYvRgLBHxS
 n1EUrjQaYwLD7AB0I6LkplW+XCLZvIdF/cKQjo3fiNxNUbGfwl09D4Qz2QJ/BpoPtp+s
 hJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384508; x=1704989308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGjQWJGQLmAl7EsKd4gss7GidQfzjVVMOp135hQS5aE=;
 b=lULIAtEbBrfU253/zSJvT2Ip3Vnd09d1064wzitgHmsJkmDrdYaG1oi0ewqR+65qUs
 PmeRMLfwSkO3F4KTNUow22YekqJLg1X8yL/2fm0fPBambXBWO4oOoSanuhN0+JT1LnRD
 G8MIMqpZT0Fyj+57pl64rxcNlViurYjOH9Mlki+Dx5itf7gLN5yrugsslQUtiSSJKRLI
 os3DMDAstPPE3exIJU5a2bKhxL8dsPNHP1xVeNX7HBPrD2fJb4FkARYEPuIsOJkts1xZ
 /z6Kl1c062W0ltoBDh0ic2wp3wzLjLserxkUeCCMyTV/cTXJXx7FvtbfMhqszNN9JETP
 AILQ==
X-Gm-Message-State: AOJu0YyynssMzWxiPO5Fj3urDmLaA4DLozHI0K0eMEz2B8xQ2JIReU91
 psYMt+inDbJ4/PmFWDOgGYow1vsTRzMMLei+LcDPEebOTd83RQ==
X-Google-Smtp-Source: AGHT+IEDR1mJVz4NII2iH5TjH2XjOHlzngmGH1Aky2igRcUdTcGteoM6Wsuq0+UkHiSW4FCurZQcdw==
X-Received: by 2002:ac2:5f4c:0:b0:50e:3107:29e2 with SMTP id
 12-20020ac25f4c000000b0050e310729e2mr376995lfz.108.1704384508018; 
 Thu, 04 Jan 2024 08:08:28 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 r14-20020a056402018e00b00556d13abcc7sm2430690edv.85.2024.01.04.08.08.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Jan 2024 08:08:27 -0800 (PST)
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
Subject: [RFC PATCH 3/9] scripts/ci: Split EL8 specific packages out of
 Centos8 list
Date: Thu,  4 Jan 2024 17:07:59 +0100
Message-ID: <20240104160805.56856-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240104160805.56856-1-philmd@linaro.org>
References: <20240104160805.56856-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/ci/setup/build-environment.yml | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
index 32ac0a74f4..60b751018f 100644
--- a/scripts/ci/setup/build-environment.yml
+++ b/scripts/ci/setup/build-environment.yml
@@ -234,10 +234,8 @@
           - nmap-ncat
           - numactl-devel
           - pixman-devel
-          - python38
           - python3-sphinx
           - rdma-core-devel
-          - redhat-rpm-config
           - snappy-devel
           - spice-glib-devel
           - systemd-devel
@@ -249,6 +247,16 @@
         - ansible_facts['distribution_file_variety'] in ['RedHat', 'CentOS']
         - ansible_facts['distribution_version'] == '8'
 
+    - name: Install packages only available on EL8
+      dnf:
+        name:
+          - python38
+          - redhat-rpm-config
+        state: present
+      when:
+        - ansible_facts['distribution_file_variety'] in ['RedHat']
+        - ansible_facts['distribution_version'] == '8'
+
     - name: Install Spice packages
       dnf:
         # Spice server not available in ppc64le
-- 
2.41.0


