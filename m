Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0427B0759
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 16:53:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlVt1-00029t-50; Wed, 27 Sep 2023 10:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlVsz-00029d-Ud
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlVsy-0005nZ-0S
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695826289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rwgjGVGNhziBXvrcC08MnjPWI3HCwgAwNQISqq/t9BE=;
 b=S5IgddfWDrjU/EV57py5d9QgnTbEcLgTeq09S6mbIaFvbAL6ACdOZoY0lwngUDsTmX1w+Z
 5jHIhFIV7G3gI/5sJ/HIWu2Xvsm9IELol1Xk/QwLkG9ajmPHXPDY1xQQgURh2cIJu7XAhR
 lLTAPytBPzKGgAlxXua5MluqfYXu918=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-64SEfrU6NrO-JD5jk3Rbrg-1; Wed, 27 Sep 2023 10:51:25 -0400
X-MC-Unique: 64SEfrU6NrO-JD5jk3Rbrg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B02CF3C1F13C;
 Wed, 27 Sep 2023 14:51:22 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82B77170EC;
 Wed, 27 Sep 2023 14:51:19 +0000 (UTC)
Date: Wed, 27 Sep 2023 09:51:14 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, andrey.drobyshev@virtuozzo.com, 
 peter.maydell@linaro.org
Subject: Re: [PATCH v2 2/3] maint: Tweak comments in mailmap regarding SPF
Message-ID: <vxsambixsenjs4owcv3dd3ayvo7jheadw7k2az42n7hfqyvo3y@herwnvhec3hn>
References: <20230927143815.3397386-5-eblake@redhat.com>
 <20230927143815.3397386-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927143815.3397386-7-eblake@redhat.com>
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

On Wed, Sep 27, 2023 at 09:38:18AM -0500, Eric Blake wrote:
> From: Eric Blake <eblake@redhat.com>
> 
> Documenting that we should not add new lines to work around SPF
> rewrites sounds foreboding; the intent is instead that new lines here
> are okay, but indicate a second problem elsewhere in our build process
> that we should also consider fixing at the same time, to keep the
> section from growing without bounds.  While we have been doing that
> for qemu-devel for a while, we jut recently fixed that for qemu-block:
> https://git.linaro.org/people/pmaydell/misc-scripts.git/commit/?id=f9a317392
> 
> Mentioning DMARC alongside SPF may also help people grep for this
> scenario, as well as documenting the 'git config' workaround that can
> be used by submitters to avoid the munging issue in the first place.
> 
> Note the subtelty: 'git commit' sets authorship information based on

subtlety

> user.name and user.email (where name is usually unquoted); while 'git
> format-patch' includes a body 'From:' line only when sendemail.from is

s/format-patch/send-email/

The comments in the patch proper were correct, but the commit message
needs a tweak.  Based on my testing, 'git send-email --annotate'
invokes the editor on the output of an implicit 'git format-patch',
which does not have a body from line yet; it is the post-processing
step of send-email that finally adds it.

> present but differs from authorship information.  Hence the use of
> quotes in sendemail.from (not a semantic change to email, but enough
> of a difference to add the body 'From:').
> 
> Fixes: 3bd2608d ("maint: Add .mailmap entries for patches claiming list authorship")
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> Once again, sending this patch to the list with my git config
> temporarily changed.  I used a command line:
>  git config sendemail.from '"Eric Blake" <eblakeWredhat.com>'
> which turned into this in my .git/config:
> [sendemail]
>   from = \"Eric Blake\" <eblake@redhat.com>
> 
> My editor window in 'git send-email' doesn't show the body from line,
> but hopefully the list archives do (that is, the addition of a body
> From appears to be a post-processing step done by git after my editor
> window closes but before the final mail is actually shoved out my MUA)

Yay, it appears to have worked!

https://patchew.org/search?q=project%3AQEMU+from%3ABlake

lists this series under 'Eric Blake' rather than 'eblake@redhat.com';
and inspecting the mail headers shows that the "" were indeed present
in the headers, while git inserted a body From because it was not
identical to the actual commit authorship without quotes.

> ---
>  .mailmap | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 04a7feb005b..fadf6e74506 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -40,7 +40,19 @@ Nick Hudson <hnick@vmware.com> hnick@vmware.com <hnick@vmware.com>
>  # for the cvs2svn initialization commit e63c3dc74bf.
> 
>  # Next, translate a few commits where mailman rewrote the From: line due
> -# to strict SPF, although we prefer to avoid adding more entries like that.
> +# to strict SPF and DMARC.  Usually, our build process should be flagging
> +# commits like these before maintainer merges; if you find the need to add
> +# a line here, please also report a bug against the part of the build
> +# process that let the mis-attribution slip through in the first place.
> +#
> +# If the mailing list munges your emails, use:
> +#   git config sendemail.from '"Your Name" <your.email@example.com>'
> +# the use of "" in that line will differ from the typically unquoted
> +# 'git config user.name', which in turn is sufficient for 'git send-email'
> +# to add an extra From: line in the body of your email that takes
> +# precedence over any munged From: in the mail's headers.
> +# See https://lists.openembedded.org/g/openembedded-core/message/166515
> +# and https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg06784.html
>  Ed Swierk <eswierk@skyportsystems.com> Ed Swierk via Qemu-devel <qemu-devel@nongnu.org>
>  Ian McKellar <ianloic@google.com> Ian McKellar via Qemu-devel <qemu-devel@nongnu.org>
>  Julia Suvorova <jusual@mail.ru> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
> -- 
> 2.41.0
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


