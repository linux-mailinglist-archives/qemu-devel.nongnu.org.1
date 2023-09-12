Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C033E79D176
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 14:56:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg2vY-0004FO-1s; Tue, 12 Sep 2023 08:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qfwIk-0000nz-S7; Tue, 12 Sep 2023 01:51:07 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qfwIf-0008FV-DY; Tue, 12 Sep 2023 01:51:06 -0400
Received: from [192.168.20.96] (210-10-213-150.per.static-ipl.aapt.com.au
 [210.10.213.150])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C238820135;
 Tue, 12 Sep 2023 13:50:48 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1694497851;
 bh=CcFdZd17f9QNqmTuAtW45PEeDnOL7pNFrLkMD+t5LJc=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=fHCnAyrYk0CaKECFJUVanjE6Q0WF0GuKjPvdEosJaXH9bJFKMekjlZVSIutixKFiA
 j3f6dx/2Dn2t6pw7Mi8foSGgKYkRo69i1dBhhQEdNyGdy2m+6JAh4bKg9DYcl0N/nO
 TS8rwwJt0CiT3KWSzIZsaji3gwp34yOuCiCs9DNuROIN75beYW5oflOAUySxsjDhnA
 8R1yDudRw2Q0v8soC71XDgvjCEjIdluABGTCkGA+T9WZ50qIV3YW2iZo+Tuqoru/tP
 EH7bQhYLykmJEn4gRz+FzvwnKPnIg8liMER7J1QXKjY0pWpZHS6T9O7Yno7yd9xbbP
 m4Do4pmIke2Qg==
Message-ID: <130f973070f4422e226a9e68218109094f0420fa.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 3/3] hw/nvme: add nvme management interface model
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Klaus Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,  Keith Busch
 <kbusch@kernel.org>
Cc: Lior Weintraub <liorw@pliops.com>, Jeremy Kerr
 <jk@codeconstruct.com.au>,  Matt Johnston <matt@codeconstruct.com.au>,
 Peter Delevoryas <peter@pjd.dev>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>, Andrew Jeffery
 <andrew@aj.id.au>
Date: Tue, 12 Sep 2023 13:50:41 +0800
In-Reply-To: <20230905-nmi-i2c-v5-3-0001d372a728@samsung.com>
References: <20230905-nmi-i2c-v5-0-0001d372a728@samsung.com>
 <20230905-nmi-i2c-v5-3-0001d372a728@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Sep 2023 08:55:22 -0400
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

Hi Klaus,

On Tue, 2023-09-05 at 10:38 +0200, Klaus Jensen wrote:
> >=20
> > +static void nmi_handle_mi_config_get(NMIDevice *nmi, NMIRequest
> > *request)
> > +{
> > +=C2=A0=C2=A0=C2=A0 uint32_t dw0 =3D le32_to_cpu(request->dw0);
> > +=C2=A0=C2=A0=C2=A0 uint8_t identifier =3D FIELD_EX32(dw0,
> > NMI_CMD_CONFIGURATION_GET_DW0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IDENTIFI=
ER);
> > +=C2=A0=C2=A0=C2=A0 const uint8_t *buf;
> > +
> > +=C2=A0=C2=A0=C2=A0 static const uint8_t smbus_freq[4] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00,=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* success =
*/
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x01, 0x00, 0x00,=C2=A0=C2=
=A0 /* 100 kHz */
> > +=C2=A0=C2=A0=C2=A0 };
> > +
> > +=C2=A0=C2=A0=C2=A0 static const uint8_t mtu[4] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00,=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* success */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x40, 0x00, /* 64 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00,=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* reserved */
> > +=C2=A0=C2=A0=C2=A0 };
> > +
> > +=C2=A0=C2=A0=C2=A0 trace_nmi_handle_mi_config_get(identifier);
> > +
> > +=C2=A0=C2=A0=C2=A0 switch (identifier) {
> > +=C2=A0=C2=A0=C2=A0 case NMI_CMD_CONFIGURATION_GET_SMBUS_FREQ:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf =3D smbus_freq;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +
> > +=C2=A0=C2=A0=C2=A0 case NMI_CMD_CONFIGURATION_GET_MCTP_TRANSMISSION_UN=
IT:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf =3D mtu;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +
> > +=C2=A0=C2=A0=C2=A0 default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nmi_set_parameter_error(nmi=
, 0x0, offsetof(NMIRequest,
> > dw0));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 nmi_scratch_append(nmi, buf, sizeof(buf));
> > +}

When I tried to build this patch I got:

```
In file included from /usr/include/string.h:535,
                 from /home/andrew/src/qemu.org/qemu/include/qemu/osdep.h:1=
12,
                 from ../hw/nvme/nmi-i2c.c:12:
In function =E2=80=98memcpy=E2=80=99,
    inlined from =E2=80=98nmi_scratch_append=E2=80=99 at ../hw/nvme/nmi-i2c=
.c:80:5,
    inlined from =E2=80=98nmi_handle_mi_config_get=E2=80=99 at ../hw/nvme/n=
mi-i2c.c:246:5,
    inlined from =E2=80=98nmi_handle_mi=E2=80=99 at ../hw/nvme/nmi-i2c.c:26=
6:9,
    inlined from =E2=80=98nmi_handle=E2=80=99 at ../hw/nvme/nmi-i2c.c:313:9=
:
/usr/include/x86_64-linux-gnu/bits/string_fortified.h:29:10: error: =E2=80=
=98__builtin_memcpy=E2=80=99 forming offset [4, 7] is out of the bounds [0,=
 4] [-Werror=3Darray-bounds=3D]
   29 |   return __builtin___memcpy_chk (__dest, __src, __len,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   30 |                                  __glibc_objsize0 (__dest));
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~
```

It wasn't clear initially from the error that the source of the problem
was the size associated with the source buffer, especially as there is
some pointer arithmetic being done to derive `__dest`.

Anyway, what we're trying to express is that the size to copy from buf
is the size of the array pointed to by buf. However, buf is declared as
a pointer to uint8_t, which loses the length information. To fix that I
think we need:

- const uint8_t *buf;
+ const uint8_t (*buf)[4];

and then:

- nmi_scratch_append(nmi, buf, sizeof(buf));
+ nmi_scratch_append(nmi, buf, sizeof(*buf));

Andrew


