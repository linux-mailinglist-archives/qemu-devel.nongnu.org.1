Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9A07A6BBB
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 21:48:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiggt-0001aS-Ux; Tue, 19 Sep 2023 15:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qiggr-0001aA-JI
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 15:47:21 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qiggp-0005rJ-EW
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 15:47:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31fe2c8db0dso5337737f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 12:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695152837; x=1695757637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zWuaDw2mlkJcL1kGZZHZ9zJPxnzfj7VRZGQLIW+eX4=;
 b=Kxxm38rTeojrbGQ00djvnPKF0e5KotUFlymAnQTOIPyZlqMSFZDr1TEKrVXSICt7D4
 MFwCNnqAt1M5XNCTFXQySVUPgCaY8dWom7l4QUo/gXRiFwPkwS41NQQ8yaZOAB0h9kUK
 DbPj6fUG1VUC24pcjmMzHZo3ooY+WINeZOVYmIRgtxsrB49MOMVoxGWarsJ2nLzGWHbz
 7CksfMUWij8Ihyu1504bwoW8co3jzGEPLw49gj9tL4WMiXCNu+9XRPrHSIOyBjurSOZF
 uyPIA41g1tq0fU4EePJCRY4Ek/ERY/tGTOxF9ls0VaqyVNY+p7D4V5TcWIlwf7ch82Jy
 0P6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695152837; x=1695757637;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+zWuaDw2mlkJcL1kGZZHZ9zJPxnzfj7VRZGQLIW+eX4=;
 b=Uv0o2FFfS+lEmK1jlZQ5R3iAapbec9+1xUENCRRRhIXy1Yco0PgHQrt7ruzJaHmpCu
 hnF3zf+JJ82QmPm0I4a81SOSOj2S+4FsfnR+a691nyzaXVXdCpMm2iTt3UpyVO3OQ8MG
 H2hGfvbhi/WJNzlzZk5oxbnNUAuAjpY0t0w1Md/hb9HuJ+rD9xZlakJR2MtUXnyl6AOv
 JhBwX51rMrvs9Sp2JgHCXle3m/3H4twCpNFq8GAtOD6SvA5IGcbltMmPRtZ+EKlbxVFj
 MBQ/RC/lpAfMwdcGiFikjZA4V1ML6V+ZOo2VZb6LLnsLGnZW17ZPkFDBLBCbZ4KK+kt7
 EJqw==
X-Gm-Message-State: AOJu0YxtbqVTY/SYWU1OW3ZOrv9ry3y3Dy87yF5vBpXm7UP/qs2oM7gm
 q8DLdO1f+OZWg4Ujb2gnLX6PjxyximI=
X-Google-Smtp-Source: AGHT+IG4iIs9zoIk1f6SPLJAorXyEEhRbyl7o+AhieoSkblfzZbyGrwsT5q8qg4HGL7RkAR+YdQwRA==
X-Received: by 2002:a05:6000:149:b0:321:5141:5523 with SMTP id
 r9-20020a056000014900b0032151415523mr505860wrx.67.1695152836935; 
 Tue, 19 Sep 2023 12:47:16 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-183-084-126.77.183.pool.telefonica.de.
 [77.183.84.126]) by smtp.gmail.com with ESMTPSA id
 s17-20020a5d5111000000b0032148618cc4sm7923951wrt.29.2023.09.19.12.47.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 12:47:16 -0700 (PDT)
Date: Tue, 19 Sep 2023 19:47:09 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 0/8] ACPI: X86 AML generation and GPE tracing cleanup
In-Reply-To: <20230908084234.17642-1-shentey@gmail.com>
References: <20230908084234.17642-1-shentey@gmail.com>
Message-ID: <9F292779-FCA7-43B3-BC37-CCE2E7958B57@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



Am 8=2E September 2023 08:42:26 UTC schrieb Bernhard Beschow <shentey@gmai=
l=2Ecom>:
>This series contains changes from my effort to bring the VIA south bridge=
s to
>
>the PC machine [1]=2E The first part of the series resolves the
>
>AcpiCpuAmlIfClass::madt_cpu virtual method which frees ACPI controllers f=
rom
>
>worrying about CPU AML generation=2E The second part minimizes an Intel-s=
pecific
>
>assumption in AML generation to just one place=2E The third part contains=
 two
>
>ACPI tracing patches which have been reviewed a long time ago but weren't=
 merged
>
>yet=2E
>
>
>
>The removal of AcpiCpuAmlIfClass::madt_cpu is essentially a respin of [2]=
 with
