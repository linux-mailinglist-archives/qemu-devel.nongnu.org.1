Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBFF809158
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 20:31:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBK3z-0000N3-T5; Thu, 07 Dec 2023 14:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rBK3y-0000Me-3H
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 14:29:34 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rBK3w-0003Ub-Ah
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 14:29:33 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1feeea75fbfso563060fac.3
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 11:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701977371; x=1702582171; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdGAeNm4c2zpwBr8EQZ4K22LGpUxWZZJ+YaoPjW32GQ=;
 b=IaaYupvkwFhVgHl3z6GUhCmmp6VrF7rUlf0xuGm6UvRYZxv8ze0cPCo25n1H+/jnp7
 yhwMECKqQ2DeqdKGBTa+QaVvGob4bzTauRQG9Nk22ApS3gk2e+YNE80pcWLhtpTf97lr
 ksLHMJdH9596t72RGeAYg/M+1pmaZHYh7Hnlg7ShqdJKEuySd+ggJKwpUArabRTM889b
 RxELh+Fhcugjrtnbw47MDO6mJ5MJXd3kYwPb6WGAM/3Z0ZvXjPRZA/PWD/zR2q3xslW1
 CrAm/4B4UNw02NNz+LUmGEzaTjdC4PZevWtrCnGwnTV02Vl5Uq1HH5vY9tXVK5Nql3jN
 /rAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701977371; x=1702582171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdGAeNm4c2zpwBr8EQZ4K22LGpUxWZZJ+YaoPjW32GQ=;
 b=Y3btAdouK8CoNKc9tub9Jn/tGmAlbDQloDl/W33CnPBuQixsmsJe59fs2M0pKGFAcN
 16c6cIbpCliY1oGVF41Gk3F94UBBXk7x6m4VXIFvQQwx7RNf2nMKVGTZfUATnRzffuBf
 hhcwDFJyLL+IwjpKlmcp/PvIbw4+gGjJ0kldSiL64Z6xiSdV8/dfPB4Q7+ZZ88taNrLU
 imqbOOW0UjOwRqxbcPMNkyXlhmG8p3ymKm9/i382qZZkED01NT+51138sq7RJPgCH5NJ
 9F5g5tWtwPkcYPdOE/QhTg95QZBiJcKpC2AVPd2tT2YSgl+j7LOpsmtr3RMdYHwJ1WY+
 k5HQ==
X-Gm-Message-State: AOJu0Yw4achcTVMLYzANqgVZ1lIKUGNIpea+TCFzTgKazFScOAOWjO+1
 9QSXwJ4KM0faOnuHlQIHltSA9JF4a8StrgqW2ZU=
X-Google-Smtp-Source: AGHT+IHeWEokbyIkF5xdsNsSVzs3x6V7jIKnJ3s5kqfItd2VFRhOnmrTRXKomBCxGFMm628120+WE+mQy9FTO7/gxak=
X-Received: by 2002:a05:6870:2101:b0:1fb:75a:c44c with SMTP id
 f1-20020a056870210100b001fb075ac44cmr3138516oae.117.1701977370807; Thu, 07
 Dec 2023 11:29:30 -0800 (PST)
MIME-Version: 1.0
References: <20231207130623.360473-1-alex.bennee@linaro.org>
In-Reply-To: <20231207130623.360473-1-alex.bennee@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 7 Dec 2023 14:29:18 -0500
Message-ID: <CAJSP0QU0x6Kds74LOzbfRy0X2igxS_7XydwL68Sfy3ypT_=j8A@mail.gmail.com>
Subject: Re: [PATCH for 8.2] docs: clean-up the xenpvh documentation
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, vikram.garhwal@amd.com, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 7 Dec 2023 at 08:07, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> I noticed the code blocks where not rendering properly so thought I'd
> better fix things up. So:
>
>   - Use better title for the machine type
>   - Explain why Xen is a little different
>   - Add a proper anchor to the tpm-device link
>   - add newline so code block properly renders
>   - add some indentation to make continuation clearer
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/specs/tpm.rst         |  2 ++
>  docs/system/arm/xenpvh.rst | 39 +++++++++++++++++++++-----------------
>  2 files changed, 24 insertions(+), 17 deletions(-)

