Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B73770188
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 15:30:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRuri-000361-EV; Fri, 04 Aug 2023 09:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRurW-00035b-AM
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:29:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRurS-0007Bg-Nx
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691155737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+dqIDwSFUD2FSN/RbNzpFPgxN/YY6z82FTsDaHMglhg=;
 b=GsphXTI4XtlAQiLX/jhV4xP/15pcrMMDNrDomEY2KyXk3Rnkb9J2WWOvAqewdF9XNXRBHT
 Gl7KSAYViU8rlBJhUc1co/Rp3XpyBAHLHpKiOrP/LgV9NFPdiZKmNjypkkxcQF1oZmWYO6
 pfHU0rdbNrfj/T9ZnbothqQjhhqelSk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-WFjjyFdvNLqZX78yFA9p6g-1; Fri, 04 Aug 2023 09:28:55 -0400
X-MC-Unique: WFjjyFdvNLqZX78yFA9p6g-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-40fa24ab5c8so5363411cf.1
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 06:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691155734; x=1691760534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dqIDwSFUD2FSN/RbNzpFPgxN/YY6z82FTsDaHMglhg=;
 b=g1Su51+Jfns4jtUqqEtEGDNbj3wJLYFG180Kf1KsbhwI5KDOb5nz+e6j8HU5iPFH19
 fCKbckvJE7D1KnqICR6pK8E6ylf8EL/Us12SeMsF/jfe0YTmIDV+QviPA2REVH0aMOQV
 wwIY/fw23hMsufz8GqhDg/HKfkQP8dLMLNpUjuuy/qHJsnU5VQIeZinhDL9rbFPxIQar
 idX4HHrXqdvn4mw3eEdw3VVkpfdwpHwupthkW1BOCvytwJNJ8AYyuQifTC62RwE29NmO
 v6rRbiIC+uBZsUP1d9kZ28YUaq9bCN4bxryQjIDjaKx/dcQV4Ga74eMntC1iSnQj2lvE
 sh2Q==
X-Gm-Message-State: ABy/qLb/VzVwWrXwbEZk4hywkVDm+Db/piwYeXw9rGMlocAmuHrlQMZD
 Y8yt1ZJsK7CO7KN+4rnpbt5orETy3iEimfFDMJy8y6GMn9pxQtsUeg500P4DGwhSM4gXY9eB7mt
 2ilMy11MBwJxm1g0=
X-Received: by 2002:a05:622a:13ce:b0:403:c2fa:83b with SMTP id
 p14-20020a05622a13ce00b00403c2fa083bmr26423241qtk.4.1691155734672; 
 Fri, 04 Aug 2023 06:28:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlECuZUnfEr60rKFwTMktoKgDzZ13queqw2tMiiaqFAyqyfU/T3+3iq0ZObwRpLgDGbzB9oHtQ==
X-Received: by 2002:a05:622a:13ce:b0:403:c2fa:83b with SMTP id
 p14-20020a05622a13ce00b00403c2fa083bmr26423217qtk.4.1691155734345; 
 Fri, 04 Aug 2023 06:28:54 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 3-20020ac85743000000b0040f8ac751a5sm643436qtx.96.2023.08.04.06.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 06:28:53 -0700 (PDT)
Date: Fri, 4 Aug 2023 09:28:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Chensheng Dong <chdong@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
Message-ID: <ZMz9FJ09waiG4r9n@x1n>
References: <20230724170755.1114519-1-peterx@redhat.com>
 <87351cfdrq.fsf@pond.sub.org> <ZL/7XtiEFWEprQhD@x1n>
 <87o7jz8a6o.fsf@pond.sub.org> <ZME33z8vFL0fRGYV@x1n>
 <87h6pf9fmd.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6pf9fmd.fsf@pond.sub.org>
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

