Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC6EA150DD
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Jan 2025 14:47:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYme1-0002K4-Lg; Fri, 17 Jan 2025 08:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmd6-00016U-7h
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:20 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmd3-0002IR-13
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:20 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d9f06f8cf2so4008645a12.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121395; x=1737726195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZVXQImgyXuNo9dYY7O4wSXJ8MQi5BChBt6FVzYz5Oo=;
 b=MejmGd8GHyRF+rgGJzVVRMMc+qaNYj7/4RihyRuX4lIk4/TL8fqVn42vwpmQV70bC0
 eH+KXV80xOBGW4UWDOXIB6g02H0sw4P0MtxmSq3kEYxt0V8/aVgZE4PVbMPQayFDBXa3
 o7CrkUh8fZZtSTRlxw1kncKXTQNj1w2z1lmqN5frpl2Qrin+PZpJc8RqxBFwS3aWhrta
 1MmaaBabALCl5e9267q5jiE7Uhma72+Sb7k8FBT3f6rjrH4fsUkfQei5cdIf3LAn+OTS
 21D+xejJoZYgSL3WD0gCM3EEv7wCeiDyGH/NBgAUqHPnOeWjtGIIqF0hf3NfJDAiez9x
 lPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121395; x=1737726195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LZVXQImgyXuNo9dYY7O4wSXJ8MQi5BChBt6FVzYz5Oo=;
 b=f/Ma0zH+AAB1iTANmKktsk/OhT5Ky3FoM1U3sLLuYIn/JokEg54ep59VAsnkqF31XB
 M4w/4BYS5P0l7flBKMPHrBt1deXQ9Q/BHjey7UYQlw5/ZDPxR/8Nqq/TlWbPiyUjiHHz
 ctFGxt0Rkl5YH0TSyZMwF0QPpLtY5kQf6ISlrzWAv/+gak4MYH9Ck446uZvk7YnQG4fu
 26XnK8J9jln/5ctZL6ZHF5BLPsn8q3BXyULMnyrYLHMy+BtET8f76V7aNWIuQazpwkhL
 1rfOIDA9IcRAMKZ+/LCaKrqs90cjPUOU1Hnf7RmSoIGIhdGFvNJKU60xPaPqlNzwxk0U
 kKwA==
X-Gm-Message-State: AOJu0YzddvwcjMa/oz7B2lsmpVgdqwk9pBT+c6bhuh+oGbGSWgv/ayYx
 Z4upbUlCI/ZHLT0Vn7zgW/G/bOznhwFplSpX+ClQok5bUSIM4qlDrkpRMUDost0=
X-Gm-Gg: ASbGnct4Pn0Efyrx9hjjr2vR8HtT/y+2VzEThYak45aOXZHQMjDz+dBTz8o9X/TZKm8
 sURsqoQdLjknKHLoc+d/h+a4KPBFZYlDNj68kHEhbZE68nGZ3HpzEIo1cUKjuJiBmsGslMBWawm
 J3Rs6lDprhdT0nKd/JalBBBmwcEVoH0OZ2tnzucSp9lmRh13YlyB+E4bxV+/4AFLL6xxJ5uek5x
 rBR+J2UNkGb5cpkj2j+wnlCyVhcZJ/3BqZvqv7lnZcffP4sHooHLVQ=
X-Google-Smtp-Source: AGHT+IHDWbSyKwkeO4AwAZ82MhRXZhEGSBMa0w/jHcstLdrYQkXpM7KgSn3sZ/AI9BCQQ86NxPadpg==
X-Received: by 2002:a05:6402:13d2:b0:5da:d76:7b3f with SMTP id
 4fb4d7f45d1cf-5db7d0f8663mr2430050a12.0.1737121393671; 
 Fri, 17 Jan 2025 05:43:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73eb5b64sm1474330a12.57.2025.01.17.05.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 57F4060866;
 Fri, 17 Jan 2025 13:43:00 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org (open list:Storage daemon)
