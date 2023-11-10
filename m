Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C7C7E7AFC
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:39:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1NyA-0002UL-T2; Fri, 10 Nov 2023 04:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1Ny9-0002TY-Np
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:38:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1Ny6-0006W3-Jt
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699609106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s78/VPPynP7lIUS0i/tpFzeRlgCgx/plWuOQnPmw7pM=;
 b=icV+HDPUTFagyoeYQ1SaH1Wfiajd00BlJ7q+BCcY+pNfbtJHdfVW7lC3zVMIHZ5d9cBt5P
 BgFVuy5Q4eol/AX9zQmXmhSWs6q6LFHXvPAivj71L3CR9DUAwHGkCT5z3+YNuXXPwkqIYy
 6rKheypcAaD6gcXSZ20K2Ng2+btJILA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-57g-7-_fNiSEShDdl8PQMA-1; Fri, 10 Nov 2023 04:38:24 -0500
X-MC-Unique: 57g-7-_fNiSEShDdl8PQMA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-54442ba286fso1493380a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 01:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699609103; x=1700213903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s78/VPPynP7lIUS0i/tpFzeRlgCgx/plWuOQnPmw7pM=;
 b=m3pzAQFGgPQd00+3zeSaUdQo7TDSGHEgEQJs0iWnoFh/ac+eBrZwJ+5+HkFay+GdVK
 9nQDhCThOQNWIodcbEgZRd4csaD/r1U7zbvotqEcUAhMfdZz8FH8uA1V3lyOYGPyK011
 Ml4Y0aAs4OOtyZDMGltKlHggcZkGILvSd04ZnOxDHUam6oNPO20u4wfgOe8pZpoSOn3u
 sC4zLSIyFISBAw5tW47SxPcQKC0fsJPlkwCvDiX4g5uRXBlFnqmq0tRk52x38au5RTjv
 7VcAikzzWIeg6TutF48WmhauwQcWxbN6UI7X9SUG7tbq0unNrrRYl0K6O21Y9U1f4/Pu
 Kn5w==
X-Gm-Message-State: AOJu0YzJ1+HdnJA7ZchL2Dsyhu3ZAmh1kNuV+0m0mDGUg0us7HpppmmO
 jWOHeRSptAFiegmuAgEX+8yAGmAU4SP23q6CiOXQhjiHp4/cRja1R/NPNfG9vyY/zXeb7Jg8MoU
 U3pnzdcWEGu2tws8H/xL9ZdVpls1+mascuWwB7ej6tugHNFboUfuJNz213JgMvk5APA9dHVXU+w
 c=
X-Received: by 2002:a50:8a81:0:b0:53e:1b:15f5 with SMTP id
 j1-20020a508a81000000b0053e001b15f5mr6165510edj.39.1699609102755; 
 Fri, 10 Nov 2023 01:38:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjKx93YFzoFBEarGXyjKHvep5Qkn9kRGsCNjZzqke7S9n61PY1MrKWzBx9H/LgzHxJGFj/PQ==
X-Received: by 2002:a50:8a81:0:b0:53e:1b:15f5 with SMTP id
 j1-20020a508a81000000b0053e001b15f5mr6165488edj.39.1699609102335; 
 Fri, 10 Nov 2023 01:38:22 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 a89-20020a509ee2000000b00546cf67c348sm884345edf.59.2023.11.10.01.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 01:38:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, balaton@eik.bme.hu,
 jsnow@redhat.com, thuth@redhat.com
Subject: [PATCH v2] docs: document what configure does with virtual
 environments
Date: Fri, 10 Nov 2023 10:38:20 +0100
Message-ID: <20231110093820.918450-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


