Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDDA76461C
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 07:48:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOtlJ-0005Bm-7J; Thu, 27 Jul 2023 01:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qOtlC-0005Aj-W5
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 01:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qOtlB-0000Zp-JT
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 01:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690436520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hzJVzkgkEh7dOiAe7AF7Zwczg3HOXUOq/pU7NlgaikU=;
 b=YDbJUMEvm0wd621q4FpY6XhjfbONSpwH2uk29Pv+aNukosuxZXxZ96TqRrXQa/QZKWBnNL
 Q0HXtMuzVfFjJI4KoLQeHnHvbvVrLEmvHybYpf3f7Ur+YGO9UkPVbRhD5LHy7Sq0wjFfSZ
 kNqviYiEXPtUWJcpvUBRqJUSJiEgCN8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-mgStEPbvOTSXi_s9D5mLSQ-1; Thu, 27 Jul 2023 01:41:55 -0400
X-MC-Unique: mgStEPbvOTSXi_s9D5mLSQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-686b7576e2bso397345b3a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 22:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690436514; x=1691041314;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzJVzkgkEh7dOiAe7AF7Zwczg3HOXUOq/pU7NlgaikU=;
 b=IzqdFdnDJvjrxcvTcFrTGHC69Dke3kqo6+IU9oxhV3jENult8+ymThwaPXOtt0ogTn
 WudB6Fe1FWOpFPa1+IO+MBSS78mGxuvFiju+usz9zXfXoX8paHLHFVpnSjoFx5vyojeU
 m4U2lx9aVngDU1V8+Q3jGoF/9I/ost45yylH+nCo/FADxmseEezR3jAMHzOpTRePnLvS
 NqEZWaXGK8THQ0jZvzHW74Srlo12pi4TL/fqclEMe4MoHsBFAf4eug199WvLvU2SZuhf
 JhRcIhBOMEehv5GooU5cHt3EPZOFp1zbYzoA2TmhZVpTUzaut/OXLfnLx1jQhHPC2yTu
 ID/g==
X-Gm-Message-State: ABy/qLYzDB3LdikBw4ntidsAf4zGqRiysth9EQijcQPBxuwWXe4w1Cfe
 OYzGBy77+tQQrfk+cECc7Ac/u9yL8mjFKI6ppnqM8qIEwWKnPbaUqkeWZ7zirPrfoT3OzUIXjsp
 IQhKKNeUzVGdmFUk=
X-Received: by 2002:a05:6a00:b4c:b0:668:9dca:13ac with SMTP id
 p12-20020a056a000b4c00b006689dca13acmr4727216pfo.7.1690436514731; 
 Wed, 26 Jul 2023 22:41:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGw5Fcp8IJIqfTxl3D6ZL+7b6cSa3t2kcu/BUj6JnlE+h22p4N4TQ1TUlCHQVI9RfyLjAriVQ==
X-Received: by 2002:a05:6a00:b4c:b0:668:9dca:13ac with SMTP id
 p12-20020a056a000b4c00b006689dca13acmr4727195pfo.7.1690436514411; 
 Wed, 26 Jul 2023 22:41:54 -0700 (PDT)
Received: from smtpclient.apple ([115.96.104.156])
 by smtp.gmail.com with ESMTPSA id
 c13-20020aa7880d000000b006579b062d5dsm570762pfo.21.2023.07.26.22.41.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jul 2023 22:41:53 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v2 3/6] python/console_socket: accept existing FD in
 initializer
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230725180337.2937292-4-jsnow@redhat.com>
Date: Thu, 27 Jul 2023 11:11:47 +0530
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
Message-Id: <E0A63AE3-6368-4FB0-9D8B-18722398604A@redhat.com>
References: <20230725180337.2937292-1-jsnow@redhat.com>
 <20230725180337.2937292-4-jsnow@redhat.com>
To: John Snow <jsnow@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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
> Useful if we want to use ConsoleSocket() for a socket created by
> socketpair().
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> python/qemu/machine/console_socket.py | 29 +++++++++++++++++++--------
> 1 file changed, 21 insertions(+), 8 deletions(-)
>=20
> diff --git a/python/qemu/machine/console_socket.py =
b/python/qemu/machine/console_socket.py
> index 4e28ba9bb2..0a4e09ffc7 100644
> --- a/python/qemu/machine/console_socket.py
> +++ b/python/qemu/machine/console_socket.py
> @@ -24,19 +24,32 @@ class ConsoleSocket(socket.socket):
>     """
>     ConsoleSocket represents a socket attached to a char device.
>=20
> -    Optionally (if drain=3D=3DTrue), drains the socket and places the =
bytes
> -    into an in memory buffer for later processing.
> -
> -    Optionally a file path can be passed in and we will also
> -    dump the characters to this file for debugging purposes.
> +    :param address: An AF_UNIX path or address.
> +    :param sock_fd: Optionally, an existing socket file descriptor.
> +                    One of address or sock_fd must be specified.
> +    :param file: Optionally, a filename to log to.
> +    :param drain: Optionally, drains the socket and places the bytes
> +                  into an in memory buffer for later processing.
>     """
> -    def __init__(self, address: str, file: Optional[str] =3D None,
> +    def __init__(self,
> +                 address: Optional[str] =3D None,
> +                 sock_fd: Optional[int] =3D None,
> +                 file: Optional[str] =3D None,
>                  drain: bool =3D False):
> +        if address is None and sock_fd is None:
> +            raise ValueError("one of 'address' or 'sock_fd' must be =
specified")
> +        if address is not None and sock_fd is not None:
> +            raise ValueError("can't specify both 'address' and =
'sock_fd'")
> +
>         self._recv_timeout_sec =3D 300.0
>         self._sleep_time =3D 0.5
>         self._buffer: Deque[int] =3D deque()
> -        socket.socket.__init__(self, socket.AF_UNIX, =
socket.SOCK_STREAM)
> -        self.connect(address)
> +        if address is not None:
> +            socket.socket.__init__(self, socket.AF_UNIX, =
socket.SOCK_STREAM)
> +            self.connect(address)
> +        else:
> +            assert sock_fd is not None
> +            socket.socket.__init__(self, fileno=3Dsock_fd)
>         self._logfile =3D None
>         if file:
>             # pylint: disable=3Dconsider-using-with
> --=20
> 2.41.0
>=20


