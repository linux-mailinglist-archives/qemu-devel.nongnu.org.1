Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 213277E6E1B
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:00:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r17R4-0003UA-Vl; Thu, 09 Nov 2023 10:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r17R2-0003S9-8k
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:59:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r17Qt-0000KB-8f
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699545541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=O8Uc+C1hjaKj812Txk32BEjAcJa4MQbq8d+ALGS3iPQ=;
 b=d09IHGQEzjWuCWyHRcXkBnOCOt1QEQ5xPsINtNM14Au8Wg6QcaTTAHdluC5Z6Mvu+sIRCj
 UDvt7xm6+G3lwvnLkWW4Oz7IWdAhmVkzT8fsHfJQuAIs+6Yjd8NaKe9cpQSxgCAhOyI6XD
 Lvsy8PvM2hNGXUQMk3zqPBjGIr9wJEQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-TAIiOdO7MW-7W2IY3-o1aQ-1; Thu, 09 Nov 2023 10:58:59 -0500
X-MC-Unique: TAIiOdO7MW-7W2IY3-o1aQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9e1020e2996so84084866b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 07:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699545538; x=1700150338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O8Uc+C1hjaKj812Txk32BEjAcJa4MQbq8d+ALGS3iPQ=;
 b=o+rNhYsV7ypTskSFv+9uSNCtty55vBHGDdsD6udXQbLWnNgj945sQ1NY7+CXUjrjr3
 fpNWPnTl7HPOpjbQBp/RfWUlwbQmBn3Nc0iuC9+bw+sKdhQALxHzWsSb7EUNp05QILej
 /UCEa5HRVHkCPgEEbO/TkkDLjevrQtKxeBxAIghmXt1dZaJdFL1gGVHMoSRO4qT4rQ5k
 IcQ3RgW9LFJtjutzOm+IHtk4vAdwpBJl0W6eXQ7IrrEZTOIk5Xeue4WysoisScmDRARI
 NJLebiQGiLgPH5QgvUzjiQGdMba5No+yTd0wpu9YQchhPjsS+xyvMHtzDnjdFSpWYAdV
 gelw==
X-Gm-Message-State: AOJu0YzkoQWTL/47aSYHuHVXUwfz0QjOGjaRGhmRcs31TnyLAd8WLJtS
 wMuVMboKlWMMqVL2wGE6rBeiPu93GWWPT1QhvO7grbeTv0J/uVbLQIC8SiZL4VEeDSyQcbf7UKx
 X2zFunf8eCQA308cRxaVWAb0CMCumMdXU/OAJIa4wC92DN+9Wul1CLSEcvhyTIgTsksHZRqF3lA
 Y=
X-Received: by 2002:a17:906:dacb:b0:9c7:59d1:b2c2 with SMTP id
 xi11-20020a170906dacb00b009c759d1b2c2mr4285442ejb.27.1699545537764; 
 Thu, 09 Nov 2023 07:58:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJk2OvCPCm5oyWyTxVf8ltOpFR9Xn5kTS4yzbvDon/fti+gP6/sbLmGgN+hfJ+7O6SDI+DKA==
X-Received: by 2002:a17:906:dacb:b0:9c7:59d1:b2c2 with SMTP id
 xi11-20020a170906dacb00b009c759d1b2c2mr4285425ejb.27.1699545537350; 
 Thu, 09 Nov 2023 07:58:57 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a1709063e4b00b0099cb349d570sm2696364eji.185.2023.11.09.07.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 07:58:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, balaton@eik.bme.hu,
 jsnow@redhat.com, thuth@redhat.com
Subject: [PATCH] docs: document what configure does with virtual environments
Date: Thu,  9 Nov 2023 16:58:55 +0100
Message-ID: <20231109155855.844630-1-pbonzini@redhat.com>
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
 docs/devel/build-system.rst | 54 ++++++++++++++++++++++++++++++++++---
 pythondeps.toml             |  3 ++-
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 21f78da7d1d..4def2e55e73 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -122,10 +122,49 @@ functioning.  These are performed using a few more helper functions:
    indicated by $TMPC.
 
 
-Python virtual environments and the QEMU build system
------------------------------------------------------
+Python virtual environments and the build process
+-------------------------------------------------
+
+An important part of configure is to create a Python virtual environment
+(venv) during the configuration phase, using the Python interpreter that
+``configure`` identified, or that was requested via the ``--python``
+command line option and the ``$PYTHON`` variable from the environment.
+The venv resides in the ``pyvenv`` directory in the build tree,
+and provides consistency in how the build process runs Python code.
+In particular it avoids a potential mismatch, where Meson and Sphinx
+binaries on the PATH might operate in a different Python environment
+than the one chosen by the user during the build process.
+
+At this stage, ``configure`` also queries the chosen Python interpreter
+about QEMU's build dependencies.  ``configure`` does  *not*
+pick the ``meson``, ``sphinx-build`` or ``avocado`` binaries in the PATH;
+likewise, there are no options such as ``--meson`` or ``sphinx-build``.
+If QEMU does not find a dependency, check that it was installed in the
+right ``site-packages`` directory or with the right ``pip`` program.
+
+If the package is available as a system package for the chosen
+interpreter, ``configure`` prepares a small script that invokes it
+from the venv itself.  If not, ``configure`` can also optionally
+install dependencies in the virtual environment with ``pip``.
+Downloading is triggered only when a ``configure`` option (currently,
+only ``--enable-docs``) is explicitly enabled but the dependencies are
+not present, and can also be disabled with ``--disable-download``.[#pip]_
+
+.. [#pip_] Avocado can also be installed with ``pip`` in the virtual
+           environment when running ``make check-avocado``.  In this
+           case, it is not currently possible to block the downloading.
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
 
-TBD
 
 Stage 2: Meson
 ==============
@@ -376,6 +415,15 @@ This is needed to obey the --python= option passed to the configure
 script, which may point to something other than the first python3
 binary on the path.
 
+By the time Meson runs, Python dependencies are available in the virtual
+environment and should be invoked though the scripts that ``configure``
+places under ``pyvenv``.  One way to do so is as follows, using Meson's
+``find_program`` function::
+
+  sphinx_build = find_program(
+       fs.parent(python.full_path()) / 'sphinx-build',
+       required: get_option('docs'))
+
 
 Stage 3: Make
 =============
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


