Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C79578D67B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:22:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbM5T-0004TR-3L; Wed, 30 Aug 2023 10:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbM5O-0004TA-Vs
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbM5M-0001Tp-Ak
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693405338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8AiXcSFRTAIoI15L+m529ZOvwi/CyZp9Zn19aIsudh4=;
 b=KcfylMjypOtCwa37OIRGUdim7LhUVdd67mQo1USRmHrwlEMxbzcov5Si1dmRfESLZUZ3pH
 8mbMNCDLpRsBbxuSACVNitDrfDbzo63a64k1rvPkj9b8/fW157s/F6hj3UOR3G+FATuqnJ
 zrci+01OjImlezIWs0MovTF88WiqiTM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-Vx1dZ1UuOTuClOYc9V3kMw-1; Wed, 30 Aug 2023 10:22:16 -0400
X-MC-Unique: Vx1dZ1UuOTuClOYc9V3kMw-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5818aba723eso13583127b3.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693405336; x=1694010136;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8AiXcSFRTAIoI15L+m529ZOvwi/CyZp9Zn19aIsudh4=;
 b=T/wEEfa/njxKr35J17U0zdvIKCgD2BIgnRpfm/eFdJ0oXX8439x2V738yEu9zOKUOU
 zpWNqKIYJaDtjaFqOhKb7ia1361LkUXaN9HVzrbzUy3EsgkWecey7kgOuoLL0PcMHaJG
 cZCpOmKA0VISFTc2gRCggSsh7YyY0fo6t31gbF028d86ArED3UCLf/cDDY61uYK3XwaM
 pt7V/CFnsQO67pgGmraL5ml/xUDWm3nI8ybxeku1WimY+StBlWulC68gCaM54u1LlkQa
 cVSts44W5RUgP7R36rwUiWFFEo7UwhSwr9gsgaCINZPQ2FD858J420ZrX0gtyTe+KZ24
 HO6w==
X-Gm-Message-State: AOJu0Yx9zTL8MZ4PJsOk6G3rfJELTT7/SLmKTXcz4iAcF8swkVHvJnHG
 tDRpuRvDasmWsea23phbrU3MkcKHQdaE36rmTh+CRtcvdmXZfDt2yULvZUZjatjEQDI6cNJf/1Y
 vhL9D/uhKBYA5HrI=
X-Received: by 2002:a81:8494:0:b0:573:2346:ea55 with SMTP id
 u142-20020a818494000000b005732346ea55mr1620121ywf.2.1693405336171; 
 Wed, 30 Aug 2023 07:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj4SZri5jffgJicr+KbgQ60JQj2VzsbMdQrM2mjvZgyoONo2glfxQi7TwgGgHKRDhK0/6yeA==
X-Received: by 2002:a81:8494:0:b0:573:2346:ea55 with SMTP id
 u142-20020a818494000000b005732346ea55mr1620104ywf.2.1693405335682; 
 Wed, 30 Aug 2023 07:22:15 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h23-20020ac85057000000b00406b11a54b8sm3737327qtm.7.2023.08.30.07.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:22:15 -0700 (PDT)
Date: Wed, 30 Aug 2023 10:22:07 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
Subject: Re: [PATCH 5/6] vfio/migration: Block VFIO migration with postcopy
 migration
Message-ID: <ZO9Qj/tbHqZ/h34z@x1n>
References: <20230828151842.11303-6-avihaih@nvidia.com> <ZO4GTnuqSORbvePL@x1n>
 <b54f3ca5-9236-84a8-1b1f-9365925fa458@nvidia.com>
 <ZO44klknC6hpd7mf@x1n>
 <adb00739-3074-dc16-bb24-1e42cbbdd50a@nvidia.com>
 <b900cc98-49fe-219b-4be0-a4b8eb36e1a4@redhat.com>
 <e3d3b6f8-2877-620e-66eb-6d3a53d65bc6@nvidia.com>
 <d036904b-6106-2cfd-6533-70f0f70fea2f@redhat.com>
 <2ce812f6-3372-fd3d-b0f3-46f12a9dc64c@nvidia.com>
 <95a37158-3ded-3930-ebf9-e33df4416cec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95a37158-3ded-3930-ebf9-e33df4416cec@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Aug 30, 2023 at 01:17:55PM +0200, Cédric Le Goater wrote:
