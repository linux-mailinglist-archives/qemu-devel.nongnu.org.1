Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F6373191B
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 14:41:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9mGn-0004l3-DX; Thu, 15 Jun 2023 08:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1q9mGi-0004ka-Ht
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 08:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1q9mGg-0002TZ-G7
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 08:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686832801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LcUkEj3K+8Dv5U7WwMsL88tampUxF9GV0oDLpskuklQ=;
 b=DFGLYzBvIGKyHq2nHZDZuo7JETheRFxCoPpViN7FeUT4V3ODjy3vqxPkKnrB98qheNh73y
 6QScBe/53Gsn9VysU4Ux9i16XaY4Etsng1xJ+YfvD2DckD3Wq7KuUOyJPph/k/xO6gVqX6
 0PM7q4Gptdw8CNixPl6KN89QVW6FKFw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-bhnekf27POuif2veI-RXDA-1; Thu, 15 Jun 2023 08:38:35 -0400
X-MC-Unique: bhnekf27POuif2veI-RXDA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f0176dcc1eso454945e87.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jun 2023 05:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686832714; x=1689424714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LcUkEj3K+8Dv5U7WwMsL88tampUxF9GV0oDLpskuklQ=;
 b=AWuN1ya+VHPZghEnZGDGB+mX//3kdh2NJ88/+L/66ThdOFwfuiajkmF2IFQAIRjZG7
 BPnwpTkkltOunMRBtuDAh1dRoQs1XWkDlZvArnrBuSM6XL8ScLsV4k9Pn75O42rVzR5b
 pCOHmwWCV1Wo7SzDLTwtsuCVS8riRQjhPObPPIh+WrnU0CRoLhYOAM/CnWjVx3AD2lPO
 KUCmu4ImWgZ82YtnOJWuJYqsaz8yCYgua4EB9cgIVpnscOUBJ/yfASIAXIXIEnc38Q6/
 y6TPbN5aFREPHmY+2O1sY+eq0dRirTRj2pGuzuU9M/cXq4c/O+5vk0pSq3SnJZ7UIs+Z
 AqLA==
X-Gm-Message-State: AC+VfDxo5ZgJ9Bzm2+NyMGMAqwLVkZdUqekYDNFDtpyuDeEJ5ajSLs/4
 ZrC8uz6PaTcTD9Dj3Dl8sSjpTeW6Oybu3BDz+VSCPpjde1CqRItf3IB+GAnqLYvT/g3Fn+UClN5
 rI3LCpio2DwuTjpy6VFS36Rlw8dEAHGE=
X-Received: by 2002:a05:6512:b97:b0:4f0:3e1:9ada with SMTP id
 b23-20020a0565120b9700b004f003e19adamr1545596lfv.31.1686832714247; 
 Thu, 15 Jun 2023 05:38:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67H+jc7tZyA+D6PnIK5uex3pBcCXD5zI6IqUrqMsSJNFAJA8uGmy1Y7a4vbFIxj10kyn53hK/rhcvZ5NKInBI=
X-Received: by 2002:a05:6512:b97:b0:4f0:3e1:9ada with SMTP id
 b23-20020a0565120b9700b004f003e19adamr1545571lfv.31.1686832713886; Thu, 15
 Jun 2023 05:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230530144821.1557-1-avihaih@nvidia.com>
 <20230530144821.1557-2-avihaih@nvidia.com>
In-Reply-To: <20230530144821.1557-2-avihaih@nvidia.com>
From: YangHang Liu <yanghliu@redhat.com>
Date: Thu, 15 Jun 2023 20:38:22 +0800
Message-ID: <CAGYh1E97X85v+90B2G1q7DUaD=zS+5Jr+BPvLuh6p6PAoYUCLg@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] migration: Add switchover ack capability
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, 
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>, 
 Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=yanghliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Test in the following two scenarios:

[1]  Test scenario:  Both source VM and target VM (in listening mode)
have enabled return-path and switchover-ack capability:

Test result : The VFIO migration completed successfully

[2]  Test scenario :  The source VM has enabled return-path and
switchover-ack capability while the target VM (in listening mode) not

Test result : The VFIO migration fails

The detailed error thrown by qemu-kvm when VFIO migration fails:
    Target VM:
          0000:17:00.2: Received INIT_DATA_SENT but switchover ack is not u=
sed
          error while loading state section id 81(0000:00:02.4:00.0/vfio)
          load of migration failed: Invalid argument
    Source VM:
           failed to save SaveStateEntry with id(name): 2(ram): -5
           Unable to write to socket: Connection reset by peer
           Unable to write to socket: Connection reset by peer

