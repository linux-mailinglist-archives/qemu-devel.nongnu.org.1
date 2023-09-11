Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F63079A987
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:18:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfieX-0000AF-H3; Mon, 11 Sep 2023 11:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfieU-00009L-JM
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:16:38 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfieR-0006SN-Qs
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:16:38 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52a49a42353so5982267a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 08:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694445394; x=1695050194; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IBBmnoByEX67to3HisQ0TlRk5vhUwAnVlWuk3Uygn+s=;
 b=JPPiIOSdycngfanRPaLbucaLG9Z63nPaTOfNQSw1hpNkrsX+Fu9aV0vNuYzUhmN/jr
 4qNdb/6tx7rKtw+H+4SxksOz0YL08GBfWmAJhoijdMcvws0dI+bQXmKVjKGTWRpsPCDs
 RXRCSgmMWOOAJp3SaYJCjbAOahIDtAANEYyIaHFQNKygBH6fckPZs5v+llIHY+I3HIJX
 8oHakdMHSSAexWpciYPBcXcEBST+AG6wsWwnMxYZaalLREEnQ/W3tLOAG8xP1DRvC9Ce
 q2IDShZDDzbo+YCdO5QxwQcqUqN2mLBxRtF3rqj1/YimJ9CewmNV4peqj7vmS5ZZwH1v
 DxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694445394; x=1695050194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IBBmnoByEX67to3HisQ0TlRk5vhUwAnVlWuk3Uygn+s=;
 b=jC0qj13WlYoG31m41OTmmd30trH0zXGG7Bb3jReGxt5BJ0bE6CGcsGE8KBWrsHGjtf
 dbuJUw1XeB3/3QwB6x7YEO4Ilyj17sHdFQSGiF/tipyYCpCAsae7O3eyiWuq5O3epctr
 f4KlMdF73zKm1qslJwkDyohRBGX3tNqZTL0gCgnJY+4vAGJ+p27r4KNUHaLkkFMx9V0Z
 SdeYYOd7UC6O4nySor9viu7VnLwlEtYJcmUzv8ubc8MVM88L2wAKiIN2g+5m8jZO5y9X
 7gERXZZ0K3DLEb3nVQDs4QuYy/orIzJrujT7eTf3IyhQQDvEaoJBnBD5Gvw14GdOVwg0
 fGCA==
X-Gm-Message-State: AOJu0YxBRdTkhtWhF2Gl94eCIsZKYizBdqSNGok7KdBR+meON/ctd6qn
 pcI6nFhG/Gmy9nXJQLHqzVWbB8V8cvOacHpIyK/xYQ==
X-Google-Smtp-Source: AGHT+IGSLz6YkOdyR/yrLUkCsWZuTmmeFMRLfxd3qFjC9iJ/7EXBIV99nntxp7AAtB0q9gQ9ZpB0M7x+PFQ+6v1rCnY=
X-Received: by 2002:a05:6402:22ee:b0:52f:3653:1c6 with SMTP id
 dn14-20020a05640222ee00b0052f365301c6mr4694741edb.27.1694445394057; Mon, 11
 Sep 2023 08:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907130004.500601-25-pbonzini@redhat.com>
 <fee31724-3b75-95d6-f4d6-2e7b8f17bf96@linaro.org>
 <8cab2217-b989-2be2-421c-c495e19dab87@tls.msk.ru>
 <a95e38d6-d968-9799-9c86-fa592b0feda7@eik.bme.hu>
 <9e9421ef-ecdb-5490-5c4f-3151e6ea23b3@tls.msk.ru>
 <11a4985d-6b60-e639-c855-6c0982dd8a03@eik.bme.hu>