QEMU 8.2.0-rc3 has already been tagged. At this stage only critical
bugs (crashes during startup, security issues, serious memory leaks,
etc).

This patch looks like a nice documentation fix but it has a limited
scope and I don't think it warrants rolling an -rc4 tag next week.

Do you agree with deferring this patch until after the 8.2 release?

Stefan

>
> diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
> index efe124a148..c96776a369 100644
> --- a/docs/specs/tpm.rst
> +++ b/docs/specs/tpm.rst
> @@ -1,3 +1,5 @@
> +.. _tpm-device:
> +
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  QEMU TPM Device
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/docs/system/arm/xenpvh.rst b/docs/system/arm/xenpvh.rst
> index e1655c7ab8..430ac2c02e 100644
> --- a/docs/system/arm/xenpvh.rst
> +++ b/docs/system/arm/xenpvh.rst
> @@ -1,34 +1,39 @@
> -XENPVH (``xenpvh``)
> +Xen Device Emulation Backend (``xenpvh``)
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -This machine creates a IOREQ server to register/connect with Xen Hypervi=
sor.
>
> -When TPM is enabled, this machine also creates a tpm-tis-device at a use=
r input
> -tpm base address, adds a TPM emulator and connects to a swtpm applicatio=
n
> -running on host machine via chardev socket. This enables xenpvh to suppo=
rt TPM
> -functionalities for a guest domain.
> +This machine is a little unusual compared to others as QEMU just acts
> +as an IOREQ server to register/connect with Xen Hypervisor. Control of
> +the VMs themselves is left to the Xen tooling.
>
> -More information about TPM use and installing swtpm linux application ca=
n be
> -found at: docs/specs/tpm.rst.
> +When TPM is enabled, this machine also creates a tpm-tis-device at a
> +user input tpm base address, adds a TPM emulator and connects to a
> +swtpm application running on host machine via chardev socket. This
> +enables xenpvh to support TPM functionalities for a guest domain.
> +
> +More information about TPM use and installing swtpm linux application
> +can be found in the :ref:`tpm-device` section.
>
>  Example for starting swtpm on host machine:
> +
>  .. code-block:: console
>
>      mkdir /tmp/vtpm2
>      swtpm socket --tpmstate dir=3D/tmp/vtpm2 \
> -    --ctrl type=3Dunixio,path=3D/tmp/vtpm2/swtpm-sock &
> +      --ctrl type=3Dunixio,path=3D/tmp/vtpm2/swtpm-sock &
>
>  Sample QEMU xenpvh commands for running and connecting with Xen:
> +
>  .. code-block:: console
>
>      qemu-system-aarch64 -xen-domid 1 \
> -    -chardev socket,id=3Dlibxl-cmd,path=3Dqmp-libxl-1,server=3Don,wait=
=3Doff \
> -    -mon chardev=3Dlibxl-cmd,mode=3Dcontrol \
> -    -chardev socket,id=3Dlibxenstat-cmd,path=3Dqmp-libxenstat-1,server=
=3Don,wait=3Doff \
> -    -mon chardev=3Dlibxenstat-cmd,mode=3Dcontrol \
> -    -xen-attach -name guest0 -vnc none -display none -nographic \
> -    -machine xenpvh -m 1301 \
> -    -chardev socket,id=3Dchrtpm,path=3Dtmp/vtpm2/swtpm-sock \
> -    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -machine tpm-base-addr=
=3D0x0C000000
> +      -chardev socket,id=3Dlibxl-cmd,path=3Dqmp-libxl-1,server=3Don,wait=
=3Doff \
> +      -mon chardev=3Dlibxl-cmd,mode=3Dcontrol \
> +      -chardev socket,id=3Dlibxenstat-cmd,path=3Dqmp-libxenstat-1,server=
=3Don,wait=3Doff \
> +      -mon chardev=3Dlibxenstat-cmd,mode=3Dcontrol \
> +      -xen-attach -name guest0 -vnc none -display none -nographic \
> +      -machine xenpvh -m 1301 \
> +      -chardev socket,id=3Dchrtpm,path=3Dtmp/vtpm2/swtpm-sock \
> +      -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -machine tpm-base-addr=
=3D0x0C000000
>
>  In above QEMU command, last two lines are for connecting xenpvh QEMU to =
swtpm
>  via chardev socket.
> --
> 2.39.2
>
>

