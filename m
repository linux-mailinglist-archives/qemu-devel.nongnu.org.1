Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 565BF78A69D
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 09:38:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaWnY-0006Tf-DN; Mon, 28 Aug 2023 03:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnP-0006SU-23
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnM-0004Ik-DZ
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fefe898f76so28356115e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 00:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693208178; x=1693812978;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=68WUFwPGuugvH79rt0rz5tv68LZhIvIILNuoS5jPn0o=;
 b=TbCMF0A4xU9EICsJOL+1PsNKrsIX4pkYzJHdI7dmTI3hqA8K9w2dq8TMwwdrAPsFTI
 SqrBcd3c8eHpTL4x26Ub82kZfqdYdyH5j9UI9LjGr0nORP2fE24ZTwBSmvLHEwHb9iSO
 yeQK6a/giC+M4TcEJkxqZE/U+D3t1JwRgS+6ulk4S50tqwUL6/PueIUnaCDy7Aem7iRh
 hvLxnRnIoqgCPu317T6ghfBSAxmwiq2y54YDIsVnDXowuV7Crv04Qo0BH/c7J3ABh4gz
 9Pc8uTdkG4wf1d/JZbZc6oaDyOVLIa7293+7eFJD1cwr6V0O1NFS/ChS1OnfU3Vua9BO
 AieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693208178; x=1693812978;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=68WUFwPGuugvH79rt0rz5tv68LZhIvIILNuoS5jPn0o=;
 b=ck5CY2r5CAIyuN7isLvGW/XftCadlRVioocylm8ukM1rydvflgiUC/GKX/uZzouX9E
 rGDOD+zM9KtW5ycjs7n3NRZ79SP4SvsZPW72ZKZRf+6jOYaCBnXu0iWD/aX83Qzb+JpG
 JirjaZIzjF9uzVfIZnHbn4GWXb2dR8FTdjv47nJWiBMrfeySr4Qgy6otJ2T7eXsY9Oy9
 k2u/gbpiPwrK4CihuPcnUzEeV4SWfFzIsXMU6F60SeOvwBisYqzb44SuYsHIXo2YgNA9
 0y19IKf7qmgsVcjQ9WQxX2IkDTOU41F5D4Go50Mqki9b54sPzPvNLzBP6zPeg4SyLYe7
 aJVg==
X-Gm-Message-State: AOJu0Yw3h8DcVLclV6bCkTjrJxM159sL4xWpwv5pCzFgkKIcd7CbwHYt
 Rv5B50jjQBrRYNY7EvQaAHm1srAeYrLsrw==
X-Google-Smtp-Source: AGHT+IGqbMHlqLY7SlA3zAiwsXtxUwtMzUz+O2e/e6L5pobFIkM9spab4pxH10sw89nZtWV+lEUPQw==
X-Received: by 2002:a05:600c:286:b0:401:be70:53b6 with SMTP id
 6-20020a05600c028600b00401be7053b6mr4352115wmk.15.1693208177656; 
 Mon, 28 Aug 2023 00:36:17 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-055-055-138.78.55.pool.telefonica.de. [78.55.55.138])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a05600c281100b003fef19bb55csm9795285wmb.34.2023.08.28.00.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 00:36:17 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/8] ACPI: X86 AML generation and GPE tracing cleanup
Date: Mon, 28 Aug 2023 09:36:01 +0200
Message-ID: <20230828073609.5710-1-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series contains changes from my effort to bring the VIA south bridges =
to=0D
the PC machine [1]. The first part of the series resolves the=0D
AcpiCpuAmlIfClass::madt_cpu virtual method which frees ACPI controllers fro=
m=0D
worrying about CPU AML generation. The second part minimizes an Intel-speci=
fic=0D
assumption in AML generation to just one place. The third part contains two=
=0D
ACPI tracing patches which have been reviewed a long time ago but weren't m=
erged=0D
yet.=0D
=0D
The removal of AcpiCpuAmlIfClass::madt_cpu is essentially a respin of [2] w=
ith=0D
a different approach. Igor wasn't generally against it but wasn't convinced=
=0D
either [3]. The new approach causes much less churn and instead allows to=0D
remove code. So I think it's worth to be reconsidered.=0D
=0D
The motivation for removing this virtual method didn't change: It frees the=
 ACPI=0D
