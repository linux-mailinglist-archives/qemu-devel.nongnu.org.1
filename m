Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8780706FDE
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:47:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLES-0008F5-UK; Wed, 17 May 2023 13:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLE6-0007eE-CM
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLE4-0004H6-Fq
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3IN3vpyWO0eLzaYR0wBWQOI2Q29IOE8Vh96ivvWrrr8=;
 b=KQmw0EFf9WIz4rM//fzRG9u9ZUBHJX2H2jqCMCT4YPDiQg2g5yq2bNK4uRK9btVHAsdmds
 bGJMr/yhulO9u4IBOsUZOJJUqqAdydhlVMB7ld6/1i8+E60jdYmDaknw0Tinfaxf/G4fD2
 AnZ5j/WuY5uniduFtnl5KA1jKgL3Mhs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-cApT83a9PKW4nRKENi5Nsw-1; Wed, 17 May 2023 13:46:10 -0400
X-MC-Unique: cApT83a9PKW4nRKENi5Nsw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so4361895e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345568; x=1686937568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3IN3vpyWO0eLzaYR0wBWQOI2Q29IOE8Vh96ivvWrrr8=;
 b=EEAAbjYQsFd3O87d7SYYtVPLNCuT+zjFdRUmaD8e2IIm7ryCjDXsh0WXkjGJLbRJLp
 w8tkr2DEbRu3bbFqlscgGaEYT2Qm07dJ0qa1Tw7F2HAD4CI3XOpz5NCR9mlISmkV577p
 OqePGU9F5yMYxzhgZV63TKcGSbbTGVxTl8X4kj0qkOKxUXEFhgSkxa9QdHm2aEETB3Id
 CyqqJfw/Gk1RwY8tSft+xWRDrvsTmM8GZysrlCRCUTL6ESiLjRlKfeAvHPEPBD2SHWJS
 5SvdXBG5RJTvSYFtxU1uA5bWmqSUyc3ewu/iI6MvyxQrSgV3egoLcQqNkyygTdK8r2f8
 LhEg==
X-Gm-Message-State: AC+VfDzBUFqgTwjPX5HQobDT8sybD0ODXbpHjzihX79Wja0sf693P2Gk
 zDjVydlLAaGKsRW7KQ2sjIs0qo9Ko5MBs51iFKjOptTIyAcs7eyFimn+poR4YkawrR2VcBgRYzb
 wNpIdgDRqrTcYjxeuOl4Nl2gyiN4eZNSupxxKiPYbGWSFzEt9UW3OjkNQCkLPt3XUG1nJOEuA6J
 M=
X-Received: by 2002:a05:600c:2059:b0:3f4:2492:a91f with SMTP id
 p25-20020a05600c205900b003f42492a91fmr25003479wmg.27.1684345568420; 
 Wed, 17 May 2023 10:46:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5pTxnHgPnjekIOSuQ4zSf8iwj79v10T4rk46Sp7LaTnWVpRIYaxVwFR2wMfF14X5Z0TY5o2Q==
X-Received: by 2002:a05:600c:2059:b0:3f4:2492:a91f with SMTP id
 p25-20020a05600c205900b003f42492a91fmr25003471wmg.27.1684345568117; 
 Wed, 17 May 2023 10:46:08 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a5d4a84000000b002c54c9bd71fsm3390013wrq.93.2023.05.17.10.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 27/68] mkvenv: avoid ensurepip if pip is installed
Date: Wed, 17 May 2023 19:44:39 +0200
Message-Id: <20230517174520.887405-28-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 67 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index fb91f922d2b9..a9c566029e6f 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -11,6 +11,8 @@
 Commands:
   command     Description
     create    create a venv
+    post_init
+              post-venv initialization
     ensure    Ensure that the specified package is installed.
 
 --------------------------------------------------
@@ -25,6 +27,13 @@
 
 --------------------------------------------------
 
+usage: mkvenv post_init [-h]
+
+options:
+  -h, --help         show this help message and exit
+
+--------------------------------------------------
+
 usage: mkvenv ensure [-h] [--online] [--dir DIR] dep_spec...
 
 positional arguments:
