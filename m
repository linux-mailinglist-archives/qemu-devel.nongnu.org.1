Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1127F293F
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 10:48:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5NMs-0006hU-F6; Tue, 21 Nov 2023 04:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5NMm-0006hC-H5
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 04:48:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5NMk-0006lR-Pp
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 04:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700560101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dg78p7I8HoI1MOkFd1x9bWs1iRBacwar9rP7stYY5WU=;
 b=Dl6CaJAVc4dKFK0SLqbjAawIjhKOR4Ldl6qNyXnzQfj+9ON/RWPxyKnbsMGNkfW7DPr6UI
 EZfxomqF+JeK5FBoXoVbG5faq6YwoPTrel9o/eMrN7KxQfT8Mzhf10sh19j2M+xfra2ukI
 mCctCSbLLr//fnIL/kxKCCeMoh/Ge5s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-j6sS6REMP6KT0q0n2XZ4AQ-1; Tue,
 21 Nov 2023 04:48:15 -0500
X-MC-Unique: j6sS6REMP6KT0q0n2XZ4AQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9F471C0758E;
 Tue, 21 Nov 2023 09:48:14 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F0B6C1596F;
 Tue, 21 Nov 2023 09:48:13 +0000 (UTC)
Date: Tue, 21 Nov 2023 10:48:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org,
 shentey@gmail.com, Rene Engel <ReneEngel80@emailn.de>
Subject: Re: [PATCH v3 0/4] ide: implement simple legacy/native mode
 switching for PCI IDE controllers
Message-ID: <ZVx83ISREUVBy/TR@redhat.com>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
 <c4bb80e8-e985-b6b2-aac1-f6e8d446b8ea@eik.bme.hu>
 <295aec31-e9c1-49d8-9bea-edad8f7b81e4@ilande.co.uk>
 <63ff9c1a-5d05-985a-bf2f-69420b72db90@eik.bme.hu>
 <ZVtiV8XXHxS+cw8o@redhat.com>
 <b9ea9c20-f9a5-9b79-6e70-624665fb5148@eik.bme.hu>
 <ZVt0B1pSsWWK7ReX@redhat.com>
 <085a9043-6850-0022-1f7c-ebf365b5570c@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <085a9043-6850-0022-1f7c-ebf365b5570c@eik.bme.hu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 20.11.2023 um 16:11 hat BALATON Zoltan geschrieben:
> On Mon, 20 Nov 2023, Kevin Wolf wrote:
> > Am 20.11.2023 um 14:47 hat BALATON Zoltan geschrieben:
> > > On Mon, 20 Nov 2023, Kevin Wolf wrote:
> > > > Am 20.11.2023 um 14:09 hat BALATON Zoltan geschrieben:
> > > > > On Mon, 20 Nov 2023, Mark Cave-Ayland wrote:
> > > > > > The only difference I can think of regarding the BAR zeroing is that the
> > > > > > BMDMA BAR is zeroed here. Does the following diff fix things?
> > > > > 
> > > > > This helps, with this the latest driver does not crash but still reads BAR4
> > > > > as 0 instead of 0xcc00 so UDMA won't work but at least it boots.
> > > > 
> > > > And disabling only the first four BARs is actually what the spec says,
> > > > too. So I'll make this change to the queued patches.
> > > > 
> > > > If I understand correctly, UDMA didn't work before this series either,
> > > > so it's a separate goal and doing it in its own patch is best anyway.
> > > 
> > > UDMA works with my original series, did not work with earlier versions of
> > > this alternative from Mark but could be fixed up on top unless Mark can send
> > > a v4 now.
> > > 
> > > > As we don't seem to have a good place to set a default, maybe just
> > > > overriding it in via_ide_cfg_read(), too, and making it return 0xcc01 in
> > > > compatibility mode is enough?
> > > 
> > > I could give that a try and see if that helps but all this
> > > via_ide_cfg_read() seems like an unnecessary complication to me. Why can't
> > > we just set the BARs (o for BAR1-3 and default for BAR4) then we don't need
> > > to override config read?
> > 
> > I would be fine with setting 0xcc00 as the default value for BAR 4, but
> > as you said yourself, we can't do that in reset because it will be
> > overwritten by the PCI core code. Where else could we meaningfully do
> > that? As far as I understand, we don't have any hint that the
> > native/compatibility mode switch resets it on real hardware, so I'm
> > hesitant to do it there (and if the guest OS doesn't even switch, it
> > would never get set).
> 
> Luckily machines which need legacy mode also seem to set it explicitly
> on startup so we can set the defaults there.

With machines, you mean the QEMU board code? Where does this happen? Or
just what guests usually do?

> The check to see if something changed the BARs before is enough to
> avoid breaking it when legacy mode is set after native mode which does
> not seem to reset BARs according to how pegasos2 Linux behaves that
> sets legacy mode after firmware set native and proframmed BARs but the
> keep using BAR addresses. The AmigaOne I think just uses the default
> values with setting legacy mode doing nothing as that's the default
> but we can detect this as setting legacy mode with BARs unset so
> that's a good place to set default values which is what my patch did
> and I added a lot of comments trying to explain this.

I guess it's a question of your philosophy if you focus on just making a
specific set of OSes work, or if you focus on trying to do what hardware
actually does. Of course, figuring out what hardware actually does
proved a bit harder than I would have hoped in this case.

> > As for BAR 0-3, didn't we conclude that the via device still accepts I/O
> > to the configured addresses even though they read as zeros? Having
> > inconsistent config space and PCIIORegion seems like a bad idea, the
> > next call to pci_update_mappings() would break it.
> 
> I don't quite get this but then we could also just leave BARs alone
> and it would still work.

Didn't we have config space dumps from real hardware that showed that
this isn't what it does? Otherwise, this would be simpler indeed.

Of course, the spec also mandates that the values in the first four BARs
are ignored in compatibility mode (i.e. we would have to unregister the
memory regions), but we already figured that the via controller doesn't
do this. So that's something we would only have to solve if we want pci.c
code to be actually generic, but not for via.

> It probably does not matter what it reads back when the device is in
> legacy mode. What would call pci_update_mappings() if device is in
> legacy and if something switches it to native it will very likely also
> program BARs. I can't imagine what would want to turn on native mode
> without trying to use a PCI driver and program BARs.

For example, I see vmstate_info_pci_config -> get_pci_config_device ->
pci_update_mappings. Would live migration be enough to trigger this?

Maybe the relevant machines don't even support live migration (I haven't
checked), but it just doesn't feel robust to have inconsistent values in
data structures that are supposed to be in sync.

Kevin


