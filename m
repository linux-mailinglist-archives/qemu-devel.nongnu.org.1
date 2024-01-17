Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8404830062
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 08:13:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ06J-0007kT-Ck; Wed, 17 Jan 2024 02:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ06H-0007ja-8E
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:12:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ06E-0003Xg-SE
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705475552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=256m95EWWdo1O6ERR10BkQvssx6U4frD18coK9U6V+Q=;
 b=jOOZuZZkGxBMVI3OcpTjD+Ljq48tDe52/lvpBP+B411jFMJG5h0KMgf+iZaclXRDnEFBzv
 Vxmtpq4ZaTNZ5REO0In9Pnt0sbxQb/WkR7wm7sLHtQcu/h8c4a6w6sSadN9xkhOwI8m1Q2
 qEFI3cDzCZHKTXOhKxph5JqnYjnouAE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-wthEGoBwMieBm0r2n2z1Lg-1; Wed, 17 Jan 2024 02:12:31 -0500
X-MC-Unique: wthEGoBwMieBm0r2n2z1Lg-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6da5a9defd5so2916754b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 23:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705475550; x=1706080350;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=256m95EWWdo1O6ERR10BkQvssx6U4frD18coK9U6V+Q=;
 b=LblsKZzHMMkCDDbF5dmGzfNOSd85mcmFjTYCgiO9pA9FbwlAgy/0DSUM3ECAqbgdpB
 t9YqjPF4AkOwxcNfsGwb35IeT+qB9lMObEMFqaG6IYk33NprSiBZm/ial5skLV02DE9X
 gqeIzQ0KVCo5CUhNvX4NBS7JAuh+EZ90LFuL8jbVE6bb5Mp9khkjYr1SwccFjEEyL4Cg
 9RTKmKrLqSmC0LUBCicpR+mdhgDyoBlfA7sQwpPxrX2aYIV1VL0lFEOvyHumaBDu7Op/
 IHX7FagQ0lRP6Z19frbVL99hVjKtRQyX4WGL1OOUgOwlIIFsEoFuiCHNpFwmuDT0YzJu
 5upQ==
X-Gm-Message-State: AOJu0Yz0Q7L1XpJ9Iwj0SRInKofYJwBbiwNB40Xb/5O6h5GnDr9wT/GA
 9C1+dBbtNhW7GwyzLPJ0oZc0BjWq2on0iEDC1lhCAZmnNDTJzpfD5KBbIbmVH64qSC0dMjO94td
 ihYOmzrs4ge3NZagOgD6Yp5Q=
X-Received: by 2002:a05:6a20:9394:b0:19b:1d4a:b94c with SMTP id
 x20-20020a056a20939400b0019b1d4ab94cmr5689938pzh.2.1705475549876; 
 Tue, 16 Jan 2024 23:12:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCBkqvZFQaOVbGAsFIVTDkoGKBRGRxPGsVC1CdhwgnrDGoNO2wvrZ5HGzQCTupJqpK04ff3w==
X-Received: by 2002:a05:6a20:9394:b0:19b:1d4a:b94c with SMTP id
 x20-20020a056a20939400b0019b1d4ab94cmr5689917pzh.2.1705475549431; 
 Tue, 16 Jan 2024 23:12:29 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 rs3-20020a17090b2b8300b0028ceafb9124sm13019465pjb.51.2024.01.16.23.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:12:28 -0800 (PST)
Date: Wed, 17 Jan 2024 15:12:22 +0800
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V2 11/11] vfio: allow cpr-reboot migration if suspended
Message-ID: <Zad91nqbaW2HizCo@x1n>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
 <1705071910-174321-12-git-send-email-steven.sistare@oracle.com>
 <ZaTfwOs2g_A4a1pO@x1n>
 <470484ea-ece5-4a73-b84a-eef98f84ed9b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <470484ea-ece5-4a73-b84a-eef98f84ed9b@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

