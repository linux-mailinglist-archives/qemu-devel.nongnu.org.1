Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C65831987
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:52:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRBW-0004GO-T6; Thu, 18 Jan 2024 07:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rQRBM-0004AN-RO
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:07:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rQRBK-0004gw-Jv
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705579655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pdoCzx91suaJRF2wdJwkv7FmurTDxJhyYPodAAPVru4=;
 b=aIPN0Qd6kRFZNg4ON4MYako90QyeB/5bdHHqeENoq4JALIza8qtVqYKE6qWdyiYZebE7DV
 0laIzdx0f2dFH+tP/2dDw2i2eLWKilRNUY+8s46MifNENF1SvkyxKaGc4K94wr0fnDlrb1
 oP2dyKhl+vLMdxIFNsIc5oaiv42Cmf4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-rey8Cl2NOh2NnT4UNpoRCg-1; Thu, 18 Jan 2024 07:07:33 -0500
X-MC-Unique: rey8Cl2NOh2NnT4UNpoRCg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e8d72e1b3so10678785e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705579652; x=1706184452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdoCzx91suaJRF2wdJwkv7FmurTDxJhyYPodAAPVru4=;
 b=voDhVQ54WG/xhd0i0gsyHiYZC9kzqergWLVvxOSIltkLlEofXEhpXOysGdOJn4JeUZ
 qY76sXAJQX/GeFxqf2p+FaG4klsriQZX+2HO7ufpISnv2m3bH2lK/rXxKdBmv1PlZC7y
 f+bvi7BtMPgkpPN8jdzy9xRPkN5eEMaAy/HXCprsIm+VQYDqAJYADsLI4/TXdS38NnVJ
 TkUVWTSdS8I6DrciWVMnErnDtFW4B3Xq39IWFUNrVTqfLJF/iDfN5IoP74Y4gI+kUXt8
 B/RmWU0pghy27henDdtXuqfxCrYPbBHsOk8IdIxLUyNjV9ug1xL5gw5atPsJ6V3TEe9O
 1z4Q==
X-Gm-Message-State: AOJu0YxgSwXPH7nAq4c2Dq7h8CNXVSowzVDRCBsmt+VWD/XfS5qgmHU0
 tuWqGLTJi5IrOsTj+tXsFh2JRfLzO029SI6XOTQUyp7cUac+2j4OqkOguYka/A3GA2x+RCGl532
 PJjUYhgLGQriCo0OC7KORPQuU4VrUhce0+U3wYt9NXpuQObHtxzAG
X-Received: by 2002:a05:600c:293:b0:40e:7610:96e9 with SMTP id
 19-20020a05600c029300b0040e761096e9mr382396wmk.235.1705579652487; 
 Thu, 18 Jan 2024 04:07:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYTuB4WHNEXpiU8eJNIXd8JQRJQsGua/duz/vIkSOeMvD2A0m6WF+JqOvpmRHblTEyr4/VoQ==
X-Received: by 2002:a05:600c:293:b0:40e:7610:96e9 with SMTP id
 19-20020a05600c029300b0040e761096e9mr382386wmk.235.1705579652108; 
 Thu, 18 Jan 2024 04:07:32 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 q5-20020a5d5745000000b00337bdf4cfc6sm3877047wrw.52.2024.01.18.04.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:07:31 -0800 (PST)
Date: Thu, 18 Jan 2024 13:07:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Kai <kai.kang@windriver.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, mst@redhat.com
Subject: Re: [PATCH] qdev: not add devices to bus in reverse order
Message-ID: <20240118130730.02ff9194@imammedo.users.ipa.redhat.com>
In-Reply-To: <1db86e7c-9d4a-6c7d-9e6b-52054b2382cd@windriver.com>
References: <20240109092015.4136865-1-kai.kang@windriver.com>
 <CAFEAcA9LBXMxOzJwmXYEVj+q0hTzMQZrpZHOOKFYWZDKXFyHig@mail.gmail.com>
 <1db86e7c-9d4a-6c7d-9e6b-52054b2382cd@windriver.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

On Thu, 18 Jan 2024 14:48:50 +0800
Kai <kai.kang@windriver.com> wrote:

