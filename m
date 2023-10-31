Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4957DCE49
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:55:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpCx-0008Ki-N1; Tue, 31 Oct 2023 09:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qxpCt-0008K0-VI
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qxpCs-0000Fh-Ea
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698760496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfAvgAPnrzvaI4kSqRtE04puSgeDSmo60c4Jkre92t0=;
 b=UnU0IvgbPucJnN/8i3/OZpvqRlUtcWzW21ZS7rRY8CPN5YoqskVYEI4pdFrxNzY29UuCW3
 uYT9x2AlEsCoqyhzi7vD0DJkBguuK1pfPkz3ZFRGsutfk+E7RupVRqNpghcM7RHsVv/wd2
 YaHvDUdfCgSYy/SA8ErInHQ8XeYNsOE=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-mf2rJRUhNEK2jATp7WyTkQ-1; Tue, 31 Oct 2023 09:54:54 -0400
X-MC-Unique: mf2rJRUhNEK2jATp7WyTkQ-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1e9bc53c828so7875882fac.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 06:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698760494; x=1699365294;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfAvgAPnrzvaI4kSqRtE04puSgeDSmo60c4Jkre92t0=;
 b=rMvTnwIZ/9iXxOev1bUHIBSRKCCX8S6SQraYPDzx7jC63avCGfAJj/RS34PJP0UB9r
 su7mbIM7iBcyL9//gSirCsieqETQtFSlHjCUuCv7r6WqjDo6DiWCELh9mseGjrzzvBYN
 hVRyVhUmQaVnori7YsmFsQanHkVpOjsRaQRhRpVJjd9vdWlA7/jZuxu7EyB47nMHhTDq
 KY3qPDOTRYFKXEBgYksZVQupW/HEUtelYRwXSn247J6zCt/7HWknFH9QeKaeehsC8QyN
 9yRM2Oty3lyHbh4K//Uxad4mDoVZedgWRDnQP+CTbHpPVSv/jRDdusk23zn6NoAZJq3X
 sMYg==
X-Gm-Message-State: AOJu0YzjW423POIbJzmO6nk2s/eMONkexl6Ape+WNW1B6Op2pLB6R3HU
 Ur9whqOc6mkTUYTlR5IJk48AGEHEjIfjL2mrULZWwpuEiqgj0pilngYab+1d/itvbJjfp1FX1jH
 ove3sVJ5Rjz7VsDs=
X-Received: by 2002:a05:6870:a548:b0:1ef:b669:ba1f with SMTP id
 p8-20020a056870a54800b001efb669ba1fmr10061441oal.8.1698760494215; 
 Tue, 31 Oct 2023 06:54:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVYVhnxP86RSekAQEC8JsDe6hHqUjMUB7aVGXtX9S678QlArx+WDUW1ptrdfOgk7MFpaEl/w==
X-Received: by 2002:a05:6870:a548:b0:1ef:b669:ba1f with SMTP id
 p8-20020a056870a54800b001efb669ba1fmr10061432oal.8.1698760493943; 
 Tue, 31 Oct 2023 06:54:53 -0700 (PDT)
Received: from smtpclient.apple ([115.96.129.243])
 by smtp.gmail.com with ESMTPSA id
 v12-20020a63b64c000000b005b8f3293bf2sm978393pgt.88.2023.10.31.06.54.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Oct 2023 06:54:53 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: tests/data/acpi/rebuild-expected-aml.sh creates files for arm
 virt that don't exist in git
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CAFEAcA_qBLXdeB7aQLcjcfMdEf9hpJu4ZhZZdHbF4SOSyZZXdw@mail.gmail.com>
Date: Tue, 31 Oct 2023 19:24:50 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <04BA3ED8-5BD9-4E78-BCAF-DB8FCF6775FB@redhat.com>
References: <CAFEAcA_qBLXdeB7aQLcjcfMdEf9hpJu4ZhZZdHbF4SOSyZZXdw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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



> On 31-Oct-2023, at 6:38 PM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> I'm doing a patchset that requires rebuilding the bios-tables-test
> expected-data files for the arm virt board. The instructions in
> bios-tables-test.c say that you should run rebuild-expected-aml.sh

This script seems to be only rebuilding the blobs for x86 and aarch64 =
not arm? So is it at all needed to run this?

> to update the data files. But running that script generates a lot
> of new data files that don't exist in git at all and are unrelated
> to the change I'm making:
>=20
>        tests/data/acpi/virt/APIC.memhp
>        tests/data/acpi/virt/APIC.numamem
>        tests/data/acpi/virt/APIC.pxb
>        tests/data/acpi/virt/DBG2.acpihmatvirt
>        tests/data/acpi/virt/DBG2.memhp
>        tests/data/acpi/virt/DBG2.numamem
>        tests/data/acpi/virt/DBG2.pxb
>        tests/data/acpi/virt/DBG2.topology
>        tests/data/acpi/virt/DSDT.numamem
>        tests/data/acpi/virt/FACP.acpihmatvirt
>        tests/data/acpi/virt/FACP.memhp
>        tests/data/acpi/virt/FACP.numamem
>        tests/data/acpi/virt/FACP.pxb
>        tests/data/acpi/virt/FACP.topology
>        tests/data/acpi/virt/GTDT.acpihmatvirt
>        tests/data/acpi/virt/GTDT.memhp
>        tests/data/acpi/virt/GTDT.numamem
>        tests/data/acpi/virt/GTDT.pxb
>        tests/data/acpi/virt/GTDT.topology
>        tests/data/acpi/virt/IORT.acpihmatvirt
>        tests/data/acpi/virt/IORT.memhp
>        tests/data/acpi/virt/IORT.numamem
>        tests/data/acpi/virt/IORT.pxb
>        tests/data/acpi/virt/IORT.topology
>        tests/data/acpi/virt/MCFG.acpihmatvirt
>        tests/data/acpi/virt/MCFG.memhp
>        tests/data/acpi/virt/MCFG.numamem
>        tests/data/acpi/virt/MCFG.pxb
>        tests/data/acpi/virt/MCFG.topology
>        tests/data/acpi/virt/PPTT.memhp
>        tests/data/acpi/virt/PPTT.numamem
>        tests/data/acpi/virt/PPTT.pxb
>        tests/data/acpi/virt/SPCR.acpihmatvirt
>        tests/data/acpi/virt/SPCR.memhp
>        tests/data/acpi/virt/SPCR.numamem
>        tests/data/acpi/virt/SPCR.pxb
>        tests/data/acpi/virt/SPCR.topology
>=20
> Does the script need fixing to not generate these files, or should
> they exist in the git repo?
>=20
> thanks
> -- PMM
>=20


