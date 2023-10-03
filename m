Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 193507B751D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:37:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnox2-0001io-0V; Tue, 03 Oct 2023 19:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qnoww-0001UC-WD
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:37:11 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qnowv-0007n3-1i
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:37:10 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so75976466b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696376226; x=1696981026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72vQoCi+4+Rpz8kpqWgejP/tRbOJ9Kf0G55V/PnvpAg=;
 b=andznbEkO/jDIzsLV7U7TY8nB3GPyMQnRs5E2Y5stOkE5I2eb/ao++bvUSHhiDAEJD
 C88ucArznRKnypXn1VvtgW6QVgZqYY9zVLXoHkFh3RYS+ZHD1GAnKA6UPxp1+UXJwVLv
 e1INjZpOVk9gc3sZXTN1QxdSG/uUH5xPRD/UioaC+K4t/V3wqD0dh5fDHzJt8gEzfgz6
 6Ele2P9cmiZDuYFopyBSMzZ9lrthkfLIcsM4zvV9A39RwDpVeb+dy+jWyGyuY8XkMeNO
 PqZfmWEbrcECyx9OQxbpb1REH0ssmej22ws4hJj+kjaFbTcRjFE5mAcbtgqQmWP1rqGS
 dxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376226; x=1696981026;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72vQoCi+4+Rpz8kpqWgejP/tRbOJ9Kf0G55V/PnvpAg=;
 b=wjOpXnAH6Sx2K2ldz+l6OYQvlfXZOhfDfQiQYlVyHszlwWPgLIhb7zWgLQOro0Et+0
 U9h9+GDzPo8hAevFCJo9ZLdATMcvGF4wbxYJ01TFsAF+r+QVn/CdkzM6m9c55tqZfela
 A2KBnGVJT3XDGKCOxKxMl55b8ACZBUuRtVGhkQGMs0yo94921sJk+g496wc4bd8UWpEr
 54l6OXpenPB0HmDJ0IbuhaOxfqkxzR91hlD20MZIw5+2A9Pqh0INHe5wOwzpUeURBzca
 KJYe3vMOtwZIj6hpry4DosEpbmVfKY6D/oih4f4I/Rpmmp5b9sOqN6B/5cVNKslWDRCm
 uOVA==
X-Gm-Message-State: AOJu0YwTcrXfhkSIAFUjp1uDE1sWlsL1FLQF1DJKRgEg1tTKTXn2P2qn
 6BnRiYKmS8mT2g4x8HTo7x5kCuzfWME=
X-Google-Smtp-Source: AGHT+IHNORQmAZV5YJfaq40pPl1WWubYCf0HluGXuJkoejXvOCJBoM0WPXklqYdVqFqrcAfe962pKQ==
X-Received: by 2002:a17:907:728e:b0:9ae:5f52:a491 with SMTP id
 dt14-20020a170907728e00b009ae5f52a491mr3420025ejc.8.1696376226503; 
 Tue, 03 Oct 2023 16:37:06 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf2af200c1d1cd88f0d7c31c.dip0.t-ipconnect.de.
 [2003:fa:af2a:f200:c1d1:cd88:f0d7:c31c])
 by smtp.gmail.com with ESMTPSA id
 gv2-20020a170906f10200b009828e26e519sm1745518ejb.122.2023.10.03.16.37.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 16:37:06 -0700 (PDT)
Date: Tue, 03 Oct 2023 23:36:58 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
CC: berrange@redhat.com, balaton@eik.bme.hu,
 Martin Kletzander <mkletzan@redhat.com>
Subject: Re: [PATCH v3 08/14] Introduce machine property "audiodev"
In-Reply-To: <20230929085112.983957-9-pbonzini@redhat.com>
References: <20230929085112.983957-1-pbonzini@redhat.com>
 <20230929085112.983957-9-pbonzini@redhat.com>
Message-ID: <2F88E9A1-09DE-444A-877A-4D911420E6BC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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



Am 29=2E September 2023 08:51:01 UTC schrieb Paolo Bonzini <pbonzini@redha=
t=2Ecom>:
>From: Martin Kletzander <mkletzan@redhat=2Ecom>
>
>Many machine types have default audio devices with no way to set the unde=
rlying
>audiodev=2E  Instead of adding an option for each and every one of them, =
this new
>property can be used as a default during machine initialisation when crea=
ting
>such devices=2E
>
>Signed-off-by: Martin Kletzander <mkletzan@redhat=2Ecom>
>[Make the property optional, instead of including it in all machines=2E -=
 Paolo]
