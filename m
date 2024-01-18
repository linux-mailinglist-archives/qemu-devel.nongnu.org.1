Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5DE8311B9
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 04:21:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQIxK-0002Y8-Vj; Wed, 17 Jan 2024 22:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQIxI-0002Xi-J8
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:20:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQIxF-0000mZ-US
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705548032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/MPBbX2mb+Sg2L8yCmdEj3+raRDuc6gWlxM57pmZn40=;
 b=blkoizyICVHl33GFMpuK/LvaeL872A4O1vhLf4lc0+rfeMxrkCRbY32pmzJkyp4CtSkID/
 3vemmA/GaDO+lXgqO65fjPQqNJp5HSIdS5yu9u6IhI1eDiyNSSSZe1cvMrXuww4pphkQPB
 26leB8flAWNj85UUcuFOxI3oQHlwg4I=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-4jV6kzsKPNi6177zRajN3A-1; Wed, 17 Jan 2024 22:20:30 -0500
X-MC-Unique: 4jV6kzsKPNi6177zRajN3A-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6da4d130a82so2918669b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 19:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705548029; x=1706152829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MPBbX2mb+Sg2L8yCmdEj3+raRDuc6gWlxM57pmZn40=;
 b=wHfmVnkMYMExbmbUafx9gpFwhLOyi6Yl7Un5pmCdnI7hXXPyZJHiKJTKOxSPCCZdJB
 c0aK075m2jyKUlsRvRCo6EK15IvehqsiUqTbvJSLUbO4Or1mFra0skNHgLRP8xf9WkJ5
 cwwyHOjCdT1m8NC90wfUYwjeVdGxo0C6l2bqaiDrmwR3Nw5EVwBVL18xhupDoYyJL0a6
 xMqZsTnvCJnAw+q80Bs3mqiR+0Xlj4Kp+rr50GTQPzf0rrJpwK353pSf+CTztZLZAEuS
 mYUZ5BP4rxYY7FZT9FN5bU6K0u9BJGomDo1I6cAViSlXjcEFS2LZjRn/GfI4REKiAyGO
 shoA==
X-Gm-Message-State: AOJu0Yzp71yQvVmRu0TQ6K42nFD3YTkYRgyhbWsXNGnQUbC5Ztt5Jflf
 1ElxM9ibDokCZCLhtI96IehpmHCvCjN3xKYa8hUOmc6+BHNdwJwNIKqB9D6ObGXI9DFfqqsw/MR
 wCXDDyWFybt5olwc4oCBg9OE/go/tLoBG7VwZWFjJJuzwdPbt200u
X-Received: by 2002:a05:6a20:dd04:b0:19b:1d39:a535 with SMTP id
 kv4-20020a056a20dd0400b0019b1d39a535mr416076pzb.6.1705548029556; 
 Wed, 17 Jan 2024 19:20:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkjHXkLljJfNCCp6aorNvj2AiSEMW1C6o+Ck4sALynZpxVK2sb/Af5prOw76NVlwWFgBtxtA==
X-Received: by 2002:a05:6a20:dd04:b0:19b:1d39:a535 with SMTP id
 kv4-20020a056a20dd0400b0019b1d39a535mr416061pzb.6.1705548029101; 
 Wed, 17 Jan 2024 19:20:29 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 c13-20020aa781cd000000b006dba11a7e18sm1623737pfn.168.2024.01.17.19.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 19:20:28 -0800 (PST)
Date: Thu, 18 Jan 2024 11:20:23 +0800
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V2 11/11] vfio: allow cpr-reboot migration if suspended
Message-ID: <ZaiY99xrzuMvzdVo@x1n>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
 <1705071910-174321-12-git-send-email-steven.sistare@oracle.com>
 <ZaTfwOs2g_A4a1pO@x1n>
 <470484ea-ece5-4a73-b84a-eef98f84ed9b@oracle.com>
 <Zad91nqbaW2HizCo@x1n>
 <67b49892-f731-4ced-981f-6303a898ac9d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67b49892-f731-4ced-981f-6303a898ac9d@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

