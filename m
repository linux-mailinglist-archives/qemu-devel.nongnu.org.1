Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8D47439D1
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:46:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFBdU-0008HC-8X; Fri, 30 Jun 2023 06:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qFBdR-0008Go-Ce
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qFBdP-0000OT-J9
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688121950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCjJ/3HVWCJE1nYaNZaE4QdPgEFIKn0AEg+JchUakM8=;
 b=RakH6Klp50cKVs6j1BLPToCiVpNNbmKkcLljlkATtlIUv1gJihSw3tLBwo61WOR+CFRkIt
 wfYG2m3NP5oUanJ1VuMmeK+wUCmKn3qp1B2Lqb6MT/D9PBWsq4mF5vL37HO4oGmEeEB+TQ
 l/P5rc86TzJdCnMmVk6sygJANWMw3cg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-0oqS5K8kPRy0rVT1BlSRSA-1; Fri, 30 Jun 2023 06:45:47 -0400
X-MC-Unique: 0oqS5K8kPRy0rVT1BlSRSA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-666e87eff0eso1674284b3a.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 03:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688121947; x=1690713947;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BCjJ/3HVWCJE1nYaNZaE4QdPgEFIKn0AEg+JchUakM8=;
 b=jiuz3YAOfP/h46ghtzyDAp7S8gX5yGmHYE1x680SwNkKi5E/odiXPXeNvt8ciIwk4P
 J2/ki1W+IVuV8hbVZQvluLIZ+eLvwJV2cCuvXrDTPFQn1vH2dBpr9nFrYrzqlLedBolr
 OA6WXTLwAF3SmG2512xCH5jI/0mwywxGm05eIZ8dbCqggIaj3lnrolNfjNilp1EPyBVN
 l3UtnJz/U9N3rdJ1k2dPzEAhtxui+x2phO+lgfxfX9mAFwUnkhF8ucxEFAWvIyVCS8UR
 PKYGXxuHQINsJLr4Vdu/BiPjSaXHSK3de8Hkm/GG/AB5JxiknQKjqE9Tnn0ZH/KB0Zpu
 I6Xg==
X-Gm-Message-State: ABy/qLa3LPr1YJ0Gua8iSup8YcKl8BoQFw2A5msKWkhwBMOcGjNcPuJY
 uZBksBIKvu71KqSuMy0ZWMKzFtAXzT6peNMlFa82BKTb0jyGD3lCHCPHv19+qr9w7BTZktL4K/W
 1wE4FTpkg7ifpWUY=
X-Received: by 2002:a05:6a00:843:b0:67c:5c21:b430 with SMTP id
 q3-20020a056a00084300b0067c5c21b430mr2985974pfk.33.1688121946850; 
 Fri, 30 Jun 2023 03:45:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGNCSc/vnwZnLJ6jLSMpde1PtBw+coE97HJVVWZUppGaebz/KDzg7j6jE62OYed2AtPzvCd1A==
X-Received: by 2002:a05:6a00:843:b0:67c:5c21:b430 with SMTP id
 q3-20020a056a00084300b0067c5c21b430mr2985962pfk.33.1688121946543; 
 Fri, 30 Jun 2023 03:45:46 -0700 (PDT)
Received: from smtpclient.apple ([115.96.128.249])
 by smtp.gmail.com with ESMTPSA id
 f4-20020aa78b04000000b0064fd4a6b306sm9725776pfd.76.2023.06.30.03.45.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Jun 2023 03:45:46 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230630063914-mutt-send-email-mst@kernel.org>
Date: Fri, 30 Jun 2023 16:15:42 +0530
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A725A09-B341-4711-B190-D8C6B07C4538@redhat.com>
References: <8868044c-f61b-7bbb-8cc8-34a14c1490d6@daynix.com>
 <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
 <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
 <A50CA177-0E7E-4828-A036-70EB532FE2B8@redhat.com>
 <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
 <20230630043734-mutt-send-email-mst@kernel.org>
 <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
 <20230630055717-mutt-send-email-mst@kernel.org>
 <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
 <20230630063914-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
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