> On 8/30/23 12:12, Avihai Horon wrote:
> > 
> > On 30/08/2023 12:53, Cédric Le Goater wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On 8/30/23 11:21, Avihai Horon wrote:
> > > > 
> > > > On 30/08/2023 11:37, Cédric Le Goater wrote:
> > > > > External email: Use caution opening links or attachments
> > > > > 
> > > > > 
> > > > > On 8/30/23 09:01, Avihai Horon wrote:
> > > > > > 
> > > > > > On 29/08/2023 21:27, Peter Xu wrote:
> > > > > > > External email: Use caution opening links or attachments
> > > > > > > 
> > > > > > > 
> > > > > > > On Tue, Aug 29, 2023 at 07:20:47PM +0300, Avihai Horon wrote:
> > > > > > > > On 29/08/2023 17:53, Peter Xu wrote:
> > > > > > > > > External email: Use caution opening links or attachments
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > On Mon, Aug 28, 2023 at 06:18:41PM +0300, Avihai Horon wrote:
> > > > > > > > > > diff --git a/migration/options.c b/migration/options.c
> > > > > > > > > > index 1d1e1321b0..e201053563 100644
> > > > > > > > > > --- a/migration/options.c
> > > > > > > > > > +++ b/migration/options.c
> > > > > > > > > > @@ -499,6 +499,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
> > > > > > > > > >                error_setg(errp, "Postcopy is not yet compatible with multifd");
> > > > > > > > > >                return false;
> > > > > > > > > >            }
> > > > > > > > > > +
> > > > > > > > > > +        if (migration_vfio_mig_active()) {
> > > > > > > > > > +            error_setg(errp, "Postcopy is not compatible with VFIO migration");
> > > > > > > > > > +            return false;
> > > > > > > > > > +        }
> > > > > > > > > Hmm.. this will add yet another vfio hard-coded line into migration/..
> > > > > > > > > 
> > > > > > > > > What will happen if the vfio device is hot plugged after enabling
> > > > > > > > > postcopy-ram here?
> > > > > > > > In that case a migration blocker will be added.
> > > > > > > > 
> > > > > > > > > Is it possible to do it in a generic way?
> > > > > > > > What comes to my mind is to let devices register a handler for a "caps
> > > > > > > > change" notification and allow them to object.
> > > > > > > > But maybe that's a bit of an overkill.
> > > > > > > This one also sounds better than hard-codes to me.
> > > > > > > 
> > > > > > > > > I was thinking the only unified place to do such check is when migration
> > > > > > > > > starts, as long as we switch to SETUP all caps are locked and doesn't allow
> > > > > > > > > any change until it finishes or fails.
> > > > > > > > > 
> > > > > > > > > So, can we do this check inside vfio_save_setup(), allow vfio_save_setup()
> > > > > > > > > to fail the whole migration early?  For example, maybe we should have an
> > > > > > > > > Error** passed in, then if it fails it calls migrate_set_error, so
> > > > > > > > > reflected in query-migrate later too.
> > > > > > > > Yes, I think this could work and it will simplify things because we could
> > > > > > > > also drop the VFIO migration blockers code.
> > > > > > > > The downside is that the user will know migration is blocked only when he
> > > > > > > > tries to migrate, and migrate_caps_check() will not block setting postcopy
> > > > > > > > when a VFIO device is already attached.
> > > > > > > > I don't have a strong opinion here, so if it's fine by you and everyone
> > > > > > > > else, I could change that to what you suggested.
> > > > > > > Failing later would be fine in this case to me; my expectation is VFIO
> > > > > > > users should be advanced already anyway (as the whole solution is still
> > > > > > > pretty involved comparing to a generic VM migration) and shouldn't try to
> > > > > > > trigger that at all in real life.  IOW I'd expect this check will be there
> > > > > > > just for sanity, rather than being relied on to let people be aware of it
> > > > > > > by the error message.
> > > > > > 
> > > > > > Yes, I agree with you.
> > > > > > 
> > > > > > > 
> > > > > > > Meanwhile the blocker + caps check is slightly complicated to me to guard
> > > > > > > both sides.  So I'd vote for failing at the QMP command. But we can wait
> > > > > > > and see whether there's other votes.
> > > > > > 
> > > > > > Sure.
> > > > > > So I will do the checking in vfio_save_setup(), unless someone else has a better idea.
> > > > > 
> > > > > Just to recap for my understanding,
> > > > > 
> > > > > vfio_save_setup() would test migrate_postcopy_ram() and update a new
> > > > > 'Error *err' parameter of the .save_setup() op which would be taken
> > > > > into account in qemu_savevm_state_setup(). Is that correct ?
> > > > > 
> > > > Yes.
> > > > But I wonder if it would be simpler to call migrate_set_error() directly from vfio_save_setup() instead of adding "Error *err" argument to .save_setup() and changing all other users.
> > > > What do you prefer?
> > > 
> > > Well, with my downstreamer hat, I would prefer a simpler solution for the
> > > VFIO postcopy limitation first. That said, there is value in adding
> > > a 'Error *' parameter to the .save_setup() op and letting the top routine
> > > qemu_savevm_state_setup() propagate. Other SaveVMhandler could start using
> > > it. even VFIO has multiple error_report() in vfio_save_setup() which could
> > > be propagated to the top callers.
> > > 
> > > Let's try that first. I will check your new series on top of 8.0
> > > 
> > OK, so just making sure, you want to add "Error *err" argument to .save_setup() first and see how it goes, right?
> 
> yes. Sorry. that was not clear.

I just remembered one pity of failing at save_setup() is it won't fail qmp
command "migrate" itself, but only reflected in query-migrate later.

If we want to make it even better (no strong opinion here, of now), we can
have it separate from save_setup(), e.g., SaveVMHandlers.save_prepare(), so
that it can be called even at migrate_prepare() and fail the QMP command
with proper errors.

Thanks,

-- 
Peter Xu