> On 1/18/24 01:31, Peter Maydell wrote:
> > (cc'd the people listed for this file in MAINTAINERS)
> >
> > On Tue, 9 Jan 2024 at 13:53, Kai Kang <kai.kang@windriver.com> wrote: =
=20
> >> When this section of source codes were added via commit:
> >>
> >> * 02e2da45c4 Add common BusState
> >>
> >> it added devices to bus with LIST_INSERT_HEAD() which operated on the
> >> single direction list. It didn't have something like LIST_INSERT_TAIL()
> >> at that time and kept that way when turned to QTAILQ.
> >>
> >> Then it causes the fist device in qemu command line inserted at the end
> >> of the bus child link list. And when realize them, the first device wi=
ll
> >> be the last one to be realized.
> >>
> >> Replace QTAILQ_INSERT_HEAD_RCU() with QTAILQ_INSERT_TAIL_RCU() to make
> >> sure that devices are added to bus with the sequence in the command
> >> line. =20
> > What are the problems being caused by the the list items being added
> > in reverse order? Your commit message doesn't say what specific
> > bug or problem it's trying to fix. =20
>=20
> The problem I met was just as I asked for for help in the maillist on=20
> Dec 18, 2023.
>=20
> The indexes of serial isa devices changes with the commit dcdbfaafe90a=20
> since qemu 6.2.0.
> Before the commit, it creates devices literally with "1" & "2":
>=20
> @@ -1252,8 +1222,6 @@ static void build_isa_devices_aml(Aml *table)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(scope, build=
_fdc_device_aml(fdc));
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0 aml_append(scope, build_lpt_device_aml());
> -=C2=A0=C2=A0=C2=A0 build_com_device_aml(scope, 1);
> -=C2=A0=C2=A0=C2=A0 build_com_device_aml(scope, 2);
>=20
> After apply the commit, it uses the 'aml builder' way and the devices=20
> are handled in reverse way.
> Then the indexes are reversed. It affects guest os such as freebsd. When=
=20
> run `pstat -t` on freebsd
> with qemu, the sequence of the output is not right.
>=20
> root@freebsd:~ # pstat -t
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LINE=C2=A0=C2=A0 INQ=C2=A0 CAN=C2=A0 LIN=
=C2=A0 LOW=C2=A0 OUTQ=C2=A0 USE=C2=A0 LOW=C2=A0=C2=A0 COL=C2=A0 SESS=C2=A0 =
PGID STATE
>  =C2=A0=C2=A0=C2=A0=C2=A0 ttyu2=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=
=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=
=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0 IC
>  =C2=A0=C2=A0=C2=A0=C2=A0 ttyu3=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=
=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=
=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0 IC
>  =C2=A0=C2=A0=C2=A0=C2=A0 ttyu1=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=
=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=
=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0 IC
>  =C2=A0=C2=A0=C2=A0=C2=A0 ttyu0=C2=A0 1920=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0 0=C2=A0 192=C2=A0 1984=C2=A0=C2=A0=C2=A0 0=C2=A0 199=C2=A0=C2=A0=
=C2=A0=C2=A0 0=C2=A0=C2=A0 664=C2=A0=C2=A0 668 ICOi
>=20
> It is expected with ascend order which keeps the same behavior with=20
> older version qemu.

this problem description should be in commit message.
As for fixing it I'd wouldn't touch bus order as Peter already noted
it has high chances to break behavior elsewhere.

current state of COM naming:
   1: QEMU 6.1  all machine types: COM1 { uid: 1, irq: 4}, COM2 { uid: 2, i=
rq: 3}
   2: QEMU 6.2+ all machine types: COM1 { uid: 2, irq: 4}, COM1 { uid: 1, i=
rq: 3}
all of above in default case where user doesn't supply 'index' explicitly.

With 'index' provided explicitly old case #1 might break due to
hardcoded resource values in former build_com_device_aml().
#2 (current code) doesn't have issues with resource values
when explicit 'index' is used (which can be a possible workaround)

So we essentially have changed enumeration for 6.1 and older
machine types in incompatible way with QEMU-6.2+ builds.
(and that in it's turn breaks exiting VM config when it
is started on QEMU-6.2+)

Kai,
Does above sum-up the issue you are encountering?

> Regards,
> Kai
>=20
> >
> > In general this kind of patch is something I'm very cautious about,
> > because it seems very likely that various bits of the code where
> > order does matter will currently be expecting (and working around)
> > the reverse-order behaviour, because that's what has been done by
> > bus_add_child() for the last 20-plus years. (As one concrete example,
> > see the big comment at the top of create_virtio_devices() in
> > hw/arm/virt.c. There are probably others where we didn't comment
> > on the ordering but just assume it.)
> > =20
> >> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> >> index 43d863b0c5..5e2ff43715 100644
> >> --- a/hw/core/qdev.c
> >> +++ b/hw/core/qdev.c
> >> @@ -89,7 +89,7 @@ static void bus_add_child(BusState *bus, DeviceState=
 *child)
> >>       kid->child =3D child;
> >>       object_ref(OBJECT(kid->child));
> >>
> >> -    QTAILQ_INSERT_HEAD_RCU(&bus->children, kid, sibling);
> >> +    QTAILQ_INSERT_TAIL_RCU(&bus->children, kid, sibling);
> >>
> >>       /* This transfers ownership of kid->child to the property.  */
> >>       snprintf(name, sizeof(name), "child[%d]", kid->index); =20
> > thanks
> > -- PMM =20
>=20
>=20


