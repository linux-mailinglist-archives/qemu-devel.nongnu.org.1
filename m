Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A2473E422
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:04:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDohT-00020B-Ih; Mon, 26 Jun 2023 12:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDohR-0001sp-Jz
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDohP-000076-RX
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687795459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rio/lHTgxG5eWIkogsBHhG3sZrnHfdBrp3YkQqLAUW4=;
 b=XYkXWbkWcTSxNw2CBao8JYn6vXiHm4SRLCfxtwraA6OMHahgYusSzZv5m50mKp5sMRPA1n
 ci5YFILodClXhZKYg36sxphq4Sr4+JLVTpKJqDrXZKyqJZf+EUYBKKw6VyP1wyWBXQpSAm
 XUOArQisex9iNmEDiQ5akrYd0xYUKnU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-0YAm04LJPwqNDRtJ0LN59g-1; Mon, 26 Jun 2023 12:04:11 -0400
X-MC-Unique: 0YAm04LJPwqNDRtJ0LN59g-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-53fd224ad48so1449662a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 09:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687795443; x=1690387443;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rio/lHTgxG5eWIkogsBHhG3sZrnHfdBrp3YkQqLAUW4=;
 b=C5B4bwGgzwi+MYpsZJhzkaV2cLnUcOUj/tcdxdsFMVgqJd1lD3kjA+dGetFL7S9ihJ
 rNuHFDp0UZDxgSAKODsgGogmVTMKaWUNBhMtdHRS/MKqz1Zi9aHtSt8x74BJrxZo2JkD
 8ptznLhH3GoVDhW6293AXrmKz3nqfEaF9QVX0L3G6nL7Znp/lojx3Ldpjl4AmAcsspKj
 N1kQqm57o6N5BwqGmJYXkyPwkudLgk2N7SHbnT60HFx80zm7BxYmxOpYLMHK55XX1z3C
 pp0oMeL1izOo8lrMN+SXm1/YEfNgGX0i4tV+mf794nFqsG2HD/WlTdUz9X4Oe76m4erR
 AYhA==
X-Gm-Message-State: AC+VfDzQSdBDK411YgE97VNDIdoS+y5dHfD/rUXH07oDOM7hfD+zSg+Y
 iajD85+eOZxCF0yET+vRRyzNhz2EsFSxEzg9k9dji6fKBPp2mEbFWuu5tS4PJ+nr5o8f2udoY12
 TYFn4//02566CNKI=
X-Received: by 2002:a17:90a:f3cc:b0:262:ea30:2cb8 with SMTP id
 ha12-20020a17090af3cc00b00262ea302cb8mr2453376pjb.20.1687795443268; 
 Mon, 26 Jun 2023 09:04:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6vPxFl54EuQEj3Gs81XBP268rWDX7F8MGav8HUBzqQeTEtl6D0xSJrPVDijkA9GfGpRap4kQ==
X-Received: by 2002:a17:90a:f3cc:b0:262:ea30:2cb8 with SMTP id
 ha12-20020a17090af3cc00b00262ea302cb8mr2453363pjb.20.1687795443018; 
 Mon, 26 Jun 2023 09:04:03 -0700 (PDT)
Received: from smtpclient.apple ([115.96.139.77])
 by smtp.gmail.com with ESMTPSA id
 fs2-20020a17090af28200b0025bf330903esm5310174pjb.1.2023.06.26.09.04.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Jun 2023 09:04:02 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v4 4/5] tests/qtest/hd-geo-test: fix incorrect
 pcie-root-port usage and simplify test
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230626162246.0ba91051@imammedo.users.ipa.redhat.com>
Date: Mon, 26 Jun 2023 21:33:56 +0530
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Labiuk <michael.labiuk@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D730B89-EA1C-4799-85FA-C8EBC831D61B@redhat.com>
References: <20230626135324.10687-1-anisinha@redhat.com>
 <20230626135324.10687-5-anisinha@redhat.com>
 <20230626162246.0ba91051@imammedo.users.ipa.redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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



> On 26-Jun-2023, at 7:52 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> On Mon, 26 Jun 2023 19:23:23 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
>=20
>> The test attaches both a SCSI controller and a pcie-to-pci bridge on =
the same
>> pcie-root-port on slot 0.
> statement is right only for bridge, while it's still incorrect for =
storage part
> (see add_scsi_controller/add_virtio_disk)
> they try to use slot !0

Grr! Sorry about this, not sure what I was thinking.
Juggling too many things.

Patchset V5 sent.

>=20
>> This is incorrect since a single downstream device
>> can be attached to a non-multifunction pcie-root-port on slot 0.
>=20
>> Additionally
>> using pcie.0 as id for pcie-root-port is incorrect as that id is =
reserved
>> only for the root bus.
> ack on this part
>=20
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


