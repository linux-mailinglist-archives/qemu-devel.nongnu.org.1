Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D88359B1210
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Oct 2024 23:57:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4SI5-0001MV-9T; Fri, 25 Oct 2024 17:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t4SHz-0001M1-4G
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 17:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t4SHx-0006op-Ct
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 17:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729893366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FHPMo7dNj04ukn/DEUAyILsQbeciY5MqgtVnPEDVggE=;
 b=AyQWnRmuMUJMmBX8lzFRaxdt80Fxv3alSJGpavxBq1+bVQ/Dc3hXUSUv/NezQQKFCjWlh+
 0UvJRPDaiaItNE06iMRDnS/CZX+ufGlyRx+DOq+ICXTKfoDP8tXd49T7fC2OJkHpMAKoC2
 RIaegylQw4hZYxerWWPGJ7huyhu1L+4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-2T-25HilPRaVC4xNmb5EZw-1; Fri, 25 Oct 2024 17:56:04 -0400
X-MC-Unique: 2T-25HilPRaVC4xNmb5EZw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cc32a0b26bso33955546d6.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 14:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729893364; x=1730498164;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHPMo7dNj04ukn/DEUAyILsQbeciY5MqgtVnPEDVggE=;
 b=IGUKIO7QxJXn+3buK1WXNvJYikRmP+yrWU59epqbZ9bW/gSPSlZoDirOCTfDWoLN/u
 kNob/DcgjQBtf8Yzdzu2xCPhLEdHjcIb1bMT8fv1/FTt2f9aM86UZ7Hl5vC3upf4mW3D
 qPV/aesMJ9fIOr6ddyU9IZAKZTe7rkgpSmCXMFcNtU1tbv6+U8ny4kod2IbgPIJYbiYr
 IoTCeMI1bEF0hkj4lciNZALppaeCulg0WeqX1D1aC7+tpup4/xsJ/ofFjSGZr9hhL9Zk
 cRz0+2tzH7q/oS7TTXxuBINNIe4PU0tHDDs9KAUq2w/4GPlGIz71NBNPaGPjstBdyOrP
 hm8g==
X-Gm-Message-State: AOJu0Yx5OuL5IWqIM1hD/wBZ8GTZvTBI/uwORWQ9hz54ycQ3eRRlEZng
 Q51lDqKF/sXduEQ8M/ExJgMKwtZuKNBt3APWwGDVBbNskjiq+CuDLsUKlpLkvfJqgUl+BrEsnV9
 9AeXrZTtcKWfWm4o1YAat8qRKtzS4IMx+3oAA/F5f3cs16HU9iRSQ
X-Received: by 2002:a05:6214:3d0e:b0:6cb:eea5:69e0 with SMTP id
 6a1803df08f44-6d1856f3c9bmr15814476d6.27.1729893363997; 
 Fri, 25 Oct 2024 14:56:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP/opelHhSkr0Waw8yYmlyfhGjAQbB1rfBviBwyXbARYJgSIlW/KrXXQoUYOV4sklcywUw3Q==
X-Received: by 2002:a05:6214:3d0e:b0:6cb:eea5:69e0 with SMTP id
 6a1803df08f44-6d1856f3c9bmr15814316d6.27.1729893363712; 
 Fri, 25 Oct 2024 14:56:03 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d179a2d472sm9658486d6.128.2024.10.25.14.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 14:56:02 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:55:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/4] x86/iommu: Make x86-iommu a singleton object
Message-ID: <ZxwT79JG0NzsDmPn@x1n>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-3-peterx@redhat.com>
 <87jzdwlekc.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzdwlekc.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 25, 2024 at 11:25:23AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > X86 IOMMUs cannot be created more than one on a system yet.  Make it a
