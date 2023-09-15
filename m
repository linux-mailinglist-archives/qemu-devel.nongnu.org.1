Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1E47A1C77
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 12:39:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh6DU-0001PX-3c; Fri, 15 Sep 2023 06:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qh6DJ-0001Nw-OA
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 06:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qh6DI-0005hQ-4f
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 06:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694774295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZf8qjs/33wAfWFtPRMDYm2sjrMVUjx9dGgTPFf6tOY=;
 b=GMFv4wvRUd/XeCnMpcGnVSA3HM9gmkThpGWYmn/C2rxFlCmRvQzE1fzkzmRNX8CVuJFgrF
 Mg4wFuoYFplOeOe3roTUtkN05o3ZpGlhDvALodVv1OXoHNJPofjebU3peVuE/7ovq6UrQ8
 iJaOpYyVtbVixGmXbggtm0FF8Vl+H2w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-F49rcPojPkak_q4aiYw2Aw-1; Fri, 15 Sep 2023 06:38:13 -0400
X-MC-Unique: F49rcPojPkak_q4aiYw2Aw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-26d50941f68so1826834a91.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 03:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694774293; x=1695379093;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZf8qjs/33wAfWFtPRMDYm2sjrMVUjx9dGgTPFf6tOY=;
 b=JH9G7CARGpzforbI41PlulHivlJPhfJteHIxL+evVPU8HTBe8okeP8ZCJIjWkr3+K8
 nJVFq341PF6p5QFso4lK23ziYRZhjzrT/gtzmOArl7SnS10i584hrRHfJvqNo2Wnneiu
 47qBQrhRRFTpv+5FNs01WvWjsnGx7WXZ4rB7xaeb78R/UNLroVFD6zoU7aBvGXWPT7ik
 aShr+/Kx04EAWPug2JwIwmyKmFgLWrp5Br8hMj8hgHxvhmqNtZxCoQmSkKdESdSCtaAh
 Wn7fPnlxzFw3HZ+qIjDabjVXacgbmRqh4OnIxrvHT0LEDswbt4Fypz0Y/Kd/xp0cy/lY
 Kccw==
X-Gm-Message-State: AOJu0YzTTwxHOuFVZRYKkQy0hg8sP4OxU0PZmHFTjFvR9aP08HKKJZc+
 L9nDPLug8iOyg5/X59hpez2tGLsZjQxyjWPD0m+ZC46cuM6z8rkHRqyLfEXx7pCxe8C4O7hgXJo
 4XUwahP7o/8zbs1A=
X-Received: by 2002:a17:90a:fa0c:b0:26b:c3f:1503 with SMTP id
 cm12-20020a17090afa0c00b0026b0c3f1503mr1122175pjb.17.1694774292791; 
 Fri, 15 Sep 2023 03:38:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHep9P30+Z1leTEiAfJd0KQ5Mdefv3MDQnneK8wwvFOy7Hl2eunJVNPsU2dK70YX6olxitCug==
X-Received: by 2002:a17:90a:fa0c:b0:26b:c3f:1503 with SMTP id
 cm12-20020a17090afa0c00b0026b0c3f1503mr1122162pjb.17.1694774292467; 
 Fri, 15 Sep 2023 03:38:12 -0700 (PDT)
