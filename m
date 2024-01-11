Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEF482A8DC
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:16:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqEs-0005nD-Rc; Thu, 11 Jan 2024 03:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNqEp-0005mY-Kr
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:16:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNqEo-00086t-7Z
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704960989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mipgOnygIQW/EkgHpbMaNVp7oietiUxG3Mr+/AMIOHw=;
 b=WwztgVZe6kP7ofI/BpZQNLxmJ46+hQvtt+G86Nq/8vdUQETjoHuHnsUdOJ/ujjLWSwr72S
 7BC1PqsiOnhQT1DUB6Kpx6pY81LdDJ50+jbdB6w8t+S0ZmT/PRNosSeLOGkLE4Tt9hd5mK
 XYSBUB/bHM3FUtjw90vn3p/yes8GrQ4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-PMIDV_4eNCKLMoVnCFehRw-1; Thu, 11 Jan 2024 03:16:27 -0500
X-MC-Unique: PMIDV_4eNCKLMoVnCFehRw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6da57e2d2b9so3302663b3a.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 00:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704960987; x=1705565787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mipgOnygIQW/EkgHpbMaNVp7oietiUxG3Mr+/AMIOHw=;
 b=vPmWOZZU8zGJQqMWQLTRvZVWkaJqcYwsDQPtD4PGUPQGv6lphdSTMnigizASgkWfNQ
 muXNWIHYU+I2pgVSplaoP3IOaxfhh4lcgLWqhOn/u9IPstYbXib+umhfRLCStueFLZ4O
 qgd6D21F8QWz/v2OYweGVs9nVWDQ8fzMQHy44GyiZYMZCecuNxN83Nw/6XTuQLR5/NYK
 hrJjcbguREV05HQNL4y4NawnjQPFFBzHSRcQiQHidwqqgqt/y+F5mW9Bor9uBlpcWcr+
 o2Htua8TOm3+Cy/PQyHEcUOyZPNO0csQqeu3f59/zISESBjkwbnZbzVwN/0um02olfde
 inBg==
X-Gm-Message-State: AOJu0YzBE/nbMsR7KV2eciOqRu15ccKFbc3Q7S+qDYBY0a1FKap/aaT2
 kdiXjPVpHL908Ox1cM39Qhy2Oyphvanhnm1iavwf60HgWXifCAcuoXOkMnjHO/GGB8ZM05Y8gX4
 QQKDEij/+K+x44DnMSdrkzkTvE/J1vmV9CO14wc8=
X-Received: by 2002:aa7:8b90:0:b0:6da:1cee:ea32 with SMTP id
 r16-20020aa78b90000000b006da1ceeea32mr694080pfd.57.1704960986770; 
 Thu, 11 Jan 2024 00:16:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTihcnsGV9mzI9WJpHo0tSj0cQsV9mC9tPTPZXTYgco4JSj0g1sPwZ0jfPRTAektnF1a94s2+RwNWdSnuff3U=
X-Received: by 2002:aa7:8b90:0:b0:6da:1cee:ea32 with SMTP id
 r16-20020aa78b90000000b006da1ceeea32mr694075pfd.57.1704960986479; Thu, 11 Jan
 2024 00:16:26 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-16-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-16-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 16:16:15 +0800
Message-ID: <CACGkMEs8sFvdkwM90Ydy-1TTOSXoY4v6ppdKkO-J5_K7ouLn8A@mail.gmail.com>
Subject: Re: [PATCH 15/40] vdpa: add svq_switching and flush_map to header
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
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

On Fri, Dec 8, 2023 at 2:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Will be used in next patches.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  include/hw/virtio/vhost-vdpa.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdp=
a.h
> index 7b8d3bf..0fe0f60 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -72,6 +72,12 @@ typedef struct vhost_vdpa_shared {
>      bool shadow_data;
>
>      unsigned refcnt;
> +
> +    /* SVQ switching is in progress? 1: turn on SVQ, -1: turn off SVQ */
> +    int svq_switching;

Nit: just curious about any reason why 0, 1 or true false is not used?

Thanks

> +
> +    /* Flush mappings on reset due to shared address space */
> +    bool flush_map;
>  } VhostVDPAShared;
>
>  typedef struct vhost_vdpa {
> --
> 1.8.3.1
>