> On 30-Jun-2023, at 4:10 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Fri, Jun 30, 2023 at 04:07:32PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 30-Jun-2023, at 3:30 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>=20
>>> On Fri, Jun 30, 2023 at 02:52:52PM +0530, Ani Sinha wrote:
>>>>=20
>>>>=20
>>>>> On 30-Jun-2023, at 2:13 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>>=20
>>>>> On Fri, Jun 30, 2023 at 02:06:59PM +0530, Ani Sinha wrote:
>>>>>>=20
>>>>>>=20
>>>>>>> On 30-Jun-2023, at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>>>>=20
>>>>>>> On Fri, Jun 30, 2023 at 01:11:33PM +0530, Ani Sinha wrote:
>>>>>>>>>=20
>>>>>>>>> Thus the check for unoccupied function 0 needs to use =
pci_is_vf() instead of checking ARI capability, and that can happen in =
do_pci_register_device().
>>>>>>>>>=20
>>>>>>>>>> Also where do you propose we move the check?
>>>>>>>>>=20
>>>>>>>>> In pci_qdev_realize(), somewhere after pc->realize() and =
before option ROM loading.
>>>>>>>>=20
>>>>>>>> Hmm, I tried this. The issue here is something like this would =
be now allowed since the PF has ARI capability:
>>>>>>>>=20
>>>>>>>> -device pcie-root-port,id=3Dp -device igb,bus=3Dp,addr=3D0x2.0x0
>>>>>>>>=20
>>>>>>>> The above should not be allowed and when used, we do not see =
the igb ethernet device from the guest OS.
>>>>>>>=20
>>>>>>> I think it's allowed because it expects you to hotplug function =
0 later,
>>>>>>=20
>>>>>> This is about the igb device being plugged into the non-zero slot =
of the pci-root-port. The guest OS ignores it.
>>>>>=20
>>>>> yes but if you later add a device with ARI and with next field =
pointing
>>>>> slot 2 guest will suddently find both.
>>>>=20
>>>> Hmm, I tried this:
>>>>=20
>>>> -device pcie-root-port,id=3Dp \
>>>> -device igb,bus=3Dp,addr=3D0x2.0x0 \
>>>> -device igb,bus=3Dp,addr=3D0x0.0x0 \
>>>>=20
>>>> The guest only found the second igb device not the first. You can =
try too.
>>>=20
>>> Because next parameter in pcie_ari_init does not match.
>>=20
>> OK send me a command line that I can test it with. I can=E2=80=99t =
come up with a case that actually works in practice.
>=20
>=20
> you need to patch igb to pass 2 as next parameter.
> maybe add a property to make it easier to play with.

Yes but without patching, could I not change the device parameters like

-device pcie-root-port,id=3Dp \
-device igb,bus=3Dp,addr=3D0x1.0x0 \
-device igb,bus=3Dp,addr=3D0x0.0x0 \

I tried the above and it did not work.

>=20
>>>=20
>>>=20
>>>>>=20
>>>>>>> no?
>>>>>>>=20
>>>>>>> I am quite worried about all this work going into blocking
>>>>>>> what we think is disallowed configurations. We should have
>>>>>>> maybe blocked them originally, but now that we didn't
>>>>>>> there's a non zero chance of regressions,
>>>>>>=20
>>>>>> Sigh,
>>>>>=20
>>>>> There's value in patches 1-4 I think - the last patch helped you =
find
>>>>> these. so there's value in this work.
>>>>>=20
>>>>>> no medals here for being brave :-)
>>>>>=20
>>>>> Try removing support for a 3.5mm jack next. Oh wait ...
>>>>=20
>>>> Indeed. Everyone uses bluetooth these days. I for one is happy that =
the jack is gone (and they were bold enough to do it while Samsung and =
others still carry the useless port ) :-)
>>>>=20
>>>>>=20
>>>>>>> and the benefit
>>>>>>> is not guaranteed.
>>>>>>>=20
>>>>>>> --=20
>>>>>>> MST


