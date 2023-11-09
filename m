Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3AB7E6D7D
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:35:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r173y-0001xA-1d; Thu, 09 Nov 2023 10:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r173v-0001tb-Mj
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:35:19 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r173s-00043H-O5
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:35:19 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9c773ac9b15so161037666b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 07:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699544113; x=1700148913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d+LMfAd/BMJfhsez7i/p/42kaYH2WsH1OjuLnueNoLQ=;
 b=AVN/ZfRp1X/mZ+yZ4klcdRsvrRYyWI12SmX76aRBTWq/Voj+8fSgP14NalUWiUmG4o
 uJKKVpYDTl91WAOBBDQah5lj/EMM1mI8un+RpgrUYONg3seBSgtoYQbiX+3lJcVbh8MA
 8+erVlLRwLirjWI+vcZEE0AxIzKzND+HZwCWjnXcYKeLO6l77WFXneJkJQW1qPIZ9Im7
 mi4eJ51sPNxvseJ/xC2v8vsZEoMHljgff8uA2932vrbWlMJG6DenVRNfgNt70R8R/s1n
 /TRTr2MxMjYgMB3Zmh6udM8qYObydzQl1Sa0ZO3KZUC5ztVsO+8vf6LIPpwjmINRlRaC
 RByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699544113; x=1700148913;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d+LMfAd/BMJfhsez7i/p/42kaYH2WsH1OjuLnueNoLQ=;
 b=MIoZltFJwuItFL4/Gf27T4sNuZRN1EhV7TRX/PxhRIr8MlQXDfvx3K+R71JcVnejy3
 Mn2XKtewTVzZ0eTrGfS5oDOxTbC7Uvygi0csVqjTc7fZ71kCg7WdOOkV7mX5RaY07JEB
 VFq08z4UgaskA+iBB2J3MzZEAYLmMx60tErs5EkMEr/Q6Rui3Ac5nyQDLBC42ssEYAa2
 MlCmBZb5ui6eZhGWD1XCpFnTaehElPMhJFoakaeQHAr2h28zFpFdLq1P7+5TXmhaBHWr
 urvJVY6GbSEGrt3lVKFxI2WPXucth4i5tPoFQOSBrDKlnRfpdm4nUYo5Y1L/5d2RHzmi
 FiTg==
X-Gm-Message-State: AOJu0YzD/zs0fsh6o+VYLAJtk5jaWnNbWBptRKzR5XDZVZ9aHl60/fHs
 RJQ/bBx5g4HX842h/CjH+xASoqVGoH6tiDGHTUUOJQ==
X-Google-Smtp-Source: AGHT+IFfchYnnbVWV/Pj0YtA9nTEwMkzNxWcvirrdvbEc47zDS6ajXsK1GK2X72sAZRkz8jdVgeX+Q==
X-Received: by 2002:a17:907:2d25:b0:9be:7b67:1673 with SMTP id
 gs37-20020a1709072d2500b009be7b671673mr4859637ejc.1.1699544113278; 
 Thu, 09 Nov 2023 07:35:13 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a170906505500b009b957d5237asm2664935ejk.80.2023.11.09.07.35.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Nov 2023 07:35:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ryo ONODERA <ryoon@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH-for-8.2] .gitlab-ci.d/cirrus.yml: Promote NetBSD job as
 gating
Date: Thu,  9 Nov 2023 16:35:10 +0100
Message-ID: <20231109153510.92353-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

This Cirrus-CI based job takes ~12min, similarly to macOS job.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20231109150900.91186-1-philmd@linaro.org>
          "tests/vm/netbsd: Use Python v3.11"
---
 .gitlab-ci.d/cirrus.yml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index e7f1f83c2c..7b01acb104 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -94,8 +94,6 @@ aarch64-macos-12-base-build:
     - cirrus-run -v --show-build-log always .gitlab-ci.d/cirrus/$NAME.yml
   variables:
     QEMU_JOB_CIRRUS: 1
-    QEMU_JOB_OPTIONAL: 1
-
 
 x86-netbsd:
   extends: .cirrus_kvm_job
@@ -110,3 +108,4 @@ x86-openbsd:
     NAME: openbsd
     CONFIGURE_ARGS: --target-list=i386-softmmu,riscv64-softmmu,mips64-softmmu
     TEST_TARGETS: check
+    QEMU_JOB_OPTIONAL: 1
-- 
2.41.0


