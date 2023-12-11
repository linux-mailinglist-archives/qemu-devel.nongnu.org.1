Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F310480D51B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 19:16:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCkp8-0002Qv-Vo; Mon, 11 Dec 2023 13:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCkot-00025s-1t
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:15:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCkoq-0004kr-Lw
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702318551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVMFijCRsS5o7OXn1yFDBUMeYGAxG3TpYcOebGlFdHA=;
 b=dfU1D9kX9OxX+L9yqvTi2281SnqMNcTQ+pCHyG3yP32gFRiK4F9IuSekxinahGzzU3Tszl
 MHrc+RJY7rW24QPQjrsJZXFliULa2ivtCz2INwdrYB4MKEPauOqIM9SIL6gadtOLZqHaKB
 y44W2lr3/qnZD3w0E3HTZVSu1ZXjSV8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-4wo4PNekMsiuC9ffLObk0Q-1; Mon, 11 Dec 2023 13:15:46 -0500
X-MC-Unique: 4wo4PNekMsiuC9ffLObk0Q-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5d42c43d8daso31633137b3.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 10:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702318546; x=1702923346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HVMFijCRsS5o7OXn1yFDBUMeYGAxG3TpYcOebGlFdHA=;
 b=H0jSfy/NJgd1Qbq/t5XUPP5Vt+gmvgCkvAeNnSV1nMrlWsKbB16kKG8UFHhVLerzGs
 pxhr0VL65altjTJ+JD13Txicu/TDqti2azgfP6rzaIlaF0+EkCagkTrTJYcbrTct05WK
 +LvhdQJOxVxJXJ4C7n2KpBUp2AhtUfZs+ONQrcV0HWxA7XmcYt8fKGyn0HHgk9wH6Jkc
 SMrdGXte5fhBxz3cqD2MLMOzLL+fHV49nGIofIdnKK89CxTZhftIQfJXHXyvuhBPr/ah
 eaKeRZebz+7vFMWPoXjGPSKxLipr6mg4dw//MMRy5e9gtUfNRgtI+et9kVbkwiI0w00c
 OvJg==
X-Gm-Message-State: AOJu0Ywp6tnryH0lX5smTAj9vDLbkdBK6AhJGFbMhbnfjSfc7cYypBID
 d3sd3mDWak2zt/mp6Ko8D6DpYR4z8UW3tC9ZKdXsjLSe4D4GfoQQ2zieX687vFa4U/VY9hHG0JH
 u5b3q17++XoPBWydPr4S5cdGYgXadxec=
X-Received: by 2002:a0d:f484:0:b0:5d7:307f:3efd with SMTP id
 d126-20020a0df484000000b005d7307f3efdmr3499224ywf.25.1702318545925; 
 Mon, 11 Dec 2023 10:15:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfm9Mnk+kyrk5WocFIvh9hCGWxuHJ4ZO6dPNV63Us+Fy8APURi1VUG7zgrnpo4Kig+ZTitenvJq2lmMZVGYVE=
X-Received: by 2002:a0d:f484:0:b0:5d7:307f:3efd with SMTP id
 d126-20020a0df484000000b005d7307f3efdmr3499209ywf.25.1702318545710; Mon, 11
 Dec 2023 10:15:45 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-41-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-41-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 19:15:09 +0100
Message-ID: <CAJaqyWewNV0oFR5uGLn_6fVVQn=vNmkwvLkgO50jMgqUJ9_feg@mail.gmail.com>
Subject: Re: [PATCH 40/40] vdpa: add trace event for vhost_vdpa_net_load_mq
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
>  net/trace-events | 1 +
>  net/vhost-vdpa.c | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/net/trace-events b/net/trace-events
> index be087e6..c128cc4 100644
> --- a/net/trace-events
> +++ b/net/trace-events
> @@ -30,3 +30,4 @@ vhost_vdpa_net_data_eval_flush(void *s, int qindex, int=
 svq_switch, bool svq_flu
>  vhost_vdpa_net_cvq_eval_flush(void *s, int qindex, int svq_switch, bool =
svq_flush) "vhost_vdpa: %p qp: %d svq_switch: %d flush_map: %d"
>  vhost_vdpa_net_load_cmd(void *s, uint8_t class, uint8_t cmd, int data_nu=
m, int data_size) "vdpa state: %p class: %u cmd: %u sg_num: %d size: %d"
>  vhost_vdpa_net_load_cmd_retval(void *s, uint8_t class, uint8_t cmd, int =
r) "vdpa state: %p class: %u cmd: %u retval: %d"
> +vhost_vdpa_net_load_mq(void *s, int ncurqps) "vdpa state: %p current_qpa=
irs: %d"
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 61da8b4..17b8d01 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1109,6 +1109,8 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s=
,
>          return 0;
>      }
>
> +    trace_vhost_vdpa_net_load_mq(s, n->curr_queue_pairs);
> +
>      mq.virtqueue_pairs =3D cpu_to_le16(n->curr_queue_pairs);
>      const struct iovec data =3D {
>          .iov_base =3D &mq,
> --
> 1.8.3.1
>


