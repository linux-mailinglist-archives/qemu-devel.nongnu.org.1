Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CE07D09B8
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:51:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtkGc-0005Np-Ck; Fri, 20 Oct 2023 03:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qtkGa-0005Ad-RW; Fri, 20 Oct 2023 03:49:56 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qtkGY-0005OO-RC; Fri, 20 Oct 2023 03:49:56 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so478492b3a.1; 
 Fri, 20 Oct 2023 00:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697788192; x=1698392992; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHs5vheDKVxWoucHAnJIKwlCbbGfzJ/voQUXMzBwong=;
 b=K24XRtfGcARdbw6cYUP73w3UU8f3y9RQwMkKfBg8Y4Ln6ojB5Rdmsvd7Ad0c9biTYx
 003zGHNvAZoCULmx/QW5RjMVUv1c/HKSZxjJso8aVIOnSsDn0RQpwh4AgpVa/pFvTU8M
 jUcxmvs5w7uG6wpAeZcGa4RUGOfk08zzsz/5WdZ9aCaIO+2Wn1LMngX7vGam8bWVrGL0
 VazYI8T4SKO3FRUzeHJQrukTpJJq51Rbr0R6zZBoSOnIG7uTWIdi9rsp1nnmXzHfzPhF
 GoAFnJpj9+mXe0ebyqQHhhkIu1bXJdqCRM3iJtMb8CdleWLFDDpUyPSUKFG4f8/X3A+W
 EIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697788192; x=1698392992;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eHs5vheDKVxWoucHAnJIKwlCbbGfzJ/voQUXMzBwong=;
 b=noV8IUhnhPD+oINi/D28ANAZy+xaXByCM+c/sLVTvjL213wvjcjzp6IuBUwYx2TTn4
 cHrGN9+PS2fj/3skgKp5Fxci3hOlacXbS1ctoCk6D7OOrshYuz07w4GViZaM9KSZ6ywp
 RCzSFzXUdD2c/pzPTKJDFP7cCMKcYNZZa0w1KqS6X+XVjsIB1FXzBTS7H/V/iRqgjoa+
 0JWYN/c0kH9noCfK0fxvurVETKzpYglPqlj49i3YX1j/5IBoYpjGteqa0XuDiz6inJ/i
 xzjTZPTndoE/PS0hoNi6bzdob7a4YorWr5bA2KDSQ3oS6OsWimaIbuf/b9mjdBsr4woQ
 bYCg==
X-Gm-Message-State: AOJu0YyNvzVJ743D9TMYkpBkvbGHwOYThT3P1vZZphx4RTV2ikHdYSSz
 gtTdvKVjNvgjChB4JSGI7mw=
X-Google-Smtp-Source: AGHT+IEkxZZbGZEYSJYyc2k3/XnaBsWJUhPr2Zl70OCIIMI61xHEOPeyxdt0KMDbbvCoGq7+A6dRFQ==
X-Received: by 2002:a05:6a00:1514:b0:691:1eb:7dda with SMTP id
 q20-20020a056a00151400b0069101eb7ddamr1150624pfu.7.1697788191615; 
 Fri, 20 Oct 2023 00:49:51 -0700 (PDT)
Received: from localhost (61-68-209-245.tpgi.com.au. [61.68.209.245])
 by smtp.gmail.com with ESMTPSA id
 b189-20020a62cfc6000000b0069029a3196dsm969512pfg.184.2023.10.20.00.49.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 00:49:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Oct 2023 17:49:38 +1000
Message-Id: <CWD3OHT178VU.3NF8B5Y5BOK1S@wheely>
Subject: Re: [PATCH 07/13] RFC migration: icp/server is a mess
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Greg Kurz" <groug@kaod.org>, "Juan Quintela" <quintela@redhat.com>
Cc: <qemu-devel@nongnu.org>, "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>, <qemu-ppc@nongnu.org>,
 <qemu-s390x@nongnu.org>, "Gerd Hoffmann" <kraxel@redhat.com>, "Corey
 Minyard" <cminyard@mvista.com>, "Samuel Thibault"
 <samuel.thibault@ens-lyon.org>, "Richard Henderson"
 <richard.henderson@linaro.org>, "David Hildenbrand" <david@redhat.com>,
 "Ilya Leoshkevich" <iii@linux.ibm.com>, "Fabiano Rosas" <farosas@suse.de>,
 "Eric Farman" <farman@linux.ibm.com>, "Peter Xu" <peterx@redhat.com>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "John Snow"
 <jsnow@redhat.com>, <qemu-block@nongnu.org>, "Mark Cave-Ayland"
 <mark.cave-ayland@ilande.co.uk>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, =?utf-8?q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, "Stefan Weil" <sw@weilnetz.de>,
 <qemu-arm@nongnu.org>, "Jason Wang" <jasowang@redhat.com>, "Corey Minyard"
 <minyard@acm.org>, "Leonardo Bras" <leobras@redhat.com>, "Thomas Huth"
 <thuth@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "David Gibson" <david@gibson.dropbear.id.au>, "Halil Pasic"
 <pasic@linux.ibm.com>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.15.2
