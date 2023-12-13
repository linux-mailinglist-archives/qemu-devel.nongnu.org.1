Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 328448114E0
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 15:40:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDQOu-0002FR-EH; Wed, 13 Dec 2023 09:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rDQOs-0002Ej-MD
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 09:39:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rDQOr-0005jj-0r
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 09:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702478388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4oJ5APz0K/zt7N6ap1Teb4iFpMf4iqgWP7VT2I1X4Q=;
 b=TxjA8sU+ZpUYGdI85Plyo3DXa+mBUTNENNSZAHb7Lj9y77G9iIBc2BeJo4Sm+cfv8ABVq2
 7lFHj2o88ef6kesVptWn3qYZQgHOf4E0hQUkAvTMqE4fD0kaQPd5lSvTtHmunq4R7zUOMg
 qzdTl75J1B7lyk1zJ9jily2xo8wGHoQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-N9A4koVVPGqZRfQVI-BzSw-1; Wed, 13 Dec 2023 09:39:46 -0500
X-MC-Unique: N9A4koVVPGqZRfQVI-BzSw-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d32b4a8ea0so30018755ad.3
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 06:39:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702478384; x=1703083184;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4oJ5APz0K/zt7N6ap1Teb4iFpMf4iqgWP7VT2I1X4Q=;
 b=Rj2oEKVnvC4hfzakmugeVnf7CjCB/xadln2I820NIqxkNGW6i0qLTjjefFVJF/3vZD
 Y/eZgEGgFehyYcxjOpvCQfqVArH1DrNoF+KxxSjx4mCIalF0Sno8cyvsASDk763yKhZ0
 qzRP0+NQdQQ9pXdpae/zqAgbh1s7Q4zEHHtKFxOQ6fdCq//6uz0x1ji3jMbcVKHVrVBA
 HyX/XXZMweFF5hkOARtUHfFkktNAicf17rAmv3g2DFMZKxTWscjNRbZrO2E+yi/d5gb+
 Cko0/twgVcWOXJZ2MpBilgqL2GyPKGb2hN7IE1pd+y8n/0shtnj55xRlfKTEPB+JhCmg
 dreg==
X-Gm-Message-State: AOJu0YwbsEdC8y+ARje3WyLiewF2YmqCTBIpkmDxjXQ9IeVa0NfufcGc
 SCi+FTNFrSFVv3t5XXiFWgZJ1tkUT5ayiw0nX2hLnAwwc/rL3bplHdXpaq/uYPkoHNP+RPFAQJd
 AwxCok7UxxAJAgMULp2dm2nM=
X-Received: by 2002:a17:902:e54a:b0:1d0:ab0e:9154 with SMTP id
 n10-20020a170902e54a00b001d0ab0e9154mr9832569plf.125.1702478384492; 
 Wed, 13 Dec 2023 06:39:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTFnDmmcFO2o+RjWizKQQNydaaOoc6rIZLKwX4WcH1uHBJFacMJZFwwlLRfbF+fRRn5LwBcQ==
X-Received: by 2002:a17:902:e54a:b0:1d0:ab0e:9154 with SMTP id
 n10-20020a170902e54a00b001d0ab0e9154mr9832555plf.125.1702478384143; 
 Wed, 13 Dec 2023 06:39:44 -0800 (PST)
Received: from smtpclient.apple ([203.163.232.58])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a170902ce8b00b001cc307bcdbdsm10682105plg.211.2023.12.13.06.39.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Dec 2023 06:39:43 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PULL 6/6] tests/acpi: disallow tests/data/acpi/virt/SSDT.memhp
 changes
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231213093242-mutt-send-email-mst@kernel.org>
Date: Wed, 13 Dec 2023 20:09:29 +0530
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <98BBB08F-31A9-48B8-9DAF-CF32E1F8B742@redhat.com>
References: <20231213105026.1944656-1-kraxel@redhat.com>
 <20231213105026.1944656-7-kraxel@redhat.com>
 <AD96681F-FBF0-4AB9-8F2B-5B6C1FB5A52F@redhat.com>
 <20231213093242-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



> On 13-Dec-2023, at 8:03=E2=80=AFPM, Michael S. Tsirkin =
<mst@redhat.com> wrote:
>=20
> On Wed, Dec 13, 2023 at 04:24:24PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 13-Dec-2023, at 4:20=E2=80=AFPM, Gerd Hoffmann =
<kraxel@redhat.com> wrote:
>>>=20
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>=20
>> Please combine this patch with patch 5. No need to do this =
separately.
>=20
>=20
> Yes but since it's done - it's fine either way I think. No?

Yes I did not realise it was a PR and not a review. I thought it was =
sent for review. If it=E2=80=99s done it=E2=80=99s ok.
That being said, I would have preferred that the commit had a =
description and not completely empty.

>=20
>>> ---
>>> tests/qtest/bios-tables-test-allowed-diff.h | 1 -
>>> 1 file changed, 1 deletion(-)
>>>=20
>>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h =
b/tests/qtest/bios-tables-test-allowed-diff.h
>>> index e569098abddc..dfb8523c8bf4 100644
>>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>>> @@ -1,2 +1 @@
>>> /* List of comma-separated changed AML files to ignore */
>>> -"tests/data/acpi/virt/SSDT.memhp",
>>> --=20
>>> 2.43.0
>>>=20
>=20


