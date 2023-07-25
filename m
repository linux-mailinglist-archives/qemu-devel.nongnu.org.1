Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F185761EC7
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 18:42:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOL78-0005Mk-2M; Tue, 25 Jul 2023 12:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOL74-0005Ku-IT
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:42:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOL72-0007Ju-5V
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690303334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6vrVCfm3bW1eUfAxrtI2QoeET6X47QUDgmGr6ssSgkk=;
 b=MbiP0fZiPZHw/S1nQfuRpcsjDCLignAKeIkzabWVJcX2Fj9fIBs5FpY0PWd45OuG0Cntak
 ZHON/61F0zM0Zi76vgC8C9ON3zHH3rq24STZrrma22y3foEpSZ0LxnoFzrapSUbXpqytFg
 uI7lAQbVyMCwPEihHV+ZCthfeastsOM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-4CgYvN5UM725a2vNdMqbTg-1; Tue, 25 Jul 2023 12:42:12 -0400
X-MC-Unique: 4CgYvN5UM725a2vNdMqbTg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-767a1ad2175so125477485a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 09:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690303331; x=1690908131;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6vrVCfm3bW1eUfAxrtI2QoeET6X47QUDgmGr6ssSgkk=;
 b=YtVqKILy6DZHYxQtYOM2l6Eq+cvj9Y2RDe4zLQS4aQP2E3z15zY2bZqNQKXpzXpnEc
 woPOc91HfbqeTRh0WGn2l4ZM/hkmV6TJB2NP2q9z+TRY1dnakXPqFQsC4NDHItc60A3y
 fBOmAr9iVof2DEx872amZM6vdAYlK1lk53p6Vo0YKexpWSShX2T07scfBNC9lRBSOUW0
 D93zq/bZq/FC6V7EP1FHZUnNMj6ZmhTtHkjX25IdGafqVLN9pNO4qwj8DK4BKuo3VSI0
 C5GHu8b5bbfoeT3FCwYAIyzU4/3mXBe5bDmoMNwx0oNc03RlJcHvHxYZhCjsLfD9Fja6
 n/xA==
X-Gm-Message-State: ABy/qLYcP9GISwAzfy8IrDQhLVC+KyWhXSrsVgHmbeUmuK9qpRuJgksg
 HVMeeYVey5ibMABb6TPh86OjZhoj3pQPQbUhPHkECKpleVhH77cV+k8fM/R93IsJlwriRll3L8R
 khslet4WcYiHRGeM=
X-Received: by 2002:a05:620a:44cd:b0:763:a1d3:196d with SMTP id
 y13-20020a05620a44cd00b00763a1d3196dmr17338343qkp.0.1690303331608; 
 Tue, 25 Jul 2023 09:42:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG/O1+1/ZDg1D9YXtjEiSysnysKTTfRIQs0+j8m7y7lMmQ7//OBmMIE/MI0HKGNI7p7Y5s+2Q==
X-Received: by 2002:a05:620a:44cd:b0:763:a1d3:196d with SMTP id
 y13-20020a05620a44cd00b00763a1d3196dmr17338319qkp.0.1690303331199; 
 Tue, 25 Jul 2023 09:42:11 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ow4-20020a05620a820400b007682af2c8aasm3778681qkn.126.2023.07.25.09.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 09:42:10 -0700 (PDT)
Date: Tue, 25 Jul 2023 12:42:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Chensheng Dong <chdong@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
Message-ID: <ZL/7XtiEFWEprQhD@x1n>
References: <20230724170755.1114519-1-peterx@redhat.com>
 <87351cfdrq.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87351cfdrq.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi, Markus,

