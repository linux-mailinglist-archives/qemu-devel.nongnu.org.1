Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D14BF7F3345
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 17:09:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5TIY-0003Ws-3I; Tue, 21 Nov 2023 11:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r5TIV-0003Q1-B7
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:08:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r5TIR-0005VX-Aq
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700582898;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=k0wFm5EK4/ld2kZkumlKGAXhj9GyIivcRy2zIbMehLs=;
 b=ArFzHDfkD1DA2uXHmXFTChL9KUFooSjlA2+3KlXlxO9Ik8bXHZKyaHRbFDoNS595dA7gC3
 YnU9R2r7q6SAg7y+lyze+N0Kjv0grkHcUUIN7nNtlM5gu9UM0nktC12Por5ADeCqJxtZzv
 aCUS3qHbo8LVhOM1ZQoOloIfjeCK73Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-vhU-WqJXOmCqezATCmplbA-1; Tue,
 21 Nov 2023 11:08:14 -0500
X-MC-Unique: vhU-WqJXOmCqezATCmplbA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65DC3280AA22;
 Tue, 21 Nov 2023 16:08:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41814492BE0;
 Tue, 21 Nov 2023 16:08:11 +0000 (UTC)
Date: Tue, 21 Nov 2023 16:08:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <graf@amazon.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>, mimoja@mimoja.de
Subject: Re: [PATCH 00/16] hw/uefi: add uefi variable service
Message-ID: <ZVzV6Au_FYK6Rav6@redhat.com>
References: <20231115151242.184645-1-kraxel@redhat.com>
 <9db15906-9474-4a6e-82a9-5275c72cf2b4@amazon.com>
 <nxzed5dhgjpn3fafjttocvxe6ztxxf5xhghaqncpdxup6y7o7y@47i3eyoehio2>
 <7bfb52e6-3698-7c44-5927-31d47d031d57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7bfb52e6-3698-7c44-5927-31d47d031d57@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Nov 21, 2023 at 04:58:44PM +0100, Laszlo Ersek wrote:
> On 11/20/23 17:50, Gerd Hoffmann wrote:
> > On Mon, Nov 20, 2023 at 12:53:45PM +0100, Alexander Graf wrote:
> >> Hey Gerd!
> >>
> >> On 15.11.23 16:12, Gerd Hoffmann wrote:
> >>> This patch adds a virtual device to qemu which the uefi firmware can use
> >>> to store variables.  This moves the UEFI variable management from
> >>> privileged guest code (managing vars in pflash) to the host.  Main
> >>> advantage is that the need to have privilege separation in the guest
> >>> goes away.
> >>>
> >>> On x86 privileged guest code runs in SMM.  It's supported by kvm, but
> >>> not liked much by various stakeholders in cloud space due to the
> >>> complexity SMM emulation brings.
> >>>
> >>> On arm privileged guest code runs in el3 (aka secure world).  This is
> >>> not supported by kvm, which is unlikely to change anytime soon given
> >>> that even el2 support (nested virt) is being worked on for years and is
> >>> not yet in mainline.
> >>>
> >>> The design idea is to reuse the request serialization protocol edk2 uses
> >>> for communication between SMM and non-SMM code, so large chunks of the
> >>> edk2 variable driver stack can be used unmodified.  Only the driver
> >>> which traps into SMM mode must be replaced by a driver which talks to
> >>> qemu instead.
> >>
> >>
> >> I'm not sure I like the split :). If we cut things off at the SMM
> >> communication layer, we still have a lot of code inside the Runtime Services
> >> (RTS) code that is edk2 specific which means we're tying ourselves tightly
> >> to the edk2 data format.
> > 
> > Which data format?
> > 
> > Request serialization format?  Yes.  I can't see what is wrong with
> > that.
> 
> ... I can't even see what's wrong with *that*. Realistically /
> practically, I think only edk2 has been considered as guest UEFI
> firmware for QEMU/KVM virtual machines, as far as upstream projects go.
> It's certainly edk2 that's bundled with QEMU.
> 
> My understanding is that firmware is just considered a part of the
> virtualization platform, so teaching edk2 specifics to QEMU doesn't seem
> wrong. (As long as we have the personpower to maintain interoperability.)
> 
> > We need one anyway, and I don't see why inventing a new one is
> > any better than the one we already have in edk2.
> > 
> > Variable storage format?  Nope, that is not the case.  The variable
> > driver supports a cache, which I think is a read-only mapping of the
> > variable store, so using that might imply we have to use edk2 storage
> > format.  Didn't check in detail through.  The cache is optional, can be
> > disabled at compile time using PcdEnableVariableRuntimeCache=FALSE, and
> > I intentionally do not use the cache feature, exactly to avoid unwanted
> > constrains to the host side implementation.
> > 
> >> It also means we can not easily expose UEFI
> >> variables that QEMU owns,
> > 
> > Qemu owning variables should be no problem.  Adding monitor commands to
> > read/write UEFI variables should be possible too.
> 
> This patch set is actually an improvement towards QEMU-owned variables.
> Right now, all variables are internal to the guest; QEMU only has a
> pflash-level view.

To throw confidental computing into the mix....

Right now for SEV-SNP/TDX, the EDK2 builds are stateless so that
variables are thrown away at poweroff.

Long term though there's interest in having the ability to (optionally)
offer persistence of variables to confidential computing too.

The key issue is that the host QEMU is not trusted so it would not be
viable to let QEMU receive the variables in plain text.

One option I've illustrated before is that have SVSM (or equiv)
expose an encrypted storage service to EDK2. Given the proposed EDK2
side protocol/modifications for variable storage, I wonder if it is
viable for SVSM (or equiv) to replace QEMU in providing the backend
storage impl ?  IOW, host QEMU would expose a pflash to the guest,
to which SVSM would apply full disk encryption, and then store the
EFI variables in it

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


