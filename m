Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DD17437CE
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:58:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF9xH-000285-WF; Fri, 30 Jun 2023 04:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qF9xD-00027Q-9z
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qF9xB-0008OK-A0
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688115484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jfPH+LwjZ/9LcomB7J5C36lR3ZpS1499ng2WD0IUbbU=;
 b=hvIeJ8nJ0WGyH8pVIQu2llYSCe4cBhZaI7DxM5njTMoJqVyKnwdC4BpyFqbX0Qjsr2fHiO
 qh0BO0+0BTch2GHkmbeLw5ptQU9fQQ1NXmozqRMqasqP+HgodEqB5LJonoxsYlMHaNheQd
 yd/jLYHKpSR0/gMxnXBpsAiVpe1zflM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-HyyWRI-LN1iYH_z_MQZ-bA-1; Fri, 30 Jun 2023 04:58:00 -0400
X-MC-Unique: HyyWRI-LN1iYH_z_MQZ-bA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7659cb9c3b3so164967085a.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 01:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688115480; x=1690707480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jfPH+LwjZ/9LcomB7J5C36lR3ZpS1499ng2WD0IUbbU=;
 b=ZdtrzHNpn1lws3nRpbd7TYiWjoZDUY1M0v8mA/MxrbrExOLAwvqXjIL9lyFQ1iRUhd
 O/9u/HMIl1IwUFqJxkK1Mnp1E397OU9rhchUNcMvmFIzNIuR8PJRPZ3w/dWO+Q6BmjHq
 0hy/BTlKizepC+CvNki7WyNqh7TdSAX8sVRtI1gMkTV5mKWQY2PCgG4uVJV40nLFprmd
 VU7sCMmvHI2fF7YT5eWxP7LWHYKrJ/B/+3/6jL6nXmwNFdfA1JCtmkHR2qPVOjDP1MUs
 0gEGVGeLFEupXtE+8C1THTtDq2Jcew9Q6h0cXZyEGAVrrQILUtdv2ajokvzpRHclK8BN
 0EWg==
X-Gm-Message-State: AC+VfDy8qzamjq3jCl5dRs34SndHDvBovxAIMvjR6+1KrMj8KWshzDhj
 dllET0JK710OFH6NJv6qNbojSmALWzqUGBI0z4qIWjWRWYFDz/FJpk/C88sw/evl54Yx9uWeGoA
 XUhPwkiseMwHfY6IAr7SZojVEVrUgG1c=
X-Received: by 2002:a05:620a:4727:b0:767:3771:f770 with SMTP id
 bs39-20020a05620a472700b007673771f770mr1901032qkb.40.1688115479974; 
 Fri, 30 Jun 2023 01:57:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6gqoIq8CFUQkqIrKVGJC5XI9y+I2vsqc12pUFSWGk2qAB410tOkt0iSBtFgdwDMjs1W89BusWOiK4OwxRZduU=
X-Received: by 2002:a05:620a:4727:b0:767:3771:f770 with SMTP id
 bs39-20020a05620a472700b007673771f770mr1901024qkb.40.1688115479747; Fri, 30
 Jun 2023 01:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
 <20230627160943.2956928-26-alex.bennee@linaro.org>
 <b08189c8-38c2-adbf-7bb3-0304f4845fc0@linaro.org>
In-Reply-To: <b08189c8-38c2-adbf-7bb3-0304f4845fc0@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 30 Jun 2023 10:57:48 +0200
Message-ID: <CABgObfa=pWNa17jKiLz3FnRk=qCyTsQ1jv1hk9ZoLZj0JV1Mng@mail.gmail.com>
Subject: Re: [PATCH v3 25/36] docs/devel: introduce some key concepts for QOM
 development
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Darren Kenny <darren.kenny@oracle.com>, 
 Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Laurent Vivier <laurent@vivier.eu>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm <qemu-arm@nongnu.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, Laurent Vivier <lvivier@redhat.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Riku Voipio <riku.voipio@iki.fi>
Content-Type: multipart/alternative; boundary="00000000000082b4c705ff5503fb"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--00000000000082b4c705ff5503fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 29 giu 2023, 15:41 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> > +The TYPE_DEVICE class is the parent class for all modern devices
> > +implemented in QEMU and adds some specific methods to handle QEMU
> > +device model. This includes managing the lifetime of devices from
> > +creation through to when they become visible to the guest and
> > +eventually unrealized.
>
> Good enough but we are mixing QOM vs QDev...
>

