Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FB87B9B2B
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 08:50:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoIAv-0003vV-BS; Thu, 05 Oct 2023 02:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoIAt-0003v8-3m
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:49:31 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoIAr-0001uH-7Z
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:49:30 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3231df054c4so636452f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 23:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696488567; x=1697093367; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vo/DTzLq37qj27YbytgTdlW7fbh84Qr9RpThrSGRRws=;
 b=X1u2bD/qf91SuZIWFNZdF7ZMdKZ2jCfQa/+/GjJ8LXVAIaWcbUmxMcG1Mo//5i4xNG
 hSSR9ISAwfi1UO58TOX0mEqQhjLzHhhJc+2iMnXYMPm9lRGoTDuyYFHun+CSxfuAalyw
 GC2ue3C87iVt0nJqGgLa1+oGPmo5Z0mA7nVBjVHCtpXdqJJoxQvbqWceXu6g3ayV1qKy
 i3ttDdcxY+/d+TBL5v6LqZOwYpPc5/NW0Dkd8pZrpgcK13Cd4kUOqU6QseKsyZ2h3wew
 uXooWBSUe4qzN1weL8fYOyyzRxkns0kO2wZTtmd9qgAHd0IDmMLKHu+73CvFy1b6LTwp
 5Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696488567; x=1697093367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vo/DTzLq37qj27YbytgTdlW7fbh84Qr9RpThrSGRRws=;
 b=sU+crop6Ca3bmmse4Obcp4ltDQmwWUo4Pk34HIckrpmgHQh/1XcNJazqp8z2/p4djZ
 9DJJz7otPjowjkgflg1Yrzvpxgquho6I9zpdclVfe3BCa+wRu5lQhkLvWP4YQS30FbZe
 fae/zQ5qQlBin9dnyFYObAf/lQMYC4xwXZ6po4RWAkGwgMfdTkb5pgyN1eMYrqr6YCQO
 4SYr75hhCLaW4q3i5IuJ8jdjdEuIbyI9yT6mSHlZRfk1Hx22RmoQ+6kT73m4OuHXowAg
 xUf87V+EeAv7ZuZ3vSYP2a9RiVwE/4eiTpSbNtzA2fXMyiOMddFxbTbTpkFJe4gXO8hz
 HNOg==
X-Gm-Message-State: AOJu0Yznqso/9SpMKQRjMa8FLWmaF8CW0ZEi3REvvB80LHz8Z4paxlN7
 j6ijiD+N3ujQGtft0atFsRR9wQ==
X-Google-Smtp-Source: AGHT+IEOA0Fu6s3bz/Xux1GjBcOQKGdRaJONtpetsfYyp4YkGrM9jLYX1nmhFLjtttb4K+2AAlVy4Q==
X-Received: by 2002:a5d:4dcc:0:b0:318:69:ab03 with SMTP id
 f12-20020a5d4dcc000000b003180069ab03mr3982794wru.17.1696488567592; 
 Wed, 04 Oct 2023 23:49:27 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a5d510a000000b00324887a13f7sm1009771wrt.0.2023.10.04.23.49.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 23:49:27 -0700 (PDT)
Message-ID: <afab0b07-51b4-81e5-2e7f-03099a7be858@linaro.org>
Date: Thu, 5 Oct 2023 08:49:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v8 2/2] tpm: add backend for mssim
Content-Language: en-US
To: James Bottomley <jejb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
References: <20231004184219.6594-1-jejb@linux.ibm.com>
 <20231004184219.6594-3-jejb@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004184219.6594-3-jejb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi James,

On 4/10/23 20:42, James Bottomley wrote:
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
>      -tpmdev mssim,id=tpm0 \
>      -device tpm-crb,tpmdev=tpm0 \
> 
> to use a remote emulator replace the first line with
> 
>      -tpmdev "{'type':'mssim','id':'tpm0','command':{'type':inet,'host':'remote','port':'2321'}}"
> 
> tpm-tis also works as the backend.
> 
> Signed-off-by: James Bottomley <jejb@linux.ibm.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 
> ---
> 
> v2: convert to SocketAddr json and use qio_channel_socket_connect_sync()
> v3: gate control power off by migration state keep control socket disconnected
>      to test outside influence and add docs.
> v7: TPMmssim -> TPMMssim; doc and json fixes
>      Make command socket open each time (makes OS debugging easier)
> ---
>   MAINTAINERS              |   6 +
>   backends/tpm/Kconfig     |   5 +
>   backends/tpm/meson.build |   1 +
>   backends/tpm/tpm_mssim.c | 319 +++++++++++++++++++++++++++++++++++++++
>   backends/tpm/tpm_mssim.h |  44 ++++++
>   docs/specs/tpm.rst       |  39 +++++
>   qapi/tpm.json            |  32 +++-
>   softmmu/tpm-hmp-cmds.c   |   9 ++
>   8 files changed, 451 insertions(+), 4 deletions(-)
>   create mode 100644 backends/tpm/tpm_mssim.c
>   create mode 100644 backends/tpm/tpm_mssim.h


> diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
> index efe124a148..4fe6c5f051 100644
> --- a/docs/specs/tpm.rst
> +++ b/docs/specs/tpm.rst
> @@ -274,6 +274,42 @@ available as a module (assuming a TPM 2 is passed through):
>     /sys/devices/LNXSYSTEM:00/LNXSYBUS:00/MSFT0101:00/tpm/tpm0/pcr-sha256/9
>     ...
>   
> +The QEMU TPM Microsoft Simulator Device
> +---------------------------------------
> +
> +The Microsoft Simulator (mssim) is the reference emulation platform
> +for the TCG TPM 2.0 specification.  It provides a reference
> +implementation for the TPM 2.0 written by Microsoft (See
> +`ms-tpm-20-ref`_ on github).  The reference implementation starts a
> +network server and listens for TPM commands on port 2321 and TPM
> +Platform control commands on port 2322, although these can be altered.
> +The QEMU mssim TPM backend talks to this implementation.  By default
> +it connects to the default ports on localhost:
> +
> +.. code-block:: console
> +
> +  qemu-system-x86_64 <qemu-options> \
> +    -tpmdev mssim,id=tpm0 \
> +    -device tpm-crb,tpmdev=tpm0
> +
> +
> +Although it can also communicate with a remote host, which must be
> +specified as a SocketAddress via json or dotted keys on the command
> +line for each of the command and control ports:
> +
> +.. code-block:: console
> +
> +  qemu-system-x86_64 <qemu-options> \
> +    -tpmdev "{'type':'mssim','id':'tpm0','command':{'type':'inet','host':'remote','port':'2321'},'control':{'type':'inet','host':'remote','port':'2322'}}" \
> +    -device tpm-crb,tpmdev=tpm0

Did you test running this command line on a big-endian host?

> +The mssim backend supports snapshotting and migration by not resetting
> +the TPM on start up and not powering it down on halt if the VM is in
> +migration, but the state of the Microsoft Simulator server must be
> +preserved (or the server kept running) outside of QEMU for restore to
> +be successful.
> +
>   The QEMU TPM emulator device
>   ----------------------------
>   
> @@ -547,3 +583,6 @@ the following:
>   
>   .. _SWTPM protocol:
>      https://github.com/stefanberger/swtpm/blob/master/man/man3/swtpm_ioctls.pod
> +
> +.. _ms-tpm-20-ref:
> +   https://github.com/microsoft/ms-tpm-20-ref


