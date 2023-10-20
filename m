Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A61F7D0AFD
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 10:59:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtlKT-0001m7-CC; Fri, 20 Oct 2023 04:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlKO-0001lP-Ef
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlKM-0002H4-4B
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697792273;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=z91of7EUqtBkze7i5FpmXticuTy9uw+cJIt4LzsJFmI=;
 b=C1lDtETRf/lWMaX1fyIqLQDuUXq9tv9ln7eRhwK0AXpYuR7UBLT34x/RER02cP8+wah3Xh
 53cGOE875ODqeQhN5m4TaZnCRUCydg11euKU4QjrwIAJZABuyeRa2nBES7g6sadHn8MH7Z
 HlPuots6WdT6OHuT2DHJhMQr4BE/Vtk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-ouHuzTJUMWuqxpGd2SDIIw-1; Fri, 20 Oct 2023 04:57:51 -0400
X-MC-Unique: ouHuzTJUMWuqxpGd2SDIIw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-408524e2368so1545035e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 01:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697792271; x=1698397071;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z91of7EUqtBkze7i5FpmXticuTy9uw+cJIt4LzsJFmI=;
 b=pEYQ9imrOy4fr5iBhtNrn69mm7LC1IR5FvTfS/Wds8k3JzWYozy66LctuQdiLefIo7
 mQaBvmtFHimVO3ZbzCxpgPryERDoCNpi/RFsLHtbJUWhtEun3jVNXJhxRLOakdYp0DQZ
 bqYpOzG83FIFOrgG+Rw32yy46qftFW2Io4rYR7gtsnrU9R6+u5DGRTYJLJIw3FV7S5Ra
 +fTOR9WxezUF5wJ4hK5BQzJq+dj0OT3RhaJUcguSDZt81E7CqQ3+/4AEDdqLBKM6IrXS
 6scnQY7YAhES9nSpOm+2RNsd4MNi6uSh3IbffWIZkRKHhANEPMsvbgMTFIBbIORUWT2T
 wtxQ==
X-Gm-Message-State: AOJu0Yyq8jb9mAGBxnT4dY1RbvbWKdnTKv7bmGTg41TIizV/yVfH/2hn
 jIYMMaoPb1T5Wvv9y1WqCWMQyrdTgqnzNAsL2/2iEmP6IhXdZE3O1Y/TFca0y9O6NKvwBJzTzqd
 Cn/vlM9mGPsA8EGQ=
X-Received: by 2002:a05:600c:15c1:b0:3fc:dd9:91fd with SMTP id
 v1-20020a05600c15c100b003fc0dd991fdmr858076wmf.40.1697792270717; 
 Fri, 20 Oct 2023 01:57:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDNj8LDfWUrhJ0bovjYZnfgTqtesKQFSVMns1MytPijiyFmuTiSFxN+YDPut4t8kCwPq0aLQ==
X-Received: by 2002:a05:600c:15c1:b0:3fc:dd9:91fd with SMTP id
 v1-20020a05600c15c100b003fc0dd991fdmr858061wmf.40.1697792270328; 
 Fri, 20 Oct 2023 01:57:50 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c12d500b004081a011c0esm6322011wmd.12.2023.10.20.01.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 01:57:49 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Greg Kurz <groug@kaod.org>
Cc: <qemu-devel@nongnu.org>,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  <qemu-ppc@nongnu.org>,
 Nicholas Piggin <npiggin@gmail.com>,  <qemu-s390x@nongnu.org>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Corey Minyard <cminyard@mvista.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Hildenbrand <david@redhat.com>,
 "Ilya Leoshkevich" <iii@linux.ibm.com>,  Fabiano Rosas <farosas@suse.de>,
 "Eric Farman" <farman@linux.ibm.com>,  Peter Xu <peterx@redhat.com>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>,  John Snow
 <jsnow@redhat.com>,  <qemu-block@nongnu.org>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Stefan Weil <sw@weilnetz.de>,
 <qemu-arm@nongnu.org>,  Jason Wang <jasowang@redhat.com>,  Corey Minyard
 <minyard@acm.org>,  Leonardo Bras <leobras@redhat.com>,  "Thomas Huth"
 <thuth@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,  David
 Gibson <david@gibson.dropbear.id.au>,  Halil Pasic <pasic@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 07/13] RFC migration: icp/server is a mess
