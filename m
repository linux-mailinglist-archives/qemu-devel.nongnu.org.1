Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE00D810DB6
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 10:53:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDLux-00028S-7p; Wed, 13 Dec 2023 04:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rDLuv-00028J-Rz
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 04:52:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rDLuu-0003fL-69
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 04:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702461154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hfMgkCeCjKv0eBkWl1QtT2Tk9nkU1jlaWkk6MEcr5Bc=;
 b=VRH2g8urSITHqhjps+n5nn6WdBXnfI3stqR8+6pfnuLSE92LlSdDcKiCf7cs1DcB9HPAJj
 SsISHccBNZGOh3xYW2SieE2aSN3rlqmrC550eYTA/MT7HtYwQfMqEPVTWls0DB7CuG61IY
 NHuqD/+6fdej9GSJcoKWblkY49SEU70=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-w5cOBx9IOBqtDtvShu8MQg-1; Wed, 13 Dec 2023 04:52:32 -0500
X-MC-Unique: w5cOBx9IOBqtDtvShu8MQg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5e27479b6e2so11315887b3.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 01:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702461152; x=1703065952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfMgkCeCjKv0eBkWl1QtT2Tk9nkU1jlaWkk6MEcr5Bc=;
 b=mh2ka1aKJxAQDhKDhAVb2Lwfs+PnLzXSS2XqiCezh1ECw8dQU+riSdUn0eShJVPXrU
 BjEnatnx4o+2zN0XeMMxlLr4bLn5EBUAICHXK6WQ8wPpIF38OuH+9jQRz8mu74c05DBf
 UEQPCu6VNJbdJ2u2SX+Eav2uQgD3f/IwjhUMp3mvIhwyrA25Lyv/0J7JbEH55fcr4NHz
 IW/PqtJB9Auny2qj5Cz52+P9eITEwBYTKEWWeNeqRGxg3jtc1MUOyF3/X+lHOSvpMoAC
 RZr+vOHbP8gloBw56EdPfViyRGnxw8PMxqu0DKmNl5VZL4eEcKBOOJ+f384RvBiiGf9/
 gxUA==
X-Gm-Message-State: AOJu0YwsZ9s9uugr7w4Ml7mS8hVac/+swFeU0Qa04S45xtDOL46khmQz
 gNS0LkN6uG8ipL4yVXtBv02C7lfe/UFNqzkp8IrpG/ylNjA+iz+8xXdePg4LMdxfwkmbRK2rfIn
 Se0/wWYCT7g5V5AKczIe5FkV+ZjGpaPc=
X-Received: by 2002:a25:dad5:0:b0:dbc:cad1:8706 with SMTP id
 n204-20020a25dad5000000b00dbccad18706mr663472ybf.28.1702461152259; 
 Wed, 13 Dec 2023 01:52:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQy+44UHnte9s+uIJYBB+ETZN+C4pC9hQkcGIl2KzSWVHeGEmdpyOmHK7WON3BssL895KKcnlhjv27fnzM0+g=
X-Received: by 2002:a25:dad5:0:b0:dbc:cad1:8706 with SMTP id
 n204-20020a25dad5000000b00dbccad18706mr663465ybf.28.1702461151981; Wed, 13
 Dec 2023 01:52:31 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-18-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-18-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Dec 2023 10:51:56 +0100
Message-ID: <CAJaqyWdXYP609879RYo5qA8JNrwFM4H2xT9N7AF_JwQifq5XZA@mail.gmail.com>
Subject: Re: [PATCH 17/40] vdpa: judge if map can be kept across reset
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Dec 7, 2023 at 7:50=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> The descriptor group for SVQ ASID allows the guest memory mapping
> to retain across SVQ switching, same as how isolated CVQ can do
> with a different ASID than the guest GPA space. Introduce an
> evaluation function to judge whether to flush or keep iotlb maps
> based on virtqueue's descriptor group and cvq isolation capability.
>
> Have to hook the evaluation function to NetClient's .poll op as
> .vhost_reset_status runs ahead of .stop, and .vhost_dev_start
> don't have access to the vhost-vdpa net's information.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  net/vhost-vdpa.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 04718b2..e9b96ed 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -504,12 +504,36 @@ static int vhost_vdpa_net_load_cleanup(NetClientSta=
te *nc, NICState *nic)
>                               n->parent_obj.status & VIRTIO_CONFIG_S_DRIV=
ER_OK);
>  }
>
> +static void vhost_vdpa_net_data_eval_flush(NetClientState *nc, bool stop=
)
> +{
> +    VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> +    struct vhost_vdpa *v =3D &s->vhost_vdpa;
> +
> +    if (!stop) {
> +        return;
> +    }
> +
> +    if (s->vhost_vdpa.index =3D=3D 0) {
> +        if (s->always_svq) {
> +            v->shared->flush_map =3D true;

Why do we need to reset the map in the case of always_svq?

> +        } else if (!v->shared->svq_switching || v->desc_group >=3D 0) {
> +            v->shared->flush_map =3D false;
> +        } else {
> +            v->shared->flush_map =3D true;
> +        }
> +    } else if (!s->always_svq && v->shared->svq_switching &&
> +               v->desc_group < 0) {
> +        v->shared->flush_map =3D true;
> +    }
> +}
> +

I'm wondering, since we have the reference count for the memory
listener already, why not adding one refcnt if _start detect it can
keep the memory maps?

>  static NetClientInfo net_vhost_vdpa_info =3D {
>          .type =3D NET_CLIENT_DRIVER_VHOST_VDPA,
>          .size =3D sizeof(VhostVDPAState),
>          .receive =3D vhost_vdpa_receive,
>          .start =3D vhost_vdpa_net_data_start,
>          .load =3D vhost_vdpa_net_data_load,
> +        .poll =3D vhost_vdpa_net_data_eval_flush,
>          .stop =3D vhost_vdpa_net_client_stop,
>          .cleanup =3D vhost_vdpa_cleanup,
>          .has_vnet_hdr =3D vhost_vdpa_has_vnet_hdr,
> @@ -1368,12 +1392,28 @@ static int vhost_vdpa_net_cvq_load(NetClientState=
 *nc)
>      return 0;
>  }
>
> +static void vhost_vdpa_net_cvq_eval_flush(NetClientState *nc, bool stop)
> +{
> +    VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> +    struct vhost_vdpa *v =3D &s->vhost_vdpa;
> +
> +    if (!stop) {
> +        return;
> +    }
> +
> +    if (!v->shared->flush_map && !v->shared->svq_switching &&
> +        !s->cvq_isolated && v->desc_group < 0) {
> +        v->shared->flush_map =3D true;
> +    }
> +}
> +
>  static NetClientInfo net_vhost_vdpa_cvq_info =3D {
>      .type =3D NET_CLIENT_DRIVER_VHOST_VDPA,
>      .size =3D sizeof(VhostVDPAState),
>      .receive =3D vhost_vdpa_receive,
>      .start =3D vhost_vdpa_net_cvq_start,
>      .load =3D vhost_vdpa_net_cvq_load,
> +    .poll =3D vhost_vdpa_net_cvq_eval_flush,
>      .stop =3D vhost_vdpa_net_cvq_stop,
>      .cleanup =3D vhost_vdpa_cleanup,
>      .has_vnet_hdr =3D vhost_vdpa_has_vnet_hdr,
> --
> 1.8.3.1
>


