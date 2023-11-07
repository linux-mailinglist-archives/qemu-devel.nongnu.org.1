Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CC97E4DA1
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 01:00:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Vy1-0008IZ-Md; Tue, 07 Nov 2023 18:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1r0Vxz-0008ID-C4; Tue, 07 Nov 2023 18:58:43 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1r0Vxw-0005Uy-Cc; Tue, 07 Nov 2023 18:58:43 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-507d1cc0538so8500738e87.2; 
 Tue, 07 Nov 2023 15:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699401517; x=1700006317;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :dkim-signature:dkim-signature:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MA+lcLUK9x0NL5ErdlicFRkOkeTj0kYupsFzQclCLac=;
 b=fytf4d47f+KfJgwVrnXjQOEnGfx/gO0CNblKIPn5dHN6eckXT1rYGtB5TyBaHbTUnT
 SzM6b4NIh08+c2iQRMKGOK7Ld4uQ/Z750z7aGOCbUxtZzH7UdS2BmG3kXOtg3x5n3vAk
 VgPz9FZP8XYe2vZn5ReTWMQMD3oqcC6Uw9KIQnyKkjyBgk0eC8+BcqDA7cf0eQcbBgx+
 tq7BsjLeDmXhATOR99PtIeohlpU/NJ4kn64nViniyX+GhBpTXtPbPKtMefUuguPQj4b7
 Ntz/OzcqoiJ0JrYQ1Ob+QmCU0BLmoXjCYk8C5fddB/sUg6S9TYlZfm42vmwYotj+RJh1
 RM/g==
X-Gm-Message-State: AOJu0YyhU3/keJhsP4kRi28jEJXz6ParOEuo64aZxZ8OMALpk2wVycZC
 /5CENT7ty1ltkCXcP4hK8gBB9pIX+dH20l5FSbM=
X-Google-Smtp-Source: AGHT+IHPnqgY+4/4M94TLABsKNCCBlMQxYD/L4KvbOU1ljHQ+WGHVHUtMsWsIlOqg8++I3wVN6SEkw==
X-Received: by 2002:a19:e043:0:b0:500:daf6:3898 with SMTP id
 g3-20020a19e043000000b00500daf63898mr70630lfj.26.1699401516198; 
 Tue, 07 Nov 2023 15:58:36 -0800 (PST)
Received: from flawful.org (c-bcf2e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.242.188]) by smtp.gmail.com with ESMTPSA id
 er6-20020a05651248c600b0050933bb416csm487987lfb.74.2023.11.07.15.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 15:58:35 -0800 (PST)
Received: by flawful.org (Postfix, from userid 112)
 id E2B043E35; Wed,  8 Nov 2023 00:58:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1699401515; bh=4o2u/ACRVjcXwjQNxZOO7j047M5FewQ9QX9g3mZPJKA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mYrb1qPBsNr68Vdg/XEVN+7Dz+Cu5QNoyAAvQb+81u91pijLK61xd7KlFpWlc5Ppm
 iXEl27UMeVEUYsHUR0eBSaiefITVVisKbZzKzBa7PBOYj3XYEorDxMy3jAGA0umT02
 86ctjmEEAj/+9U8X8zkybFJ/YqGwr17GIurVEjQw=
