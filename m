Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2528745DFD
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGK01-0000mX-0z; Mon, 03 Jul 2023 09:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzj-0000YP-O3
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzh-00083Z-WA
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fba545d743so59792615e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688392412; x=1690984412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWju6yYypmjiS4eVFMrIutfDiiFuiOcYWn1zgF31IBI=;
 b=xrzSzRfY+vom5vaC6PYW7WykOZ64DoyCzdCCVnthZkbjpbmkA89J9ZbXtX4jIk2fq/
 BonZpzh38+kGtYkAsqofM+XUhctN6qIN4PT49GbjHRxmdBYCOEOBHo/r3Lhm2kzJUTbA
 YAwqMW8W/+MDOujgFO1gJBCz2+G1S5i2JaHrlLL9pEKbCvB21s2pDfhuG8EE5AJvxy7U
 2uqUZWI1ACl79OsUiwn153hio9GTrYf4B25pbFg5AK3od/jAMlwRo/tehqVcheTsFYGm
 tK4dwnXhHQbX/6kE2fjgXklJH8YmDptjgkUV7uGm7XLF9tuz/p1KSn9jrcIxPPfxe761
 6q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392412; x=1690984412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWju6yYypmjiS4eVFMrIutfDiiFuiOcYWn1zgF31IBI=;
 b=QhFcMBjP865EPdnNKAciHzGeBgY4EPW8VRJJVgUG2sdjBvbwj4fedg4EtMA0HlPPX9
 aAUdeSwEw0cQpcvZE1BAqOl8vL33JtEBgDZZTlyiRCPO87wKQ0QrO/U1LvB6IzyT1d6e
 +bCBUVyTGrc9MS5WUWPIIpDgVji28U9CUO0pRNDCWqoneHNt0eWRaDdQWH+P6tr7X/ry
 lKxx40wIufLVq5rpoqcg9Q1RdciOm8liR5Rg/SgdjfuAa0sMD96iNLnIP838AWKUx+G5
 KOm4jBAT2CV0VTF4FWXgfS5gEkkiXyfdXOMFTRM5mzGx0p8bjecFDXXd9W9v/n1ZPuyv
 p0FA==
X-Gm-Message-State: AC+VfDyO61yBB3P5FqWpTJJ9FnupaseFHMoCaGbBVQ4JvPOhYEzwQ9Yy
 REjps/BelTNGnnLNRz4Ne8L02/uB7R8+dmSmxgE=
X-Google-Smtp-Source: ACHHUZ6Sz4TxfvYhJmiT02wOR9G4a4W9Rzj2CvhqjfrMRKFOxJ7s7fhXLfTha5wlil27+X0XZA7nvg==
X-Received: by 2002:a05:600c:2213:b0:3fa:e92e:7a7b with SMTP id
 z19-20020a05600c221300b003fae92e7a7bmr9739218wml.15.1688392412706; 
 Mon, 03 Jul 2023 06:53:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 da16-20020a056000197000b0031274a184d5sm25819253wrb.109.2023.07.03.06.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:53:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 745451FFCC;
 Mon,  3 Jul 2023 14:44:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 22/38] docs/devel: add some front matter to the devel index
Date: Mon,  3 Jul 2023 14:44:11 +0100
Message-Id: <20230703134427.1389440-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Give an overview of the most useful bits of the devel documentation to
read depending on what the developer wants to do.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-23-alex.bennee@linaro.org>

diff --git a/docs/devel/index-process.rst b/docs/devel/index-process.rst
index d50dd74c3e..362f97ee30 100644
--- a/docs/devel/index-process.rst
+++ b/docs/devel/index-process.rst
@@ -1,3 +1,5 @@
+.. _development_process:
+
 QEMU Community Processes
 ------------------------
 
diff --git a/docs/devel/index-tcg.rst b/docs/devel/index-tcg.rst
index b44ff8b5a4..a992844e5c 100644
--- a/docs/devel/index-tcg.rst
+++ b/docs/devel/index-tcg.rst
@@ -1,3 +1,5 @@
+.. _tcg:
+
 TCG Emulation
 -------------
 
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 09cfb322be..abf60457c2 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -2,10 +2,30 @@
 Developer Information
 ---------------------
 
-This section of the manual documents various parts of the internals of QEMU.
-You only need to read it if you are interested in reading or
+This section of the manual documents various parts of the internals of
+QEMU. You only need to read it if you are interested in reading or
 modifying QEMU's source code.
 
+QEMU is a large and mature project with a number of complex subsystems
+that can be overwhelming to understand. The development documentation
+is not comprehensive but hopefully presents enough to get you started.
+If there are areas that are unclear please reach out either via the
+IRC channel or mailing list and hopefully we can improve the
+documentation for future developers.
+
+All developers will want to familiarise themselves with
+:ref:`development_process` and how the community interacts. Please pay
+particular attention to the :ref:`coding-style` and
+:ref:`submitting-a-patch` sections to avoid common pitfalls.
+
+If you wish to implement a new hardware model you will want to read
+through the :ref:`qom` documentation to understand how QEMU's object
+model works.
+
+Those wishing to enhance or add new CPU emulation capabilities will
+want to read our :ref:`tcg` documentation, especially the overview of
+the :ref:`tcg_internals`.
+
 .. toctree::
    :maxdepth: 1
 
diff --git a/docs/devel/tcg.rst b/docs/devel/tcg.rst
index b4096a17df..2786f2f679 100644
--- a/docs/devel/tcg.rst
+++ b/docs/devel/tcg.rst
@@ -1,3 +1,5 @@
+.. _tcg_internals:
+
 ====================
 Translator Internals
 ====================
-- 
2.39.2


