Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D24747389
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:05:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgdF-0001HN-6b; Tue, 04 Jul 2023 10:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGgdC-0001Gg-Vn
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGgdB-00019q-3q
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688479426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HGQ9hZFGQLrKuJSqFy9SwAoU5nURgXAj670lLeJ6VY=;
 b=KpOL3Qgubr/+2CtkGBl1yM23UHP4lzrVhbjI9R8Mscl6+m9hR8TQ3vLxBXHhxQ+2ugzUUx
 0Bd9SJcqMEIE8yuE2ZiU3vqjN3ohuDfvCglE6lyqpLxj392i/MneTR8RmEdD58X90gy5wZ
 4nq/sVCFqz5eOhoyXP7KfxAyKfhBu80=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-Id9FsJOlN2iAiz_yh_gebQ-1; Tue, 04 Jul 2023 10:03:45 -0400
X-MC-Unique: Id9FsJOlN2iAiz_yh_gebQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-66871648c25so7558949b3a.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688479424; x=1691071424;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4HGQ9hZFGQLrKuJSqFy9SwAoU5nURgXAj670lLeJ6VY=;
 b=MZwydPZXfCle0YDO7yOFFP9BOHw135jJiHWjdaT3V/osCPdX03trX/jP30C900Op3z
 HKYew5j9lmtDUJo524+lDHdbDO1gK27y9MiCyxA5KnVYMEGIpM6mZofY+ojOJFnH2p++
 btJ3EZBB0K5wLCabBT1z4bq5OSq0F6YBIeJ2Sr/X8b8vqD5Q4P6k5HCVBdHkgtQG01tw
 AvTfWoibmtscX8P6/OVokUrxk0I6XKzCmsmVXuO7AoQETmziqUYwuK9cvKFV0MYmz/WC
 0xjeQyJxsOO6/MG+cdX1sXtZYY1U5MYGV/1ArCfGEtXMM9JhRopvPIU2hNLDM19ShHLK
 v0mA==
X-Gm-Message-State: ABy/qLbpnjdhfS3im8x70wCvSDtt1SoMF8LnVMyzX4mHayPeF8jTTIod
 dGse4Cn4oE2FUyfUrEnn68V/DBEWKIWDyZPGSOlRRPw6k0NiyKBOr3mWec/Z4zlJJeuO1ffuWsa
 Wjl5PRMKPITSqD/Q=
X-Received: by 2002:a05:6a00:854:b0:681:50fd:2b93 with SMTP id
 q20-20020a056a00085400b0068150fd2b93mr20004907pfk.25.1688479423984; 
 Tue, 04 Jul 2023 07:03:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEFovg4N/G6T/nLO/Hu54EWfL1X/7EWlztpouww0pY5yVDwXyyVjfPXQkMeAGPSMow2KipKLQ==
X-Received: by 2002:a05:6a00:854:b0:681:50fd:2b93 with SMTP id
 q20-20020a056a00085400b0068150fd2b93mr20004864pfk.25.1688479423470; 
 Tue, 04 Jul 2023 07:03:43 -0700 (PDT)
Received: from smtpclient.apple ([115.96.131.170])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a62b605000000b00640f51801e6sm15660732pff.159.2023.07.04.07.03.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Jul 2023 07:03:43 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <a6cf6a37-ae26-1725-f564-bc46b2dc892a@daynix.com>
Date: Tue, 4 Jul 2023 19:33:38 +0530
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A2291A2-91AD-4AA5-BA39-419C052C45AF@redhat.com>
References: <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
 <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
 <A50CA177-0E7E-4828-A036-70EB532FE2B8@redhat.com>
 <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
 <20230630043734-mutt-send-email-mst@kernel.org>
 <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
 <20230630055717-mutt-send-email-mst@kernel.org>
 <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
 <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
 <20230630112611-mutt-send-email-mst@kernel.org>
 <0879ed66-766c-1d3f-dcce-31e1285a7972@daynix.com>
 <20230704133801.0423b554@imammedo.users.ipa.redhat.com>
 <a6cf6a37-ae26-1725-f564-bc46b2dc892a@daynix.com>
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



