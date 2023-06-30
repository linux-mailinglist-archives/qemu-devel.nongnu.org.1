Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EFC743D10
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:57:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFEbh-00028c-7H; Fri, 30 Jun 2023 09:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qFEbd-0001us-0A
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:56:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qFEba-0002n4-Ns
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688133369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SQnEg0B5b4xEQqx++ez74WA7NlHRHlcM2CeZ6/JH0lA=;
 b=fUNCnImInnySD9XemVpUEztnzuJq361NPzf0fOqxjvUYKg8VMKkC4kDsqpKrBSByL6Lak0
 6JrhSskurcyJ90VISQUyeS3mmNQp7jHgvg+a/xqQ5oZiREaqEh840nI00IztSBW82Sp/JH
 UlsDnn33+W3cZpXEhmNNgDvx7hX/23k=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-zfk57BycN7WSXPMxwZyDOQ-1; Fri, 30 Jun 2023 09:56:08 -0400
X-MC-Unique: zfk57BycN7WSXPMxwZyDOQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6686e4499b1so1413467b3a.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688133367; x=1690725367;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SQnEg0B5b4xEQqx++ez74WA7NlHRHlcM2CeZ6/JH0lA=;
 b=ZoL9VDywb06ZsxSz2kb+aYAYGpwrn8kuwDqsu88PFbFhIeicyeFjxA5lKY6fiWZJWT
 wXdrJlaMSxFyuf6pCHY+Ap/NJBlC4mHZBIn0+cZyhmuClxk+dKSHu9rnLv7QqvseydkG
 34mmV52K/7UoaVfZia3aaUA67iIeIeGEzExmZMOMgl10w4kZCzGiTu0VwVrN/Ug4xbs9
 Ka5POvRXJIXs/QmuKgp4Z12AbRGOfW2fU+H7N4A/HMuGsAFs7tk0+APkKXZ5wfBP8lUx
 s8ZTqDkKzuRXvT+xvuGPN4OEBarog2WLSGkb9yZeKj44Diae9tCMJcTnIvMfKUU+CNno
 GbqA==
X-Gm-Message-State: ABy/qLahTiMSMu/R9Z+KxhcrLRnHVCS/3TepCg0akNrFZD89PU4wt7HA
 wcsF32Gb2AGuN8//z2L9MJRsXmOE5HK8mijwg2+biqpw+xWtHk17Amqy9ZFXhr2WVFg+akrkvSI
 /3fPVoM1kHWCpjkI=
X-Received: by 2002:a05:6a00:1501:b0:668:9bf9:fa70 with SMTP id
 q1-20020a056a00150100b006689bf9fa70mr2515304pfu.34.1688133367068; 
 Fri, 30 Jun 2023 06:56:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrcz1puPXXAzFEc27VfpH7+9gwxZK2X+J6AEvnLp5xM88fYCONt8/bLY8WCKR6P3GL1+NlRw==
X-Received: by 2002:a05:6a00:1501:b0:668:9bf9:fa70 with SMTP id
 q1-20020a056a00150100b006689bf9fa70mr2515279pfu.34.1688133366708; 
 Fri, 30 Jun 2023 06:56:06 -0700 (PDT)
Received: from smtpclient.apple ([115.96.128.249])
 by smtp.gmail.com with ESMTPSA id
 m12-20020aa78a0c000000b00679d3fb2f92sm7338691pfa.154.2023.06.30.06.56.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Jun 2023 06:56:06 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <bf351f8b-1c8a-8a7a-7f44-17c9ba18f179@daynix.com>
Date: Fri, 30 Jun 2023 19:26:01 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DFB3B0B7-1F61-4779-9833-2AF1BA3BDFA6@redhat.com>
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
 <bf351f8b-1c8a-8a7a-7f44-17c9ba18f179@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
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



> On 30-Jun-2023, at 5:25 PM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> On 2023/06/30 20:36, Akihiko Odaki wrote:
>> On 2023/06/30 19:37, Ani Sinha wrote:
>>>=20
>>>=20
>>>> On 30-Jun-2023, at 3:30 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>=20
>>>> On Fri, Jun 30, 2023 at 02:52:52PM +0530, Ani Sinha wrote:
>>>>>=20
>>>>>=20
>>>>>> On 30-Jun-2023, at 2:13 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>>>=20
>>>>>> On Fri, Jun 30, 2023 at 02:06:59PM +0530, Ani Sinha wrote:
>>>>>>>=20
>>>>>>>=20
>>>>>>>> On 30-Jun-2023, at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>>>>>=20
>>>>>>>> On Fri, Jun 30, 2023 at 01:11:33PM +0530, Ani Sinha wrote:
>>>>>>>>>>=20
>>>>>>>>>> Thus the check for unoccupied function 0 needs to use =
pci_is_vf() instead of checking ARI capability, and that can happen in =
do_pci_register_device().
>>>>>>>>>>=20
>>>>>>>>>>> Also where do you propose we move the check?
>>>>>>>>>>=20
>>>>>>>>>> In pci_qdev_realize(), somewhere after pc->realize() and =
before option ROM loading.
>>>>>>>>>=20
>>>>>>>>> Hmm, I tried this. The issue here is something like this would =
be now allowed since the PF has ARI capability:
>>>>>>>>>=20
>>>>>>>>> -device pcie-root-port,id=3Dp -device igb,bus=3Dp,addr=3D0x2.0x0=

>>>>>>>>>=20
>>>>>>>>> The above should not be allowed and when used, we do not see =
the igb ethernet device from the guest OS.
>>>>>>>>=20
>>>>>>>> I think it's allowed because it expects you to hotplug function =
0 later,
>>>>>>>=20
>>>>>>> This is about the igb device being plugged into the non-zero =
slot of the pci-root-port. The guest OS ignores it.
>>>>>>=20
>>>>>> yes but if you later add a device with ARI and with next field =
pointing
>>>>>> slot 2 guest will suddently find both.
>>>>>=20
>>>>> Hmm, I tried this:
>>>>>=20
>>>>> -device pcie-root-port,id=3Dp \
>>>>> -device igb,bus=3Dp,addr=3D0x2.0x0 \
>>>>> -device igb,bus=3Dp,addr=3D0x0.0x0 \
>>>>>=20
>>>>> The guest only found the second igb device not the first. You can =
try too.
>>>>=20
>>>> Because next parameter in pcie_ari_init does not match.
>>>=20
>>> OK send me a command line that I can test it with. I can=E2=80=99t =
come up with a case that actually works in practice.
>> I don't think there is one because the code for PCI multifunction =
does not care ARI. In my opinion, we need yet another check to make =
non-SR-IOV multifunction and ARI capability mutually exclusive; if a =
function has the ARI capability and it is not a VF, an attempt to assign =
non-zero function number for it should fail.
>=20
> No, the more straightforward way to fix this problem is to check the =
device function number is less than the next function number advertised =
with ARI.
>=20

Personally I would leave the check for ARI capable devices to someone =
else. I am ok with moving the check to pci_qdev_realize() and I verified =
that both unit tests and the breaking test case for BZ 2128929 is =
caught. I have also verified that the change does not break igb vf =
generation.=20
If there is any interest to push this change, I will spin a new version =
with tags for test fixes added and the rework for this patch with the =
check moved to the new location as you had suggested.


>> But it should be a distinct check as it will need to check the =
function number bits.