controllers in general and PIIX4 PM in particular from generating X86 CPU A=
ML.=0D
The latter is also used in MPIS context where X86 CPU AML generation is=0D
stubbed out. This indicates a design issue where a problem was solved at th=
e=0D
wrong place. Moreover, it turned out that TYPE_ACPI_GED_X86 could be remove=
d as=0D
well, further supporting this claim.=0D
=0D
The second part of this series limits SMI command port determination during=
 AML=0D
generation to just one place. Currently the ACPI_PORT_SMI_CMD constant is u=
sed=0D
multiple times which has an Intel-specific value. In order to make the code=
 a=0D
microscopic bit more compatible with our VIA south bridge models its usage =
gets=0D
limited to one place, allowing the constant to be turned into a device mode=
l=0D
property in the future.=0D
=0D
The third part improves the tracing experience for ACPI general purpose eve=
nts.=0D
It originates from an old series: [4].=0D
=0D
Testing done:=0D
* `make check`=0D
* `make check-avocado`=0D
* `qemu-system-ppc -machine pegasos2 -rtc base=3Dlocaltime \=0D
   -device ati-vga,guest_hwcursor=3Dtrue,romfile=3D""=0D
   -cdrom morphos-3.18.iso -bios pegasos2.rom`=0D
=0D
[1] https://github.com/shentok/qemu/tree/pc-via=0D
[2] https://lore.kernel.org/qemu-devel/20230121151941.24120-1-shentey@gmail=
.com/=0D
[3] https://lore.kernel.org/qemu-devel/20230125174842.395fda5d@imammedo.use=
rs.ipa.redhat.com/=0D
[4] https://patchew.org/QEMU/20230122170724.21868-1-shentey@gmail.com/=0D
=0D
Bernhard Beschow (8):=0D
  hw/i386/acpi-build: Use pc_madt_cpu_entry() directly=0D
  hw/acpi/cpu: Have build_cpus_aml() take a build_madt_cpu_fn callback=0D
  hw/acpi/acpi_dev_interface: Remove now unused madt_cpu virtual method=0D
  hw/acpi/acpi_dev_interface: Remove now unused #include "hw/boards.h"=0D
  hw/i386: Remove now redundant TYPE_ACPI_GED_X86=0D
  hw/i386/acpi-build: Determine SMI command port just once=0D
  hw/acpi: Trace GPE access in all device models, not just PIIX4=0D
  hw/acpi/core: Trace enable and status registers of GPE separately=0D
=0D
 hw/acpi/hmat.h                         |  3 ++-=0D
 hw/i386/acpi-common.h                  |  3 +--=0D
 include/hw/acpi/acpi_dev_interface.h   |  3 ---=0D
 include/hw/acpi/cpu.h                  |  6 ++++-=0D
 include/hw/acpi/generic_event_device.h |  2 --=0D
 hw/acpi/acpi-x86-stub.c                |  6 -----=0D
 hw/acpi/core.c                         |  9 +++++++=0D
 hw/acpi/cpu.c                          |  9 +++----=0D
 hw/acpi/hmat.c                         |  1 +=0D
 hw/acpi/memory_hotplug.c               |  1 +=0D
 hw/acpi/piix4.c                        |  5 ----=0D
 hw/i386/acpi-build.c                   | 13 +++++-----=0D
 hw/i386/acpi-common.c                  |  5 ++--=0D
 hw/i386/acpi-microvm.c                 |  3 +--=0D
 hw/i386/generic_event_device_x86.c     | 36 --------------------------=0D
 hw/i386/microvm.c                      |  2 +-=0D
 hw/isa/lpc_ich9.c                      |  1 -=0D
 hw/acpi/trace-events                   | 10 ++++---=0D
 hw/i386/meson.build                    |  1 -=0D
 19 files changed, 38 insertions(+), 81 deletions(-)=0D
 delete mode 100644 hw/i386/generic_event_device_x86.c=0D
=0D
-- =0D
2.42.0=0D
=0D

