Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA977A5F3B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:14:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXix-0003I5-7A; Tue, 19 Sep 2023 06:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiXip-0003DN-41
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:12:48 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiXin-0005La-0L
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:12:46 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32155a45957so1724875f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695118362; x=1695723162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0zbZPsaTAWLU8NhXe0AqmzBHuQOLcBVRNpjcnRGPRoc=;
 b=JsxOPD5Cpt6W+Qigq1/vR1yRMIvIK49iS5n77RNKAV5Dtdd6EAhxqIqAzgj+ZTj+2q
 gomyVgvmZlV4PweIwylz7My7TrjF1gW5DnQVIVLQg4TQ5KWlxQ5TOo01hyKFa+8hxTGf
 3ismyHWYXQauxX/RrwrMubbEuWqb7eWZ+U8kPTSmaP6aliJ+rSA8pxbqPMyTdlA9+oky
 iMbK1K93ulghAqmBxyiBbjcTxSlNC5+MQOR+0OremI7bXZWNoVfx1wd5cDubDfUpFwsa
 pnp4L53Z09CaLwqN7mqGnFu7H5YkRPfhOYTDe+v+x767NPRgMSebQ2DUp0TOdSCbnobv
 rUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695118362; x=1695723162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0zbZPsaTAWLU8NhXe0AqmzBHuQOLcBVRNpjcnRGPRoc=;
 b=sjLvc7DZ2omOS9LTndQVCS/xsSxMy609e9qKMdIvUgu8LlOjQiyUSqsVO4OiKhsYge
 Wb94EknM4kCjErdh30Ijqrj3ZpyDndMGVLg0b6PQEeDYz71kjmGVnJeW9NT1ZBN60+34
 wotN3XFwL4Z82qnvme1NyWDmEcuft7QEonyLHWU37hhMiJLVx3HFUPw+nDsJuKuO+U6M
 NLYmL4Bf/sPz7rezQbJLvIjWRFt0O2Kcg11UbJksr4WtnrhUkotu2m1lABjAMibrMe1R
 +tFfklyAdB+4rGRvQ5ikFngA8m/c/LX9kJ8llPd3JM3ikDaglR3g+rD92xLBOnAS853p
 /LzQ==
X-Gm-Message-State: AOJu0YzMTQwwkMsG3HuWelRmBTgKBW3uwA1DGERW5MN5G3aWXcXVQG8o
 jhdd52zCMIu/W9fPDbb0A/R9Yg==
X-Google-Smtp-Source: AGHT+IFRUKr7PUln6JEhtxC+eLVACIsDb7OmPRCfLOSUm319bFlxNZcY3CQ06IUrZC3zeJBiPImFVg==
X-Received: by 2002:a05:6000:1e91:b0:321:67f4:8bd7 with SMTP id
 dd17-20020a0560001e9100b0032167f48bd7mr911936wrb.32.1695118361967; 
 Tue, 19 Sep 2023 03:12:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ba13-20020a0560001c0d00b0031ddf6cc89csm12290136wrb.98.2023.09.19.03.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 03:12:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [RFC 0/3] virt: wire up NS EL2 virtual timer IRQ
Date: Tue, 19 Sep 2023 11:12:37 +0100
Message-Id: <20230919101240.2569334-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This patchset is an RFC that wires up the NS EL2 virtual timer IRQ on
the virt board, similarly to what
https://patchew.org/QEMU/20230913140610.214893-1-marcin.juszkiewicz@linaro.org/
does for the sbsa-ref board.

Patches 1 and 3 are the usual dance to keep the ACPI unit tests happy
with the change to the ACPI table contents; patch 2 is the meat.

This is an RFC for two reasons:

(1) I'm not very familiar with ACPI, and patch 2 needs to update the
ACPI GTDT table to report the interrupt number.  In particular, this
means we need the rev 3 of this table (present in ACPI spec 6.3 and
later), not the rev 2 we currently report.  I'm not sure if it's
permitted to rev just this table, or if we would need to upgrade all
our ACPI tables to the newer spec first.

(2) The change causes EDK2 (UEFI) to assert on startup:
ASSERT [ArmTimerDxe] /home/kraxel/projects/qemu/roms/edk2/ArmVirtPkg/Library/ArmVirtTimerFdtClientLib/ArmVirtTimerFdtClientLib.c(72): PropSize == 36 || PropSize == 48
This is because the EDK2 code that consumes the QEMU generated device
tree blob is incorrectly insisting that the architectural-timer
interrupts property has only 3 or 4 entries, so it falls over if
given a dtb with the 5th entry for the EL2 virtual timer irq.  In
particular this breaks the avocado test:
machine_aarch64_virt.py:Aarch64VirtMachine.test_alpine_virt_tcg_gic_max
I'm not entirely sure what to do about this -- we can get EDK2 fixed
and update our own test case, but there's a lot of binaries out there
in the wild that won't run if we just update the virt board the way
this patchset does.  We could perhaps make the virt board change be
dependent on machine type version, as a way to let users fall back to
the old behaviour.

I'm putting this patchset out on the list to get opinions and
review on those two points.

thanks
-- PMM

Peter Maydell (3):
  tests/qtest/bios-tables-test: Allow changes to virt GTDT
  hw/arm/virt: Wire up non-secure EL2 virtual timer IRQ
  tests/qtest/bios-tables-test: Update virt/GTDT golden reference

 include/hw/arm/virt.h     |   2 ++
 hw/arm/virt-acpi-build.c  |  16 ++++++++++++----
 hw/arm/virt.c             |  29 ++++++++++++++++++++++++++++-
 tests/data/acpi/virt/GTDT | Bin 96 -> 104 bytes
 4 files changed, 42 insertions(+), 5 deletions(-)

-- 
2.34.1


