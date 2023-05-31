Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC73A717C3D
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 11:42:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ILU-0005yu-87; Wed, 31 May 2023 05:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q4ILR-0005yO-7z
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:42:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q4ILP-0001qQ-7K
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685526134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZivEnteBfONsuBRZZcGuKeR1/Oqa3UVSac4f5vWWrY=;
 b=FFps5RbhG9Az4Se7i4Fduci5Da/Ys60AM0TFRDl9yfTwtj09LArOH5511wmk7yCSBEopwr
 iJwoY10cM9qq5Dz1I2VSRugRT72EZtMdRMXZB2nLj/zkJGYTd74lBvATLNYXx//Z1jRyp4
 8BapV6x1AsCv9Fy3vVt81cPX0oRueBc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-CpYYPha2Ni61brw-q1PZUQ-1; Wed, 31 May 2023 05:42:13 -0400
X-MC-Unique: CpYYPha2Ni61brw-q1PZUQ-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6af86dd9ae9so4659549a34.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 02:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685526132; x=1688118132;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZivEnteBfONsuBRZZcGuKeR1/Oqa3UVSac4f5vWWrY=;
 b=Mc8xN43lbVwraKCCgNqvSuiuYmAS84Uv1bz992AaJaqkHinv/0tNcBndudCf2iQhEK
 IuqvqkVKiE/rxI2kajPIfLQRQrDRP9f4FH/VBrXxqpBKEP6TikrHXGkrtle5CUcROXnA
 4oqHX+A5x9eS2OeGteg9bBbgGNvX/B8nXzghc5S4gzRmrWLFUVUXG85FO3LHMErTAsst
 /uf0eiYfQyvYCxpXTqPkJHCJ/XlOfROwCaG8baz1N2eINvMB2sfd5L4SuTgntBseuNgj
 eZzAK5qAUjK7pm15MYffJspRqevBxKB84p3k7/8qoFa/5D0cMU45IglOUn2ZbjH8vH7t
 2bCQ==
X-Gm-Message-State: AC+VfDwkErnUdTXtKejUYut3q2o69E/ZWs4rJMTj/V1NfGWw/FbHVnAd
 yT4773g2b+4nMEUaUoFIKyU5sPiQCnwouwK+MiSqacYT91dkUvxEMaZjqf0fUTG55HjfLeH8dJx
 ILDIrOt9/RyKCgHXjaUAHT4g=
X-Received: by 2002:a05:6358:4303:b0:122:f227:581d with SMTP id
 r3-20020a056358430300b00122f227581dmr1795704rwc.24.1685526132275; 
 Wed, 31 May 2023 02:42:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7aaHN76EVzfuqWS0uZ6Q03hLoK1bOFg8L15vVtzoV0X3TlOHZwVYNLzdRaRM0cp3oFmZNKfw==
X-Received: by 2002:a05:6358:4303:b0:122:f227:581d with SMTP id
 r3-20020a056358430300b00122f227581dmr1795682rwc.24.1685526131985; 
 Wed, 31 May 2023 02:42:11 -0700 (PDT)
Received: from smtpclient.apple ([49.207.196.14])
 by smtp.gmail.com with ESMTPSA id
 23-20020a17090a005700b0025374fedab4sm896570pjb.22.2023.05.31.02.42.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 May 2023 02:42:11 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] hw/smbios: fix thead count field in type 4 table
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <ZHcIcaQIlnQVsmbP@liuzhao-OptiPlex-7080>
Date: Wed, 31 May 2023 15:12:07 +0530
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, maobibo@loongson.cn,
 gaosong@loongson.cn, Zhenyu Wang <zhenyu.z.wang@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C9CDE0B-29C3-4952-B547-B39A6C3DF9B0@redhat.com>
References: <20230530122034.547109-1-zhaotianrui@loongson.cn>
 <ZHcIcaQIlnQVsmbP@liuzhao-OptiPlex-7080>
