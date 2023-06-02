Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B4972006D
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 13:31:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q52zP-0003YF-Td; Fri, 02 Jun 2023 07:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1q52zN-0003Y6-PM
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1q52zM-00054t-4Y
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685705435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zKFSZHw/lZX9fNOdZEtXLHPFoPiaq+rDpI+cEcJS3Lo=;
 b=b1w2b3CICyZVX8AWypJ//EpZpE8+RYUA7tFiMdfbYPLTcIt3Jtm/6DYPxX1S8kg4vIpkw5
 G1ifUpBcKlB9v8vY1DflwircJUwzPNW9CFaELncg7X6NusAmlf8i2bsJinhNbb2pQ6dDhV
 egZciUu2BY7/pTCfmo9vN6WSUcpYj6k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-1OmIR0v7PE-hHkSRjR22WA-1; Fri, 02 Jun 2023 07:30:33 -0400
X-MC-Unique: 1OmIR0v7PE-hHkSRjR22WA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5128dcbdfc1so1368196a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 04:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685705432; x=1688297432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zKFSZHw/lZX9fNOdZEtXLHPFoPiaq+rDpI+cEcJS3Lo=;
 b=b+hzBsw0iomOqJJ5Kmj+wN/4tvWRPGpU6FQSMsVcctx+ERM3nq+H1De45pIQDPZD6K
 3chzMDsQH2vkBl2bUceoBs4/Eu85kpJUbZkbdxZCVPfhAGD5FOkJDTI9bBsMFJr4nfra
 XVyKy1PtT3gVXOfDLxP4L4hbrWmgVFIT+l/vgZwAa0jxQIEjp7ZuKi2+4hOAQSa/Ojox
 MTjSoseyOhUxEca3kcYpZoFd6wQKdFb7xKhwzq/DNLzFxfALT9AKZPg4zfeKvfMt4twX
 N5QOs4kY5pbPcc2I9ge8b4uMxMkKTicmHCV98X7Z12DEHfycI/F652+cWZDWic7RzEQ5
 /xlA==
X-Gm-Message-State: AC+VfDw7Gjk2zK7yCvpW5gPbnU3kccJV7CJyPIrQIJJ1SsayvTtDnSPp
 WIDq/faHKANogcdsq7OezaOLo24Q4U2KcWywH9Lc43+jY3Irof8NjtFCMqPaY5TvHyniyTs3nTZ
 5jfkF793LVj5cGle7R+hTZAA0Imz5w5zTYLoTMRoac9Ds
X-Received: by 2002:aa7:d0c4:0:b0:50c:358:1eba with SMTP id
 u4-20020aa7d0c4000000b0050c03581ebamr1673258edo.35.1685705432039; 
 Fri, 02 Jun 2023 04:30:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xcqPrWeqPSgEqlh9QJtPizB+eW5n9MoEHEH8D+dB/f51x9ZVbBFIJwg3EiD+A4FwmCKdCT+4pVjs/H/2xbv4=
X-Received: by 2002:aa7:d0c4:0:b0:50c:358:1eba with SMTP id
 u4-20020aa7d0c4000000b0050c03581ebamr1673244edo.35.1685705431749; Fri, 02 Jun
 2023 04:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230526153143.470745-1-eperezma@redhat.com>
In-Reply-To: <20230526153143.470745-1-eperezma@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 2 Jun 2023 19:29:55 +0800
Message-ID: <CAPpAL=ypo551yeF2rah7++qPrKQvvAA09-UM-OLGwcm-PuwqpA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Move ASID test to vhost-vdpa net initialization
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Parav Pandit <parav@mellanox.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng2@huawei.com, 
 Shannon Nelson <snelson@pensando.io>, Laurent Vivier <lvivier@redhat.com>,
 si-wei.liu@oracle.com, 
 Cindy Lu <lulu@redhat.com>, Harpreet Singh Anand <hanand@xilinx.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Gautam Dawar <gdawar@xilinx.com>, Jason Wang <jasowang@redhat.com>, 
 Liuxiangdong <liuxiangdong5@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 alvaro.karsz@solid-run.com, Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

QE did a sanity test on v4 of this series using the vdpa_sim
device,everything is working fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, May 26, 2023 at 11:31=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> QEMU v8.0 is able to switch dynamically between vhost-vdpa passthrough
> and SVQ mode as long as the net device does not have CVQ.  The net device
> state followed (and migrated) by CVQ requires special care.
>
> A pre-requisite to add CVQ to that framework is to determine if devices w=
ith
> CVQ are migratable or not at initialization time.  The solution to it is =
to
> always shadow only CVQ, and vq groups and ASID are used for that.
>
> However, current qemu version only checks ASID at device start (as "drive=
r set
> DRIVER_OK status bit"), not at device initialization.  A check at
> initialization time is required.  Otherwise, the guest would be able to s=
et
> and remove migration blockers at will [1].
>
> This series is a requisite for migration of vhost-vdpa net devices with C=
VQ.
> However it already makes sense by its own, as it reduces the number of io=
ctls
> at migration time, decreasing the error paths there.
>
> [1] https://lore.kernel.org/qemu-devel/2616f0cd-f9e8-d183-ea78-db1be4825d=
9c@redhat.com/
> ---
> v4:
> * Only probe one of MQ or !MQ.
> * Merge vhost_vdpa_cvq_is_isolated in vhost_vdpa_probe_cvq_isolation
> * Call ioctl directly instead of adding functions.
>
> v3:
> * Only record cvq_isolated, true if the device have cvq isolated in both =
!MQ
> * and MQ configurations.
> * Drop the cache of cvq group, it can be done on top
>
> v2:
> * Take out the reset of the device from vhost_vdpa_cvq_is_isolated
>   (reported by Lei Yang).
> * Expand patch messages by Stefano G. questions.
>
> Eugenio P=C3=A9rez (2):
>   vdpa: return errno in vhost_vdpa_get_vring_group error
>   vdpa: move CVQ isolation check to net_init_vhost_vdpa
>
>  net/vhost-vdpa.c | 147 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 112 insertions(+), 35 deletions(-)
>
> --
> 2.31.1
>
>


