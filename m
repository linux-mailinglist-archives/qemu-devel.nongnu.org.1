Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8A881161A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:23:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDR44-0001At-KB; Wed, 13 Dec 2023 10:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rDR42-0001AU-5S
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:22:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rDR40-0001Yu-M4
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702480939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SH0gGHJ3uwI7I/+OC5YsnHxWER6lWuWWXYeVHD9Pz8o=;
 b=JSY4NtwRCuKKQkmhsurj9RZbUj7l2UEPPahCXmQpG7kh/xF/OvfZ1MvD7rLYPP8eF10KMD
 gSYPI5ASV23pIwOA47SXMcCUEajxIqOCNOECfkDjRVQq9gb9A0rTwUG9ATQGfqjL1Nq1Lq
 yiwaYwnYaIj/lVeeDEwINM9sAMxuzfc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-lVxVf-Q2NamopRj9b8LeDA-1; Wed, 13 Dec 2023 10:22:18 -0500
X-MC-Unique: lVxVf-Q2NamopRj9b8LeDA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6cecc9a3519so3602928b3a.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 07:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702480936; x=1703085736;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SH0gGHJ3uwI7I/+OC5YsnHxWER6lWuWWXYeVHD9Pz8o=;
 b=MCvPq6biEk181ycvUy+EM5cEBHNrfrEfqabzRg+9I2aIRQCvsv7mVrdtzl4mwS0ETN
 lGk4crVXbfJLas/lgVQ3IQCTwxCAGlLBLxW8uiBvnazc+L27/cmwH2FqRiuYyV+lqMgY
 lsdBQKXjAM6ZAfh9M6L30pyC99iXs4tGaWZB+vLhbZ1EDRBQwbRvNQ+23gG9kIhbjpaa
 8vuBBPhj44dZg6BvwCfDatnlE2gtB3TGFJTFe0nT7uyw0gTFf9u5hgpGhjuARWQV3Kux
 TwySXKoXB/oU23Z++RjsnoiTGEl1FYjGtdzhLUXyDSiNhKVzcMWNj5EmUL9Pghuwbunr
 22nw==
X-Gm-Message-State: AOJu0YxT9w4ONp2P8IB4bvicpWmofC6msHZeI++RYT01vkj0idSS3PUb
 UCCJe5xidkUMvT+ehU5MngDcAOas6gG9IRzhNhFirNpfR67bOzZr9HsnQcJ67X+p4Faf0oQEXbw
 p934d32lmLHy3kbhdeDgQ4Vs=
X-Received: by 2002:a05:6a21:2703:b0:187:a4df:4e57 with SMTP id
 rm3-20020a056a21270300b00187a4df4e57mr4091279pzb.20.1702480936321; 
 Wed, 13 Dec 2023 07:22:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHdQIYsncmDsU9zFWWwyuNVuwjQWc+k9xQkc6YiQQ7RvOTHedAGVPiikjxvXj4cbW3ZdcJwQ==
X-Received: by 2002:a05:6a21:2703:b0:187:a4df:4e57 with SMTP id
 rm3-20020a056a21270300b00187a4df4e57mr4091270pzb.20.1702480935988; 
 Wed, 13 Dec 2023 07:22:15 -0800 (PST)
Received: from smtpclient.apple ([203.163.232.58])
 by smtp.gmail.com with ESMTPSA id
 q6-20020a635c06000000b00528db73ed70sm9759235pgb.3.2023.12.13.07.22.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Dec 2023 07:22:15 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PULL 6/6] tests/acpi: disallow tests/data/acpi/virt/SSDT.memhp
 changes
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231213101629-mutt-send-email-mst@kernel.org>
Date: Wed, 13 Dec 2023 20:52:01 +0530
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <48CE6B59-1624-49A1-B5A9-EC1BD468DCCF@redhat.com>
References: <20231213105026.1944656-1-kraxel@redhat.com>
 <20231213105026.1944656-7-kraxel@redhat.com>
 <AD96681F-FBF0-4AB9-8F2B-5B6C1FB5A52F@redhat.com>
 <20231213093242-mutt-send-email-mst@kernel.org>
 <98BBB08F-31A9-48B8-9DAF-CF32E1F8B742@redhat.com>
 <20231213100321-mutt-send-email-mst@kernel.org>
 <dr77dip25isnjsfs3llxuxpxnym5dxwovwaruqvnjw5s6ydgou@7sni32qgde44>
 <20231213101629-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 13-Dec-2023, at 8:47=E2=80=AFPM, Michael S. Tsirkin =
<mst@redhat.com> wrote:
>=20
> On Wed, Dec 13, 2023 at 04:14:00PM +0100, Gerd Hoffmann wrote:
>>  Hi,
>>=20
>>> I agree, Gerd, going forward please include the diff of the
>>> disassemled AML.
>>=20
>> That is in patch 5/6 which updates the test data.
>>=20
>> take care,
>>  Gerd
>=20
> Oh I double checked and you are right, I'm not sure where did I look =
that I missed it.

Yes I was talking about patch 6 having an empty description.


