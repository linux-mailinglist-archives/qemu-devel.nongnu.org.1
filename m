Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF4881B986
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 15:28:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGK1K-0003oV-1r; Thu, 21 Dec 2023 09:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGK0u-0003o9-BA; Thu, 21 Dec 2023 09:27:04 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGK0s-0006Dx-OO; Thu, 21 Dec 2023 09:27:04 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54f4f7e88feso1088077a12.3; 
 Thu, 21 Dec 2023 06:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703168817; x=1703773617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4DV0p+5dY9XfZax4X4ugZlGw/VNGQEtAi5qdKOkX7Y=;
 b=Nx9VRqO8Ex/pj+JSERKPOJoyJ/ns9Yvj7A1MOAwUrr0SaP0csvYkfALJAxmMIpoHle
 GlBD2k5LgCQzrYAjl9iw1ls1aAqnPeR5uUHWuWw/iV8zDFQecuMtD3o4z5XGpqxbgFus
 Eu8DrbF0o87mDnxxTgPkUgHwahPFKK8bwQUaGIpBp02hWKicoNhOaa+kO51wzCvbrUgj
 qtacOMrAVOX+3+XP6oQfkNtK59cSMjPzepWSH7JB0jlFVOgklBj8+meDPAcK9ctLuzNs
 7L2cqdOjTKicTHYL03EKusxXV22WvD7jeL1mSggAXFdxbK9mJPcAYUJ/Dbg84fY1xE0W
 HM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703168817; x=1703773617;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4DV0p+5dY9XfZax4X4ugZlGw/VNGQEtAi5qdKOkX7Y=;
 b=tAafa1b4rqxuZHU6Jfeppj8G6nzo1g7FTa2O1hq3TNmR3sHq4wOIxiweTriNrv3dQv
 3kZ1LJ++CmQabWbzSy5iHLsVTYXrJunhOH1GthRyFCDPUDHFYG3ibS2o/yGKaKtTS0ak
 e7I1EQRDBcHxc1YxepOGbDF9ET5cgCob8Qyzyl4DPmIierKqtkZt6Z35seA/e1NZi6n/
 9i8bdNOkuG6b9wS5lUelJ6oHCALrKV8AFCCNoqyG4THbWuxzO2qe6sMzFs8GFmcdUVcB
 rvFqPNkgJjBl+CGZfS/J0cnJOpkI868Iko3EwovkkSJ8l3VGG/dUT7MxDeonXUO5Kpk3
 SbVg==
X-Gm-Message-State: AOJu0YxGz1LXMKI+zQ/hdYRbft69yIF5u8/eWGFaGNSN1i2ry3LYxhbv
 wOrcGUu9o58OBDK6vcjTmnQ=
X-Google-Smtp-Source: AGHT+IGLzaIN/g2qEjb311Ir5k2440dG1R8bzUZkX7l6fFvwwc85p1h95JxuutWacARMKuiK2dAyXg==
X-Received: by 2002:a17:906:e247:b0:a26:a296:2bab with SMTP id
 gq7-20020a170906e24700b00a26a2962babmr921365ejb.118.1703168816516; 
 Thu, 21 Dec 2023 06:26:56 -0800 (PST)
Received: from ?IPv6:::1?
 (p200300faaf1724005cbed9e46dc30ccf.dip0.t-ipconnect.de.
 [2003:fa:af17:2400:5cbe:d9e4:6dc3:ccf])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a17090791c100b00a26af35c171sm145858ejz.0.2023.12.21.06.26.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 06:26:56 -0800 (PST)
Date: Thu, 21 Dec 2023 14:26:48 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_08/12=5D_hw/block/fdc-isa=3A_Imple?=
 =?US-ASCII?Q?ment_relocation_and_toggling_for_TYPE=5FISA=5FFDC?=
In-Reply-To: <42552a96-7db9-50a0-6a4c-76ecae98df35@eik.bme.hu>
References: <20231218185114.119736-1-shentey@gmail.com>
 <20231218185114.119736-9-shentey@gmail.com>
 <42552a96-7db9-50a0-6a4c-76ecae98df35@eik.bme.hu>
Message-ID: <DCB2D0F5-90E5-4C6A-9CCA-7864A1AFFD33@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



Am 19=2E Dezember 2023 00:09:23 UTC schrieb BALATON Zoltan <balaton@eik=2E=
bme=2Ehu>:
>On Mon, 18 Dec 2023, Bernhard Beschow wrote:
>> Implement isa_fdc_set_{enabled,iobase} in order to implement relocation=
 and
>> toggling of SuperI/O functions in the VIA south bridges without breakin=
g
>> encapsulation=2E
>
>You may want to revise these commit messages=2E What toggling means is on=
ly defined in the last patch but I can't think of a better name for it othe=
r than spelling out enable/disable=2E

I'll use enable/disable then=2E

> It's probably also not relevant in this commit message to mention VIA so=
uth bridges as this is a generic function not specific to that usage only=
=2E

I'll refer to SuperI/O chips rather than VIA specifically since I want to =
point out the distinction to properties=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> include/hw/block/fdc=2Eh |  3 +++
>> hw/block/fdc-isa=2Ec     | 14 ++++++++++++++
>> 2 files changed, 17 insertions(+)
>>=20
>> diff --git a/include/hw/block/fdc=2Eh b/include/hw/block/fdc=2Eh
>> index 35248c0837=2E=2Ec367c5efea 100644
>> --- a/include/hw/block/fdc=2Eh
>> +++ b/include/hw/block/fdc=2Eh
>> @@ -14,6 +14,9 @@ void fdctrl_init_sysbus(qemu_irq irq, hwaddr mmio_bas=
e, DriveInfo **fds);
>> void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
>>                        DriveInfo **fds, qemu_irq *fdc_tc);
>>=20
>> +void isa_fdc_set_iobase(ISADevice *fdc, hwaddr iobase);
>> +void isa_fdc_set_enabled(ISADevice *fdc, bool enabled);
>> +
>> FloppyDriveType isa_fdc_get_drive_type(ISADevice *fdc, int i);
>> int cmos_get_fd_drive_type(FloppyDriveType fd0);
>>=20
>> diff --git a/hw/block/fdc-isa=2Ec b/hw/block/fdc-isa=2Ec
>> index b4c92b40b3=2E=2Ec989325de3 100644
>> --- a/hw/block/fdc-isa=2Ec
>> +++ b/hw/block/fdc-isa=2Ec
>> @@ -192,6 +192,20 @@ static Aml *build_fdinfo_aml(int idx, FloppyDriveT=
ype type)
>>     return dev;
>> }
>>=20
>> +void isa_fdc_set_iobase(ISADevice *fdc, hwaddr iobase)
>> +{
>> +    FDCtrlISABus *isa =3D ISA_FDC(fdc);
>> +
>> +    fdc->ioport_id =3D iobase;
>> +    isa->iobase =3D iobase;
>> +    portio_list_set_address(&isa->portio_list, isa->iobase);
>> +}
>> +
>> +void isa_fdc_set_enabled(ISADevice *fdc, bool enabled)
>> +{
>> +    portio_list_set_enabled(&ISA_FDC(fdc)->portio_list, enabled);
>> +}
>> +
>> int cmos_get_fd_drive_type(FloppyDriveType fd0)
>> {
>>     int val;
>>=20

