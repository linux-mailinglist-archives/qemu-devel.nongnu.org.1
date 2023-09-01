Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A5778FBAB
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 12:15:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc1Aa-0003bE-R3; Fri, 01 Sep 2023 06:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1qc1AW-0003K7-ED
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1qc1AR-0001jQ-I8
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:14:24 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-FJIaquLtOvCGYcdxyyk2cg-1; Fri, 01 Sep 2023 06:14:16 -0400
X-MC-Unique: FJIaquLtOvCGYcdxyyk2cg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2bcc03ed694so23331701fa.2
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 03:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693563255; x=1694168055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5Lhmwq3v+LqCGOHQsOwIcxRg/3Km1NXFwkaRfoLU0M=;
 b=U96zcNfeBGwMndXTfw+G7DqXhQ1P//kKDlXr2SdzYtqtcA/LONx1Ltiowlkqo8rLPN
 Tx3VSeM23OzrgkYF2tXM36O+6ajaKwkZiZ0LHwe1vw7c05B51h08oNRPLCM574uFDsC9
 NIrJCrDi7geYU6cchdWD7s+ksUF+KW2f7BHJzlY4iVUZZjQiUSKtIbW+QtJ5DUeDiB6x
 rnK7Y7IsH94ZFvLu3NhuxmtuMGIqqQ6PETzO5/ySR7zBWTK7yN3GODPLic5rdWzVPckg
 KldPeVGb5oO1nZae+8s61XMuZLSHBOxagHxBYG01G2yjYszccLqpk4fW1Kmz77BePdYA
 fIbw==
X-Gm-Message-State: AOJu0YwirXrd9GXhvoVOn3ssAXDNqJA7q6TgIVZAMtI/Wtaq8bVJWqUJ
 2GK7sBHvUbA10MBXd2oTULF0dO/sE3qf+57Gt4mtfdo3fMu3QB168MMh/bZhLRPunyfZkhmxW4A
 6XKkWRT8YqtoezVvJmThZeVQD7L2H/TY=
X-Received: by 2002:a2e:8914:0:b0:2bd:d34:f892 with SMTP id
 d20-20020a2e8914000000b002bd0d34f892mr1530131lji.3.1693563255117; 
 Fri, 01 Sep 2023 03:14:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM7Jp+uqX5ypx6SHmcT6xOyQze0MENbbz6KcjPvLHgJZoSRgvL/xarLiHDKWGjYFmqrYKke9WPrr+LJSU+JNA=
X-Received: by 2002:a2e:8914:0:b0:2bd:d34:f892 with SMTP id
 d20-20020a2e8914000000b002bd0d34f892mr1530112lji.3.1693563254803; Fri, 01 Sep
 2023 03:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230831125702.11263-1-avihaih@nvidia.com>
 <20230831125702.11263-5-avihaih@nvidia.com>
In-Reply-To: <20230831125702.11263-5-avihaih@nvidia.com>
From: YangHang Liu <yanghliu@redhat.com>
Date: Fri, 1 Sep 2023 18:14:03 +0800
Message-ID: <CAGYh1E_9zLuWaWZ1FMw4Xa78YcWVn4BRwRs+PQOWiBJZSHgcSg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] vfio/migration: Block VFIO migration with postcopy
 migration
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yanghliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When try to do the vfio post-copy migration, we can get an expected
internal error now: "unable to execute QEMU command 'migrate':
0000:b1:00.2: VFIO migration is not supported with postcopy migration"

Tested-by: Yanghang Liu <yanghliu@redhat.com>

Best Regards,
YangHang Liu


On Thu, Aug 31, 2023 at 8:57=E2=80=AFPM Avihai Horon <avihaih@nvidia.com> w=
rote:
>
> VFIO migration is not compatible with postcopy migration. A VFIO device
> in the destination can't handle page faults for pages that have not been
> sent yet.
>
> Doing such migration will cause the VM to crash in the destination:
>
> qemu-system-x86_64: VFIO_MAP_DMA failed: Bad address
> qemu-system-x86_64: vfio_dma_map(0x55a28c7659d0, 0xc0000, 0xb000, 0x7f1b1=
1a00000) =3D -14 (Bad address)
> qemu: hardware error: vfio: DMA mapping failed, unable to continue
>
> To prevent this, block VFIO migration with postcopy migration.
>
> Reported-by: Yanghang Liu <yanghliu@redhat.com>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  hw/vfio/migration.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 71855468fe..20994dc1d6 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -335,6 +335,27 @@ static bool vfio_precopy_supported(VFIODevice *vbase=
dev)
>
>  /* ---------------------------------------------------------------------=
- */
>
> +static int vfio_save_prepare(void *opaque, Error **errp)
> +{
> +    VFIODevice *vbasedev =3D opaque;
> +
> +    /*
> +     * Snapshot doesn't use postcopy, so allow snapshot even if postcopy=
 is on.
> +     */
> +    if (runstate_check(RUN_STATE_SAVE_VM)) {
> +        return 0;
> +    }
> +
> +    if (migrate_postcopy_ram()) {
> +        error_setg(
> +            errp, "%s: VFIO migration is not supported with postcopy mig=
ration",
> +            vbasedev->name);
> +        return -EOPNOTSUPP;
> +    }
> +
> +    return 0;
> +}
> +
>  static int vfio_save_setup(QEMUFile *f, void *opaque)
>  {
>      VFIODevice *vbasedev =3D opaque;
> @@ -640,6 +661,7 @@ static bool vfio_switchover_ack_needed(void *opaque)
>  }
>
>  static const SaveVMHandlers savevm_vfio_handlers =3D {
> +    .save_prepare =3D vfio_save_prepare,
>      .save_setup =3D vfio_save_setup,
>      .save_cleanup =3D vfio_save_cleanup,
>      .state_pending_estimate =3D vfio_state_pending_estimate,
> --
> 2.26.3
>


