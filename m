Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0983F82A6B7
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 05:04:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNmHN-0001OR-DJ; Wed, 10 Jan 2024 23:02:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNmHL-0001Nc-DH
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 23:02:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNmHJ-00072q-Ap
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 23:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704945768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ciuR0nHWkge73Dg5iQ5PCK7AsS010i+Tuj/JU1uAoqQ=;
 b=btwRtCAeQizdi8Cu4EmqMODrHLkTr0WL441J+VHvjoPbBfDEuFMKAzkKnt2N1ROCous08N
 37k31qKj84j3/pogjaGeGvMhIXr1EWrW4tt2Nh2ZpUuZgkzHblAHtIEbo9zf0JUlzHA6aD
 Ufg1YsT+nFOn23CJLIrj7k1y3m1oUJg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-1MpOGQ9xO1Cqhk7Unk0ykw-1; Wed, 10 Jan 2024 23:02:46 -0500
X-MC-Unique: 1MpOGQ9xO1Cqhk7Unk0ykw-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3bd3af050ddso4504467b6e.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 20:02:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704945766; x=1705550566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ciuR0nHWkge73Dg5iQ5PCK7AsS010i+Tuj/JU1uAoqQ=;
 b=Jh/dXgLyWyLND2BAHi16TCBH8mbtHQWxrZIHZVybPkEYSmpsltGiEA9HQ4Nzl76yZx
 Cx4K7ZstGdv0t4eFMH7B2bPd+0KhR/Ew3y4/Jb7hAv/3BA/Ekyq6t9/3mqmh1umPmc1z
 x7OP7j1MWBkqUc3utXq8R3MubuGSIKLzgGHe+ADb82mItQnITC6cAPn9XCGxHMJCPcqZ
 VJCfSMzPvn6HhAQH5rHHmg5ETPN94r9naqr0Ged8w/+DZytRdv7fNWHHTPdKsvFqSMGg
 DvmMbxHaTYXtfozLwLNgO4yFYm8kVrnweLZFtWb2dfjxTQmlzfL0JLkxVkpWmjINFyjZ
 YETw==
X-Gm-Message-State: AOJu0Yyq66Qo3a6jXJ1YUf39mbZrfVKLM71nAbBSDUnkx+/8zaYeNFhI
 +vq7T35J+su3MzPP8zfSOHpKMzoXG4iTRkxfcduC8/8t6Tb9rYEwI0HriBhtfbOg8Cb5V2zItkd
 C58XYVGBltnZCsAggNCpwWJG9uaBVY4KaApsIBBY=
X-Received: by 2002:a05:6808:2112:b0:3bb:d622:14c2 with SMTP id
 r18-20020a056808211200b003bbd62214c2mr874862oiw.9.1704945765928; 
 Wed, 10 Jan 2024 20:02:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaTOkWhUa7G/8v7PDRewc2MMPTeMQo8+P3KAfL5lNZ8GGIvYnOV31PNj4n9xcQX8WwQqQfe9IQ9lh6aKqqCds=
X-Received: by 2002:a05:6808:2112:b0:3bb:d622:14c2 with SMTP id
 r18-20020a056808211200b003bbd62214c2mr874846oiw.9.1704945765655; Wed, 10 Jan
 2024 20:02:45 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-4-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-4-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 12:02:34 +0800
Message-ID: <CACGkMEtQL8JdkFkyBQ8adt--TK88oTfuPuUnDRkpVT6ZoDuOeQ@mail.gmail.com>
Subject: Re: [PATCH 03/40] vdpa: probe descriptor group index for data vqs
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Dec 8, 2023 at 2:53=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Getting it ahead at initialization time instead of start time allows
> decision making independent of device status, while reducing failure
> possibility in starting device or during migration.
>
> Adding function vhost_vdpa_probe_desc_group() for that end. This
> function will be used to probe the descriptor group for data vqs.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  net/vhost-vdpa.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 887c329..0cf3147 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1688,6 +1688,95 @@ out:
>      return r;
>  }
>
> +static int vhost_vdpa_probe_desc_group(int device_fd, uint64_t features,
> +                                       int vq_index, int64_t *desc_grpid=
x,
> +                                       Error **errp)
> +{
> +    uint64_t backend_features;
> +    int64_t vq_group, desc_group;
> +    uint8_t saved_status =3D 0;
> +    uint8_t status =3D 0;
> +    int r;
> +
> +    ERRP_GUARD();
> +
> +    r =3D ioctl(device_fd, VHOST_GET_BACKEND_FEATURES, &backend_features=
);
> +    if (unlikely(r < 0)) {
> +        error_setg_errno(errp, errno, "Cannot get vdpa backend_features"=
);
> +        return r;
> +    }
> +
> +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID))) {
> +        return 0;
> +    }
> +
> +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_DESC_ASID))) {
> +        return 0;
> +    }
> +
> +    r =3D ioctl(device_fd, VHOST_VDPA_GET_STATUS, &saved_status);
> +    if (unlikely(r)) {
> +        error_setg_errno(errp, -r, "Cannot get device status");
> +        goto out;
> +    }

I wonder what's the reason for the status being saved and restored?

We don't do this in vhost_vdpa_probe_cvq_isolation().

Thanks


