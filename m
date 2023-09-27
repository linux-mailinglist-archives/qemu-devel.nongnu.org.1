Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E71D7B0635
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 16:07:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlVBr-0004pM-E8; Wed, 27 Sep 2023 10:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlVBp-0004ou-Ck
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlVBn-0002kh-2u
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695823613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPGNQvknATW/BdBcZ/iMBceyfdKznF1WEfYvwP1SxM4=;
 b=fGpzMqKQZCAI8CwEfVBZV/gIG02QWmUr5sHa9QwyX2fUfUVvHKP/jQLBEPt8nRZ4H7Vttr
 HgLAnx5EE8KptUnSDIuVWVHhBriuASVKT/unzVnqxDRBE0guFVvudZiTyioMqC01p01Q9S
 KQ7scEHMin1gwUfYyEEv/Zhs5mS3ofw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-5iIs8nqLOnGr7GpZS6dd0Q-1; Wed, 27 Sep 2023 10:06:48 -0400
X-MC-Unique: 5iIs8nqLOnGr7GpZS6dd0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16E493C1F141;
 Wed, 27 Sep 2023 14:06:48 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DADEC1678B;
 Wed, 27 Sep 2023 14:06:46 +0000 (UTC)
Date: Wed, 27 Sep 2023 09:06:45 -0500
From: Eric Blake <eblake@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] maint: Tweak comment in mailmap to sound friendlier
Message-ID: <tewmhssbdcsu27k2qgpsk7ffu5uxpbnxl7vml5ox4fpxrz5nnp@5alfgqinlq7t>
References: <20230926203946.3303600-2-eblake@redhat.com>
 <a8d61378-3dcb-45e5-95dd-95fb9e1e0da8@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8d61378-3dcb-45e5-95dd-95fb9e1e0da8@virtuozzo.com>
User-Agent: NeoMutt/20230517-449-a10573
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Sep 27, 2023 at 01:34:40PM +0300, Andrey Drobyshev wrote:
> On 9/26/23 23:39, eblake@redhat.com wrote:
> > From: Eric Blake <eblake@redhat.com>
> > 
> > Documenting that we should not add new lines to work around SPF
> > rewrites sounds foreboding; the intent is instead that new lines here
> > are okay, but indicate a second problem elsewhere in our build process
> > that we should also consider fixing at the same time, to keep the
> > section from growing without bounds.
> > 
> > Mentioning DMARC alongside SPF may also help people grep for this
> > scenario, as well as documenting the 'git config' workaround that can
> > be used by submitters to avoid the munging issue in the first place.
> > 
> > Fixes: 3bd2608d ("maint: Add .mailmap entries for patches claiming list authorship")
> > CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> > 
> > I'm sending this email with a temporary 'git config sendemail.from
> > eblake@redhat.com', to see if the added advice actually adds the extra
> > line. It did not show up in my editor window, though, so this patch
> > may need further tweaking to get the instructions right.  Since I
> > don't normally suffer from SPF/DMARC munging, I may not be the best
> > person to test the right workaround.  Or maybe 'git config' does not
> > yet have the right workaround already available as a turnkey solution
> > we can suggest.
> > 
> 
> The only drawback of this approach is that mail clients, as well as
> tools like patchew.org now only show your "<email>" in From/Author
> field.  You can see it here:
> 
> https://patchew.org/search?q=project%3AQEMU+from%3ABlake

Indeed.  But I think I know more now, so I'll try something slightly
different in v2.

> 
> In your email there're 2 "From:" fields now:
> 
> > Headers...
> > From: eblake@redhat.com
> > More headers...
> > From: Eric Blake <eblake@redhat.com>
> > Actual patch

Not quite - if you read the raw email, notice the blank line, which
separate true headers from the body.  That is, the headers are:

| From: eblake@redhat.com
| More headers...
| Subject:

while the body starts:

| From: Eric Blake <eblake@redhat.com>
| 
| rest of actual patch

'git am' is already smart enough to prioritize the body's From: line
over mail headers when re-creating authorship for a patch being
imported into a maintainer's tree.  But patchew currently favors the
email headers in its attributions.

> 
> Apparently, mail clients prefer to pay attention on the very first
> "From:" entry, while tools like "git am" -- on the last.  If we managed
> to make those entries both be in the format "name <email>" -- that'd be
> ideal.  However, as I pointed out in another thread, if we set
> sendemail.from to "name <email>", the 2nd entry doesn't get added since
> they're now identical.  So you figure out the way to get 2 identical
> "From:" entries -- please let us know.

My current working theory (to be tested in my upcoming v2 posting) is
that git compares two values: the author attribution (composed from
'git config user.name' and 'git config user.email'), and the sendemail
attribution (directly from 'git config sendemail.from').  If the two
differ, then git format-email produces the one-liner 'From: real
author <real@email>' based on commit authorship info as the first line
in the body of the message; if they are the same (including when
sendemail.from is missing, so git assumes you are sending your own
patch and that your MUA will supply the same name), the body line is
omitted.  Meanwhile, when git feeds a file into sendemail, it omits a
From: header by default (relying on your MUA to supply one - and your
MUA probably picks the same spelling as your authorship), but includes
a From: header (which generally overrides your MUA's default) verbatim
from sendemail.from if that was set, regardless of commit authorship
info.

That would explain whey when you set sendemail.from to list your full
name and email, you didn't get a body From: line.  And when you omit
the real name in sendemail.from, the two definitely differ, so git
includes the body From: (I just demonstrated that when I posted this
v1).  But it may still be possible to force author attribution to be
slightly different to sendemail.from, but still having a name in the
From: line, so that patchew doesn't see a bare email without a name,
all by intentionally spelling things differently.  So my attempt for
my v2 patch, my settings will be:

[user]
        name = Eric Blake
        email = eblake@redhat.com
[sendemail]
        from = "Eric Blake" <eblake@redhat.com>

with the hope that the addition of quotes (a semantic no-op from
email's point of view, but a different spelling from git's point of
view) would be enough to cause git send-email to include a body From:
line.  Fingers crossed while I test it...

> 
> Having all that said, it would still be nice to have additional checks
> for "qemu-block@nongnu.org" authorship, as Peter mentioned in the
> previous thread.

Yes, Peter found the spot, and mentioned his fix in the other thread.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


