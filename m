Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD19A743838
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 11:23:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFALL-0000HI-L5; Fri, 30 Jun 2023 05:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qFALH-0000G3-55
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qFALF-0006Wb-4f
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688116979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=exv0le3cmuxNNRJQKrP6yV10sPvtWy6rwCWtA2HL3Ww=;
 b=fGYN2LS7NgJXPFyZ1DPh7FdXcv5oIdYLYAPUPqPbBlR783isSALl5s0xWwpjqA5SouKU0d
 8xAswhQXsYDlR3O6JAnTbPPGo9oIT81E5Tx/cyJ7agmF5YPOR6k0QZcl9hCGb6rAyV4a6q
 KqpWVnkapHld9nzHZU8Z6/DEj7nw5Hk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-UANW4ZT_P-GD1ug9ifa8vg-1; Fri, 30 Jun 2023 05:22:58 -0400
X-MC-Unique: UANW4ZT_P-GD1ug9ifa8vg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-262c488c1d3so1106840a91.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 02:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688116977; x=1690708977;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=exv0le3cmuxNNRJQKrP6yV10sPvtWy6rwCWtA2HL3Ww=;
 b=DuqXNVX29fS2DzlwLuw9jD+l6IqSIzwooLWNBJTKdC+Y1l8/hTrb10zHIuF59eI1h+
 apRZEpR5s5BOt24lXDyoVkWhH3+VKaYTJItNXyGNgS+6llIWVOscWuUAxJ68AkpeB3qy
 p9oKlyVUz6BMTAqnAzCJ1EolaTHA1vSvwUNXQIbLDU+oIJaro3pH3DqMO7IUQ6spL6WD
 ugQdGCfbEYMLU1FhlJJJV/o3EXVY/+z1WLGi/WBygy//TT+Fya9l6NR4tBY/vJrRT0wU
 gVQY43BDEERgALUF5rU5mbs9m6stnB5kGGQb6F6rBgXOq513ypNYQoQLkEnBSdT0jVUV
 LQ6w==
X-Gm-Message-State: ABy/qLacUhgcVmNpw1YWLiBstIcgP7rEHelKgEUFtyzRa5yOYljj30tZ
 c/tkqkoFUcWuXyNWDxO5Y5D0whQCaIyy92Ep1Rj+cVd61XGcxSIwlnGrvr9czlFQ5PuBiejMpqj
 vkzW6FsocGSy0F4A=
X-Received: by 2002:a17:90a:1a13:b0:263:53be:5120 with SMTP id
 19-20020a17090a1a1300b0026353be5120mr1344463pjk.36.1688116977289; 
 Fri, 30 Jun 2023 02:22:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlES1n3UjSmU64uvFYYUmwzOc0xmqqsxcHi8m8dSmTXYmn2lAVD/Y8bBu5lst9notmdSAVUD6g==
X-Received: by 2002:a17:90a:1a13:b0:263:53be:5120 with SMTP id
 19-20020a17090a1a1300b0026353be5120mr1344453pjk.36.1688116976982; 
 Fri, 30 Jun 2023 02:22:56 -0700 (PDT)
Received: from smtpclient.apple ([115.96.128.249])
 by smtp.gmail.com with ESMTPSA id
 14-20020a17090a098e00b0025c2c398d33sm5545415pjo.39.2023.06.30.02.22.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Jun 2023 02:22:56 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230630043734-mutt-send-email-mst@kernel.org>
Date: Fri, 30 Jun 2023 14:52:52 +0530
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-6-anisinha@redhat.com>
 <8d382e8b-088b-f0af-eec4-a85ee513b4ae@daynix.com>
 <CAK3XEhNOJkm13+vxJO9-Adhwq8NJ3TQ1gaOXj8Dn3NtixF_=jQ@mail.gmail.com>
 <8868044c-f61b-7bbb-8cc8-34a14c1490d6@daynix.com>
 <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
 <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
 <A50CA177-0E7E-4828-A036-70EB532FE2B8@redhat.com>
 <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
 <20230630043734-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 30-Jun-2023, at 2:13 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Fri, Jun 30, 2023 at 02:06:59PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 30-Jun-2023, at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>=20
>>> On Fri, Jun 30, 2023 at 01:11:33PM +0530, Ani Sinha wrote:
>>>>>=20
>>>>> Thus the check for unoccupied function 0 needs to use pci_is_vf() =
instead of checking ARI capability, and that can happen in =
do_pci_register_device().
>>>>>=20
>>>>>> Also where do you propose we move the check?
>>>>>=20
>>>>> In pci_qdev_realize(), somewhere after pc->realize() and before =
option ROM loading.
>>>>=20
>>>> Hmm, I tried this. The issue here is something like this would be =
now allowed since the PF has ARI capability:
>>>>=20
>>>> -device pcie-root-port,id=3Dp -device igb,bus=3Dp,addr=3D0x2.0x0
>>>>=20
>>>> The above should not be allowed and when used, we do not see the =
igb ethernet device from the guest OS.
>>>=20
>>> I think it's allowed because it expects you to hotplug function 0 =
later,
>>=20
>> This is about the igb device being plugged into the non-zero slot of =
the pci-root-port. The guest OS ignores it.
>=20
> yes but if you later add a device with ARI and with next field =
pointing
> slot 2 guest will suddently find both.

Hmm, I tried this:

-device pcie-root-port,id=3Dp \
-device igb,bus=3Dp,addr=3D0x2.0x0 \
-device igb,bus=3Dp,addr=3D0x0.0x0 \

The guest only found the second igb device not the first. You can try =
too.

>=20
>>> no?
>>>=20
>>> I am quite worried about all this work going into blocking
>>> what we think is disallowed configurations. We should have
>>> maybe blocked them originally, but now that we didn't
>>> there's a non zero chance of regressions,
>>=20
>> Sigh,
>=20
> There's value in patches 1-4 I think - the last patch helped you find
> these. so there's value in this work.
>=20
>> no medals here for being brave :-)
>=20
> Try removing support for a 3.5mm jack next. Oh wait ...

Indeed. Everyone uses bluetooth these days. I for one is happy that the =
jack is gone (and they were bold enough to do it while Samsung and =
others still carry the useless port ) :-)
=20
>=20
>>> and the benefit
>>> is not guaranteed.
>>>=20
>>> --=20
>>> MST


