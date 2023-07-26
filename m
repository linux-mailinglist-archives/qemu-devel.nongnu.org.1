Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F571762CCA
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 09:12:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOYfi-0006ku-QE; Wed, 26 Jul 2023 03:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qOYff-0006ju-QE
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 03:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qOYfe-00049t-4P
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 03:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690355451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qRlABuytTMmZriWos7umoUGrtsGpCHoMMAEvcZWDQxE=;
 b=VehX1c2ZGcfCMmKsPHSo9zRC62zT8uVnWo+WMfyKZFvtKwHFX2Bnn+/O3GyehZaBwPMOCL
 ZPK6oz5tJejLd1D4PET2p2euTSnZZuBZYI7duoVxJLm/h4e8c6LgqkZNrJ9cSyO4YZIEdv
 za88xVZbzmlV5xLWH0zBSlT4+SD2Nsc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-lJa4fxaMNeGiId4hHIZk9A-1; Wed, 26 Jul 2023 03:10:49 -0400
X-MC-Unique: lJa4fxaMNeGiId4hHIZk9A-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5635233876bso3345671a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 00:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690355449; x=1690960249;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRlABuytTMmZriWos7umoUGrtsGpCHoMMAEvcZWDQxE=;
 b=bV3yDYsJz/qQCVABx7IUZQkV+Iwu1cr4lW4DZB+NefVrxfYOVMr6KA2fpPbZ4pp724
 qnA6WDv9MHJa+ar6N097a4SZoWlQjVI9tEJloLguHELBMtoyhQihEroigPBW05Rch0al
 7kJTlTXAsvJiOGnjvAwZ5eugYE3v/QlHTH1MHcTYgRQkWnqe56/Z6xe8aElX8hvJUppt
 vmsUEHlEhRvo4X81CJImnBXnwzjmvYQ3Oz1pH0SnIMQYEQ2URrd1ac+jn8j7HL4kstcT
 X89bIUII1EtEYdLH5WxnM4S8z1h5c82cwSOhlHJci2xqBRCImGx7yPh/VVUrVbN5b5EC
 FYiQ==
X-Gm-Message-State: ABy/qLZ2eI9+ZNhmY4KBXyjCVjoAozNC37mn18Gx7A96S2AsTgLSnmrd
 s9an4b1b6XHAkAENbrO6e09ZaUDlWjoUMdUjvrPngLPLswK0SyazR7K9HOYJxrrByXdEUNr//NN
 YithoewLMGPKFONw=
X-Received: by 2002:a05:6a20:3c90:b0:138:1980:1dd3 with SMTP id
 b16-20020a056a203c9000b0013819801dd3mr1093412pzj.14.1690355448846; 
 Wed, 26 Jul 2023 00:10:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF+8gzn+XYeSIg32fH2y7XQZ63pxyR7WH3gbfs8mIr+6WXieHEsXdRKccA9bQgRFX6W/skJ8A==
X-Received: by 2002:a05:6a20:3c90:b0:138:1980:1dd3 with SMTP id
 b16-20020a056a203c9000b0013819801dd3mr1093391pzj.14.1690355448560; 
 Wed, 26 Jul 2023 00:10:48 -0700 (PDT)
Received: from smtpclient.apple ([115.96.152.59])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a170902a61600b001b2069072ccsm12307634plq.18.2023.07.26.00.10.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jul 2023 00:10:48 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v2 1/6] python/machine: move socket setup out of
 _base_args property
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230725180337.2937292-2-jsnow@redhat.com>
Date: Wed, 26 Jul 2023 12:40:40 +0530
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
Message-Id: <F7950301-E4B8-422F-A1A5-4A34CFD2D170@redhat.com>
References: <20230725180337.2937292-1-jsnow@redhat.com>
 <20230725180337.2937292-2-jsnow@redhat.com>
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
> This property isn't meant to do much else besides return a list of
> strings, so move this setup back out into _pre_launch().
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> python/qemu/machine/machine.py | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/python/qemu/machine/machine.py =
b/python/qemu/machine/machine.py
> index c16a0b6fed..8be0f684fe 100644
> --- a/python/qemu/machine/machine.py
> +++ b/python/qemu/machine/machine.py
> @@ -300,9 +300,7 @@ def _base_args(self) -> List[str]:
>=20
>         if self._qmp_set:
>             if self._sock_pair:
> -                fd =3D self._sock_pair[0].fileno()
> -                os.set_inheritable(fd, True)
> -                moncdev =3D f"socket,id=3Dmon,fd=3D{fd}"
> +                moncdev =3D =
f"socket,id=3Dmon,fd=3D{self._sock_pair[0].fileno()}"
>             elif isinstance(self._monitor_address, tuple):
>                 moncdev =3D "socket,id=3Dmon,host=3D{},port=3D{}".format=
(
>                     *self._monitor_address
> @@ -339,6 +337,7 @@ def _pre_launch(self) -> None:
>         if self._qmp_set:
>             if self._monitor_address is None:
>                 self._sock_pair =3D socket.socketpair()
> +                os.set_inheritable(self._sock_pair[0].fileno(), True)
>                 sock =3D self._sock_pair[1]
>             if isinstance(self._monitor_address, str):
>                 self._remove_files.append(self._monitor_address)
> --=20
> 2.41.0
>=20


