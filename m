Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E60E707005
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:53:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLEY-00007v-M7; Wed, 17 May 2023 13:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDy-0007Nt-2A
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDv-0004Ee-La
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6zd8JySzHufb40u2YdjKPP9uyphRfPUF9dyMvW5WUms=;
 b=BLwYithXrWfNsTaFRLIWP6ayL0UqnO0JaohMeGtZinx1JTU6lNVlNFB1gzXVoXawb8Ft48
 5Q89eRDyqpIAMDPu03wc0vvQ/HkMj36FnoO5l8iXVfU9XEqVCzQ3Jiybxl6gAnh7BCt6ck
 kow5DpWC0W6RGkEGM3UU/wgeGc57Buc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-kigC6oc8NomsiYmfOLbwlg-1; Wed, 17 May 2023 13:45:59 -0400
X-MC-Unique: kigC6oc8NomsiYmfOLbwlg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f33f8ffa37so4308035e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345558; x=1686937558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6zd8JySzHufb40u2YdjKPP9uyphRfPUF9dyMvW5WUms=;
 b=AMRrHFd7BWN0AzEW7Glo88b5x7JrgdZoYp9DL0mWpPCb+VjPExl/EDa2C05VbDY1yU
 /8MIIgzavM97m0poBoPrmzOr0LbKdtnIK2xd2zTGURx8nP+HyRV8GboLM5TqOl9Y12pz
 /6k7dponQ+9iM8MaWqOdj8Hy6RDyvBdXYhAo8PiBoTT3/AiaouJX0OEzPN/F1uuOt0fK
 eCiLxRwAQKh4sSjyRSU3QKvszxruqz4YMzfSCCZuAEqNrG4X7hQn1SJ9dC/w4PvkoFXF
 Wpdfcm0EeoLCtZiYwRDLnNBidZVHWkYa8woQB+9hf2ddGD1Hpx3F2ayIsUl+JtBlf4Kn
 qwuA==
X-Gm-Message-State: AC+VfDw9Lkl9+f+xSuUxm/n75jM2OUJYp5Z8/1DK7f03rZD3AS6U+zyq
 Hivvgpf7+1gIQHZ4dE69yTmtC6144W9lOceoCuA78X8bLSTU4+MAMip6EHHf0PEKdyBQpJFhFlV
 00rIAhQKs0H6RU11OQUIFQA6sD2upKFDPRMuyWL8LHbopmrMaoL97ADSdZrEPEz0a1HPCfXmcQM
 s=
X-Received: by 2002:adf:e5c7:0:b0:306:3286:69a2 with SMTP id
 a7-20020adfe5c7000000b00306328669a2mr1325630wrn.48.1684345558030; 
 Wed, 17 May 2023 10:45:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ68GWtjoIlO3YeyV7a0KGitnsTvE/s4k99z4/S7DMwUVgk505fwxfPFAG5KOFxNMEGvvFfbmw==
X-Received: by 2002:adf:e5c7:0:b0:306:3286:69a2 with SMTP id
 a7-20020adfe5c7000000b00306328669a2mr1325616wrn.48.1684345557674; 
 Wed, 17 May 2023 10:45:57 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 t2-20020a5d5342000000b003063176ef0dsm3409608wrv.97.2023.05.17.10.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 21/68] mkvenv: add better error message for broken or missing
 ensurepip
Date: Wed, 17 May 2023 19:44:33 +0200
Message-Id: <20230517174520.887405-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Debian debundles ensurepip for python; NetBSD debundles pyexpat but
ensurepip needs pyexpat. Try our best to offer a helpful error message
instead of just failing catastrophically.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-5-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index a4534e41b52b..3c48f8b9baa6 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -34,6 +34,7 @@
 # later. See the COPYING file in the top-level directory.
 
 import argparse
+from importlib.util import find_spec
 import logging
 import os
 from pathlib import Path
@@ -76,6 +77,10 @@ class QemuEnvBuilder(venv.EnvBuilder):
 
     def __init__(self, *args: Any, **kwargs: Any) -> None:
         logger.debug("QemuEnvBuilder.__init__(...)")
+
+        if kwargs.get("with_pip", False):
+            check_ensurepip()
+
         super().__init__(*args, **kwargs)
 
         # Make the context available post-creation:
@@ -98,6 +103,38 @@ def get_value(self, field: str) -> str:
         return ret
 
 
+def check_ensurepip() -> None:
+    """
+    Check that we have ensurepip.
+
+    Raise a fatal exception with a helpful hint if it isn't available.
+    """
+    if not find_spec("ensurepip"):
+        msg = (
+            "Python's ensurepip module is not found.\n"
+            "It's normally part of the Python standard library, "
+            "maybe your distribution packages it separately?\n"
+            "Either install ensurepip, or alleviate the need for it in the "
+            "first place by installing pip and setuptools for "
+            f"'{sys.executable}'.\n"
+            "(Hint: Debian puts ensurepip in its python3-venv package.)"
+        )
+        raise Ouch(msg)
+
+    # ensurepip uses pyexpat, which can also go missing on us:
+    if not find_spec("pyexpat"):
+        msg = (
+            "Python's pyexpat module is not found.\n"
+            "It's normally part of the Python standard library, "
+            "maybe your distribution packages it separately?\n"
+            "Either install pyexpat, or alleviate the need for it in the "
+            "first place by installing pip and setuptools for "
+            f"'{sys.executable}'.\n\n"
+            "(Hint: NetBSD's pkgsrc debundles this to e.g. 'py310-expat'.)"
+        )
+        raise Ouch(msg)
+
+
 def make_venv(  # pylint: disable=too-many-arguments
     env_dir: Union[str, Path],
     system_site_packages: bool = False,
-- 
2.40.1


