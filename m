Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF787AE543
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 07:54:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql11K-0005go-R3; Tue, 26 Sep 2023 01:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1ql11I-0005gR-Po
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1ql11H-0008Bp-8z
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695707642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZlmV3hTeoWtTcZ5hLbGgRysoCnFbjgkCMMAm8jRDGHE=;
 b=giYUELV0bl6a8+vPrN51tQ7HITzYhnN32jGyJH3ZWNuxj/Kb+lbgsF6FCXNZqwW0AAQqXE
 Q4pAmY4sDmZys13sBifYKvGGI84RLMC4vf/tSJjY7XXoMn9hQjNOkzn4qjiM/cWLUTLOsx
 yk9tfFyQe/sSRn3fluO7GC24rWvVdPo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-5WHPsb1cO26ygWwC2XxfRw-1; Tue, 26 Sep 2023 01:54:00 -0400
X-MC-Unique: 5WHPsb1cO26ygWwC2XxfRw-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5703f4f8acdso7336931a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 22:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695707639; x=1696312439;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZlmV3hTeoWtTcZ5hLbGgRysoCnFbjgkCMMAm8jRDGHE=;
 b=mBPOhpQy1hzJDXe1s2/dGFcaVhDTQsImRjLavJaBSfxdsL3sw1xT8nfXQgUL8nV/s2
 2dct9w9NxPVpA+LciGS2d1sr6WshvlUbdygoAC+Rds9mkbYNRpqVXP82Da91uxZ2EFpq
 GogztPhzexFAevWCNFrKQoWweAvogNAoRqq0Z22PZhdz8jmkUeTfGilpJB5+QRix8sl9
 Z49m+oQ2ASPqR1P7+YQJTv7+AmFFvngaBNrnknULrl/KGBhJaVO610CeL11sd006Ur5j
 kh25HSZWDrFZOZ3Qtu2lHs3TDxUKTiqnYxRDMvz6y+s43pLzsOdNXYf0vT+sTU/R1ThL
 /wUg==
X-Gm-Message-State: AOJu0Ywxl4liPeVCpPCJ1ERkrdJVdxgt2IGznVl7qofYUXZJLdS19XhL
 Z1OGELMHhaIhVhWxykDnG2jGiNedE2xf5ETZKXgsMnKt+ZgeRD/az2KqIQBG5ARZDuOiDaNgOaR
 jOfIJJ+M8wlZcr3I=
X-Received: by 2002:a05:6a21:6d8a:b0:13a:e955:d958 with SMTP id
 wl10-20020a056a216d8a00b0013ae955d958mr7552628pzb.7.1695707639424; 
 Mon, 25 Sep 2023 22:53:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKaJKx9DDw6ddNQvn8SvUb9/yuFuUtrg0D9HKQtE20K75pIOqk9EwvUOPFh8ThL0XNJMquog==
X-Received: by 2002:a05:6a21:6d8a:b0:13a:e955:d958 with SMTP id
 wl10-20020a056a216d8a00b0013ae955d958mr7552614pzb.7.1695707639122; 
 Mon, 25 Sep 2023 22:53:59 -0700 (PDT)
Received: from smtpclient.apple ([115.96.197.4])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a170902c38400b001b016313b1dsm6230542plg.86.2023.09.25.22.53.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Sep 2023 22:53:58 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] hw/i386: changes towards enabling -Wshadow=local
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <ZRGjTzPqGZHTtNkg@x1n>
Date: Tue, 26 Sep 2023 11:23:53 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E868C6B-4360-4E68-B951-80180AB073FE@redhat.com>
References: <20230923023334.41537-1-anisinha@redhat.com> <ZRGjTzPqGZHTtNkg@x1n>
To: Peter Xu <peterx@redhat.com>
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



> On 25-Sep-2023, at 8:42 PM, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Sat, Sep 23, 2023 at 08:03:34AM +0530, Ani Sinha wrote:
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index c0ce896668..c1fb69170f 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -3770,9 +3770,9 @@ static void =
vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>>     while (remain >=3D VTD_PAGE_SIZE) {
>>         IOMMUTLBEvent event;
>>         uint64_t mask =3D dma_aligned_pow2_mask(start, end, =
s->aw_bits);
>> -        uint64_t size =3D mask + 1;
>> +        uint64_t sz =3D mask + 1;
>>=20
>> -        assert(size);
>> +        assert(sz);
>>=20
>>         event.type =3D IOMMU_NOTIFIER_UNMAP;
>>         event.entry.iova =3D start;
>> @@ -3784,8 +3784,8 @@ static void =
vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>>=20
>>         memory_region_notify_iommu_one(n, &event);
>>=20
>> -        start +=3D size;
>> -        remain -=3D size;
>> +        start +=3D sz;
>> +        remain -=3D sz;
>>     }
>>=20
>>     assert(!remain);
>=20
> Ani,
>=20
> I've got a small patch for this hunk already:
>=20
> https://lore.kernel.org/r/20230922160410.138786-1-peterx@redhat.com
>=20
> Wouldn't hurt to merge both, though.. or just drop the other one.

I liked your change so kept it and removed mine. See v2.

>=20
> Reviewed-by: Peter Xu <peterx@redhat.com>
>=20
> Thanks,
>=20
> --=20
> Peter Xu
>=20


