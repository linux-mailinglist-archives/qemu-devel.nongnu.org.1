Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F6E76344C
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 12:52:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOc6U-0002md-Gy; Wed, 26 Jul 2023 06:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qOc6Q-0002m9-SK
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 06:50:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qOc6P-0006QC-3E
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 06:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690368643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PD5HhGgtAoKXVCR/fk7txnORSMgwH0u7OuToY6KcWoo=;
 b=Q87iBK9hB5BTnQp87efdpKxdeN67iR1lkUN9+kGSBpL6IdNBxZb3z0eCHmgjGv3yXfHu9t
 zEjd7KBDm+zubQabuSGN/f0G+p0Tx/q/6p59NyXIthz4yRczSCxPUIVG0H1/X6/4+ppn+P
 jmG2oplM2O37X29bQ+/Tbw3YxvPPH5U=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-HZRAkl1xOwigcVtoyKZqzg-1; Wed, 26 Jul 2023 06:50:42 -0400
X-MC-Unique: HZRAkl1xOwigcVtoyKZqzg-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1bb83eb84e5so36828275ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 03:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690368641; x=1690973441;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PD5HhGgtAoKXVCR/fk7txnORSMgwH0u7OuToY6KcWoo=;
 b=hI9r/6KrF01UySJlzqMTxiq708hHKy0Gwu1mfg41/kd3QnxC07dvmvOq7mUUHiXXUG
 SOTo2lxxrZrUH+R4OvVD50RAlH56yKuhYxxcqjb7GY4BxYLL/rXvvLU1KiMS41/r3V8e
 LlsrCFvRyDtopGOusZFNCw5XT9MH/ltFaLFc9ieUsZsxoiLiYDvx7/J9Ek3I33puqo/P
 K4MySmETqQzahOs6xtp/7US6XUg6IlTV8Mk/ATRg3uREvY9IqO01lTHEIlX0iMDEoF7X
 4dq/F0UWOkkG2JMfQSC0Abf/Bi7Yme8cY+uASjN2am4DUCJJRNwV99zBruNZCHQPeaEO
 MP7A==
X-Gm-Message-State: ABy/qLZGHcSAU7KzFCJH2DaI3uWlkfDwL2ygYcg8+853UdrgE1YraMNK
 XRLpRvTJIB8IpA+RnoNZ3IcG5DEwVDxlxSRPWrDwBML1jvr8A+XrTj1Gk4Ikf3o2AaCfp3ePsXO
 6RGT19iTW/cuR9xU=
X-Received: by 2002:a17:902:e5c2:b0:1b8:987f:3f34 with SMTP id
 u2-20020a170902e5c200b001b8987f3f34mr2115693plf.25.1690368641280; 
 Wed, 26 Jul 2023 03:50:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE4Kr4Y1PZ/6+fwxwj4lKHAZiZJsaQyvuKrt51p6VhNlQwzU6wboq8Cbbz4Ic1iBCkbi3HxzQ==
X-Received: by 2002:a17:902:e5c2:b0:1b8:987f:3f34 with SMTP id
 u2-20020a170902e5c200b001b8987f3f34mr2115660plf.25.1690368640699; 
 Wed, 26 Jul 2023 03:50:40 -0700 (PDT)
Received: from smtpclient.apple ([115.96.152.59])
 by smtp.gmail.com with ESMTPSA id
 1-20020a170902c10100b001bb9aadfb04sm6938401pli.220.2023.07.26.03.50.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jul 2023 03:50:40 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v2 4/6] python/machine: use socketpair() for console
 connections
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230725180337.2937292-5-jsnow@redhat.com>
Date: Wed, 26 Jul 2023 16:20:33 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B867C4E8-24FC-4C4E-9FE8-2353CC21320C@redhat.com>
References: <20230725180337.2937292-1-jsnow@redhat.com>
 <20230725180337.2937292-5-jsnow@redhat.com>
To: John Snow <jsnow@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 25-Jul-2023, at 11:33 PM, John Snow <jsnow@redhat.com> wrote:
>=20
> Create a socketpair for the console output. This should help eliminate
> race conditions around console text early in the boot process that =
might
> otherwise have been dropped on the floor before being able to connect =
to
> QEMU under "server,nowait".
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Thanks for doing this. I recall we spoke about this late last year in =
the context of fixing my bios-bits avocado test and adding a console =
output there.
Except the concern below,

