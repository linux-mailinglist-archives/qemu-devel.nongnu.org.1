Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B140C7AA8B0
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 08:01:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjZDx-0006AV-Ju; Fri, 22 Sep 2023 02:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjZDq-00068a-2Z
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 02:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjZDf-0002RI-NI
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 02:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695362449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ui+wE2nBi84wnQXIUsdSxnPYvmq0IuswJ3AzG7nl26w=;
 b=h2jGGI44a9jD9ny5521016H2pUy91bLnYNiSfV/X81hJ4PZpEJ4t5uoDFLBrdY9NFVFOp5
 Uw7KsFnRksYTjEzBJgle8ZhvSu+fTbb9+h4lM1hNFVRlzjsFDEfCtHaHCqENz1DJiF5S4c
 QKSDbGqzy8m+EU8i4dnEzUu8Gjo36vQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-0s31ys7mMHmuclaawqrrZw-1; Fri, 22 Sep 2023 02:00:45 -0400
X-MC-Unique: 0s31ys7mMHmuclaawqrrZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6289285A5BD;
 Fri, 22 Sep 2023 06:00:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 235A220268D7;
 Fri, 22 Sep 2023 06:00:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1555C21E6900; Fri, 22 Sep 2023 08:00:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: James Bottomley <jejb@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 2/2] tpm: add backend for mssim
References: <20230109161532.6892-1-jejb@linux.ibm.com>
 <20230109161532.6892-3-jejb@linux.ibm.com>
Date: Fri, 22 Sep 2023 08:00:44 +0200
In-Reply-To: <20230109161532.6892-3-jejb@linux.ibm.com> (James Bottomley's
 message of "Mon, 9 Jan 2023 11:15:32 -0500")
Message-ID: <87bkduwxv7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Found this cleaning out old mail, sorry for missing it until now!

I think we owe James a quick decision wether we're willing to take the
feature.  Stefan, thoughts?

James Bottomley <jejb@linux.ibm.com> writes:

> From: James Bottomley <James.Bottomley@HansenPartnership.com>
>
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
> Signed-off-by: James Bottomley <jejb@linux.ibm.com>

[...]

> diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
> index 535912a92b..1398735956 100644
> --- a/docs/specs/tpm.rst
> +++ b/docs/specs/tpm.rst
> @@ -270,6 +270,38 @@ available as a module (assuming a TPM 2 is passed through):
>    /sys/devices/LNXSYSTEM:00/LNXSYBUS:00/MSFT0101:00/tpm/tpm0/pcr-sha256/9
>    ...
>  
> +The QEMU TPM Microsoft Simulator Device
> +---------------------------------------
> +
> +The TCG provides a reference implementation for TPM 2.0 written by


Suggest to copy the cover letter's nice introductory paragraph here:

  The Microsoft Simulator (mssim) is the reference emulation platform
  for the TCG TPM 2.0 specification.

  It provides a reference implementation for TPM 2.0 written by

> +Microsoft (See `ms-tpm-20-ref`_ on github).  The reference implementation
> +starts a network server and listens for TPM commands on port 2321 and
> +TPM Platform control commands on port 2322, although these can be
> +altered.  The QEMU mssim TPM backend talks to this implementation.  By
> +default it connects to the default ports on localhost:
> +
> +.. code-block:: console
> +
> +  qemu-system-x86_64 <qemu-options> \
> +    -tpmdev mssim,id=tpm0 \
> +    -device tpm-crb,tpmdev=tpm0
> +
> +
> +Although it can also communicate with a remote host, which must be
> +specified as a SocketAddress via json on the command line for each of

Is the "via JSON" part in "must be specified ... on the command line"
correct?  I'd expect to be able to use dotted keys as well, like

    -tpmdev type=mssim,id=tpm0,command.type=inet,command.host=remote,command.port=2321',control.type=inet,control.host=remote,control.port=2322

Aside: I do recommend management applications stick to JSON.

