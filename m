Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD28C7CC011
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 12:00:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsgsD-00033N-7v; Tue, 17 Oct 2023 06:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qsgs2-00032k-TP
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 06:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qsgs0-0006kV-TT
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 06:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697536810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NfBqHM1UtMsqkaoXmz1SIR6BPvvxfg8sosizmQsczCI=;
 b=TfiuguBxktVvTuZ+vdjDTO54bgkfr8AUZCJMA2ulcJtpOFr5rt3AZfYFvbOxK9tZSz7Cty
 hZN1ZPorrf5rqmUmaHmWEodxwji6VD5VgWMdtB6BG0FBdPhLCQZ6yAoST+hCKzE7ZcjZsP
 14rZ1DT9owOachyiZbFE1nKclWObA4A=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-h51NiTZMOzyht9vXZXzicw-1; Tue, 17 Oct 2023 05:59:59 -0400
X-MC-Unique: h51NiTZMOzyht9vXZXzicw-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1ca28f36249so30393985ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 02:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697536798; x=1698141598;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NfBqHM1UtMsqkaoXmz1SIR6BPvvxfg8sosizmQsczCI=;
 b=eQk1kH1V2FMY/DHJace8mDRK0JElHav98d+g9DWHBXiSbR86MOA+FehICUU2QUw5Os
 8gwWbsw8qFcvMssqWeUD1ACYm7EVC87iWAXFJ2Q2cekii8vwl2QU42Z3UOAEx79Nft9t
 //RR6SIKQLByQL/V5r2QTSddkt7cc6GS9wVI2tP0Co3RRwbayQRBvlcQ7g8CSPcK9wd1
 J9HU5HDKJoEK9jNEMaSI21qbGbpZqw7+ECK4GSyD7TWggdBOvf8j2glpIl8hQcgQzxdu
 JPTjLm2IELH1tBebbms8eAZxvmWUm0vivE7vcL2kyaomqctqsl3h++RzIWbH0IcPbGW/
 XQzQ==
X-Gm-Message-State: AOJu0YxV/CIsfdXW7xOf/a3F1JZBYwWQPI10ZgmZOwnNUnxMWUus0h0K
 +btA80LQjlL9M4yB+hX4DK+TZKDZuViHt7eOMU2bNyya6Ns9NxNyPkKKBGIF6IMEKRNkRVtDQRm
 1Z5K41kLiasdr/z6ihtOo5CDp6cHKR1c=
X-Received: by 2002:a17:903:2282:b0:1c0:9b7c:f82a with SMTP id
 b2-20020a170903228200b001c09b7cf82amr1944810plh.53.1697536798123; 
 Tue, 17 Oct 2023 02:59:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWAYDGETIQNIyuG3oeusvQsLkls0jDYmtBn/XV4lUVploScZUYY0LNwFf16eFkOdEXvXdoDTIdvKLBX1W+jKg=
X-Received: by 2002:a17:903:2282:b0:1c0:9b7c:f82a with SMTP id
 b2-20020a170903228200b001c09b7cf82amr1944794plh.53.1697536797867; Tue, 17 Oct
 2023 02:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <c61c13f9a0c67dec473bdbfc8789c29ef26c900b.1696624734.git.quic_mathbern@quicinc.com>
In-Reply-To: <c61c13f9a0c67dec473bdbfc8789c29ef26c900b.1696624734.git.quic_mathbern@quicinc.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 17 Oct 2023 11:59:46 +0200
Message-ID: <CADSE00LrnobNt5tUbk_c8t421EgedZGPamW+SxX4cAH=VUuQfQ@mail.gmail.com>
Subject: Re: [PATCH] hw/display: fix memleak from virtio_add_resource
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000d49cf20607e695ea"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
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

--000000000000d49cf20607e695ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 6, 2023 at 10:41=E2=80=AFPM Matheus Tavares Bernardino <
quic_mathbern@quicinc.com> wrote:

