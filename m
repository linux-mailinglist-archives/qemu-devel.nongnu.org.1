Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67295916C2C
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jun 2024 17:11:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7ns-0001sM-ID; Tue, 25 Jun 2024 11:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7nq-0001ra-Ug
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:09:50 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7nk-0006Yr-Ei
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:09:50 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70666aceb5bso2612861b3a.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719328183; x=1719932983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Kjm5Q+dfF56+LBXldKy5tauJI3b/ezkLUM1j/Z1L+Y=;
 b=Jq/tiRbH8IkQO9WfDVF4RBj5NObiM059EQ6xT4pqykS/jESFGW8Nuc2WIn78yzISKA
 g8R5f/dlcWFJ86eob1qeVgaaCizf/qwa7u9O0cwVvBfsLITs9fGdPTYSwSm5nnOPcW1K
 iAffyluNlx6cTBHR3dWC4jGijmDxyh/6TEgnsWDQoWcoP1mNM6H2v03ztt8BIf7Tevwp
 TscWH0MfnmNMcWMvr1qQQJMA4snL9p2APvKmI+kdh2QzuabDINUR3Qplp0p00dVdVHFT
 AeyW7TAxUGL3yJKHy4Ga20Y87D7esLqqGlKtop9SqVlT1eROrdAIjBwcMb/CusoRX8D1
 7cOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719328183; x=1719932983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Kjm5Q+dfF56+LBXldKy5tauJI3b/ezkLUM1j/Z1L+Y=;
 b=qpx/qTkJ7SP+FI4BuSxsjBIyRq0X4MX4tLNptyEKV5MvrNrag+egzJqusrv82EcR79
 XdYp18yyG5a9N75j4BFispGyPpfvhjwpyNPFhfXsPR7OxZ5or6oLglxL1jyswXGw1/rF
 n0dyH0sSupqvjLMbf7pjwN/0blivAr0dK771J8kYgnLIqYxmR3gNQx/juhU6ubAA1Lit
 /+bi+9k/WbmQOKZkWhw3kUxd21bZqdN9REzy7sEush1Y0dTk/U2GOVsuJlYpspa+w6c/
 PAlOc+/3MxTGXW8I0D0U2JHZibKMabPwgACsFqqcqbOnpk+BsGUmI8hwWzzg5EUsc+nH
 p0ug==
X-Gm-Message-State: AOJu0YwMrpknYsfetNIMCBddK6i93bKyU3p5O9f6k1E3Ccf8zpX+RV7p
 ZgFHDklxJIWkxiuOBhWjkhA1Ov1GBKjZpNHuQMNemwd2KJJRL4d1c9lUlv9X+xGMW/Qv8jnrNRF
 H
X-Google-Smtp-Source: AGHT+IFKEtG7Ymz4GG/oBvR+dD+baTKkhVkIKcmIWDRaEh+73S7IQv4audjxzLKu9gx2sdzN7HUdNA==
X-Received: by 2002:a05:6a20:9686:b0:1b8:a08c:73e3 with SMTP id
 adf61e73a8af0-1bcf7fcdbf5mr7217267637.48.1719328182116; 
 Tue, 25 Jun 2024 08:09:42 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70681722219sm4142636b3a.73.2024.06.25.08.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 08:09:41 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v4 09/16] tests/data/acpi: Move x86 ACPI tables under
 x86/${machine} path
Date: Tue, 25 Jun 2024 20:38:32 +0530
Message-Id: <20240625150839.1358279-10-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
References: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x432.google.com
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

