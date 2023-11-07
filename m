Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 505137E3621
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 08:56:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Gw0-0000d9-Sr; Tue, 07 Nov 2023 02:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r0Gvx-0000cf-UM
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:55:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r0Gvw-0001HG-BV
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699343735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VgVOPEL42G2kdqZq4NjIshGGGQbjEU1aX4xsuj3xops=;
 b=bhMnCVLqEUQCH0A4BjBgzUjwBKt9wliFQUx8f764mD4JleTmZ6T1u3gdemRAz2i9Ko/tnV
 4AhSdrTwhBmZFH1Fi6sCsoGmQyRakbHhvBxT46F4zmTdIAri5xNEI/85437/MHBJ3RwUrS
 AA9Q1caJVUGH/MQ6Cpru5pCsT4S13EI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-415vGCYYN2ug1X84qUOedQ-1; Tue, 07 Nov 2023 02:55:34 -0500
X-MC-Unique: 415vGCYYN2ug1X84qUOedQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-da1aa98ec19so6546220276.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 23:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699343733; x=1699948533;
 h=message-id:references:cc:in-reply-to:date:subject:mime-version
 :content-transfer-encoding:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VgVOPEL42G2kdqZq4NjIshGGGQbjEU1aX4xsuj3xops=;
 b=E4W+7jXGPsa9E3gcpT/Ciz/pbPY7qpCRaqgVKngIe9Q4j47bP2pfxIw3XbSFfGs6gu
 Hl7GBcNygfKBP8VJcbDwsreu52O9I6O0RugbAMpv5oBT76Jw2NYVl3Ykdxw+osHvEWdZ
 D07h8f/8CPaI6Z3LbcHa1M7c4lAAHOAAqYTxv6V4WaVYojGNEkZOwa/JQSFwJmlsaio5
 n7N/SzXeO0Te899jVEAdzCrOKSXmvF+75a3+PJ4YJaXBTFIuXrw9DKEK5UhQmWzZthRO
 tt+NHr27JAwcyRELEpa5vJZ3outJyP/Vco0wVsMAC3Ud7ldPcb4Hgq43O6CYMjbn70KN
 /ynQ==
X-Gm-Message-State: AOJu0Yx6uznsib47tpyuZ7dsnYI2A/Me4t3e9xbJ/pBQ3E8WJ7viGP3V
 RxQ4v08gdSQqDXXne0GVZlPtSSu1FizFQpAvRpaKQ2W7Vt0fZwj0+1N16bX3vR0+zwD8of/xGIo
 k/dMLSWkubE1vcKM=
X-Received: by 2002:a25:aca8:0:b0:da0:d005:6bb7 with SMTP id
 x40-20020a25aca8000000b00da0d0056bb7mr31471996ybi.1.1699343733739; 
 Mon, 06 Nov 2023 23:55:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW8GHMsm8ssQGkf1Tb+kdh9zrdq7rIL78vVt6iiNS5I6XOaGO+edrwDqnYqzeDW0SZ5vko0w==
X-Received: by 2002:a25:aca8:0:b0:da0:d005:6bb7 with SMTP id
 x40-20020a25aca8000000b00da0d0056bb7mr31471984ybi.1.1699343733467; 
 Mon, 06 Nov 2023 23:55:33 -0800 (PST)
Received: from smtpclient.apple ([115.96.144.207])
 by smtp.gmail.com with ESMTPSA id
 p3-20020aa78603000000b0068883728c16sm6927493pfn.144.2023.11.06.23.55.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Nov 2023 23:55:32 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH 0/2] Some biosbits avocado test fixes
Date: Tue, 7 Nov 2023 13:25:28 +0530
In-Reply-To: <20231027032120.6012-1-anisinha@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org,
 crosa@redhat.com, philmd@linaro.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20231027032120.6012-1-anisinha@redhat.com>
Message-Id: <FE18100E-8B63-439C-875C-752E23C7DB6C@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> On 27-Oct-2023, at 8:51 AM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
> Included are couple of bios bits test fixes.
> 32-bit SMBIOS entry point is enforced.
> Console logging is enabled.
>=20
> I have tested these changes in the CI pipeline here and the test seems
> to pass:
>=20
> https://gitlab.com/anisinha/qemu/-/jobs/5380627517

MST, are you going to queue this?

> Log:
>=20
> =
https://cdn.artifacts.gitlab-static.net/8a/b0/8ab0aa629e9c43a80356e27a4409=
85f41da9ad10b120a410d9f070bed092fea6/2023_10_26/5380627517/5862985776/job.=
log?response-content-type=3Dtext%2Fplain%3B%20charset%3Dutf-8&response-con=
tent-disposition=3Dinline&Expires=3D1698376660&KeyName=3Dgprd-artifacts-cd=
n&Signature=3Dln7fYsTb8t6ch0Trsa7SHAN01QY=3D
>=20
> CC: jsnow@redhat.com
> CC: jusual@redhat.com
> CC: imammedo@redhat.com
> CC: mst@redhat.com
> CC: qemu-devel@nongnu.org
> CC: crosa@redhat.com
> CC: philmd@linaro.org
> CC: Wainer dos Santos Moschetta <wainersm@redhat.com>
> CC: Beraldo Leal <bleal@redhat.com>
>=20
> Ani Sinha (2):
>  acpi/tests/avocado/bits: enforce 32-bit SMBIOS entry point
>  acpi/tests/avocado/bits: enable console logging from bits VM
>=20
> tests/avocado/acpi-bits.py | 33 ++++++++++++++++++++++-----------
> 1 file changed, 22 insertions(+), 11 deletions(-)
>=20
> --=20
> 2.42.0
>=20