> When the given uuid is already present in the hash table,
> virtio_add_resource() does not add the passed VirtioSharedObject. In
> this case, free it in the callers to avoid leaking memory. This fixed
> the following `make check` error, when built with --enable-sanitizers:
>
>   4/166 qemu:unit / test-virtio-dmabuf   ERROR 1.51s   exit status 1
>
>   =3D=3D7716=3D=3DERROR: LeakSanitizer: detected memory leaks
>   Direct leak of 320 byte(s) in 20 object(s) allocated from:
>       #0 0x7f6fc16e3808 in __interceptor_malloc
> ../../../../src/libsanitizer/asan/asan_malloc_linux.cc:144
>       #1 0x7f6fc1503e98 in g_malloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x57e98)
>       #2 0x564d63cafb6b in test_add_invalid_resource
> ../tests/unit/test-virtio-dmabuf.c:100
>       #3 0x7f6fc152659d  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x7a59d)
>   SUMMARY: AddressSanitizer: 320 byte(s) leaked in 20 allocation(s).
>
> The changes at virtio_add_resource() itself are not strictly necessary
> for the memleak fix, but they make it more obvious that, on an error
> return, the passed object is not added to the hash.
>
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
>  hw/display/virtio-dmabuf.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> index 4a8e430f3d..3dba4577ca 100644
> --- a/hw/display/virtio-dmabuf.c
> +++ b/hw/display/virtio-dmabuf.c
> @@ -29,7 +29,7 @@ static int uuid_equal_func(const void *lhv, const void
> *rhv)
>
>  static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *valu=
e)
>  {
> -    bool result =3D false;
> +    bool result =3D true;
>
>      g_mutex_lock(&lock);
>      if (resource_uuids =3D=3D NULL) {
> @@ -39,7 +39,9 @@ static bool virtio_add_resource(QemuUUID *uuid,
> VirtioSharedObject *value)
>                                                 g_free);
>      }
>      if (g_hash_table_lookup(resource_uuids, uuid) =3D=3D NULL) {
> -        result =3D g_hash_table_insert(resource_uuids, uuid, value);
> +        g_hash_table_insert(resource_uuids, uuid, value);
> +    } else {
> +        result =3D false;
>      }
>      g_mutex_unlock(&lock);
>
> @@ -57,6 +59,9 @@ bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
>      vso->type =3D TYPE_DMABUF;
>      vso->value =3D GINT_TO_POINTER(udmabuf_fd);
>      result =3D virtio_add_resource(uuid, vso);
> +    if (!result) {
> +        g_free(vso);
> +    }
>
>      return result;
>  }
> @@ -72,6 +77,9 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct
> vhost_dev *dev)
>      vso->type =3D TYPE_VHOST_DEV;
>      vso->value =3D dev;
>      result =3D virtio_add_resource(uuid, vso);
> +    if (!result) {
> +        g_free(vso);
> +    }
>
>      return result;
>  }
> --
> 2.37.2
>
>
Thanks!

Reviewed-by: Albert Esteve <aesteve@redhat.com>

--000000000000d49cf20607e695ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div></div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 6, 2023 at 10:41=
=E2=80=AFPM Matheus Tavares Bernardino &lt;<a href=3D"mailto:quic_mathbern@=
quicinc.com" target=3D"_blank">quic_mathbern@quicinc.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">When the given uuid=
 is already present in the hash table,<br>
