Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D5C78463E
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 17:51:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTe6-0006Ig-33; Tue, 22 Aug 2023 11:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qYTe4-0006IH-91
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:50:16 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qYTe2-0002LT-3M
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:50:16 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31adc5c899fso4302813f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 08:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692719412; x=1693324212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ty+MUkk4NoppjREySXRnsnBpbVPnIcQrATnyM/78euY=;
 b=OljoUuv/8zK0BBV+H8uPSYrDt7AhB6bnmyNCoSXSNSOmLdKLNXGpMDVys7XXdsNhTz
 gK8Qt03Zfby+ISpvkJ8HqZWIW2R5kpUXCoen8tUQfYc8xsD3jfPZVO3+yvJNGdWwJvQr
 bZODCsUcIUod2nnB8G0W3vAhkXhMoykI5Gu83ueNG4i/pNeX7B2tuPfz0hCGwUDbEj5+
 Yvkex9ZlY6rRc8j2z9jzzdkgEWiUHIDsslrQQoSMgqEFrChXaiATcbiJ7ANhDx2fsR2g
 2Slc+nL6Uk8FB1kIgEMRxd4x386/MysnrjqqnSqwJMGUfWxn856ppvf6tPkRCZI7nNwz
 QqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692719412; x=1693324212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ty+MUkk4NoppjREySXRnsnBpbVPnIcQrATnyM/78euY=;
 b=OGY4hJhfEF9+MwqjjiTiHGiwm4RJNr+njio7y0RrzoLtv9VtWv9GAuB3OcVSKhUzI2
 shX6g1kZVEsmLtcvlTEbr01Jt/zAg02JDI4znc/h7y/UkmS2eeeaDkYtKsLTgW4MEpyL
 KaDHZM0tbMKeWaFbY30uIrsSq+QhU15MTZ2OuFvnBU+uv8NLCRxGu3HQ2WqUdi5YFGit
 0+naLh6UHjApwjTZUVP6ki+L/6vSxQbeTXA6MducOw6Mi1Wrax3MkPxZMHkxFSgepPF5
 X1c45wvBmkwmfOSqa8EtRGmcQ78V7GlgVmIIlvgM4aji7P3d0nj3jV3OEgDibBHRsOZe
 sUsg==
X-Gm-Message-State: AOJu0Yy6hzXlSc45zbaNA2GCkNzhZ/ydE6duLECmS7JbTDo0/yv1yn3h
 jHr/qHe4jFzocfxR5MQtIzV+sQ==
X-Google-Smtp-Source: AGHT+IEiSlfytEc+dEdzuAtqPPCycVcHP6dwWtcFzjYugFkJWZia3ekjjyMc3xx3v7mlG+jdjPEccw==
X-Received: by 2002:a5d:6a43:0:b0:317:f7b0:85f with SMTP id
 t3-20020a5d6a43000000b00317f7b0085fmr7166588wrw.33.1692719412194; 
 Tue, 22 Aug 2023 08:50:12 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a5d5748000000b003196e992567sm16091082wrw.115.2023.08.22.08.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 08:50:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 69FB61FFBB;
 Tue, 22 Aug 2023 16:50:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [RFC PATCH] docs/style: permit inline loop variables
Date: Tue, 22 Aug 2023 16:50:04 +0100
Message-Id: <20230822155004.1158931-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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


