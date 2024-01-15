Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 104E882D392
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:59:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPE7y-0002D5-1z; Sun, 14 Jan 2024 22:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPE7v-0002Cp-OB
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:59:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPE7u-0002AC-9q
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705291145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vOb09NC4gDli9chuq2ie+qIcFJSYYMKxctbLhQ4CKhg=;
 b=id6uBa2ZLiHYULfqWb6aUAJAW9PaPrHUxPVbgfW/7IbDQIAxFm8az6HZaRR+na/3gk4GY/
 A9U8mCVRNhbHsAb9t01wMufpPasDA+izifpl/ES/tLpAYVuyKYpweaTA8/4UT/MDIc/GN0
 MgexxK6+XITduInsrCJli9yvlenqS2I=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-E0QQMqcWMtyUAyU53sSCOw-1; Sun, 14 Jan 2024 22:59:03 -0500
X-MC-Unique: E0QQMqcWMtyUAyU53sSCOw-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3bbac3d23f8so8847535b6e.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705291143; x=1705895943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vOb09NC4gDli9chuq2ie+qIcFJSYYMKxctbLhQ4CKhg=;
 b=sILOi412GctN2CwYHszYQROPc468HfHyy/v2EPJvJ1bWWB/mbdsosrazk0g2oorY2a
 PAxx52tnMeWcQTbcikLtsi+VqFFfcnoF4DFvLfty05VR1RL8gn44gTaT3ugTYMBwtqKf
 4/PmDvJaGorjXdonL9HpXkJh99TVs7/DfSnDTk2qxGZB1d36y1LKhTcbzYU9jd6eOkOk
 DVL3evzF3viIN0QfGyDr4vDZBkFdvD5YnRLON0J2IxLBk5x2+LCdSYNnKEWTuWG96nOQ
 Ztw/lXxoNZql5/6yxKlGsN+TkzeM35YfKg1+8D0Oh3AZhIrUtHf1FtalX9pvMdZdTGCa
 tnNA==
X-Gm-Message-State: AOJu0Yx7WHvmToyVZfSO699MVORZ2lVTgSwL7ZLZx45v5uoo4kS9LVcV
 jAAVSTaJqwJXV6dhvP4UGChKvLUPNus/K1O8G7xoP7+iHtsjK+DAwn8OvvlTEqQZwd8bP4m8NUc
 sgmPauIk3E7zGY8GjRUEXpmEfwFs4A3TvJQ42rKk=
X-Received: by 2002:a05:6808:1302:b0:3bd:54d2:9195 with SMTP id
 y2-20020a056808130200b003bd54d29195mr7066693oiv.43.1705291143094; 
 Sun, 14 Jan 2024 19:59:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt+MInFbmZ9i2I5ADReAppaInZvFlp2IHQBb/6nEERWlBGLI/pUPxkJSw0YhL6kHeBNri06w8yP4JK3POASjA=
X-Received: by 2002:a05:6808:1302:b0:3bd:54d2:9195 with SMTP id
 y2-20020a056808130200b003bd54d29195mr7066683oiv.43.1705291142914; Sun, 14 Jan
 2024 19:59:02 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-41-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-41-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 11:58:52 +0800
Message-ID: <CACGkMEtuEtT-oMwwKSRqyeGwgKKxxaBRqRjr4_Tt8easgKK7xQ@mail.gmail.com>
Subject: Re: [PATCH 40/40] vdpa: add trace event for vhost_vdpa_net_load_mq
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Fri, Dec 8, 2023 at 2:51=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> For better debuggability and observability.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
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

Similarly, I think nc->name looks better than the plain pointer here?

Thanks

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