References: <20231019190831.20363-1-quintela@redhat.com>
 <20231019190831.20363-8-quintela@redhat.com>
 <20231019233958.17abb488@bahia>
In-Reply-To: <20231019233958.17abb488@bahia>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

On Fri Oct 20, 2023 at 7:39 AM AEST, Greg Kurz wrote:
> On Thu, 19 Oct 2023 21:08:25 +0200
> Juan Quintela <quintela@redhat.com> wrote:
>
> > Current code does:
> > - register pre_2_10_vmstate_dummy_icp with "icp/server" and instance
> >   dependinfg on cpu number
> > - for newer machines, it register vmstate_icp with "icp/server" name
> >   and instance 0
> > - now it unregisters "icp/server" for the 1st instance.
> >=20
> > This is wrong at many levels:
> > - we shouldn't have two VMSTATEDescriptions with the same name
> > - In case this is the only solution that we can came with, it needs to
> >   be:
> >   * register pre_2_10_vmstate_dummy_icp
> >   * unregister pre_2_10_vmstate_dummy_icp
> >   * register real vmstate_icp
> >=20
> > As the initialization of this machine is already complex enough, I
> > need help from PPC maintainers to fix this.
> >=20
> > Volunteers?
> >=20
> > CC: Cedric Le Goater <clg@kaod.org>
> > CC: Daniel Henrique Barboza <danielhb413@gmail.com>
> > CC: David Gibson <david@gibson.dropbear.id.au>
> > CC: Greg Kurz <groug@kaod.org>
> >=20
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> >  hw/ppc/spapr.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index cb840676d3..8531d13492 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -143,7 +143,12 @@ static bool pre_2_10_vmstate_dummy_icp_needed(void=
 *opaque)
> >  }
> > =20
> >  static const VMStateDescription pre_2_10_vmstate_dummy_icp =3D {
> > -    .name =3D "icp/server",
> > +    /*
> > +     * Hack ahead.  We can't have two devices with the same name and
> > +     * instance id.  So I rename this to pass make check.
> > +     * Real help from people who knows the hardware is needed.
> > +     */
> > +    .name =3D "pre-2.10-icp/server",
> >      .version_id =3D 1,
> >      .minimum_version_id =3D 1,
> >      .needed =3D pre_2_10_vmstate_dummy_icp_needed,
>
> I guess this fix is acceptable as well and a lot simpler than
> reverting the hack actually. Outcome is the same : drop
> compat with pseries-2.9 and older.
>
> Reviewed-by: Greg Kurz <groug@kaod.org>

So the reason we can't have duplicate names registered, aside from it
surely going bad if we actually send or receive a stream at the point
they are registered, is the duplcate check introduced in patch 9? But
before that, this hack does seem to actually work because the duplicate
is unregistered right away.

If I understand the workaround, there is an asymmetry in the migration
sequence in that receiving an unexpected object would cause a failure,
but going from newer to older would just skip some "expected" objects
and that didn't cause a problem. So you only have to deal with ignoring
the unexpected ones going form older to newer.

Side question, is it possible to flag the problem of *not* receiving
an object that you did expect? That might be a source of bugs too.

Anyway, I wonder if we could fix this spapr problem by adding a special
case wild card instance matcher to ignore it? It's still a bit hacky
but maybe a bit nicer. I don't mind deprecating the machine soon if
you want to clear the wildcard hack away soon, but it would be nice to
separate the deprecation and removal from the fix, if possible.

This patch is not tested but hopefully helps illustrate the idea.

Thanks,
Nick

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1a31fb7293..8ce03edefa 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1205,6 +1205,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDe=
scription *vmsd,
 bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque);
=20
 #define  VMSTATE_INSTANCE_ID_ANY  -1
+#define  VMSTATE_INSTANCE_ID_WILD -2
=20
 /* Returns: 0 on success, -1 on failure */
 int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cb840676d3..2418899dd4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -155,16 +155,10 @@ static const VMStateDescription pre_2_10_vmstate_dumm=
y_icp =3D {
     },
 };