On Wed, Jan 17, 2024 at 04:30:48PM -0500, Steven Sistare wrote:
> On 1/17/2024 2:12 AM, Peter Xu wrote:
> > On Tue, Jan 16, 2024 at 03:37:33PM -0500, Steven Sistare wrote:
> >> On 1/15/2024 2:33 AM, Peter Xu wrote:
> >>> On Fri, Jan 12, 2024 at 07:05:10AM -0800, Steve Sistare wrote:
> >>>> Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
> >>>> guest drivers' suspend methods flush outstanding requests and re-initialize
> >>>> the devices, and thus there is no device state to save and restore.  The
> >>>> user is responsible for suspending the guest before initiating cpr, such as
> >>>> by issuing guest-suspend-ram to the qemu guest agent.
> >>>>
> >>>> Relax the vfio blocker so it does not apply to cpr, and add a notifier that
> >>>> verifies the guest is suspended.  Skip dirty page tracking, which is N/A for
> >>>> cpr, to avoid ioctl errors.
> >>>>
> >>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >>>> ---
> >>>>  hw/vfio/common.c              |  2 +-
> >>>>  hw/vfio/cpr.c                 | 20 ++++++++++++++++++++
> >>>>  hw/vfio/migration.c           |  2 +-
> >>>>  include/hw/vfio/vfio-common.h |  1 +
> >>>>  migration/ram.c               |  9 +++++----
> >>>>  5 files changed, 28 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> >>>> index 0b3352f..09af934 100644
> >>>> --- a/hw/vfio/common.c
> >>>> +++ b/hw/vfio/common.c
> >>>> @@ -128,7 +128,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
> >>>>      error_setg(&multiple_devices_migration_blocker,
> >>>>                 "Multiple VFIO devices migration is supported only if all of "
> >>>>                 "them support P2P migration");
> >>>> -    ret = migrate_add_blocker(&multiple_devices_migration_blocker, errp);
> >>>> +    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
> >>>>  
> >>>>      return ret;
> >>>>  }
> >>>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> >>>> index bbd1c7a..9f4b1fe 100644
> >>>> --- a/hw/vfio/cpr.c
> >>>> +++ b/hw/vfio/cpr.c
> >>>> @@ -7,13 +7,33 @@
> >>>>  
> >>>>  #include "qemu/osdep.h"
> >>>>  #include "hw/vfio/vfio-common.h"
> >>>> +#include "migration/misc.h"
> >>>>  #include "qapi/error.h"
> >>>> +#include "sysemu/runstate.h"
> >>>> +
> >>>> +static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
> >>>> +                                    MigrationEvent *e, Error **errp)
> >>>> +{
> >>>> +    if (e->state == MIGRATION_STATUS_SETUP &&
> >>>> +        !runstate_check(RUN_STATE_SUSPENDED)) {
> >>>> +
> >>>> +        error_setg(errp,
> >>>> +            "VFIO device only supports cpr-reboot for runstate suspended");
> >>>> +
> >>>> +        return -1;
> >>>> +    }
> >>>
> >>> What happens if the guest is suspended during SETUP, but then quickly waked
> >>> up before CPR migration completes?
> >>
> >> That is a management layer bug -- we told them the VM must be suspended.
> >> However, I will reject a wakeup request if migration is active and mode is cpr.
> > 
> > Yes it needs to be enforced if it is required by cpr-reboot.  QEMU
> > hopefully should never rely on mgmt app behavior.
> > 
> >>
> >>>> +    return 0;
> >>>> +}
> >>>>  
> >>>>  int vfio_cpr_register_container(VFIOContainer *container, Error **errp)
> >>>>  {
> >>>> +    migration_add_notifier_mode(&container->cpr_reboot_notifier,
> >>>> +                                vfio_cpr_reboot_notifier,
> >>>> +                                MIG_MODE_CPR_REBOOT);
> >>>>      return 0;
> >>>>  }
> >>>>  
> >>>>  void vfio_cpr_unregister_container(VFIOContainer *container)
> >>>>  {
> >>>> +    migration_remove_notifier(&container->cpr_reboot_notifier);
> >>>>  }
> >>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >>>> index 534fddf..488905d 100644
> >>>> --- a/hw/vfio/migration.c
> >>>> +++ b/hw/vfio/migration.c
> >>>> @@ -895,7 +895,7 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
> >>>>      vbasedev->migration_blocker = error_copy(err);
> >>>>      error_free(err);
> >>>>  
> >>>> -    return migrate_add_blocker(&vbasedev->migration_blocker, errp);
> >>>> +    return migrate_add_blocker_normal(&vbasedev->migration_blocker, errp);
> >>>>  }
> >>>>  
> >>>>  /* ---------------------------------------------------------------------- */
> >>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> >>>> index 1add5b7..7a46e24 100644
> >>>> --- a/include/hw/vfio/vfio-common.h
> >>>> +++ b/include/hw/vfio/vfio-common.h
> >>>> @@ -78,6 +78,7 @@ struct VFIOGroup;
> >>>>  typedef struct VFIOContainer {
> >>>>      VFIOContainerBase bcontainer;
> >>>>      int fd; /* /dev/vfio/vfio, empowered by the attached groups */
> >>>> +    NotifierWithReturn cpr_reboot_notifier;
> >>>>      unsigned iommu_type;
> >>>>      QLIST_HEAD(, VFIOGroup) group_list;
> >>>>  } VFIOContainer;
> >>>> diff --git a/migration/ram.c b/migration/ram.c
> >>>> index 1923366..44ad324 100644
> >>>> --- a/migration/ram.c
> >>>> +++ b/migration/ram.c
> >>>> @@ -2392,8 +2392,8 @@ static void ram_save_cleanup(void *opaque)
> >>>>      RAMState **rsp = opaque;
> >>>>      RAMBlock *block;
> >>>>  
> >>>> -    /* We don't use dirty log with background snapshots */
> >>>> -    if (!migrate_background_snapshot()) {
> >>>> +    /* We don't use dirty log with background snapshots or cpr */
> >>>> +    if (!migrate_background_snapshot() && migrate_mode() == MIG_MODE_NORMAL) {
> >>>
> >>> Same question here, on what happens if the user resumes the VM before
> >>> migration completes?  IIUC shared-ram is not required, then it means if
> >>> that happens the cpr migration image can contain corrupted data, and that
> >>> may be a problem.
> >>>
> >>> Background snapshot is special in that it relies on totally different
> >>> tracking facilities (userfault, rather than KVM_GET_DIRTY_LOG), so it
> >>> disabled dirty tracking completely.  I assume not the case for cpr.
> >>>
> >>> If cpr is not going to support that use case, IIUC it should fail that
> >>> system wakeup properly.  Or perhaps when CPR mode QEMU should instead
> >>> reject a wakeup?
> >>
> >> Good catch, this hunk would break the non-vfio case where the guest can be
> >> running when migration is initiated.  I should narrow the logic to check for
> >> that:
> >>
> >>     if (!migrate_background_snapshot() &&
> >>         (migrate_mode() == MIG_MODE_NORMAL || runstate_is_running()) {
> >>         ... use dirty logging ...
> >>
> >> That plus rejecting a wakeup request should be sufficient.
> > 
> > Sounds good.
> > 
> > Please also consider adding "VM suspended for the whole cpr-reboot
> > migration process" into the cpr-reboot mode qapi/ documentation as a
> > hard requirement.  I don't see that mentioned at all, then people will be
> > surprised to see a wakeup failure otherwise.
> 
> I will add something, but suspending is not always required:
>   * If the VM has vfio, then the user must suspend it before cpr-reboot
>   * If the VM does not have vfio, then the user does not need to suspend it.  

But you plan to unconditionally disable dirty tracking for cpr-reboot, am I
right?  If that's unconditional, we need to make it enforced in both codes
and document.

Dirty tracking is still essential if the VM is not suspended, or can be
waked up during migration, and when shared-mem-only is not enforced.

If you see this is why I had such feeling that the interfacing for
cpr-reboot is not clear (even if the major use case is), even to us
developers and reviewers, and then clear documentations will help.  That's
an issue at least to me.  We seem to have mixed up a few things.

For example, if we can have two hints (or capability/etc., just an idea to
show how we could have split those):

  - MIG_HINT_SUSPENDED: when set this flag, suspension is required during a
    live migration.  This will be required for VFIO live upgrades.  If this
    is set, start migration will check "suspended" state and fail
    otherwise.  Meanwhile if this is set system-wakeup is forbidden during
    migration.

    PS: this is pretty tricky because AFAICT we're relying on guest suspend
    behavior to make sure VFIO is stateless.. can a guest OS not obey that?
    Can it go into suspension with VFIO state kept?  I don't know.  But
    this is another story.  It just smells tricky because QEMU migration
    now relies on that guest behavior to be correct.

  - MIG_HINT_RAM_SHARED_PERSIST: when set this flag, writable memory must
    be shared and persisted even after QEMU quits.  We need this hint
    because that's a sign-off from the admin that we can ignore RAM during
    the migration.  This can already imply e.g. x-ignore-shared.

  - MIG_HINT_MIGRATE_TO_FILE: when this flag set, it guarantees VM migrates
    to the file and it'll be stopped later.  All the cpr-reboot blocker
    changes should only be relevant to this hint, e.g. VM that contains
    "qcow" block drive should be allowed for migration if this flag is set,
    even if it may not support a generic live migration for other reasons
    (which I actually am not clear..).  Also, when this flag is set, QEMU
    can stop the VM before migration starts, because we know tracking dirty
    is meaningless and the VM is destined to be stored in the file later.

Then it's clearer to know whether dirty tracking is needed:

  if (MIG_HINT_SUSPENDED || MIG_HINT_RAM_SHARED_PERSIST ||
      MIG_HINT_MIGRATE_TO_FILE || background_snspashot())
    // dirty tracking not needed
  else
    // dirty tracking needed

Also, if with above it can also help fixed-ram migration.  For example,
MIG_HINT_MIGRATE_TO_FILE is exactly what we used to discuss on the
"auto-pause", which is mentioned in the fixed-ram series:

https://lore.kernel.org/all/20231023203608.26370-1-farosas@suse.de/

Note that I'm not saying cpr-reboot should do like this, because I haven't
yet 100% think all through with the idea.  But I want to show the idea that
how such complicated feature can be split into multiple, with pretty clear
interface and even reuse-able outside this project (e.g. in fixed-ram
migration; currently fixed-ram migration always enable dirty-tracking
because it lacks that hint even if the admin knows it will destroy the VM
after migration).

>   * If the VM is suspended when cpr-reboot begins (regardless of whether it
>     has vfio or not), then wakeup is blocked until cpr-reboot finishes
> 
> > Frankly, every time I re-read the cpr-reboot description I get confused on
> > what is implied and enforced in this mode.  Can we provide an update?
> > 
> > # @cpr-reboot: The migrate command saves state to a file, allowing one to
> > #              quit qemu, reboot to an updated kernel, and restart an updated
> > #              version of qemu.  The caller must specify a migration URI
> > #              that writes to and reads from a file.  Unlike normal mode,
> > #              the use of certain local storage options does not block the
> > #              migration, but the caller must not modify guest block devices
> > #              between the quit and restart.  To avoid saving guest RAM to the
> > #              file, the memory backend must be shared, and the @x-ignore-shared
> > #              migration capability must be set.  Guest RAM must be non-volatile
> > #              across reboot, such as by backing it with a dax device, but this
> > #              is not enforced.  The restarted qemu arguments must match those
> > #              used to initially start qemu, plus the -incoming option.
> > #              (since 8.2)
> > 
> > For example, is shared-mem enfornced?  AFAIU it's not required for now, at
> > least I don't remember any code to stop cpr-reboot migration if there's
> > private memories.
> 
> shared-mem is not enforced or always required.
> *If* you want "To avoid saving guest RAM to the file", then
> "the memory backend must be shared".
> 
> If you are willing to incur the cost of saving RAM to the file, then shared-mem is 
> not required.

This can be one entry of the "Suggestions on cpr-reboot mode".

> 
> > What about the image location restriction on non-volatile?  Is it required?
> > IIUC "guest ram must be non-volatile across reboot" asks more than what we
> > need to document for cpr-reboot.  For example, can someone use cpr-reboot
> > to upgrade the userspace virt stack, but doesn't want to upgrade the
> > kernel?  Then I assume dax is not required, since anyone can use a
> > memory-based file (like shmem, hugetlbfs, or even guest_memfd in the future
> > of security contexts)?
> 
> "Guest RAM must be non-volatile *across reboot*".
> If you are not rebooting, it can be volatile.

Yet another entry of "Suggestions".

> 
> > I think it's okay to keep such descriptions, but the document (so far only
> > exists in qapi/migration.json) should clearly describe what must be done,
> 
> I believe I did so, perhaps too tersely, but I will expand it.

Maybe the current issue is it contains too much information, while many of
them can confuse the reader.

IMHO it'll be good to provide a summary paragraph on explaining what
cpr-reboot mode is, after reading this people should know whether they
should enable it.  Then for a richer document we can reference the docs/
link in qapi document if we want, or at least put details into separate
paragraphs.

> 
> > separated from what is suggested.  The current version is still unclear,
> > IMHO, and it'll be good to amend it when adding the hard requirement on
> > suspended mode.  AFAIU the suspended mode helps:
> > 
> >   (1) vfio devices all stateless (vfio use case specific)
> > 
> >   (2) no dirty tracking required (vfio + non-vfio use case, e.g., merely no
> >       restriction on what block type the VM uses)
> > 
> > Also, since we already have cpr-reboot mode merged, we need a solid
> > document file describing this feature.  Maybe "what is suggested" should be
> > put into that document instead, keeping the qapi document the essential
> > documents.  Above explanations can also be good material to be mentioned
> > there (if my understanding of why suspended is a hard requirement is
> > correct..).
> > 
> > For that, feel free to pull the lastest qemu master branch, then you can
> > create a file under docs/devel/migration/, possibly, cpr-reboot.rst, and
> > link that into the features.rst file.  Currently we lack of docs for
> > migration features, but we do have plan to enrich it to some degree soon:
> > 
> >   https://www.qemu.org/docs/master/devel/migration/features.html
> > 
> > So it would be good to have cpr-reboot since the 1st day the whole feature
> > is there.  The doc can be posted separately if you prefer, so I can merge
> > the doc series even sooner (one patch to update qapi/, one to add that file
> > to docs/, perhaps).  You can also maintain missing items as TODO in the
> > same .rst file, depending on how much work is still leftover, then remove
> > entries alongside of your patches merged, which I mostly suggested the same
> > to fixed-ram.
> 
> Sure, I will work on a doc.

Thanks a lot.

-- 
Peter Xu


