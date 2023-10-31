Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 720BE7DCE7C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:02:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpJD-0001y9-QI; Tue, 31 Oct 2023 10:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qxpJB-0001xJ-3n
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qxpJ9-0001zU-FR
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698760886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=myzfJXCIS/oiJVPm7Nb8t+4m5+cWg5rSAtxUXcpRwzM=;
 b=fQ7l6CC7y+tCAjJLzIheBDVNSnFPgZsnGkBtRoKk5RRhhebkT3K66f7Tmq/ID1U7lAOFim
 TD4CON0SPPrff/0GxBgDYcYg4xfeJ7q2Bag+rm9kxPvbeQvf1v9rkRZAqre/eLrWqW254y
 Y9vrrIGxIoYUnNMlWzrCbe8rT6/QU7Y=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-r-e13mPZM2W2s_U8EB_taQ-1; Tue, 31 Oct 2023 10:01:25 -0400
X-MC-Unique: r-e13mPZM2W2s_U8EB_taQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6b5cac99d3dso5933261b3a.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698760883; x=1699365683;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=myzfJXCIS/oiJVPm7Nb8t+4m5+cWg5rSAtxUXcpRwzM=;
 b=mzSsR/c4Io7pZcMVlkGpekrN7tFULcluyl2POPt3CKjezE6yF2lEwzLMg1SF5lzdJE
 kg248M/5uWe1K9QWeF0ycX6C+sCHSlClA+mCCni0iT45jwVyCzPvoSYWxGqBhMhGlEYO
 T1AnYKRBJEFIws1GKESbmaGokblQeJNXcud+ntK+7Ua79yHKipoV3rVz9IFlO5Btn4hA
 ZJLFKiSkvlyFrsieJRUyq/4Dj1uFZ4B863P7QELSSN5wIJ05XtY6PSnUyXSGWYn8+S3b
 vT2cORfPGONDIJKJ/GeLBPwFNGuIko7wArEcEerL4bq0LxdpT/oK91B94/n9HmTDnzNy
 T4zw==
X-Gm-Message-State: AOJu0Yypsd2G5zuchRWfowugwnIi1Cs1UImSUSmnH9YoaolG1gQXTjVQ
 CyLrpxxu78sQzo8p84xpYhWk+d35L45v+6y6x8WQ882NWQcYc3ly62HF+iWryU6cbLa3Jjcy0y7
 EWCHSvX3izJJDEX21d02KTIE=
X-Received: by 2002:a05:6a00:1356:b0:6c0:4006:4195 with SMTP id
 k22-20020a056a00135600b006c040064195mr15333706pfu.0.1698760883486; 
 Tue, 31 Oct 2023 07:01:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaqd8F15ou2c0qCrMZTNl6irdeVf8YGFzZ9mPMMq9sRKNYa3CtK+6psy4CyaRkzBL/y7euAg==
X-Received: by 2002:a05:6a00:1356:b0:6c0:4006:4195 with SMTP id
 k22-20020a056a00135600b006c040064195mr15333676pfu.0.1698760883106; 
 Tue, 31 Oct 2023 07:01:23 -0700 (PDT)
Received: from smtpclient.apple ([115.96.129.243])
 by smtp.gmail.com with ESMTPSA id
 fm1-20020a056a002f8100b006933b69f7afsm1290491pfb.42.2023.10.31.07.01.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Oct 2023 07:01:22 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: tests/data/acpi/rebuild-expected-aml.sh creates files for arm
 virt that don't exist in git
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231031094948-mutt-send-email-mst@kernel.org>
Date: Tue, 31 Oct 2023 19:31:18 +0530
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA0866DC-99ED-419D-98BB-1171534924F0@redhat.com>
References: <CAFEAcA_qBLXdeB7aQLcjcfMdEf9hpJu4ZhZZdHbF4SOSyZZXdw@mail.gmail.com>
 <20231031094948-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
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



> On 31-Oct-2023, at 7:21 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Oct 31, 2023 at 01:08:01PM +0000, Peter Maydell wrote:
>> I'm doing a patchset that requires rebuilding the bios-tables-test
>> expected-data files for the arm virt board. The instructions in
>> bios-tables-test.c say that you should run rebuild-expected-aml.sh
>> to update the data files. But running that script generates a lot
>> of new data files that don't exist in git at all and are unrelated
>> to the change I'm making:
>>=20
>>        tests/data/acpi/virt/APIC.memhp
>>        tests/data/acpi/virt/APIC.numamem
>>        tests/data/acpi/virt/APIC.pxb
>>        tests/data/acpi/virt/DBG2.acpihmatvirt
>>        tests/data/acpi/virt/DBG2.memhp
>>        tests/data/acpi/virt/DBG2.numamem
>>        tests/data/acpi/virt/DBG2.pxb
>>        tests/data/acpi/virt/DBG2.topology
>>        tests/data/acpi/virt/DSDT.numamem
>>        tests/data/acpi/virt/FACP.acpihmatvirt
>>        tests/data/acpi/virt/FACP.memhp
>>        tests/data/acpi/virt/FACP.numamem
>>        tests/data/acpi/virt/FACP.pxb
>>        tests/data/acpi/virt/FACP.topology
>>        tests/data/acpi/virt/GTDT.acpihmatvirt
>>        tests/data/acpi/virt/GTDT.memhp
>>        tests/data/acpi/virt/GTDT.numamem
>>        tests/data/acpi/virt/GTDT.pxb
>>        tests/data/acpi/virt/GTDT.topology
>>        tests/data/acpi/virt/IORT.acpihmatvirt
>>        tests/data/acpi/virt/IORT.memhp
>>        tests/data/acpi/virt/IORT.numamem
>>        tests/data/acpi/virt/IORT.pxb
>>        tests/data/acpi/virt/IORT.topology
>>        tests/data/acpi/virt/MCFG.acpihmatvirt
>>        tests/data/acpi/virt/MCFG.memhp
>>        tests/data/acpi/virt/MCFG.numamem
>>        tests/data/acpi/virt/MCFG.pxb
>>        tests/data/acpi/virt/MCFG.topology
>>        tests/data/acpi/virt/PPTT.memhp
>>        tests/data/acpi/virt/PPTT.numamem
>>        tests/data/acpi/virt/PPTT.pxb
>>        tests/data/acpi/virt/SPCR.acpihmatvirt
>>        tests/data/acpi/virt/SPCR.memhp
>>        tests/data/acpi/virt/SPCR.numamem
>>        tests/data/acpi/virt/SPCR.pxb
>>        tests/data/acpi/virt/SPCR.topology
>>=20
>> Does the script need fixing to not generate these files, or should
>> they exist in the git repo?
>=20
> The script is not smart enough to notice that files are identical - =
e.g.
> tests/data/acpi/virt/PPTT are all the same so we just have one of =
these
> - and so all the copies don't need to be there.=20

See this in bios-tables-test.c

       if (g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
            exp_sdt.aml_file =3D aml_file;
        } else if (*ext !=3D '\0') {
            /* try fallback to generic (extension less) expected file */
            ext =3D "";
            g_free(aml_file);
            goto try_again;
        }


Basically we need to make the dumping part of the code smarter. I will =
try something if I am too bored :-)


