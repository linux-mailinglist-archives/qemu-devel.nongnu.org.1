Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5427A9353
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 11:54:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjGN5-00088Y-FU; Thu, 21 Sep 2023 05:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qjGN2-00088J-1p
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qjGN0-0000BI-DQ
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695289993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G5+2UU5LrQ45N8KWKO6Q1ugzccgGM6aDNb3v1U5pJII=;
 b=AsKEvhNRNXcr0oH4FPWtFUIj/pOUS7FnnN1zoqt1UzmQAfZlC4jEKuP4vYx2dd8fkEFcF1
 GAW/CCz1lc+q/BuZo4cR2o5yt98oHMBR5CrB37TPrOg15TtWQUPTlp+vud4xD/keDz1NPK
 tY0ddfgULBIykw5J/3dMY8EgQTJBR5I=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-ehzkyGoRMRi5HDXDRam0OQ-1; Thu, 21 Sep 2023 05:53:11 -0400
X-MC-Unique: ehzkyGoRMRi5HDXDRam0OQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5041ea5abb6so1037049e87.2
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 02:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695289990; x=1695894790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G5+2UU5LrQ45N8KWKO6Q1ugzccgGM6aDNb3v1U5pJII=;
 b=JDR2HXVGULixz2tjkoB4Uxov5YFj0Cqvoazxydl2LwFVJ4IGURFZM1R2u6gXFNXJts
 t0EYu1lBnP+tt/udyCDGriooculNqXsaXlpiR/H/1vM1LuqPY646mKlNWBNkntSk16XL
 jmLVd/OA8hMvpxZ5RlNltHro7GgDJFefbX+0Z7ffM8i8vJpy+ClpVLbsedQVwJQOZnRF
 k6uG00VMSF99vR8Dpd/M9Hgf1SIp3uh6bNdZzIjFHepliMe3oFOsRQiUvDPBhYxeN3J/
 F67n4lgLpz5+dh2Wv0a9D7HNw9TUt0OqGRXe14FBS5OtgslPv1Bh7nELomuCUIyDKTd6
 tuJA==
X-Gm-Message-State: AOJu0YwX6BgdbbmjNCLP60u6BlrrF/4aY7wr3386H6zxLXTU5tgnm2v6
 uz1OOTgrgxVFJLUOCNZdCQzC83b5cR/S+JgrWQjKEoxzkqRtkJs9p4ol9Zlbr5eWuXglV3yofJm
 erkU/5EGsfmj23kmGDF4w/dKl8tZJ9ik=
X-Received: by 2002:a19:9147:0:b0:503:26bd:7f58 with SMTP id
 y7-20020a199147000000b0050326bd7f58mr4254810lfj.41.1695289990130; 
 Thu, 21 Sep 2023 02:53:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/BwAJULIMzosaENVD8DyM1KyL3tNIiH5eh4BemTphdHqlGr84zmfzV9YrGChWy8biFBxQP5K2IbidUp/dTVE=
X-Received: by 2002:a19:9147:0:b0:503:26bd:7f58 with SMTP id
 y7-20020a199147000000b0050326bd7f58mr4254800lfj.41.1695289989825; Thu, 21 Sep
 2023 02:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221110100629.61496-1-akihiko.odaki@daynix.com>
 <20221110100629.61496-2-akihiko.odaki@daynix.com>
 <CAPMcbCrGkXzeZex_veDYV8HSMMzH8d=zy1jkf21t4qFekGmDpg@mail.gmail.com>
 <f3895076-5ccc-4542-8cc5-635a99cff182@daynix.com>
In-Reply-To: <f3895076-5ccc-4542-8cc5-635a99cff182@daynix.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 21 Sep 2023 12:52:58 +0300
Message-ID: <CAPMcbCpwJb+uE0U_d+NYScVest1QGB3extUZ9xM10YeGM0-tVQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] qga: Remove platform GUID definitions
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Yan Vugenfirer <yan@daynix.com>
Content-Type: multipart/alternative; boundary="000000000000a29d5b0605db7524"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000a29d5b0605db7524
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Akihiko,

Thanks for ping.
I will merge this commit with other qga fixes.

Best Regards,
Konstantin Kostiuk.


On Thu, Sep 21, 2023 at 10:58=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com>
wrote:

