Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 812E983047D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 12:25:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ41o-0000qT-ER; Wed, 17 Jan 2024 06:24:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ41m-0000qK-HJ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 06:24:14 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ41k-0003RW-OZ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 06:24:14 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e779f0273so29072915e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 03:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705490651; x=1706095451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jxRLDvW91oBZEZLuMAZ7D7Kb5HHh/4xKrHR4jsaC06k=;
 b=tmejDPaTnU7Q7FYwc7ak7AkDrY4CGMF1H4D79sWiEl7S3GywONWVBGBAmnXaWVDHFU
 h+dduZcul6MNBEVYWtYF04T+UwZlGE0N0a9SwqIIz1Xh2kc4jccoMm2R55FUJQFtDESB
 A8MFf7bDFOUzijtpGkDNkZv5whOKds1C9TmZWuUjDHxPsp7xaUW6Yfiy7lN4KhkNjwCw
 ka9Cn0f7hryApDKvLGLipHrR32Z+zBB6rpUges+I0WQjAzadZ86feiZivNx21O/tAVLQ
 NUI+Ze+uLjMz32usLTgHcy2mBL0x5t1eeW7RauyMtFuCDhwz89qJVXBpIweYyWm2CABg
 ml/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705490651; x=1706095451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jxRLDvW91oBZEZLuMAZ7D7Kb5HHh/4xKrHR4jsaC06k=;
 b=XASBAtOCnqs0O+6y2iwvlgYBnrJWvshxA1/yF4LNi/DosgIi0nPuF8K1xc3KFznPxz
 fOZljRUbRuSTst9XJq1EpR2CE+xgt1PcBHiJBKjIo1VmzgAX3qIiMqDP7PcM1/jQZRWV
 5fgDrPLG5nsu6B/C9U0Ks4B1i+ZrcDuJtLGCVIvCrdhnzPyeBPqbpEC43bflFmMSSe1B
 GPCUf8TnwS4ltMtaoZq1/KPWrE7tYIDdpL0Qph1oBrPDXOiUnfDiyJsAWd0xj0stPWj/
 2kHSYVpkqLQ276U67OpJZYKoyJoWGvAW1E7uXuXwcmIl1JvDk0QHXXPW1ByGW2KmyBTe
 Lo1A==
X-Gm-Message-State: AOJu0Yw6NWuK0+WdUwV6GRqlyJaRb88wD7+p+Ed++pmmTswUH0kwkRBG
 hLOcEXKmT1j/VGFh56mWnXThbWjX0wlqbA==
X-Google-Smtp-Source: AGHT+IFyi49LJQGLwdKzdcEEeXZ/UfUtG16Prpm05DBd8IPc/mcZhaVcLwBLVitty7p4iqFdpnZasQ==
X-Received: by 2002:a05:600c:524c:b0:40e:4aed:ad27 with SMTP id
 fc12-20020a05600c524c00b0040e4aedad27mr4538216wmb.144.1705490650664; 
 Wed, 17 Jan 2024 03:24:10 -0800 (PST)
Received: from m1x-phil.lan ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a05600c470400b0040e45799541sm25957599wmo.15.2024.01.17.03.24.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jan 2024 03:24:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Ryo ONODERA <ryoon@netbsd.org>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [RFC PATCH] tests/vm/netbsd: Remove missing py311-expat package
Date: Wed, 17 Jan 2024 12:24:07 +0100
Message-ID: <20240117112407.22462-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Per commits a9dbde71da ("mkvenv: add better error message for
broken or missing ensurepip") and 1dee66c693 ("tests/vm: add
py310-expat to NetBSD"), we need py-expat to use ensurepip.

However the py311-expat package isn't available anymore:

  ### Installing packages ...
  processing remote summary (http://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/9.3/All)...
  database for http://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/9.3/All is up-to-date
  py311-expat is not available in the repository
  ...
  calculating dependencies.../py311-expat is not available in the repository
  pkg_install error log can be found in /var/db/pkgin/pkg_install-err.log

Dropping it from the default packages list allows creating the
NetBSD VM and build / test QEMU, without error from ensurepip.

This reverts commit 1dee66c693 ("tests/vm: add py310-expat to NetBSD").

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2109
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC because ensurepip seems important due to cited commits
    but I'm not sure where it is used, and this fixes my CI build.
---
 tests/vm/netbsd | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 649fcad353..a3f6dd6b3c 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -31,7 +31,6 @@ class NetBSDVM(basevm.BaseVM):
         "pkgconf",
         "xz",
         "python311",
-        "py311-expat",
         "ninja-build",
 
         # gnu tools
-- 
2.41.0


