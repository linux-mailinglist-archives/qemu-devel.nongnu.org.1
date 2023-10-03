Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 268EE7B74CA
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:23:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnoiM-0008CE-8x; Tue, 03 Oct 2023 19:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qnoiI-0008AL-Fa
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:22:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qnoiF-00020W-VG
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:22:01 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4056ce55e7eso14846715e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696375318; x=1696980118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0f2vU2Tp5kWcSidG+0GfHM2fCZDc8Gx6g04Mw7tskOQ=;
 b=FkPVVLBrenzPFCdTT4YXv+4mm8vHCq7n6MVUb9xuOa+QG9+V5zBtEpHCgJf9z0sPmh
 O5E+8FqTMctHLQiTK82Rq9RUvezwRIJYGtJ6KJnGHwnfwQDqlzM+ow1GyvqrKtbmvdTC
 xo0hEXampvkejyBQYVcNASSI5z1koh0wlZFM/dfjvNFU73rb35K9z7wWd9owkaJGlXsG
 X4oXfY9aN8MPAN+/zfv2UG379fLOmu8nP58p/aWQW2ZuF6p9Lvq16gRKjOmF5q+owjKO
 mqOdw+VXSLv7h34Hqyuif/L9uaRmeqMD+4rIS3V6Lbi4DHGZBnBJ06x8KcO5rM2BaY5n
 8DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696375318; x=1696980118;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0f2vU2Tp5kWcSidG+0GfHM2fCZDc8Gx6g04Mw7tskOQ=;
 b=tOyLtQPNtzbFWaWpgZGBh0uIZVLvPeUjNlp00C38JM68vo2AoNnJIsO9INh8tu/4DU
 SjdbA36nKh6sz/NQdTyvL1O2KFeXGCyhd6lQipgs1hqMa6eKjFv4nCN6Kg90Mia7Aw8O
 0V9NHnjipDom8J+7VbePMJkYwlFx7kinO2DRHuHAWobDRGsdSYyq3khBc3LdUaeLjOX6
 YgJ+HykSh3FN5xPicpWZLP+YanRtdz/JiMKW85gPNm27mAYiG1WaDxonxj/u+Xyl5b9z
 ZmQJ9EJgceTnSkrXjsPaBS3ClfqoULSu0O7fhzy4yiBBeYOy1/0sFf/1Far0acyckTHG
 Lqkw==
X-Gm-Message-State: AOJu0YxqFwlSZi3IysrLTOVnsuuOrZDb1jqBrQcRUTp43PZaITTeYP41
 5lfnHbdVMqMdLXzYk43xbIM=
X-Google-Smtp-Source: AGHT+IEC074fRZKcdokyRhXPs5k5guhCmyzZ3EFdtul0nSCYX14H1Ts7kvvgI4iSqeWC7v5WZ/YSLA==
X-Received: by 2002:a5d:4fd2:0:b0:314:15a8:7879 with SMTP id
 h18-20020a5d4fd2000000b0031415a87879mr595484wrw.34.1696375317508; 
 Tue, 03 Oct 2023 16:21:57 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf2af200c1d1cd88f0d7c31c.dip0.t-ipconnect.de.
 [2003:fa:af2a:f200:c1d1:cd88:f0d7:c31c])
 by smtp.gmail.com with ESMTPSA id
 q17-20020aa7da91000000b00537f44827a8sm1481276eds.64.2023.10.03.16.21.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 16:21:57 -0700 (PDT)
Date: Tue, 03 Oct 2023 23:21:50 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/5=5D_hw/i386/apic=3A_Defer_error_?=
 =?US-ASCII?Q?check_from_apic=5Fget=5Fclass_to_kvm=5Fapic=5Frealize?=
In-Reply-To: <20231003082728.83496-3-philmd@linaro.org>
References: <20231003082728.83496-1-philmd@linaro.org>
 <20231003082728.83496-3-philmd@linaro.org>
Message-ID: <8527EF0C-E466-41A0-B1A2-9AEF301B5B5E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x336.google.com
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



Am 3=2E Oktober 2023 08:27:25 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>apic_get_class() isn't supposed to fail=2E kvm_apic_realize() is
>DeviceRealize() handler, which can fail=2E Defer the error check
>to the latter=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> hw/i386/kvm/apic=2Ec       | 5 +++++
> target/i386/cpu-sysemu=2Ec | 8 --------
> 2 files changed, 5 insertions(+), 8 deletions(-)
>
>diff --git a/hw/i386/kvm/apic=2Ec b/hw/i386/kvm/apic=2Ec
>index 1e89ca0899=2E=2E4883308247 100644
>--- a/hw/i386/kvm/apic=2Ec
>+++ b/hw/i386/kvm/apic=2Ec
>@@ -228,6 +228,11 @@ static void kvm_apic_realize(DeviceState *dev, Error=
 **errp)
> {
>     APICCommonState *s =3D APIC_COMMON(dev);
>=20
>+    if (!kvm_irqchip_in_kernel()) {
>+        error_setg(errp, "KVM does not support userspace APIC");
>+        return;
>+    }
>+
>     memory_region_init_io(&s->io_memory, OBJECT(s), &kvm_apic_io_ops, s,
>                           "kvm-apic-msi", APIC_SPACE_SIZE);
>=20
>diff --git a/target/i386/cpu-sysemu=2Ec b/target/i386/cpu-sysemu=2Ec
>index 2375e48178=2E=2E6a228c9178 100644
>--- a/target/i386/cpu-sysemu=2Ec
>+++ b/target/i386/cpu-sysemu=2Ec
>@@ -253,10 +253,6 @@ APICCommonClass *apic_get_class(Error **errp)
>=20
>     /* TODO: in-kernel irqchip for hvf */
>     if (kvm_enabled()) {
>-        if (!kvm_irqchip_in_kernel()) {
>-            error_setg(errp, "KVM does not support userspace APIC");
>-            return NULL;
>-        }
>         apic_type =3D "kvm-apic";
>     } else if (xen_enabled()) {
>         apic_type =3D "xen-apic";
>@@ -272,10 +268,6 @@ void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
>     APICCommonState *apic;
>     APICCommonClass *apic_class =3D apic_get_class(errp);
>=20
>-    if (!apic_class) {
>-        return;
>-    }
>-

Did you intend to remove these lines in the next commit? There you're writ=
ing to simplify x86_cpu_apic_create() which you're doing here already=2E

Best regards,
Bernhard

>     cpu->apic_state =3D DEVICE(object_new_with_class(OBJECT_CLASS(apic_c=
lass)));
>     object_property_add_child(OBJECT(cpu), "lapic",
>                               OBJECT(cpu->apic_state));