Reviewed-by: Ani Sinha <anisinha@redhat.com>


> ---
> python/qemu/machine/machine.py | 30 +++++++++++++++++++++++++++---
> 1 file changed, 27 insertions(+), 3 deletions(-)
>=20
> diff --git a/python/qemu/machine/machine.py =
b/python/qemu/machine/machine.py
> index 26f0fb8a81..09f214c95c 100644
> --- a/python/qemu/machine/machine.py
> +++ b/python/qemu/machine/machine.py
> @@ -159,6 +159,8 @@ def __init__(self,
>=20
>         self._name =3D name or f"{id(self):x}"
>         self._sock_pair: Optional[Tuple[socket.socket, socket.socket]] =
=3D None
> +        self._cons_sock_pair: Optional[
> +            Tuple[socket.socket, socket.socket]] =3D None
>         self._temp_dir: Optional[str] =3D None
>         self._base_temp_dir =3D base_temp_dir
>         self._sock_dir =3D sock_dir
> @@ -315,8 +317,9 @@ def _base_args(self) -> List[str]:
>         for _ in range(self._console_index):
>             args.extend(['-serial', 'null'])
>         if self._console_set:
> -            chardev =3D =
('socket,id=3Dconsole,path=3D%s,server=3Don,wait=3Doff' %
> -                       self._console_address)
> +            assert self._cons_sock_pair is not None
> +            fd =3D self._cons_sock_pair[0].fileno()
> +            chardev =3D f"socket,id=3Dconsole,fd=3D{fd}"
>             args.extend(['-chardev', chardev])
>             if self._console_device_type is None:
>                 args.extend(['-serial', 'chardev:console'])
> @@ -351,6 +354,10 @@ def _pre_launch(self) -> None:
>                 nickname=3Dself._name
>             )
>=20
> +        if self._console_set:
> +            self._cons_sock_pair =3D socket.socketpair()
> +            os.set_inheritable(self._cons_sock_pair[0].fileno(), =
True)
> +
>         # NOTE: Make sure any opened resources are *definitely* freed =
in
>         # _post_shutdown()!
>         # pylint: disable=3Dconsider-using-with
> @@ -368,6 +375,9 @@ def _pre_launch(self) -> None:
>     def _post_launch(self) -> None:
>         if self._sock_pair:
>             self._sock_pair[0].close()
> +        if self._cons_sock_pair:
> +            self._cons_sock_pair[0].close()
> +
>         if self._qmp_connection:
>             if self._sock_pair:
>                 self._qmp.connect()
> @@ -518,6 +528,11 @@ def _early_cleanup(self) -> None:
>             self._console_socket.close()
>             self._console_socket =3D None
>=20
> +        if self._cons_sock_pair:
> +            self._cons_sock_pair[0].close()
> +            self._cons_sock_pair[1].close()
> +            self._cons_sock_pair =3D None
> +
>     def _hard_shutdown(self) -> None:
>         """
>         Perform early cleanup, kill the VM, and wait for it to =
terminate.
> @@ -878,10 +893,19 @@ def console_socket(self) -> socket.socket:
>         Returns a socket connected to the console
>         """
>         if self._console_socket is None:
> +            if not self._console_set:
> +                raise QEMUMachineError(
> +                    "Attempt to access console socket with no =
connection")
> +            assert self._cons_sock_pair is not None
> +            # os.dup() is used here for sock_fd because otherwise =
we'd
> +            # have two rich python socket objects that would each try =
to
> +            # close the same underlying fd when either one gets =
garbage
> +            # collected.
>             self._console_socket =3D console_socket.ConsoleSocket(
> -                self._console_address,
> +                sock_fd=3Dos.dup(self._cons_sock_pair[1].fileno()),
>                 file=3Dself._console_log_path,
>                 drain=3Dself._drain_console)
> +            self._cons_sock_pair[1].close()

I am not 100% sure but should we save the new sock_fd here? Like
self._cons_sock_pair[1] =3D sock_fd ;

Then next time console_socket() is invoked, the correct fd will be =
duped.

>         return self._console_socket
>=20
>     @property
> --=20
> 2.41.0
>=20


