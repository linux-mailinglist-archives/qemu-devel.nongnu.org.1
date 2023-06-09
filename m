Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CFD729752
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:47:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ZeB-0000i4-7w; Fri, 09 Jun 2023 06:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=517b6bf9d=anthony.perard@citrix.com>)
 id 1q7Ze8-0000g6-FA
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:47:08 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=517b6bf9d=anthony.perard@citrix.com>)
 id 1q7Ze5-00015P-Mc
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1686307625;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dM7o+uJm3jltHB6pCR+shMRrsvJK+PlElVIJWU5Ryow=;
 b=GxMfWadfE98BMA3vfrw+7LBjzcI88LAAVe+Hi600lNZ3k+GU1Mgma4WO
 o86GYcvTaUoMtZUmSlHBqfa4legLIXxSxniz/mpgbnoPbDyRcx4njGLxN
 DOBXTfhwCAq+ENk/29XbxEI2fBDwB5O75j5ME+nigLfXaq6C1YXhMYrNC Q=;
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 112212280
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:SwSY0qrT9axPg4ExK0lFKEzLB31eBmI0YhIvgKrLsJaIsI4StFCzt
 garIBmGOf2DYWujctwnad7goU0P7cXRy4RiHAY4pCg2Hi9B8puZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpA1c/Ek/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKq04GtwUmAWP6gR5weAzyhNVfrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXABQwdz2G2KHr/Le+ENR3jPQYCNLuf6pK7xmMzRmBZRonaZXKQqGM7t5ExjYgwMtJGJ4yZ
 eJAN2ApNk6ZJUQSZBFOUslWcOSA3xETdxVRrk6VoqwmpXDe1gVr3JDmMcbPe8zMTsJQ9qqdj
 jufpT6gWEtKbLRzzxK19CyimO/XsRnQY9pPBrCmtdVPjVCqkzl75Bo+CgLg/KjRZlSFc8lEN
 0Ue9y4qrK4z3E+mVN/wW1u/unHslgUcVtxMHvwS5wSEy66S6AGcbkABVSJpctEqtMYqAzct0
 zehht7sGHljvaOYTVqb8bGbqy70PjIaRUcYZCQERBEJpdnupo0+lAnISP5nEai8lNqzHiv/q
 xiPpTI1irFVhNYF2qGx9E3Cqz2pr5nNCAUy423/Un2g8StwYYe3YIru4l+d8PUoBIuVU1Cbs
 H8sm8GU7+cVEdeLmTDlaO8XF7G07PWXGDTbhRhkGJxJ3z2w4XOnfI1WyDhjPkptaZxCfzL1C
 GfToQRM/4RSOlOwYKZ8f4WqTcMwwsDIDd34UtjEY9wIZYJ+HCef9iZod0+W3kj3nUQsmL15M
 pCeGe60DXceDKhPyDuwTv0al7gxyUgW1W7VAJz20Rmj+b6ff2KOD6cINkOUaeI057/Cpx/am
 /5WL8aQwg9TePH/aCLQt4UUKDg3wWMTXM6s7ZYNL6jaf1QgQTt6YxPM/V8/U6hYholQyaSVw
 nS4AHJDwmrEoWbCaizfPxiPd4jTdZp4qHs6OwklMlCpx2UvbO6T0UsPS3ckVeJ5rbI+lJaYW
 9FAIpzdWaoXFlwr7hxHNfHAQJpemANHbO5kFw6se3ABcpFpXGQlEfe0L1K0pEHi4sda3PbSQ
 oFMNSuBG/LvojiO6+6IAM9DN3vr4RAgdBtaBiMk2OV7dkT265RNICfslPIxKMxkAUydlmXAi
 1fMW0pH/rmlT2oJHD7h3/nskmtUO7EmQhoy85fzsN5ayhU2DkL8mNQdAY5kjBjWVX/u+bXKW
 Amm56iUDRHzp34T69AUO+8yncoDCy7H++cyIvJMQC+aMDxGy9pIfhG74CW4nvcdm+cA6FPnC
 hrnFxszEezhBf4J2WU5fGINBtlvH9lN8tUOxZzZ+HnH2RI=
IronPort-HdrOrdr: A9a23:qmGjV6rE/2DMQuuA2mcmXPMaV5obeYIsimQD101hICG9Ffb1qy
 nOppsmPHrP4wr5N0tPpTntAsi9qArnhOdICOsqTNWftXjd2FdARbsKheGO/9SKIVycygcy79
 YGT4FOTPH2EFhmnYLbzWCDYrAdKQC8gcWVbDHlvhNQcT0=
