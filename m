Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9E87B5396
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 15:01:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnIXL-0001vB-O4; Mon, 02 Oct 2023 09:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foo00@h08.hostsharing.net>)
 id 1qnIXI-0001r0-B2; Mon, 02 Oct 2023 09:00:32 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foo00@h08.hostsharing.net>)
 id 1qnIX2-0007Xn-Sv; Mon, 02 Oct 2023 09:00:31 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "*.hostsharing.net",
 Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
 by bmailout2.hostsharing.net (Postfix) with ESMTPS id 9B6202800B3D2;
 Mon,  2 Oct 2023 14:50:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 8530323B871; Mon,  2 Oct 2023 14:50:35 +0200 (CEST)
Date: Mon, 2 Oct 2023 14:50:35 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Yao, Jiewen" <jiewen.yao@intel.com>
Cc: Alistair Francis <alistair23@gmail.com>,
 "wilfred.mallawa@wdc.com" <wilfred.mallawa@wdc.com>,
 "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "its@irrelevant.dk" <its@irrelevant.dk>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
 "Browy, Chris" <cbrowy@avery-design.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/3] hw/nvme: Add SPDM over DOE support
Message-ID: <20231002125035.GA21884@wunner.de>
References: <20230915112723.2033330-1-alistair.francis@wdc.com>
 <20230915112723.2033330-3-alistair.francis@wdc.com>
 <20231002084753.GA23546@wunner.de>
 <MW4PR11MB58723743D7A01A9E6876A4F78CC5A@MW4PR11MB5872.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR11MB58723743D7A01A9E6876A4F78CC5A@MW4PR11MB5872.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: none client-ip=83.223.78.240;
 envelope-from=foo00@h08.hostsharing.net; helo=bmailout2.hostsharing.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Mon, Oct 02, 2023 at 11:36:25AM +0000, Yao, Jiewen wrote:
> Comment on subjectAltName.
> 
> PCI-SIG realized that it may cause problem for certain device
> and decided to remove such requirement in future ECN.
> I don't think that is absolutely needed.

We have to follow what's in the spec.  We can't just leave out
certain elements because they might possibly maybe be removed
in the future.

PCIe r6.1 does require the Subject Alternative Name and that's
the latest version, so we follow that.

The ECN that you're referring to only exists as a draft in the
PCISIG's Review Zone Archive.

My understanding is that the Subject Alternative Name's purpose
is to eliminate certain threats in the CMA threat model:
The Subject Alternative Name is basically a signed version of the
device's identity in config space.  Without it, a different device
might misappropriate a device's certificate + private key.

If the Subject Alternative Name requirement is dropped, I would
like to know how that threat is prevented instead?

I don't quite understand what you mean by "may cause problem for
certain device".  I've asked the editor of the PCIe Base Spec why
they're considering removing the requirement and the gist of the
answer was -- I'm paraphrasing here -- that vendors thought the
requirement is generally quite narrow and perceived as a straight-jacket
and that at this point, more flexibility is desired as to the
identification scheme.  There was no mention at all of "problems
for certain devices".

Thanks,

Lukas

