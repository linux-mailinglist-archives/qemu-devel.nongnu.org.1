Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F03743B1C
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 13:49:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFCbG-00066J-2g; Fri, 30 Jun 2023 07:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qFCbA-00065y-1Q
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qFCb8-0004WZ-5C
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688125652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMQYqBJhD4kUBs7kbbsPg5cmD09HweMbaFFZIE5rrQo=;
 b=YX+KjIm+nGF6YB04LGr7CoXTaOgm2+6ehCflIhF7z19cPLvua0kbtBVq0SPyxFGXo+1KEn
 fWCXFGUQLhrvWq1Ir1EGpnESxxMlEOnqE72pHtWNsgBL28hYv9V71vEG9QnkxHl0o9V753
 DkWNrBlkW2TVGMHyj3LLCA7sRswTVI0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-GyQbqa2pOauu1brF1Dpuxw-1; Fri, 30 Jun 2023 07:47:31 -0400
X-MC-Unique: GyQbqa2pOauu1brF1Dpuxw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1b7f5436076so11883945ad.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 04:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688125650; x=1690717650;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bMQYqBJhD4kUBs7kbbsPg5cmD09HweMbaFFZIE5rrQo=;
 b=UWOekmtT5cK3htAXowbT5nW6YNrtnLOyEZfm8alP8QT8G6oE329UQPehOUUxb6C+uz
 mTVvdRc7s19g+DjEaYqiR90RiAbgSDBtGE8ljxezpNTpHMM1s8N9OImx+j9PW9Vx3x6A
 7P42TnGEJMnbqkQFUUetzmzV6b0eu5Zt6vjhKEfoygM3nsRX80iYtpvaC8Nk+OjIR25U
 eZ3nOxpxlsz1gX4ha9KKIFvIPUBrzP2XLO+F22tLRhnHv0MkIOkjm0p32T7CruQff0T9
 z5jqcdhZPVG3Yew5GIvS5n8lwuIFJ5l/2QH/jTeixK/usiSq40/b+T1zcl5Oxw0nqIxC
 HscA==
X-Gm-Message-State: ABy/qLYEhaERR/lcbIfy1a1kuwgMxk7X6VV9XAuZnLn6rQ+vK2VKdlTb
 KHqBgLJ/akZKIbvmaOjHKeMry8zjafNMnkUNK9W90d+JI+PrynB+zYXtESr/hGTJd6TjRgLwr8L
 v+3WcPah6qYE8FCQGbxCwptU=
X-Received: by 2002:a17:903:11c4:b0:1b0:f727:bc41 with SMTP id
 q4-20020a17090311c400b001b0f727bc41mr1614940plh.42.1688125649718; 
 Fri, 30 Jun 2023 04:47:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF74Ltiu7h5WFkDpI2BKVIb/O0T3Z8dGn6HhYtSDT2WGlfQxYHcnPPA2ABUQ49FIFtze4dN1w==
X-Received: by 2002:a17:903:11c4:b0:1b0:f727:bc41 with SMTP id
 q4-20020a17090311c400b001b0f727bc41mr1614927plh.42.1688125649401; 
 Fri, 30 Jun 2023 04:47:29 -0700 (PDT)
Received: from smtpclient.apple ([115.96.128.249])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a170902bd0b00b001a9b29b6759sm10698915pls.183.2023.06.30.04.47.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Jun 2023 04:47:29 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
Date: Fri, 30 Jun 2023 17:17:24 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <70C8CAAF-7AF3-4FFE-9D59-045E2F815D39@redhat.com>
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
 <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
 <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
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



> On 30-Jun-2023, at 5:06 PM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> On 2023/06/30 19:37, Ani Sinha wrote:
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
>> OK send me a command line that I can test it with. I can=E2=80=99t =
come up with a case that actually works in practice.
>=20
> I don't think there is one because the code for PCI multifunction does =
not care ARI. In my opinion, we need yet another check to make =
non-SR-IOV multifunction and ARI capability mutually exclusive; if a =
function has the ARI capability and it is not a VF, an attempt to assign =
non-zero function number for it should fail.
>=20
> But it should be a distinct check as it will need to check the =
function number bits.

I will leave this for mst to comment.

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
>=20
> Hello from a guy using a shiny M2 Macbook Air carrying the legacy jack =
with a 100-yen earphone. Even people who ported Linux to this machine =
spent efforts to get the jack to work on Linux ;)

Yes that is because the jack exists. If they did not make the jack work, =
it would be a broken device. With bluetooth being so pervasive, its =
mostly a matter of time before most devices stop shipping with a 3.5mm.

All I am saying is sometimes one needs to be bold to bring changes. =
Otherwise changes never come. Status quo is not an option IMHO.=20

>=20
>>>>=20
>>>>>=20
>>>>>>> and the benefit
>>>>>>> is not guaranteed.
>>>>>>>=20
>>>>>>> --=20
>>>>>>> MST