TYPE_DEVICE is mentioned here because it appears in the code (the part that
is not changing and thus is not included in the diff). It's not mixing QOM
with qdev.

Paolo

>   Alternatively several static types could be registered using helper
> macro
> >   DEFINE_TYPES()
>
>
> > +.. _device-life-cycle:
> > +
> > +Device Life-cycle
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +As class initialisation cannot fail devices have an two additional
> > +methods to handle the creation of dynamic devices. The ``realize``
> > +function is called with ``Error **`` pointer which should be set if
> > +the device cannot complete its setup. Otherwise on successful
> > +completion of the ``realize`` method the device object is added to the
> > +QOM tree and made visible to the guest.
> > +
> > +The reverse function is ``unrealize`` and should be were clean-up
> > +code lives to tidy up after the system is done with the device.
>
> Worth mentioning hotplug devices must implement it?
>
> > +All devices can be instantiated by C code, however only some can
> > +created dynamically via the command line or monitor.
> >
> > +Likewise only some can be unplugged after creation and need an
> > +explicit ``unrealize`` implementation.
>
> Ah, here we go.
>
> > This is determined by the
> > +``user_creatable`` variable in the root ``DeviceClass`` structure.
> > +Devices can only be unplugged if their ``parent_bus`` has a registered
> > +``HotplugHandler``.
>
> TODO on top, mentions the reset() handlers are called after realize(),
> and can be called multiple times.
>
> >   API Reference
> > --------------
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >   See the :ref:`QOM API<qom-api>` and :ref:`QDEV API<qdev-api>`
> >   documents for the complete API description.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>

--00000000000082b4c705ff5503fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 29 giu 2023, 15:41 Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; ha scrit=
to:</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
&gt; +The TYPE_DEVICE class is the parent class for all modern devices<br>
&gt; +implemented in QEMU and adds some specific methods to handle QEMU<br>
&gt; +device model. This includes managing the lifetime of devices from<br>
&gt; +creation through to when they become visible to the guest and<br>
&gt; +eventually unrealized.<br>
<br>
Good enough but we are mixing QOM vs QDev...<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">TYPE_DEVICE is mentioned here b=
ecause it appears in the code (the part that is not changing and thus is no=
t included in the diff). It&#39;s not mixing QOM with qdev.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
&gt;=C2=A0 =C2=A0Alternatively several static types could be registered usi=
ng helper macro<br>
&gt;=C2=A0 =C2=A0DEFINE_TYPES()<br>
<br>
<br>
&gt; +.. _device-life-cycle:<br>
&gt; +<br>
&gt; +Device Life-cycle<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; +<br>
&gt; +As class initialisation cannot fail devices have an two additional<br=
>
&gt; +methods to handle the creation of dynamic devices. The ``realize``<br=
>
&gt; +function is called with ``Error **`` pointer which should be set if<b=
r>
&gt; +the device cannot complete its setup. Otherwise on successful<br>
&gt; +completion of the ``realize`` method the device object is added to th=
e<br>
&gt; +QOM tree and made visible to the guest.<br>
&gt; +<br>
&gt; +The reverse function is ``unrealize`` and should be were clean-up<br>
&gt; +code lives to tidy up after the system is done with the device.<br>
<br>
Worth mentioning hotplug devices must implement it?<br>
<br>
&gt; +All devices can be instantiated by C code, however only some can<br>
&gt; +created dynamically via the command line or monitor.<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +Likewise only some can be unplugged after creation and need an<br>
&gt; +explicit ``unrealize`` implementation.<br>
<br>
Ah, here we go.<br>
<br>
&gt; This is determined by the<br>
&gt; +``user_creatable`` variable in the root ``DeviceClass`` structure.<br=
>
&gt; +Devices can only be unplugged if their ``parent_bus`` has a registere=
d<br>
&gt; +``HotplugHandler``.<br>
<br>
TODO on top, mentions the reset() handlers are called after realize(),<br>
and can be called multiple times.<br>
<br>
&gt;=C2=A0 =C2=A0API Reference<br>
&gt; --------------<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0See the :ref:`QOM API&lt;qom-api&gt;` and :ref:`QDEV API&l=
t;qdev-api&gt;`<br>
&gt;=C2=A0 =C2=A0documents for the complete API description.<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt;<br>
<br>
</blockquote></div></div></div>

--00000000000082b4c705ff5503fb--