=20
-static void pre_2_10_vmstate_register_dummy_icp(int i)
+static void pre_2_10_vmstate_register_dummy_icp(void)
 {
-    vmstate_register(NULL, i, &pre_2_10_vmstate_dummy_icp,
-                     (void *)(uintptr_t) i);
-}
-
-static void pre_2_10_vmstate_unregister_dummy_icp(int i)
-{
-    vmstate_unregister(NULL, &pre_2_10_vmstate_dummy_icp,
-                       (void *)(uintptr_t) i);
+    vmstate_register(NULL, VMSTATE_INSTANCE_ID_WILD,
+                     &pre_2_10_vmstate_dummy_icp, NULL);
 }
=20
 int spapr_max_server_number(SpaprMachineState *spapr)
@@ -2665,12 +2659,10 @@ static void spapr_init_cpus(SpaprMachineState *spap=
r)
     }
=20
     if (smc->pre_2_10_has_unused_icps) {
-        for (i =3D 0; i < spapr_max_server_number(spapr); i++) {
-            /* Dummy entries get deregistered when real ICPState objects
-             * are registered during CPU core hotplug.
-             */
-            pre_2_10_vmstate_register_dummy_icp(i);
-        }
+        /* Dummy entries get deregistered when real ICPState objects
+         * are registered during CPU core hotplug.
+         */
+        pre_2_10_vmstate_register_dummy_icp();
     }
=20
     for (i =3D 0; i < possible_cpus->len; i++) {
@@ -3873,21 +3865,9 @@ void spapr_core_release(DeviceState *dev)
 static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *de=
v)
 {
     MachineState *ms =3D MACHINE(hotplug_dev);
-    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
     CPUCore *cc =3D CPU_CORE(dev);
     CPUArchId *core_slot =3D spapr_find_cpu_slot(ms, cc->core_id, NULL);
=20
-    if (smc->pre_2_10_has_unused_icps) {
-        SpaprCpuCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
-        int i;
-
-        for (i =3D 0; i < cc->nr_threads; i++) {
-            CPUState *cs =3D CPU(sc->threads[i]);
-
-            pre_2_10_vmstate_register_dummy_icp(cs->cpu_index);
-        }
-    }
-
     assert(core_slot);
     core_slot->cpu =3D NULL;
     qdev_unrealize(dev);
@@ -3968,10 +3948,8 @@ static void spapr_core_plug(HotplugHandler *hotplug_=
dev, DeviceState *dev)
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc =3D MACHINE_GET_CLASS(spapr);
-    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     SpaprCpuCore *core =3D SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc =3D CPU_CORE(dev);
-    CPUState *cs;
     SpaprDrc *drc;
     CPUArchId *core_slot;
     int index;
@@ -4018,13 +3996,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_=
dev, DeviceState *dev)
                            &error_abort);
         }
     }
-
-    if (smc->pre_2_10_has_unused_icps) {
-        for (i =3D 0; i < cc->nr_threads; i++) {
-            cs =3D CPU(core->threads[i]);
-            pre_2_10_vmstate_unregister_dummy_icp(cs->cpu_index);
-        }
-    }
 }
=20
 static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *=
dev,
diff --git a/migration/savevm.c b/migration/savevm.c
index 497ce02bd7..f33449e208 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -989,6 +989,10 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *s=
e, JSONWriter *vmdesc)
         trace_savevm_section_skip(se->idstr, se->section_id);
         return 0;
     }
+    if (se->instance_id =3D=3D VMSTATE_INSTANCE_ID_WILD) {
+        warn_report("Wildcard vmstate entry must set needed=3Dfalse");
+        return 0;
+    }
=20
     trace_savevm_section_start(se->idstr, se->section_id);
     save_section_header(f, se, QEMU_VM_SECTION_FULL);
@@ -1731,13 +1735,16 @@ int qemu_save_device_state(QEMUFile *f)
=20
 static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id)
 {
+    SaveStateEntry *se_wild =3D NULL;
     SaveStateEntry *se;
=20
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!strcmp(se->idstr, idstr) &&
-            (instance_id =3D=3D se->instance_id ||
-             instance_id =3D=3D se->alias_id))
-            return se;
+        if (!strcmp(se->idstr, idstr)) {
+            if (instance_id =3D=3D se->instance_id || instance_id =3D=3D s=
e->alias_id)
+                return se;
+            if (se->instance_id =3D=3D VMSTATE_INSTANCE_ID_WILD)
+                se_wild =3D se;
+        }
         /* Migrating from an older version? */
         if (strstr(se->idstr, idstr) && se->compat) {
             if (!strcmp(se->compat->idstr, idstr) &&
@@ -1746,7 +1753,7 @@ static SaveStateEntry *find_se(const char *idstr, uin=
t32_t instance_id)
                 return se;
         }
     }
-    return NULL;
+    return se_wild;
 }
=20
 enum LoadVMExitCodes {

