Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F18767E8B63
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 16:30:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1pvZ-0003og-Fa; Sat, 11 Nov 2023 10:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1pvY-0003nm-0b
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 10:29:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1pvW-0008IM-1g
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 10:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699716576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s78/VPPynP7lIUS0i/tpFzeRlgCgx/plWuOQnPmw7pM=;
 b=ZlGjDEjg0GGvbLjVSMFL+TatCMgJ1nRKLcN+qPY89UrRhbBe9EzelX4zUiAVWxU3gSl6Us
 FUP63c6qcWiDGoPN7kGoI1YF2/mixuQwSgBJ86Oef6IYD6/GqidGz/pGsWoskaLAWEnpu6
 RJAPYc4fTnB4DPZWDpYO/yow9QMglTM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-U4CeP_78NwKbyqytjzKEtQ-1; Sat, 11 Nov 2023 10:29:34 -0500
X-MC-Unique: U4CeP_78NwKbyqytjzKEtQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9e61e969b19so115130166b.2
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 07:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699716573; x=1700321373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s78/VPPynP7lIUS0i/tpFzeRlgCgx/plWuOQnPmw7pM=;
 b=SrZFvUdYf+8L8cB8uaA8QakkJeLgK59HBIMNTKAYB2U4LYli+G3rb7NEURChXmawxE
 HbhlPHBAAnqInsE9KsMUcDZ8siy4YvjualR0Hgt3NLj6S9BysPZHX5QGBWOiR8wnW0vQ
 tmsKAg/OH9tYrweq4D48/tuWo5ah5wP1zIo3h0fcJUgjVBUDxL51AHefbTvtP/r51Jc7
 dSTAPKW3NLFg+q4emwWg/GQhXBU4tO0FxWsgy26WfNvASaols0qkvlFtz2szyYGNYR7/
 1GYbh/Mei2/o67aVzRQHCKNxqGBocIwxbDpNkQsAnMeU9AgL38ur3JYaiu3Wjt00+vFK
 p/ig==
X-Gm-Message-State: AOJu0Yw+syog/XoIMBQxi77k3iauIt6koITuNIobHmRvD79C8xJulQV5
 q8TB43AqxnLvjoFSSGLRRTb2f1AC8bUERz3wW0qxs231gFue1NhOuGgE3UexfD/L+ywUNUzx7r3
 Aauqa8mzDk7ZwWVVLTqpEDOmuW7ZtivUw8ACELeUaUHOkUUnXrV4+tuEc4mwIRD1gXAOGmwe+H0
 8=
X-Received: by 2002:a17:906:24d9:b0:9d3:ccf0:7617 with SMTP id
 f25-20020a17090624d900b009d3ccf07617mr1187758ejb.44.1699716572789; 
 Sat, 11 Nov 2023 07:29:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgjLzetCqra8GvX+3/eL9OQhAvEyouiNWaWIZdy93ULNLR3bkUB59Ise5//DLHqs9sUHt/Tg==
X-Received: by 2002:a17:906:24d9:b0:9d3:ccf0:7617 with SMTP id
 f25-20020a17090624d900b009d3ccf07617mr1187746ejb.44.1699716572352; 
 Sat, 11 Nov 2023 07:29:32 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a1709062e8a00b009e676a5b158sm1194895eji.83.2023.11.11.07.29.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 07:29:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/6] docs: document what configure does with virtual
 environments
Date: Sat, 11 Nov 2023 16:29:20 +0100
Message-ID: <20231111152923.966998-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231111152923.966998-1-pbonzini@redhat.com>
References: <20231111152923.966998-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Given the recent confusion around how QEMU detects the system
Meson installation, and/or decides to install its own, it is
time to fill in the "Python virtual environments and the QEMU
build system" section of the documentation.

As a curiosity, a first and partial draft of the text was generated
by an LLM[1].  It required quite a bit of editing and probably did not
save much time, but some expressions do remain in the finished text.

[1] https://chat.openai.com/share/42c1500d-71c1-480b-bab9-7ccc2c155365

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
2.41.0