Subject: [PULL 35/37] docs/devel: add a codebase section
Date: Fri, 17 Jan 2025 13:42:54 +0000
Message-Id: <20250117134256.2079356-36-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Present the various parts of QEMU and organization of codebase.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241209183104.365796-6-pierrick.bouvier@linaro.org>
[AJB: tweak commit summary, update MAINTAINERS]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-36-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index f744896f89..4c86c81f08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -74,6 +74,7 @@ W: https://www.qemu.org/docs/master/devel/index.html
 S: Odd Fixes
 F: docs/devel/build-environment.rst
 F: docs/devel/code-of-conduct.rst
+F: docs/devel/codebase.rst
 F: docs/devel/conflict-resolution.rst
 F: docs/devel/style.rst
 F: docs/devel/submitting-a-patch.rst
diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 3028d5fff7..3bc3579434 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -176,6 +176,8 @@ for that architecture.
     - System
     - Tensilica ISS SIMCALL
 
+.. _tcg-plugins:
+
 TCG Plugins
 -----------
 
diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
new file mode 100644
index 0000000000..4039875ee0
--- /dev/null
+++ b/docs/devel/codebase.rst
@@ -0,0 +1,220 @@
+========
+Codebase
+========
+
+This section presents the various parts of QEMU and how the codebase is
+organized.
+
+Beyond giving succint descriptions, the goal is to offer links to various
+parts of the documentation/codebase.
+
+Subsystems
+----------
+
+An exhaustive list of subsystems and associated files can be found in the
+`MAINTAINERS <https://gitlab.com/qemu-project/qemu/-/blob/master/MAINTAINERS>`_
+file.
+
+Some of the main QEMU subsystems are:
+
+- `Accelerators<Accelerators>`
+- Block devices and `disk images<disk images>` support
+- `CI<ci>` and `Tests<testing>`
+- `Devices<device-emulation>` & Board models
+- `Documentation <documentation-root>`
+- `GDB support<GDB usage>`
+- `Migration<migration>`
+- `Monitor<QEMU monitor>`
+- :ref:`QOM (QEMU Object Model)<qom>`
+- `System mode<System emulation>`
+- :ref:`TCG (Tiny Code Generator)<tcg>`
+- `User mode<user-mode>` (`Linux<linux-user-mode>` & `BSD<bsd-user-mode>`)
+- User Interfaces
+
+More documentation on QEMU subsystems can be found on :ref:`internal-subsystem`
+page.
+
+The Grand tour
+--------------
+
+We present briefly here what every folder in the top directory of the codebase
+contains. Hop on!
+
+The folder name links here will take you to that folder in our gitlab
+repository. Other links will take you to more detailed documentation for that
+subsystem, where we have it. Unfortunately not every subsystem has documentation
+yet, so sometimes the source code is all you have.
+
+* `accel <https://gitlab.com/qemu-project/qemu/-/tree/master/accel>`_:
+  Infrastructure and architecture agnostic code related to the various
+  `accelerators <Accelerators>` supported by QEMU
+  (TCG, KVM, hvf, whpx, xen, nvmm).
+  Contains interfaces for operations that will be implemented per
+  `target <https://gitlab.com/qemu-project/qemu/-/tree/master/target>`_.
+* `audio <https://gitlab.com/qemu-project/qemu/-/tree/master/audio>`_:
+  Audio (host) support.
+* `authz <https://gitlab.com/qemu-project/qemu/-/tree/master/authz>`_:
+  `QEMU Authorization framework<client authorization>`.
+* `backends <https://gitlab.com/qemu-project/qemu/-/tree/master/backends>`_:
+  Various backends that are used to access resources on the host (e.g. for
+  random number generation, memory backing or cryptographic functions).
+* `block <https://gitlab.com/qemu-project/qemu/-/tree/master/block>`_:
+  Block devices and `image formats<disk images>` implementation.
+* `bsd-user <https://gitlab.com/qemu-project/qemu/-/tree/master/bsd-user>`_:
+  `BSD User mode<bsd-user-mode>`.
+* build: Where the code built goes by default. You can tell the QEMU build
+  system to put the built code anywhere else you like.
+* `chardev <https://gitlab.com/qemu-project/qemu/-/tree/master/chardev>`_:
+  Various backends used by char devices.
+* `common-user <https://gitlab.com/qemu-project/qemu/-/tree/master/common-user>`_:
+  User-mode assembly code for dealing with signals occuring during syscalls.
+* `configs <https://gitlab.com/qemu-project/qemu/-/tree/master/configs>`_:
+  Makefiles defining configurations to build QEMU.
+* `contrib <https://gitlab.com/qemu-project/qemu/-/tree/master/contrib>`_:
+  Community contributed devices/plugins/tools.
+* `crypto <https://gitlab.com/qemu-project/qemu/-/tree/master/crypto>`_:
+  Cryptographic algorithms used in QEMU.
+* `disas <https://gitlab.com/qemu-project/qemu/-/tree/master/disas>`_:
+  Disassembly functions used by QEMU target code.
+* `docs <https://gitlab.com/qemu-project/qemu/-/tree/master/docs>`_:
+  QEMU Documentation.
+* `dump <https://gitlab.com/qemu-project/qemu/-/tree/master/dump>`_:
+  Code to dump memory of a running VM.
+* `ebpf <https://gitlab.com/qemu-project/qemu/-/tree/master/ebpf>`_:
+  eBPF program support in QEMU. `virtio-net RSS<ebpf-rss>` uses it.
+* `fpu <https://gitlab.com/qemu-project/qemu/-/tree/master/fpu>`_:
+  Floating-point software emulation.
+* `fsdev <https://gitlab.com/qemu-project/qemu/-/tree/master/fsdev>`_:
+  `VirtFS <https://www.linux-kvm.org/page/VirtFS>`_ support.
+* `gdbstub <https://gitlab.com/qemu-project/qemu/-/tree/master/gdbstub>`_:
+  `GDB <GDB usage>` support.
+* `gdb-xml <https://gitlab.com/qemu-project/qemu/-/tree/master/gdb-xml>`_:
+  Set of XML files describing architectures and used by `gdbstub <GDB usage>`.
+* `host <https://gitlab.com/qemu-project/qemu/-/tree/master/host>`_:
+  Various architecture specific header files (crypto, atomic, memory
+  operations).
+* `linux-headers <https://gitlab.com/qemu-project/qemu/-/tree/master/linux-headers>`_:
+  A subset of headers imported from Linux kernel and used for implementing
+  KVM support and user-mode.
+* `linux-user <https://gitlab.com/qemu-project/qemu/-/tree/master/linux-user>`_:
+  `User mode <user-mode>` implementation. Contains one folder per target
+  architecture.
+* `.gitlab-ci.d <https://gitlab.com/qemu-project/qemu/-/tree/master/.gitlab-ci.d>`_:
+  `CI <ci>` yaml and scripts.
+* `include <https://gitlab.com/qemu-project/qemu/-/tree/master/include>`_:
+  All headers associated to different subsystems in QEMU. The hierachy used
+  mirrors source code organization and naming.
+* `hw <https://gitlab.com/qemu-project/qemu/-/tree/master/hw>`_:
+  `Devices <device-emulation>` and boards emulation. Devices are categorized by
+  type/protocol/architecture and located in associated subfolder.
+* `io <https://gitlab.com/qemu-project/qemu/-/tree/master/io>`_:
+  QEMU `I/O channels <https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg04208.html>`_.
+* `libdecnumber <https://gitlab.com/qemu-project/qemu/-/tree/master/libdecnumber>`_:
+  Import of gcc library, used to implement decimal number arithmetic.
+* `migration <https://gitlab.com/qemu-project/qemu/-/tree/master/migration>`__:
+  `Migration framework <migration>`.
+* `monitor <https://gitlab.com/qemu-project/qemu/-/tree/master/monitor>`_:
+  `Monitor <QEMU monitor>` implementation (HMP & QMP).
+* `nbd <https://gitlab.com/qemu-project/qemu/-/tree/master/nbd>`_:
+  QEMU `NBD (Network Block Device) <nbd>` server.
+* `net <https://gitlab.com/qemu-project/qemu/-/tree/master/net>`_:
+  Network (host) support.
+* `pc-bios <https://gitlab.com/qemu-project/qemu/-/tree/master/pc-bios>`_:
+  Contains pre-built firmware binaries and boot images, ready to use in
+  QEMU without compilation.
+* `plugins <https://gitlab.com/qemu-project/qemu/-/tree/master/plugins>`_:
+  :ref:`TCG plugins <tcg-plugins>` core implementation. Plugins can be found in
+  `tests <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/tcg/plugins>`__
+  and `contrib <https://gitlab.com/qemu-project/qemu/-/tree/master/contrib/plugins>`__
+  folders.
+* `po <https://gitlab.com/qemu-project/qemu/-/tree/master/po>`_:
+  Translation files.
+* `python <https://gitlab.com/qemu-project/qemu/-/tree/master/python>`_:
+  Python part of our build/test system.
+* `qapi <https://gitlab.com/qemu-project/qemu/-/tree/master/qapi>`_:
+  `QAPI <qapi>` implementation.
+* `qobject <https://gitlab.com/qemu-project/qemu/-/tree/master/qobject>`_:
+  QEMU Object implementation.
+* `qga <https://gitlab.com/qemu-project/qemu/-/tree/master/qga>`_:
+  QEMU `Guest agent <qemu-ga>` implementation.
+* `qom <https://gitlab.com/qemu-project/qemu/-/tree/master/qom>`_:
+  QEMU :ref:`Object model <qom>` implementation, with monitor associated commands.
+* `replay <https://gitlab.com/qemu-project/qemu/-/tree/master/replay>`_:
+  QEMU :ref:`Record/replay <replay>` implementation.
+* `roms <https://gitlab.com/qemu-project/qemu/-/tree/master/roms>`_:
+  Contains source code for various firmware and ROMs, which can be compiled if
+  custom or updated versions are needed.
+* `rust <https://gitlab.com/qemu-project/qemu/-/tree/master/rust>`_:
+  Rust integration in QEMU. It contains the new interfaces defined and
+  associated devices using it.
+* `scripts <https://gitlab.com/qemu-project/qemu/-/tree/master/scripts>`_:
+  Collection of scripts used in build and test systems, and various
+  tools for QEMU codebase and execution traces.
+* `scsi <https://gitlab.com/qemu-project/qemu/-/tree/master/scsi>`_:
+  Code related to SCSI support, used by SCSI devices.
+* `semihosting <https://gitlab.com/qemu-project/qemu/-/tree/master/semihosting>`_:
+  QEMU `Semihosting <Semihosting>` implementation.
+* `stats <https://gitlab.com/qemu-project/qemu/-/tree/master/stats>`_:
+  `Monitor <QEMU monitor>` stats commands implementation.
+* `storage-daemon <https://gitlab.com/qemu-project/qemu/-/tree/master/storage-daemon>`_:
+  QEMU `Storage daemon <storage-daemon>` implementation.
+* `stubs <https://gitlab.com/qemu-project/qemu/-/tree/master/stubs>`_:
+  Various stubs (empty functions) used to compile QEMU with specific
+  configurations.
+* `subprojects <https://gitlab.com/qemu-project/qemu/-/tree/master/subprojects>`_:
+  QEMU submodules used by QEMU build system.
+* `system <https://gitlab.com/qemu-project/qemu/-/tree/master/system>`_:
+  QEMU `system mode <System emulation>` implementation (cpu, mmu, boot support).
+* `target <https://gitlab.com/qemu-project/qemu/-/tree/master/target>`_:
+  Contains code for all target architectures supported (one subfolder
+  per arch). For every architecture, you can find accelerator specific
+  implementations.
+* `tcg <https://gitlab.com/qemu-project/qemu/-/tree/master/tcg>`_:
+  :ref:`TCG <tcg>` related code.
+  Contains one subfolder per host supported architecture.
+* `tests <https://gitlab.com/qemu-project/qemu/-/tree/master/tests>`_:
+  QEMU `test <testing>` suite
+
+  - `avocado <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/avocado>`_:
+    Functional tests booting full VM using `Avocado framework <checkavocado-ref>`.
+    Those tests will be transformed and moved into
+    `tests/functional <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/functional>`_
+    in the future.
+  - `data <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/data>`_:
+    Data for various tests.
+  - `decode <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/decode>`_:
+    Testsuite for :ref:`decodetree <decodetree>` implementation.
+  - `docker <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/docker>`_:
+    Code and scripts to create `containers <container-ref>` used in `CI <ci>`.
+  - `fp <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/fp>`_:
+    QEMU testsuite for soft float implementation.
+  - `functional <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/functional>`_:
+    `Functional tests <checkfunctional-ref>` (full VM boot).
+  - `lcitool <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/lcitool>`_:
+    Generate dockerfiles for CI containers.
+  - `migration <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/migration>`_:
+    Test scripts and data for `Migration framework <migration>`.
+  - `multiboot <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/multiboot>`_:
+    Test multiboot functionality for x86_64/i386.
+  - `qapi-schema <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/qapi-schema>`_:
+    Test scripts and data for `QAPI <qapi-tests>`.
+  - `qemu-iotests <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/qemu-iotests>`_:
+    `Disk image and block tests <qemu-iotests>`.
+  - `qtest <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/qtest>`_:
+    `Device emulation testing <qtest>`.
+  - `tcg <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/tcg>`__:
+    `TCG related tests <checktcg-ref>`. Contains code per architecture
+    (subfolder) and multiarch tests as well.
+  - `tsan <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/tsan>`_:
+    `Suppressions <tsan-suppressions>` for thread sanitizer.
+  - `uefi-test-tools <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/uefi-test-tools>`_:
+    Test tool for UEFI support.
+  - `unit <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/unit>`_:
+    QEMU `Unit tests <unit-tests>`.
+* `trace <https://gitlab.com/qemu-project/qemu/-/tree/master/trace>`_:
+  :ref:`Tracing framework <tracing>`. Used to print information associated to various
+  events during execution.
+* `ui <https://gitlab.com/qemu-project/qemu/-/tree/master/ui>`_:
+  QEMU User interfaces.
+* `util <https://gitlab.com/qemu-project/qemu/-/tree/master/util>`_:
+  Utility code used by other parts of QEMU.
diff --git a/docs/devel/decodetree.rst b/docs/devel/decodetree.rst
index e3392aa705..98ad33a487 100644
--- a/docs/devel/decodetree.rst
+++ b/docs/devel/decodetree.rst
@@ -1,3 +1,5 @@
+.. _decodetree:
+
 ========================
 Decodetree Specification
 ========================
