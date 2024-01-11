Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFB182A804
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 08:07:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNp9a-0005sx-3w; Thu, 11 Jan 2024 02:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNp9X-0005sJ-Td
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:06:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNp9W-0005AD-Bt
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704956817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J5vznvnlmRwI1rNFz63taMLN5NRQy15z18EFywvU5nM=;
 b=SNXx15nL96ifkmmQ+/EgqJ4Mg0hyo+rVT1/glNYjOdxAOFNk4HEyGiDsSVy2tcAIj1xyPR
 oIhvWpLbJHJfIHdWpXHpSXl+XrKZ2mRMqjYMR6u/9GTg/mMY6jFFMVoqYY3For3/v9KSm5
 NxoBQseT5nxTIsL86HZNfwsAAvBXgno=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-J91XZXXnPyqasLelgdoo_g-1; Thu, 11 Jan 2024 02:06:56 -0500
X-MC-Unique: J91XZXXnPyqasLelgdoo_g-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3bd4b623e4aso2417646b6e.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 23:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704956815; x=1705561615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J5vznvnlmRwI1rNFz63taMLN5NRQy15z18EFywvU5nM=;
 b=RVxEYNaJ/9Y9UHNsQkisPS1LpeNa9x61/Y9aruZq7CAZrQU4CQHrv+U7EUuK58HQ6x
 3ucbCuhmf/64ZcOS77TvRd7kKOtTN6yQPId/NP795uH1K9vGpTWg/N4Swsr71hfSIYpG
 QaTjirIjGRx1OwIaJD9pPvrDJrO+UHZr0VUzliJADAvW5QPD4GfLkwjQH8lUiN8+jBTt
 3OrNCNVvqA3NUNryh1Gr7RAZkved+SzUHAcqHzeADCMnD2hgLSSnsRHzDW1fEM1zYeDB
 GdrlmoKBLNeuMxYfZV/FmvdFu6/SifX8DZWKG6MTwHDDUsdp23rt/B4Ihj9+c7F9A3RS
 Nrfg==
X-Gm-Message-State: AOJu0Yxops8E6C5TGvKKF8/WKxJ8x4eoBDAyk3T/MxTGKDN5EFjXRxlf
 AdEePT/4kHO4QB3FzEQ9o/3sUr6Imh/qWrJBEK7+7W+ZjNvPRNQjgCGpGQLe5jSJClTOnDDDFjA
 vo1caNCtXke9qSLBo5VSy6QnYdfVREFCBS1RL1vI=
X-Received: by 2002:a05:6808:1152:b0:3bd:4022:79aa with SMTP id
 u18-20020a056808115200b003bd402279aamr1319879oiu.19.1704956815372; 
 Wed, 10 Jan 2024 23:06:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjz2ZoVyaSsQWr61jrpiM2ZSJbKdBhy81Xmxp7iWqnIIpTnGUYwwHwxshmcFNJK0UuQ2dkYl/QxOHRPSCD0Cs=
X-Received: by 2002:a05:6808:1152:b0:3bd:4022:79aa with SMTP id
 u18-20020a056808115200b003bd402279aamr1319863oiu.19.1704956815099; Wed, 10
 Jan 2024 23:06:55 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-5-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-5-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 15:06:44 +0800
Message-ID: <CACGkMEtXjyAfBwKCiB=3PKkEh6kpxFqM9wvKnXx9mVsNkYk1EA@mail.gmail.com>
Subject: Re: [PATCH 04/40] vdpa: piggyback desc_group index when probing
 isolated cvq
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

On Fri, Dec 8, 2023 at 2:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Same as the previous commit, but do it for cvq instead of data vqs.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  net/vhost-vdpa.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 0cf3147..cb5705d 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1601,16 +1601,19 @@ static const VhostShadowVirtqueueOps vhost_vdpa_n=
et_svq_ops =3D {
>  };
>
>  /**
> - * Probe if CVQ is isolated
> + * Probe if CVQ is isolated, and piggyback its descriptor group
> + * index if supported
>   *
>   * @device_fd         The vdpa device fd
>   * @features          Features offered by the device.
>   * @cvq_index         The control vq pair index
> + * @desc_grpidx       The CVQ's descriptor group index to return
>   *
> - * Returns <0 in case of failure, 0 if false and 1 if true.
> + * Returns <0 in case of failure, 0 if false and 1 if true (isolated).
>   */
>  static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t featur=
es,
> -                                          int cvq_index, Error **errp)
> +                                          int cvq_index, int64_t *desc_g=
rpidx,
> +                                          Error **errp)
>  {
>      uint64_t backend_features;
>      int64_t cvq_group;
> @@ -1667,6 +1670,13 @@ static int vhost_vdpa_probe_cvq_isolation(int devi=
ce_fd, uint64_t features,
>          goto out;
>      }
>
> +    if (backend_features & BIT_ULL(VHOST_BACKEND_F_DESC_ASID)) {
> +        int64_t desc_group =3D vhost_vdpa_get_vring_desc_group(device_fd=
,
> +                                                             cvq_index, =
errp);
> +        if (likely(desc_group >=3D 0) && desc_group !=3D cvq_group)
> +            *desc_grpidx =3D desc_group;
> +    }
> +
>      for (int i =3D 0; i < cvq_index; ++i) {
>          int64_t group =3D vhost_vdpa_get_vring_group(device_fd, i, errp)=
;
>          if (unlikely(group < 0)) {
> @@ -1685,6 +1695,8 @@ static int vhost_vdpa_probe_cvq_isolation(int devic=
e_fd, uint64_t features,
>  out:
>      status =3D 0;
>      ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> +    status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER;

Is this a bug fix or I don't see the connection with the descriptor group.

Thanks

> +    ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
>      return r;
>  }
>
> @@ -1791,6 +1803,7 @@ static NetClientState *net_vhost_vdpa_init(NetClien=
tState *peer,
>                                         Error **errp)
>  {
>      NetClientState *nc =3D NULL;
> +    int64_t desc_group =3D -1;
>      VhostVDPAState *s;
>      int ret =3D 0;
>      assert(name);
> @@ -1802,7 +1815,7 @@ static NetClientState *net_vhost_vdpa_init(NetClien=
tState *peer,
>      } else {
>          cvq_isolated =3D vhost_vdpa_probe_cvq_isolation(vdpa_device_fd, =
features,
>                                                        queue_pair_index *=
 2,
> -                                                      errp);
> +                                                      &desc_group, errp)=
;
>          if (unlikely(cvq_isolated < 0)) {
>              return NULL;
>          }
> --
> 1.8.3.1
>


