Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E37E57D7
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 14:12:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0iKv-0005RG-IF; Wed, 08 Nov 2023 08:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0iKu-0005Nd-47
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 08:11:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0iKs-0005Wx-7q
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 08:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699449069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNgpOq9TgtAR1mYE3hw+NxfccaPHWdPrRmZDB8OUZh8=;
 b=NyMy/peGkn4Oxv1CGx5Y53unjpLG6OcC9Oj/ifJtKsKs+osPXYI9zwqUysbnbx1HEOXWcL
 +Ku3N+dvzZ3WVcUEhdlal56QPi+6S+31+Qcy5ZeSY64ej7zd2vjCg98YER1RcJXMGVgQDH
 TZ9/VZkqbWw19QluUv/jYZylZEqhJoA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-FCAdXndDMq2P6E55Mj_akw-1; Wed, 08 Nov 2023 08:11:03 -0500
X-MC-Unique: FCAdXndDMq2P6E55Mj_akw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EBE3101A52D;
 Wed,  8 Nov 2023 13:11:03 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 211392166B26;
 Wed,  8 Nov 2023 13:11:00 +0000 (UTC)
Date: Wed, 8 Nov 2023 14:10:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Niklas Cassel <nks@flawful.org>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Damien Le Moal <dlemoal@kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH v2] hw/ide/ahci: fix legacy software reset
Message-ID: <ZUuI41b5CnU8GlID@redhat.com>
References: <20231005100407.1136484-1-nks@flawful.org>
 <ZUp+b6pHoov9Qbc6@redhat.com> <ZUrO/tluTBjnPXHV@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUrO/tluTBjnPXHV@x1-carbon>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 08.11.2023 um 00:57 hat Niklas Cassel geschrieben:
> On Tue, Nov 07, 2023 at 07:14:07PM +0100, Kevin Wolf wrote:
> > Am 05.10.2023 um 12:04 hat Niklas Cassel geschrieben:
> > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > > 
> > > Legacy software contains a standard mechanism for generating a reset to a
> > > Serial ATA device - setting the SRST (software reset) bit in the Device
> > > Control register.
> > > 
> > > Serial ATA has a more robust mechanism called COMRESET, also referred to
> > > as port reset. A port reset is the preferred mechanism for error
> > > recovery and should be used in place of software reset.
> > > 
> > > Commit e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
> > > improved the handling of PxCI, such that PxCI gets cleared after handling
> > > a non-NCQ, or NCQ command (instead of incorrectly clearing PxCI after
> > > receiving an arbitrary FIS).
> > > 
> > > However, simply clearing PxCI after a non-NCQ, or NCQ command, is not
> > > enough, we also need to clear PxCI when receiving a SRST in the Device
> > > Control register.
> > > 
> > > This fixes an issue for FreeBSD where the device would fail to reset.
> > > The problem was not noticed in Linux, because Linux uses a COMRESET
> > > instead of a legacy software reset by default.
> > > 
> > > Fixes: e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
> > > Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> > > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > ---
> > > Changes since v1: write the D2H FIS before clearing PxCI.
> > > 
> > >  hw/ide/ahci.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> > > index babdd7b458..7269dabbdb 100644
> > > --- a/hw/ide/ahci.c
> > > +++ b/hw/ide/ahci.c
> > > @@ -1254,10 +1254,26 @@ static void handle_reg_h2d_fis(AHCIState *s, int port,
> > >          case STATE_RUN:
> > >              if (cmd_fis[15] & ATA_SRST) {
> > >                  s->dev[port].port_state = STATE_RESET;
> > > +                /*
> > > +                 * When setting SRST in the first H2D FIS in the reset sequence,
> > > +                 * the device does not send a D2H FIS. Host software thus has to
> > > +                 * set the "Clear Busy upon R_OK" bit such that PxCI (and BUSY)
> > > +                 * gets cleared. See AHCI 1.3.1, section 10.4.1 Software Reset.
> > > +                 */
> > > +                if (opts & AHCI_CMD_CLR_BUSY) {
> > > +                    ahci_clear_cmd_issue(ad, slot);
> > > +                }
> > 
> > I suspect that AHCI_CMD_CLR_BUSY really should be checked in a more
> > generic place, but this will do for fixing software reset.
> 
> This weirdo option "Clear Busy upon R_OK" is for the HBA itself to
> clear the bit for the command in PxCI, when it gets the R_OK that the
> Host to Device (H2D) FIS was transmitted successfully to the device.
> The normal way is that the device sends back a Device to Host (D2H) FIS
> which then causes the bit in PxCI to be cleared in the HBA.
> 
> Yes, theoretically you could probably build a FIS that has the "Clear
> Busy upon R_OK" even for e.g. a regular non-NCQ I/O command (where
> PxCI/BUSY is first supposed to be cleared once the command is
> done...), however this would surely cause problems as PxCI would then
> no longer shadow the state of the device.
> 
> If you search for "Clear Busy upon R_OK", the only usage seems
> to be for legacy software reset.
> [...]

Yes, looks like ignoring it otherwise is harmless.

> > ahci_reset_port() already calls ahci_init_d2h() -> ahci_write_fis_d2h().
> > So I think this new ahci_write_fis_d2h() only sets some state that will
> > immediately be overwritten again. Which is good, because we didn't set
> > the signature as described in the SATA software reset protocol yet, that
> > is only done in ahci_reset_port().
> > 
> > Am I missing something? Why do we need this ahci_write_fis_d2h() call
> > here?
> > 
> > As for the ahci_clear_cmd_issue(), I'm surprised that ahci_reset_port()
> > doesn't already clear the register. Wouldn't it make more sense there
> > than just in this one caller?
> 
> A start/stop of the engine (PxCMD.ST) does clear PxCI, as I implemented in:
> https://github.com/qemu/qemu/commit/d73b84d0b664e60fffb66f46e84d0db4a8e1c713
> 
> But according to AHCI 1.3.1, section:
> 3.3.14 Offset 38h: PxCI – Port x Command Issue
> 
> PxCI does also have a reset value of 0h.
> 
> So I would assume that it is okay to clear PxCI to zero also in
> ahci_reset_port().

Yes, that was what I thought.

> By doing so, we could avoid both the ahci_clear_cmd_issue(),
> and the ahci_write_fis_d2h(ad, false).
> 
> Perhaps you can drop the "bonus" part of my patch and simply
> add a pr->cmd_issue to ahci_reset_port()?

I agree that this is probably the best change to make.

If you also want to add that comment that there already is a D2H FIS
sent during reset, and maybe change the commit message to explain why
we're touching ahci_reset_port(), I think I would prefer if you sent a
v3. I'm usually happy to make small changes while applying, but it feels
like this would be a larger change than I would be comfortable making
without having it on the mailing list again.

Kevin