To support multiple architectures using same machine name, create x86
folder and move all x86 related AML files for each machine type inside.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/data/acpi/{ => x86}/microvm/APIC              | Bin
 tests/data/acpi/{ => x86}/microvm/APIC.ioapic2      | Bin
 tests/data/acpi/{ => x86}/microvm/APIC.pcie         | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT              | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT.ioapic2      | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT.pcie         | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT.rtc          | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT.usb          | Bin
 tests/data/acpi/{ => x86}/microvm/ERST.pcie         | Bin
 tests/data/acpi/{ => x86}/microvm/FACP              | Bin
 tests/data/acpi/{ => x86}/pc/APIC                   | Bin
 tests/data/acpi/{ => x86}/pc/APIC.acpihmat          | Bin
 tests/data/acpi/{ => x86}/pc/APIC.cphp              | Bin
 tests/data/acpi/{ => x86}/pc/APIC.dimmpxm           | Bin
 tests/data/acpi/{ => x86}/pc/DSDT                   | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.acpierst          | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.acpihmat          | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.bridge            | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.cphp              | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.dimmpxm           | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.hpbridge          | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.hpbrroot          | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.ipmikcs           | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.memhp             | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.nohpet            | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.numamem           | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.roothp            | Bin
 tests/data/acpi/{ => x86}/pc/ERST.acpierst          | Bin
 tests/data/acpi/{ => x86}/pc/FACP                   | Bin
 tests/data/acpi/{ => x86}/pc/FACP.nosmm             | Bin
 tests/data/acpi/{ => x86}/pc/FACS                   | Bin
 tests/data/acpi/{ => x86}/pc/HMAT.acpihmat          | Bin
 tests/data/acpi/{ => x86}/pc/HPET                   | Bin
 tests/data/acpi/{ => x86}/pc/NFIT.dimmpxm           | Bin
 tests/data/acpi/{ => x86}/pc/SLIT.cphp              | Bin
 tests/data/acpi/{ => x86}/pc/SLIT.memhp             | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.acpihmat          | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.cphp              | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.dimmpxm           | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.memhp             | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.numamem           | Bin
 tests/data/acpi/{ => x86}/pc/SSDT.dimmpxm           | Bin
 tests/data/acpi/{ => x86}/pc/WAET                   | Bin
 tests/data/acpi/{ => x86}/q35/APIC                  | Bin
 tests/data/acpi/{ => x86}/q35/APIC.acpihmat         | Bin
 .../acpi/{ => x86}/q35/APIC.acpihmat-noinitiator    | Bin
 tests/data/acpi/{ => x86}/q35/APIC.core-count       | Bin
 tests/data/acpi/{ => x86}/q35/APIC.core-count2      | Bin
 tests/data/acpi/{ => x86}/q35/APIC.cphp             | Bin
 tests/data/acpi/{ => x86}/q35/APIC.dimmpxm          | Bin
 tests/data/acpi/{ => x86}/q35/APIC.thread-count     | Bin
 tests/data/acpi/{ => x86}/q35/APIC.thread-count2    | Bin
 tests/data/acpi/{ => x86}/q35/APIC.type4-count      | Bin
 tests/data/acpi/{ => x86}/q35/APIC.xapic            | Bin
 tests/data/acpi/{ => x86}/q35/CEDT.cxl              | Bin
 tests/data/acpi/{ => x86}/q35/DMAR.dmar             | Bin
 tests/data/acpi/{ => x86}/q35/DSDT                  | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.acpierst         | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.acpihmat         | Bin
 .../acpi/{ => x86}/q35/DSDT.acpihmat-noinitiator    | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.applesmc         | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.bridge           | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.core-count       | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.core-count2      | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.cphp             | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.cxl              | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.dimmpxm          | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.ipmibt           | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.ipmismbus        | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.ivrs             | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.memhp            | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.mmio64           | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.multi-bridge     | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.noacpihp         | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.nohpet           | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.numamem          | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.pvpanic-isa      | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.thread-count     | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.thread-count2    | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.tis.tpm12        | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.tis.tpm2         | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.type4-count      | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.viot             | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.xapic            | Bin
 tests/data/acpi/{ => x86}/q35/ERST.acpierst         | Bin
 tests/data/acpi/{ => x86}/q35/FACP                  | Bin
 tests/data/acpi/{ => x86}/q35/FACP.core-count       | Bin
 tests/data/acpi/{ => x86}/q35/FACP.core-count2      | Bin
 tests/data/acpi/{ => x86}/q35/FACP.nosmm            | Bin
 tests/data/acpi/{ => x86}/q35/FACP.slic             | Bin
 tests/data/acpi/{ => x86}/q35/FACP.thread-count     | Bin
 tests/data/acpi/{ => x86}/q35/FACP.thread-count2    | Bin
 tests/data/acpi/{ => x86}/q35/FACP.type4-count      | Bin
 tests/data/acpi/{ => x86}/q35/FACP.xapic            | Bin
 tests/data/acpi/{ => x86}/q35/FACS                  | Bin
 tests/data/acpi/{ => x86}/q35/HMAT.acpihmat         | Bin
 .../acpi/{ => x86}/q35/HMAT.acpihmat-noinitiator    | Bin
 tests/data/acpi/{ => x86}/q35/HPET                  | Bin
 tests/data/acpi/{ => x86}/q35/IVRS.ivrs             | Bin
 tests/data/acpi/{ => x86}/q35/MCFG                  | Bin
 tests/data/acpi/{ => x86}/q35/NFIT.dimmpxm          | Bin
 tests/data/acpi/{ => x86}/q35/SLIC.slic             | Bin
 tests/data/acpi/{ => x86}/q35/SLIT.cphp             | Bin
 tests/data/acpi/{ => x86}/q35/SLIT.memhp            | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.acpihmat         | Bin
 .../acpi/{ => x86}/q35/SRAT.acpihmat-noinitiator    | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.cphp             | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.dimmpxm          | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.memhp            | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.mmio64           | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.numamem          | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.xapic            | Bin
 tests/data/acpi/{ => x86}/q35/SSDT.dimmpxm          | Bin
 tests/data/acpi/{ => x86}/q35/TCPA.tis.tpm12        | Bin
 tests/data/acpi/{ => x86}/q35/TPM2.tis.tpm2         | Bin
 tests/data/acpi/{ => x86}/q35/VIOT.viot             | Bin
 tests/data/acpi/{ => x86}/q35/WAET                  | Bin
 117 files changed, 0 insertions(+), 0 deletions(-)
 rename tests/data/acpi/{ => x86}/microvm/APIC (100%)
 rename tests/data/acpi/{ => x86}/microvm/APIC.ioapic2 (100%)
 rename tests/data/acpi/{ => x86}/microvm/APIC.pcie (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT.ioapic2 (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT.pcie (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT.rtc (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT.usb (100%)
 rename tests/data/acpi/{ => x86}/microvm/ERST.pcie (100%)
 rename tests/data/acpi/{ => x86}/microvm/FACP (100%)
 rename tests/data/acpi/{ => x86}/pc/APIC (100%)
 rename tests/data/acpi/{ => x86}/pc/APIC.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/pc/APIC.cphp (100%)
 rename tests/data/acpi/{ => x86}/pc/APIC.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.acpierst (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.bridge (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.cphp (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.hpbridge (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.hpbrroot (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.ipmikcs (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.memhp (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.nohpet (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.numamem (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.roothp (100%)
 rename tests/data/acpi/{ => x86}/pc/ERST.acpierst (100%)
 rename tests/data/acpi/{ => x86}/pc/FACP (100%)
 rename tests/data/acpi/{ => x86}/pc/FACP.nosmm (100%)
 rename tests/data/acpi/{ => x86}/pc/FACS (100%)
 rename tests/data/acpi/{ => x86}/pc/HMAT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/pc/HPET (100%)
 rename tests/data/acpi/{ => x86}/pc/NFIT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/SLIT.cphp (100%)
 rename tests/data/acpi/{ => x86}/pc/SLIT.memhp (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.cphp (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.memhp (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.numamem (100%)
 rename tests/data/acpi/{ => x86}/pc/SSDT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/WAET (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.acpihmat-noinitiator (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.core-count (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.core-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.cphp (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.thread-count (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.thread-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.type4-count (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.xapic (100%)
 rename tests/data/acpi/{ => x86}/q35/CEDT.cxl (100%)
 rename tests/data/acpi/{ => x86}/q35/DMAR.dmar (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.acpierst (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.acpihmat-noinitiator (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.applesmc (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.bridge (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.core-count (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.core-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.cphp (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.cxl (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.ipmibt (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.ipmismbus (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.ivrs (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.memhp (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.mmio64 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.multi-bridge (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.noacpihp (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.nohpet (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.numamem (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.pvpanic-isa (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.thread-count (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.thread-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.tis.tpm12 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.tis.tpm2 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.type4-count (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.viot (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.xapic (100%)
 rename tests/data/acpi/{ => x86}/q35/ERST.acpierst (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.core-count (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.core-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.nosmm (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.slic (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.thread-count (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.thread-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.type4-count (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.xapic (100%)
 rename tests/data/acpi/{ => x86}/q35/FACS (100%)
 rename tests/data/acpi/{ => x86}/q35/HMAT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/q35/HMAT.acpihmat-noinitiator (100%)
 rename tests/data/acpi/{ => x86}/q35/HPET (100%)
 rename tests/data/acpi/{ => x86}/q35/IVRS.ivrs (100%)
 rename tests/data/acpi/{ => x86}/q35/MCFG (100%)
 rename tests/data/acpi/{ => x86}/q35/NFIT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/SLIC.slic (100%)
 rename tests/data/acpi/{ => x86}/q35/SLIT.cphp (100%)
 rename tests/data/acpi/{ => x86}/q35/SLIT.memhp (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.acpihmat-noinitiator (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.cphp (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.memhp (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.mmio64 (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.numamem (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.xapic (100%)
 rename tests/data/acpi/{ => x86}/q35/SSDT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/TCPA.tis.tpm12 (100%)
 rename tests/data/acpi/{ => x86}/q35/TPM2.tis.tpm2 (100%)
 rename tests/data/acpi/{ => x86}/q35/VIOT.viot (100%)
 rename tests/data/acpi/{ => x86}/q35/WAET (100%)

diff --git a/tests/data/acpi/microvm/APIC b/tests/data/acpi/x86/microvm/APIC
similarity index 100%
rename from tests/data/acpi/microvm/APIC
rename to tests/data/acpi/x86/microvm/APIC
diff --git a/tests/data/acpi/microvm/APIC.ioapic2 b/tests/data/acpi/x86/microvm/APIC.ioapic2
similarity index 100%
rename from tests/data/acpi/microvm/APIC.ioapic2
rename to tests/data/acpi/x86/microvm/APIC.ioapic2
diff --git a/tests/data/acpi/microvm/APIC.pcie b/tests/data/acpi/x86/microvm/APIC.pcie
similarity index 100%
rename from tests/data/acpi/microvm/APIC.pcie
rename to tests/data/acpi/x86/microvm/APIC.pcie
diff --git a/tests/data/acpi/microvm/DSDT b/tests/data/acpi/x86/microvm/DSDT
similarity index 100%
rename from tests/data/acpi/microvm/DSDT
rename to tests/data/acpi/x86/microvm/DSDT
diff --git a/tests/data/acpi/microvm/DSDT.ioapic2 b/tests/data/acpi/x86/microvm/DSDT.ioapic2
similarity index 100%
rename from tests/data/acpi/microvm/DSDT.ioapic2
rename to tests/data/acpi/x86/microvm/DSDT.ioapic2
diff --git a/tests/data/acpi/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
similarity index 100%
rename from tests/data/acpi/microvm/DSDT.pcie
rename to tests/data/acpi/x86/microvm/DSDT.pcie
diff --git a/tests/data/acpi/microvm/DSDT.rtc b/tests/data/acpi/x86/microvm/DSDT.rtc
similarity index 100%
rename from tests/data/acpi/microvm/DSDT.rtc
rename to tests/data/acpi/x86/microvm/DSDT.rtc
diff --git a/tests/data/acpi/microvm/DSDT.usb b/tests/data/acpi/x86/microvm/DSDT.usb
similarity index 100%
rename from tests/data/acpi/microvm/DSDT.usb
rename to tests/data/acpi/x86/microvm/DSDT.usb
diff --git a/tests/data/acpi/microvm/ERST.pcie b/tests/data/acpi/x86/microvm/ERST.pcie
similarity index 100%
rename from tests/data/acpi/microvm/ERST.pcie
rename to tests/data/acpi/x86/microvm/ERST.pcie
diff --git a/tests/data/acpi/microvm/FACP b/tests/data/acpi/x86/microvm/FACP
similarity index 100%
rename from tests/data/acpi/microvm/FACP
rename to tests/data/acpi/x86/microvm/FACP
diff --git a/tests/data/acpi/pc/APIC b/tests/data/acpi/x86/pc/APIC
similarity index 100%
rename from tests/data/acpi/pc/APIC
rename to tests/data/acpi/x86/pc/APIC
diff --git a/tests/data/acpi/pc/APIC.acpihmat b/tests/data/acpi/x86/pc/APIC.acpihmat
similarity index 100%
rename from tests/data/acpi/pc/APIC.acpihmat
rename to tests/data/acpi/x86/pc/APIC.acpihmat
diff --git a/tests/data/acpi/pc/APIC.cphp b/tests/data/acpi/x86/pc/APIC.cphp
similarity index 100%
rename from tests/data/acpi/pc/APIC.cphp
rename to tests/data/acpi/x86/pc/APIC.cphp
diff --git a/tests/data/acpi/pc/APIC.dimmpxm b/tests/data/acpi/x86/pc/APIC.dimmpxm
similarity index 100%
rename from tests/data/acpi/pc/APIC.dimmpxm
rename to tests/data/acpi/x86/pc/APIC.dimmpxm
diff --git a/tests/data/acpi/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
similarity index 100%
rename from tests/data/acpi/pc/DSDT
rename to tests/data/acpi/x86/pc/DSDT
diff --git a/tests/data/acpi/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
similarity index 100%
rename from tests/data/acpi/pc/DSDT.acpierst
rename to tests/data/acpi/x86/pc/DSDT.acpierst
diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
similarity index 100%
rename from tests/data/acpi/pc/DSDT.acpihmat
rename to tests/data/acpi/x86/pc/DSDT.acpihmat
diff --git a/tests/data/acpi/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
similarity index 100%
rename from tests/data/acpi/pc/DSDT.bridge
rename to tests/data/acpi/x86/pc/DSDT.bridge
diff --git a/tests/data/acpi/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
similarity index 100%
rename from tests/data/acpi/pc/DSDT.cphp
rename to tests/data/acpi/x86/pc/DSDT.cphp
diff --git a/tests/data/acpi/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
similarity index 100%
rename from tests/data/acpi/pc/DSDT.dimmpxm
rename to tests/data/acpi/x86/pc/DSDT.dimmpxm
diff --git a/tests/data/acpi/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
similarity index 100%
rename from tests/data/acpi/pc/DSDT.hpbridge
rename to tests/data/acpi/x86/pc/DSDT.hpbridge
diff --git a/tests/data/acpi/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
similarity index 100%
rename from tests/data/acpi/pc/DSDT.hpbrroot
rename to tests/data/acpi/x86/pc/DSDT.hpbrroot
diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
similarity index 100%
rename from tests/data/acpi/pc/DSDT.ipmikcs
rename to tests/data/acpi/x86/pc/DSDT.ipmikcs
diff --git a/tests/data/acpi/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
similarity index 100%
rename from tests/data/acpi/pc/DSDT.memhp
rename to tests/data/acpi/x86/pc/DSDT.memhp
diff --git a/tests/data/acpi/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
similarity index 100%
rename from tests/data/acpi/pc/DSDT.nohpet
rename to tests/data/acpi/x86/pc/DSDT.nohpet
diff --git a/tests/data/acpi/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
similarity index 100%
rename from tests/data/acpi/pc/DSDT.numamem
rename to tests/data/acpi/x86/pc/DSDT.numamem
diff --git a/tests/data/acpi/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
similarity index 100%
rename from tests/data/acpi/pc/DSDT.roothp
rename to tests/data/acpi/x86/pc/DSDT.roothp
diff --git a/tests/data/acpi/pc/ERST.acpierst b/tests/data/acpi/x86/pc/ERST.acpierst
similarity index 100%
rename from tests/data/acpi/pc/ERST.acpierst
rename to tests/data/acpi/x86/pc/ERST.acpierst
diff --git a/tests/data/acpi/pc/FACP b/tests/data/acpi/x86/pc/FACP
similarity index 100%
rename from tests/data/acpi/pc/FACP
rename to tests/data/acpi/x86/pc/FACP
diff --git a/tests/data/acpi/pc/FACP.nosmm b/tests/data/acpi/x86/pc/FACP.nosmm
similarity index 100%
rename from tests/data/acpi/pc/FACP.nosmm
rename to tests/data/acpi/x86/pc/FACP.nosmm
diff --git a/tests/data/acpi/pc/FACS b/tests/data/acpi/x86/pc/FACS
similarity index 100%
rename from tests/data/acpi/pc/FACS
rename to tests/data/acpi/x86/pc/FACS
diff --git a/tests/data/acpi/pc/HMAT.acpihmat b/tests/data/acpi/x86/pc/HMAT.acpihmat
similarity index 100%
rename from tests/data/acpi/pc/HMAT.acpihmat
rename to tests/data/acpi/x86/pc/HMAT.acpihmat
diff --git a/tests/data/acpi/pc/HPET b/tests/data/acpi/x86/pc/HPET
similarity index 100%
rename from tests/data/acpi/pc/HPET
rename to tests/data/acpi/x86/pc/HPET
diff --git a/tests/data/acpi/pc/NFIT.dimmpxm b/tests/data/acpi/x86/pc/NFIT.dimmpxm
similarity index 100%
rename from tests/data/acpi/pc/NFIT.dimmpxm
rename to tests/data/acpi/x86/pc/NFIT.dimmpxm
diff --git a/tests/data/acpi/pc/SLIT.cphp b/tests/data/acpi/x86/pc/SLIT.cphp
similarity index 100%
rename from tests/data/acpi/pc/SLIT.cphp
rename to tests/data/acpi/x86/pc/SLIT.cphp
diff --git a/tests/data/acpi/pc/SLIT.memhp b/tests/data/acpi/x86/pc/SLIT.memhp
similarity index 100%
rename from tests/data/acpi/pc/SLIT.memhp
rename to tests/data/acpi/x86/pc/SLIT.memhp
diff --git a/tests/data/acpi/pc/SRAT.acpihmat b/tests/data/acpi/x86/pc/SRAT.acpihmat
similarity index 100%
rename from tests/data/acpi/pc/SRAT.acpihmat
rename to tests/data/acpi/x86/pc/SRAT.acpihmat
diff --git a/tests/data/acpi/pc/SRAT.cphp b/tests/data/acpi/x86/pc/SRAT.cphp
similarity index 100%
rename from tests/data/acpi/pc/SRAT.cphp
rename to tests/data/acpi/x86/pc/SRAT.cphp
diff --git a/tests/data/acpi/pc/SRAT.dimmpxm b/tests/data/acpi/x86/pc/SRAT.dimmpxm
similarity index 100%
rename from tests/data/acpi/pc/SRAT.dimmpxm
rename to tests/data/acpi/x86/pc/SRAT.dimmpxm
diff --git a/tests/data/acpi/pc/SRAT.memhp b/tests/data/acpi/x86/pc/SRAT.memhp
similarity index 100%
rename from tests/data/acpi/pc/SRAT.memhp
rename to tests/data/acpi/x86/pc/SRAT.memhp
diff --git a/tests/data/acpi/pc/SRAT.numamem b/tests/data/acpi/x86/pc/SRAT.numamem
similarity index 100%
rename from tests/data/acpi/pc/SRAT.numamem
rename to tests/data/acpi/x86/pc/SRAT.numamem
diff --git a/tests/data/acpi/pc/SSDT.dimmpxm b/tests/data/acpi/x86/pc/SSDT.dimmpxm
similarity index 100%
rename from tests/data/acpi/pc/SSDT.dimmpxm
rename to tests/data/acpi/x86/pc/SSDT.dimmpxm
diff --git a/tests/data/acpi/pc/WAET b/tests/data/acpi/x86/pc/WAET
similarity index 100%
rename from tests/data/acpi/pc/WAET
rename to tests/data/acpi/x86/pc/WAET
diff --git a/tests/data/acpi/q35/APIC b/tests/data/acpi/x86/q35/APIC
similarity index 100%
rename from tests/data/acpi/q35/APIC
rename to tests/data/acpi/x86/q35/APIC
diff --git a/tests/data/acpi/q35/APIC.acpihmat b/tests/data/acpi/x86/q35/APIC.acpihmat
similarity index 100%
rename from tests/data/acpi/q35/APIC.acpihmat
rename to tests/data/acpi/x86/q35/APIC.acpihmat
diff --git a/tests/data/acpi/q35/APIC.acpihmat-noinitiator b/tests/data/acpi/x86/q35/APIC.acpihmat-noinitiator
similarity index 100%
rename from tests/data/acpi/q35/APIC.acpihmat-noinitiator
rename to tests/data/acpi/x86/q35/APIC.acpihmat-noinitiator
diff --git a/tests/data/acpi/q35/APIC.core-count b/tests/data/acpi/x86/q35/APIC.core-count
similarity index 100%
rename from tests/data/acpi/q35/APIC.core-count
rename to tests/data/acpi/x86/q35/APIC.core-count
diff --git a/tests/data/acpi/q35/APIC.core-count2 b/tests/data/acpi/x86/q35/APIC.core-count2
similarity index 100%
rename from tests/data/acpi/q35/APIC.core-count2
rename to tests/data/acpi/x86/q35/APIC.core-count2
diff --git a/tests/data/acpi/q35/APIC.cphp b/tests/data/acpi/x86/q35/APIC.cphp
similarity index 100%
rename from tests/data/acpi/q35/APIC.cphp
rename to tests/data/acpi/x86/q35/APIC.cphp
diff --git a/tests/data/acpi/q35/APIC.dimmpxm b/tests/data/acpi/x86/q35/APIC.dimmpxm
similarity index 100%
rename from tests/data/acpi/q35/APIC.dimmpxm
rename to tests/data/acpi/x86/q35/APIC.dimmpxm
diff --git a/tests/data/acpi/q35/APIC.thread-count b/tests/data/acpi/x86/q35/APIC.thread-count
similarity index 100%
rename from tests/data/acpi/q35/APIC.thread-count
rename to tests/data/acpi/x86/q35/APIC.thread-count
diff --git a/tests/data/acpi/q35/APIC.thread-count2 b/tests/data/acpi/x86/q35/APIC.thread-count2
similarity index 100%
rename from tests/data/acpi/q35/APIC.thread-count2
rename to tests/data/acpi/x86/q35/APIC.thread-count2
diff --git a/tests/data/acpi/q35/APIC.type4-count b/tests/data/acpi/x86/q35/APIC.type4-count
similarity index 100%
rename from tests/data/acpi/q35/APIC.type4-count
rename to tests/data/acpi/x86/q35/APIC.type4-count
diff --git a/tests/data/acpi/q35/APIC.xapic b/tests/data/acpi/x86/q35/APIC.xapic
similarity index 100%
rename from tests/data/acpi/q35/APIC.xapic
rename to tests/data/acpi/x86/q35/APIC.xapic
diff --git a/tests/data/acpi/q35/CEDT.cxl b/tests/data/acpi/x86/q35/CEDT.cxl
similarity index 100%
rename from tests/data/acpi/q35/CEDT.cxl
rename to tests/data/acpi/x86/q35/CEDT.cxl
diff --git a/tests/data/acpi/q35/DMAR.dmar b/tests/data/acpi/x86/q35/DMAR.dmar
similarity index 100%
rename from tests/data/acpi/q35/DMAR.dmar
rename to tests/data/acpi/x86/q35/DMAR.dmar
diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
similarity index 100%
rename from tests/data/acpi/q35/DSDT
rename to tests/data/acpi/x86/q35/DSDT
diff --git a/tests/data/acpi/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
similarity index 100%
rename from tests/data/acpi/q35/DSDT.acpierst
rename to tests/data/acpi/x86/q35/DSDT.acpierst
diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
similarity index 100%
rename from tests/data/acpi/q35/DSDT.acpihmat
rename to tests/data/acpi/x86/q35/DSDT.acpihmat
diff --git a/tests/data/acpi/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
similarity index 100%
rename from tests/data/acpi/q35/DSDT.acpihmat-noinitiator
rename to tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
diff --git a/tests/data/acpi/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
similarity index 100%
rename from tests/data/acpi/q35/DSDT.applesmc
rename to tests/data/acpi/x86/q35/DSDT.applesmc
diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
similarity index 100%
rename from tests/data/acpi/q35/DSDT.bridge
rename to tests/data/acpi/x86/q35/DSDT.bridge
diff --git a/tests/data/acpi/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
similarity index 100%
rename from tests/data/acpi/q35/DSDT.core-count
rename to tests/data/acpi/x86/q35/DSDT.core-count
diff --git a/tests/data/acpi/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
similarity index 100%
rename from tests/data/acpi/q35/DSDT.core-count2
rename to tests/data/acpi/x86/q35/DSDT.core-count2
diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
similarity index 100%
rename from tests/data/acpi/q35/DSDT.cphp
rename to tests/data/acpi/x86/q35/DSDT.cphp
diff --git a/tests/data/acpi/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
similarity index 100%
rename from tests/data/acpi/q35/DSDT.cxl
rename to tests/data/acpi/x86/q35/DSDT.cxl
diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
similarity index 100%
rename from tests/data/acpi/q35/DSDT.dimmpxm
rename to tests/data/acpi/x86/q35/DSDT.dimmpxm
diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
similarity index 100%
rename from tests/data/acpi/q35/DSDT.ipmibt
rename to tests/data/acpi/x86/q35/DSDT.ipmibt
diff --git a/tests/data/acpi/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
similarity index 100%
rename from tests/data/acpi/q35/DSDT.ipmismbus
rename to tests/data/acpi/x86/q35/DSDT.ipmismbus
diff --git a/tests/data/acpi/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
similarity index 100%
rename from tests/data/acpi/q35/DSDT.ivrs
rename to tests/data/acpi/x86/q35/DSDT.ivrs
diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
similarity index 100%
rename from tests/data/acpi/q35/DSDT.memhp
rename to tests/data/acpi/x86/q35/DSDT.memhp
diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
similarity index 100%
rename from tests/data/acpi/q35/DSDT.mmio64
rename to tests/data/acpi/x86/q35/DSDT.mmio64
diff --git a/tests/data/acpi/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
similarity index 100%
rename from tests/data/acpi/q35/DSDT.multi-bridge
rename to tests/data/acpi/x86/q35/DSDT.multi-bridge
diff --git a/tests/data/acpi/q35/DSDT.noacpihp b/tests/data/acpi/x86/q35/DSDT.noacpihp
similarity index 100%
rename from tests/data/acpi/q35/DSDT.noacpihp
rename to tests/data/acpi/x86/q35/DSDT.noacpihp
diff --git a/tests/data/acpi/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
similarity index 100%
rename from tests/data/acpi/q35/DSDT.nohpet
rename to tests/data/acpi/x86/q35/DSDT.nohpet
diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
similarity index 100%
rename from tests/data/acpi/q35/DSDT.numamem
rename to tests/data/acpi/x86/q35/DSDT.numamem
diff --git a/tests/data/acpi/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
similarity index 100%
rename from tests/data/acpi/q35/DSDT.pvpanic-isa
rename to tests/data/acpi/x86/q35/DSDT.pvpanic-isa
diff --git a/tests/data/acpi/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
similarity index 100%
rename from tests/data/acpi/q35/DSDT.thread-count
rename to tests/data/acpi/x86/q35/DSDT.thread-count
diff --git a/tests/data/acpi/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
similarity index 100%
rename from tests/data/acpi/q35/DSDT.thread-count2
rename to tests/data/acpi/x86/q35/DSDT.thread-count2
diff --git a/tests/data/acpi/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
similarity index 100%
rename from tests/data/acpi/q35/DSDT.tis.tpm12
rename to tests/data/acpi/x86/q35/DSDT.tis.tpm12
diff --git a/tests/data/acpi/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
similarity index 100%
rename from tests/data/acpi/q35/DSDT.tis.tpm2
rename to tests/data/acpi/x86/q35/DSDT.tis.tpm2
diff --git a/tests/data/acpi/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
similarity index 100%
rename from tests/data/acpi/q35/DSDT.type4-count
rename to tests/data/acpi/x86/q35/DSDT.type4-count
diff --git a/tests/data/acpi/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
similarity index 100%
rename from tests/data/acpi/q35/DSDT.viot
rename to tests/data/acpi/x86/q35/DSDT.viot
diff --git a/tests/data/acpi/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
similarity index 100%
rename from tests/data/acpi/q35/DSDT.xapic
rename to tests/data/acpi/x86/q35/DSDT.xapic
diff --git a/tests/data/acpi/q35/ERST.acpierst b/tests/data/acpi/x86/q35/ERST.acpierst
similarity index 100%
rename from tests/data/acpi/q35/ERST.acpierst
rename to tests/data/acpi/x86/q35/ERST.acpierst
diff --git a/tests/data/acpi/q35/FACP b/tests/data/acpi/x86/q35/FACP
similarity index 100%
rename from tests/data/acpi/q35/FACP
rename to tests/data/acpi/x86/q35/FACP
diff --git a/tests/data/acpi/q35/FACP.core-count b/tests/data/acpi/x86/q35/FACP.core-count
similarity index 100%
rename from tests/data/acpi/q35/FACP.core-count
rename to tests/data/acpi/x86/q35/FACP.core-count
diff --git a/tests/data/acpi/q35/FACP.core-count2 b/tests/data/acpi/x86/q35/FACP.core-count2
similarity index 100%
rename from tests/data/acpi/q35/FACP.core-count2
rename to tests/data/acpi/x86/q35/FACP.core-count2
diff --git a/tests/data/acpi/q35/FACP.nosmm b/tests/data/acpi/x86/q35/FACP.nosmm
similarity index 100%
rename from tests/data/acpi/q35/FACP.nosmm
rename to tests/data/acpi/x86/q35/FACP.nosmm
diff --git a/tests/data/acpi/q35/FACP.slic b/tests/data/acpi/x86/q35/FACP.slic
similarity index 100%
rename from tests/data/acpi/q35/FACP.slic
rename to tests/data/acpi/x86/q35/FACP.slic
diff --git a/tests/data/acpi/q35/FACP.thread-count b/tests/data/acpi/x86/q35/FACP.thread-count
similarity index 100%
rename from tests/data/acpi/q35/FACP.thread-count
rename to tests/data/acpi/x86/q35/FACP.thread-count
diff --git a/tests/data/acpi/q35/FACP.thread-count2 b/tests/data/acpi/x86/q35/FACP.thread-count2
similarity index 100%
rename from tests/data/acpi/q35/FACP.thread-count2
rename to tests/data/acpi/x86/q35/FACP.thread-count2
diff --git a/tests/data/acpi/q35/FACP.type4-count b/tests/data/acpi/x86/q35/FACP.type4-count
similarity index 100%
rename from tests/data/acpi/q35/FACP.type4-count
rename to tests/data/acpi/x86/q35/FACP.type4-count
diff --git a/tests/data/acpi/q35/FACP.xapic b/tests/data/acpi/x86/q35/FACP.xapic
similarity index 100%
rename from tests/data/acpi/q35/FACP.xapic
rename to tests/data/acpi/x86/q35/FACP.xapic
diff --git a/tests/data/acpi/q35/FACS b/tests/data/acpi/x86/q35/FACS
similarity index 100%
rename from tests/data/acpi/q35/FACS
rename to tests/data/acpi/x86/q35/FACS
diff --git a/tests/data/acpi/q35/HMAT.acpihmat b/tests/data/acpi/x86/q35/HMAT.acpihmat
similarity index 100%
rename from tests/data/acpi/q35/HMAT.acpihmat
rename to tests/data/acpi/x86/q35/HMAT.acpihmat
diff --git a/tests/data/acpi/q35/HMAT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/HMAT.acpihmat-noinitiator
similarity index 100%
rename from tests/data/acpi/q35/HMAT.acpihmat-noinitiator
rename to tests/data/acpi/x86/q35/HMAT.acpihmat-noinitiator
diff --git a/tests/data/acpi/q35/HPET b/tests/data/acpi/x86/q35/HPET
similarity index 100%
rename from tests/data/acpi/q35/HPET
rename to tests/data/acpi/x86/q35/HPET
diff --git a/tests/data/acpi/q35/IVRS.ivrs b/tests/data/acpi/x86/q35/IVRS.ivrs
similarity index 100%
rename from tests/data/acpi/q35/IVRS.ivrs
rename to tests/data/acpi/x86/q35/IVRS.ivrs
diff --git a/tests/data/acpi/q35/MCFG b/tests/data/acpi/x86/q35/MCFG
similarity index 100%
rename from tests/data/acpi/q35/MCFG
rename to tests/data/acpi/x86/q35/MCFG
diff --git a/tests/data/acpi/q35/NFIT.dimmpxm b/tests/data/acpi/x86/q35/NFIT.dimmpxm
similarity index 100%
rename from tests/data/acpi/q35/NFIT.dimmpxm
rename to tests/data/acpi/x86/q35/NFIT.dimmpxm
diff --git a/tests/data/acpi/q35/SLIC.slic b/tests/data/acpi/x86/q35/SLIC.slic
similarity index 100%
rename from tests/data/acpi/q35/SLIC.slic
rename to tests/data/acpi/x86/q35/SLIC.slic
diff --git a/tests/data/acpi/q35/SLIT.cphp b/tests/data/acpi/x86/q35/SLIT.cphp
similarity index 100%
rename from tests/data/acpi/q35/SLIT.cphp
rename to tests/data/acpi/x86/q35/SLIT.cphp
diff --git a/tests/data/acpi/q35/SLIT.memhp b/tests/data/acpi/x86/q35/SLIT.memhp
similarity index 100%
rename from tests/data/acpi/q35/SLIT.memhp
rename to tests/data/acpi/x86/q35/SLIT.memhp
diff --git a/tests/data/acpi/q35/SRAT.acpihmat b/tests/data/acpi/x86/q35/SRAT.acpihmat
similarity index 100%
rename from tests/data/acpi/q35/SRAT.acpihmat
rename to tests/data/acpi/x86/q35/SRAT.acpihmat
diff --git a/tests/data/acpi/q35/SRAT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/SRAT.acpihmat-noinitiator
similarity index 100%
rename from tests/data/acpi/q35/SRAT.acpihmat-noinitiator
rename to tests/data/acpi/x86/q35/SRAT.acpihmat-noinitiator
diff --git a/tests/data/acpi/q35/SRAT.cphp b/tests/data/acpi/x86/q35/SRAT.cphp
similarity index 100%
rename from tests/data/acpi/q35/SRAT.cphp
rename to tests/data/acpi/x86/q35/SRAT.cphp
diff --git a/tests/data/acpi/q35/SRAT.dimmpxm b/tests/data/acpi/x86/q35/SRAT.dimmpxm
similarity index 100%
rename from tests/data/acpi/q35/SRAT.dimmpxm
rename to tests/data/acpi/x86/q35/SRAT.dimmpxm
diff --git a/tests/data/acpi/q35/SRAT.memhp b/tests/data/acpi/x86/q35/SRAT.memhp
similarity index 100%
rename from tests/data/acpi/q35/SRAT.memhp
rename to tests/data/acpi/x86/q35/SRAT.memhp
diff --git a/tests/data/acpi/q35/SRAT.mmio64 b/tests/data/acpi/x86/q35/SRAT.mmio64
similarity index 100%
rename from tests/data/acpi/q35/SRAT.mmio64
rename to tests/data/acpi/x86/q35/SRAT.mmio64
diff --git a/tests/data/acpi/q35/SRAT.numamem b/tests/data/acpi/x86/q35/SRAT.numamem
similarity index 100%
rename from tests/data/acpi/q35/SRAT.numamem
rename to tests/data/acpi/x86/q35/SRAT.numamem
diff --git a/tests/data/acpi/q35/SRAT.xapic b/tests/data/acpi/x86/q35/SRAT.xapic
similarity index 100%
rename from tests/data/acpi/q35/SRAT.xapic
rename to tests/data/acpi/x86/q35/SRAT.xapic
diff --git a/tests/data/acpi/q35/SSDT.dimmpxm b/tests/data/acpi/x86/q35/SSDT.dimmpxm
similarity index 100%
rename from tests/data/acpi/q35/SSDT.dimmpxm
rename to tests/data/acpi/x86/q35/SSDT.dimmpxm
diff --git a/tests/data/acpi/q35/TCPA.tis.tpm12 b/tests/data/acpi/x86/q35/TCPA.tis.tpm12
similarity index 100%
rename from tests/data/acpi/q35/TCPA.tis.tpm12
rename to tests/data/acpi/x86/q35/TCPA.tis.tpm12
diff --git a/tests/data/acpi/q35/TPM2.tis.tpm2 b/tests/data/acpi/x86/q35/TPM2.tis.tpm2
similarity index 100%
rename from tests/data/acpi/q35/TPM2.tis.tpm2
rename to tests/data/acpi/x86/q35/TPM2.tis.tpm2
diff --git a/tests/data/acpi/q35/VIOT.viot b/tests/data/acpi/x86/q35/VIOT.viot
similarity index 100%
rename from tests/data/acpi/q35/VIOT.viot
rename to tests/data/acpi/x86/q35/VIOT.viot
diff --git a/tests/data/acpi/q35/WAET b/tests/data/acpi/x86/q35/WAET
similarity index 100%
rename from tests/data/acpi/q35/WAET
rename to tests/data/acpi/x86/q35/WAET
-- 
2.40.1


