Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB827B058E
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 15:36:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlUhI-00044i-Nj; Wed, 27 Sep 2023 09:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlUhG-00043u-HH
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlUhE-00083l-SO
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695821719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xyGYuLnuyOUDVoFF1RfMOQlmnpsVLg48LO6adNxcWs=;
 b=bbU7tnjQBWFWlu2FD+wtJ3Fyo/i9klDTu/IFdG8i5GNNXFUpr+bg7uhZ5xW/osKCN4o3zT
 Z+GrW+CxWh3TVF9QKQycKEF6571giDGuC1Cn2z8tX7Pw7TcKlTVpFlfTfzzQR555c8SHJ2
 QR8+swoLDT6c/YbKLT0zis+Pu8Sycz0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-dBPeTSeCNHaMGgy6vMRH8Q-1; Wed, 27 Sep 2023 09:35:16 -0400
X-MC-Unique: dBPeTSeCNHaMGgy6vMRH8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0A34803508;
 Wed, 27 Sep 2023 13:35:15 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A04FA2026D4B;
 Wed, 27 Sep 2023 13:35:14 +0000 (UTC)
Date: Wed, 27 Sep 2023 08:35:12 -0500
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: andrey.drobyshev@virtuozzo.com, qemu-devel@nongnu.org, 
 kwolf@redhat.com, philmd@linaro.org
Subject: Re: [PATCH] mailmap: Fix Andrey Drobyshev author email
Message-ID: <idfl7u5m6cpzbbxtfuxbrjzf2nadlgnizfg67a3jvepob43t7c@taiwdoxwylkq>
References: <20230926102801.512107-1-andrey.drobyshev@virtuozzo.com>
 <f27kkumticbgf6m2cvzggtnh5ikcfoexeeo2xs4lrim7muulq6@7kuhh475fffy>
 <CAFEAcA85LwsFiBxbDiki6-8FAbmZSFFH7Esf+x8stiPDjww_KA@mail.gmail.com>
 <o4gb5k2pa2h7krwvstec2qdfvrsnzlc2l3q3da476bofdepazf@mzqnyast5uw5>
 <CAFEAcA81BGW46oMiC4u3oB5d+CJrTo-p6R_397-R0fAFaDz3Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA81BGW46oMiC4u3oB5d+CJrTo-p6R_397-R0fAFaDz3Qw@mail.gmail.com>
User-Agent: NeoMutt/20230517-449-a10573
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Wed, Sep 27, 2023 at 01:41:41PM +0100, Peter Maydell wrote:
> On Tue, 26 Sept 2023 at 20:42, Eric Blake <eblake@redhat.com> wrote:
> >
> > On Tue, Sep 26, 2023 at 02:46:44PM +0100, Peter Maydell wrote:
> > > What did you mean by "we prefer to avoid adding more entries" ?
> > > It reads to me like "don't add more entries even if we get more
> > > accidental attributed-to-the-list commits" (and I was actually
> > > thinking about replying to this patch to say "the mailmap file
> > > says we shouldn't add more of these lines"), but presumably since
> > > you've reviewed this patch that wasn't the actual intention.
> > > Maybe the comment could use clarification.
> >
> > Indeed, it is meant more along the lines of "because our build process
> > was tweaked to warn us in advance of merging more commits that suffer
> > from the same problem, we shouldn't be having to continually increase
> > the size of this section", or even "if you end up adding a line here,
> > please also take the time to figure out what part of our build process
> > failed to catch it in advance" (in this particular instance, the
> > failure was effectively that we were grepping for 'via qemu-devel',
> > not 'via qemu-.*').
> 
> I've adjusted the line in the apply-pullreq script:
> https://git.linaro.org/people/pmaydell/misc-scripts.git/commit/?id=f9a317392e83c84e4fdfcff554f64da3dfb7907b
> 
> Richard, Stefan: you probably want to update your copies.
> 
> (I also noticed we have a few commits from 2021 that were
> attributed to qemu-ppc@nongnu.org.)

All from BALATON Zoltan; I'll add a .mailmap entry for that as a v2
post for my other thread on tweaking the .mailmap comment.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


