Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 840237B9ABF
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 06:52:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGKU-0005Sm-VZ; Thu, 05 Oct 2023 00:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGKH-0005Gy-IA
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:51:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGK0-0005Ql-HU
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:51:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-405361bb94eso5254445e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 21:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696481445; x=1697086245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G5/bL+UFb8aN7V1hRtFDrx4S/Prog5l18VX5gdr2wlo=;
 b=vsogpc9VOjBJtK0AcDTd/9UpKnb2IedL12rktCegIHF6aM1wYhbdfXXFv+mcGfabJb
 KGTskxRfWbh9NnJW8xRrX3ltVLPZCtC63dSXLMbmtJN8W4bYkOVp2SuUmIkCpzTqLxp4
 iZ7QddHoS+n5WoW8GDxJCJqIFkL4TtxNVMuBiYiV29C0gPmwBAd9rQgOiv9rBPyQjMn1
 4i7W/oOEVbVAwux7ipKnongfpADHrJ3yseHteU0pw0rDDunWQ3brovjfcPldGhrKozxN
 SE65wylwkazP+HVIU6dD32dMDWwrcuvBPEuocywV/gMWVZjHs+exXiKnxu55JO+BCwJH
 h6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696481445; x=1697086245;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G5/bL+UFb8aN7V1hRtFDrx4S/Prog5l18VX5gdr2wlo=;
 b=kfuAc2Njs5zbogSpVKlAPwL0ttruSIGdMN04LORDvjIqGKRgYKxTniBBe+AiBUI539
 XO7RkdmIw1xyocIT+t9SjQxd1k0ZCKfrSccuhElIOPLIYzt1/eOCMV34LhbfPBmusW5G
 OvvPh/YdeXAVK+q/P1PD2T35xfgKIjLtZpLiBR8T9LBCIovj9car7GspyI4VjlEYErXX
 /ZXD97D+lSJM5oxaBN6x743w+M9Hr7Jm06zfuOD/JkzNLvSLmowpm+t9LtXH3YWmCFK6
 XGxAbPA/PPxo67NqKITATNc7k9/X1YvOCcauzwy8GWrnBAOz5pwctv8MaBSfBM1FDGXO
 700Q==
X-Gm-Message-State: AOJu0Yz93fGR3L6W6wE/fCnwjw0mbsA7PCbHhZ3ahfvROmZxh5yAsnP5
 D9lxtwgxb64GARsRtqka0EYzmfuBSELATkZGwsk=
X-Google-Smtp-Source: AGHT+IHtIxae6pMe+yle46vIAqmQ1lXBJXfxQZ04grEB+PU+BSYCOk7/jxBfL08mlbJ6/aAGkaYajA==
X-Received: by 2002:a7b:ce8f:0:b0:3fe:2bb1:11ba with SMTP id
 q15-20020a7bce8f000000b003fe2bb111bamr4169410wmj.27.1696481444698; 
 Wed, 04 Oct 2023 21:50:44 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr.
 [176.171.211.120]) by smtp.gmail.com with ESMTPSA id
 k22-20020a7bc416000000b00404719b05b5sm617269wmi.27.2023.10.04.21.50.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 21:50:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/22] qapi: Kill 'qapi/qmp/qerror.h' for good
Date: Thu,  5 Oct 2023 06:50:17 +0200
Message-ID: <20231005045041.52649-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since v1:
- Fixed checkpatch warnings (Juan)
- Added R-b tags
- New patch for 'vcpu_dirty_limit'

Hi,

This is kind of a selfish series. I'm really tired to grep
and read this comment from 2015 in qapi/qmp/qerror.h:
      /*
       * These macros will go away, please don't use
       * in new code, and do not add new ones!
       */

Besides, these definitions are still added in recent code
(see for example commit 09f9ec9913 from June 2023). So
let's finish with this 8 years old technical debt.

Overall it took me 3h: 1h to find the correct Coccinelle
doc about Python use and read it again [*], then 1h to
adapt the script for each patch, rest is testing and
writing comments, so the scripts used could be used as
reference later.

Regards,

Phil.

[*] https://www.lrz.de/services/compute/courses/x_lecturenotes/hspc1w19.pdf