>Signed-off-by: Paolo Bonzini <pbonzini@redhat=2Ecom>
>---
> hw/core/machine=2Ec   | 33 +++++++++++++++++++++++++++++++++
> include/hw/boards=2Eh |  9 +++++++++
> 2 files changed, 42 insertions(+)
>
>diff --git a/hw/core/machine=2Ec b/hw/core/machine=2Ec
>index cb38b8cf4cb=2E=2E6aa49c8d4f1 100644
>--- a/hw/core/machine=2Ec
>+++ b/hw/core/machine=2Ec
>@@ -39,6 +39,7 @@
> #include "hw/virtio/virtio=2Eh"
> #include "hw/virtio/virtio-pci=2Eh"
> #include "hw/virtio/virtio-net=2Eh"
>+#include "audio/audio=2Eh"
>=20
> GlobalProperty hw_compat_8_1[] =3D {};
> const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
>@@ -686,6 +687,26 @@ bool device_type_is_dynamic_sysbus(MachineClass *mc,=
 const char *type)
>     return allowed;
> }
>=20
>+static char *machine_get_audiodev(Object *obj, Error **errp)
>+{
>+    MachineState *ms =3D MACHINE(obj);
>+
>+    return g_strdup(ms->audiodev);
>+}
>+
>+static void machine_set_audiodev(Object *obj, const char *value,
>+                                 Error **errp)
>+{
>+    MachineState *ms =3D MACHINE(obj);
>+
>+    if (!audio_state_by_name(value, errp)) {
>+        return;
>+    }
>+
>+    g_free(ms->audiodev);
>+    ms->audiodev =3D g_strdup(value);
>+}
>+
> HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machi=
ne)
> {
>     int i;
>@@ -931,6 +952,17 @@ out_free:
>     qapi_free_BootConfiguration(config);
> }
>=20
>+void machine_add_audiodev_property(MachineClass *mc)
>+{
>+    ObjectClass *oc =3D OBJECT_CLASS(mc);
>+
>+    object_class_property_add_str(oc, "audiodev",
>+                                  machine_get_audiodev,
>+                                  machine_set_audiodev);
>+    object_class_property_set_description(oc, "audiodev",
>+                                          "Audiodev to use for default m=
achine devices");
>+}
>+
> static void machine_class_init(ObjectClass *oc, void *data)
> {
>     MachineClass *mc =3D MACHINE_CLASS(oc);
>@@ -1136,6 +1168,7 @@ static void machine_finalize(Object *obj)
>     g_free(ms->device_memory);
>     g_free(ms->nvdimms_state);
>     g_free(ms->numa_state);
>+    g_free(ms->audiodev);
> }
>=20
> bool machine_usb(MachineState *machine)
>diff --git a/include/hw/boards=2Eh b/include/hw/boards=2Eh
>index 6c67af196a3=2E=2E55a64a13fdf 100644
>--- a/include/hw/boards=2Eh
>+++ b/include/hw/boards=2Eh
>@@ -24,6 +24,7 @@ OBJECT_DECLARE_TYPE(MachineState, MachineClass, MACHINE=
)
>=20
> extern MachineState *current_machine;
>=20
>+void machine_add_audiodev_property(MachineClass *mc);

I'm a bit late now since the code is already in master but I wonder if thi=
s function should've been named machine_*class_*add_audiodev_property()=2E =
At least similar functions in this header suggest so=2E

Best regards,
Bernhard

> void machine_run_board_init(MachineState *machine, const char *mem_path,=
 Error **errp);
> bool machine_usb(MachineState *machine);
> int machine_phandle_start(MachineState *machine);
>@@ -358,6 +359,14 @@ struct MachineState {
>     MemoryRegion *ram;
>     DeviceMemoryState *device_memory;
>=20
>+    /*
>+     * Included in MachineState for simplicity, but not supported
>+     * unless machine_add_audiodev_property is called=2E  Boards
>+     * that have embedded audio devices can call it from the
>+     * machine init function and forward the property to the device=2E
>+     */
>+    char *audiodev;
>+
>     ram_addr_t ram_size;
>     ram_addr_t maxram_size;
>     uint64_t   ram_slots;

