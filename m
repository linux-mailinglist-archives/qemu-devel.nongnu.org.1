Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAC37B06EB
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 16:33:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlVZx-00025r-7M; Wed, 27 Sep 2023 10:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlVZr-00025L-IH
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:31:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlVZg-0006ml-1t
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695825095;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zEvfcI2WxVkgjVgh6pWb550RWrrD8Qo5GZ54mmr8R4U=;
 b=KEcQLyw+yO+27HCOYirJNDIgochRBj8t3FA2dD5Ue1WPKzCD12T69SbyFyjTgqh3vQ0Yd0
 HCw7W0BNZnITP8KDCEWGMmSBk9UPxJPSvMHk6BiEO5SS8nsz4Or2ADG4Fp4yaqema3ITPL
 3E5wpPUXrRAKkeuo6USaMlZ/ZXsD6As=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-jHxsgO6yO36_ekrKlBx_fA-1; Wed, 27 Sep 2023 10:31:33 -0400
X-MC-Unique: jHxsgO6yO36_ekrKlBx_fA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE4CE85A5BE;
 Wed, 27 Sep 2023 14:31:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76BC31055466;
 Wed, 27 Sep 2023 14:31:30 +0000 (UTC)
Date: Wed, 27 Sep 2023 15:31:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Cc: Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: migration maintenance, governance [Was: Re: [PATCH V4 0/2]
 migration file URI]
Message-ID: <ZRQ8wOhTNDEL3suv@redhat.com>
References: <1688135108-316997-1-git-send-email-steven.sistare@oracle.com>
 <dba1e07d-6ebf-9329-7be7-4702ff5dc16d@suse.de>
 <1290963e-9f63-fc70-6729-d355d247c2fd@linaro.org>
 <2f5b9774-e089-3606-905a-8b991dcc5e87@suse.de>
 <a4adf886-7018-4cf5-14d6-cd85172ea501@suse.de>
 <9833202a-8060-1e81-208e-4e240279c298@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9833202a-8060-1e81-208e-4e240279c298@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 27, 2023 at 03:14:29PM +0200, Claudio Fontana wrote:
> On 9/13/23 15:00, Claudio Fontana wrote:
> > On 8/30/23 15:09, Claudio Fontana wrote:
> >> On 8/22/23 15:25, Philippe Mathieu-Daudé wrote:
> >>> Hi Claudio,
> >>>
> >>> On 22/8/23 14:00, Claudio Fontana wrote:
> >>>> Hello,
> >>>>
> >>>> this series is all reviewed,
> >>>>
> >>>> and is needed as a precondition for further work to improve dramatically the performance of virsh save, virsh restore
> >>>> when migrating to disk, can it be merged?
> >>>
> >>> $ ./scripts/get_maintainer.pl -f migration/meson.build
> >>> Juan Quintela <quintela@redhat.com> (maintainer:Migration)
> >>> Peter Xu <peterx@redhat.com> (reviewer:Migration)
> >>> Leonardo Bras <leobras@redhat.com> (reviewer:Migration)
> >>> qemu-devel@nongnu.org (open list:All patches CC here)
> >>>
> >>> One maintainer, one single point of failure. When the
> >>> maintainer is busy or offline (vacations?) then everybody
> >>> is stuck.
> >>>
> >>> This is usually solved by adding co-maintainers.
> >>>
> >>> Juan, would you accept having co-maintainers helping you
> >>> dealing with the merge process? I'm not volunteering, but
> >>> this can be a good opportunity to make a formal request to
> >>> the community.
> >>
> >> I would like to highlight to the QEMU community here how important this is for SUSE,
> >>
> >> to see progress for all the series in the migration area that are currently still waiting and competing for attention.
> >>
> >> The specific features and improvements we are developing or helping to review are a priority for us,
> >> and we are concerned about the rate of progress with the existing governance processes.
> >>
> >> Fabiano is investing a lot of his attention to this area, with features, bugfixes and reviews,
> >> but of course it is up to the community as a whole to address the issue so that reviewed work is merged.
> >>
> >> My attempt here is to make sure that it is recognized as a problem, so it can be hopefully be addressed by the community in a timely fashion,
> >> and we can all benefit from the already developed and reviewed work that is pending.
> >>
> > 
> > Hi Juan, any comments? Would additional help for co-maintenance of live migration help?
> > How can we make things proceed?
> > 
> > From our (SUSE) side we are willing to help as much as we can, and all options are open,
> > whatever it takes to get the multiple series currently waiting to flow again.
> > 
> > Thanks,
> > 
> > Claudio
> 
> Hi any news here?
> 
> We continue to see the migration area of QEMU as basically blocked;
> 
> there are a number of reviewed series out and little progress in merging them,
> as well as a number of improvements not posted to the list at all due to the situation being completely bottlenecked.
> 
> Would a co-maintenance of migration/ from Fabiano be an option?
> 
> Should we organize a call to discuss this if the mailing list does not suffice to discuss this topic?

FWIW, in response to your previous mail, I had suggested to Peter Xu in
private that he would make a good candidate of co-maintainer for migration,
given he is already a nominated reviewer and has been actively reviewing
migration patches for a long while.

Migration did have 2 maintainers until earlier in this year when David
Gilbert moved on to other things, and I think we can all see that this
has had an unfortunate impact on productivity in the migration subsystem
that needs to be solved.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


