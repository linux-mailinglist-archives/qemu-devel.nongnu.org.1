Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 682249F821C
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Dec 2024 18:40:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKVG-0000dC-Lu; Thu, 19 Dec 2024 12:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOKVE-0000a8-KP
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:40:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOKVC-0001vW-GQ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734629996;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/zcSvZ7eRbWw4Z4IJdiOlQvowwTZtOxqcEOvoDnKctQ=;
 b=P+9bUIicGqb+XdKKjkUeLVfS7PW5smj60jmDa8Fob6zgFmmE5vBh3JLN97LMiVkfvF8Rwe
 /rSK01H9lpHC0BSQzXwru/T74P5tUlHMkvKZUj6zHEnruG82AG00tvrohl3I3daj5JtHB3
 1Dk7F0D3FPId9KIdTdzrsObzQ95jpJk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-IalvRk_KOeWXx9qcK6CM6Q-1; Thu,
 19 Dec 2024 12:39:55 -0500
X-MC-Unique: IalvRk_KOeWXx9qcK6CM6Q-1
X-Mimecast-MFC-AGG-ID: IalvRk_KOeWXx9qcK6CM6Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDC3A1955F3D; Thu, 19 Dec 2024 17:39:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70A5619560AD; Thu, 19 Dec 2024 17:39:50 +0000 (UTC)
Date: Thu, 19 Dec 2024 17:39:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v11 2/2] tpm: add backend for mssim
Message-ID: <Z2RaYsLkazgciofM@redhat.com>
References: <20241212170528.30364-1-James.Bottomley@HansenPartnership.com>
 <20241212170528.30364-3-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212170528.30364-3-James.Bottomley@HansenPartnership.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Dec 12, 2024 at 12:05:28PM -0500, James Bottomley wrote:
> The Microsoft Simulator (mssim) is the reference emulation platform
> for the TCG TPM 2.0 specification.
> 
> https://github.com/Microsoft/ms-tpm-20-ref.git
> 
> It exports a fairly simple network socket based protocol on two
> sockets, one for command (default 2321) and one for control (default
> 2322).  This patch adds a simple backend that can speak the mssim
> protocol over the network.  It also allows the two sockets to be
> specified on the command line.  The benefits are twofold: firstly it
> gives us a backend that actually speaks a standard TPM emulation
> protocol instead of the linux specific TPM driver format of the
> current emulated TPM backend and secondly, using the microsoft
> protocol, the end point of the emulator can be anywhere on the
> network, facilitating the cloud use case where a central TPM service
> can be used over a control network.
> 
> The implementation does basic control commands like power off/on, but
> doesn't implement cancellation or startup.  The former because
> cancellation is pretty much useless on a fast operating TPM emulator
> and the latter because this emulator is designed to be used with OVMF
> which itself does TPM startup and I wanted to validate that.
> 
> To run this, simply download an emulator based on the MS specification
> (package ibmswtpm2 on openSUSE) and run it, then add these two lines
> to the qemu command and it will use the emulator.
> 
>     -tpmdev mssim,id=tpm0 \
>     -device tpm-crb,tpmdev=tpm0 \
> 
> to use a remote emulator replace the first line with
> 
>     -tpmdev "{'type':'mssim','id':'tpm0','command':{'type':inet,'host':'remote','port':'2321'}}"
> 
> tpm-tis also works as the backend.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 
> ---
> 
> v2: convert to SocketAddr json and use qio_channel_socket_connect_sync()
> v3: gate control power off by migration state keep control socket disconnected
>     to test outside influence and add docs.
> v7: TPMmssim -> TPMMssim; doc and json fixes
>     Make command socket open each time (makes OS debugging easier)
> v11: add startup method to make sure TPM is reset on reboot
> ---
>  MAINTAINERS              |   6 +
>  backends/tpm/Kconfig     |   5 +
>  backends/tpm/meson.build |   1 +
>  backends/tpm/tpm_mssim.c | 335 +++++++++++++++++++++++++++++++++++++++
>  backends/tpm/tpm_mssim.h |  44 +++++
>  docs/specs/tpm.rst       |  39 +++++
>  qapi/tpm.json            |  31 +++-
>  system/tpm-hmp-cmds.c    |   9 ++
>  8 files changed, 466 insertions(+), 4 deletions(-)
>  create mode 100644 backends/tpm/tpm_mssim.c
>  create mode 100644 backends/tpm/tpm_mssim.h
> 


> diff --git a/backends/tpm/tpm_mssim.c b/backends/tpm/tpm_mssim.c
> new file mode 100644
> index 0000000000..8f105fc924
> --- /dev/null
> +++ b/backends/tpm/tpm_mssim.c
> @@ -0,0 +1,335 @@
> +/*
> + * Emulator TPM driver which connects over the mssim protocol
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2022

Copyright by whom ? I presume yourself, but I wouldn't normally
assume the 'Author' line applies to the Copyright line.

> + * Author: James Bottomley <jejb@linux.ibm.com>
> + */
> +


> diff --git a/backends/tpm/tpm_mssim.h b/backends/tpm/tpm_mssim.h
> new file mode 100644
> index 0000000000..397474e4f6
> --- /dev/null
> +++ b/backends/tpm/tpm_mssim.h
> @@ -0,0 +1,44 @@
> +/*
> + * SPDX-License-Identifier: BSD-2-Clause
> + *
> + * The code below is copied from the Microsoft/TCG Reference implementation
> + *
> + *  https://github.com/Microsoft/ms-tpm-20-ref.git
> + *
> + * In file TPMCmd/Simulator/include/TpmTcpProtocol.h
> + */

That file has a volumous copyright header that I would expect to be
preserved here.


> diff --git a/qapi/tpm.json b/qapi/tpm.json
> index e6345d424b..eed4cb9e82 100644
> --- a/qapi/tpm.json
> +++ b/qapi/tpm.json
> @@ -6,6 +6,8 @@
>  # = TPM (trusted platform module) devices
>  ##
>  
> +{ 'include': 'sockets.json' }
> +
>  ##
>  # @TpmModel:
>  #
> @@ -48,9 +50,11 @@
>  #
>  # @emulator: Software Emulator TPM type (since 2.11)
>  #
> +# @mssim: Microsoft TPM Emulator (since 9.0)

Sorry, this needs a trivial bump to 10.0 now as that's
the current dev cycle

> +##
> +# @TPMMssimOptions:
> +#
> +# Information for the mssim emulator connection
> +#
> +# @command: command socket for the TPM emulator
> +#
> +# @control: control socket for the TPM emulator
> +#
> +# Since: 9.0

Likewise.

> +##
> +{ 'struct': 'TPMMssimOptions',
> +  'data': { '*command': 'SocketAddress',
> +            '*control': 'SocketAddress' },
> +  'if': 'CONFIG_TPM' }
> +
>  ##
>  # @TpmTypeOptions:
>  #


Functionally the code looks mergable with just those bureaucratic changes.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