On Tue, Jan 16, 2024 at 03:37:33PM -0500, Steven Sistare wrote:
> On 1/15/2024 2:33 AM, Peter Xu wrote:
> > On Fri, Jan 12, 2024 at 07:05:10AM -0800, Steve Sistare wrote:
> >> Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
> >> guest drivers' suspend methods flush outstanding requests and re-initialize
> >> the devices, and thus there is no device state to save and restore.  The
> >> user is responsible for suspending the guest before initiating cpr, such as
> >> by issuing guest-suspend-ram to the qemu guest agent.
> >>
> >> Relax the vfio blocker so it does not apply to cpr, and add a notifier that
> >> verifies the guest is suspended.  Skip dirty page tracking, which is N/A for
> >> cpr, to avoid ioctl errors.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>  hw/vfio/common.c              |  2 +-
> >>  hw/vfio/cpr.c                 | 20 ++++++++++++++++++++
> >>  hw/vfio/migration.c           |  2 +-
> >>  include/hw/vfio/vfio-common.h |  1 +
> >>  migration/ram.c               |  9 +++++----
> >>  5 files changed, 28 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> >> index 0b3352f..09af934 100644
> >> --- a/hw/vfio/common.c
> >> +++ b/hw/vfio/common.c
> >> @@ -128,7 +128,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
> >>      error_setg(&multiple_devices_migration_blocker,
> >>                 "Multiple VFIO devices migration is supported only if all of "
> >>                 "them support P2P migration");
> >> -    ret = migrate_add_blocker(&multiple_devices_migration_blocker, errp);
> >> +    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
> >>  
> >>      return ret;
> >>  }
> >> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> >> index bbd1c7a..9f4b1fe 100644
> >> --- a/hw/vfio/cpr.c
> >> +++ b/hw/vfio/cpr.c
> >> @@ -7,13 +7,33 @@
> >>  
> >>  #include "qemu/osdep.h"
> >>  #include "hw/vfio/vfio-common.h"
> >> +#include "migration/misc.h"
> >>  #include "qapi/error.h"
> >> +#include "sysemu/runstate.h"
> >> +
> >> +static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
> >> +                                    MigrationEvent *e, Error **errp)
> >> +{
> >> +    if (e->state == MIGRATION_STATUS_SETUP &&
> >> +        !runstate_check(RUN_STATE_SUSPENDED)) {
> >> +
> >> +        error_setg(errp,
> >> +            "VFIO device only supports cpr-reboot for runstate suspended");
> >> +
> >> +        return -1;
> >> +    }
> > 
> > What happens if the guest is suspended during SETUP, but then quickly waked
> > up before CPR migration completes?
> 
> That is a management layer bug -- we told them the VM must be suspended.
> However, I will reject a wakeup request if migration is active and mode is cpr.

Yes it needs to be enforced if it is required by cpr-reboot.  QEMU
hopefully should never rely on mgmt app behavior.

> 
> >> +    return 0;
> >> +}
> >>  
> >>  int vfio_cpr_register_container(VFIOContainer *container, Error **errp)
> >>  {
> >> +    migration_add_notifier_mode(&container->cpr_reboot_notifier,
> >> +                                vfio_cpr_reboot_notifier,
> >> +                                MIG_MODE_CPR_REBOOT);
> >>      return 0;
> >>  }
> >>  
> >>  void vfio_cpr_unregister_container(VFIOContainer *container)
> >>  {
> >> +    migration_remove_notifier(&container->cpr_reboot_notifier);
> >>  }
> >> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >> index 534fddf..488905d 100644
> >> --- a/hw/vfio/migration.c
> >> +++ b/hw/vfio/migration.c
> >> @@ -895,7 +895,7 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
> >>      vbasedev->migration_blocker = error_copy(err);
> >>      error_free(err);
> >>  
> >> -    return migrate_add_blocker(&vbasedev->migration_blocker, errp);
> >> +    return migrate_add_blocker_normal(&vbasedev->migration_blocker, errp);
> >>  }
> >>  
> >>  /* ---------------------------------------------------------------------- */
> >> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> >> index 1add5b7..7a46e24 100644
> >> --- a/include/hw/vfio/vfio-common.h
> >> +++ b/include/hw/vfio/vfio-common.h
> >> @@ -78,6 +78,7 @@ struct VFIOGroup;
> >>  typedef struct VFIOContainer {
> >>      VFIOContainerBase bcontainer;
> >>      int fd; /* /dev/vfio/vfio, empowered by the attached groups */
> >> +    NotifierWithReturn cpr_reboot_notifier;
> >>      unsigned iommu_type;
> >>      QLIST_HEAD(, VFIOGroup) group_list;
> >>  } VFIOContainer;
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index 1923366..44ad324 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -2392,8 +2392,8 @@ static void ram_save_cleanup(void *opaque)
> >>      RAMState **rsp = opaque;
> >>      RAMBlock *block;
> >>  
> >> -    /* We don't use dirty log with background snapshots */
> >> -    if (!migrate_background_snapshot()) {
> >> +    /* We don't use dirty log with background snapshots or cpr */
> >> +    if (!migrate_background_snapshot() && migrate_mode() == MIG_MODE_NORMAL) {
> > 
> > Same question here, on what happens if the user resumes the VM before
> > migration completes?  IIUC shared-ram is not required, then it means if
> > that happens the cpr migration image can contain corrupted data, and that
> > may be a problem.
> > 
> > Background snapshot is special in that it relies on totally different
> > tracking facilities (userfault, rather than KVM_GET_DIRTY_LOG), so it
> > disabled dirty tracking completely.  I assume not the case for cpr.
> > 
> > If cpr is not going to support that use case, IIUC it should fail that
> > system wakeup properly.  Or perhaps when CPR mode QEMU should instead
> > reject a wakeup?
> 
> Good catch, this hunk would break the non-vfio case where the guest can be
> running when migration is initiated.  I should narrow the logic to check for
> that:
> 
>     if (!migrate_background_snapshot() &&
>         (migrate_mode() == MIG_MODE_NORMAL || runstate_is_running()) {
>         ... use dirty logging ...
> 
> That plus rejecting a wakeup request should be sufficient.

Sounds good.

Please also consider adding "VM suspended for the whole cpr-reboot
migration process" into the cpr-reboot mode qapi/ documentation as a
hard requirement.  I don't see that mentioned at all, then people will be
surprised to see a wakeup failure otherwise.

Frankly, every time I re-read the cpr-reboot description I get confused on
what is implied and enforced in this mode.  Can we provide an update?

# @cpr-reboot: The migrate command saves state to a file, allowing one to
#              quit qemu, reboot to an updated kernel, and restart an updated
#              version of qemu.  The caller must specify a migration URI
#              that writes to and reads from a file.  Unlike normal mode,
#              the use of certain local storage options does not block the
#              migration, but the caller must not modify guest block devices
#              between the quit and restart.  To avoid saving guest RAM to the
#              file, the memory backend must be shared, and the @x-ignore-shared
#              migration capability must be set.  Guest RAM must be non-volatile
#              across reboot, such as by backing it with a dax device, but this
#              is not enforced.  The restarted qemu arguments must match those
#              used to initially start qemu, plus the -incoming option.
#              (since 8.2)

For example, is shared-mem enfornced?  AFAIU it's not required for now, at
least I don't remember any code to stop cpr-reboot migration if there's
private memories.

What about the image location restriction on non-volatile?  Is it required?
IIUC "guest ram must be non-volatile across reboot" asks more than what we
need to document for cpr-reboot.  For example, can someone use cpr-reboot
to upgrade the userspace virt stack, but doesn't want to upgrade the
kernel?  Then I assume dax is not required, since anyone can use a
memory-based file (like shmem, hugetlbfs, or even guest_memfd in the future
of security contexts)?

I think it's okay to keep such descriptions, but the document (so far only
exists in qapi/migration.json) should clearly describe what must be done,
separated from what is suggested.  The current version is still unclear,
IMHO, and it'll be good to amend it when adding the hard requirement on
suspended mode.  AFAIU the suspended mode helps:

  (1) vfio devices all stateless (vfio use case specific)

  (2) no dirty tracking required (vfio + non-vfio use case, e.g., merely no
      restriction on what block type the VM uses)

Also, since we already have cpr-reboot mode merged, we need a solid
document file describing this feature.  Maybe "what is suggested" should be
put into that document instead, keeping the qapi document the essential
documents.  Above explanations can also be good material to be mentioned
there (if my understanding of why suspended is a hard requirement is
correct..).

For that, feel free to pull the lastest qemu master branch, then you can
create a file under docs/devel/migration/, possibly, cpr-reboot.rst, and
link that into the features.rst file.  Currently we lack of docs for
migration features, but we do have plan to enrich it to some degree soon:

  https://www.qemu.org/docs/master/devel/migration/features.html

So it would be good to have cpr-reboot since the 1st day the whole feature
is there.  The doc can be posted separately if you prefer, so I can merge
the doc series even sooner (one patch to update qapi/, one to add that file
to docs/, perhaps).  You can also maintain missing items as TODO in the
same .rst file, depending on how much work is still leftover, then remove
entries alongside of your patches merged, which I mostly suggested the same
to fixed-ram.

Thanks,

-- 
Peter Xu


