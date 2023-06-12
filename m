Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C4572D32D
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 23:21:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8ox5-00069Q-5z; Mon, 12 Jun 2023 17:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q8ox1-00068q-2t
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 17:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q8owz-0001qm-FP
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 17:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686604784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/6sd962pvx5JSCy4DkWX6WEW7ermPPyW/cCktqsVw84=;
 b=ieFmFu1M7pPT6dhzD9HpfH/KQXKAXKeOSz7w2xvKkbhD3tgsABgKZurVbUL+aiIjGSXePe
 89qOd5jXcp3rCrEqHg9NJogkyNSgzMMTpoLrN+RmTcVKSYie0dvU0dytQfXyl3RruMFaxm
 xO970A0FVlRACLFBACeMt8hFRwYwKxE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-TC0cH7eiOiaBU6LdFG_lYg-1; Mon, 12 Jun 2023 17:19:43 -0400
X-MC-Unique: TC0cH7eiOiaBU6LdFG_lYg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-62632620f00so9827746d6.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 14:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686604782; x=1689196782;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6sd962pvx5JSCy4DkWX6WEW7ermPPyW/cCktqsVw84=;
 b=ToJC2tXnSIkJ+CdamMdBucA/BC1WW2xjdoRIFecYeuH/cq547mLYxg+kBeYsj0Zsyl
 HB4tGmHLzEHoe4as+yrH2H7lLpMdFWMzzzOfkf+kpTmZKLXSD+cN0TfUK4Xgk1UG1uWj
 uER2mWhzNwgQFw7pYa1VjUSZSF85oiIZSJMK7XZZEU2dlUJbWN6n4v8+HLOFQ2pjEBy0
 FJyQLbhhS4P9MVtar3ziaaQQTMpDr+wuUqkDeOXdNXoqU33DKlOGgaS7vUbGU1+sTfI2
 CrYgchLgi1YlRDvTifnaZ86JbkFQd3gRGkt9h5ImPXNs/bbVhCWL3YtBq1yzwV6h4xyk
 ZfNQ==
X-Gm-Message-State: AC+VfDy9U8N8XFLXR9vV1bb/R6ZjjaPSeyeInfFRyf0CkZlLTDtnsogo
 Vng0ZkClGtiMGbH58Ci16qJfQ8QlnV1S4U7iNDzXaNrflqDuFd1QWEgoJ+dUINuTrYT7I473SGx
 d+sAcTTVQJposD8E=
X-Received: by 2002:a05:6214:c26:b0:626:273e:c35c with SMTP id
 a6-20020a0562140c2600b00626273ec35cmr12999243qvd.2.1686604782471; 
 Mon, 12 Jun 2023 14:19:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6BgYroICsIuxw5Vqm2MkEN9oQUL86wqfK6XXyZb392NdKhpfXsIdFLWm+Sj9mjU4fSs/PGBA==
X-Received: by 2002:a05:6214:c26:b0:626:273e:c35c with SMTP id
 a6-20020a0562140c2600b00626273ec35cmr12999230qvd.2.1686604782186; 
 Mon, 12 Jun 2023 14:19:42 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u13-20020a0cf1cd000000b00626117620aasm1153765qvl.105.2023.06.12.14.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 14:19:41 -0700 (PDT)
Date: Mon, 12 Jun 2023 17:19:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Message-ID: <ZIeL7MGzKBv7CgZ2@x1n>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875y7sflqb.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 12, 2023 at 10:51:08PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Mon, Jun 12, 2023 at 09:33:42PM +0200, Juan Quintela wrote:
> >> Only "defer" is recommended.  After setting all migation parameters,
> >> start incoming migration with "migrate-incoming uri" command.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  docs/about/deprecated.rst | 7 +++++++
> >>  softmmu/vl.c              | 2 ++
> >>  2 files changed, 9 insertions(+)
> >> 
> >> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> >> index 47e98dc95e..518672722d 100644
> >> --- a/docs/about/deprecated.rst
> >> +++ b/docs/about/deprecated.rst
> >> @@ -447,3 +447,10 @@ The new way to modify migration is using migration parameters.
> >>  ``blk`` functionality can be acchieved using
> >>  ``migrate_set_parameter block-incremental true``.
> >>  
> >> +``-incoming uri`` (since 8.1)
> >> +'''''''''''''''''''''''''''''
> >> +
> >> +Everything except ``-incoming defer`` are deprecated.  This allows to
> >> +setup parameters before launching the proper migration with
> >> +``migrate-incoming uri``.
> >> +
> >> diff --git a/softmmu/vl.c b/softmmu/vl.c
> >> index b0b96f67fa..7fe865ab59 100644
> >> --- a/softmmu/vl.c
> >> +++ b/softmmu/vl.c
> >> @@ -2651,6 +2651,8 @@ void qmp_x_exit_preconfig(Error **errp)
> >>      if (incoming) {
> >>          Error *local_err = NULL;
> >>          if (strcmp(incoming, "defer") != 0) {
> >> +            warn_report("-incoming %s is deprecated, use -incoming defer and "
> >> +                        " set the uri with migrate-incoming.", incoming);
> >
> > I still use uri for all my scripts, alongside with "-global migration.xxx"
> > and it works.
> 
> You know what you are doing (TM).
> And remember that we don't support -gobal migration.x-foo.
> Yes, I know, we should drop the "x-" prefixes.

I hope they'll always be there. :) They're pretty handy for tests, when we
want to boot a VM without the need to script the sequences of qmp cmds.

Yes, we probably should just always drop the x-.  We can always declare
debugging purpose for all -global migration.* fields.

> 
> > Shall we just leave it there?  Or is deprecating it helps us in any form?
> 
> See the patches two weeks ago when people complained that lisen(.., num)
> was too low.  And there are other parameters that work the same way
> (that I convenientely had forgotten).  So the easiest way to get things
> right is to use "defer" always.  Using -incoming "uri" should only be
> for people that "know what they are doing", so we had to ways to do it:
> - review all migration options and see which ones work without defer
>   and document it
> - deprecate everything that is not defer.
> 
> Anything else is not going to be very user unfriendly.
> What do you think.

IIRC Wei Wang had a series just for that, so after that patchset applied we
should have fixed all issues cleanly?  Is there one more thing that's not
working right there?

> 
> Later, Juan.
> 
> PD.  This series are RFC for multiple reasons O:-)

Happy to know the rest (besides which I know will break my script :).

-- 
Peter Xu


