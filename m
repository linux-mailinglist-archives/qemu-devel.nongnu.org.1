Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 546D073E42C
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:06:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDojj-0002wp-5e; Mon, 26 Jun 2023 12:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDojg-0002uu-Qj
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDojf-0001Cn-8n
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687795598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IKkP/SlfJ+rAKzK8U2VAaeYfAniZnzDyd1ocjUJ4kDU=;
 b=PUVTitEJSg+qW6dd1HK4WmHRHtv0gGlan/rcTcfUNUkAl4tCyfGJbmBlRt1yaloB1gif2D
 x7mI4LZnfEFIy6FR5bEKywhI1PafUbrhzc7Bv+l3LORJaNzum459QaQktdHG9SaDuFquv7
 IJAFi6PeoqXkvetewI9NXOdHl907OGA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-muuBmfBzP16mMG7QATWRMg-1; Mon, 26 Jun 2023 12:06:31 -0400
X-MC-Unique: muuBmfBzP16mMG7QATWRMg-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1b7ea1595b4so7117955ad.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 09:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687795588; x=1690387588;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IKkP/SlfJ+rAKzK8U2VAaeYfAniZnzDyd1ocjUJ4kDU=;
 b=IOXFnllIxYGh80KpJS0FUki1hBvwAh/23//jf2p9tqUFTODIHBZ6R0nPC9kK/qAlsi
 jTuEn04auW6tXuA+mFery819D2XaWXJWhSqbUBoqv6Z1BC+zwoyeLXmvZulwFg63I0wL
 65sYg8X/f6mOuDgak6c+dQy5eEvdc8x7pxFY2eiOi97eeYd1lCKwcHcM0yHFK20H1u6w
 Y6hytD1fpjLFih0wk8LZpKtqKOb32C90x+Cc8sr/M582vROILyitKjEV1vZNTfHL1CA7
 ZATZNArFtndfPRCGnMEdtbJQNEghUW3PunW28d9uk0yz5G8fEW4M3BjQtSo4XoeL3cfc
 tg/g==
X-Gm-Message-State: AC+VfDwZD7c6LACy9p16t5ZaUwhACEWWrjYzt3LOPb9mJwuXiTUoRmpF
 AxQtn3L9csOiZoaTgCIIHNMEEBoEIbV2gRXxxjYke2f6rRQw3Q7ByWZJFEc8a8Ysg05bO12/Cwf
 nZZbx03o181ntBqUKQ+WB3M0h2AvDfvo04+/E5LleD5b+TmgTfKJsRlvpvXYWlab6zihJQiWert
 c=
X-Received: by 2002:a17:903:2452:b0:1b7:cee1:60c4 with SMTP id
 l18-20020a170903245200b001b7cee160c4mr4863029pls.59.1687795588731; 
 Mon, 26 Jun 2023 09:06:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4jIu11UTuObDCnZdP1db8Jkeu/EYV2X1xHOv/YBcqUzht952dCRcZ+gLlalBYX8Ty9A6gv3g==
X-Received: by 2002:a17:903:2452:b0:1b7:cee1:60c4 with SMTP id
 l18-20020a170903245200b001b7cee160c4mr4863000pls.59.1687795588326; 
 Mon, 26 Jun 2023 09:06:28 -0700 (PDT)
Received: from smtpclient.apple ([115.96.139.77])
 by smtp.gmail.com with ESMTPSA id
 jf5-20020a170903268500b001b7eeffbdbfsm3421442plb.261.2023.06.26.09.06.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Jun 2023 09:06:28 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v5 0/5] test and QEMU fixes to ensure proper PCIE device
 usage
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230626160156.3938-1-anisinha@redhat.com>
Date: Mon, 26 Jun 2023 21:36:23 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, thuth@redhat.com, lvivier@redhat.com,
 michael.labiuk@virtuozzo.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <22568A8B-2ABB-44F0-89A6-6338A91E4382@redhat.com>
References: <20230626160156.3938-1-anisinha@redhat.com>
To: qemu-devel@nongnu.org
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

Scratch this =E2=80=A6 I will resend =E2=80=A6


> On 26-Jun-2023, at 9:31 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
> Patches 1-4:
> Fix tests so that devices do not use non-zero slots on the pcie root
> ports. PCIE ports only have one slot, so PCIE devices can only be
> plugged into slot 0 on a PCIE port.
>=20
> Patch 5:
> Enforce only one slot on PCIE port.
>=20
> The test fixes must be applied before the QEMU change that checks for =
use
> of a single slot in PCIE port.
>=20
> CC: mst@redhat.com
> CC: imammedo@redhat.com
> CC: jusual@redhat.com
> CC: thuth@redhat.com
> CC: lvivier@redhat.com
> CC: michael.labiuk@virtuozzo.com
>=20
> Changelog:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> v5: no code changes - correct a mistake in the commit log message.
>=20
> v4: reword commit log for patch 4.
>=20
> v3: tags added. reword the error description in patch 5. Reword commit =
log in patch 4.=20
>=20
> v2: add hd-geo-test fix as well as the actual QEMU code fix to the =
patchset.
> The patches are added in the right order.
>=20
>=20
> Ani Sinha (4):
>  tests/acpi: allow changes in DSDT.noacpihp table blob
>  tests/acpi/bios-tables-test: use the correct slot on the
>    pcie-root-port
>  tests/acpi/bios-tables-test: update acpi blob q35/DSDT.noacpihp
>  tests/qtest/hd-geo-test: fix incorrect pcie-root-port usage and
>    simplify test
>=20
> Peter Maydell (1):
>  Revert "cputlb: Restrict SavedIOTLB to system emulation"
>=20
> include/hw/core/cpu.h             |   6 ++----
> tests/data/acpi/q35/DSDT.noacpihp | Bin 8248 -> 8241 bytes
> tests/qtest/bios-tables-test.c    |   4 ++--
> tests/qtest/hd-geo-test.c         |  18 ++++++++----------
> 4 files changed, 12 insertions(+), 16 deletions(-)
>=20
> --=20
> 2.39.1
>=20