diff --git a/docs/devel/ebpf_rss.rst b/docs/devel/ebpf_rss.rst
index 4a68682b31..ed5d33767b 100644
--- a/docs/devel/ebpf_rss.rst
+++ b/docs/devel/ebpf_rss.rst
@@ -1,3 +1,5 @@
+.. _ebpf-rss:
+
 ===========================
 eBPF RSS virtio-net support
 ===========================
diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index ab9fbc4482..bca597c658 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -1,3 +1,5 @@
+.. _internal-subsystem:
+
 Internal Subsystem Information
 ------------------------------
 
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index a53f1bfda5..29f032d6a8 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -35,3 +35,4 @@ the :ref:`tcg_internals`.
    index-api
    index-internals
    index-tcg
+   codebase
diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index c2857fc244..cdd4f4a6d7 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -1,3 +1,5 @@
+.. _migration:
+
 ===================
 Migration framework
 ===================
diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 583207a8ec..3e26d2d104 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -9,6 +9,7 @@ How to use the QAPI code generator
    This work is licensed under the terms of the GNU GPL, version 2 or
    later.  See the COPYING file in the top-level directory.
 
+.. _qapi:
 
 Introduction
 ============
diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 91f4dc61fb..9869bcf034 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -39,6 +39,8 @@ Before running tests, it is best to build QEMU programs first. Some tests
 expect the executables to exist and will fail with obscure messages if they
 cannot find them.
 
