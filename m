Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C98317875B0
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:41:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDMn-0006Mx-Gw; Thu, 24 Aug 2023 12:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMk-0006Ln-W5
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:27 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMb-00087H-92
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:26 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fea0640d7aso233125e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692895155; x=1693499955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iiC7cvPGqtDwu4nVf8eS+Cmc1lWchz2oWST+0j9UI/U=;
 b=vA04Pnyi1MC8iOQivkJG13qqRHXhRXuNG7cUOMxumPJZedRGejr4eELLl0BrlJyUqV
 Vd3n/9aUMUboZS3CWZ9lfs67ilKCYueY1h+GPvUoAEg2hwJIF2ezCfTY23rQxpdGn96n
 AUkUD3bu5RDU2QLQB46APSKzlD6/v4AGjV3U/9/xpLDi//2nBJ+92F1576o2Y+MUr4zX
 /6Ewj6uwLFC0TRSeEYj0Ri1Xoka63RPdCCYj7cUt5Fh3cixZiZSR2xn+WXOCawLN2wKt
 tBjFnXRyU6bIG0ix4WNxK119p1EeUcp5omVUWMmQnuj4rH5ZhCFvMmXYcLpLmMeb2Pvn
 OB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692895155; x=1693499955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iiC7cvPGqtDwu4nVf8eS+Cmc1lWchz2oWST+0j9UI/U=;
 b=kS6yqw+/bU8mTCR13TsnsnP71NpImMLG5PJqtj1gKAhPc+QkWJHVOo5e6rksxwnYZV
 4k49mSvfzirUQmoGrK2Pe7iuJU6gwQW275/7y1U3yg+ijRv1x/QcPVRyRVWqfYY+whXL
 KKPaxUd74K2drAuFTZa/F+dtf1FJ5zup2HaplllbHvleCp+HBwurFrqzOcl1zKIXnUJP
 J4DN60Wq1HdPrIsEwEUOEUOZWvad0KPjX88IWkBlq5Wxq35ABrcggzu7uMmlA8B6ld89
 C81PObxGe2/5SGCpB8nMCFcUkN95d14oDoAdPnQdMwbzW5sXOyDKLKNaPSPy8GCwgnSw
 A+7g==
X-Gm-Message-State: AOJu0Yx0lHB2Z41VEiBShOcuyhjSMfz5SsDf4LPZtEXUzcN03YmCl2Y7
 0bSEVUf90LMND89yRfl7+ro0YQ==
X-Google-Smtp-Source: AGHT+IHSweN2nQXLY2hUsg1P0sRg0uZ2PyL46Pd2IcPdyY94+9MW/izk/pyT8hI4pKtfh/hYV+9+Vw==
X-Received: by 2002:a05:600c:28c:b0:401:b0f2:88cc with SMTP id
 12-20020a05600c028c00b00401b0f288ccmr1218595wmk.41.1692895155495; 
 Thu, 24 Aug 2023 09:39:15 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a05600c045000b003fee0741b8csm3070971wmb.23.2023.08.24.09.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:39:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A942F1FFBF;
 Thu, 24 Aug 2023 17:39:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 04/12] docs/style: permit inline loop variables
Date: Thu, 24 Aug 2023 17:39:02 +0100
Message-Id: <20230824163910.1737079-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824163910.1737079-1-alex.bennee@linaro.org>
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

I've already wasted enough of my time debugging aliased variables in
deeply nested loops. While not scattering variable declarations around
is a good aim I think we can make an exception for stuff used inside a
loop.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230822155004.1158931-1-alex.bennee@linaro.org>
---
 docs/devel/style.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 3cfcdeb9cd..2f68b50079 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -204,7 +204,14 @@ Declarations
 
 Mixed declarations (interleaving statements and declarations within
 blocks) are generally not allowed; declarations should be at the beginning
-of blocks.
+of blocks. To avoid accidental re-use it is permissible to declare
+loop variables inside for loops:
+
+.. code-block:: c
+
+    for (int i = 0; i < ARRAY_SIZE(thing); i++) {
+        /* do something loopy */
+    }
 
 Every now and then, an exception is made for declarations inside a
 #ifdef or #ifndef block: if the code looks nicer, such declarations can
-- 
2.39.2


