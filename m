Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEB47B7348
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 23:25:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmsM-0001zt-0m; Tue, 03 Oct 2023 17:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qnmsK-0001zl-5w
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:24:16 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qnmsI-0003mb-2y
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:24:15 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9ad8d47ef2fso254955766b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696368252; x=1696973052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EkG7v68Trxt68Cu2pyY78mexBbfH0R0LWq30kAO0N3o=;
 b=cSrEOpE4ETYV2Ddc1kfyn2XPxLWA2w2UYlpmaTgWPo+zT+mMRUoNnRqqEGl3JN2HVu
 pyLHrTsmYMjtZCHfP7IVCcUwxReZDV8bA9kHRVFbJIl+h9GoIstPls4APPhkJZVFrSXb
 QGZt+QO5Zyne18VLysgcpOHWhaiTPtka4JRbQqPMbiiDuhRr694UjRbwl7Hpph1+kaz6
 pUOlQNB68ch++XAvNU6hWxgGLmvHTdSDQjGKsAknOg5gnh90iAqgMd8LY1lrtJLbn3No
 9HQ2gwSE+5MCPQ3KAqCwirmlzg8nZCEOd/d+axR7SlrU+kR6ZBBnasVGX2rbrk+anr6z
 Lh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696368252; x=1696973052;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EkG7v68Trxt68Cu2pyY78mexBbfH0R0LWq30kAO0N3o=;
 b=sJDWRzGq8D7k5kfosUzu826g1hsbm6RiKMs/rUJu1x61SMSkmA9YIbruib7ARcx/PQ
 Qp3QWJSXaGapZ8Np+SDmvpLJSwwkAvoiJcGxmgEBbSOhGN2TA00IeGOrah5oOqHBekPB
 NgFdNhOo2uebMmZb9cXd8OLtIIWI9MIp7dXtF6/5H10f2YWRLu9lJnVQYvekIxUGLjcZ
 Jx1bVkfhfUpI2uLuzKPYHCiyZenxEBoZi6Zs/WRBCg4tLGgegeTLhb6uBbWmzY0eJJBM
 v4CdbHBiA1SEaBzJadw6XQZ8OvV+OUbOHGq/zyeGJ102Zau5W7RAb8d0AGmoQFefwvFX
 vrrw==
X-Gm-Message-State: AOJu0YyWUGv5aNIdxPTiNHp3jMxjYTbicGqpMHcvmgjRBhe1OAJkPfGV
 WJGBOvZvuebiow8zfWFEW/2IjKVbrls=
X-Google-Smtp-Source: AGHT+IEqxqm2N0xGP2NlJrkt0fi3pqRYcnp6vmRVk+1t81Cc8HF4XB1wfBkBEOjWL31M0/XchpIChw==
X-Received: by 2002:a17:906:2d2:b0:9ad:8ef8:a7e8 with SMTP id
 18-20020a17090602d200b009ad8ef8a7e8mr383684ejk.25.1696368251621; 
 Tue, 03 Oct 2023 14:24:11 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf2af2002dbc26c5e78fe5cc.dip0.t-ipconnect.de.
 [2003:fa:af2a:f200:2dbc:26c5:e78f:e5cc])
 by smtp.gmail.com with ESMTPSA id
 kq15-20020a170906abcf00b009875a6d28b0sm1619670ejb.51.2023.10.03.14.24.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 14:24:11 -0700 (PDT)
Date: Tue, 03 Oct 2023 21:24:03 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_hw/i386/acp?=
 =?US-ASCII?Q?i-build=3A_Remove_build-time_?=
 =?US-ASCII?Q?assertion_on_PIIX/ICH9_reset_registers_being_identical?=
In-Reply-To: <20231003211658.14327-1-shentey@gmail.com>
References: <20231003211658.14327-1-shentey@gmail.com>
Message-ID: <8A3B6DC2-95EB-4000-B615-34C2740ADC4E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
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

The iteration in the subject should have been 1, not 3=2E=2E=2E

Am 3=2E Oktober 2023 21:16:58 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>Commit 6103451aeb74 ("hw/i386: Build-time assertion on pc/q35 reset regis=
ter
>being identical=2E") introduced a build-time check where the addresses of=
 the
>reset registers are expected to be equal=2E Back then the code to generat=
e AML for
>the reset register in the FADT was common=2E However, since commit 937d1b=
58714b
>("pc: acpi: isolate FADT specific data into AcpiFadtData structure") the =
AML
>gets generated for ICH9 only=2E There is no need any loger for the assert=
ion, so
>remove it=2E
>
>Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>---
> hw/i386/acpi-build=2Ec | 5 -----
> 1 file changed, 5 deletions(-)
>
>diff --git a/hw/i386/acpi-build=2Ec b/hw/i386/acpi-build=2Ec
>index 95199c8900=2E=2E6fff1901f5 100644
>--- a/hw/i386/acpi-build=2Ec
>+++ b/hw/i386/acpi-build=2Ec
>@@ -56,7 +56,6 @@
>=20
> /* Supported chipsets: */
> #include "hw/southbridge/ich9=2Eh"
>-#include "hw/southbridge/piix=2Eh"
> #include "hw/acpi/pcihp=2Eh"
> #include "hw/i386/fw_cfg=2Eh"
> #include "hw/i386/pc=2Eh"
>@@ -242,10 +241,6 @@ static void acpi_get_pm_info(MachineState *machine, =
AcpiPmInfo *pm)
>     pm->pcihp_io_len =3D
>         object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
>=20
>-    /* The above need not be conditional on machine type because the res=
et port
>-     * happens to be the same on PIIX (pc) and ICH9 (q35)=2E */
>-    QEMU_BUILD_BUG_ON(ICH9_RST_CNT_IOPORT !=3D PIIX_RCR_IOPORT);
>-
>     /* Fill in optional s3/s4 related properties */
>     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NUL=
L);
>     if (o) {

