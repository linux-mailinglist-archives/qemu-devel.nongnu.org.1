Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E777452EE
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 00:27:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qG5W1-0007O5-OW; Sun, 02 Jul 2023 18:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qG5W0-0007Nn-2a
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 18:25:56 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qG5Vy-0006xF-EX
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 18:25:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso22017165e9.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688336752; x=1690928752;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brJ53WepNRWQm12rssTXlqHMNSqdSpQ3iotpQXlBldw=;
 b=oFqiyjgCuw2kW5i4vvmVZhxFlTsWp8F5rVJGhXKMmfgN63339ooPR9xS3m/kDP8SfX
 OLuDVL953iL23YmgupptKXaWSzl4RBQsMyAK3WJz5PKjjnmy4n2s+ljEtdKuSuzPwuFW
 IiKPjjm+JWazTicIUT+52zRkm237ipHDrqVC/hXxyJj6ZQbg2Vp79R0ZYIVtdhdrtOyR
 byn/DqsvsFuhpQIzNlpKDupg8y3fqzBMmtI2KyDlNXtfJf/UJzWmYDn7UlDEfOd4pQ0i
 zILn3nJMcFa/nRE6m6JCbc2a/wpYQSo2p4dW87txGhyY9C/2hCiK99ozy7xrdPUcLivU
 aoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688336752; x=1690928752;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=brJ53WepNRWQm12rssTXlqHMNSqdSpQ3iotpQXlBldw=;
 b=kAX4qmRX5INy2oTAMza35vhhEh3lxhoFpcL1kvzIFwsGL3SziKxSY+Vzx2/KPXvb9L
 /gHY60lKDntoVanHU4ZvxGT3e2TcPpjjOESB1wFqr5eUaViBs4KIKvYrfSO3Csyr8Y2c
 1MRmVJ0X70a1XVQPHxak0NKrHH2p3N6MpSxCGCZNbM86DRnyXE3NelJMyWL5aIv2foCw
 d0IW0PhaOtCTBPA4S8vS67KNiO7uUqo9+pclTj5Vcw4wibP/InPKJ4EIStJcGf6ysbQw
 yWIxJ6mverRtun3MJFTTCFu0nXFIhNj7v6uv10ohq1QEiEX3N22Ud4H+fbIoqwr8WRue
 PNPw==
X-Gm-Message-State: AC+VfDyrAQT4OkhviopNGvb+zQaP2O9dohc/F5MaWlx64o1DiXJTbyHT
 8DLDoyePGcP00z+mYOsBi9s=
X-Google-Smtp-Source: ACHHUZ5rXCXbjGsIoh5YArs96eCY9/yS9S2QYFz0k3XpXbCvtiSaj9YvSmw1rVnMHxW1fJOK8nsAZA==
X-Received: by 2002:a7b:c847:0:b0:3fa:9348:51a8 with SMTP id
 c7-20020a7bc847000000b003fa934851a8mr6265209wml.23.1688336752463; 
 Sun, 02 Jul 2023 15:25:52 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-014-031-053.89.14.pool.telefonica.de.
 [89.14.31.53]) by smtp.gmail.com with ESMTPSA id
 d1-20020a5d6dc1000000b00304adbeeabbsm23974422wrz.99.2023.07.02.15.25.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jul 2023 15:25:52 -0700 (PDT)
Date: Sun, 02 Jul 2023 22:25:48 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>
CC: Olaf Hering <olaf@aepfle.de>, qemu-devel <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2] piix: fix regression during unplug in Xen HVM domUs
In-Reply-To: <b562eb6f-c7ad-dec9-d92f-266ca8561170@ilande.co.uk>
References: <20210317070046.17860-1-olaf@aepfle.de>
 <4441d32f-bd52-9408-cabc-146b59f0e4dc@redhat.com>
 <20210325121219.7b5daf76.olaf@aepfle.de>
 <dae251e1-f808-708e-902c-05cfcbbea9cf@redhat.com>
 <20230509225818.GA16290@aepfle.de> <20230626231901.5b5d11c1.olaf@aepfle.de>
 <c939b695-2b68-085a-0f19-108ecdcc1a05@redhat.com>
 <5DB37FA5-41DF-4ED6-8C8A-CDDD6F276F42@gmail.com>
 <20230627140740.2736f6e8.olaf@aepfle.de>
 <4F5609FD-4A89-4450-89E2-3311CC5A9317@gmail.com>
 <CABgObfamZEHv0W3B6kPXGTiT1f2G__S=Bi1-_PYeSomsiVFaFg@mail.gmail.com>
 <3987B0DB-46F2-49F1-AEA5-B88BC61A633F@gmail.com>
 <b562eb6f-c7ad-dec9-d92f-266ca8561170@ilande.co.uk>
Message-ID: <BD839728-D519-42C7-BFE9-CD15CABF09C4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
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



Am 1=2E Juli 2023 11:58:57 UTC schrieb Mark Cave-Ayland <mark=2Ecave-aylan=
d@ilande=2Eco=2Euk>:
>On 01/07/2023 10:53, Bernhard Beschow wrote:
>
>> Am 30=2E Juni 2023 08:48:02 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>>> Il mer 28 giu 2023, 13:28 Bernhard Beschow <shentey@gmail=2Ecom> ha sc=
ritto:
>>>=20
>>>>=20
>>>>=20
>>>> Am 27=2E Juni 2023 12:07:40 UTC schrieb Olaf Hering <olaf@aepfle=2Ede=
>:
>>>>> Tue, 27 Jun 2023 10:12:50 +0000 Bernhard Beschow <shentey@gmail=2Eco=
m>:
>>>>>=20
>>>>>> The BAR is a 32 bit register whose default value is 0x00000001=2E I=
 think
>>>> what's supposed to happen here is a pci_set_long() rather than a
>>>> pci_set_byte()=2E
>>>>>=20
>>>>> Indeed, the u32 at that address changes from c121 to c101 with the
>>>> current code=2E
>>>>=20
>>>> Neat! Would you mind sending a patch fixing the BMIBA register to be =
reset
>>>> as 32 bit?
>>>>=20
>>>=20
>>> I think we should also check why writing the command register is not
>>> disabling the BAR as well=2E
>>=20
>> So IIUC the BMIBA register is managed internally by QEMU's PCI code and=
 we shouldn't have to mess with the register at all=2E We should actually r=
emove the explicit reset of BMIBA, correct?
>>=20
>> I've tried debugging the PCI code when working on the VIA IDE controlle=
r to understand it better=2E But despite QEMU being compiled with --enable-=
debug it seemd to be compiled with -O2 still, making debugging quite hard=
=2E I'm not sure if any compile flags leak into my build environment though=
=2E
>
>Certainly --enable-debug normally does the right thing when building QEMU=
=2E If you want to double-check the compiler flags in use to see if anythin=
g from CFLAGS/LDFLAGS is getting picked up, use "make V=3D1" after configur=
e which outputs the full command being used during the build rather than ju=
st the summary=2E

--enable-debug does the right thing indeed=2E The error was on my side=2E =
Solved!

Thanks,
Bernhard
>
>
>ATB,
>
>Mark=2E
>

