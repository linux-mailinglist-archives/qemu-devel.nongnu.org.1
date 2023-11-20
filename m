Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F33E37F1020
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 11:18:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r51LZ-0007Lv-IK; Mon, 20 Nov 2023 05:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r51LN-0007LE-1T
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 05:17:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r51L8-0004J2-Ka
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 05:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700475430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q8qRhDqna7F2j2FCsrOtNOg2vntTQD9P7Di01HnprCY=;
 b=ATUT01EjBsM8Z8cJOdwK+tRU+C4UIDDrVt8JQ+Kt+PnTO3PbOSwBh+AP5+YyLIWF9ngdl+
 zOszdwzbmPcjJaJQD1DPc3m49Kmv8OjzQ+vrxRkxD4f3VzZEiJkrT4mbWTdphzv5LgJFJf
 2Ud7Ei/mhAdrHScuqinEDYJtzCE6Mkw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-7Pc7f9uxNeCslyldl4Cxmg-1; Mon, 20 Nov 2023 05:17:03 -0500
X-MC-Unique: 7Pc7f9uxNeCslyldl4Cxmg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49ECC84AEE2;
 Mon, 20 Nov 2023 10:17:03 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEBE81C060B0;
 Mon, 20 Nov 2023 10:17:01 +0000 (UTC)
Date: Mon, 20 Nov 2023 11:17:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org,
 shentey@gmail.com
Subject: Re: [PATCH v3 0/4] ide: implement simple legacy/native mode
 switching for PCI IDE controllers
Message-ID: <ZVsyHHMZKhmNZU/7@redhat.com>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
 <ZVYdkaQ5DcTHxhnJ@redhat.com>
 <c29fa245-fbb6-ff76-7836-7447c845cf9f@eik.bme.hu>
 <48c8863d-6534-eae2-4cba-089cc4fb6a6d@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48c8863d-6534-eae2-4cba-089cc4fb6a6d@eik.bme.hu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Am 17.11.2023 um 15:23 hat BALATON Zoltan geschrieben:
> On Thu, 16 Nov 2023, BALATON Zoltan wrote:
> > On Thu, 16 Nov 2023, Kevin Wolf wrote:
> > > Am 16.11.2023 um 11:33 hat Mark Cave-Ayland geschrieben:
> > > > This series adds a simple implementation of legacy/native mode
> > > > switching for PCI
> > > > IDE controllers and updates the via-ide device to use it.
> > > > 
> > > > The approach I take here is to add a new pci_ide_update_mode()
> > > > function which handles
> > > > management of the PCI BARs and legacy IDE ioports for each mode
> > > > to avoid exposing
> > > > details of the internal logic to individual PCI IDE controllers.
> > > > 
> > > > As noted in [1] this is extracted from a local WIP branch I have
> > > > which contains
> > > > further work in this area. However for the moment I've kept it simple (and
> > > > restricted it to the via-ide device) which is good enough for Zoltan's PPC
> > > > images whilst paving the way for future improvements after 8.2.
> > > > 
> > > > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > > 
> > > > [1] https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg05403.html
> > > > 
> > > > v3:
> > > > - Rebase onto master
> > > > - Move ide_portio_list[] and ide_portio_list2[] to IDE core to
> > > > prevent duplication in
> > > >   hw/ide/pci.c
> > > > - Don't zero BARs when switching from native mode to legacy
> > > > mode, instead always force
> > > >   them to read zero as suggested in the PCI IDE specification
> > > > (note: this also appears
> > > >   to fix the fuloong2e machine booting from IDE)
> > > > - Add comments in pci_ide_update_mode() suggested by Kevin
> > > > - Drop the existing R-B and T-B tags: whilst this passes my
> > > > local tests, the behaviour
> > > >   around zero BARs feels different enough here
> > > 
> > > Thanks, applied to the block branch.
> > 
> > I feel a bit left out of this conversation... Did Google or some other
> > spam filter decide again to filter my messages so you did not see them
> > at all? Could you confitm that you've got my previous two replies in
> > this thread so I know I'm not sending comments to /dev/null please?
> 
> Looks like there's some issue with these mails. They appear in the list
> archive but maybe not in people's mailboxes? Did any of you got this message
> and previous ones I've sent?
> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03180.html
> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03983.html

I received it, but at least the second one only after sending the mail
you replied to here.

For your specific concern, it seems to me that resetting BAR 4 on a
switch between compatibility mode and native mode is another via quirk
and should therefore be implemented in via.c rather than pci.c?

If I get a new version of the patches in the next few hours, I can
update the queued patches before sending a pull request, but otherwise
this can still be done in a separate patch.

Kevin