To: Zhao Liu <zhao1.liu@intel.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> On 31-May-2023, at 2:12 PM, Zhao Liu <zhao1.liu@intel.com> wrote:
>=20
> On Tue, May 30, 2023 at 08:20:34PM +0800, Tianrui Zhao wrote:
>> Date: Tue, 30 May 2023 20:20:34 +0800
>> From: Tianrui Zhao <zhaotianrui@loongson.cn>
>> Subject: [PATCH] hw/smbios: fix thead count field in type 4 table
>> X-Mailer: git-send-email 2.39.1
>>=20
>> The thread_count value in smbios type_4 table should be
>> (ms->smp.cores * ms->smp.threads). As according to smbios spec 7.5
>> Processor Information (Type 4), the field "Thread Count" means the
>> "Number of threads per processor socket" rather than number of
>> threads per core.
>>=20
>> When apply this patch, use "-smp 4,sockets=3D1,cores=3D2,threads=3D2" =
to
>> boot VM, the dmidecode -t 4 shows like:
>>=20
>> Handle 0x0400, DMI type 4, 48 bytes
>> Processor Information
>>        Socket Designation: CPU 0
>>        ...
>>        Core Count: 2
>>        Core Enabled: 2
>>        Thread Count: 4
>>        Characteristics: None
>>=20
>> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
>> ---
>> hw/smbios/smbios.c | 7 ++++---
>> 1 file changed, 4 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
>> index d2007e70fb..56aeaa069d 100644
>> --- a/hw/smbios/smbios.c
>> +++ b/hw/smbios/smbios.c
>> @@ -713,6 +713,7 @@ static void =
smbios_build_type_4_table(MachineState *ms, unsigned instance)
>> {
>>     char sock_str[128];
>>     size_t tbl_len =3D SMBIOS_TYPE_4_LEN_V28;
>> +    int count;
>>=20
>>     if (smbios_ep_type =3D=3D SMBIOS_ENTRY_POINT_TYPE_64) {
>>         tbl_len =3D SMBIOS_TYPE_4_LEN_V30;
>> @@ -749,15 +750,15 @@ static void =
smbios_build_type_4_table(MachineState *ms, unsigned instance)
>>=20
>>     t->core_count =3D (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
>>     t->core_enabled =3D t->core_count;
>> -
>> -    t->thread_count =3D (ms->smp.threads > 255) ? 0xFF : =
ms->smp.threads;
>> +    count =3D ms->smp.cores * ms->smp.threads;
>=20
> Hi Ani & Tianrui,
>=20
> =46rom the comment of CpuTopology (include/hw/boards.h):
>=20
> ms->cores means the "the number of cores in one cluster".
> ms->threads means the "the number of threads in one core".
>=20
> So ms->cores * ms->threads means the number of threads in one cluster
> not one socket.

Yes ok other than arm/virt I do not see any other arch that supports =
clusters.

>=20
> That's why I count the number of threads in a socket by =
"ms->smp.max_cpus
> / ms->smp.sockets" in [1].
>=20
> The other correct way is:
> ms->smp.cluster * ms->smp.cores * ms->smp.threads.
>=20

Sure, I prefer this calculation than what you have used.


> [1]: =
https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07229.html
>=20
> Thanks,
> Zhao
>=20
>> +    t->thread_count =3D (count > 255) ? 0xFF : count;
>>=20
>>     t->processor_characteristics =3D cpu_to_le16(0x02); /* Unknown */
>>     t->processor_family2 =3D cpu_to_le16(0x01); /* Other */
>>=20
>>     if (tbl_len =3D=3D SMBIOS_TYPE_4_LEN_V30) {
>>         t->core_count2 =3D t->core_enabled2 =3D =
cpu_to_le16(ms->smp.cores);
>> -        t->thread_count2 =3D cpu_to_le16(ms->smp.threads);
>> +        t->thread_count2 =3D cpu_to_le16(count);
>>     }
>>=20
>>     SMBIOS_BUILD_TABLE_POST;
>> --=20
>> 2.39.1


