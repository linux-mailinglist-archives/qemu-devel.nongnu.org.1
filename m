Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E524470AA9A
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 21:07:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0Ruk-0007GQ-3U; Sat, 20 May 2023 15:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0Ruh-0007G4-LA
 for qemu-devel@nongnu.org; Sat, 20 May 2023 15:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0Rug-00008A-5Q
 for qemu-devel@nongnu.org; Sat, 20 May 2023 15:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684609605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8UYDmpTcBJj16+BuGQN1qnrqBAgf8A4hb7KM89B/ts=;
 b=QTUUZ3jUnS7a0acbCfX0n9DEQxF1Cc+X4SKrpYL7SP7kWWLT741dBYiS9IVqZD+lsmdnlg
 Dx9J9+N7vYxs5w4ldrbDzK7gdfRvhteoiaDJgPp0ODeA0ARzrTEqQBCsa/60zvmSd8lLT8
 PaoYKlUipOsCeiwhLOeTzI3waTcUeMo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-l4SVb31pNTOTfwh1kiavxA-1; Sat, 20 May 2023 15:06:43 -0400
X-MC-Unique: l4SVb31pNTOTfwh1kiavxA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a34d3e5ebso449224366b.3
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 12:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684609602; x=1687201602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8UYDmpTcBJj16+BuGQN1qnrqBAgf8A4hb7KM89B/ts=;
 b=VjF3M+aADZXlCWp9+SwlAGM8Grme/gsrNcwFm+Kgdu/WVgKI70ofQZFW4N02mTdLu1
 GsLfablun+ElkCxPZxzNANTkYeNX3TTxNEMHiYaiaL9fFcQAMAwy0PRy6SVe8AX6DWWr
 4RabxATXOOIJn7nLvp5yC4Y+XO8moDrM8o28QMsIu6khY7fvbeNri1uvIE1Rww4tx9vz
 1yi0KlEDr9dfIQXuMsrkRfBl3sVl4WH+bcjRIFVkxpMwmdqOYwLnYOUgVzydUESnjJu5
 bRTJvZ7CkIZTENKVIhe3xeEGq818n2nSr63lNDKRvQU3OqRAYHvZSd4xB8oZrVH5ELRm
 2H0w==
X-Gm-Message-State: AC+VfDwibJLoWKS1eUWCKyR5ya9uYNVEAX9It62pSGw4pZTmIJh6D+lW
 hfndoqbQRdOWtPAkYIrhaD2FKU9PivM1DLAz/s5gFH1Ei4jCez3uLcPwJPqRUewvmDab0WwqUaU
 T7G67VpWcQ4S7jDocWlDBenZf5Of9OzoEEoz1r2nC2/htuah+/VQOE4uaxyo87Qn7Qbg+jlswWU
 k=
X-Received: by 2002:a17:907:3e95:b0:958:772e:e926 with SMTP id
 hs21-20020a1709073e9500b00958772ee926mr5550464ejc.24.1684609602389; 
 Sat, 20 May 2023 12:06:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6wxvQuIYkrxkFWs8s56fLZ7nlbyTJfXbT6GnI3xdWv/iCNosLGB4b86tvBuWCs6DQEbEASCQ==
X-Received: by 2002:a17:907:3e95:b0:958:772e:e926 with SMTP id
 hs21-20020a1709073e9500b00958772ee926mr5550446ejc.24.1684609601973; 
 Sat, 20 May 2023 12:06:41 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 gu12-20020a170906f28c00b00966069b78absm1066356ejb.192.2023.05.20.12.06.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 12:06:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/7] mkvenv: pass first missing package to diagnose()
Date: Sat, 20 May 2023 21:06:30 +0200
Message-Id: <20230520190632.7491-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230520190632.7491-1-pbonzini@redhat.com>
References: <20230520190632.7491-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


