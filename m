Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E5F7CC798
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:38:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsm9N-0004mj-Vx; Tue, 17 Oct 2023 11:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsm8w-0004ia-Ag
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsm8u-0000tE-6C
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697557077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w7Db3IVB7mXE36pd8OH6GI6W+Jp+uY6BFWMvirFLUN0=;
 b=gZStFBYPC/pg0DVkb6lK/0K18O/VHJ86HzmyEzfrUM9drB1xo8mRoxFHn/66fWwSjUueY5
 v+yMjyJYWsdjJb7p3XMYcAMsg+mfdUJAHRr4U6lwcXHJEmryzfkEdpFwiWxHk5knODPnHs
 Me8uLz9qT1dTE2mqx4phTW4E8ZdLUik=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-ug1y8wq1NkugWTX7wec7fQ-1; Tue, 17 Oct 2023 11:37:40 -0400
X-MC-Unique: ug1y8wq1NkugWTX7wec7fQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77585a78884so85741985a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 08:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697557060; x=1698161860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7Db3IVB7mXE36pd8OH6GI6W+Jp+uY6BFWMvirFLUN0=;
 b=wvERpne5zynZfYw5GvRMSnvx1islL5GXY3H6C81gignzyz5FJ5yDcuH0E92LzXsdw+
 qSVx+RjjOJ4LcBktqUR4mShCWRJ7uy3EiNt+xEFFBhv9mlHjLK1dj8BLMwdat/qzsK/I
 yy3piHDjLAV7KLv+woCz9cuShr9RZct6XXvGI7IKT1hPZ06JZUNtvqlwRdNbGJsv6Ahp
 Fh0L4NofbaC+1FUN5bc8CxyWhwJh0OIsmZCDDIgjSx/KmL24viCKknEEeFfc4G793Jc8
 ANwPHwDdrAOyh9puc7w2Y+C4ieKbl7BRVQr6xEn0BDgm2MGfZSQmg9IYXl+3at/wXb8s
 jnxg==
X-Gm-Message-State: AOJu0Yzr+RTS3Z/pOoQ7CTNmWMgPZs66dhTtKyEYWveVcgdmvq9vLNZ/
 1AjA0y8FpqgBs2tUDzcnzgZ5nQghPQtGMweLB9JBCcHUhBydd2n2yokD+bZXf1UET011MSaHQUb
 BCcE7N88QZsQc0wk=
X-Received: by 2002:a05:620a:20d5:b0:775:82e2:dc19 with SMTP id
 f21-20020a05620a20d500b0077582e2dc19mr2918962qka.2.1697557060325; 
 Tue, 17 Oct 2023 08:37:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC1t3L/Z+nu7ZZGewwh+Z6jHSFHF+xalZvDkRA2qpBP8vu7BcbBwd+53pDza/URia7R9scqQ==
X-Received: by 2002:a05:620a:20d5:b0:775:82e2:dc19 with SMTP id
 f21-20020a05620a20d500b0077582e2dc19mr2918930qka.2.1697557059888; 
 Tue, 17 Oct 2023 08:37:39 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 e3-20020a05620a12c300b007789072e445sm73641qkl.31.2023.10.17.08.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 08:37:39 -0700 (PDT)
Date: Tue, 17 Oct 2023 11:37:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Chensheng Dong <chdong@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Eric Blake <eblake@redhat.com>, Joao Martins <joao.m.martins@oracle.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v4] migration: Allow user to specify available switchover
 bandwidth
Message-ID: <ZS6qJ0F1uRlKWe45@x1n>
References: <20231010221922.40638-1-peterx@redhat.com>
 <87y1g149t3.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1g149t3.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Tue, Oct 17, 2023 at 04:12:40PM +0200, Markus Armbruster wrote:
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
> > data we sent in the channel" can be dramatically inaccurate sometimes.
> 
> how much data we've sent to the channel
> 
> >
> > With that, the decision to switchover will be affected, by assuming that we
> > may not be able to switchover at all with such a low bandwidth, but in
> > reality we can.
> >
> > The migration may not even converge at all with the downtime specified,
> > with that wrong estimation of bandwidth, keeping iterations forever with a
> 
> iterating forever
> 
> > low estimation of bandwidth.
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
> > specified.  It may not be the exact bandwidth when switching over (in which
> > case qemu will push migration data as fast as possible), but much better
> > than QEMU trying to wildly guess, especially when very wrong.
> >
> > A new parameter "avail-switchover-bandwidth" is introduced just for this.
> > So when the user specified this parameter, instead of trusting the
> > estimated value from QEMU itself (based on the QEMUFile send speed), it
> > trusts the user more by using this value to decide when to switchover,
> > assuming that we'll have such bandwidth available then.
> >
> > Note that specifying this value will not throttle the bandwidth for
> > switchover yet, so QEMU will always use the full bandwidth possible for
> > sending switchover data, assuming that should always be the most important
> > way to use the network at that time.
> >
> > This can resolve issues like "unconvergence migration" which is caused by
> > hilarious low "migration bandwidth" detected for whatever reason.
> 
> "unconvergence" isn't a word :)
> 
> Suggest "like migration not converging, because the automatically
> detected migration bandwidth is hilariously low for whatever reason."
> 
> Appreciate the thorough explanation!

Thanks for reviewing!

The patch is already in today's migration pull, so unfortunately no planned
repost for now.  I'll amend the commit message and collect the ACK if I'll
need to redo it.

> 
> >
> > Reported-by: Zhiyi Guo <zhguo@redhat.com>
> > Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > v4:
> > - Rebase to master, with duplicated documentations
> > ---
> >  qapi/migration.json            | 34 +++++++++++++++++++++++++++++++++-
> >  migration/migration.h          |  2 +-
> >  migration/options.h            |  1 +
> >  migration/migration-hmp-cmds.c | 14 ++++++++++++++
> >  migration/migration.c          | 24 +++++++++++++++++++++---
> >  migration/options.c            | 28 ++++++++++++++++++++++++++++
> >  migration/trace-events         |  2 +-
> >  7 files changed, 99 insertions(+), 6 deletions(-)
> >
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 8843e74b59..0c897a99b1 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -759,6 +759,16 @@
> >  # @max-bandwidth: to set maximum speed for migration.  maximum speed
> >  #     in bytes per second.  (Since 2.8)
> >  #
> > +# @avail-switchover-bandwidth: to set the available bandwidth that
> > +#     migration can use during switchover phase.  NOTE!  This does not
> > +#     limit the bandwidth during switchover, but only for calculations when
> > +#     making decisions to switchover.  By default, this value is zero,
> > +#     which means QEMU will estimate the bandwidth automatically.  This can
> > +#     be set when the estimated value is not accurate, while the user is
> > +#     able to guarantee such bandwidth is available when switching over.
> > +#     When specified correctly, this can make the switchover decision much
> > +#     more accurate.  (Since 8.2)
> 
> We tend to eschew abbreviations in QAPI schema identifiers.
> available-switchover-bandwidth is a mouthful, though.  What do you
> think?

The named changed in the past versions, and IIRC avail-switchover-bandwidth
is something we came up with last.. assuming a trade-off between length and
sane meanings.  I don't have anything better to come up.. :)

Please shoot if you have better suggestions.  We still have three weeks to
8.2 soft freeze.

Thanks,

-- 
Peter Xu