On Fri, Aug 04, 2023 at 02:06:02PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Jul 26, 2023 at 08:21:35AM +0200, Markus Armbruster wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > Hi, Markus,
> >> >
> >> > On Tue, Jul 25, 2023 at 01:10:01PM +0200, Markus Armbruster wrote:
> >> 
> >> [...]
> >> 
> >> >> For better or worse, we duplicate full documentation between
> >> >> MigrationParameter, MigrateSetParameters, and MigrationParameters.  This
> >> >> would be the first instance where we reference instead.  I'm not opposed
> >> >> to use references, but if we do, I want them used consistently.
> >> >
> >> > We discussed this over the other "switchover" parameter, but that patchset
> >> > just stranded..
> >> >
> >> > Perhaps I just provide a pre-requisite patch to remove all the comments in
> >> > MigrateSetParameters and MigrationParameters, letting them all point to
> >> > MigrationParameter?
> >> 
> >> Simplifies maintaining the doc commments.  But how does it affect the
> >> documentation generated from it?  Better, neutral, or worse?
> >
> > Probably somewhere neutral.  There are definitely benefits, shorter
> > man/html page in total, and avoid accidentally different docs over the same
> > fields.  E.g., we sometimes have different wordings for different objects:
> >
> >        max-cpu-throttle
> >               maximum cpu throttle percentage.  Defaults to 99.  (Since 3.1)
> >
> >        max-cpu-throttle: int (optional)
> >               maximum cpu throttle percentage.  The default value is 99. (Since 3.1)
> >
> > This one is fine, but it's just very easy to leak in something that shows
> > differently.  It's good to provide coherent documentation for the same
> > fields over all three objects.
> 
> Yes, but we've been doing okay regardless.
> 
> The drawback of replacing duplicates by references is that readers need
> to follow the references.
> 
> Less onerous when the references can be clicked.
> 
> If we de-duplicate, which copy do we keep, MigrationParameter,
> MigrateSetParameters, or MigrationParameter?  Do we have an idea which
> of these users are likely to read first?

I chose MigrationParameter for no explicit reason, because I can't find
good argument to differenciate them.  Please let me know if you have any
suggestion.

> 
> > When looking at qemu-qmp-ref.7, it can be like this when we can invite the
> > reader to read the other section (assuming we only keep MigrationParameter
> > to keep the documentations):
> >
> >    MigrationParameters (Object)
> >
> >        The object structure to represent a list of migration parameters.
> >        The optional members aren't actually optional.  For detailed
> >        explanation for each of the field, please refer to the documentation
> >        of MigrationParameter.
> >
> > But the problem is we always will generate the Members entry, where now
> > it'll all filled up with "Not documented"..
> >
> >    Members
> >        announce-initial: int (optional)
> >               Not documented
> >
> >        announce-max: int (optional)
> >               Not documented
> >
> >        announce-rounds: int (optional)
> >               Not documented
> >
> >        [...]
> >
> > I think maybe it's better we just list the members without showing "Not
> > documented" every time for the other two objects.  Not sure whether it's an
> > easy way to fix it, or is it a major issue.
> 
> The automatic generation of "Not documented" documentation is a
> stop-gap.  Leaving a member undocumented should be a hard error.  It
> isn't only because we have 511 instances to fix.
> 
> Perhaps a directive to ignore undocumented members could be useful.
> I.e. to suppress the automatic "Not documented" documented now, the
> error later.
> 
> We could write things out in longhand instead, like
> 
>     # @announce-initial: Same as MigrationParameter member
>     #     @announce-initial.

Yes I can definitely do this.

Since I don't really know whether the "put a link" will work at all (at
least man page doesn't really have those, does it?), would this be the way
you suggest us forward?

Note that I am also always happy to simply duplicate the three paragraphs
just like before; that's not something I must do with solving the migration
problem so far, we can decouple the two problems essentially.  But since
we're at it, if you think worthwhile we may have a chance get rid of
duplicated documents here (before code) I can try.

> 
> > For developers, dedup the comment should always be a win, afaict.
> 
> No argument.

Let me explain a bit: I meant the patch author who will reduce writting
duplicated documents, making sure everything match together.  And reviewers
who will read the duplicated content, making sure that everything match
together again.  The two efforts can be avoided.  That's all I meant here
for when I was referring to as "developers" in this context..  Not everyone
as a common sense of developer.

Thanks,

-- 
Peter Xu