+.. _unit-tests:
+
 Unit tests
 ~~~~~~~~~~
 
@@ -126,6 +128,8 @@ successfully on various hosts. The following list shows some best practices:
   #ifdef in the codes. If the whole test suite cannot run on Windows, disable
   the build in the meson.build file.
 
+.. _qapi-tests:
+
 QAPI schema tests
 ~~~~~~~~~~~~~~~~~
 
@@ -160,6 +164,8 @@ check-block
 are in the "auto" group).
 See the "QEMU iotests" section below for more information.
 
+.. _qemu-iotests:
+
 QEMU iotests
 ------------
 
@@ -679,6 +685,8 @@ The above exitcode=0 has TSan continue without error if any warnings are found.
 This allows for running the test and then checking the warnings afterwards.
 If you want TSan to stop and exit with error on warnings, use exitcode=66.
 
+.. _tsan-suppressions:
+
 TSan Suppressions
 ~~~~~~~~~~~~~~~~~
 Keep in mind that for any data race warning, although there might be a data race
@@ -901,7 +909,6 @@ You can run the avocado tests simply by executing:
 
 See :ref:`checkavocado-ref` for more details.
 
-
 .. _checktcg-ref:
 
 Testing with "make check-tcg"
diff --git a/docs/devel/testing/qtest.rst b/docs/devel/testing/qtest.rst
index c5b8546b3e..73ef7702b7 100644
--- a/docs/devel/testing/qtest.rst
+++ b/docs/devel/testing/qtest.rst
@@ -1,3 +1,5 @@
+.. _qtest:
+
 ========================================
 QTest Device Emulation Testing Framework
 ========================================
