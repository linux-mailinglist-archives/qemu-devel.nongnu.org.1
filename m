Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B1680D518
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 19:16:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCkp5-0002Cl-Ge; Mon, 11 Dec 2023 13:16:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCkon-00020P-Bq
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:15:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCkog-0004iW-45
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702318535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jr3BmAtvIN5vNPjNOlc20Jhyr9W1IJFnrWkHjMe7zTI=;
 b=GI3TCcIN94VebKuU4TvSWzAYS/JrFPqqUk/WXHXC12C9MWvDzPfTXAjvsrkyKxhCXVzab9
 uCnLSNjen1cevRDn1PP9tF440uZvMKH1vxelHP4JeeDmbiZygCUlgEUt1VFoUepWPBwwf/
 kaEtPSuu1WdinlzFXCjDY8da3xhujkY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-YX3noqB2N1Sb4c9oRVBR4w-1; Mon, 11 Dec 2023 13:15:34 -0500
X-MC-Unique: YX3noqB2N1Sb4c9oRVBR4w-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dbc1f00dc35so5367669276.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 10:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702318533; x=1702923333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jr3BmAtvIN5vNPjNOlc20Jhyr9W1IJFnrWkHjMe7zTI=;
 b=VEQrnNl/1kjPuINc7CWmQwlK3OsWdIplUtUOcYh+Y0xOrGh6zVk+sb/p3Ni1dpiTRl
 XuF6s4szbKExaToV4Nc7DgVszDSe+RikCtxQvfK3RPP8/NOeFie9eHAul5Rhe8hPflz4
 qCP7ZUsXx5ZP1b9brHr/dgytPPJihXZlSiZOoPyM45M+QJmt71Jx6VjjPlAp59JCgpaE
 49VkUOigo1ES8baykutwHXITYtRLbDfi7qALBtT/jr4kcgOJzQTlOF5ilIBN07TRjfcx
 h5xiskFx4Oyr2KlZUrDTnm4+VW3qB+PxJaxL92V6mGmzm9umpdJ6ZRsQbYQq6SekMUD1
 73kw==
X-Gm-Message-State: AOJu0Yzb5FPFeQ2qfwGKbYhvfVOmHXPvqUAYWpvos1d0Hd0td9idQFym
 513GpkOqtnk2sgZ1ygZJU247Svl58UlY5zfqgccwJdsZXlpzHRPZL2EFRra59zjrR4UbEVnt9ly
 qP0NRawy0avqs0DY+yjWsnZAyubWAYv8=
X-Received: by 2002:a05:6902:1b88:b0:da3:76d7:ddcd with SMTP id
 ei8-20020a0569021b8800b00da376d7ddcdmr3679707ybb.17.1702318533361; 
 Mon, 11 Dec 2023 10:15:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuAActuyhyfsiwpUfbt/3tBNEhf/4I/FcQqmkrjiWzXx2blSWn+mpYrCCr3ZCXfE3ARsFsjt5q5yvaI0AWbwA=
X-Received: by 2002:a05:6902:1b88:b0:da3:76d7:ddcd with SMTP id
 ei8-20020a0569021b8800b00da376d7ddcdmr3679694ybb.17.1702318533113; Mon, 11
 Dec 2023 10:15:33 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-40-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-40-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 19:14:57 +0100
Message-ID: <CAJaqyWc5TwWzJ9czSQ2uqBcsfcjwZs0YfWvqgzzLyUj1XJJ8ZQ@mail.gmail.com>
Subject: Re: [PATCH 39/40] vdpa: add trace events for vhost_vdpa_net_load_cmd
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Dec 7, 2023 at 7:51=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> For better debuggability and observability.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  net/trace-events | 2 ++
>  net/vhost-vdpa.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/net/trace-events b/net/trace-events
> index d650c71..be087e6 100644
> --- a/net/trace-events
> +++ b/net/trace-events
> @@ -28,3 +28,5 @@ colo_filter_rewriter_conn_offset(uint32_t offset) ": of=
fset=3D%u"
>  vhost_vdpa_set_address_space_id(void *v, unsigned vq_group, unsigned asi=
d_num) "vhost_vdpa: %p vq_group: %u asid: %u"
>  vhost_vdpa_net_data_eval_flush(void *s, int qindex, int svq_switch, bool=
 svq_flush) "vhost_vdpa: %p qp: %d svq_switch: %d flush_map: %d"
>  vhost_vdpa_net_cvq_eval_flush(void *s, int qindex, int svq_switch, bool =
svq_flush) "vhost_vdpa: %p qp: %d svq_switch: %d flush_map: %d"
> +vhost_vdpa_net_load_cmd(void *s, uint8_t class, uint8_t cmd, int data_nu=
m, int data_size) "vdpa state: %p class: %u cmd: %u sg_num: %d size: %d"
> +vhost_vdpa_net_load_cmd_retval(void *s, uint8_t class, uint8_t cmd, int =
r) "vdpa state: %p class: %u cmd: %u retval: %d"
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index a0bd8cd..61da8b4 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -885,6 +885,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState=
 *s,
>
>      assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl))=
;
>      cmd_size =3D sizeof(ctrl) + data_size;
> +    trace_vhost_vdpa_net_load_cmd(s, class, cmd, data_num, data_size);
>      if (vhost_svq_available_slots(svq) < 2 ||
>          iov_size(out_cursor, 1) < cmd_size) {
>          /*
> @@ -916,6 +917,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState=
 *s,
>
>      r =3D vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
>      if (unlikely(r < 0)) {
> +        trace_vhost_vdpa_net_load_cmd_retval(s, class, cmd, r);
>          return r;
>      }
>
> --
> 1.8.3.1
>


