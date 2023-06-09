Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E17728C5B
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 02:24:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Puh-00049r-R7; Thu, 08 Jun 2023 20:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q7Pug-00049a-LY
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 20:23:34 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q7Pue-00040J-UB
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 20:23:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 885BC6518B;
 Fri,  9 Jun 2023 00:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE13C433EF;
 Fri,  9 Jun 2023 00:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686270211;
 bh=OpDb7/RjL4XjYjMeFWJxEnsOXV1XjZsBrKHObfFQFHQ=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=GAksM/2LKgQhmQ5t7bcwMGoXUW1k6MVBTMBTbGIDCeezK/OFO3GwRa9+AdRzo98RL
 vn6dwF1UEGwZKihgMa7nrKTN0vxkV8Och6SWdUPATQ5vyh6V5zfrQ8Zd4cpS8D4WDr
 4OKarCpBJ98D9nuIBKtdOqy8n8rHInt3JKl9jOG8WVOyQbdDR0HOXu+iuqFmhsSnM6
 AQxrF2vDExEatQFht6UQhexEJWZD+1lVvcO/seAeY/z2z9WMGEzNj2hKR8BAXY29qZ
 zjtwOeR1SjHFuWvb6v8lBT+AX7hXjrPnXbkKdmB45WemON5wpd68fHCtgcyxNxTkNk
 Y6WEvrDc2vF7g==
Date: Thu, 8 Jun 2023 17:23:27 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Stefano Stabellini <sstabellini@kernel.org>
cc: Bernhard Beschow <shentey@gmail.com>, mst@redhat.com, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 David Woodhouse <dwmw@amazon.co.uk>, Eduardo Habkost <eduardo@habkost.net>, 
 Chuck Zmudzinski <brchuckz@aol.com>, Aurelien Jarno <aurelien@aurel32.net>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 0/7] Resolve TYPE_PIIX3_XEN_DEVICE
In-Reply-To: <alpine.DEB.2.22.394.2306081542170.3803068@ubuntu-linux-20-04-desktop>
Message-ID: <alpine.DEB.2.22.394.2306081722330.3803068@ubuntu-linux-20-04-desktop>
References: <20230403074124.3925-1-shentey@gmail.com>
 <20230421033757-mutt-send-email-mst@kernel.org>
 <9EB9A984-61E5-4226-8352-B5DDC6E2C62E@gmail.com>
 <alpine.DEB.2.22.394.2305151350180.4125828@ubuntu-linux-20-04-desktop>
 <EB3E61EB-B543-4B15-94A9-C16A66437601@gmail.com>
 <ADD39905-0305-477A-8801-C1F561E0DFD4@gmail.com>
 <alpine.DEB.2.22.394.2306081542170.3803068@ubuntu-linux-20-04-desktop>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 8 Jun 2023, Stefano Stabellini wrote:
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

I noticed now that this patch series got committed (the right version
without the build failure), thanks Anthony for sending the pull request!

