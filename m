Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCF6728B37
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OM3-0001e7-OF; Thu, 08 Jun 2023 18:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q7OM1-0001cK-8k
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:43:41 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q7OLz-00039K-Bt
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:43:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 90BAB63F17;
 Thu,  8 Jun 2023 22:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041E6C433EF;
 Thu,  8 Jun 2023 22:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686264216;
 bh=s/roKiwIpEWTPQAAmU12DOXtTPMNzR+NigpYF0r52tE=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=N+C//+qPNMJMEZqOZqUeRGk+m1d0p94LawSZ5cnrs2pLaMOpBEszkznP/aKaIA5UK
 S+fsgTpr8vcgY7YfL7L4FyEmX5o7dvdLWT06dSFcvAHuJ14zA2uqGO0TPZ0xhqxxzg
 a48NCaEuJ4EIpgcYmB45+mCXSZm9s0mVRZSnCBJj7Lnr8DxnyHs5z/Xe2lKIqLFUyy
 XBpLrtFYNWfvmIgAgZD/Tbq6UDtPYUkmLpBdABbvXUMpuJCmbZNffGU034Ia6yhvG1
 Ttzav0/quy9Y0NZPk547GRpx5nsLPsTtkUprFNP5TEwyqeWQf6Vq+Hr6Mgp6f/9PBg
 miWJaHkVn2AxQ==
Date: Thu, 8 Jun 2023 15:43:32 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Bernhard Beschow <shentey@gmail.com>
cc: Stefano Stabellini <sstabellini@kernel.org>, mst@redhat.com, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 David Woodhouse <dwmw@amazon.co.uk>, Eduardo Habkost <eduardo@habkost.net>, 
 Chuck Zmudzinski <brchuckz@aol.com>, Aurelien Jarno <aurelien@aurel32.net>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 0/7] Resolve TYPE_PIIX3_XEN_DEVICE
In-Reply-To: <ADD39905-0305-477A-8801-C1F561E0DFD4@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2306081542170.3803068@ubuntu-linux-20-04-desktop>
References: <20230403074124.3925-1-shentey@gmail.com>
 <20230421033757-mutt-send-email-mst@kernel.org>
 <9EB9A984-61E5-4226-8352-B5DDC6E2C62E@gmail.com>
 <alpine.DEB.2.22.394.2305151350180.4125828@ubuntu-linux-20-04-desktop>
 <EB3E61EB-B543-4B15-94A9-C16A66437601@gmail.com>
 <ADD39905-0305-477A-8801-C1F561E0DFD4@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-891826009-1686264215=:3803068"
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-891826009-1686264215=:3803068
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 5 Jun 2023, Bernhard Beschow wrote:
> Am 22. Mai 2023 15:42:03 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
> >
> >
> >Am 15. Mai 2023 20:52:40 UTC schrieb Stefano Stabellini <sstabellini@kernel.org>:
> >>On Sat, 13 May 2023, Bernhard Beschow wrote:
> >>> Am 21. April 2023 07:38:10 UTC schrieb "Michael S. Tsirkin" <mst@redhat.com>:
> >>> >On Mon, Apr 03, 2023 at 09:41:17AM +0200, Bernhard Beschow wrote:
> >>> >> There is currently a dedicated PIIX3 device model for use under Xen. By reusing
> >>> >> existing PCI API during initialization this device model can be eliminated and
> >>> >> the plain PIIX3 device model can be used instead.
> >>> >> 
> >>> >> Resolving TYPE_PIIX3_XEN_DEVICE results in less code while also making Xen
> >>> >> agnostic towards the precise south bridge being used in the PC machine. The
> >>> >> latter might become particularily interesting once PIIX4 becomes usable in the
> >>> >> PC machine, avoiding the "Frankenstein" use of PIIX4_ACPI in PIIX3.
> >>> >
> >>> >xen stuff so I assume that tree?
> >>> 
> >>> Ping
> >>
> >>I am OK either way. Michael, what do you prefer?
> >>
> >>Normally I would suggest for you to pick up the patches. But as it
> >>happens I'll have to likely send another pull request in a week or two
> >>and I can add these patches to it.
> >>
> >>Let me know your preference and I am happy to follow it.
> >
> >Hi Stefano,
> >
> >Michael's PR was merged last week. How about including this series into your PR then?
> 
> Ping

Sorry for the late reply, it looks like patch #3 breaks the build:

[1888/4025] Compiling C object libcommon.fa.p/hw_isa_piix3.c.o
FAILED: libcommon.fa.p/hw_isa_piix3.c.o 
cc -m64 -mcx16 -Ilibcommon.fa.p -Iui -I../ui -I/usr/include/capstone -I/usr/include/pixman-1 -I/usr/include/libpng16 -I/usr/include/spice-server -I/usr/include/spice-1 -I/usr/include/p11-kit-1 -I/usr/include/libusb-1.0 -I/usr/include/SDL2 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/gio-unix-2.0 -I/usr/include/slirp -I/usr/include/gtk-3.0 -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/freetype2 -I/usr/include/fribidi -I/usr/include/uuid -I/usr/include/cairo -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/atk-1.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -I/usr/include/at-spi-2.0 -I/usr/include/vte-2.91 -I/usr/include/virgl -I/usr/include/cacard -I/usr/include/nss -I/usr/include/nspr -I/usr/include/PCSC -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O2 -g -fstack-protector-strong -U_FORTIFY_SOURCE -D_FORTIFY_SOURC
 E=2 -Wundef -Wwrite-strings -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls -Wold-style-declaration -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined -Wimplicit-fallthrough=2 -Wmissing-format-attribute -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi -isystem /builds/Vikram.garhwal/qemu-ioreq/linux-headers -isystem linux-headers -iquote . -iquote /builds/Vikram.garhwal/qemu-ioreq -iquote /builds/Vikram.garhwal/qemu-ioreq/include -iquote /builds/Vikram.garhwal/qemu-ioreq/host/include/x86_64 -iquote /builds/Vikram.garhwal/qemu-ioreq/host/include/generic -iquote /builds/Vikram.garhwal/qemu-ioreq/tcg/i386 -pthread -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -fPIE -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=600 -DNCURSES_WIDECHAR=1 -D_REENTRANT -Wno-undef -DSTRUCT_IOVEC_DEFINED -MD -MQ libcommon.fa.p/hw
 _isa_piix3.c.o -MF libcommon.fa.p/hw_isa_piix3.c.o.d -o libcommon.fa.p/hw_isa_piix3.c.o -c ../hw/isa/piix3.c
../hw/isa/piix3.c:265:13: error: ‘pci_piix3_realize’ defined but not used [-Werror=unused-function]
  265 | static void pci_piix3_realize(PCIDevice *dev, Error **errp)
      |             ^~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

--8323329-891826009-1686264215=:3803068--