> > singleton so it guards the system from accidentally create yet another
> > IOMMU object when one already presents.
> >
> > Now if someone tries to create more than one, e.g., via:
> >
> >   ./qemu -M q35 -device intel-iommu -device intel-iommu
> >
> > The error will change from:
> >
> >   qemu-system-x86_64: -device intel-iommu: QEMU does not support multiple vIOMMUs for x86 yet.
> >
> > To:
> >
> >   qemu-system-x86_64: -device intel-iommu: Class 'intel-iommu' only supports one instance
> >
> > Unfortunately, yet we can't remove the singleton check in the machine
> > hook (pc_machine_device_pre_plug_cb), because there can also be
> > virtio-iommu involved, which doesn't share a common parent class yet.
> >
> > But with this, it should be closer to reach that goal to check singleton by
> > QOM one day.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> $ qemu-system-x86_64 -device amd-iommu,help
> /work/armbru/qemu/include/hw/boards.h:24:MACHINE: Object 0x56473906f960 is not an instance of type machine
> Aborted (core dumped)
> 
> (gdb) bt
> #0  0x00007ffff4e43834 in __pthread_kill_implementation () at /lib64/libc.so.6
> #1  0x00007ffff4df18ee in raise () at /lib64/libc.so.6
> #2  0x00007ffff4dd98ff in abort () at /lib64/libc.so.6
> #3  0x0000555555f75ef3 in object_dynamic_cast_assert
>     (obj=0x555557e03960, typename=0x5555563c403e "machine", file=0x5555563c4018 "/work/armbru/qemu/include/hw/boards.h", line=24, func=0x5555563c4290 <__func__.7> "MACHINE") at ../qom/object.c:936
> #4  0x0000555555d5db0f in MACHINE (obj=0x555557e03960)
>     at /work/armbru/qemu/include/hw/boards.h:24
> #5  0x0000555555d5e030 in x86_iommu_get_default () at ../hw/i386/x86-iommu.c:83
> #6  0x0000555555d5e262 in x86_iommu_get_instance
>     (errp=0x5555573d4918 <error_abort>) at ../hw/i386/x86-iommu.c:139
> #7  0x0000555555f7c27c in singleton_get_instance (class=0x555557e00320)
>     at ../qom/object_interfaces.c:371
> #8  0x000055555612a842 in qmp_device_list_properties
>     (typename=0x555557e001d0 "amd-iommu", errp=0x7fffffffda38)
>     at ../qom/qom-qmp-cmds.c:147
> #9  0x0000555555bf20b2 in qdev_device_help (opts=0x555557e001f0)
>     at ../system/qdev-monitor.c:314
> #10 0x0000555555bfe06d in device_help_func
>     (opaque=0x0, opts=0x555557e001f0, errp=0x0) at ../system/vl.c:1208
> #11 0x0000555556217186 in qemu_opts_foreach
>     (list=0x55555729e5c0 <qemu_device_opts>, func=0x555555bfe04d <device_help_func>, opaque=0x0, errp=0x0) at ../util/qemu-option.c:1135
> #12 0x0000555555c01d56 in qemu_process_help_options () at ../system/vl.c:2555
> #13 0x0000555555c04d81 in qemu_init (argc=3, argv=0x7fffffffde28)
>     at ../system/vl.c:3654
> #14 0x000055555612ffae in main (argc=3, argv=0x7fffffffde28)
>     at ../system/main.c:47
> 

Thanks for the report!

It turns out that qdev_get_machine() cannot be invoked too early, and the
singleton code can make it earlier..

We may want a pre-requisite patch to allow qdev_get_machine() to be invoked
anytime, like:

===8<===
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index db36f54d91..7ceae47139 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -831,6 +831,16 @@ Object *qdev_get_machine(void)
 {
     static Object *dev;
 
+    if (!phase_check(PHASE_MACHINE_CREATED)) {
+        /*
+         * When the machine is not created, below can wrongly create
+         * /machine to be a container.. this enables qdev_get_machine() to
+         * be used at any time and return NULL properly when machine is not
+         * created.
+         */
+        return NULL;
+    }
+
     if (dev == NULL) {
         dev = container_get(object_get_root(), "/machine");
     }
===8<===

I hope it makes sense on its own. Then callers who can be invoked earlier
could then handle NULL properly, in this case..

===8<===
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 4bfeb08705..fceb7adfe0 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -80,9 +80,15 @@ void x86_iommu_irq_to_msi_message(X86IOMMUIrq *irq, MSIMessage *msg_out)
 
 X86IOMMUState *x86_iommu_get_default(void)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
-    PCMachineState *pcms =
-        PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
+    Object *machine = qdev_get_machine();
+    PCMachineState *pcms;
+
+    /* If machine has not been created, so is the vIOMMU */
+    if (!machine) {
+        return NULL;
+    }
+
+    pcms = PC_MACHINE(object_dynamic_cast(machine, TYPE_PC_MACHINE));
 
     if (pcms &&
         object_dynamic_cast(OBJECT(pcms->iommu), TYPE_X86_IOMMU_DEVICE)) {
===8<===

I'll make sure this works if I'll repost.

Thanks,

-- 
Peter Xu


