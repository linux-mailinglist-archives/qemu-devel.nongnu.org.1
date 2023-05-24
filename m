Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6480D70F7EA
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 15:41:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1oil-0008OA-4q; Wed, 24 May 2023 09:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1oie-0008D8-CM
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:40:01 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1oib-0003lx-Rc
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:39:59 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-30a892c45c4so574973f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 06:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684935595; x=1687527595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PoFcFHhtN//HYJuXe8yUkXS88yzA5U5AjAGE2C88aFE=;
 b=LlL26XbmMqIfnVRJ7mQFf7knn5B5u2RUadIjfMQsOyXG6MbF6R+l2RnUtwGnS62/Vx
 F1sOBi4u4L3ioU94rOtWQPR82AOdW9UieLb35LxDtuUoEKr1/JhPTS5+V+hoQFJPZ6v/
 NjzQ3xH3xLpXjrocmcscbKIjIsMlNTRlWl0LIKxyrPqJQDfe+CkIRjuU32slCAG4F08P
 5rOq4p7kGJW35FiiG07axucTX1aa58DEj6agRcvMapLUIh1tWuz4/C6dH2S+77izOoCx
 pbqdwGdpuVBiQtDIQRuMgzOJfQzy2wkk1YPXvLGBN4p9oA7DmJ28jEqInumDapjGYPOg
 xWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684935595; x=1687527595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PoFcFHhtN//HYJuXe8yUkXS88yzA5U5AjAGE2C88aFE=;
 b=N/ZuIAO882Q/7oxZVjYUcYeqVrGlVfntTWrDw4vueh04Fzl0qkWUp/nYfWJkH/G57J
 no1dNF44Yr/2SlGw7WABIErKH/l9Nj1515AR74YsweJ4QZ4Hzp7Xt4X7IPx7wf0poHjC
 rdCRtUoWYsdOWGfMLDKh9fFhb3OSNrgGdqtJH8QMFYNqvhDub/mcsebhQgqDZjtbQkNg
 L3LIpn797YOkf4yBriMoCPxUnRj+A/NVehDkfEfX03sXN0qYJ4kAOEKuq8Rsxv8cbVYm
 zK/nzbrCJVr8cH5G2/Rux6td+b9Du/CKU/VUaQPc4QkViY6mPX4FyD3kfS8evtN6Q/9D
 velA==
X-Gm-Message-State: AC+VfDxppzchonpyfw52SwVo9Gq3b+NRwYkj8hGFhZumSqzxgwCnt3Ab
 w5BSbj/N2rZv8e0omzDv78rclg==
X-Google-Smtp-Source: ACHHUZ5cwfELyyiwnD3SgO3pqe5iGq3OUgj5BOEuQirsO5OwCqF+nOds3unAu3kRFVqtuKw+F4B52w==
X-Received: by 2002:adf:e6cb:0:b0:2d1:3eb9:c3c2 with SMTP id
 y11-20020adfe6cb000000b002d13eb9c3c2mr12314606wrm.54.1684935595144; 
 Wed, 24 May 2023 06:39:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a5d4e11000000b003063772a55bsm14538281wrt.61.2023.05.24.06.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 06:39:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 64B031FFBF;
 Wed, 24 May 2023 14:39:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v5 04/10] scripts/qapi: document the tool that generated the
 file
Date: Wed, 24 May 2023 14:39:46 +0100
Message-Id: <20230524133952.3971948-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524133952.3971948-1-alex.bennee@linaro.org>
References: <20230524133952.3971948-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
Message-Id: <20230523125000.3674739-5-alex.bennee@linaro.org>
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


