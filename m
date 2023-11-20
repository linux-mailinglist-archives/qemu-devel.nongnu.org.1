Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B44C77F1491
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 14:44:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r54YJ-0000Fx-0l; Mon, 20 Nov 2023 08:43:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r54YG-0000FA-Ps
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 08:43:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r54YC-0001Dy-Rv
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 08:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700487776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MTg8xXl3K/KKajN8KRjwgK1+/HyxLRXZXQ/6TB0oAMM=;
 b=Jt3WeZ9wI5oL1NAtfODUT3V39E0upFSyi7jueDl/tnJKUxpYri01P2LFoO8fG79y10hJVR
 X3jBdKk9yNxRdSwNJuTVkojKwLP1jZBSb4bLQNrcnC3Q00eMLXWLcw92tKNcUx4ZQQu6VS
 kOv25wvTk3X93yJHWG+a9QjYEGo9yl4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-mBgKMohoPQSTa7LJoPLtTg-1; Mon,
 20 Nov 2023 08:42:52 -0500
X-MC-Unique: mBgKMohoPQSTa7LJoPLtTg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06B76280AA22;
 Mon, 20 Nov 2023 13:42:52 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97188492BFC;
 Mon, 20 Nov 2023 13:42:50 +0000 (UTC)
Date: Mon, 20 Nov 2023 14:42:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org,
 shentey@gmail.com, Rene Engel <ReneEngel80@emailn.de>
Subject: Re: [PATCH v3 0/4] ide: implement simple legacy/native mode
 switching for PCI IDE controllers
Message-ID: <ZVtiV8XXHxS+cw8o@redhat.com>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
 <c4bb80e8-e985-b6b2-aac1-f6e8d446b8ea@eik.bme.hu>
 <295aec31-e9c1-49d8-9bea-edad8f7b81e4@ilande.co.uk>
 <63ff9c1a-5d05-985a-bf2f-69420b72db90@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63ff9c1a-5d05-985a-bf2f-69420b72db90@eik.bme.hu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 20.11.2023 um 14:09 hat BALATON Zoltan geschrieben:
> On Mon, 20 Nov 2023, Mark Cave-Ayland wrote:
> > On 19/11/2023 21:43, BALATON Zoltan wrote:
> > > On Thu, 16 Nov 2023, Mark Cave-Ayland wrote:
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
> > > >  hw/ide/pci.c
> > > > - Don't zero BARs when switching from native mode to legacy
> > > > mode, instead always force
> > > >  them to read zero as suggested in the PCI IDE specification
> > > > (note: this also appears
> > > >  to fix the fuloong2e machine booting from IDE)
> > > 
> > > Not sure you're getting this, see also:
> > > https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg04167.html
> > > but this seems to break latest version of the AmigaOS driver for
> > > some reason. I assume this is the BAR zeroing that causes this as it
> > > works with v2 series and nothing else changed in v3 that could cause
> > > this. Testing was done by Rene Engel, cc'd so maybe he can add more
> > > info. It seems to work with my patch that sets BARs to legacy values
> > > and with v2 that sets them to 0 but not with v3 which should also
> > > read 0 but maybe something is off here.
> > 
> > I've been AFK for a few days, so just starting to catch up on various
> > bits and pieces.
> 
> OK just wasn't sure if you saw my emails at all as it happened before that
> some spam filters disliked my mail server and put messages in the spam
> folder.
> 
> > The only difference I can think of regarding the BAR zeroing is that the
> > BMDMA BAR is zeroed here. Does the following diff fix things?
> 
> This helps, with this the latest driver does not crash but still reads BAR4
> as 0 instead of 0xcc00 so UDMA won't work but at least it boots.

And disabling only the first four BARs is actually what the spec says,
too. So I'll make this change to the queued patches.

If I understand correctly, UDMA didn't work before this series either,
so it's a separate goal and doing it in its own patch is best anyway.

As we don't seem to have a good place to set a default, maybe just
overriding it in via_ide_cfg_read(), too, and making it return 0xcc01 in
compatibility mode is enough?

Kevin


