Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6795973DD96
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:32:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkRw-0008GB-FS; Mon, 26 Jun 2023 07:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDkRX-0008BO-QR
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDkRW-0006KT-3o
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687779097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pPS8iR5Ae2WoIMGpyRN+RfBUm0Wj/BxQfnN2bY00loo=;
 b=cD7e5zI4ifzXh1574a65+Z6OUjABpSuGyBDPZ2jPkp0NuZAe/vFAigEEXfVIe3LdV7MgqY
 rZ6CNJGHMuBnXCeo7awz2yX2thf1GLhiwrXJt/aLpcwIwJwjUvcHsjj+nYMMWCpApUG0WF
 5BReLYPr+B024zjkRXh27gDacPrUYjI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-ELMfzTy7NCylFfUF30bEDw-1; Mon, 26 Jun 2023 07:31:35 -0400
X-MC-Unique: ELMfzTy7NCylFfUF30bEDw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-668728bb904so2775577b3a.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687779094; x=1690371094;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pPS8iR5Ae2WoIMGpyRN+RfBUm0Wj/BxQfnN2bY00loo=;
 b=PPzNN5w7y70f0vh49xV3k4UBFIf/gyeV4fntp1JvFVauRHnqA4ZWtggqnVXT+o4uIF
 uAk+6VihddgZsC34DnLu2gI1kJRztq4c6dUcTWXb3BzuGgFL0MyFq8k+M7fc/zMXdO/i
 FqN0dEJhdjoLvs8n15sEtz7oY4eCrS4cFNg1uj6SdZSGUoMRlHQBJE0lJeFRcP0N2NLc
 yJBpvO8BkUhx/b17FNf1zzXy/QBzV2PQf1ZGx6IrNDT8mh9LNh954FcLWClv/orgnPNH
 ykVNbGwXqzwGipstNDSQd+DNQVTiBVsyNB902nHzogtxzo2F7KWOZgez3GJKtZ1qIbfu
 aVPQ==
X-Gm-Message-State: AC+VfDwPuDqXUpgCIj5MamLKwx2M1qycxFpau9YVTjPAu6qIKKxAXxJs
 e69FVJfH9BAjapRmUaD0cj88IubcAd6UPvm7GFPWJYWfPTEqWai7C3Cy+W8lJaOy8UhLYyCU4wm
 R8csgCaxPlsJi02o=
X-Received: by 2002:a05:6a00:21d1:b0:66a:3289:5bf8 with SMTP id
 t17-20020a056a0021d100b0066a32895bf8mr19508148pfj.2.1687779094280; 
 Mon, 26 Jun 2023 04:31:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ZTz8blZNG46/AadOGRGBHVthbgq0Gm3y+eLg0wPNimwD/VgA5sANnxIDAPTWyzztYDo1KSw==
X-Received: by 2002:a05:6a00:21d1:b0:66a:3289:5bf8 with SMTP id
 t17-20020a056a0021d100b0066a32895bf8mr19508132pfj.2.1687779093958; 
 Mon, 26 Jun 2023 04:31:33 -0700 (PDT)
Received: from smtpclient.apple ([115.96.139.77])
 by smtp.gmail.com with ESMTPSA id
 u23-20020a62ed17000000b0064d74808738sm3583893pfh.214.2023.06.26.04.31.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Jun 2023 04:31:33 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v2 4/5] tests/qtest/hd-geo-test: fix test by removing
 unnecessary pcie-root-port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230626131547.010ccdd8@imammedo.users.ipa.redhat.com>
Date: Mon, 26 Jun 2023 17:01:29 +0530
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Labiuk <michael.labiuk@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B33FFEC-B67A-47EF-8867-FE84CEB93412@redhat.com>
References: <20230622103255.267289-1-anisinha@redhat.com>
 <20230622103255.267289-5-anisinha@redhat.com>
 <20230626131547.010ccdd8@imammedo.users.ipa.redhat.com>
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



> On 26-Jun-2023, at 4:45 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> On Thu, 22 Jun 2023 16:02:54 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
>=20
>> A SCSI controller can be attached to a pcie-to-pci bridge which in =
turn can be
>> attached directly to the root bus (peie.0). There is no need to =
attach a
>> pcie-root-port on the root bus in order to attach the pcie-ro-pci =
bridge.
>> Fix it.
>=20
> bridge can be both on pcie.0 or on root-port and both are valid =
configs.
> So what exactly and why we are fixing here?

If you look at the functions carefully, =E2=80=9Cbr=E2=80=9D is a =
pcie-root-port and =E2=80=9Cpcie.0=E2=80=9D is a pcie-to-pci bridge.
The bug here is that both the SCSI controller and the pcie-to-pci bridge =
(pcie.0) were getting attached to the same pcie-root-port. I think the =
intention of the author was to attach the SCSI controller to pcie-to-pci =
bridge.
In any case, I do not see the reason to attach a pcie-root-port here. We =
can attach the pcie-to-pci bridge on the RC and then attach the SCSI =
controllers on the bridge.

>=20
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


