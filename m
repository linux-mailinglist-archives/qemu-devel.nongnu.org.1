Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB4878D6B4
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:56:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMaH-0001AY-4A; Wed, 30 Aug 2023 10:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaF-00019t-HS
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaB-0000ji-M9
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-401b3ea0656so51730515e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407250; x=1694012050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uH3otyEIeLq3dLGPNCMZELh485heJIDu3uWi+lqceck=;
 b=XZIceiIliKeKjndId2v9ttLbfJlYZOmm9rGJTGUlVYHgpDvalnBTk1PN+Y1Y+0ayov
 JZAtYTAXadOpFB0Z4Lh7gXA5oNtcDOcWzh5zR1MmgTxXzNoyGq7m/rukCechDJIGtZwa
 QWGCH1QZ3Diva4PRJuE6ghHOTiAGsUYLCIsBTJQVGcwa8OgO2UB8S6ONzqG0tjPX8dsV
 jm+mNPCEjupQuCg9n/G9ZQ1zjMLoXYtVEfk60ov/8VddAU2oaIlmhcoYMFP3/CpgaPR9
 +6vsSJTmjVJVcute7KPsZ3Ns3H415sICn7qIxtuIGwBMDcQAb8ajSR74eZ/8LIU6bPjP
 lzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407250; x=1694012050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uH3otyEIeLq3dLGPNCMZELh485heJIDu3uWi+lqceck=;
 b=jefdpDMLt7zRnCvdGeAeWPM8E3oobl2hUiFwORm0w0sqDmawRqX8K4Vh+MI5EDq3dZ
 A8Uj1pkgrOyyEBRFIV9LHhnOU7d99/JwC6uTOMvtQdIuyGfoqyAl6ijQJUAXk6AM0hjW
 WpMlfD6BdNzMf43GI0pED5JX/L/qiuT5TC1gdEHo6qkOKofUZrCxrvl15g+l9M+z2Aln
 QIxsxGN8bS3BpVsgjhZev0kMtWTn6PYtajxeybTpbABnOIubeNJu4VndDxAQzDlGpFpy
 T5ohz3Kk+CvwhZzJ8Je4W5R6Y0dVFBvzCIydW6jszNrKNZAt7rRCaXT09uTDsym3hzzC
 QpCA==
X-Gm-Message-State: AOJu0YzlvaqPYMnn/KgMrgNf2BeblnuBARZ21+uB/4nCzBu1ZsPxcyZQ
 88BaUPsjQypoYq7DBF+cIJ17Fg==
X-Google-Smtp-Source: AGHT+IHvF+2t6OFOepDX9rpS7oQ2MF91c+8dK7+lsR86r8JRVqLH6dOifjec6w/hh7YxjTvd3f5abQ==
X-Received: by 2002:adf:cd0b:0:b0:317:f18b:a950 with SMTP id
 w11-20020adfcd0b000000b00317f18ba950mr1751701wrm.26.1693407250072; 
 Wed, 30 Aug 2023 07:54:10 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b4-20020adff244000000b0031423a8f4f7sm16871369wrp.56.2023.08.30.07.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:54:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0E6D31FFBF;
 Wed, 30 Aug 2023 15:54:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [PULL 04/12] docs/style: permit inline loop variables
Date: Wed, 30 Aug 2023 15:53:59 +0100
Message-Id: <20230830145407.3064249-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830145407.3064249-1-alex.bennee@linaro.org>
References: <20230830145407.3064249-1-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Message-Id: <20230829161528.2707696-5-alex.bennee@linaro.org>

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