virtio_add_resource() does not add the passed VirtioSharedObject. In<br>
this case, free it in the callers to avoid leaking memory. This fixed<br>
the following `make check` error, when built with --enable-sanitizers:<br>
<br>
=C2=A0 4/166 qemu:unit / test-virtio-dmabuf=C2=A0 =C2=A0ERROR 1.51s=C2=A0 =
=C2=A0exit status 1<br>
<br>
=C2=A0 =3D=3D7716=3D=3DERROR: LeakSanitizer: detected memory leaks<br>
=C2=A0 Direct leak of 320 byte(s) in 20 object(s) allocated from:<br>
=C2=A0 =C2=A0 =C2=A0 #0 0x7f6fc16e3808 in __interceptor_malloc ../../../../=
src/libsanitizer/asan/asan_malloc_linux.cc:144<br>
=C2=A0 =C2=A0 =C2=A0 #1 0x7f6fc1503e98 in g_malloc (/lib/x86_64-linux-gnu/l=
ibglib-2.0.so.0+0x57e98)<br>
=C2=A0 =C2=A0 =C2=A0 #2 0x564d63cafb6b in test_add_invalid_resource ../test=
s/unit/test-virtio-dmabuf.c:100<br>
=C2=A0 =C2=A0 =C2=A0 #3 0x7f6fc152659d=C2=A0 (/lib/x86_64-linux-gnu/libglib=
-2.0.so.0+0x7a59d)<br>
=C2=A0 SUMMARY: AddressSanitizer: 320 byte(s) leaked in 20 allocation(s).<b=
r>
<br>
The changes at virtio_add_resource() itself are not strictly necessary<br>
for the memleak fix, but they make it more obvious that, on an error<br>
return, the passed object is not added to the hash.<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:quic_mathbe=
rn@quicinc.com" target=3D"_blank">quic_mathbern@quicinc.com</a>&gt;<br>
---<br>
=C2=A0hw/display/virtio-dmabuf.c | 12 ++++++++++--<br>
=C2=A01 file changed, 10 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c<br>
index 4a8e430f3d..3dba4577ca 100644<br>
--- a/hw/display/virtio-dmabuf.c<br>
+++ b/hw/display/virtio-dmabuf.c<br>
@@ -29,7 +29,7 @@ static int uuid_equal_func(const void *lhv, const void *r=
hv)<br>
<br>
=C2=A0static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *v=
alue)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 bool result =3D false;<br>
+=C2=A0 =C2=A0 bool result =3D true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_mutex_lock(&amp;lock);<br>
=C2=A0 =C2=A0 =C2=A0if (resource_uuids =3D=3D NULL) {<br>
@@ -39,7 +39,9 @@ static bool virtio_add_resource(QemuUUID *uuid, VirtioSha=
redObject *value)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 g_free);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (g_hash_table_lookup(resource_uuids, uuid) =3D=3D NU=
LL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_hash_table_insert(resource_uuids,=
 uuid, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_hash_table_insert(resource_uuids, uuid, valu=
e);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0g_mutex_unlock(&amp;lock);<br>
<br>
@@ -57,6 +59,9 @@ bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)<br=
>
=C2=A0 =C2=A0 =C2=A0vso-&gt;type =3D TYPE_DMABUF;<br>
=C2=A0 =C2=A0 =C2=A0vso-&gt;value =3D GINT_TO_POINTER(udmabuf_fd);<br>
=C2=A0 =C2=A0 =C2=A0result =3D virtio_add_resource(uuid, vso);<br>
+=C2=A0 =C2=A0 if (!result) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(vso);<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0return result;<br>
=C2=A0}<br>
@@ -72,6 +77,9 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost=
_dev *dev)<br>
=C2=A0 =C2=A0 =C2=A0vso-&gt;type =3D TYPE_VHOST_DEV;<br>
=C2=A0 =C2=A0 =C2=A0vso-&gt;value =3D dev;<br>
=C2=A0 =C2=A0 =C2=A0result =3D virtio_add_resource(uuid, vso);<br>
+=C2=A0 =C2=A0 if (!result) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(vso);<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0return result;<br>
=C2=A0}<br>
-- <br>
2.37.2<br>
<br></blockquote><div><br></div><div>Thanks!</div><div><br></div><div>Revie=
wed-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com">aesteve@red=
hat.com</a>&gt;=C2=A0</div></div>
</div>

--000000000000d49cf20607e695ea--