> On 04-Jul-2023, at 5:20 PM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> On 2023/07/04 20:38, Igor Mammedov wrote:
>> On Sat, 1 Jul 2023 16:28:30 +0900
>> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>> On 2023/07/01 0:29, Michael S. Tsirkin wrote:
>>>> On Fri, Jun 30, 2023 at 08:36:38PM +0900, Akihiko Odaki wrote:
>>>>> On 2023/06/30 19:37, Ani Sinha wrote:
>>>>>>=20
>>>>>> =20
>>>>>>> On 30-Jun-2023, at 3:30 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>>>>=20
>>>>>>> On Fri, Jun 30, 2023 at 02:52:52PM +0530, Ani Sinha wrote:
>>>>>>>>=20
>>>>>>>> =20
>>>>>>>>> On 30-Jun-2023, at 2:13 PM, Michael S. Tsirkin =
<mst@redhat.com> wrote:
>>>>>>>>>=20
>>>>>>>>> On Fri, Jun 30, 2023 at 02:06:59PM +0530, Ani Sinha wrote:
>>>>>>>>>>=20
>>>>>>>>>> =20
>>>>>>>>>>> On 30-Jun-2023, at 2:02 PM, Michael S. Tsirkin =
<mst@redhat.com> wrote:
>>>>>>>>>>>=20
>>>>>>>>>>> On Fri, Jun 30, 2023 at 01:11:33PM +0530, Ani Sinha wrote:
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Thus the check for unoccupied function 0 needs to use =
pci_is_vf() instead of checking ARI capability, and that can happen in =
do_pci_register_device().
>>>>>>>>>>>>> =20
>>>>>>>>>>>>>> Also where do you propose we move the check?
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> In pci_qdev_realize(), somewhere after pc->realize() and =
before option ROM loading.
>>>>>>>>>>>>=20
>>>>>>>>>>>> Hmm, I tried this. The issue here is something like this =
would be now allowed since the PF has ARI capability:
>>>>>>>>>>>>=20
>>>>>>>>>>>> -device pcie-root-port,id=3Dp -device =
igb,bus=3Dp,addr=3D0x2.0x0
>>>>>>>>>>>>=20
>>>>>>>>>>>> The above should not be allowed and when used, we do not =
see the igb ethernet device from the guest OS.
>>>>>>>>>>>=20
>>>>>>>>>>> I think it's allowed because it expects you to hotplug =
function 0 later,
>>>>>>>>>>=20
>>>>>>>>>> This is about the igb device being plugged into the non-zero =
slot of the pci-root-port. The guest OS ignores it.
>>>>>>>>>=20
>>>>>>>>> yes but if you later add a device with ARI and with next field =
pointing
>>>>>>>>> slot 2 guest will suddently find both.
>>>>>>>>=20
>>>>>>>> Hmm, I tried this:
>>>>>>>>=20
>>>>>>>> -device pcie-root-port,id=3Dp \
>>>>>>>> -device igb,bus=3Dp,addr=3D0x2.0x0 \
>>>>>>>> -device igb,bus=3Dp,addr=3D0x0.0x0 \
>>>>>>>>=20
>>>>>>>> The guest only found the second igb device not the first. You =
can try too.
>>>>>>>=20
>>>>>>> Because next parameter in pcie_ari_init does not match.
>>>>>>=20
>>>>>> OK send me a command line that I can test it with. I can=E2=80=99t =
come up with a case that actually works in practice.
>>>>>=20
>>>>> I don't think there is one because the code for PCI multifunction =
does not
>>>>> care ARI. In my opinion, we need yet another check to make =
non-SR-IOV
>>>>> multifunction and ARI capability mutually exclusive; if a function =
has the
>>>>> ARI capability and it is not a VF, an attempt to assign non-zero =
function
>>>>> number for it should fail.
>> is it stated somewhere in spec(s) that ARI and !SR-IOV are mutually =
exclusive?
>>>>=20
>>>> Why is that? My understanding is that ARI capable devices should =
also
>>>> set the multifunction bit in the header. It's not terribly clear =
from
>>>> the spec though.
>>>=20
>>> Something like the following will not work properly with ARI-capable
>>> device (think of a as an ARI-capable device):
>>> -device a,addr=3D0x1.0x0,multifunction=3Don -device a,addr=3D0x1.0x1
>> (I had a crazy idea, to use it like that so we could put more devices
>> on port without resorting to adding extra bridges)
>> Can you elaborate some more why it won't work?
>=20
> It won't work because the ARI next function number field is fixed. In =
this case, the field of the Function at 0x1.0x0 should point to 0x1.0x1, =
but it doesn=E2=80=99t.

Where does it point to in this case then? 0x1.0x2 becasue of the stride?

> As the result, the Function at 0x1.0x1 won't be recognized.
>=20
> It's more problematic if some of the Functions are ARI-capable but =
others are not. In my understanding, all Functions in a ARI-capable =
device need to have ARI capability, but that's not enforced.
>=20
>>> This is because the next function numbers advertised with ARI are =
not
>>> updated with the multifunction configuration, but they are hardcoded =
in
>>> the device implementation. In this sense, the traditional =
(non-SR/IOV)
>>> multifunction mechanism QEMU has will not work with ARI-capable =
devices.
>>>=20
>>>>  =20
>>>>> But it should be a distinct check as it will need to check the =
function
>>>>> number bits.
>>>>> =20
>>>>>> =20
>>>>>>>=20
>>>>>>> =20
>>>>>>>>> =20
>>>>>>>>>>> no?
>>>>>>>>>>>=20
>>>>>>>>>>> I am quite worried about all this work going into blocking
>>>>>>>>>>> what we think is disallowed configurations. We should have
>>>>>>>>>>> maybe blocked them originally, but now that we didn't
>>>>>>>>>>> there's a non zero chance of regressions,
>>>>>>>>>>=20
>>>>>>>>>> Sigh,
>>>>>>>>>=20
>>>>>>>>> There's value in patches 1-4 I think - the last patch helped =
you find
>>>>>>>>> these. so there's value in this work.
>>>>>>>>> =20
>>>>>>>>>> no medals here for being brave :-)
>>>>>>>>>=20
>>>>>>>>> Try removing support for a 3.5mm jack next. Oh wait ...
>>>>>>>>=20
>>>>>>>> Indeed. Everyone uses bluetooth these days. I for one is happy =
that the jack is gone (and they were bold enough to do it while Samsung =
and others still carry the useless port ) :-)
>>>>>=20
>>>>> Hello from a guy using a shiny M2 Macbook Air carrying the legacy =
jack with
>>>>> a 100-yen earphone. Even people who ported Linux to this machine =
spent
>>>>> efforts to get the jack to work on Linux ;)
>>>>> =20
>>>>>>>> =20
>>>>>>>>> =20
>>>>>>>>>>> and the benefit
>>>>>>>>>>> is not guaranteed.
>>>>>>>>>>>=20
>>>>>>>>>>> --=20
>>>>>>>>>>> MST


