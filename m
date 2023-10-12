Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CBC7C642B
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:41:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqnVE-0000iS-Ry; Thu, 12 Oct 2023 00:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qqnVC-0000fC-SW
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qqnVA-0000ck-Md
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697085646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IlWm9zfcUnGSk313mGFPiaOAQx+5qDAGYydJu9tt1Fs=;
 b=BiWJwgxJ4Qqp+v1HmukVksZ6sJqwMfWENLXZlaSa8I32vZfaLjHovZZuGQH7Ehm980as5h
 byAkzh5Zq0IPtEACDW2Lv8BsuehFZs9jr2XJlpVj9Rko4ps2cc3AFHtbWwc8FvzmxWsqJK
 GDGYEk5tfpmcUE5sdLPARO6vMQ3kefg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-vYYeoQ-nNye8mRdPwiUExQ-1; Thu, 12 Oct 2023 00:40:42 -0400
X-MC-Unique: vYYeoQ-nNye8mRdPwiUExQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-58530660c1bso393489a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697085641; x=1697690441;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IlWm9zfcUnGSk313mGFPiaOAQx+5qDAGYydJu9tt1Fs=;
 b=GFFQphC0rPgZCzRXVtpeBUcuwx4XFGlW9o/e88kmao3SnSx9G6t1/sof05qMbBHIUT
 MSsc3wdkaDANONmXrD2E9s4McottbL0zGptKrqfyaXIYQ0CHowSzYBo7MNE3REHwV2Gx
 06ToquJYk43e4fyyK6YhKG/TEFjF/DGSgmdibyRHNN57f966d29epUh+N/Mku2HTmmyL
 jke0Vdwq6WyouKtvDuZW6SXtHUPnX25Im/VcCG5IMl4CwTAYDFQZM9hQfHq5c9AEG5r4
 p5PXmT99HRcK/yboGhWlgSrabGibxtkD5P1oizuxmppcyWA5gBZepCoGhJSbcM6oJQjL
 lWPw==
X-Gm-Message-State: AOJu0YyicmUsc81KEsjPDLLPXFL+dDwi1xYniurOrEr8LOYdeauDogWQ
 SSgaqUjLPwYbwdo9fvrmpbRMNwBxQO3gXesWwZMSHEX1Xah9UYXy3irOzhT2cYMK8YIuOQRR45s
 AsTLO9gtvBliSn1M=
X-Received: by 2002:a05:6a20:7291:b0:157:b453:dbb9 with SMTP id
 o17-20020a056a20729100b00157b453dbb9mr24647229pzk.6.1697085641014; 
 Wed, 11 Oct 2023 21:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYzuyQRI8R8AoMcC0EkGTkipWmjC6mB2OYhJ09Wq9KJTQidcIHLPGSEOlonc5vrpDpmx9Chw==
X-Received: by 2002:a05:6a20:7291:b0:157:b453:dbb9 with SMTP id
 o17-20020a056a20729100b00157b453dbb9mr24647215pzk.6.1697085640723; 
 Wed, 11 Oct 2023 21:40:40 -0700 (PDT)
Received: from smtpclient.apple ([202.88.220.252])
 by smtp.gmail.com with ESMTPSA id
 im16-20020a170902bb1000b001c5fed0b35esm790332plb.300.2023.10.11.21.40.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Oct 2023 21:40:40 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] hw/i386/cxl: ensure maxram is greater than ram size for
 calculating cxl range
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231011173104.000016f5@Huawei.com>
Date: Thu, 12 Oct 2023 10:10:36 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8E01874E-9B9D-41C5-9D88-29D9B4071BC6@redhat.com>
References: <20231011105335.42296-1-anisinha@redhat.com>
 <20231011173104.000016f5@Huawei.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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



> On 11-Oct-2023, at 10:01 PM, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> On Wed, 11 Oct 2023 16:23:35 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
>=20
>> pc_get_device_memory_range() finds the device memory size by =
calculating the
>> difference between maxram and ram sizes. This calculation makes sense =
only when
>> maxram is greater than the ram size. Make sure we check for that =
before calling
>> pc_get_device_memory_range().
>>=20
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>=20
> Whilst this is similar to other cases, I can't remember or quickly =
work
> out if the 'else' path here is appropriate.  Can we add something to =
the
> patch description to talk about that?
>=20
> For reference it's:
>=20
> cxl_base =3D pc_above_4g_end(pcms);

Leaving the alignment adjustments aside, the hotplugged memory devices =
are mapped starting from where the =E2=80=9Cabove_4g=E2=80=9D memory =
ends.
The cxl memory starts after the region reserved for hot plugged memory =
devices. If there is no hot plugged memory device region (maxmem =3D=3D =
mem), the cxl memory can start right after where =E2=80=9Cabove_4g=E2=80=9D=
 memory ends.
See also pc_pci_hole64_start() and pc_max_used_gpa().
I did not want to add any alignment adjustments because I was not sure =
if it would add regression and incompatibility with older machine types.=20=



>=20
>> ---
>> hw/i386/pc.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index f72e2c3b35..948c58171c 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -820,10 +820,12 @@ static void =
pc_get_device_memory_range(PCMachineState *pcms,
>> static uint64_t pc_get_cxl_range_start(PCMachineState *pcms)
>> {
>>     PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>> +    MachineState *ms =3D MACHINE(pcms);
>>     hwaddr cxl_base;
>>     ram_addr_t size;
>>=20
>> -    if (pcmc->has_reserved_memory) {
>> +    if (pcmc->has_reserved_memory &&
>> +        (ms->ram_size < ms->maxram_size)) {
>>         pc_get_device_memory_range(pcms, &cxl_base, &size);
>>         cxl_base +=3D size;
>>     } else {
>=20


