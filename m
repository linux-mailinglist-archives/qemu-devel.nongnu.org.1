Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D79B712B36
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:56:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ahf-0002xJ-8b; Fri, 26 May 2023 12:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2ahc-0002vi-5T
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:54:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2aha-0002Fz-6d
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:54:07 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30a8dc89c33so626406f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685120044; x=1687712044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dadaeGJAraoXdJKWnEyRjK7/UkylBjw/4fB2pIOhIDM=;
 b=oVOr0Z96+QHRcNRpLz0dhfjHtTiUTtIwEv1S9iNF3dMiXKKNWNEHAQmXZfcPtLkSs4
 JyMySb6hJgkwrpzb3aH9xe9H+7Su7CVQdaYY1XobboW6Qy1Es2TvzSG8QeySiMOOTfdx
 nk/AF58eJxzjKHziY8XEREcvbnJgkb7ygKpYkit7dSrdtLZMAyO2gWdlolRkzHqHp9EZ
 2+5WCnlDV5EfC/a+n7ionfp7kRFkmGeUdgBHPPVZdnIfrFwsVEXZIfkVLRkurYttrzys
 5eCGjeWKm4ZLZ3j/6ERmAnKKeLocBXOqX9FoOXcFuvJB60q6kg7y8Awem6GbXf9C6w2c
 uxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685120044; x=1687712044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dadaeGJAraoXdJKWnEyRjK7/UkylBjw/4fB2pIOhIDM=;
 b=VgHsD7M1e13tvRRq8z9um0LugH0WZ2/hJn/edwtyMaWdFKcK68SMoaEtXln5TWTnLv
 5rPinxhH88upYauZ22jM0J4MVHzUUUF30xJlM9kdQp2HbohjfUF6b1tmLBWLZWMVUUuW
 mkLQwizw1WDCCGSmotfyoVeepEIFfuNfeLFoo8Q0wmEmQ2TF8LYR8r3MnDTeHmWXO6Dm
 pCwsWEjPTi2JBzQW3tf1EoqTorKcwRJfSJ61JqVfuUX5JONQLfFBwqZOGKPhoKAROcMS
 3KxcJXzCkXSfLaSz86Ln8LO7TEOqdIK72hy6k5mHv0LbjdT4Cl1chERVlcllADfdt6vj
 zZTg==
X-Gm-Message-State: AC+VfDwwOXCkCnefQfNLdCoBI/HA3emC4Puaye6zSkCvaeiGNBk6I9kY
 Mq11sfJ84vl9VLQxU064BVgeqg==
X-Google-Smtp-Source: ACHHUZ6KBWKapKxFU8P0MpmVEBimzJdG8lkT0qQtKV+ucDkIYu3eCmSpXiOwYBl2WLlHzmza4OYbrg==
X-Received: by 2002:a5d:4cc2:0:b0:306:36e7:db27 with SMTP id
 c2-20020a5d4cc2000000b0030636e7db27mr1909674wrt.16.1685120044687; 
 Fri, 26 May 2023 09:54:04 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z11-20020adff1cb000000b003093a412310sm5657661wro.92.2023.05.26.09.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:54:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4F2A91FFBC;
 Fri, 26 May 2023 17:54:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Markus Armbruster <armbru@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 04/11] scripts/qapi: document the tool that generated the
 file
Date: Fri, 26 May 2023 17:53:54 +0100
Message-Id: <20230526165401.574474-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526165401.574474-1-alex.bennee@linaro.org>
References: <20230526165401.574474-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230524133952.3971948-5-alex.bennee@linaro.org>

---
v6
  - use Markus' suggestion for prettier wrapping lines
  - drop un-needed str()
---
 scripts/qapi/gen.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 8f8f784f4a..70bc576a10 100644
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
+                     tool=os.path.basename(sys.argv[0]),
                      blurb=self._blurb, copyright=self._copyright)
 
     def _bottom(self) -> str:
@@ -195,7 +197,10 @@ def _bottom(self) -> str:
 
 class QAPIGenTrace(QAPIGen):
     def _top(self) -> str:
-        return super()._top() + '# AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n'
+        return (super()._top()
+                + '# AUTOMATICALLY GENERATED by '
+                + os.path.basename(sys.argv[0])
+                + ', DO NOT MODIFY\n\n')
 
 
 @contextmanager
-- 
2.39.2


