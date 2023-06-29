Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A79574289D
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 16:40:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEsn4-0005Es-PD; Thu, 29 Jun 2023 10:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEsn1-0005EW-P5
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 10:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEsmg-0006s2-BS
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 10:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688049488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8tXa4Zh6Sg1U/9oLV0zW5gTkL1B3BtaPxzy/Mg+oxNk=;
 b=f9IN/S8OSeukI1NyJiwkNRljXywD8N774mNQNxyLYfQGVrZ4QP24y5uW/Y10kQe+5qCsn4
 UIxnvzLTis6XwIEQ/OIIHeCQBZtefDpVe+/xvO2Hytdy9m1M2BZEJx7F5LVfEnoyN76GBp
 GJ0ngPn5F0Ef/jUSY88eCpvQcQPP7CE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-PyPYd3SFO8yNWcTUlShNPw-1; Thu, 29 Jun 2023 10:38:04 -0400
X-MC-Unique: PyPYd3SFO8yNWcTUlShNPw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-666ecb24eb3so451339b3a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 07:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688049483; x=1690641483;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8tXa4Zh6Sg1U/9oLV0zW5gTkL1B3BtaPxzy/Mg+oxNk=;
 b=ZI8zsFsPYLcaEszitFpHV6EL6zxlkNKD5wwVtjHH/852ijJ/Ou4eJ3U8S92h+3ZMs9
 ALGUghaMyQxyg+xjPSyUGgmVGK33DFOgkB3sd1YqrrYUJQ6ZQjme+q3Ed/i+qRTPUgSZ
 eMNkCqeSAl41HjtAWkn0E5nCPv6qPG5eAB4kpIEr4gRmoJXgH12BxuKcxCuqyihPB3FP
 qQ0QhnIXZCXcEb563A7CDrDMrDfdepvTZodnC1utls1WhYWCIG/SscQLzjKk5fu4Rjr3
 X+jtadh9oE+P0ZrLHRPQkwKjoKS9Sb84jBokdibsiuXjL96D6l6oKg55dstu3mwYM2yt
 8zgA==
X-Gm-Message-State: ABy/qLZJ233+7ilUXw7KrebHazz06vRx4MnXjcDk3EMbYlmkUYDh+8e8
 gFBeBU4Bp42d1Je7FZIQwpenJNivuwzc6zZYWgs8vjUwoal8nSw2i0FNtaqRQ3JpmL0jbRJIc/Z
 Dn/suSft+gAn36NzOjamnb98=
X-Received: by 2002:a05:6a00:228e:b0:675:70d7:1eb4 with SMTP id
 f14-20020a056a00228e00b0067570d71eb4mr123686pfe.14.1688049482771; 
 Thu, 29 Jun 2023 07:38:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGiLmC+R/DCj6VBMjX/IvGv/7JUDmcB8FCR+qBnqdKjuG9eoOaQy8UpJxqGvm8Isuuig7f4Fg==
X-Received: by 2002:a05:6a00:228e:b0:675:70d7:1eb4 with SMTP id
 f14-20020a056a00228e00b0067570d71eb4mr123669pfe.14.1688049482469; 
 Thu, 29 Jun 2023 07:38:02 -0700 (PDT)
Received: from smtpclient.apple ([203.163.234.183])
 by smtp.gmail.com with ESMTPSA id
 a16-20020aa780d0000000b00666e2dac482sm8446133pfn.124.2023.06.29.07.37.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Jun 2023 07:38:02 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230629102421-mutt-send-email-mst@kernel.org>
Date: Thu, 29 Jun 2023 20:07:57 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com,
 imammedo@redhat.com, akihiko.odaki@daynix.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A398CFAA-12F6-447D-A03D-F2DAC79AB1B7@redhat.com>
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-6-anisinha@redhat.com>
 <20230629102421-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
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



> On 29-Jun-2023, at 7:54 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Thu, Jun 29, 2023 at 09:37:07AM +0530, Ani Sinha wrote:
>> PCI Express ports only have one slot, so PCI Express devices can only =
be
>> plugged into slot 0 on a PCIE port. Enforce it.
>>=20
>> The change has been tested to not break ARI by instantiating seven =
vfs on an
>> emulated igb device (the maximum number of vfs the linux igb driver =
supports).
>=20
> I guess we need to test with some other device then? 7 VFs is same
> slot so hardly a good test.

No its not the same slot. Its using different slots/device numbers. I =
checked that.
The same patch was failing without the vf check.

>=20
>> The vfs are seen to have non-zero device/slot numbers in the =
conventional
>> PCI BDF representation.
>>=20
>> CC: jusual@redhat.com
>> CC: imammedo@redhat.com
>> CC: akihiko.odaki@daynix.com
>>=20
>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
>> ---
>> hw/pci/pci.c | 15 +++++++++++++++
>> 1 file changed, 15 insertions(+)
>>=20
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index e2eb4c3b4a..0320ac2bb3 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -65,6 +65,7 @@ bool pci_available =3D true;
>> static char *pcibus_get_dev_path(DeviceState *dev);
>> static char *pcibus_get_fw_dev_path(DeviceState *dev);
>> static void pcibus_reset(BusState *qbus);
>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>=20
>> static Property pci_props[] =3D {
>>     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>> @@ -1190,6 +1191,20 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>                    name);
>>=20
>>        return NULL;
>> +    } /*
>> +       * With SRIOV and ARI, vfs can have non-zero slot in the =
conventional
>> +       * PCI interpretation as all five bits reserved for slot =
addresses are
>> +       * also used for function bits for the various vfs. Ignore =
that case.
>> +       * It is too early here to check for ARI capabilities in the =
PCI config
>> +       * space. Hence, we check for a vf device instead.
>> +       */
>> +    else if (!pci_is_vf(pci_dev) &&
>> +             pcie_has_upstream_port(pci_dev) &&
>> +             PCI_SLOT(devfn)) {
>> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
>> +                   " parent device only allows plugging into slot =
0.",
>> +                   PCI_SLOT(devfn), name);
>> +        return NULL;
>>     }
>>=20
>>     pci_dev->devfn =3D devfn;
>> --=20
>> 2.39.1
>=20