Received: from smtpclient.apple ([115.96.206.7])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a17090a31c300b002639c4f81cesm5021454pjf.3.2023.09.15.03.38.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Sep 2023 03:38:11 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] mem/x86: add processor address space check for VM memory
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <e052a3c4-33e9-1d75-dc9b-3c64f8ae777b@redhat.com>
Date: Fri, 15 Sep 2023 16:08:06 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <41A3B19D-87B7-4FD6-A5C7-17D758B2DB37@redhat.com>
References: <20230908095024.270946-1-anisinha@redhat.com>
 <77284898-c540-31ac-d438-ebff52f6d75d@redhat.com>
 <1911B17C-24F2-406B-9ED4-DCF98E794A09@redhat.com>
 <730648ed-55ac-aa2c-58d2-d79224aeb586@redhat.com>
 <1574DF3A-7E1F-4C4F-9087-6E8DEE456906@redhat.com>
 <6cbca7b9-381b-6268-27f0-d7ea1c5ed1bd@redhat.com>
 <3A287C52-F547-4494-B803-8CFC50CBA175@redhat.com>
 <30f0ddfb-6eb7-84a5-04a0-e11905451733@redhat.com>
 <A354B36D-A86E-48D9-B8B6-DC35D8976410@redhat.com>
 <34403090-b4b3-990f-7723-1d56d8053bd5@redhat.com>
 <08530A80-90F3-4E33-9B1A-E71A66726123@redhat.com>
 <e052a3c4-33e9-1d75-dc9b-3c64f8ae777b@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 14-Sep-2023, at 5:19 PM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
>>>>> We requested a to hotplug a maximum of "8 GiB", and sized the area =
slightly larger to allow for some flexibility
>>>>> when it comes to placing DIMMs in that "device-memory" area.
>>>> Right but here in this example you do not hot plug memory while the =
VM is running. We can hot plug 8G yes, but the memory may not physically =
exist yet (and may never exist). How can we use this math to provision =
device-memory when the memory may not exist physically?
>>>=20
>>> We simply reserve a region in GPA space where we can coldplug and =
hotplug a
>>> predefined maximum amount of memory we can hotplug.
>>>=20
>>> What do you think is wrong with that?
>> The only issue I have is that even though we are accounting for it, =
the memory actually might not be physically present.
>=20
> Not sure if "accounting" is the right word; the memory is not present =
and nowhere indicated as present. It's just a reservation of GPA space, =
like the PCI hole is as well.
>=20
> [...]
>=20
>>>=20
>>> Yes. In this case ms->ram_size =3D=3D ms->maxram_size and you cannot =
cold/hotplug any memory devices.
>>>=20
>>> See how pc_memory_init() doesn't call machine_memory_devices_init() =
in that case.
>>>=20
>>> That's what the QEMU user asked for when *not* specifying maxmem =
(e.g., -m 4g).
>>>=20
>>> In order to cold/hotplug any memory devices, you have to tell QEMU =
ahead of time how much memory
>>> you are intending to provide using memory devices (DIMM, NVDIMM, =
virtio-pmem, virtio-mem).
>> So that means that when we are actually hot plugging the memory, =
there is no need to actually perform additional checks. It can be done =
statically when -mem and -maxmem etc are provided in the command line.
>=20
> What memory device code does, is find a free location inside the =
reserved GPA space for memory devices. Then, it maps that device at
> that location.

Yes I see the function memory_device_get_free_addr() that does all the =
range checks and validations and this gets called from the pre_plug() =
handler.=20

>=20
> [...]
>=20
>>> /*
>>> * The 64bit pci hole starts after "above 4G RAM" and
>>> * potentially the space reserved for memory hotplug.
>>> */
>>>=20
>>> There is the
>>> 	ROUND_UP(hole64_start, 1 * GiB);
>>> in there that is not really required for the !hole64 case. It
>>> shouldn't matter much in practice I think (besides an aligned value
>>> showing up in the error message).
>>>=20
>>> We could factor out most of that calculation into a
>>> separate function, skipping that alignment to make that
>>> clearer.
>> Yeah this whole memory segmentation is quite complicated and might =
benefit from a qemu doc or a refactoring.
>=20
> Absolutely. Do you have time to work on that (including the updated =
fix?).

Other than the fix you proposed I am not sure if we need to fix anything =
else atm. Seems physical address space bound checks are already in =
place.
Re: doc, maybe. I will add it to my TODO list.

>=20
> --=20
> Cheers,
>=20
> David / dhildenb


