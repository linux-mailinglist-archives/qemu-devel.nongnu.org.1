Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2147439B8
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:38:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFBVY-0005q6-RU; Fri, 30 Jun 2023 06:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qFBVX-0005pi-2D
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qFBVV-0005Ew-Af
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688121460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d3Z/EPFFqSCIrBpr7qf3suhgrD1zE6HK6eSf53Wv/l8=;
 b=JnkUcGu/jLnUu6KmHTb1RzHMCzHteWmUoDT9jahW91wudihsea1W4kF+t7SfbNWucKyhdq
 CGB2kJUT+JhDID8Cv6lLJY7WfLm1APHiuSMjbJxCBw2wOgl9oCGEMTVTV8a5a/+zjdkLh6
 a8il0LK0qSgfDixSUgjg951G56cJiic=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-HPFb5izkPLW-fBrZXsxlMQ-1; Fri, 30 Jun 2023 06:37:38 -0400
X-MC-Unique: HPFb5izkPLW-fBrZXsxlMQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1b7f2239a04so16047745ad.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 03:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688121457; x=1690713457;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d3Z/EPFFqSCIrBpr7qf3suhgrD1zE6HK6eSf53Wv/l8=;
 b=hcu5Wqichp5KPtvXNPS7U9RpqwmK6RKkptSthwCO9Pq0bYZTCl+XxwtT+pC6aBf4Lw
 VraBrcEg9hMwB9vpQE+rghgCt+3NWUznl4h31AmZyxc3QT8ubbXTaXGwPk90JhlaTrj4
 7gniUloOI44QuiJno7QLpHx6NE3REe6Ew/tbchHjprv2zSxdhdwt+4wn9AnFF0g7Vnhg
 IIzR7hTvmncW3YoBJkMErvnii681gnPeZjwFl/XzfcxiCe4lm5bAznvz83mv6HZHfIEt
 IuyevWSt5AvDXb026X1Qlqh5H2j8M1xg8I3ZaeIVLMsEvHGgeZXuxa/L94n20n3l0YZT
 9GyA==
X-Gm-Message-State: ABy/qLZ26ZQR6IbFAP79cV8HJPYh5jCNDRTarqAyZyGPFAMKcZSthN06
 k53qwgIJNPu33iHDzLOxKKaMN0oKRA4JFvKd2ZmAm7l9TE0p01ex151jCeE8QHU0VFQ/sAecp6T
 /ktj8NAEId5vgA1Q=
X-Received: by 2002:a17:902:b20b:b0:1b8:3c5e:228a with SMTP id
 t11-20020a170902b20b00b001b83c5e228amr1555656plr.10.1688121457469; 
 Fri, 30 Jun 2023 03:37:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEzJOrlz6INe9Ww1uvMFS5JOmtKIXsd/+zpAuW9EgjvZTP3tjazLkbvlppMhtR4eq5xt8QKdg==
X-Received: by 2002:a17:902:b20b:b0:1b8:3c5e:228a with SMTP id
 t11-20020a170902b20b00b001b83c5e228amr1555644plr.10.1688121457144; 
 Fri, 30 Jun 2023 03:37:37 -0700 (PDT)
Received: from smtpclient.apple ([115.96.128.249])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f54900b001b510f55296sm4023233plf.174.2023.06.30.03.37.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Jun 2023 03:37:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230630055717-mutt-send-email-mst@kernel.org>
Date: Fri, 30 Jun 2023 16:07:32 +0530
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
References: <8d382e8b-088b-f0af-eec4-a85ee513b4ae@daynix.com>
 <CAK3XEhNOJkm13+vxJO9-Adhwq8NJ3TQ1gaOXj8Dn3NtixF_=jQ@mail.gmail.com>
 <8868044c-f61b-7bbb-8cc8-34a14c1490d6@daynix.com>
 <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
 <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
 <A50CA177-0E7E-4828-A036-70EB532FE2B8@redhat.com>
 <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
 <20230630043734-mutt-send-email-mst@kernel.org>
 <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
 <20230630055717-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
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



> On 30-Jun-2023, at 3:30 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Fri, Jun 30, 2023 at 02:52:52PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 30-Jun-2023, at 2:13 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>=20
>>> On Fri, Jun 30, 2023 at 02:06:59PM +0530, Ani Sinha wrote:
>>>>=20
>>>>=20
>>>>> On 30-Jun-2023, at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>>=20
>>>>> On Fri, Jun 30, 2023 at 01:11:33PM +0530, Ani Sinha wrote:
>>>>>>>=20
>>>>>>> Thus the check for unoccupied function 0 needs to use =
pci_is_vf() instead of checking ARI capability, and that can happen in =
do_pci_register_device().
>>>>>>>=20
>>>>>>>> Also where do you propose we move the check?
>>>>>>>=20
>>>>>>> In pci_qdev_realize(), somewhere after pc->realize() and before =
option ROM loading.
>>>>>>=20
>>>>>> Hmm, I tried this. The issue here is something like this would be =
now allowed since the PF has ARI capability:
>>>>>>=20
>>>>>> -device pcie-root-port,id=3Dp -device igb,bus=3Dp,addr=3D0x2.0x0
>>>>>>=20
>>>>>> The above should not be allowed and when used, we do not see the =
igb ethernet device from the guest OS.
>>>>>=20
>>>>> I think it's allowed because it expects you to hotplug function 0 =
later,
>>>>=20
>>>> This is about the igb device being plugged into the non-zero slot =
of the pci-root-port. The guest OS ignores it.
>>>=20
>>> yes but if you later add a device with ARI and with next field =
pointing
>>> slot 2 guest will suddently find both.
>>=20
>> Hmm, I tried this:
>>=20
>> -device pcie-root-port,id=3Dp \
>> -device igb,bus=3Dp,addr=3D0x2.0x0 \
>> -device igb,bus=3Dp,addr=3D0x0.0x0 \
>>=20
>> The guest only found the second igb device not the first. You can try =
too.
>=20
> Because next parameter in pcie_ari_init does not match.

OK send me a command line that I can test it with. I can=E2=80=99t come =
up with a case that actually works in practice.

>=20
>=20
>>>=20
>>>>> no?
>>>>>=20
>>>>> I am quite worried about all this work going into blocking
>>>>> what we think is disallowed configurations. We should have
>>>>> maybe blocked them originally, but now that we didn't
>>>>> there's a non zero chance of regressions,
>>>>=20
>>>> Sigh,
>>>=20
>>> There's value in patches 1-4 I think - the last patch helped you =
find
>>> these. so there's value in this work.
>>>=20
>>>> no medals here for being brave :-)
>>>=20
>>> Try removing support for a 3.5mm jack next. Oh wait ...
>>=20
>> Indeed. Everyone uses bluetooth these days. I for one is happy that =
the jack is gone (and they were bold enough to do it while Samsung and =
others still carry the useless port ) :-)
>>=20
>>>=20
>>>>> and the benefit
>>>>> is not guaranteed.
>>>>>=20
>>>>> --=20
>>>>> MST


