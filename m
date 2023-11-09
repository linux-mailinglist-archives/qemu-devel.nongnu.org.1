Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9467E6CE0
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:09:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16eb-0007We-Ls; Thu, 09 Nov 2023 10:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r16eZ-0007Sq-Dt
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:09:07 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r16eX-0006hz-QW
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:09:07 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9de7a43bd1aso156235666b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 07:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699542543; x=1700147343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RkxZjLdrSTnFJIKsHkOj6x9DC0DNlMhc61gK75HiHJU=;
 b=D8QAvTcY3x1U09RAIvuskMi9ZW2kPLwjaJ2JDXlDLMi79RhqjX+f8PASqQlMw7tVLM
 iEAnxKricZLrKWk7oqhKOvBy8G+OODCvAOm0IDu54CWl4IBp1mHJno/O6MX5ONvDIrVP
 1SMVEx18ttL6vEMUHfPlxIGqA7fsIRyE5GRgZTveiez33tK63IDdru+AIaEZavLkLMMC
 yFPVqrVzwt7oQH91957ebBatDkE1FKW1sQ7d0xfJnljXKPOYoN1pVKfQr5c+PE3Ownj4
 MRAYsvjE6PsPm4f0rIAuJroQ1Zsh15ngPVUo+GY/vOqxjzXO/7IuxCgDjp3RA3gWEfla
 yyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699542543; x=1700147343;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RkxZjLdrSTnFJIKsHkOj6x9DC0DNlMhc61gK75HiHJU=;
 b=cD/qXCXUlkDdfoNvONE+E8/suuyv0rWBLamQJ9xQMONDTv+CLJFb3YKUIGePFTXFDU
 EuBubQGEO9DoFPFkuz6rltOLM8HzvLkpeO/BWGV/4RlMM86nfvSKZShRfOBOQKGkBRId
 2NsjvGbOgj4V2L/QMotdIMfqESTu7TzRGSFhTa+moiSsyOfaUaG2qu2AqBlDRyL7DyGS
 wCH2Bzmg258flvmuvEz5eMjGAgli84QYnPwz/0iZXLkQQOY5LCEWVSQh3VDJs0Ydf7p2
 mFC8uKkiBCujN/sUcvvm35oa84M22leQo/R/DRr39K3vPhdxcukV3nDD0ZzP0qvXL2FI
 tSPQ==
X-Gm-Message-State: AOJu0Yxqvrn2dUs3NaiGBvFB8lkgEDXpwZ04vuIcHOTKALZ2RsXso2xC
 siQ2Iq9G9Y6s1nILYLYzqy7znbhtWNjHrXqO2npd6w==
X-Google-Smtp-Source: AGHT+IEFAz5R2FlOdMaY2ilD0nBgFZU3YQ1OXGUSFNF69N7jcgXqcPFhBJJj0RN5w3gsk5NgYxq2hQ==
X-Received: by 2002:a17:907:3ea4:b0:9e2:af56:c380 with SMTP id
 hs36-20020a1709073ea400b009e2af56c380mr4283099ejc.6.1699542543397; 
 Thu, 09 Nov 2023 07:09:03 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 qt19-20020a170906ecf300b009a1be9c29d7sm2670716ejb.179.2023.11.09.07.09.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Nov 2023 07:09:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ryo ONODERA <ryoon@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Warner Losh <imp@bsdimp.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-8.2] tests/vm/netbsd: Use Python v3.11
Date: Thu,  9 Nov 2023 16:09:00 +0100
Message-ID: <20231109150900.91186-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

We requiere the 'ninja-build', which depends on 'python311':

  $ pkgin show-deps ninja-build
  direct dependencies for ninja-build-1.11.1nb1
          python311>=3.11.0

So we end up installing both Python v3.10 and v3.11:

  [31/76] installing python311-3.11.5...
  [54/76] installing python310-3.10.13...
  [74/76] installing py310-expat-3.10.13nb1...

Then the build system picks Python v3.11, and doesn't find
py-expat because we only installed the 3.10 version:

  python determined to be '/usr/pkg/bin/python3.11'
  python version: Python 3.11.5

  *** Ouch! ***

  Python's pyexpat module is not found.
  It's normally part of the Python standard library, maybe your distribution packages it separately?
  Either install pyexpat, or alleviate the need for it in the first place by installing pip and setuptools for '/usr/pkg/bin/python3.11'.

  (Hint: NetBSD's pkgsrc debundles this to e.g. 'py310-expat'.)

  ERROR: python venv creation failed

Fix by installing py-expat for v3.11. Remove the v3.10
packages since we aren't using them anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/vm/netbsd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 40b27a3469..649fcad353 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -30,8 +30,8 @@ class NetBSDVM(basevm.BaseVM):
         "git-base",
         "pkgconf",
         "xz",
-        "python310",
-        "py310-expat",
+        "python311",
+        "py311-expat",
         "ninja-build",
 
         # gnu tools
-- 
2.41.0


