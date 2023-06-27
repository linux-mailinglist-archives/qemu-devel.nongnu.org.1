Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE73273F8B3
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:27:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4xu-0002oj-6H; Tue, 27 Jun 2023 05:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qE4xr-0002oa-4A
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qE4xp-0006I9-Gr
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687857980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JxhksgNjHxuJ2umdc9d+2gCLvVrLqERyfz6HkahDq2U=;
 b=SGWqQf8CmSruD09kjvLCvWu+3Gg+ihPaDW5+rGkBEIvanM4My2RItg14Eq+14Gny8m2QLx
 kFo9+o/IKjybMBEeP5T2K+Q19Scyp8OO3WCwKyVulrTCxHqikV6CAqRId8sKATo/lv6mfp
 LRCbIxtsoh0f1gkApQpBfuKq77lyIas=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-1m5CeEbNPaqxXr2RG5K3Pg-1; Tue, 27 Jun 2023 05:26:18 -0400
X-MC-Unique: 1m5CeEbNPaqxXr2RG5K3Pg-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1b7ef04ddfeso13023655ad.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687857978; x=1690449978;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JxhksgNjHxuJ2umdc9d+2gCLvVrLqERyfz6HkahDq2U=;
 b=kl0tZM0Adc/CRHwVt0p/6xQzBKorhWCHoJokGHECRk2aRmhHJXeR08v8XkKW5mhoIx
 WX1wh9YVzJXDAyrJ67pJQo4PdtVyNrzKeqItGN06FbYguHCiNq2KHHxt7uuEssOETLHn
 2fhG4DZaHsc4IZngo0R2VHATH13y1rF7onxuCmXv0p8WWA2KXWEfQmWGDTfKeQphGQ7w
 yRy+JeVZCKt5C+MasRCeX8sFEEkbzueRpn7Vd7T+w9MGOOrzLmczAobextkG2FzwTqTD
 vr1SqKGxeISAlppBM2yiTjT0LhaK0uxbm+3aQyr7GqHdxFslvq/VN12Ts522o6JP0naE
 H18w==
X-Gm-Message-State: AC+VfDzZnpdxAg314Friz7krap4k27OORu/6m6pICyYW5CVbJlui2qRf
 XKoA7xNEN70kN/ardyFnECqi79VHsP+8IXRt6/Etg3niTjySyQCj2PRGfeNb+7FU3li3kv7Woe9
 3L6gOE2UWolHVfPM=
X-Received: by 2002:a17:902:e5c3:b0:1b6:bced:1dd6 with SMTP id
 u3-20020a170902e5c300b001b6bced1dd6mr7420269plf.35.1687857977714; 
 Tue, 27 Jun 2023 02:26:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7blYXwux/twIDoK1746G8HMMtx0puakFyCuLD16iEN5cyAP0W4Ey7+fKwQAqhWtAHLrhmA/A==
X-Received: by 2002:a17:902:e5c3:b0:1b6:bced:1dd6 with SMTP id
 u3-20020a170902e5c300b001b6bced1dd6mr7420254plf.35.1687857977388; 
 Tue, 27 Jun 2023 02:26:17 -0700 (PDT)
Received: from smtpclient.apple ([116.73.132.30])
 by smtp.gmail.com with ESMTPSA id
 bj8-20020a170902850800b001b7fa81b145sm3864459plb.265.2023.06.27.02.26.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Jun 2023 02:26:17 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [RESEND PATCH v5 4/5] tests/qtest/hd-geo-test: fix incorrect
 pcie-root-port usage and simplify test
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230627105413.125f3da7@imammedo.users.ipa.redhat.com>
Date: Tue, 27 Jun 2023 14:56:12 +0530
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Labiuk <michael.labiuk@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <37CEFE5A-4254-4B52-B798-FD9981F7E8F4@redhat.com>
References: <20230626161244.4145-1-anisinha@redhat.com>
 <20230626161244.4145-5-anisinha@redhat.com>
 <20230627105413.125f3da7@imammedo.users.ipa.redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
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



