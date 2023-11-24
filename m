Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B83F57F77BA
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 16:25:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Y2c-0004fm-Ob; Fri, 24 Nov 2023 10:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2b-0004fe-96
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2Z-0004A0-IO
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700839462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gg7WTh3aHpl1+7zvMuf9VaYP22nQsRG0DOeT1ZRI+XY=;
 b=bVsW1MPLxusQPTaSC/CQY4i6xX4pwufzbm5jzL/3p1pJojtGQS7+C2HAa6s1CGPmoDbjXM
 I0yc55zbTgy10iKSBtLZetx9j62WRWdyN3efPKfMpDfMog8MTZ/OitpCXATYE5XoPVuFT5
 osXNE4Ls81IQJ0ZLxKEK2mQkBuMYylQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-PAo0zEoMPi6J7yfxbhiBBA-1; Fri, 24 Nov 2023 10:24:19 -0500
X-MC-Unique: PAo0zEoMPi6J7yfxbhiBBA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-67a16ff92abso8274146d6.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 07:24:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700839458; x=1701444258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gg7WTh3aHpl1+7zvMuf9VaYP22nQsRG0DOeT1ZRI+XY=;
 b=JRIjHYGXjFX7+DxxosB8B7O3GYKAtGz7Kj7raZgK9kNdUzciTJSbrilcKfPC8wHtXP
 UsxoF4ap77X0gS/upN/raEvg4wlg5oYB9kI7u7fp7GAgIqHfI4CToCtvC9C7AW71goQT
 yKh+ZsmbnK2mJPboYjhfz0QJrptif4PE9LKUweqxhtIXmBeyaZGF+TLKljDDK0oz9rR9
 3lrHyaOZ9Wjl934ootTm+Zjs07h5IP/7mN61QqS1WeRfdRKtPHYyRMVdQXvswGu8pX6O
 e19TehjiI7Cpq07Q7mBJviIVsEmI60yAi8Y6SWJMFpA/17EZRDuvEHnScbw+7dD34cbK
 JWgQ==
X-Gm-Message-State: AOJu0Yx2ZfHuOWH0Df1GDW15lmpAQIcpYUlFyNXGexv8oEF2/cQL8GfZ
 WzwMAo9PqOYT6m2mY3TQoaPoG1e54C/+A0+eq2dK3DKc6axqxPW7DPxtYtntpqdS45wTRidWhUh
 hR6TxyG40Yh+h3IYezEQL6haYWLib2UbcGQ0lVP0Q47CO4NkiYSYb0GsJxjQ2eiQQn3cO8T0mfe
 s=
X-Received: by 2002:a0c:f64f:0:b0:64f:4e64:5962 with SMTP id
 s15-20020a0cf64f000000b0064f4e645962mr3593525qvm.31.1700839458529; 
 Fri, 24 Nov 2023 07:24:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+kT0kdrUSdAQY4RzNmzrMDX1vtLsV4vmPPN0+hmLWG/hmac1ob3ePn7B5fd8K8rYDAoZXnQ==
X-Received: by 2002:a0c:f64f:0:b0:64f:4e64:5962 with SMTP id
 s15-20020a0cf64f000000b0064f4e645962mr3593492qvm.31.1700839458063; 
 Fri, 24 Nov 2023 07:24:18 -0800 (PST)
Received: from [10.201.49.108] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 n11-20020ad444ab000000b0067a08bba0bbsm1373838qvt.0.2023.11.24.07.24.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 07:24:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/10] docs: document what configure does with virtual
 environments
Date: Fri, 24 Nov 2023 16:24:01 +0100
Message-ID: <20231124152408.140936-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124152408.140936-1-pbonzini@redhat.com>
References: <20231124152408.140936-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Given the recent confusion around how QEMU detects the system
Meson installation, and/or decides to install its own, it is
time to fill in the "Python virtual environments and the QEMU
build system" section of the documentation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst | 88 +++++++++++++++++++++++++++++++++++--
 pythondeps.toml             |  3 +-
 2 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 21f78da7d1d..43d6005881e 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -122,10 +122,78 @@ functioning.  These are performed using a few more helper functions:
    indicated by $TMPC.
 
 