@@ -111,7 +120,9 @@ class QemuEnvBuilder(venv.EnvBuilder):
 
     The primary difference is that it emulates a "nested" virtual
     environment when invoked from inside of an existing virtual
-    environment by including packages from the parent.
+    environment by including packages from the parent.  Also,
+    "ensurepip" is replaced if possible with just recreating pip's
+    console_scripts inside the virtual environment.
 
     Parameters for base class init:
       - system_site_packages: bool = False
@@ -138,8 +149,19 @@ def __init__(self, *args: Any, **kwargs: Any) -> None:
             # The venv we are currently in, also does so.
             kwargs["system_site_packages"] = sys.base_prefix in site.PREFIXES
 
-        if kwargs.get("with_pip", False):
-            check_ensurepip()
+        # ensurepip is slow: venv creation can be very fast for cases where
+        # we allow the use of system_site_packages. Therefore, ensurepip is
+        # replaced with our own script generation once the virtual environment
+        # is setup.
+        self.want_pip = kwargs.get("with_pip", False)
+        if self.want_pip:
+            if (
+                kwargs.get("system_site_packages", False)
+                and not need_ensurepip()
+            ):
+                kwargs["with_pip"] = False
+            else:
+                check_ensurepip()
 
         super().__init__(*args, **kwargs)
 
@@ -211,6 +233,14 @@ def post_post_setup(self, context: SimpleNamespace) -> None:
             with open(pth_file, "w", encoding="UTF-8") as file:
                 file.write(parent_libpath + os.linesep)
 
+        if self.want_pip:
+            args = [
+                context.env_exe,
+                __file__,
+                "post_init",
+            ]
+            subprocess.run(args, check=True)
+
     def get_value(self, field: str) -> str:
         """
         Get a string value from the context namespace after a call to build.
@@ -223,6 +253,19 @@ def get_value(self, field: str) -> str:
         return ret
 
 
+def need_ensurepip() -> bool:
+    """
+    Tests for the presence of setuptools and pip.
+
+    :return: `True` if we do not detect both packages.
+    """
+    # Don't try to actually import them, it's fraught with danger:
+    # https://github.com/pypa/setuptools/issues/2993
+    if find_spec("setuptools") and find_spec("pip"):
+        return False
+    return True
+
+
 def check_ensurepip() -> None:
     """
     Check that we have ensurepip.
@@ -693,6 +736,17 @@ def ensure(
         raise SystemExit(f"\n{msg}\n\n") from exc
 
 
+def post_venv_setup() -> None:
+    """
+    This is intended to be run *inside the venv* after it is created.
+    """
+    logger.debug("post_venv_setup()")
+    # Generate a 'pip' script so the venv is usable in a normal
+    # way from the CLI. This only happens when we inherited pip from a
+    # parent/system-site and haven't run ensurepip in some way.
+    generate_console_scripts(["pip"])
+
+
 def _add_create_subcommand(subparsers: Any) -> None:
     subparser = subparsers.add_parser("create", help="create a venv")
     subparser.add_argument(
@@ -703,6 +757,10 @@ def _add_create_subcommand(subparsers: Any) -> None:
     )
 
 
+def _add_post_init_subcommand(subparsers: Any) -> None:
+    subparsers.add_parser("post_init", help="post-venv initialization")
+
+
 def _add_ensure_subcommand(subparsers: Any) -> None:
     subparser = subparsers.add_parser(
         "ensure", help="Ensure that the specified package is installed."
@@ -761,6 +819,7 @@ def main() -> int:
     )
 
     _add_create_subcommand(subparsers)
+    _add_post_init_subcommand(subparsers)
     _add_ensure_subcommand(subparsers)
 
     args = parser.parse_args()
@@ -771,6 +830,8 @@ def main() -> int:
                 system_site_packages=True,
                 clear=True,
             )
+        if args.command == "post_init":
+            post_venv_setup()
         if args.command == "ensure":
             ensure(
                 dep_specs=args.dep_specs,
-- 
2.40.1


