Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD0F82D391
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:57:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPE6b-0001Vp-KD; Sun, 14 Jan 2024 22:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPE6Y-0001VY-Jq
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:57:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPE6X-0001xO-3f
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705291060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+8TkXWJW4BwGVSubjzMW98wK5Q2xu9z9OImLZHA9gs=;
 b=M09B53SBNXxbr6yA5YR3BRiq5HFK9WUPOFna9/cHfIojl4s2SsqiIdzCEvVJCcnZn/Wuet
 nDT+KZLLkZ4RI0HMyozUoIRCALSYQLoknobcS556C2ZMh/dOS2ZmYc8upRePDUqDdX23wf
 aLOUfPiobk0BuzXtbq+SijGfGuITG00=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-xBs9SB-2PR2__jfH7P3ZQw-1; Sun, 14 Jan 2024 22:57:39 -0500
X-MC-Unique: xBs9SB-2PR2__jfH7P3ZQw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-28bcf7f605aso7559173a91.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705291058; x=1705895858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+8TkXWJW4BwGVSubjzMW98wK5Q2xu9z9OImLZHA9gs=;
 b=nIS8cOYkaHfVuLMQJY/Uq3aWmHK/Wfv5937B28snNMGH6V66Jcr73WHkoxAXUBfMYb
 MVhXG9bFyGpABX3vFZlN/IFAaPKs9+WRErGTfjutXjBzGLpqoUb4GFQQeSM9aorx8H2q
 5mIopFiVOuspN5CHTiOSWZXELpeDQ8MK0vWg8c9OYK191DxnzvrKetf9wIJXz/OzuG5h
 71R/H4MEpgGKZyLIJXabFyGVXUQBabeP0Vw01bSls9lkmrjcvDEmc7nfOb26bhMnq2FF
 VMK0NmtosMqXa4Cq3NcPKrJYH836qb38I4gb/m1wDEX3iWje+bbd12k+3TSSfAPuckeG
 OtCw==
X-Gm-Message-State: AOJu0Yxe3ElHYoP8iouHDU4VCh41eHU7GGDKjC8Q41hhZzSYUoVYOVtw
 DSLUzBDAHFAzEC+2V0ALnmHvU4W2ntwo5wNp1b4FY2/wEbw4GVX8ShRrpn9tz5FvB32bAvii+AU
 cQcgtVnIhNRWrxqeyt7as+eRdrZIEkG94VMSPHnE=
X-Received: by 2002:a17:90a:d98e:b0:28d:fd67:fa9c with SMTP id
 d14-20020a17090ad98e00b0028dfd67fa9cmr8044211pjv.37.1705291058042; 
 Sun, 14 Jan 2024 19:57:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDmv2aetLMDujTAqRfNXm0dF+PO3uS69fk3RvBnohzUZj1ZvoKi76xhKFPwVPqTeWgQbFBX8x/sJ5EPfDkdGM=
X-Received: by 2002:a17:90a:d98e:b0:28d:fd67:fa9c with SMTP id
 d14-20020a17090ad98e00b0028dfd67fa9cmr8044199pjv.37.1705291057808; Sun, 14
 Jan 2024 19:57:37 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-39-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-39-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 11:57:26 +0800
Message-ID: <CACGkMEvAUnfzvH=bnE8ka0fxrQORnGRvKeSk=wnuhZUvEcpOdg@mail.gmail.com>
Subject: Re: [PATCH 38/40] vdpa: add trace events for eval_flush
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Fri, Dec 8, 2023 at 2:51=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> For better debuggability and observability.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  net/trace-events | 2 ++
>  net/vhost-vdpa.c | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/net/trace-events b/net/trace-events
> index aab666a..d650c71 100644
> --- a/net/trace-events
> +++ b/net/trace-events
> @@ -26,3 +26,5 @@ colo_filter_rewriter_conn_offset(uint32_t offset) ": of=
fset=3D%u"
>
>  # vhost-vdpa.c
>  vhost_vdpa_set_address_space_id(void *v, unsigned vq_group, unsigned asi=
d_num) "vhost_vdpa: %p vq_group: %u asid: %u"
> +vhost_vdpa_net_data_eval_flush(void *s, int qindex, int svq_switch, bool=
 svq_flush) "vhost_vdpa: %p qp: %d svq_switch: %d flush_map: %d"
> +vhost_vdpa_net_cvq_eval_flush(void *s, int qindex, int svq_switch, bool =
svq_flush) "vhost_vdpa: %p qp: %d svq_switch: %d flush_map: %d"
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 84876b0..a0bd8cd 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -608,6 +608,9 @@ static void vhost_vdpa_net_data_eval_flush(NetClientS=
tate *nc, bool stop)
>                 v->desc_group < 0) {
>          v->shared->flush_map =3D true;
>      }
> +    trace_vhost_vdpa_net_data_eval_flush(v, s->vhost_vdpa.index,
> +                                        v->shared->svq_switching,
> +                                        v->shared->flush_map);
>  }
>
>  static NetClientInfo net_vhost_vdpa_info =3D {
> @@ -1457,6 +1460,10 @@ static void vhost_vdpa_net_cvq_eval_flush(NetClien=
tState *nc, bool stop)

For even better debuggability and observability.

Is it better to squash this into the patch into vhost_vdpa_net_cvq_eval_flu=
sh()?

Thanks

>          !s->cvq_isolated && v->desc_group < 0) {
>          v->shared->flush_map =3D true;
>      }
> +
> +    trace_vhost_vdpa_net_cvq_eval_flush(v, s->vhost_vdpa.index,
> +                                       v->shared->svq_switching,
> +                                       v->shared->flush_map);
>  }
>
>  static NetClientInfo net_vhost_vdpa_cvq_info =3D {
> --
> 1.8.3.1
>


