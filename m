Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C7B7AF44A
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 21:43:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlDx0-0001Zt-UX; Tue, 26 Sep 2023 15:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlDwz-0001ZE-96
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlDwx-0007xu-A0
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695757346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aAfocUZko+sLK38tAtMHyrELlApEPhgfVIFZstzVDg4=;
 b=YBg0WB0c7bql/ZOjTcauJYSG7oJs/ZBhx2XhoDyIKd17k1lyeMjAiTSMY86XPxscunjkoP
 lJN9HY//4GQ3YXszPvtuSSB3Ru1Tmwxb5kNoGFHYl7lrWoD+xkyv31Fk/d0DofGFcurOc2
 vHek61iv0UZAEHO4qvQhLcUFE+ZGxho=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-8pqlz-VdPkGxLcZQQ9CeZQ-1; Tue, 26 Sep 2023 15:42:22 -0400
X-MC-Unique: 8pqlz-VdPkGxLcZQQ9CeZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9DD9801779;
 Tue, 26 Sep 2023 19:42:21 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADDBF2156702;
 Tue, 26 Sep 2023 19:42:20 +0000 (UTC)
Date: Tue, 26 Sep 2023 14:42:19 -0500
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: andrey.drobyshev@virtuozzo.com, qemu-devel@nongnu.org, 
 kwolf@redhat.com, philmd@linaro.org
Subject: Re: [PATCH] mailmap: Fix Andrey Drobyshev author email
Message-ID: <o4gb5k2pa2h7krwvstec2qdfvrsnzlc2l3q3da476bofdepazf@mzqnyast5uw5>
References: <20230926102801.512107-1-andrey.drobyshev@virtuozzo.com>
 <f27kkumticbgf6m2cvzggtnh5ikcfoexeeo2xs4lrim7muulq6@7kuhh475fffy>
 <CAFEAcA85LwsFiBxbDiki6-8FAbmZSFFH7Esf+x8stiPDjww_KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA85LwsFiBxbDiki6-8FAbmZSFFH7Esf+x8stiPDjww_KA@mail.gmail.com>
User-Agent: NeoMutt/20230517-449-a10573
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Sep 26, 2023 at 02:46:44PM +0100, Peter Maydell wrote:
> On Tue, 26 Sept 2023 at 14:40, Eric Blake <eblake@redhat.com> wrote:
> >
> > On Tue, Sep 26, 2023 at 01:28:01PM +0300, andrey.drobyshev@virtuozzo.com wrote:
> > > From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> > >
> > > This fixes authorship of commits 2848289168, 52b10c9c0c as the mailing
> > > list rewrote the "From:" field in the corresponding patches.  See commit
> > > 3bd2608db7 ("maint: Add .mailmap entries for patches claiming list
> > > authorship") for explanation.
> > >
> > > Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> > > ---
> > >  .mailmap | 1 +
> > >  1 file changed, 1 insertion(+)
> >
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Hi Eric -- you wrote commit 3bd2608db72997, which included the
> comment for this bit of .mailmap:
> 
> +# Next, translate a few commits where mailman rewrote the From: line due
> +# to strict SPF, although we prefer to avoid adding more entries like that.
> 
> What did you mean by "we prefer to avoid adding more entries" ?
> It reads to me like "don't add more entries even if we get more
> accidental attributed-to-the-list commits" (and I was actually
> thinking about replying to this patch to say "the mailmap file
> says we shouldn't add more of these lines"), but presumably since
> you've reviewed this patch that wasn't the actual intention.
> Maybe the comment could use clarification.

Indeed, it is meant more along the lines of "because our build process
was tweaked to warn us in advance of merging more commits that suffer
from the same problem, we shouldn't be having to continually increase
the size of this section", or even "if you end up adding a line here,
please also take the time to figure out what part of our build process
failed to catch it in advance" (in this particular instance, the
failure was effectively that we were grepping for 'via qemu-devel',
not 'via qemu-.*').  If wording along those lines is better, or if you
have other ideas, I'm happy to turn it into a formal commit to improve
the comment in that file.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


