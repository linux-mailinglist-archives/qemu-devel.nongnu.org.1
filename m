Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D2389EFF2
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Apr 2024 12:37:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruVJA-0004M1-Tb; Wed, 10 Apr 2024 06:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ruVIt-0004Ky-GF
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 06:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ruVIr-00022E-LB
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 06:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712745339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c/JhOomIpUEzNGGVS15jcROIQDytxa86oqbJB+CBiFI=;
 b=IlL8cuIfNKqVV1FOpq73XQLkhvEHUK3+X+yFZEJ27d+zuoOlwdxFcAr5WYKHisTs1F5erg
 r1I3TWF26Ps7YVBjJwkfipDd8owv5K8LSc31GnlKImacrMgEr7xV73N7JoiI6MBzEQ21zU
 4dSyddlMWwFSMFyqpEO8uTEpkKcns48=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-_TUMpmo-P-6iZvyJKmTODA-1; Wed, 10 Apr 2024 06:35:35 -0400
X-MC-Unique: _TUMpmo-P-6iZvyJKmTODA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2050A802A6F;
 Wed, 10 Apr 2024 10:35:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 912CE490F9;
 Wed, 10 Apr 2024 10:35:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5EC3B18009BB; Wed, 10 Apr 2024 12:35:13 +0200 (CEST)
Date: Wed, 10 Apr 2024 12:35:13 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Daniel Berrange <berrange@redhat.com>, 
 Cole Robinson <crobinso@redhat.com>
Subject: secure boot & direct kernel load (was: Re: [PATCH] x86/loader: only
 patch linux kernels)
Message-ID: <p4ifsoadheo2phszidswkl63ttt6wkq4luxk55gtlteaz6umpk@mb4gmtrrx3tt>
References: <20240410072126.617063-1-kraxel@redhat.com>
 <20240410032448-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410032448-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 10, 2024 at 03:26:29AM -0400, Michael S. Tsirkin wrote:
> On Wed, Apr 10, 2024 at 09:21:26AM +0200, Gerd Hoffmann wrote:
> > If the binary loaded via -kernel is *not* a linux kernel (in which
> > case protocol == 0), do not patch the linux kernel header fields.
> > 
> > It's (a) pointless and (b) might break binaries by random patching
> > and (c) changes the binary hash which in turn breaks secure boot
> > verification.
> > 
> > Background: OVMF happily loads and runs not only linux kernels but
> > any efi binary via direct kernel boot.
> > 
> > Note: Breaking the secure boot verification is a problem for linux
> > kernels too, but fixed that is left for another day ...
> 
> Um we kind of care about Linux ;)
> 
> What's the plan?  I suspect we should just add a command line flag
> to skip patching? And once we do that, it seems safer to just
> always rely on the flag?

Well, there are more problems to solve here than just the patching.  So
lets have a look at the bigger picture before discussion the details ...

[ Cc'ing Daniel + Cole ]

Current state of affairs is that OVMF supports two ways to boot a linux
kernel:

 (1) Just load it as EFI binary and boot via linux kernel EFI stub,
     which is the modern way to load a linux kernel (which is why you
     can boot not only linux kernels but any efi binary).

 (2) Use the old EFI handover protocol.  Which is the RHEL-6 era way to
     boot a linux kernel on EFI.

For method (1) secure boot verification must pass.  For (2) not.  So if
you try to use direct kernel boot with secure boot enabled OVMF will
first try (1), which will fail, then go fallback to (2).

The reason for the failure is not only the patching, but also the fact
that the linux kernel is typically verified by shim.efi (and the distro
keys compiled into the binary) instead of the firmware.

Going though (2) is not ideal for multiple reasons, so we need some
strategy how we'll go handle direct kernel load with uefi and secure
boot in a way that (1) works.

Options I see:

  (a) Stop using direct kernel boot, let virt-install & other tools
      create vfat boot media with shim+kernel+initrd instead.

  (b) Enroll the distro signing keys in the efi variable store, so
      booting the kernel without shim.efi works.

  (c) Add support for loading shim to qemu (and ovmf), for example
      with a new '-shim' command line option which stores shim.efi
      in some new fw_cfg file.

(b) + (c) both require a fix for the patching issue.  The options
I see here are:

  (A) Move the patching from qemu to the linuxboot option rom.
      Strictly speaking it belongs there anyway.  It doesn't look
      that easy though, for qemu it is easier to gather all
      information needed ...

  (B) Provide both patched and unpatched setup header, so the
      guest can choose what it needs.

  (C) When implementing (c) above we can piggyback on the -shim
      switch and skip patching in case it is present.

  (D) Add a flag to skip the patching.

Comments?  Other/better ideas?

take care,
  Gerd


