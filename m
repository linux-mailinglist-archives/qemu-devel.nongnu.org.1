Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 187FA741E7C
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 04:50:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEhiB-0000ZK-2a; Wed, 28 Jun 2023 22:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEhi8-0000Yq-A5
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 22:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEhi6-000724-FV
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 22:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688006920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uv+bzi7gDJcp1FHseYhH5CS9k4cB9qeLEBBG38dVMno=;
 b=I3BhVD/7Btaci0+xhbpdevBvpTyw7rxrP0pMNmy6I0/X18sqViMd2aT7sPZ5YEEVc7Yd6F
 rGtPQC2aXZgLpXpAfsNZ6O5mAod6Jf9u7fM3euC3dJYASWs4gmWkU0SfnxQIb93RR6fUIh
 rO4siH7p6G5njFx6pLvQsGIBlWDqcoc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-NZy8jTNKMDycQb67kITOlA-1; Wed, 28 Jun 2023 22:48:39 -0400
X-MC-Unique: NZy8jTNKMDycQb67kITOlA-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6686a103a8cso232029b3a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 19:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688006918; x=1690598918;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uv+bzi7gDJcp1FHseYhH5CS9k4cB9qeLEBBG38dVMno=;
 b=Kf4733xbOZGjApyEr0xgkaFxzQqm8XF+WmEuL+TwuxnPi6MAG1ghZoP7Ildp0Bz6Ot
 M4FfVMtJsAvcuW3tBJ/yq0G4ADZY/tOto6xFfqL2ay+gzvpRNVNfR+yZI4iJVrKNf5J0
 cOZCgBOXYN/GSk+gHZN0X+3EK3shvfAZBzCZ18Wr7vSIAYK7/mDplhj8nCDOhySOTZDA
 j3iKVOVB0m2GFVdSNeBQ/os5oljZdmY4sC+119rRSWRFASkSyofC4sP02VBf9mN4gEvS
 Gi1yktj4O8oX5yopWtNFcog4TcmuJqP+6HuhOc4L10E4LLCJd3P90Htt18Q2g8ydCJGo
 xooA==
X-Gm-Message-State: AC+VfDwwJraVqyiXD4NcorSlS6Fgobx7YhQlZsFc4qH2S/UgFT5ngXFx
 pH12nPMq2CH7/Q7FTROoXZb3hm2Yip6ehveraVIQx6jylDj2Fa8uK2z55+1rcWIjLn0NvAksFHV
 cW9l50d2ACU3UXKI=
X-Received: by 2002:a05:6a20:6a25:b0:126:7648:1be8 with SMTP id
 p37-20020a056a206a2500b0012676481be8mr17699097pzk.35.1688006918041; 
 Wed, 28 Jun 2023 19:48:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Ecd1/jcjrsVNXAbYHKiW5joDn22swApi3xC9Hp2Nptje7+C8ufa9y0pEDY2tMCBQluJgbCQ==
X-Received: by 2002:a05:6a20:6a25:b0:126:7648:1be8 with SMTP id
 p37-20020a056a206a2500b0012676481be8mr17699076pzk.35.1688006917711; 
 Wed, 28 Jun 2023 19:48:37 -0700 (PDT)
Received: from smtpclient.apple ([203.163.234.183])
 by smtp.gmail.com with ESMTPSA id
 j11-20020a63ec0b000000b00502f4c62fd3sm8073728pgh.33.2023.06.28.19.48.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Jun 2023 19:48:37 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: ARI and igb emulation
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <2E460631-2E82-46CA-AA3B-C31E99396661@redhat.com>
Date: Thu, 29 Jun 2023 08:18:32 +0530
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Lei Yang <leiyang@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E86B95F-FBCC-409C-9D33-B3E09BCE1D36@redhat.com>
References: <ACCE3C63-50B6-4310-9DF6-F1BE759F5B1E@redhat.com>
 <1865ce6f-842c-d5dd-b43f-c2f36710c791@daynix.com>
 <0cd0195d-cbc2-4727-4a54-6acf743303eb@daynix.com>
 <2E460631-2E82-46CA-AA3B-C31E99396661@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
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



> On 28-Jun-2023, at 6:19 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
>=20
>> On 28-Jun-2023, at 6:15 PM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>>=20
>> Adding CC.
>>=20
>> On 2023/06/28 21:24, Akihiko Odaki wrote:
>>> On 2023/06/27 23:32, Ani Sinha wrote:
>>>> Hi :
>>>> I am proposing a patch in QEMU [1] which may or may not break ARI =
but I wanted to give my best shot in making sure I am not breaking =
anything with ARI enabled. I see that your igb emulation code enables =
ARI with its SRIOV emulation. I ran the qtest and avocado tests that are =
mentioned in [2] and they both pass. Is there anything else/any tweaks =
that I should be doing to make sure I am not breaking ARI with igb?
>>>>=20
>>>> Thanks for information,
>>>> Ani
>>>>=20
>>>> 1. =
https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg05478.html
>>>> 2. https://www.qemu.org/docs/master/system/devices/igb.html
>>>>=20
>>>>=20
>>> This indeed resulted in the following error message with igb:
>>> qemu-system-aarch64: PCI: slot 16 is not valid for igbvf, parent =
device only allows plugging into slot 0.
>>> To reproduce the issue, add the following to QEMU command line:
>>> -device pcie-root-port,id=3Dp -device igb,bus=3Dp
>>> And enable 7 virtual functions on the guest. For Linux, see:
>>> https://docs.kernel.org/PCI/pci-iov-howto.html
>>> You may only enforce the slot number restriction only for devices =
without ARI.

>>> The slot number is assumed as 0 when ARI is enabled if I understand =
correctly.

Yes, in linux there is something like this:

device =3D pci_ari_enabled(dev->bus) ? 0 : PCI_SLOT(dev->devfn);

We will have to make similar changes in QEMU to fix all PCI_SLOT =
references and adjust code accordingly.=


