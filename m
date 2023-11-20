Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BB37F1920
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 17:52:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r57U4-0006a4-Qk; Mon, 20 Nov 2023 11:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r57Tr-0006Xl-C6
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 11:50:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r57Tn-0003h6-L2
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 11:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700499033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmKaC5N53mP3rtUiB1S6AXp94gGlkwsUhlg9kWEpr2k=;
 b=CsOPlpRv2okuJ9jvaCEkuQcwoDGEYRHTvD7PDwMhb4frSapOU4tXl+l4Tn45CstSGqycID
 7Il34ExMx/YyzG51h9gtNuKCes0JTULzN7tsWY7VGZhdzbPMYQ4hiOvgON4LdCMVpcIMIm
 qksT+XTXFJGZt/O0LwUByFfOXx04PTM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-mbiHMhWMOvuuNCR-zWnQ7w-1; Mon, 20 Nov 2023 11:50:30 -0500
X-MC-Unique: mbiHMhWMOvuuNCR-zWnQ7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D2B181100E;
 Mon, 20 Nov 2023 16:50:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1F99C15882;
 Mon, 20 Nov 2023 16:50:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9611E18009BB; Mon, 20 Nov 2023 17:50:27 +0100 (CET)
Date: Mon, 20 Nov 2023 17:50:27 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Ard Biesheuvel <ardb@kernel.org>, mimoja@mimoja.de
Subject: Re: [PATCH 00/16] hw/uefi: add uefi variable service
Message-ID: <nxzed5dhgjpn3fafjttocvxe6ztxxf5xhghaqncpdxup6y7o7y@47i3eyoehio2>
References: <20231115151242.184645-1-kraxel@redhat.com>
 <9db15906-9474-4a6e-82a9-5275c72cf2b4@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9db15906-9474-4a6e-82a9-5275c72cf2b4@amazon.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

On Mon, Nov 20, 2023 at 12:53:45PM +0100, Alexander Graf wrote:
> Hey Gerd!
> 
> On 15.11.23 16:12, Gerd Hoffmann wrote:
> > This patch adds a virtual device to qemu which the uefi firmware can use
> > to store variables.  This moves the UEFI variable management from
> > privileged guest code (managing vars in pflash) to the host.  Main
> > advantage is that the need to have privilege separation in the guest
> > goes away.
> > 
> > On x86 privileged guest code runs in SMM.  It's supported by kvm, but
> > not liked much by various stakeholders in cloud space due to the
> > complexity SMM emulation brings.
> > 
> > On arm privileged guest code runs in el3 (aka secure world).  This is
> > not supported by kvm, which is unlikely to change anytime soon given
> > that even el2 support (nested virt) is being worked on for years and is
> > not yet in mainline.
> > 
> > The design idea is to reuse the request serialization protocol edk2 uses
> > for communication between SMM and non-SMM code, so large chunks of the
> > edk2 variable driver stack can be used unmodified.  Only the driver
> > which traps into SMM mode must be replaced by a driver which talks to
> > qemu instead.
> 
> 
> I'm not sure I like the split :). If we cut things off at the SMM
> communication layer, we still have a lot of code inside the Runtime Services
> (RTS) code that is edk2 specific which means we're tying ourselves tightly
> to the edk2 data format.

Which data format?

Request serialization format?  Yes.  I can't see what is wrong with
that.  We need one anyway, and I don't see why inventing a new one is
any better than the one we already have in edk2.

Variable storage format?  Nope, that is not the case.  The variable
driver supports a cache, which I think is a read-only mapping of the
variable store, so using that might imply we have to use edk2 storage
format.  Didn't check in detail through.  The cache is optional, can be
disabled at compile time using PcdEnableVariableRuntimeCache=FALSE, and
I intentionally do not use the cache feature, exactly to avoid unwanted
constrains to the host side implementation.

> It also means we can not easily expose UEFI
> variables that QEMU owns,

Qemu owning variables should be no problem.  Adding monitor commands to
read/write UEFI variables should be possible too.

> which can come in very handy when implementing MOR
> - another feature that depends on SMM today.

Have a pointer for me?  Google finds me
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/device-guard-requirements,
which describes the variable behavior (which I think should be no
problem to implement), but doesn't say a word about what exactly gets
locked when enabled ...

> In EC2, we are simply serializing all variable RTS calls to the hypervisor,

The edk2 code effectively does the same (with PcdEnableVariableRuntimeCache=FALSE).

> similar to the Xen implementation
> (https://www.youtube.com/watch?v=jiR8khaECEk).

Is the Xen implementation upstream?  Can't see a xen variable driver in
OvmfPkg.  The video is from 2019.  What is the state of this?

> The edk2 side code we have built is here:
> https://github.com/aws/uefi/tree/main/edk2-stable202211 (see anything with
> VarStore in the name).

Ok, so it's just the variables.  The edk2 variant also sends variable
policy requests (see Edk2VariablePolicyProtocol,
https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Library/VariablePolicyLib/ReadMe.md).
And it can easily be extended should the need arise in the future (all
requests are tagged with a protocol/event guid).

> Given that we deal with untrusted input, I would strongly prefer if we could
> move it to a Rust implementation instead though.

Valid point.

I've started in C because I have next no to experience with rust (yet),
so getting a test-able / demo-able implementation done was much easier
for me.  Also I think we don't have any rust infrastructure in qemu
(yet?).  Being able to use the qapi / qobject support to read/write the
variable store in json format is nice too.

But I'm open to discuss other options.

> We started a Rust
> reimplementation of it that interface that can build as a library with C
> bindings which QEMU could then link against:
> 
>   https://github.com/Mimoja/rs-uefi-varstore/tree/for_main
> 
> The code never went beyond the initial stages,

Hmm.  Why not?

> but if we're pulling the variable store to QEMU, this would be the
> best path forward IMHO.

Ok, so you are trying to sell me a prototype as solution?
/me looks a bit skeptical ...

take care,
  Gerd