In-Reply-To: <20231020100626.57debfa4@bahia> (Greg Kurz's message of "Fri, 20
 Oct 2023 10:06:26 +0200")
References: <20231019190831.20363-1-quintela@redhat.com>
 <20231019190831.20363-8-quintela@redhat.com>
 <20231019233958.17abb488@bahia> <875y313g4b.fsf@secure.mitica>
 <20231020100626.57debfa4@bahia>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 10:57:49 +0200
Message-ID: <87fs251xiq.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Greg Kurz <groug@kaod.org> wrote:
> On Fri, 20 Oct 2023 09:30:44 +0200
> Juan Quintela <quintela@redhat.com> wrote:
>
>> Greg Kurz <groug@kaod.org> wrote:
>> > On Thu, 19 Oct 2023 21:08:25 +0200
>> > Juan Quintela <quintela@redhat.com> wrote:
>> >
>> >> Current code does:
>> >> - register pre_2_10_vmstate_dummy_icp with "icp/server" and instance
>> >>   dependinfg on cpu number
>> >> - for newer machines, it register vmstate_icp with "icp/server" name
>> >>   and instance 0
>> >> - now it unregisters "icp/server" for the 1st instance.
>> >> 
>> >> This is wrong at many levels:
>> >> - we shouldn't have two VMSTATEDescriptions with the same name
>> >> - In case this is the only solution that we can came with, it needs to
>> >>   be:
>> >>   * register pre_2_10_vmstate_dummy_icp
>> >>   * unregister pre_2_10_vmstate_dummy_icp
>> >>   * register real vmstate_icp
>> >> 
>> >> As the initialization of this machine is already complex enough, I
>> >> need help from PPC maintainers to fix this.
>> >> 
>> >> Volunteers?
>> >> 
>> >> CC: Cedric Le Goater <clg@kaod.org>
>> >> CC: Daniel Henrique Barboza <danielhb413@gmail.com>
>> >> CC: David Gibson <david@gibson.dropbear.id.au>
>> >> CC: Greg Kurz <groug@kaod.org>
>> >> 
>> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> >> ---
>> >>  hw/ppc/spapr.c | 7 ++++++-
>> >>  1 file changed, 6 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> >> index cb840676d3..8531d13492 100644
>> >> --- a/hw/ppc/spapr.c
>> >> +++ b/hw/ppc/spapr.c
>> >> @@ -143,7 +143,12 @@ static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
>> >>  }
>> >>  
>> >>  static const VMStateDescription pre_2_10_vmstate_dummy_icp = {
>> >> -    .name = "icp/server",
>> >> +    /*
>> >> +     * Hack ahead.  We can't have two devices with the same name and
>> >> +     * instance id.  So I rename this to pass make check.
>> >> +     * Real help from people who knows the hardware is needed.
>> >> +     */
>> >> +    .name = "pre-2.10-icp/server",
>> >>      .version_id = 1,
>> >>      .minimum_version_id = 1,
>> >>      .needed = pre_2_10_vmstate_dummy_icp_needed,
>> >
>> > I guess this fix is acceptable as well and a lot simpler than
>> > reverting the hack actually. Outcome is the same : drop
>> > compat with pseries-2.9 and older.
>> >
>> > Reviewed-by: Greg Kurz <groug@kaod.org>
>> 
>> I fully agree with you here.
>> The other options given on this thread is deprecate that machines, but I
>> would like to have this series sooner than 2 releases.
>
> Yeah and, especially, the deprecation of all these machine types is
> itself a massive chunk of work as it will call to identify and
> remove other related workarounds as well. Given that pretty much
> everyone working in PPC/PAPR moved away, can the community handle
> such a big change ?
>
>>  And what ppc is
>> doing here is (and has always been) a hack and an abuse about how
>> vmstate registrations is supposed to work.
>> 
>
> Sorry again... We should have involved migration experts at the time. :-)

I would have told you that this can't be done O:-)

Sent another version with a vmstate hack to accomodate this.  You don't
have to deprecate the machines due to migration O:-)

And now that I have ppc gurus attention, could you comment in the other
question:

./hw/ppc/spapr_iommu.c

static void spapr_tce_table_realize(DeviceState *dev, Error **errp)
{
    ...
    vmstate_register(VMSTATE_IF(tcet), tcet->liobn, &vmstate_spapr_tce_table,
                     tcet);
}

./include/hw/ppc/spapr.h

struct SpaprTceTable {
    ...
    uint32_t liobn;
    ....
};

./include/migration.h

static inline int vmstate_register(VMStateIf *obj, int instance_id,
                                   const VMStateDescription *vmsd,
                                   void *opaque);


liobn is an uint32_t and insntance_id is an int.

For this series, I started with this:

static inline int vmstate_register(VMStateIf *obj, int instance_id,
                                   const VMStateDescription *vmsd,
                                   void *opaque)
{
    if (instance_id < 0) {
        error_report("vmstate_register: Invalid device: %s instance_id: %d",
                     vmsd->name, instance_id);
        return -1;
    }
    return vmstate_register_with_alias_id(obj, instance_id, vmsd,
                                          opaque, -1, 0, NULL);
}

And it failed on this.  So I change the test to

    if (instance_id == VM_INSTANCE_ID_ANY) {
       ....
    }

But we are still having troubles with signs here.

Posible actions:
- Look the other side and hope that liobn is never -1.
  (if it is -1, it would become 0, so not really a big trouble).
- change vmstate type to uint32_t and make VM_INSTANCE_ID_ANY to UINT32_MAX
  (exact same problem if liobn happens to be UINT32_MAX)

I have no clue what are the valid values of liobn.  So I am leaning to
just look the other way and do nothing.

Advise?

Thanks, Juan.




