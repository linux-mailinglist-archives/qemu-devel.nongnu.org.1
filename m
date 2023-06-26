Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA6D73E137
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:56:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmhl-0002Ou-W8; Mon, 26 Jun 2023 09:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDmhj-0002OQ-VS
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:56:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDmhi-0006m4-Dk
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687787789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQ1RUptSeNKrfN5uf7Oxwakoha2B16PptlcQkRughPA=;
 b=EkS5BgT1NhepMLuUQNjAKcp//LET+EM0FnWJdRjmC/uIcIZTL6iTejTW+WR3byLEBGQYFD
 cbxMGmV5JvNU6ZCtZrM7Vut/ZPV2QSUykzOMUYqhog7QMjAu9CyLwyETTwcdEaBl7W6CP5
 MNt2aIqRf3JRFGcyUJLcQjtQw+QTMDA=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-5C7yHEEiONO_M_64j7CqPA-1; Mon, 26 Jun 2023 09:56:28 -0400
X-MC-Unique: 5C7yHEEiONO_M_64j7CqPA-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-55e2389c493so1479723eaf.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687787788; x=1690379788;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQ1RUptSeNKrfN5uf7Oxwakoha2B16PptlcQkRughPA=;
 b=RltPq3bAUGGW9EIyDQQe0UouIUB9BrAR9PLp7mdAamR/Rf4m+SpQB0NSTJO+6XFv+s
 ijrrqEpJwONa4jipODHnW1Iut+0aB1jPyWAe7porbgXa7AgfcLVy3Ci3yGT0NKbfIinV
 WNDFxgKiesCHNSCdHtYryKvUg3M/iSIYj4Uo96pmEpzu6+oag9RXzXAgDU++/1GvlQvg
 imCkleeHAjHS+UkDD6AK/9CsWkPX14lyB+RLZl+GeIN6r6U2Jb95lM5+DMw58SqmbIUe
 +5F5WdktbllQ9Z3ABpFv4TBpwCIWOXmu1EE3T7zzud/rje0OxK1oVhbz9FJRA9kO+rpZ
 uQOg==
X-Gm-Message-State: AC+VfDw6SU1KUqIr9zyOz5LV29XX5P6B3sHHcAEuPw+WAShGUs8xr63h
 WAo25GflPiZAjJ49a146cZ4U2dbn5ozffuFoG4GI21vRUJQfzZ1zKKRrCmwRjleFGyRIdcfmFqS
 /68Fd4GkVm9PZSJg=
X-Received: by 2002:a54:4711:0:b0:3a1:b12f:824f with SMTP id
 k17-20020a544711000000b003a1b12f824fmr6346667oik.35.1687787787789; 
 Mon, 26 Jun 2023 06:56:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7A5fkF4ng6zcQPWIOoepaSRq5uGUZoYzFvim49sUmwhSvezzeeFMUlC5EvnDhYiHMDscsLyA==
X-Received: by 2002:a54:4711:0:b0:3a1:b12f:824f with SMTP id
 k17-20020a544711000000b003a1b12f824fmr6346650oik.35.1687787787483; 
 Mon, 26 Jun 2023 06:56:27 -0700 (PDT)
Received: from smtpclient.apple ([115.96.139.77])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a170902b60100b0019ee045a2b3sm4208085pls.308.2023.06.26.06.56.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Jun 2023 06:56:27 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v4 0/5] test and QEMU fixes to ensure proper PCIE device
 usage
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230626095407-mutt-send-email-mst@kernel.org>
Date: Mon, 26 Jun 2023 19:26:22 +0530
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, michael.labiuk@virtuozzo.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <97BD632C-527A-4FF7-9D49-DB298F761DEB@redhat.com>
References: <20230626135324.10687-1-anisinha@redhat.com>
 <20230626095407-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
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



> On 26-Jun-2023, at 7:24 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> Ani, two versions a day is too much,

So you suggesting I slow down my CPU freq? :-)=20

> pls don't unless first one
> has been sent by mistake or something. then explain what
> it was pls.

I did say=20

v4: reword commit log for patch 4

>=20
> On Mon, Jun 26, 2023 at 07:23:19PM +0530, Ani Sinha wrote:
>> Patches 1-4:
>> Fix tests so that devices do not use non-zero slots on the pcie root
>> ports. PCIE ports only have one slot, so PCIE devices can only be
>> plugged into slot 0 on a PCIE port.
>>=20
>> Patch 5:
>> Enforce only one slot on PCIE port.
>>=20
>> The test fixes must be applied before the QEMU change that checks for =
use
>> of a single slot in PCIE port.
>>=20
>> CC: mst@redhat.com
>> CC: imammedo@redhat.com
>> CC: jusual@redhat.com
>> CC: thuth@redhat.com
>> CC: lvivier@redhat.com
>> CC: michael.labiuk@virtuozzo.com
>>=20
>> Changelog:
>> v4: reword commit log for patch 4.
>> v3: tags added. reword the error description in patch 5. Reword =
commit log in patch 4.=20
>> v2: add hd-geo-test fix as well as the actual QEMU code fix to the =
patchset.
>> The patches are added in the right order.
>>=20
>> Ani Sinha (5):
>>  tests/acpi: allow changes in DSDT.noacpihp table blob
>>  tests/acpi/bios-tables-test: use the correct slot on the
>>    pcie-root-port
>>  tests/acpi/bios-tables-test: update acpi blob q35/DSDT.noacpihp
>>  tests/qtest/hd-geo-test: fix incorrect pcie-root-port usage and
>>    simplify test
>>  hw/pci: ensure PCIE devices are plugged into only slot 0 of PCIE =
port
>>=20
>> hw/pci/pci.c                      |   6 ++++++
>> tests/data/acpi/q35/DSDT.noacpihp | Bin 8248 -> 8241 bytes
>> tests/qtest/bios-tables-test.c    |   4 ++--
>> tests/qtest/hd-geo-test.c         |  18 ++++++++----------
>> 4 files changed, 16 insertions(+), 12 deletions(-)
>>=20
>> --=20
>> 2.39.1
>=20


