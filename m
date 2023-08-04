Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A58AD770280
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 16:03:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRvOW-0007wp-E7; Fri, 04 Aug 2023 10:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRvOT-0007wg-UT
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:03:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRvOS-0002Bv-7a
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691157783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjHKSuPyhP4QtUg/mwQc1AA/Vu54gzHUzlikctJLOVk=;
 b=RzGG3ohKrhP6E6O2zpG2CDCq5A1XZgkfy9kf7Ps072PvouEGqcZOboeY+Bg4Slo+RcDDqj
 fq2uJDyi9pZe/fGhpaYkyNuPdyHWTEqZ7NpKpgTordmq3WPqc5Ua2FM1ZXYyzozBnE3jO8
 WAfnsMwf6EKRry6i01AJPW6U9UvjVsM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-Ndk12_MpOWiVy9tsUcqiWA-1; Fri, 04 Aug 2023 10:02:57 -0400
X-MC-Unique: Ndk12_MpOWiVy9tsUcqiWA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-637948b24bdso4650606d6.1
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 07:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691157776; x=1691762576;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gjHKSuPyhP4QtUg/mwQc1AA/Vu54gzHUzlikctJLOVk=;
 b=gZoeC5SGIDhXK3x31FNhyvkayZsiCAT2PKwAXX+dM3ul8Bwh0b9tVhJ593GiIxsHsl
 KkUaRyIRgslTR4SlS/OkhqW/MSZbj2FXtRU6DvmtjfIBUUlE+k21BftocmB2wd4TwsO9
 wTx+fYovmUS0IjFalHBaBOJDLMKFMLlyT2BKmSAEZloEhznAKHMJBf8UEHD30JijrcsA
 ZVkEVz+xIOeQr0HZWwvKcV/lOiAY7QLroETcsN+cYKHTeEsMPboD/7vW2+d2slrH0WTh
 7/AW+JT9Q8nGp4M6S4vucB4u9rV4Zce6ZiX/af04NjKjCoKL06VVhEXlFZR5EtlA4Rj/
 0TGA==
X-Gm-Message-State: ABy/qLa5XYCZVM3d3Lvw9oBTlTNc605U1Xj5fOoLX3ibsawAER1HTS/s
 rIjWS9r+N1zKPWYprP0G5y1Lp8nLz1Gr2SajG+LNPKwvJcMAfGUtgHXR0RkLIK9uQufoGQY3CjQ
 Ep38dfrAWTlD9KoE=
X-Received: by 2002:a05:6214:5017:b0:63c:fd2d:6ff1 with SMTP id
 jo23-20020a056214501700b0063cfd2d6ff1mr23586606qvb.1.1691157776132; 
 Fri, 04 Aug 2023 07:02:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF1EkqD3U8yGjD0BFqqhNpsxAxPEE/7Sc0UsnPFMveWCAM7PbNQ04yiy7YUk0ufu5dAjYdyGA==
X-Received: by 2002:a05:6214:5017:b0:63c:fd2d:6ff1 with SMTP id
 jo23-20020a056214501700b0063cfd2d6ff1mr23586568qvb.1.1691157775814; 
 Fri, 04 Aug 2023 07:02:55 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 r4-20020a0ce284000000b00634daee6ecbsm678566qvl.113.2023.08.04.07.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 07:02:55 -0700 (PDT)
Date: Fri, 4 Aug 2023 10:02:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Chensheng Dong <chdong@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
Message-ID: <ZM0FDgndvbhrhMa0@x1n>
References: <20230724170755.1114519-1-peterx@redhat.com>
 <87351cfdrq.fsf@pond.sub.org> <ZL/7XtiEFWEprQhD@x1n>
 <87o7jz8a6o.fsf@pond.sub.org> <ZME33z8vFL0fRGYV@x1n>
 <ZMz/g+qU7vzXx6aP@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMz/g+qU7vzXx6aP@redhat.com>
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

On Fri, Aug 04, 2023 at 02:39:15PM +0100, Daniel P. Berrangé wrote:
> On Wed, Jul 26, 2023 at 11:12:31AM -0400, Peter Xu wrote:
> > On Wed, Jul 26, 2023 at 08:21:35AM +0200, Markus Armbruster wrote:
> > > Peter Xu <peterx@redhat.com> writes:
> > > 
> > > > Hi, Markus,
> > > >
> > > > On Tue, Jul 25, 2023 at 01:10:01PM +0200, Markus Armbruster wrote:
> > > 
> > > [...]
> > > 
> > > >> For better or worse, we duplicate full documentation between
> > > >> MigrationParameter, MigrateSetParameters, and MigrationParameters.  This
> > > >> would be the first instance where we reference instead.  I'm not opposed
> > > >> to use references, but if we do, I want them used consistently.
> > > >
> > > > We discussed this over the other "switchover" parameter, but that patchset
> > > > just stranded..
> > > >
> > > > Perhaps I just provide a pre-requisite patch to remove all the comments in
> > > > MigrateSetParameters and MigrationParameters, letting them all point to
> > > > MigrationParameter?
> > > 
> > > Simplifies maintaining the doc commments.  But how does it affect the
> > > documentation generated from it?  Better, neutral, or worse?
> > 
> > Probably somewhere neutral.  There are definitely benefits, shorter
> >
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
> Do we have any actual problems though where the difference in
> docs is actively harmful ? I agree there's a possbility of the
> duplication being problematic, but unless its actually the
> case in reality, it is merely a theoretical downside.
> 
> IMHO for someone consuming the docs, this patch is worse, not neutral.

I agree.

> 
> > 
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
> > 
> > For developers, dedup the comment should always be a win, afaict.
> 
> IMHO that's optimizing for the wrong people and isn't a measurable
> win anyway. Someone adding a new parameter can just cut+paste the
> same docs string in the three places. It is a cost, but it is a
> small one time cost, where having "not documented" is a ongoing
> cost for consumers of our API.
> 
> I don't think the burden on QEMU maintainers adding new migration
> parameters is significant enough to justify ripping out our existing
> docs.

I had that strong feeling mostly because I'm a migration developer and
migration reviewer, so I suffer on both sides. :) I was trying to stand out
for either any future author/reviewer from that pov, but I think indeed the
ultimate consumer is the reader.

Fundamentally to solve the problem, maybe we must dedup the objects rather
than the documents only?  I'll try to dig a bit more in this area next week
if I have time, any link for previous context would be welcomed (or obvious
reason that we just won't be able to do that; I only know that at least
shouldn't be trivial to resolve).

For this one - Markus, let me know what do you think, or I'll simply repost
v3 with the duplications (when needed, probably later not sooner).

Thanks,

-- 
Peter Xu