Received: from x1-carbon (OpenWrt.lan [192.168.1.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 7518534CD;
 Wed,  8 Nov 2023 00:57:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1699401479; bh=4o2u/ACRVjcXwjQNxZOO7j047M5FewQ9QX9g3mZPJKA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZwLW4jHDKp5kvEe1CEJvdDplbws/60allZrsKrYlDbmus6sgTiBul1JZd/CHplm7G
 3JJwrLkKncwsJaAoLZ9Sqs5QM4VraN6pE+Lw2hSMKT7lqsWFnoK+jx19ADZ6476Z00
 6SoIb5QRoL++5ZpfjDjV2bwuMukkxob6rs9x2iYY=
Date: Wed, 8 Nov 2023 00:57:50 +0100
From: Niklas Cassel <nks@flawful.org>
To: Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Damien Le Moal <dlemoal@kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH v2] hw/ide/ahci: fix legacy software reset
Message-ID: <ZUrO/tluTBjnPXHV@x1-carbon>
References: <20231005100407.1136484-1-nks@flawful.org>
 <ZUp+b6pHoov9Qbc6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUp+b6pHoov9Qbc6@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Nov 07, 2023 at 07:14:07PM +0100, Kevin Wolf wrote:
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

This weirdo option "Clear Busy upon R_OK" is for the HBA itself to clear
the bit for the command in PxCI, when it gets the R_OK that the Host to Device
(H2D) FIS was transmitted successfully to the device.
The normal way is that the device sends back a Device to Host (D2H) FIS
which then causes the bit in PxCI to be cleared in the HBA.

Yes, theoretically you could probably build a FIS that has the
"Clear Busy upon R_OK" even for e.g. a regular non-NCQ I/O command
(where PxCI/BUSY is first supposed to be cleared once the command is done...),
however this would surely cause problems as PxCI would then no longer shadow
the state of the device.

If you search for "Clear Busy upon R_OK", the only usage seems
to be for legacy software reset.

I'm quite sure that the option was specifically created for legacy
software reset, since to do a legacy software reset, you need to
create and issue two FISes.
The first FIS has SRST set (assert reset), the second FIS has SRST
cleared (deassert reset).

For regular I/O non-NCQ commands, PxCI will be cleared when the
I/O has completed (by the device sending back a D2H FIS).
For NCQ commands, PxCI will be cleared when the drive has
successfully queued the command (by the device sending back a D2H FIS).

The spec states that there should NOT be a D2H FIS sent back to
the HBA when getting the first H2D FIS (which asserts reset).
(The device will still send back a R_OK that the FIS was transmitted
successfully.)

For the second H2D FIS (that deasserts reset), the spec says that the
device SHOULD send a D2H FIS back (after the device diagnostic is done).


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

There are two ways to reset.
COMRESET which is a simple register write.
or
legacy software reset, where you create and issue two H2D FISes
(just like when submitting an I/O command).
For legacy software reset, the first H2D FIS should not send back a
D2H FIS. The second H2D FIS should.

ahci_reset_port() is used by both ways.



Previously, the QEMU model didn't handle a legacy software according
to spec, it simply cleared PxCI blindly without checking "Clear Busy
upon R_OK" for non-I/O commands.


In SATA 3.5a Gold, section 11.4 Software reset protocol.
When SRST goes from 1->0, it should execute a device diagnostic.
At the end of the diagnostic, it should transfer a D2H FIS with good
status.


Reading other chapters again, the execution of device diagnostic,
and sending of good status, is also done when a reset is done via
a COMRESET.

So even while a D2H FIS is usually sent back as a response to a H2D FIS,
it appears that also a COMRESET (which is a register write), triggers
a D2H FIS.


I did know that the device sends a D2H FIS on power up, in order to update
PxSIG. (This is why we have the ahci_init_d2h() function.)

However, it turns out that the D2H FIS that updates PxSIG and the D2H FIS
that is send out after a SRST 1->0 (and a COMRESET), is the same as the
D2H FIS that updates PxSIG.

But if we remove:

> > +                ahci_clear_cmd_issue(ad, slot);
> > +                ahci_write_fis_d2h(ad, false);

Then PxCI for the second H2D FIS (that is executed like) a normal command
will not get cleared here...


So where should it get cleared?
In ahci_init_d2h() is the correct place... ahci_init_d2h() does
ahci_write_fis_d2h(), but is currently the only ahci_write_fis_d2h()
that doesn't also do a ahci_clear_cmd_issue().


However, simply adding a ahci_clear_cmd_issue() in ahci_init_d2h()
is not trivial. The whole ahci_init_d2h() is a big hack, as the comments
in the code already says... And ahci_init_d2h() is not only called from
ahci_reset_port()...

I think I would prefer to keep the ahci_clear_cmd_issue() above,
drop the ahci_write_fis_d2h(ad, false), and modify the comment to
say that the matching D2H FIS is really the ahci_write_fis_d2h()
done by ahci_init_d2h()... which is the _singular_ D2H FIS sent out
after the device diagnostic triggered by SRST 1->0 has completed,
which send the good status (which is what the HBA initializes PxSIG
to), and additionally clears PxCI.

(For a reset triggered by a COMRESET, everything is the same, except
it doesn't clear PxCI, since there was no command created and issued.)


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

A start/stop of the engine (PxCMD.ST) does clear PxCI, as I implemented in:
https://github.com/qemu/qemu/commit/d73b84d0b664e60fffb66f46e84d0db4a8e1c713

But according to AHCI 1.3.1, section:
3.3.14 Offset 38h: PxCI – Port x Command Issue

PxCI does also have a reset value of 0h.

So I would assume that it is okay to clear PxCI to zero also in
ahci_reset_port().

By doing so, we could avoid both the ahci_clear_cmd_issue(),
and the ahci_write_fis_d2h(ad, false).

Perhaps you can drop the "bonus" part of my patch and simply
add a pr->cmd_issue to ahci_reset_port()?

Thank you for your review!


Kind regards,
Niklas