On Tue, Jul 25, 2023 at 01:10:01PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Migration bandwidth is a very important value to live migration.  It's
> > because it's one of the major factors that we'll make decision on when to
> > switchover to destination in a precopy process.
> >
> > This value is currently estimated by QEMU during the whole live migration
> > process by monitoring how fast we were sending the data.  This can be the
> > most accurate bandwidth if in the ideal world, where we're always feeding
> > unlimited data to the migration channel, and then it'll be limited to the
> > bandwidth that is available.
> >
> > However in reality it may be very different, e.g., over a 10Gbps network we
> > can see query-migrate showing migration bandwidth of only a few tens of
> > MB/s just because there are plenty of other things the migration thread
> > might be doing.  For example, the migration thread can be busy scanning
> > zero pages, or it can be fetching dirty bitmap from other external dirty
> > sources (like vhost or KVM).  It means we may not be pushing data as much
> > as possible to migration channel, so the bandwidth estimated from "how many
> > data we sent in the channel" can be dramatically inaccurate sometimes,
> > e.g., that a few tens of MB/s even if 10Gbps available, and then the
> > decision to switchover will be further affected by this.
> >
> > The migration may not even converge at all with the downtime specified,
> > with that wrong estimation of bandwidth.
> >
> > The issue is QEMU itself may not be able to avoid those uncertainties on
> > measuing the real "available migration bandwidth".  At least not something
> > I can think of so far.
> >
> > One way to fix this is when the user is fully aware of the available
> > bandwidth, then we can allow the user to help providing an accurate value.
> >
> > For example, if the user has a dedicated channel of 10Gbps for migration
> > for this specific VM, the user can specify this bandwidth so QEMU can
> > always do the calculation based on this fact, trusting the user as long as
> > specified.
> >
> > When the user wants to have migration only use 5Gbps out of that 10Gbps,
> > one can set max-bandwidth to 5Gbps, along with available-bandwidth to 5Gbps
> > so it'll never use over 5Gbps too (so the user can have the rest 5Gbps for
> > other things).  So it can be useful even if the network is not dedicated,
> > but as long as the user can know a solid value.
> >
> > A new parameter "available-bandwidth" is introduced just for this. So when
> > the user specified this parameter, instead of trusting the estimated value
> > from QEMU itself (based on the QEMUFile send speed), let's trust the user
> > more.
> >
> > This can resolve issues like "unconvergence migration" which is caused by
> > hilarious low "migration bandwidth" detected for whatever reason.
> >
> > Reported-by: Zhiyi Guo <zhguo@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  qapi/migration.json            | 20 +++++++++++++++++++-
> >  migration/migration.h          |  2 +-
> >  migration/options.h            |  1 +
> >  migration/migration-hmp-cmds.c | 14 ++++++++++++++
> >  migration/migration.c          | 19 +++++++++++++++----
> >  migration/options.c            | 28 ++++++++++++++++++++++++++++
> >  migration/trace-events         |  2 +-
> >  7 files changed, 79 insertions(+), 7 deletions(-)
> >
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 47dfef0278..fdc269e0a1 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -730,6 +730,16 @@
> >  # @max-bandwidth: to set maximum speed for migration.  maximum speed
> >  #     in bytes per second.  (Since 2.8)
> >  #
> > +# @available-bandwidth: to set available bandwidth for migration.  By
> > +#     default, this value is zero, means the user is not aware of the
> > +#     available bandwidth that can be used by QEMU migration, so QEMU will
> > +#     estimate the bandwidth automatically.  This can be set when the
> > +#     estimated value is not accurate, while the user is able to guarantee
> > +#     such bandwidth is available for migration purpose during the
> > +#     migration procedure.  When specified correctly, this can make the
> > +#     switchover decision much more accurate, which will also be based on
> > +#     the max downtime specified.  (Since 8.2)
> 
> Humor me: break lines slightly earlier, like
> 
>    # @available-bandwidth: to set available bandwidth for migration.  By
>    #     default, this value is zero, means the user is not aware of the
>    #     available bandwidth that can be used by QEMU migration, so QEMU
>    #     will estimate the bandwidth automatically.  This can be set when
>    #     the estimated value is not accurate, while the user is able to
>    #     guarantee such bandwidth is available for migration purpose
>    #     during the migration procedure.  When specified correctly, this
>    #     can make the switchover decision much more accurate, which will
>    #     also be based on the max downtime specified.  (Since 8.2)

Sure.

> 
> > +#
> >  # @downtime-limit: set maximum tolerated downtime for migration.
> >  #     maximum downtime in milliseconds (Since 2.8)
> >  #
> > @@ -803,7 +813,7 @@
> >             'cpu-throttle-initial', 'cpu-throttle-increment',
> >             'cpu-throttle-tailslow',
> >             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
> > -           'downtime-limit',
> > +           'available-bandwidth', 'downtime-limit',
> >             { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
> >             'block-incremental',
> >             'multifd-channels',
> > @@ -886,6 +896,9 @@
> >  # @max-bandwidth: to set maximum speed for migration.  maximum speed
> >  #     in bytes per second.  (Since 2.8)
> >  #
> > +# @available-bandwidth: to set available migration bandwidth.  Please refer
> > +#     to comments in MigrationParameter for more information. (Since 8.2)
> 
> For better or worse, we duplicate full documentation between
> MigrationParameter, MigrateSetParameters, and MigrationParameters.  This
> would be the first instance where we reference instead.  I'm not opposed
> to use references, but if we do, I want them used consistently.

We discussed this over the other "switchover" parameter, but that patchset
just stranded..

Perhaps I just provide a pre-requisite patch to remove all the comments in
MigrateSetParameters and MigrationParameters, letting them all point to
MigrationParameter?

One thing I should have mentioned much earlier is that this patch is for
8.2 material.

> 
> > +#
> >  # @downtime-limit: set maximum tolerated downtime for migration.
> >  #     maximum downtime in milliseconds (Since 2.8)
> >  #
> > @@ -971,6 +984,7 @@
> >              '*tls-hostname': 'StrOrNull',
> >              '*tls-authz': 'StrOrNull',
> >              '*max-bandwidth': 'size',
> > +            '*available-bandwidth': 'size',
> >              '*downtime-limit': 'uint64',
> >              '*x-checkpoint-delay': { 'type': 'uint32',
> >                                       'features': [ 'unstable' ] },
> > @@ -1078,6 +1092,9 @@
> >  # @max-bandwidth: to set maximum speed for migration.  maximum speed
> >  #     in bytes per second.  (Since 2.8)
> >  #
> > +# @available-bandwidth: to set available migration bandwidth.  Please refer
> > +#     to comments in MigrationParameter for more information. (Since 8.2)
> > +#
> >  # @downtime-limit: set maximum tolerated downtime for migration.
> >  #     maximum downtime in milliseconds (Since 2.8)
> >  #
> > @@ -1160,6 +1177,7 @@
> >              '*tls-hostname': 'str',
> >              '*tls-authz': 'str',
> >              '*max-bandwidth': 'size',
> > +            '*available-bandwidth': 'size',
> >              '*downtime-limit': 'uint64',
> >              '*x-checkpoint-delay': { 'type': 'uint32',
> >                                       'features': [ 'unstable' ] },
> > diff --git a/migration/migration.h b/migration/migration.h
> > index b7c8b67542..fadbf64d9d 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -283,7 +283,7 @@ struct MigrationState {
> >      /*
> >       * The final stage happens when the remaining data is smaller than
> >       * this threshold; it's calculated from the requested downtime and
> > -     * measured bandwidth
> > +     * measured bandwidth, or available-bandwidth if user specified.
> 
> Suggest to scratch "user".

Will do, thanks.

-- 
Peter Xu


