Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C37CD744850
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 11:54:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXIG-0005OS-Jy; Sat, 01 Jul 2023 05:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qFXIE-0005OD-Ae
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 05:53:26 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qFXIC-0001ix-RD
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 05:53:26 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-98df3dea907so323186266b.3
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 02:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688205203; x=1690797203;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U6qzh5zT5TRYd5Sip4g9abjelR/5v1OLZh8dWj8GBAE=;
 b=g1lntXpKHUXhdYIGb1g2NFGLAg9i2q1sGxEt/vbVZeLtWuht/fvm9vwV1MLjKUwjkU
 oBauakppnvcoYODDuxCIFDW27tsbkAmV97KExEJ+esKI9lF0NATFWtezMBCCNDDlwLLS
 uxWFI19OAoe8qiLMwJeTqSnkpi8JvTrAXTtN5Wez5YTPfIArk8mIm/F1S4SngQLnG2DU
 HBThsEgZCVfXdPnf00KvUAYFQG2kX0p/T5O+vC1t3jjiSjsDhLEKKZ4hFnwrUOhhaH8b
 O2AZns8c6R5KXJIvqnEfC5tTTupGkpy8hJ1iWkxzQ//Y/RuyaV+JheQxKwn+2WL1126u
 9yoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688205203; x=1690797203;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U6qzh5zT5TRYd5Sip4g9abjelR/5v1OLZh8dWj8GBAE=;
 b=fCVI4eEiQLFFs2JrOG9GBYEcjhm43BsgC3YEwNSuv9n7yaPZOEIAvpAfdMPF4L/sm7
 YXpVpFI+sswzCEBQoStnaK5L0QSxldEcbfMDYeuHAWaUHioTZZhro0ZLtW3DzXE3MnP7
 su4x3F2BLKxDY1Wg15LLz2toeYpF7aoIBTlM+X4hdU42igaWyMj9IFTmBW4G3LkSaRDi
 hJxP2Ccwe69NLu2/dy2GlPgU51JFFllxk6Mo0ljyuNnALxMctXnWO2dJUHfdPZLgRFeV
 na5NdH+2xJeoiBtkHsDamwbG7DYQRaqSl/Q8CFTcSqHKXKMaIWwahRFgDknoKhuVzxhI
 LLcQ==
X-Gm-Message-State: AC+VfDwJg8EbQVO7TBh+T/7ERRFf7/gvBtV8waoLzBT6VQKQuuH8X7uS
 XSXB9tL8d2k69U7eHemI+Lw=
X-Google-Smtp-Source: APBJJlHaXRaHawJGh8EcQEbPNbdz3SpEWVXwBe9z3waKnvOCHY7coyJ32yStWcR97XEgIaTVX5NGgQ==
X-Received: by 2002:a17:906:b7c8:b0:984:bd75:6a3 with SMTP id
 fy8-20020a170906b7c800b00984bd7506a3mr3527933ejb.58.1688205202474; 
 Sat, 01 Jul 2023 02:53:22 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-012-173-083.89.12.pool.telefonica.de.
 [89.12.173.83]) by smtp.gmail.com with ESMTPSA id
 v9-20020aa7cd49000000b005187a42b44fsm7606875edw.58.2023.07.01.02.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 02:53:22 -0700 (PDT)
Date: Sat, 01 Jul 2023 09:53:12 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: Olaf Hering <olaf@aepfle.de>, qemu-devel <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2] piix: fix regression during unplug in Xen HVM domUs
In-Reply-To: <CABgObfamZEHv0W3B6kPXGTiT1f2G__S=Bi1-_PYeSomsiVFaFg@mail.gmail.com>
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
Message-ID: <3987B0DB-46F2-49F1-AEA5-B88BC61A633F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
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



Am 30=2E Juni 2023 08:48:02 UTC schrieb Paolo Bonzini <pbonzini@redhat=2Ec=
om>:
>Il mer 28 giu 2023, 13:28 Bernhard Beschow <shentey@gmail=2Ecom> ha scrit=
to:
>
>>
>>
>> Am 27=2E Juni 2023 12:07:40 UTC schrieb Olaf Hering <olaf@aepfle=2Ede>:
>> >Tue, 27 Jun 2023 10:12:50 +0000 Bernhard Beschow <shentey@gmail=2Ecom>=
:
>> >
>> >> The BAR is a 32 bit register whose default value is 0x00000001=2E I =
think
>> what's supposed to happen here is a pci_set_long() rather than a
>> pci_set_byte()=2E
>> >
>> >Indeed, the u32 at that address changes from c121 to c101 with the
>> current code=2E
>>
>> Neat! Would you mind sending a patch fixing the BMIBA register to be re=
set
>> as 32 bit?
>>
>
>I think we should also check why writing the command register is not
>disabling the BAR as well=2E

So IIUC the BMIBA register is managed internally by QEMU's PCI code and we=
 shouldn't have to mess with the register at all=2E We should actually remo=
ve the explicit reset of BMIBA, correct?

I've tried debugging the PCI code when working on the VIA IDE controller t=
o understand it better=2E But despite QEMU being compiled with --enable-deb=
ug it seemd to be compiled with -O2 still, making debugging quite hard=2E I=
'm not sure if any compile flags leak into my build environment though=2E

Best regards,
Bernhard=20
>
>Paolo
>
>
>> Best regards,
>> Bernhard
>> >
>> >Olaf
>>
>>

