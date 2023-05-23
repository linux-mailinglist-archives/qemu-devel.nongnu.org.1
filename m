Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 923D670DD04
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:51:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RTM-0007e7-He; Tue, 23 May 2023 08:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RTJ-0007au-Uu
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:38 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RTA-0005Hw-RB
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:36 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3078d1c8828so7066315f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684846203; x=1687438203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00n5aVndIwSHvOX6LssWty7GpzeSEYjdv0l8Fp9wGrU=;
 b=dbLOXqQ8igxdE1saSzV5UX9w8GscLnkydyd4eiwJ+sq8YgejDwaINj9JS/pMX78Ivs
 3D+zcjE0pidQ9z7QjF4X3Y4S5CmYj1bqBNi8XrEc3sha1Qzop8XIMuNTowOvT2BfoIwd
 jNzfJvTOK2Cobs949x/054z2rVMjaIM74bmQcl2NGiMPnwjKKcF92Shqgf+gWpPlYxwG
 POlfJ1v7zToofyp2xzu8pySQLkV/hH6g4xrmHOUWmWTtuBp+Zi2jTRwSAFB5M4kttfxp
 1+L/8ieAqNY5Ci7hpsF+Bx0Ihh9hMKtnViTqBR2Y3XWRBwuXT7OqnDd47noE0jc2W9pe
 LaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684846203; x=1687438203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00n5aVndIwSHvOX6LssWty7GpzeSEYjdv0l8Fp9wGrU=;
 b=Fzpb0u6kzHlNxb0xrbbztiOM4bKulE507BId+EDDHio5aMDiVog4jJgMeQJIEdqGuf
 f0HUlCO9R+Juz54CC7KeQAAmmJqFG6LwBWiUqtALKmrCrjLaI0Ss4cz0Fc6UIiEIE0Z7
 qXaAG39mH4ul9IKuVqt8DW96twveHc8FG5P7SPczMDGCZmLTVPfo0nozhmrMMEJ63mr8
 fbQugSlDh67sn3nXBRTDUSrgJVmftzCKwpNe7GU7Y1kn0HvaIpQuGMSogg9Zlh8wUb9i
 1JuxyTp7sB7Hp22+8DAT0oNL1bi7R2IH3ENoCKG2PMwbG1s28Or+MfHrD/NQDSbaXtEO
 X0Ow==
X-Gm-Message-State: AC+VfDxlW/Apj1/JmDle/Iy0AdXpG2/PKjf1V5aSb+GsI49ugj1tFvZA
 eTkRcYSyyVnhjLgVbxk1JANdqA==
X-Google-Smtp-Source: ACHHUZ7ctykBYCeyKMDAV1FOk1+7S+X29GIaMZ90CvXQEcbpmo2eDOHQ9sfMf4obVORH68Q2M+6Lzg==
X-Received: by 2002:a5d:62d0:0:b0:309:51c5:3bf6 with SMTP id
 o16-20020a5d62d0000000b0030951c53bf6mr10999718wrv.23.1684846203460; 
 Tue, 23 May 2023 05:50:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q3-20020adff783000000b002e61e002943sm10960332wrp.116.2023.05.23.05.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:50:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 657EA1FFBF;
 Tue, 23 May 2023 13:50:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Warner Losh <imp@bsdimp.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Eric Blake <eblake@redhat.com>,
 libvir-list@redhat.com, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 04/10] scripts/qapi: document the tool that generated the
 file
Date: Tue, 23 May 2023 13:49:54 +0100
Message-Id: <20230523125000.3674739-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523125000.3674739-1-alex.bennee@linaro.org>
References: <20230523125000.3674739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

This makes it a little easier for developers to find where things
where being generated.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230505155336.137393-5-alex.bennee@linaro.org>

---
v4
  - expand out os.path.basename(sys.argv[0])
---
 scripts/qapi/gen.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 8f8f784f4a..2ea27ef31c 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -13,6 +13,7 @@
 
 from contextlib import contextmanager
 import os
+import sys
 import re
 from typing import (
     Dict,
@@ -162,7 +163,7 @@ def __init__(self, fname: str, blurb: str, pydoc: str):
 
     def _top(self) -> str:
         return mcgen('''
-/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
+/* AUTOMATICALLY GENERATED by %(tool)s DO NOT MODIFY */
 
 /*
 %(blurb)s
@@ -174,6 +175,7 @@ def _top(self) -> str:
  */
 
 ''',
+                     tool=str(os.path.basename(sys.argv[0])),
                      blurb=self._blurb, copyright=self._copyright)
 
     def _bottom(self) -> str:
@@ -195,7 +197,9 @@ def _bottom(self) -> str:
 
 class QAPIGenTrace(QAPIGen):
     def _top(self) -> str:
-        return super()._top() + '# AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n'
+        return super()._top() + (
+            '# AUTOMATICALLY GENERATED by '
+            f"{os.path.basename(sys.argv[0])}, DO NOT MODIFY\n\n" )
 
 
 @contextmanager
-- 
2.39.2