> On 2022/11/17 18:45, Konstantin Kostiuk wrote:
> > Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com
> > <mailto:kkostiuk@redhat.com>>
> >
> > Will merge this patch in QGA series
> >
> > On Thu, Nov 10, 2022 at 12:06 PM Akihiko Odaki <akihiko.odaki@daynix.co=
m
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     GUID_DEVINTERFACE_DISK and GUID_DEVINTERFACE_STORAGEPORT are alread=
y
> >     defined by MinGW-w64. They are not only unnecessary, but can lead t=
o
> >     duplicate definition errors at link time with some unknown conditio=
n.
> >
> >     Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>
> >     ---
> >       qga/commands-win32.c | 7 -------
> >       1 file changed, 7 deletions(-)
> >
> >     diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> >     index ec9f55b453..dde5d401bb 100644
> >     --- a/qga/commands-win32.c
> >     +++ b/qga/commands-win32.c
> >     @@ -506,13 +506,6 @@ static GuestDiskBusType
> >     find_bus_type(STORAGE_BUS_TYPE bus)
> >           return win2qemu[(int)bus];
> >       }
> >
> >     -DEFINE_GUID(GUID_DEVINTERFACE_DISK,
> >     -        0x53f56307L, 0xb6bf, 0x11d0, 0x94, 0xf2,
> >     -        0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
> >     -DEFINE_GUID(GUID_DEVINTERFACE_STORAGEPORT,
> >     -        0x2accfe60L, 0xc130, 0x11d2, 0xb0, 0x82,
> >     -        0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
> >     -
> >       static void get_pci_address_for_device(GuestPCIAddress *pci,
> >                                              HDEVINFO dev_info)
> >       {
> >     --
> >     2.38.1
> >
>
> Hi Konstantin,
>
> This patch seems missed since then. Can you merge it?
>
> Regards,
> Akihiko Odaki
>
>

--000000000000a29d5b0605db7524
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Akihiko,</div><div><br></div><div>Thanks for ping.=
 <br></div><div>I will merge this commit with other qga fixes.<br></div><di=
v><br></div><div><div><div><div dir=3D"ltr" class=3D"gmail_signature" data-=
smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div><div=
>Konstantin Kostiuk.</div></div></div></div><br></div></div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 21,=
 2023 at 10:58=E2=80=AFAM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki=
@daynix.com">akihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On 2022/11/17 18:45, Konstantin Kostiu=
k wrote:<br>
&gt; Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.=
com" target=3D"_blank">kkostiuk@redhat.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kk=
ostiuk@redhat.com</a>&gt;&gt;<br>
&gt; <br>
&gt; Will merge this patch in QGA series<br>
&gt; <br>
&gt; On Thu, Nov 10, 2022 at 12:06 PM Akihiko Odaki &lt;<a href=3D"mailto:a=
kihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a> <br=
>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blan=
k">akihiko.odaki@daynix.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0GUID_DEVINTERFACE_DISK and GUID_DEVINTERFACE_STORAG=
EPORT are already<br>
&gt;=C2=A0 =C2=A0 =C2=A0defined by MinGW-w64. They are not only unnecessary=
, but can lead to<br>
&gt;=C2=A0 =C2=A0 =C2=A0duplicate definition errors at link time with some =
unknown condition.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:=
akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a><br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qga/commands-win32.c | 7 -------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A01 file changed, 7 deletions(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/qga/commands-win32.c b/qga/commands-wi=
n32.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index ec9f55b453..dde5d401bb 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/qga/commands-win32.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/qga/commands-win32.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -506,13 +506,6 @@ static GuestDiskBusType<br>
&gt;=C2=A0 =C2=A0 =C2=A0find_bus_type(STORAGE_BUS_TYPE bus)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return win2qemu[(int)bus];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-DEFINE_GUID(GUID_DEVINTERFACE_DISK,<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x53f56307L, 0xb6bf, 0=
x11d0, 0x94, 0xf2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, 0xa0, 0xc9, 0x1e=
, 0xfb, 0x8b);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-DEFINE_GUID(GUID_DEVINTERFACE_STORAGEPORT,<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x2accfe60L, 0xc130, 0=
x11d2, 0xb0, 0x82,<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, 0xa0, 0xc9, 0x1e=
, 0xfb, 0x8b);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0static void get_pci_address_for_device(Guest=
PCIAddress *pci,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 HDEVINFO dev_info)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.38.1<br>
&gt; <br>
<br>
Hi Konstantin,<br>
<br>
This patch seems missed since then. Can you merge it?<br>
<br>
Regards,<br>
Akihiko Odaki<br>
<br>
</blockquote></div>

--000000000000a29d5b0605db7524--


