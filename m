Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3277EC7FB
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 16:57:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3IFh-0002x2-84; Wed, 15 Nov 2023 10:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r3IFe-0002wm-Mc
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:56:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r3IFc-0005MW-6v
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700063781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GFOptn6yyaE70AsxGCPMOgi0h3blHRDaoiTO1lXov7Q=;
 b=e0t3EesqatBju9tLW5at3Qh/DVUDd3w07M0NLiQ+SGH/dnP87up9XRFkIamqz8SriKoob3
 TG8bORjRFhB7Oz8WyhxzlHLmDCEBtlnnPZiJdRnH96/laLC06V99UJiy5eCWVuxIaSVoqw
 SwR/SG5RXRJkA/A9UFcv/qN5s8x+sig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-8k0g6HarPEKPuKwnii4kQg-1; Wed, 15 Nov 2023 10:56:17 -0500
X-MC-Unique: 8k0g6HarPEKPuKwnii4kQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AEB38058E9;
 Wed, 15 Nov 2023 15:56:17 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 89A55C1596F;
 Wed, 15 Nov 2023 15:56:15 +0000 (UTC)
Date: Wed, 15 Nov 2023 09:56:13 -0600
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, graf@amazon.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 16/16] docs: add uefi variable service documentation and
 TODO list.
Message-ID: <qrlcw7fn6hgd53nswpdnyybivzrtziekiubn7wu5hotmeyim2v@fs2db6jzbgzg>
References: <20231115151242.184645-1-kraxel@redhat.com>
 <20231115151242.184645-17-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115151242.184645-17-kraxel@redhat.com>
User-Agent: NeoMutt/20231103
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Nov 15, 2023 at 04:12:38PM +0100, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  docs/devel/index-internals.rst |  1 +
>  docs/devel/uefi-vars.rst       | 66 ++++++++++++++++++++++++++++++++++
>  hw/uefi/TODO.md                | 17 +++++++++
>  3 files changed, 84 insertions(+)
>  create mode 100644 docs/devel/uefi-vars.rst
>  create mode 100644 hw/uefi/TODO.md

> +
> +Guest UEFI variable management
> +==============================
> +
> +Traditional approach for UEFI Variable storage in qemu guests is to

The traditional

> +work as close as possible to physical hardware.  That means provide

providing

> +pflash as storage and leave the management of variables and flash to

leaving

> +the guest.

> +
> +Secure boot support comes with the requirement that the UEFI variable
> +storage must be protected against direct access by the OS.  All update
> +requests must pass the sanity checks.  (Parts of) the firmware must
> +run with a higher priviledge level than the OS so this can be enforced

privilege

> +by the firmware.  On x86 this has been implemented using System
> +Management Mode (SMM) in qemu and kvm, which again is the same
> +approach taken by physical hardware.  Only priviedged code running in

privileged

> +SMM mode is allowed to access flash storage.
> +
> +Communication with the firmware code running in SMM mode works by
> +serializing the requests to a shared buffer, then trapping into SMM
> +mode via SMI.  The SMM code processes the request, stores the reply in
> +the same buffer and returns.
> +
> +Host UEFI variable service
> +==========================
> +
> +Instead of running the priviledged code inside the guest we can run it

privileged

> +on the host.  The serialization protocol cen be reused.  The

can

> +communication with the host uses a virtual device, which essentially
> +allows to configure the shared buffer location and size and to trap to

s/allows to configure/configures/
s/and to trap/, and traps/

> +the host to process the requests.
> +
> +The ``uefi-vars`` device implements the UEFI virtual device.  It comes
> +in ``uefi-vars-isa`` and ``uefi-vars-sysbus`` flavours.  The device
> +reimplements the handlers needed, specifically
> +``EfiSmmVariableProtocol`` and ``VarCheckPolicyLibMmiHandler``.  It
> +also consumes events (``EfiEndOfDxeEventGroup``,
> +``EfiEventReadyToBoot`` and ``EfiEventExitBootServices``).
> +
> +The advantage of the approach is that we do not need a special
> +prividge level for the firmware to protect itself, i.e. it does not

privilege

> +depend on SMM emulation on x64, which allows to remove a bunch of

s/allows to remove/allows the removal of/

> +complex code for SMM emulation from the linux kernel
> +(CONFIG_KVM_SMM=n).  It also allows to support secure boot on arm

s/to support/support for/

> +without implementing secure world (el3) emulation in kvm.
> +
> +Of course there are also downsides.  The added device increases the
> +attack surface of the host, and we are adding some code duplication
> +because we have to reimplement some edk2 functionality in qemu.
> +

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