diff --git a/docs/index.rst b/docs/index.rst
index 0b9ee9901d..78285ebd6a 100644
--- a/docs/index.rst
+++ b/docs/index.rst
@@ -3,6 +3,8 @@
    You can adapt this file completely to your liking, but it should at least
    contain the root `toctree` directive.
 
+.. _documentation-root:
+
 ================================
 Welcome to QEMU's documentation!
 ================================
diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
index 11f7bae460..d16cc1b9f0 100644
--- a/docs/interop/qemu-ga.rst
+++ b/docs/interop/qemu-ga.rst
@@ -1,3 +1,5 @@
+.. _qemu-ga:
+
 QEMU Guest Agent
 ================
 
diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index 384e95ba76..cfe1acb78a 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -500,6 +500,8 @@ What you should *never* do:
 - expect it to work when loadvm'ing
 - write to the FAT directory on the host system while accessing it with the guest system
 
+.. _nbd:
+
 NBD access
 ~~~~~~~~~~
 
diff --git a/docs/tools/qemu-storage-daemon.rst b/docs/tools/qemu-storage-daemon.rst
index ea00149a63..35ab2d7807 100644
--- a/docs/tools/qemu-storage-daemon.rst
+++ b/docs/tools/qemu-storage-daemon.rst
@@ -1,3 +1,5 @@
+.. _storage-daemon:
+
 ===================
 QEMU Storage Daemon
 ===================
diff --git a/docs/user/main.rst b/docs/user/main.rst
index 7a126ee809..80a77f0a0c 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -1,3 +1,5 @@
+.. _user-mode:
+
 QEMU User space emulator
 ========================
 
@@ -42,6 +44,8 @@ QEMU was conceived so that ultimately it can emulate itself. Although it
 is not very useful, it is an important test to show the power of the
 emulator.
 
+.. _linux-user-mode:
+
 Linux User space emulator
 -------------------------
 
@@ -175,6 +179,8 @@ Other binaries
    * ``qemu-sparc64`` can execute some Sparc64 (Sparc64 CPU, 64 bit ABI) and
      SPARC32PLUS binaries (Sparc64 CPU, 32 bit ABI).
 
+.. _bsd-user-mode:
+
 BSD User space emulator
 -----------------------
 
-- 
2.39.5


