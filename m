Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3618670919C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:26:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvQ9-0004dH-PC; Fri, 19 May 2023 04:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvQ6-0004d5-E4
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:25:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvQ4-0003I9-DN
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684484699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=c8UYDmpTcBJj16+BuGQN1qnrqBAgf8A4hb7KM89B/ts=;
 b=bU6/3BlJ4T562Bllr4riHvQHhmwgmUgwgtkGk+jv5DCpiYUna6t1mUnXxl6JK1jB6GhRiv
 HwPO+1aal1fYtCQWEPtsWlwsZofgY8zxjUZ1iyXGQP/7Re12O9KE/6sIjC9hJmLsk7oPIT
 hWk7PcYCnnrM9t3UA4T9rvb/z63qxc0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-UK5qKJV7Na-nqjh2VHU2BA-1; Fri, 19 May 2023 04:24:57 -0400
X-MC-Unique: UK5qKJV7Na-nqjh2VHU2BA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-510db794925so2896147a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684484696; x=1687076696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c8UYDmpTcBJj16+BuGQN1qnrqBAgf8A4hb7KM89B/ts=;
 b=KwYxEKNyERkfe0Si0HP2bABH31b3D4pao52toqJGFkDLwiP/F5Mcb6IaFGkYKOLFiF
 h7UKAgNwqt63sxJuHq96JaZ46v7CxAmyS8/0ImVQwpLxamez0QmBmGhww2UFyDypevmN
 XiylvpR3pt90/SIJkgMinO8SvATJUXw/GEnbU68B+Uao4ZSB61LKgYLsluAUIcd2JARr
 mM6o1/w2oauJrVc6pMGlwD8g5EJ8sTpRa3Hlvq8SeuRMQaSQpVRr8Iv8Zw+aSWnlsDnD
 2UvkLfnE6rv30TRIvyF1/dKHihikeJZDCsYGBmrf1EvPyF4dX5h6eNVCEQMJy8YGVfpk
 iB0w==
X-Gm-Message-State: AC+VfDz32406ZSY6/Jjqivz23d/+IKfGWwxh8ynRGDgegoMu1TwAb+ii
 UeReXd/GMIDZWyzECEqGk9HPeXeb6h2hc4yLEjYhVzQOyQ4AqnWh/Sj0055mM0Ayfp6EE8tSd/g
 p4swg0wYjUQlLXSW9aF5SfBwTCcBJnAswCDeHYVAVgq6rHB0vZo+Q/eQ2ERNgjM9SIWIXhJ0Edd
 E=
X-Received: by 2002:a17:907:9495:b0:953:8249:1834 with SMTP id
 dm21-20020a170907949500b0095382491834mr1231294ejc.16.1684484696168; 
 Fri, 19 May 2023 01:24:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ58eLIdBuNAUjsJBljaqIsyq0T9/fXsR5vnnbxuEPiTdcyifnUxD25vQ3go759QEQ3yy31Tuw==
X-Received: by 2002:a17:907:9495:b0:953:8249:1834 with SMTP id
 dm21-20020a170907949500b0095382491834mr1231273ejc.16.1684484695758; 
 Fri, 19 May 2023 01:24:55 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 ko25-20020a170907987900b00966056bd4f4sm1977614ejc.28.2023.05.19.01.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 01:24:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH] mkvenv: pass first missing package to diagnose()
Date: Fri, 19 May 2023 10:24:54 +0200
Message-Id: <20230519082454.1102010-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

If sphinx is present but the theme is not, mkvenv will print an
inaccurate diagnostic:

ERROR: Could not find a version that satisfies the requirement sphinx-rtd-theme>=0.5.0 (from versions: none)
ERROR: No matching distribution found for sphinx-rtd-theme>=0.5.0

'sphinx>=1.6.0' not found:
 • Python package 'sphinx' version '5.3.0' was found, but isn't suitable.
 • mkvenv was configured to operate offline and did not check PyPI.

Instead, ignore the packages that were found to be present, and report
an error based on the first absent package.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 6c78a2c1120e..3a9aef46a513 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -722,7 +722,8 @@ def _do_ensure(
     dep_specs: Sequence[str],
     online: bool = False,
     wheels_dir: Optional[Union[str, Path]] = None,
-) -> None:
+    prog: Optional[str] = None,
+) -> Optional[Tuple[str, bool]]:
     """
     Use pip to ensure we have the package specified by @dep_specs.
 
@@ -752,10 +753,24 @@ def _do_ensure(
         generate_console_scripts(present)
 
     if absent:
-        # Some packages are missing or aren't a suitable version,
-        # install a suitable (possibly vendored) package.
-        print(f"mkvenv: installing {', '.join(absent)}", file=sys.stderr)
-        pip_install(args=absent, online=online, wheels_dir=wheels_dir)
+        if online or wheels_dir:
+            # Some packages are missing or aren't a suitable version,
+            # install a suitable (possibly vendored) package.
+            print(f"mkvenv: installing {', '.join(absent)}", file=sys.stderr)
+            try:
+                pip_install(args=absent, online=online, wheels_dir=wheels_dir)
+                return None
+            except subprocess.CalledProcessError:
+                pass
+
+        return diagnose(
+            absent[0],
+            online,
+            wheels_dir,
+            prog if absent[0] == dep_specs[0] else None,
+        )
+
+    return None
 
 
 def ensure(
@@ -785,14 +800,12 @@ def ensure(
     if not HAVE_DISTLIB:
         raise Ouch("a usable distlib could not be found, please install it")
 
-    try:
-        _do_ensure(dep_specs, online, wheels_dir)
-    except subprocess.CalledProcessError as exc:
+    result = _do_ensure(dep_specs, online, wheels_dir, prog)
+    if result:
         # Well, that's not good.
-        msg, bad = diagnose(dep_specs[0], online, wheels_dir, prog)
-        if bad:
-            raise Ouch(msg) from exc
-        raise SystemExit(f"\n{msg}\n\n") from exc
+        if result[1]:
+            raise Ouch(result[0])
+        raise SystemExit(f"\n{result[0]}\n\n")
 
 
 def post_venv_setup() -> None:
-- 
2.40.1


