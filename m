Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 155F37DC64B
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 07:12:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxhxc-00026w-3F; Tue, 31 Oct 2023 02:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qxhxa-00026l-Dh
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 02:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qxhxX-0001LB-DA
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 02:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698732637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/MB7dRT/6ac4dI1QwmgLsJB1CwM66dzPMSZl4+Qaq70=;
 b=EZ/eJoSQln2e0zsgZ86kgEHHGwOUbkl4xdap/XIqSvz7lIDdbtF9rdGXaqf6vpHyhB8kki
 8KdsdlR0/MVIwtGHNqKJj1lvSE8qQ6d17+cs4E5hKlvLAspPW4laDXlpZ6H7zNzMxfKlLH
 5/fvv4JgFZlgzDUPA477tgXSJ+mMTBw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-Urzg7YjVNLSVBPV5ffnTmg-1; Tue, 31 Oct 2023 02:10:25 -0400
X-MC-Unique: Urzg7YjVNLSVBPV5ffnTmg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-54061ad6600so4062269a12.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 23:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698732624; x=1699337424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/MB7dRT/6ac4dI1QwmgLsJB1CwM66dzPMSZl4+Qaq70=;
 b=gmTsqozyZ05E31iqjg+8IxLKC4budvfII+MkEcAUxIArOsuYnbJEQkJ6c+YCSm5RmS
 MQjfT7+8F2FIiRcnTD8aRdHQpN82oizRJJRJMPccz1+QAKu1KYd30N6PesVTQiZdnLRy
 7P3udqbn27G4mIgo+G6nfeiXmu9MbHRwhVh0cOGxV1CmkTl6dsfaAEMvH0CGTGzZDHsU
 1QNQtougg0D2Zkrwg5vK4lyllRcB+OjY9VQ403Xgoven2jKkt96LGYDdnwp5HMp3enop
 eGkpOKZRZO7PjcBTL9Wyz8HMSG8FSl6rhBcRIy+9G9tNWne1Dla5M56YvQiDVfZ55quu
 BCMA==
X-Gm-Message-State: AOJu0YyNI4S57R1kr9h9iQ18LsKLAGZGvAIwmsLiwIndp+4R+jlb6Cvw
 6eG+Zndip6h8ADX7YGHkgL7ELSENDZaQkGoIXcakBOktgSsyqymW9d4bcmz0kOrXd6l2xI0u+4g
 0KNTDZALKVXAKbdz4PDZwRnd+b3iarAg=
X-Received: by 2002:a05:6402:b2f:b0:531:2b0b:9b8 with SMTP id
 bo15-20020a0564020b2f00b005312b0b09b8mr9026073edb.7.1698732624415; 
 Mon, 30 Oct 2023 23:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc9pHMpKVjTWgegHS1f+yzyCBQvFpd0cJiZ11DcEsMWWvgwc8I72k1BlBnxK/rpy+txzEbofKONopbUe/0SQ0=
X-Received: by 2002:a05:6402:b2f:b0:531:2b0b:9b8 with SMTP id
 bo15-20020a0564020b2f00b005312b0b09b8mr9026056edb.7.1698732624115; Mon, 30
 Oct 2023 23:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231006010835.444-7-gurchetansingh@chromium.org>
 <20231031012515.15504-1-liucong2@kylinos.cn>
In-Reply-To: <20231031012515.15504-1-liucong2@kylinos.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Oct 2023 10:10:11 +0400
Message-ID: <CAMxuvaxvUeOp=N8BveYFCny2vUDN8eTS_2mq+qugs-RHkM_6TQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu-rutabaga: Add empty interface to fix arm64
 crash
To: Cong Liu <liucong2@kylinos.cn>
Cc: gurchetansingh@chromium.org, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, akihiko.odaki@gmail.com,
 alex.bennee@linaro.org, 
 ernunes@redhat.com, hi@alyssa.is, manos.pitsidianakis@linaro.org, 
 mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, ray.huang@amd.com, 
 shentey@gmail.com, thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 31, 2023 at 5:31=E2=80=AFAM Cong Liu <liucong2@kylinos.cn> wrot=
e:
>
> Add an empty element to the interfaces array, which is consistent with
> the behavior of other devices in qemu and fixes the crash on arm64.
>
> 0  0x0000fffff5c18550 in  () at /usr/lib64/libc.so.6
> 1  0x0000fffff6c9cd6c in g_strdup () at /usr/lib64/libglib-2.0.so.0
> 2  0x0000aaaaab4945d8 in g_strdup_inline (str=3D<optimized out>) at /usr/=
include/glib-2.0/glib/gstrfuncs.h:321
> 3  type_new (info=3Dinfo@entry=3D0xaaaaabc1b2c8 <virtio_gpu_rutabaga_pci_=
info>) at ../qom/object.c:133
> 4  0x0000aaaaab494f14 in type_register_internal (info=3D0xaaaaabc1b2c8 <v=
irtio_gpu_rutabaga_pci_info>) at ../qom/object.c:143
> 5  type_register (info=3D0xaaaaabc1b2c8 <virtio_gpu_rutabaga_pci_info>) a=
t ../qom/object.c:152
> 6  type_register_static (info=3D0xaaaaabc1b2c8 <virtio_gpu_rutabaga_pci_i=
nfo>) at ../qom/object.c:157
> 7  type_register_static_array (infos=3D<optimized out>, nr_infos=3D<optim=
ized out>) at ../qom/object.c:165
> 8  0x0000aaaaab6147e8 in module_call_init (type=3Dtype@entry=3DMODULE_INI=
T_QOM) at ../util/module.c:109
> 9  0x0000aaaaab10a0ec in qemu_init_subsystems () at ../system/runstate.c:=
817
> 10 0x0000aaaaab10d334 in qemu_init (argc=3D13, argv=3D0xfffffffff198) at =
../system/vl.c:2760
> 11 0x0000aaaaaae4da6c in main (argc=3D<optimized out>, argv=3D<optimized =
out>) at ../system/main.c:47
>
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/virtio-gpu-pci-rutabaga.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/display/virtio-gpu-pci-rutabaga.c b/hw/display/virtio-gpu=
-pci-rutabaga.c
> index c96729e19834..abbb898c65dc 100644
> --- a/hw/display/virtio-gpu-pci-rutabaga.c
> +++ b/hw/display/virtio-gpu-pci-rutabaga.c
> @@ -36,6 +36,7 @@ static const TypeInfo virtio_gpu_rutabaga_pci_info[] =
=3D {
>          .instance_init =3D virtio_gpu_rutabaga_initfn,
>          .interfaces =3D (InterfaceInfo[]) {
>              { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +            { },
>          }
>      },
>  };
> --
> 2.34.1
>