X-Talos-CUID: 9a23:Jj4GHWyHkuQZiU80TJJ3BgUwJ9kIdyKekUvVJhWFEmxZc5mOTBy5rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AzmdNLA44YlZvQSlSKlQjDVG1xoxY5fqgFkAVva8?=
 =?us-ascii?q?tgJHZJyFueBy4gTmOF9o=3D?=
X-IronPort-AV: E=Sophos;i="6.00,229,1681185600"; d="scan'208";a="112212280"
Date: Fri, 9 Jun 2023 11:46:53 +0100
To: Stefano Stabellini <sstabellini@kernel.org>
CC: Bernhard Beschow <shentey@gmail.com>, <mst@redhat.com>,
 <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Woodhouse
 <dwmw@amazon.co.uk>, Eduardo Habkost <eduardo@habkost.net>, Chuck Zmudzinski
 <brchuckz@aol.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Paul Durrant
 <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>, Philippe
 =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v4 0/7] Resolve TYPE_PIIX3_XEN_DEVICE
Message-ID: <0372b3c8-fc50-4d61-83da-72748a439405@perard>
References: <20230403074124.3925-1-shentey@gmail.com>
 <20230421033757-mutt-send-email-mst@kernel.org>
 <9EB9A984-61E5-4226-8352-B5DDC6E2C62E@gmail.com>
 <alpine.DEB.2.22.394.2305151350180.4125828@ubuntu-linux-20-04-desktop>
 <EB3E61EB-B543-4B15-94A9-C16A66437601@gmail.com>
 <ADD39905-0305-477A-8801-C1F561E0DFD4@gmail.com>
 <alpine.DEB.2.22.394.2306081542170.3803068@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2306081542170.3803068@ubuntu-linux-20-04-desktop>
Received-SPF: pass client-ip=216.71.145.155;
 envelope-from=prvs=517b6bf9d=anthony.perard@citrix.com;
 helo=esa3.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jun 08, 2023 at 03:43:32PM -0700, Stefano Stabellini wrote:
> On Mon, 5 Jun 2023, Bernhard Beschow wrote:
> > Am 22. Mai 2023 15:42:03 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
> > >
> > >
> > >Am 15. Mai 2023 20:52:40 UTC schrieb Stefano Stabellini <sstabellini@kernel.org>:
> > >>On Sat, 13 May 2023, Bernhard Beschow wrote:
> > >>> Am 21. April 2023 07:38:10 UTC schrieb "Michael S. Tsirkin" <mst@redhat.com>:
> > >>> >On Mon, Apr 03, 2023 at 09:41:17AM +0200, Bernhard Beschow wrote:
> > >>> >> There is currently a dedicated PIIX3 device model for use under Xen. By reusing
> > >>> >> existing PCI API during initialization this device model can be eliminated and
> > >>> >> the plain PIIX3 device model can be used instead.
> > >>> >> 
> > >>> >> Resolving TYPE_PIIX3_XEN_DEVICE results in less code while also making Xen
> > >>> >> agnostic towards the precise south bridge being used in the PC machine. The
> > >>> >> latter might become particularily interesting once PIIX4 becomes usable in the
> > >>> >> PC machine, avoiding the "Frankenstein" use of PIIX4_ACPI in PIIX3.
> > >>> >
> > >>> >xen stuff so I assume that tree?
> > >>> 
> > >>> Ping
> > >>
> > >>I am OK either way. Michael, what do you prefer?
> > >>
> > >>Normally I would suggest for you to pick up the patches. But as it
> > >>happens I'll have to likely send another pull request in a week or two
> > >>and I can add these patches to it.
> > >>
> > >>Let me know your preference and I am happy to follow it.
> > >
> > >Hi Stefano,
> > >
> > >Michael's PR was merged last week. How about including this series into your PR then?
> > 
> > Ping
> 
> Sorry for the late reply, it looks like patch #3 breaks the build:

Hi Stefano,

Sorry I forgot to reply to these mails. I've sent a pull request for
this earlier this week (along with other patches I had to send), so the
series should be applied now.

I guess the build issue is due to trying to apply the same patch again.

Cheers,

-- 
Anthony PERARD