>
>a different approach=2E Igor wasn't generally against it but wasn't convi=
nced
>
>either [3]=2E The new approach causes much less churn and instead allows =
to
>
>remove code=2E So I think it's worth to be reconsidered=2E
>
>
>
>The motivation for removing this virtual method didn't change: It frees t=
he ACPI
>
>controllers in general and PIIX4 PM in particular from generating X86 CPU=
 AML=2E
>
>The latter is also used in MPIS context where X86 CPU AML generation is
>
>stubbed out=2E This indicates a design issue where a problem was solved a=
t the
>
>wrong place=2E Moreover, it turned out that TYPE_ACPI_GED_X86 could be re=
moved as
>
>well, further supporting this claim=2E
>
>
>
>The second part of this series limits SMI command port determination duri=
ng AML
>
>generation to just one place=2E Currently the ACPI_PORT_SMI_CMD constant =
is used
>
>multiple times which has an Intel-specific value=2E In order to make the =
code a
>
>microscopic bit more compatible with our VIA south bridge models its usag=
e gets
>
>limited to one place, allowing the constant to be turned into a device mo=
del
>
>property in the future=2E
>
>
>
>The third part improves the tracing experience for ACPI general purpose e=
vents=2E
>
>It originates from an old series: [4]=2E
>
>
>
>Testing done:
>
>* `make check`
>
>* `make check-avocado`
>
>
>
>v2:
>
>* Trace ACPI GPE values with "0x%02" (Phil)
>

Ping

All patches reviewed=2E Michael, are you the one going to queue it?

Thanks,
Bernhard

>
>
>[1] https://github=2Ecom/shentok/qemu/tree/pc-via
>
>[2] https://lore=2Ekernel=2Eorg/qemu-devel/20230121151941=2E24120-1-shent=
ey@gmail=2Ecom/
>
>[3] https://lore=2Ekernel=2Eorg/qemu-devel/20230125174842=2E395fda5d@imam=
medo=2Eusers=2Eipa=2Eredhat=2Ecom/
>
>[4] https://patchew=2Eorg/QEMU/20230122170724=2E21868-1-shentey@gmail=2Ec=
om/
>
>
>
>Bernhard Beschow (8):
>
>  hw/i386/acpi-build: Use pc_madt_cpu_entry() directly
>
>  hw/acpi/cpu: Have build_cpus_aml() take a build_madt_cpu_fn callback
>
>  hw/acpi/acpi_dev_interface: Remove now unused madt_cpu virtual method
>
>  hw/acpi/acpi_dev_interface: Remove now unused #include "hw/boards=2Eh"
=
>
>  hw/i386: Remove now redundant TYPE_ACPI_GED_X86
>
>  hw/i386/acpi-build: Determine SMI command port just once
>
>  hw/acpi: Trace GPE access in all device models, not just PIIX4
>
>  hw/acpi/core: Trace enable and status registers of GPE separately
>
>
>
> hw/acpi/hmat=2Eh                         |  3 ++-
>
> hw/i386/acpi-common=2Eh                  |  3 +--
>
> include/hw/acpi/acpi_dev_interface=2Eh   |  3 ---
>
> include/hw/acpi/cpu=2Eh                  |  6 ++++-
>
> include/hw/acpi/generic_event_device=2Eh |  2 --
>
> hw/acpi/acpi-x86-stub=2Ec                |  6 -----
>
> hw/acpi/core=2Ec                         |  9 +++++++
>
> hw/acpi/cpu=2Ec                          |  9 +++----
>
> hw/acpi/hmat=2Ec                         |  1 +
>
> hw/acpi/memory_hotplug=2Ec               |  1 +
>
> hw/acpi/piix4=2Ec                        |  5 ----
>
> hw/i386/acpi-build=2Ec                   | 13 +++++-----
>
> hw/i386/acpi-common=2Ec                  |  5 ++--
>
> hw/i386/acpi-microvm=2Ec                 |  3 +--
>
> hw/i386/generic_event_device_x86=2Ec     | 36 --------------------------=

>
> hw/i386/microvm=2Ec                      |  2 +-
>
> hw/isa/lpc_ich9=2Ec                      |  1 -
>
> hw/acpi/trace-events                   | 10 ++++---
>
> hw/i386/meson=2Ebuild                    |  1 -
>
> 19 files changed, 38 insertions(+), 81 deletions(-)
>
> delete mode 100644 hw/i386/generic_event_device_x86=2Ec
>
>
>
>-- >
>2=2E42=2E0
>
>
>

