Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB7B798454
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:44:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeX4r-0002nF-1X; Fri, 08 Sep 2023 04:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4j-0002dU-5s
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:50 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4e-0004ho-EA
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:47 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so1644480f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 01:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694162562; x=1694767362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MXMqVduWvHSXm5TTmj5h8lrqE4Ukk43eDBxbpE5yU18=;
 b=Ey8OEtHziSINvyyz/qtKBb5MrGOvLvy7O3tK30tbPfzDPhus6jBy+s/KatZR/omcAK
 e/io/xdZeEZHmKx8M9O2rRUsnBPz2PL/4e1szqYQFICZDiQYDviEX6TcqUy0Gn+/hbUE
 lEw48rlxcaa4ZbDv5wf09tIC4bU4rrkWJsz34z3YozOrJqoiEaWX4ZvheUm75nNOMv4Z
 lFnE4ksDdyza3Xbc7WvstOA7o8azS4oMyIv8hrTXQOae14sA2IUnpcBCFWqLAWUH9fT/
 AtTC3MG9/YrPpjOcusV+mYO2Rew3B46G7AtQw/xGwrlAFZMKm/qRx2kAlAyG+Q5XJloX
 5Ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694162562; x=1694767362;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MXMqVduWvHSXm5TTmj5h8lrqE4Ukk43eDBxbpE5yU18=;
 b=vZuMr26aoHTa0nOBL94+CJyPRlVrFXc8IiwpVa0zal81D3Qvfo4BI4KojbjcLHDD7X
 3e3L0bkGnKr4v06KDYrP8Pt9Jy1x+ObL//PwaCwXc8Q9JL0CfUOOuS5c+exs1Visae7d
 LbDtXzZa0w0ovkRz8R/m4H1+3BjjTjTanSBy/qEyyOtj7JtIth23EelwyhwW3cJSN/Bj
 sGDq9Hpif2qJ6FmlosGRLq9MG3X5DUsHPXVsdb6VZXpe9Fta0DIg1cLCYXrMs3jZP2v3
 hfjmvJzG887ir4+JpPCQB7JfwmohvQtLlDG8da/I8UTQVdb8BKoJsOqxqks4OPUh3zTx
 AIyQ==
X-Gm-Message-State: AOJu0YyfSrqaD/6dTT22AX6nurqUdgZMiL3oyt4NL4CwxTs5cewQ4tIS
 rAL3iB3AimZ1ZsfuzM56Q26LiAvZ9TA=
X-Google-Smtp-Source: AGHT+IGCTD5Rad9XxnW7EHpWmWJ6v1MLgHb4esBP7eB0ZINM+6WO/LHbD4NTZ/JP4GDVTx4eGPxiGQ==
X-Received: by 2002:a05:6000:1190:b0:31a:d2b2:f28f with SMTP id
 g16-20020a056000119000b0031ad2b2f28fmr1263262wrx.51.1694162561997; 
 Fri, 08 Sep 2023 01:42:41 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-093-170.78.54.pool.telefonica.de. [78.54.93.170])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a056000001100b003197c2316ecsm1462139wrx.112.2023.09.08.01.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 01:42:41 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 0/8] ACPI: X86 AML generation and GPE tracing cleanup
Date: Fri,  8 Sep 2023 10:42:26 +0200
Message-ID: <20230908084234.17642-1-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x431.google.com
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
=0D
v2:=0D
* Trace ACPI GPE values with "0x%02" (Phil)=0D
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

