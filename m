Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9351C7A585F
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 06:24:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiSH7-0002LL-UE; Tue, 19 Sep 2023 00:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiSH5-0002L4-FI
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 00:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiSH3-0000xb-Qb
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 00:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695097424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvyQB98cflYgKfEhhjEFrNiYlzbUGK4ZImS30vG3Wzo=;
 b=CFpi1AEZI3Qmc98bys1CtBSksxN5Xryd3HZG5mAVEA3bIbvHd/JoTd54cs4Zin/zvn9FQv
 n8KNKh4YpUguj9ubts70uM0w/NgODw64QyQnXqiFzSvj1Yvo2jw59hg7pUJRYTefOeWbO1
 /9JPtywfZsLOiM3e870mlUSKJLIKgwE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-EdAx4ho7MQKgDt_SJIRXtQ-1; Tue, 19 Sep 2023 00:23:42 -0400
X-MC-Unique: EdAx4ho7MQKgDt_SJIRXtQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-53087cba7ecso2740687a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 21:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695097421; x=1695702221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gvyQB98cflYgKfEhhjEFrNiYlzbUGK4ZImS30vG3Wzo=;
 b=cpvD6eHWVF26tWPZ5xNY1mysbNMoyqYxbVxz6nABuKAXLkCD04JWF4RUqQZ/JvwrPQ
 sLKlD9BEH2QQIJWmaDRwTT92bKE4EDwU9lp4L+R3uzd3ku2syh01WEMLWqNDSHSrhTnR
 2rF9JatVg8keKXJqfSU+taXgVhtYYccgNurMpdK8nEzcZnHniCbafD/2reX7uHhgPQ4T
 xO8wMWti6139pAL4FcEdidEYdi/vDNhzPyNhQg4zCN3ehhrBeIb0H5qS9N+4oG2u0mWV
 ZWDdvKlENXWDQOmeMVxi0uBFC6i7cPA6Mc+Dt9TVNrjNr+vNBt2DAzqhAqZIFxPc9yAv
 Z8fA==
X-Gm-Message-State: AOJu0YyNNV7jLtOK4OPsMmv4d9FZ28VNvtlQooYv2X9+t/AfQI6eBeK2
 DAr8c2AOCO6etcC01UPC5xCGDIexHUoRMJZBL4kIutm/SQKDBhEJslDev3FOB8C465BDAy43ac+
 QJK6yUv5W3ExEgiK9Pizey0Zf/AjrVE4=
X-Received: by 2002:a17:906:3149:b0:9a1:e011:1a62 with SMTP id
 e9-20020a170906314900b009a1e0111a62mr9586797eje.38.1695097421055; 
 Mon, 18 Sep 2023 21:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgzp2gL7AUX19lNOrYuqwca4f0KXhoURSW2B3TWVTIafuSJfSlr6qURVv7d18hGAaj4k4xMcewo5jfOyu9WM8=
X-Received: by 2002:a17:906:3149:b0:9a1:e011:1a62 with SMTP id
 e9-20020a170906314900b009a1e0111a62mr9586788eje.38.1695097420755; Mon, 18 Sep
 2023 21:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230918135448.90963-1-anisinha@redhat.com>
 <CAK3XEhOMqdfyPBm0ZgkirrcaBhOwQt_eOZ7=bbdW8OJpz3hWHg@mail.gmail.com>
 <ceea0d9d-19d6-29e7-cb84-81f85936b8c2@redhat.com>
 <CAK3XEhNETZBGtzpv2vBzygQtYuzTrsihzQNRdK8kp3+_u590Rg@mail.gmail.com>
 <3a3b5c4a-afad-8362-088c-a531d6998c23@redhat.com>
 <CAK3XEhPYPaJfeK5hcq+EktSn9iFVrv05H=TJ4VJNARddK1jYOA@mail.gmail.com>
In-Reply-To: <CAK3XEhPYPaJfeK5hcq+EktSn9iFVrv05H=TJ4VJNARddK1jYOA@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 19 Sep 2023 09:53:28 +0530
Message-ID: <CAK3XEhP5dyn5bORreJSt7U_QANh2oWG2Tn9UKttbAxEKTSmEfg@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/pc: fix max_used_gpa for 32-bit systems
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, philmd@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 19, 2023 at 9:20=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wro=
te:
>
> On Mon, Sep 18, 2023 at 9:28=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 18.09.23 17:56, Ani Sinha wrote:
> > > On Mon, Sep 18, 2023 at 8:59=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> > >>
> > >> On 18.09.23 17:22, Ani Sinha wrote:
> > >>> On Mon, Sep 18, 2023 at 7:25=E2=80=AFPM Ani Sinha <anisinha@redhat.=
com> wrote:
> > >>>>
> > >>>> 32-bit systems do not have a reserved memory for hole64 but they m=
ay have a
> > >>>> reserved memory space for memory hotplug. Since, hole64 starts aft=
er the
> > >>>> reserved hotplug memory, the unaligned hole64 start address gives =
us the
> > >>>> end address for this memory hotplug region that the processor may =
use.
> > >>>> Fix this. This ensures that the physical address space bound check=
ing works
> > >>>> correctly for 32-bit systems as well.
> > >>>
> > >>> This patch breaks some unit tests. I am not sure why it did not cat=
ch
> > >>> it when I tested it before sending.
> > >>> Will have to resend after fixing the tests.
> > >>
> > >> Probably because they supply more memory than the system can actuall=
y
> > >> handle? (e.g., -m 4g on 32bit)?
> > >
> > > cxl tests are failing for example.
> > >
> > > $ ./qemu-system-i386 -display none -machine q35,cxl=3Don
> > > qemu-system-i386: Address space limit 0xffffffff < 0x1000fffff
> > > phys-bits too low (32)
>
> also another thing is:
>
> ./qemu-system-i386 -machine pc -m 128
> works but ...
>
> $ ./qemu-system-i386 -machine pc -m 128,slots=3D3,maxmem=3D1G
> qemu-system-i386: Address space limit 0xffffffff < 0x1f7ffffff
> phys-bits too low (32)
>
> or
>
> $ ./qemu-system-i386 -machine pc-i440fx-8.2 -accel kvm -m 128,slots=3D3,m=
axmem=3D1G
> qemu-system-i386: Address space limit 0xffffffff < 0x1f7ffffff
> phys-bits too low (32)
>
> but of course after the compat knob older pc machines work fine using
> the old logic :
>
> $ ./qemu-system-i386 -machine pc-i440fx-8.1 -accel kvm -m 128,slots=3D3,m=
axmem=3D1G
> VNC server running on ::1:5900
> ^Cqemu-system-i386: terminating on signal 2

I dpn't know if we always need to do this but this code adds 1 GiB per
slot for device memory :

    if (pcmc->enforce_aligned_dimm) {
         /* size device region assuming 1G page max alignment per slot */
         size +=3D (1 * GiB) * machine->ram_slots;
     }

For a 32-bit machine that is a lot of memory consumed in just alignment.