> +the command and control ports:
> +
> +.. code-block:: console
> +
> +  qemu-system-x86_64 <qemu-options> \
> +    -tpmdev "{'type':'mssim','id':'tpm0','command':{'type':'inet','host':'remote','port':'2321'},'control':{'type':'inet','host':'remote','port':'2322'}}" \
> +    -device tpm-crb,tpmdev=tpm0
> +
> +
> +The mssim backend supports snapshotting and migration, but the state
> +of the Microsoft Simulator server must be preserved (or the server
> +kept running) outside of QEMU for restore to be successful.
> +
>  The QEMU TPM emulator device
>  ----------------------------
>  
> @@ -526,3 +558,6 @@ the following:
>  
>  .. _SWTPM protocol:
>     https://github.com/stefanberger/swtpm/blob/master/man/man3/swtpm_ioctls.pod
> +
> +.. _ms-tpm-20-ref:
> +   https://github.com/microsoft/ms-tpm-20-ref
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index ed78a87ddd..12482368d0 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -731,6 +731,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>      unsigned int c = 0;
>      TPMPassthroughOptions *tpo;
>      TPMEmulatorOptions *teo;
> +    TPMmssimOptions *tmo;
>  
>      info_list = qmp_query_tpm(&err);
>      if (err) {
> @@ -764,6 +765,14 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>              teo = ti->options->u.emulator.data;
>              monitor_printf(mon, ",chardev=%s", teo->chardev);
>              break;
> +        case TPM_TYPE_MSSIM:
> +            tmo = &ti->options->u.mssim;
> +            monitor_printf(mon, ",command=%s:%s,control=%s:%s",
> +                           tmo->command->u.inet.host,
> +                           tmo->command->u.inet.port,
> +                           tmo->control->u.inet.host,
> +                           tmo->control->u.inet.port);
> +            break;
>          case TPM_TYPE__MAX:
>              break;
>          }
> diff --git a/qapi/tpm.json b/qapi/tpm.json
> index 2b491c28b4..f9dde35377 100644
> --- a/qapi/tpm.json
> +++ b/qapi/tpm.json
> @@ -5,6 +5,7 @@
>  ##
>  # = TPM (trusted platform module) devices
>  ##

Blank line, please.

> +{ 'include': 'sockets.json' }
>  
>  ##
>  # @TpmModel:
> @@ -49,7 +50,7 @@
   #
   # @passthrough: TPM passthrough type
   #
   # @emulator: Software Emulator TPM type (since 2.11)
>  #

Missing member documentation:

   # @mssim: <brief description here> (since 8.2)

>  # Since: 1.5
>  ##
> -{ 'enum': 'TpmType', 'data': [ 'passthrough', 'emulator' ],
> +{ 'enum': 'TpmType', 'data': [ 'passthrough', 'emulator', 'mssim' ],
>    'if': 'CONFIG_TPM' }
>  
>  ##
> @@ -64,7 +65,7 @@
>  # Example:
>  #
>  # -> { "execute": "query-tpm-types" }
> -# <- { "return": [ "passthrough", "emulator" ] }
> +# <- { "return": [ "passthrough", "emulator", "mssim" ] }

Thanks for updating the example.

>  #
>  ##
>  { 'command': 'query-tpm-types', 'returns': ['TpmType'],
> @@ -117,6 +118,22 @@
>    'data': { 'data': 'TPMEmulatorOptions' },
>    'if': 'CONFIG_TPM' }
>  
> +##
> +# @TPMmssimOptions:

Please capitalize similar to TPMPassthroughOptions and
TPMEmulatorOptions: TPMMssimOptions.

> +#
> +# Information for the mssim emulator connection
> +#
> +# @command: command socket for the TPM emulator

Blank line, please.

> +# @control: control socket for the TPM emulator
> +#
> +# Since: 7.2.0

Since 8.2

> +##
> +{ 'struct': 'TPMmssimOptions',
> +  'data': {
> +      '*command': 'SocketAddress',
> +      '*control': 'SocketAddress' },

Locally consistent indentation is

     'data': { '*command': 'SocketAddress',
               '*control': 'SocketAddress' },

> +  'if': 'CONFIG_TPM' }
> +
>  ##
>  # @TpmTypeOptions:
>  #
> @@ -124,6 +141,7 @@
>  #
>  # @type: - 'passthrough' The configuration options for the TPM passthrough type
>  #        - 'emulator' The configuration options for TPM emulator backend type
> +#        - 'mssim' The configuration options for TPM emulator mssim type
>  #
>  # Since: 1.5
>  ##
> @@ -131,7 +149,8 @@
>    'base': { 'type': 'TpmType' },
>    'discriminator': 'type',
>    'data': { 'passthrough' : 'TPMPassthroughOptionsWrapper',
> -            'emulator': 'TPMEmulatorOptionsWrapper' },
> +            'emulator': 'TPMEmulatorOptionsWrapper',
> +            'mssim' : 'TPMmssimOptions' },
>    'if': 'CONFIG_TPM' }
>  
>  ##
> @@ -150,7 +169,8 @@
>              'id' : 'str' },
>    'discriminator': 'type',
>    'data': { 'passthrough' : 'TPMPassthroughOptions',
> -            'emulator': 'TPMEmulatorOptions' },
> +            'emulator': 'TPMEmulatorOptions',
> +            'mssim': 'TPMmssimOptions' },
>    'if': 'CONFIG_TPM' }
>  
>  ##

Address my nitpicking, and you may add

Acked-by: Markus Armbruster <armbru@redhat.com>