Tested-by: YangHang Liu <yanghliu@redhat.com>




On Wed, May 31, 2023 at 1:46=E2=80=AFAM Avihai Horon <avihaih@nvidia.com> w=
rote:
>
> Migration downtime estimation is calculated based on bandwidth and
> remaining migration data. This assumes that loading of migration data in
> the destination takes a negligible amount of time and that downtime
> depends only on network speed.
>
> While this may be true for RAM, it's not necessarily true for other
> migrated devices. For example, loading the data of a VFIO device in the
> destination might require from the device to allocate resources, prepare
> internal data structures and so on. These operations can take a
> significant amount of time which can increase migration downtime.
>
> This patch adds a new capability "switchover ack" that prevents the
> source from stopping the VM and completing the migration until an ACK
> is received from the destination that it's OK to do so.
>
> This can be used by migrated devices in various ways to reduce downtime.
> For example, a device can send initial precopy metadata to pre-allocate
> resources in the destination and use this capability to make sure that
> the pre-allocation is completed before the source VM is stopped, so it
> will have full effect.
>
> This new capability relies on the return path capability to communicate
> from the destination back to the source.
>
> The actual implementation of the capability will be added in the
> following patches.
>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/migration.json | 12 +++++++++++-
>  migration/options.h |  1 +
>  migration/options.c | 21 +++++++++++++++++++++
>  3 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 179af0c4d8..061ea512e0 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -487,6 +487,16 @@
>  #     and should not affect the correctness of postcopy migration.
>  #     (since 7.1)
>  #
> +# @switchover-ack: If enabled, migration will not stop the source VM
> +#     and complete the migration until an ACK is received from the
> +#     destination that it's OK to do so.  Exactly when this ACK is
> +#     sent depends on the migrated devices that use this feature.
> +#     For example, a device can use it to make sure some of its data
> +#     is sent and loaded in the destination before doing switchover.
> +#     This can reduce downtime if devices that support this capability
> +#     are present.  'return-path' capability must be enabled to use
> +#     it.  (since 8.1)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> @@ -502,7 +512,7 @@
>             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
> -           'zero-copy-send', 'postcopy-preempt'] }
> +           'zero-copy-send', 'postcopy-preempt', 'switchover-ack'] }
>
>  ##
>  # @MigrationCapabilityStatus:
> diff --git a/migration/options.h b/migration/options.h
> index 45991af3c2..9aaf363322 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -40,6 +40,7 @@ bool migrate_postcopy_ram(void);
>  bool migrate_rdma_pin_all(void);
>  bool migrate_release_ram(void);
>  bool migrate_return_path(void);
> +bool migrate_switchover_ack(void);
>  bool migrate_validate_uuid(void);
>  bool migrate_xbzrle(void);
>  bool migrate_zero_blocks(void);
> diff --git a/migration/options.c b/migration/options.c
> index b62ab30cd5..16007afca6 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -185,6 +185,8 @@ Property migration_properties[] =3D {
>      DEFINE_PROP_MIG_CAP("x-zero-copy-send",
>              MIGRATION_CAPABILITY_ZERO_COPY_SEND),
>  #endif
> +    DEFINE_PROP_MIG_CAP("x-switchover-ack",
> +                        MIGRATION_CAPABILITY_SWITCHOVER_ACK),
>
>      DEFINE_PROP_END_OF_LIST(),
>  };
> @@ -308,6 +310,13 @@ bool migrate_return_path(void)
>      return s->capabilities[MIGRATION_CAPABILITY_RETURN_PATH];
>  }
>
> +bool migrate_switchover_ack(void)
> +{
> +    MigrationState *s =3D migrate_get_current();
> +
> +    return s->capabilities[MIGRATION_CAPABILITY_SWITCHOVER_ACK];
> +}
> +
>  bool migrate_validate_uuid(void)
>  {
>      MigrationState *s =3D migrate_get_current();
> @@ -547,6 +556,18 @@ bool migrate_caps_check(bool *old_caps, bool *new_ca=
ps, Error **errp)
>          }
>      }
>
> +    if (new_caps[MIGRATION_CAPABILITY_SWITCHOVER_ACK]) {
> +        if (!new_caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
> +            error_setg(errp, "Capability 'switchover-ack' requires capab=
ility "
> +                             "'return-path'");
> +            return false;
> +        }
> +
> +        /* Disable this capability until it's implemented */
> +        error_setg(errp, "'switchover-ack' is not implemented yet");
> +        return false;
> +    }
> +
>      return true;
>  }
>
> --
> 2.26.3
>
>