-Python virtual environments and the QEMU build system
------------------------------------------------------
+Python virtual environments and the build process
+-------------------------------------------------
+
+An important step in ``configure`` is to create a Python virtual
+environment (venv) during the configuration phase.  The Python interpreter
+comes from the ``--python`` command line option, the ``$PYTHON`` variable
+from the environment, or the system PATH, in this order.  The venv resides
+in the ``pyvenv`` directory in the build tree, and provides consistency
+in how the build process runs Python code.
+
+At this stage, ``configure`` also queries the chosen Python interpreter
+about QEMU's build dependencies.  Note that the build process does  *not*
+look for ``meson``, ``sphinx-build`` or ``avocado`` binaries in the PATH;
+likewise, there are no options such as ``--meson`` or ``--sphinx-build``.
+This avoids a potential mismatch, where Meson and Sphinx binaries on the
+PATH might operate in a different Python environment than the one chosen
+by the user during the build process.  On the other hand, it introduces
+a potential source of confusion where the user installs a dependency but
+``configure`` is not able to find it.  When this happens, the dependency
+was installed in the ``site-packages`` directory of another interpreter,
+or with the wrong ``pip`` program.
+
+If a package is available for the chosen interpreter, ``configure``
+prepares a small script that invokes it from the venv itself[#distlib]_.
+If not, ``configure`` can also optionally install dependencies in the
+virtual environment with ``pip``, either from wheels in ``python/wheels``
+or by downloading the package with PyPI.  Downloading can be disabled with
+``--disable-download``; and anyway, it only happens when a ``configure``
+option (currently, only ``--enable-docs``) is explicitly enabled but
+the dependencies are not present[#pip]_.
+
+.. [#distlib] The scripts are created based on the package's metadata,
+              specifically the ``console_script`` entry points.  This is the
+              same mechanism that ``pip`` uses when installing a package.
+              Currently, in all cases it would be possible to use ``python -m``
+              instead of an entry point script, which makes this approach a
+              bit overkill.  On the other hand, creating the scripts is
+              future proof and it makes the contents of the ``pyvenv/bin``
+              directory more informative.  Portability is also not an issue,
+              because the Python Packaging Authority provides a package
+              ``distlib.scripts`` to perform this task.
+
+.. [#pip] ``pip`` might also be used when running ``make check-avocado``
+           if downloading is enabled, to ensure that Avocado is
+           available.
+
+The required versions of the packages are stored in a configuration file
+``pythondeps.toml``.  The format is custom to QEMU, but it is documented
+at the top of the file itself and it should be easy to understand.  The
+requirements should make it possible to use the version that is packaged
+that is provided by supported distros.
+
+When dependencies are downloaded, instead, ``configure`` uses a "known
+good" version that is also listed in ``pythondeps.toml``.  In this
+scenario, ``pythondeps.toml`` behaves like the "lock file" used by
+``cargo``, ``poetry`` or other dependency management systems.
+
+
+Bundled Python packages
+-----------------------
+
+Python packages that are **mandatory** dependencies to build QEMU,
+but are not available in all supported distros, are bundled with the
+QEMU sources.  Currently this includes Meson (outdated in CentOS 8
+and derivatives, Ubuntu 20.04 and 22.04, and openSUSE Leap) and tomli
+(absent in Ubuntu 20.04).
+
+If you need to update these, please do so by modifying and rerunning
+``python/scripts/vendor.py``.  This script embeds the sha256 hash of
+package sources and checks it.  The pypi.org web site provides an easy
+way to retrieve the sha256 hash of the sources.
 
-TBD
 
 Stage 2: Meson
 ==============
@@ -376,6 +444,15 @@ This is needed to obey the --python= option passed to the configure
 script, which may point to something other than the first python3
 binary on the path.
 
+By the time Meson runs, Python dependencies are available in the virtual
+environment and should be invoked through the scripts that ``configure``
+places under ``pyvenv``.  One way to do so is as follows, using Meson's
+``find_program`` function::
+
+  sphinx_build = find_program(
+       fs.parent(python.full_path()) / 'sphinx-build',
+       required: get_option('docs'))
+
 
 Stage 3: Make
 =============
@@ -434,6 +511,11 @@ number of dynamically created files listed later.
   executables.  Build rules for various subdirectories are included in
   other meson.build files spread throughout the QEMU source tree.
 
+``python/scripts/mkvenv.py``
+  A wrapper for the Python ``venv`` and ``distlib.scripts`` packages.
+  It handles creating the virtual environment, creating scripts in
+  ``pyvenv/bin``, and calling ``pip`` to install dependencies.
+
 ``tests/Makefile.include``
   Rules for external test harnesses. These include the TCG tests
   and the Avocado-based integration tests.
diff --git a/pythondeps.toml b/pythondeps.toml
index 0a35ebcf9f0..4beadfd96f5 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -10,7 +10,8 @@
 # - accepted: accepted versions when using a system package
 # - installed: fixed version to install in the virtual environment
 #              if a system package is not found; if not specified,
-#              the minimum and maximum
+#              defaults to the same as "accepted" or, if also missing,
+#              to the newest version available on PyPI.
 # - canary: if specified, use this program name to present more
 #           precise error diagnostics to the user.  For example,
 #           'sphinx-build' can be used as a bellwether for the
-- 
2.43.0