> On 27-Jun-2023, at 2:24 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> On Mon, 26 Jun 2023 21:42:43 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
>=20
>> The test attaches a SCSI controller to a non-zero slot and a =
pcie-to-pci bridge
>> on slot 0 on the same pcie-root-port. Since a downstream device can =
be attached
>> to a pcie-root-port only on slot 0, the above test configuration is =
not allowed.
>=20
>> Additionally using pcie.0 as id for pcie-root-port is incorrect as =
that id is
>                                      ^^^^ shouldn't it be pcie-to-pci =
?

Yes you are right. Pcie-root-port is =E2=80=9Cbr=E2=80=9D in the test. =
Its so confusing!

>> reserved only for the root bus.
>=20
>>=20
>> In the test scenario, there is no need to attach a pcie-root-port to =
the
>> root complex. A SCSI controller can be attached to a pcie-to-pci =
bridge
>> which can then be directly attached to the root bus (pcie.0).
>>=20
>> Fix the test and simplify it.
>>=20
>> CC: mst@redhat.com
>> CC: imammedo@redhat.com
>> CC: Michael Labiuk <michael.labiuk@virtuozzo.com>
>>=20
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> tests/qtest/hd-geo-test.c | 18 ++++++++----------
>> 1 file changed, 8 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
>> index 5aa258a2b3..d08bffad91 100644
>> --- a/tests/qtest/hd-geo-test.c
>> +++ b/tests/qtest/hd-geo-test.c
>> @@ -784,14 +784,12 @@ static void test_override_scsi(void)
>>     test_override(args, "pc", expected);
>> }
>>=20
>> -static void setup_pci_bridge(TestArgs *args, const char *id, const =
char *rootid)
>> +static void setup_pci_bridge(TestArgs *args, const char *id)
>> {
>>=20
>> -    char *root, *br;
>> -    root =3D g_strdup_printf("-device pcie-root-port,id=3D%s", =
rootid);
>> -    br =3D g_strdup_printf("-device pcie-pci-bridge,bus=3D%s,id=3D%s",=
 rootid, id);
>> +    char *br;
>> +    br =3D g_strdup_printf("-device =
pcie-pci-bridge,bus=3Dpcie.0,id=3D%s", id);
>>=20
>> -    args->argc =3D append_arg(args->argc, args->argv, ARGV_SIZE, =
root);
>>     args->argc =3D append_arg(args->argc, args->argv, ARGV_SIZE, br);
>> }
>>=20
>> @@ -811,8 +809,8 @@ static void test_override_scsi_q35(void)
>>     add_drive_with_mbr(args, empty_mbr, 1);
>>     add_drive_with_mbr(args, empty_mbr, 1);
>>     add_drive_with_mbr(args, empty_mbr, 1);
>> -    setup_pci_bridge(args, "pcie.0", "br");
>> -    add_scsi_controller(args, "lsi53c895a", "br", 3);
>> +    setup_pci_bridge(args, "pcie-pci-br");
>> +    add_scsi_controller(args, "lsi53c895a", "pcie-pci-br", 3);
>>     add_scsi_disk(args, 0, 0, 0, 0, 0, 10000, 120, 30);
>>     add_scsi_disk(args, 1, 0, 0, 1, 0, 9000, 120, 30);
>>     add_scsi_disk(args, 2, 0, 0, 2, 0, 1, 0, 0);
>> @@ -868,9 +866,9 @@ static void test_override_virtio_blk_q35(void)
>>     };
>>     add_drive_with_mbr(args, empty_mbr, 1);
>>     add_drive_with_mbr(args, empty_mbr, 1);
>> -    setup_pci_bridge(args, "pcie.0", "br");
>> -    add_virtio_disk(args, 0, "br", 3, 10000, 120, 30);
>> -    add_virtio_disk(args, 1, "br", 4, 9000, 120, 30);
>> +    setup_pci_bridge(args, "pcie-pci-br");
>> +    add_virtio_disk(args, 0, "pcie-pci-br", 3, 10000, 120, 30);
>> +    add_virtio_disk(args, 1, "pcie-pci-br", 4, 9000, 120, 30);
>>     test_override(args, "q35", expected);
>> }
>>=20
>=20