In-Reply-To: <11a4985d-6b60-e639-c855-6c0982dd8a03@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 16:16:22 +0100
Message-ID: <CAFEAcA-WJ9J1YQunJ+bSG=wnpxh1By+Bf18j2CyV7G0vZ=8b7g@mail.gmail.com>
Subject: Re: [PULL 24/51] meson: compile bundled device trees
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, qemu-ppc <qemu-ppc@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 8 Sept 2023 at 21:08, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Fri, 8 Sep 2023, Michael Tokarev wrote:
> > 08.09.2023 22:21, BALATON Zoltan:
> >> I was about to ask, since when but probably nobody knows then. AFAIR I had
> >> no such errors for the canyonlands one when I've added it but that was
> >> quite some years ago and things in dtc for example could have changed so it
> >> now gives these warnings.
> >
> > I think it can be said based on debian build logs. Lemme see..
> >
> > https://buildd.debian.org/status/logs.php?pkg=qemu&arch=all
> >
> > The first log entry there is from 2018-12-12, for qemu 3.1, dtc 1.4.7.
> > It has:
> >
> > dtc -o b/qemu/pc-bios/bamboo.dtb pc-bios/bamboo.dts
> > b/qemu/pc-bios/bamboo.dtb: Warning (unit_address_vs_reg): /memory: node has a
> > reg or ranges property, but no unit name
> > b/qemu/pc-bios/bamboo.dtb: Warning (unit_address_vs_reg): /plb/opb: node has
> > a reg or ranges property, but no unit name
> > b/qemu/pc-bios/bamboo.dtb: Warning (chosen_node_stdout_path):
> > /chosen:linux,stdout-path: Use 'stdout-path' instead
> > b/qemu/pc-bios/bamboo.dtb: Warning (interrupts_property): /plb/opb: Missing
> > interrupt-parent
> > b/qemu/pc-bios/bamboo.dtb: Warning (interrupts_property): /plb/opb/ebc:
> > Missing interrupt-parent
>
>
> OK so bamboo was likely always like that. Sam460ex (aka canyonlands which
> is the devel board it is based on) was added in February 2018 so that was
> OK back then but later dtc versions may have become pickier somewhere
> between 1.4.7 and 1.6.0.

Yeah, at some point dtc started warning about a lot of these
things, I think in the hope that people writing dt files would
fix them before the dt got into wide circulation.

> > next it was moved to one of the subpackages, and moved back to
> > arch-independent package in 6.2 (2022-01-09, dtc 1.6.0), which has:
> >
> > dtc -o b/misc/bamboo.dtb pc-bios/bamboo.dts
> > pc-bios/bamboo.dts:45.9-48.4: Warning (unit_address_vs_reg): /memory: node
> > has a reg or ranges property, but no unit name
> > pc-bios/bamboo.dts:87.13-154.5: Warning (unit_address_vs_reg): /plb/opb: node
> > has a reg or ranges property, but no unit name
> > pc-bios/bamboo.dts:198.3-50: Warning (chosen_node_stdout_path):
> > /chosen:linux,stdout-path: Use 'stdout-path' instead
> > pc-bios/bamboo.dts:87.13-154.5: Warning (interrupts_property): /plb/opb:
> > Missing interrupt-parent
> > pc-bios/bamboo.dts:100.14-108.6: Warning (interrupts_property): /plb/opb/ebc:
> > Missing interrupt-parent
> > dtc -o b/misc/canyonlands.dtb pc-bios/canyonlands.dts
> > pc-bios/canyonlands.dts:47.9-50.4: Warning (unit_address_vs_reg): /memory:
> > node has a reg or ranges property, but no unit name
> > pc-bios/canyonlands.dts:210.13-429.5: Warning (unit_address_vs_reg):
> > /plb/opb: node has a reg or ranges property, but no unit name
> > pc-bios/canyonlands.dts:464.26-504.5: Warning (pci_bridge):
> > /plb/pciex@d00000000: node name is not "pci" or "pcie"
> > pc-bios/canyonlands.dts:506.26-546.5: Warning (pci_bridge):
> > /plb/pciex@d20000000: node name is not "pci" or "pcie"
>
> Linux has this in arch/powerpc/boot/dts/canyonlands.dts and at least had a
> change of the pciex names to pcie that should fix some of these but if the
> u-boot still uses older names then could updating this result in different
> results between using -kernel and without that? I don't know how guests
> use the dtb so can't tell what to do but keeping it consistent with the
> older u-boot this board has seems like a safer option.

At least in theory, guest code looking at a device tree blob
should be searching it by 'compatible' property name, not
by the name of the node itself. So changing node names is
a fairly safe change, though as you say the absolute safest
thing would be to not change at all.

Did we get these dts file from some other "upstream" source?
If so then the best thing is probably either to just update
from that upstream source again, or else say "these aren't
files the QEMU project is writing, so there's no point in
having the compile process warning about them, turn all the
dtc warnings off using the '-q' option".

-- PMM