Philippe Mathieu-Daudé (22):
  qapi: Inline and remove QERR_BUS_NO_HOTPLUG definition
  qapi: Inline and remove QERR_DEVICE_HAS_NO_MEDIUM definition
  qapi: Inline and remove QERR_DEVICE_IN_USE definition
  qapi: Inline and remove QERR_DEVICE_NO_HOTPLUG definition
  qapi: Inline QERR_INVALID_PARAMETER definition (constant parameter)
  qapi: Inline and remove QERR_INVALID_PARAMETER definition
  qapi: Inline QERR_INVALID_PARAMETER_TYPE definition (constant param)
  qapi: Inline QERR_INVALID_PARAMETER_TYPE definition (constant value)
  qapi: Inline and remove QERR_INVALID_PARAMETER_TYPE definition
  qapi: Correct error message for 'vcpu_dirty_limit' parameter
  qapi: Inline QERR_INVALID_PARAMETER_VALUE definition (constant value)
  qapi: Inline QERR_INVALID_PARAMETER_VALUE definition (constant param)
  qapi: Inline and remove QERR_INVALID_PARAMETER_VALUE definition
  qapi: Inline and remove QERR_IO_ERROR definition
  qapi: Inline and remove QERR_MIGRATION_ACTIVE definition
  qapi: Inline QERR_MISSING_PARAMETER definition (constant parameter)
  qapi: Inline and remove QERR_MISSING_PARAMETER definition
  qapi: Inline and remove QERR_PROPERTY_VALUE_BAD definition
  qapi: Inline and remove QERR_PROPERTY_VALUE_OUT_OF_RANGE definition
  qapi: Inline and remove QERR_QGA_COMMAND_FAILED  definition
  RFC qapi: Inline and remove QERR_UNSUPPORTED definition
  qapi: Remove 'qapi/qmp/qerror.h' header

 qga/qapi-schema.json             |   5 +-
 include/qapi/qmp/qerror.h        |  62 -------------------
 backends/cryptodev-vhost-user.c  |   5 +-
 backends/dbus-vmstate.c          |   3 +-
 backends/rng-egd.c               |   5 +-
 backends/rng-random.c            |   4 +-
 block/gluster.c                  |  22 +++----
 block/monitor/block-hmp-cmds.c   |   7 +--
 block/quorum.c                   |   4 +-
 block/snapshot.c                 |   5 +-
 block/vmdk.c                     |   9 ++-
 blockdev.c                       |  16 +++--
 blockjob.c                       |   4 +-
 chardev/char-fe.c                |   3 +-
 chardev/char.c                   |   4 +-
 dump/dump.c                      |  11 ++--
 dump/win_dump.c                  |   5 +-
 hw/core/qdev-properties-system.c |   6 +-
 hw/core/qdev-properties.c        |   3 +-
 hw/core/qdev.c                   |   4 +-
 hw/intc/openpic.c                |   4 +-
 hw/ppc/spapr_pci.c               |   5 +-
 hw/usb/redirect.c                |   7 +--
 migration/migration.c            |   7 +--
 migration/options.c              | 102 +++++++++++++------------------
 migration/page_cache.c           |   9 ++-
 migration/ram.c                  |   5 +-
 migration/savevm.c               |   7 +--
 monitor/fds.c                    |   9 ++-
 monitor/hmp-cmds.c               |   3 +-
 monitor/qmp-cmds.c               |   4 +-
 net/filter-buffer.c              |   4 +-
 net/filter.c                     |   8 +--
 net/net.c                        |  10 ++-
 qapi/opts-visitor.c              |  12 ++--
 qapi/qapi-forward-visitor.c      |   3 +-
 qapi/qapi-util.c                 |   4 +-
 qapi/qapi-visit-core.c           |   5 +-
 qapi/qobject-input-visitor.c     |  53 ++++++++--------
 qapi/string-input-visitor.c      |  27 ++++----
 qga/commands-bsd.c               |   9 ++-
 qga/commands-posix.c             |  47 +++++++-------
 qga/commands-win32.c             |  65 ++++++++++----------
 qga/commands.c                   |  10 +--
 qom/object.c                     |  16 +++--
 qom/object_interfaces.c          |   3 +-
 qom/qom-qmp-cmds.c               |   8 +--
 softmmu/balloon.c                |   3 +-
 softmmu/cpus.c                   |   8 +--
 softmmu/qdev-monitor.c           |  24 ++++----
 softmmu/rtc.c                    |   1 -
 softmmu/tpm.c                    |   8 +--
 softmmu/vl.c                     |   5 +-
 target/arm/arm-qmp-cmds.c        |   4 +-
 target/i386/cpu.c                |  15 +++--
 target/s390x/cpu_models_sysemu.c |   4 +-
 ui/input-barrier.c               |   3 +-
 ui/ui-qmp-cmds.c                 |   7 +--
 util/block-helpers.c             |   4 +-
 util/qemu-option.c               |  21 +++----
 scripts/qapi/visit.py            |   5 +-
 61 files changed, 308 insertions(+), 437 deletions(-)
 delete mode 100644 include/qapi/qmp/qerror.h

-- 
2.41.0


