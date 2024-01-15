Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7206182D4A1
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 08:34:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPHTe-0000Dk-Pq; Mon, 15 Jan 2024 02:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPHTV-00006Q-RZ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 02:33:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPHTU-0000tp-3L
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 02:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705304015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9OFG+Yt1tUzTZHOZMVW94eS1+ust1Gha+gykjNkNBmM=;
 b=BE4X1viKU37znNwFVphrInub1LDqcAKHgVLu1tM3QDBKH9L4Dn5yiHDm+fvLMzN6Wv0O6S
 39lQSoVIiZJqxGjbwSulbjrlsiDaTtXpQpKJirIsyY8BfBaoUlbFa6CMpGjhNn4cNIBFFA
 7WiGdVyh6NoSy2IBeXHQYtIjV4eVv3E=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-mhxbbuCVNa2556UW2y0k3Q-1; Mon, 15 Jan 2024 02:33:33 -0500
X-MC-Unique: mhxbbuCVNa2556UW2y0k3Q-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5987dd9cb9aso1058656eaf.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 23:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705304012; x=1705908812;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OFG+Yt1tUzTZHOZMVW94eS1+ust1Gha+gykjNkNBmM=;
 b=jnxfDhytzGdxNwM0dysuaTxhkiZ9ysdrNp0PXuO9YHHBlvvfUGDat+NTIxtq/gBb2y
 NLoiGInxUbLBazSigNuy++BvS3yjpLSX1QlrkXBA2ZqQFJEfJjbPCMgGbMC+3BFuO3L9
 fkRmNrmw/EueIho2bC5eFTGpVbH+nafPIv1Cg7NQfTvcgqXJctAmaeubt7Osf4lLjVjT
 3Qa9t0VYXXS99GGXBHAJzP2gqXY8wabY3qZu+7getlsDlXi4ukGUPxZp4602ujtWx4yM
 FZYBZjXYIHwy73HmnLmxfPGqi5S6tgig0wgtUUCCK8IqqOcuZ91ckmHUlfKZ8oBm3Ky+
 XINg==
X-Gm-Message-State: AOJu0YxLBf5DyhA3MTmocrTssUqcLdYj7mz3AEJ8jcsTTXmmZDwoG8+e
 ECVwav0oE3ODHrBO0Py+vEfW+h7p9oKywnHcHUzZOkbmvP0fb5DM56f+1BlDuA/z+yPzD2fTVgX
 Ub9YQeBlsduqD43erV3i5m1w=
X-Received: by 2002:a05:6359:45a4:b0:175:e361:8849 with SMTP id
 no36-20020a05635945a400b00175e3618849mr2975485rwb.1.1705304012456; 
 Sun, 14 Jan 2024 23:33:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHr9zASNkIAZpTSou26LrPHJDbRJdWwdM/BJ5EpP5/1J1e3n7p8Lx+NrT44vUcjnek7IbnMXw==
X-Received: by 2002:a05:6359:45a4:b0:175:e361:8849 with SMTP id
 no36-20020a05635945a400b00175e3618849mr2975471rwb.1.1705304012067; 
 Sun, 14 Jan 2024 23:33:32 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 t126-20020a625f84000000b006d9b93ca5e2sm7581582pfb.146.2024.01.14.23.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 23:33:31 -0800 (PST)
Date: Mon, 15 Jan 2024 15:33:20 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V2 11/11] vfio: allow cpr-reboot migration if suspended
Message-ID: <ZaTfwOs2g_A4a1pO@x1n>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
 <1705071910-174321-12-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1705071910-174321-12-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Fri, Jan 12, 2024 at 07:05:10AM -0800, Steve Sistare wrote:
> Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
> guest drivers' suspend methods flush outstanding requests and re-initialize
> the devices, and thus there is no device state to save and restore.  The
> user is responsible for suspending the guest before initiating cpr, such as
> by issuing guest-suspend-ram to the qemu guest agent.
> 
> Relax the vfio blocker so it does not apply to cpr, and add a notifier that
> verifies the guest is suspended.  Skip dirty page tracking, which is N/A for
> cpr, to avoid ioctl errors.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  hw/vfio/common.c              |  2 +-
>  hw/vfio/cpr.c                 | 20 ++++++++++++++++++++
>  hw/vfio/migration.c           |  2 +-
>  include/hw/vfio/vfio-common.h |  1 +
>  migration/ram.c               |  9 +++++----
>  5 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 0b3352f..09af934 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -128,7 +128,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>      error_setg(&multiple_devices_migration_blocker,
>                 "Multiple VFIO devices migration is supported only if all of "
>                 "them support P2P migration");
> -    ret = migrate_add_blocker(&multiple_devices_migration_blocker, errp);
> +    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
>  
>      return ret;
>  }
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index bbd1c7a..9f4b1fe 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -7,13 +7,33 @@
>  
>  #include "qemu/osdep.h"
>  #include "hw/vfio/vfio-common.h"
> +#include "migration/misc.h"
>  #include "qapi/error.h"
> +#include "sysemu/runstate.h"
> +
> +static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
> +                                    MigrationEvent *e, Error **errp)
> +{
> +    if (e->state == MIGRATION_STATUS_SETUP &&
> +        !runstate_check(RUN_STATE_SUSPENDED)) {
> +
> +        error_setg(errp,
> +            "VFIO device only supports cpr-reboot for runstate suspended");
> +
> +        return -1;
> +    }

What happens if the guest is suspended during SETUP, but then quickly waked
up before CPR migration completes?

> +    return 0;
> +}
>  
>  int vfio_cpr_register_container(VFIOContainer *container, Error **errp)
>  {
> +    migration_add_notifier_mode(&container->cpr_reboot_notifier,
> +                                vfio_cpr_reboot_notifier,
> +                                MIG_MODE_CPR_REBOOT);
>      return 0;
>  }
>  
>  void vfio_cpr_unregister_container(VFIOContainer *container)
>  {
> +    migration_remove_notifier(&container->cpr_reboot_notifier);
>  }
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 534fddf..488905d 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -895,7 +895,7 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>      vbasedev->migration_blocker = error_copy(err);
>      error_free(err);
>  
> -    return migrate_add_blocker(&vbasedev->migration_blocker, errp);
> +    return migrate_add_blocker_normal(&vbasedev->migration_blocker, errp);
>  }
>  
>  /* ---------------------------------------------------------------------- */
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 1add5b7..7a46e24 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -78,6 +78,7 @@ struct VFIOGroup;
>  typedef struct VFIOContainer {
>      VFIOContainerBase bcontainer;
>      int fd; /* /dev/vfio/vfio, empowered by the attached groups */
> +    NotifierWithReturn cpr_reboot_notifier;
>      unsigned iommu_type;
>      QLIST_HEAD(, VFIOGroup) group_list;
>  } VFIOContainer;
> diff --git a/migration/ram.c b/migration/ram.c
> index 1923366..44ad324 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2392,8 +2392,8 @@ static void ram_save_cleanup(void *opaque)
>      RAMState **rsp = opaque;
>      RAMBlock *block;
>  
> -    /* We don't use dirty log with background snapshots */
> -    if (!migrate_background_snapshot()) {
> +    /* We don't use dirty log with background snapshots or cpr */
> +    if (!migrate_background_snapshot() && migrate_mode() == MIG_MODE_NORMAL) {

Same question here, on what happens if the user resumes the VM before
migration completes?  IIUC shared-ram is not required, then it means if
that happens the cpr migration image can contain corrupted data, and that
may be a problem.

Background snapshot is special in that it relies on totally different
tracking facilities (userfault, rather than KVM_GET_DIRTY_LOG), so it
disabled dirty tracking completely.  I assume not the case for cpr.

If cpr is not going to support that use case, IIUC it should fail that
system wakeup properly.  Or perhaps when CPR mode QEMU should instead
reject a wakeup?

>          /* caller have hold BQL or is in a bh, so there is
>           * no writing race against the migration bitmap
>           */
> @@ -2804,8 +2804,9 @@ static void ram_init_bitmaps(RAMState *rs)
>  
>      WITH_RCU_READ_LOCK_GUARD() {
>          ram_list_init_bitmaps();
> -        /* We don't use dirty log with background snapshots */
> -        if (!migrate_background_snapshot()) {
> +        /* We don't use dirty log with background snapshots or cpr */
> +        if (!migrate_background_snapshot() &&
> +            migrate_mode() == MIG_MODE_NORMAL) {
>              memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
>              migration_bitmap_sync_precopy(rs, false);
>          }
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


