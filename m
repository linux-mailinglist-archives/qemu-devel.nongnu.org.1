Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDA07E484A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:32:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QsN-0002j9-01; Tue, 07 Nov 2023 13:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0QsL-0002iU-4W
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0QsJ-0007MO-Ir
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699381950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pLej2qZPJWEsDysUM3T28GcEmOLX/H7OnNWo/me/tpU=;
 b=Bv2KLu8yiNOHDj26dcs5js678BsGNPTGUKfognmG46H9fzbn9BystbH9xbO1DBveSuScKo
 WeFkAxdwBhpnNlB93xxiKNB9oE/eZcR9TV/QAZZq2pnW61Jp88sUNR0s7co5dnfwPSUtnE
 t99DTAVfTIpoRCi4nMVGfJQ9GKhwy0o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-kBlXCyriNbqWYPhyZOiP3A-1; Tue,
 07 Nov 2023 13:32:27 -0500
X-MC-Unique: kBlXCyriNbqWYPhyZOiP3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC53B380607E;
 Tue,  7 Nov 2023 18:32:21 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B78A2166B26;
 Tue,  7 Nov 2023 18:32:20 +0000 (UTC)
Date: Tue, 7 Nov 2023 19:32:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Niklas Cassel <nks@flawful.org>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Damien Le Moal <dlemoal@kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH v2] hw/ide/ahci: fix legacy software reset
Message-ID: <ZUqCszEpl/Xb0KOS@redhat.com>
References: <20231005100407.1136484-1-nks@flawful.org>
 <ZUp+b6pHoov9Qbc6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUp+b6pHoov9Qbc6@redhat.com>
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

Am 07.11.2023 um 19:14 hat Kevin Wolf geschrieben:
> Am 05.10.2023 um 12:04 hat Niklas Cassel geschrieben:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> > 
> > Legacy software contains a standard mechanism for generating a reset to a
> > Serial ATA device - setting the SRST (software reset) bit in the Device
> > Control register.
> > 
> > Serial ATA has a more robust mechanism called COMRESET, also referred to
> > as port reset. A port reset is the preferred mechanism for error
> > recovery and should be used in place of software reset.
> > 
> > Commit e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
> > improved the handling of PxCI, such that PxCI gets cleared after handling
> > a non-NCQ, or NCQ command (instead of incorrectly clearing PxCI after
> > receiving an arbitrary FIS).
> > 
> > However, simply clearing PxCI after a non-NCQ, or NCQ command, is not
> > enough, we also need to clear PxCI when receiving a SRST in the Device
> > Control register.
> > 
> > This fixes an issue for FreeBSD where the device would fail to reset.
> > The problem was not noticed in Linux, because Linux uses a COMRESET
> > instead of a legacy software reset by default.
> > 
> > Fixes: e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
> > Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> > Changes since v1: write the D2H FIS before clearing PxCI.
> > 
> >  hw/ide/ahci.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> > index babdd7b458..7269dabbdb 100644
> > --- a/hw/ide/ahci.c
> > +++ b/hw/ide/ahci.c
> > @@ -1254,10 +1254,26 @@ static void handle_reg_h2d_fis(AHCIState *s, int port,
> >          case STATE_RUN:
> >              if (cmd_fis[15] & ATA_SRST) {
> >                  s->dev[port].port_state = STATE_RESET;
> > +                /*
> > +                 * When setting SRST in the first H2D FIS in the reset sequence,
> > +                 * the device does not send a D2H FIS. Host software thus has to
> > +                 * set the "Clear Busy upon R_OK" bit such that PxCI (and BUSY)
> > +                 * gets cleared. See AHCI 1.3.1, section 10.4.1 Software Reset.
> > +                 */
> > +                if (opts & AHCI_CMD_CLR_BUSY) {
> > +                    ahci_clear_cmd_issue(ad, slot);
> > +                }
> 
> I suspect that AHCI_CMD_CLR_BUSY really should be checked in a more
> generic place, but this will do for fixing software reset.
> 
> >              }
> >              break;
> >          case STATE_RESET:
> >              if (!(cmd_fis[15] & ATA_SRST)) {
> > +                /*
> > +                 * When clearing SRST in the second H2D FIS in the reset
> > +                 * sequence, the device will send a D2H FIS. See SATA 3.5a Gold,
> > +                 * section 11.4 Software reset protocol.
> > +                 */
> > +                ahci_clear_cmd_issue(ad, slot);
> > +                ahci_write_fis_d2h(ad, false);
> >                  ahci_reset_port(s, port);
> 
> This part isn't mentioned in the commit message at all, and I don't see
> how it's related to commit e2a5d9b3d9c3 either. Is this supposed to be a
> bonus fix?
> 
> ahci_reset_port() already calls ahci_init_d2h() -> ahci_write_fis_d2h().
> So I think this new ahci_write_fis_d2h() only sets some state that will
> immediately be overwritten again. Which is good, because we didn't set
> the signature as described in the SATA software reset protocol yet, that
> is only done in ahci_reset_port().
> 
> Am I missing something? Why do we need this ahci_write_fis_d2h() call
> here?
> 
> As for the ahci_clear_cmd_issue(), I'm surprised that ahci_reset_port()
> doesn't already clear the register. Wouldn't it make more sense there
> than just in this one caller?

The other thing I wondered and forgot to actually write is if we should
extend ahci-test to include port and software resets.

Kevin


