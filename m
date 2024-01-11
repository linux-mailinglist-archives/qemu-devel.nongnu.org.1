Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3FF82A90E
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:25:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqNV-0002VJ-DY; Thu, 11 Jan 2024 03:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNqNI-0002SZ-VX
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:25:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNqND-0004Qm-QF
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704961510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7kN2OboYv9j1gWoKgmCSRFW1ftXWzfBfTVz036EwDLk=;
 b=b9jqv5w9BLPQX3/zMmutrCKMh/NepX/ocypzKODL5GfV37IctvUevnsSEdXnTsvGSLdQuK
 GoNyg3x/j2UpstKGFIazTa9mVXB6C6n3EW9jkcBIJS9mgwg1m6DuL1jvXM8ltlmQLr8nX+
 7qFGyVSmhOfTxLfS8Kjo51YZYX0Z6MY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-8kyQuJhBPCyVds87I4hItA-1; Thu, 11 Jan 2024 03:25:08 -0500
X-MC-Unique: 8kyQuJhBPCyVds87I4hItA-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3bd52c528aeso500523b6e.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 00:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704961508; x=1705566308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7kN2OboYv9j1gWoKgmCSRFW1ftXWzfBfTVz036EwDLk=;
 b=vZd3kdpTBgqcmPRxUnksi2hK5MCkHfjhnjsSDdUCNYkNNt6NsS/IWvYWGM/jM4TtOc
 BjWBy4IETL7fSuO1i7pjpOxJa6ZqNmZZT+fxew9sub3jZOwH5OM3yEr/Ef+8oiIRmT5V
 1Su5gtQqzcSXcssxhqLLL/bczU7MCadi1HUQKGqAicgR5FD0LhBr5C8+k/il2xMohMEo
 jDnOCt2qDI5CPjHLGmEPSP56aPfMPHUbwEwQQg1KvCcHkFaAz2u/jlm1DS1YNFAenieE
 gtTWK6ghLqsP6uOLDSHFBevphagX7D6lh7BeYhPFSfcK8YDx30hVnTjiPH0mSVC3m+55
 /xHA==
X-Gm-Message-State: AOJu0YzgW120ps2Hsb+l7EOsjYYks2+JM822RxrhPTkJ2bjcqfh3/7XE
 vw5VPPuA+i77xjiS781rbwRldJn9TZFpHJuglytfJ/+CpWWZEMcC71+NQpLskk88PWEbDeDvHoF
 5LizOHS6yHkeH0OTbuZRxI2FOr6JPlMAGW65x+Cg=
X-Received: by 2002:a05:6808:d48:b0:3bb:bc98:759c with SMTP id
 w8-20020a0568080d4800b003bbbc98759cmr1065704oik.63.1704961508098; 
 Thu, 11 Jan 2024 00:25:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE1gKxv5dl1Ar6UDJDP3AP1WVxQTckAAG9Y24SdN6bylO50CFzItY+QZXGvvx20YTe5RDGk1ZnF9yhhR7N71E=
X-Received: by 2002:a05:6808:d48:b0:3bb:bc98:759c with SMTP id
 w8-20020a0568080d4800b003bbbc98759cmr1065695oik.63.1704961507788; Thu, 11 Jan
 2024 00:25:07 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-18-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-18-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 16:24:55 +0800
Message-ID: <CACGkMEtug-M9R8fJ_X3nX1qOWjPHnhtrVaTSin1YDpBBGGYyfg@mail.gmail.com>
Subject: Re: [PATCH 17/40] vdpa: judge if map can be kept across reset
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Dec 8, 2023 at 2:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> The descriptor group for SVQ ASID allows the guest memory mapping
> to retain across SVQ switching, same as how isolated CVQ can do
> with a different ASID than the guest GPA space. Introduce an
> evaluation function to judge whether to flush or keep iotlb maps
> based on virtqueue's descriptor group and cvq isolation capability.

I may miss something, but is there any reason we can't judge during
initialization?

We know the device capability so it should not depend on any runtime
configuration.

Thanks

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


