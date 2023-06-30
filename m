Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2250C7436A9
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:11:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF98s-00044u-SU; Fri, 30 Jun 2023 04:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF98h-0003bR-8e
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:05:59 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF98R-0001Dd-DA
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:05:45 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9891c73e0fbso274281066b.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 01:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688112341; x=1690704341;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W548W94gIUu0+BCL3qmZZRt6kia8R4D6w9rTpVoB54E=;
 b=rDoRNA8g9LkDkME65XMOtgtbGNa18T3HmmYdeksI4bBRo1zfZV2OBZoKtq708q+FBx
 ioeVq1H/JglA9rCllshVJDnHLvANy/rzN3zOtJxfM/q9tqKGzF98A7CV4G5Xq1j1+fnK
 relzBY8LJC+hiyCApuzJagYVTRQ0VbE5uUf4NhPB66Ly+W10TURpFff08gWiz6y2qdpP
 Glk58ipWgXOx5fsmQLT2zCp4IcsZ/HLj/IcE7DXC1hzBus/YTYod5KX/BZ2jaJvaQXk+
 +whryVEn3Sz8lJZUeOF7yOBp9+LWnRkn6jCqjSLw9qck60ZhouCXhIRgsPad0M0Zr9tW
 mQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688112341; x=1690704341;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W548W94gIUu0+BCL3qmZZRt6kia8R4D6w9rTpVoB54E=;
 b=g/KCLS18/glIBiFXZyMYpOLKRCtcl3G0639XRxaTL4BVOYWbpaLfyubNghMnjkXOgP
 7naZ8E2A+B94KtS0Xy+gu+vvos1DfBITbyaOmWKqTWTV6aNCsU+LymtBqfrGChF1sy2a
 Xe2i0OO4Q7U7Icfsc+OkZdF02C+klcO0CDR174CU/kqZCu8Ew/af6Rxpd6gI9SDvuEq+
 vwTJUIlWHWp3PxkBY0YOk7q4l7SSROv95+ZRUqMZR3xQBO8zUnng6LIrokHTfJQTRKfi
 95I1az5JDJtT1KvOTWpKgSTPG8KaGA18fnBIVFxa+5EFA9SaX1wMd3+b74DzKqMoA8oj
 tngA==
X-Gm-Message-State: ABy/qLZ3dy5QXxFUFjuWknA4HeXW0B9lnBgCDdynUirJ6JLCGApVKSY3
 NT2GsnWsYicVyav0EmehsQw=
X-Google-Smtp-Source: APBJJlGQgvHJJleDfcXmbEhxCodIf5NF+jBIVZef5dv1E0voP2B1/gg4F/Ep9yW9haB1kJRVUkSrwQ==
X-Received: by 2002:a17:906:7fc5:b0:991:7874:e882 with SMTP id
 r5-20020a1709067fc500b009917874e882mr1955534ejs.3.1688112340774; 
 Fri, 30 Jun 2023 01:05:40 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 e23-20020a170906045700b00992c92af6f4sm983307eja.144.2023.06.30.01.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 01:05:40 -0700 (PDT)
Date: Fri, 30 Jun 2023 08:05:29 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Olaf Hering <olaf@aepfle.de>
CC: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2] piix: fix regression during unplug in Xen HVM domUs
In-Reply-To: <20230630092921.392b302d.olaf@aepfle.de>
References: <20210317070046.17860-1-olaf@aepfle.de>
 <4441d32f-bd52-9408-cabc-146b59f0e4dc@redhat.com>
 <20210325121219.7b5daf76.olaf@aepfle.de>
 <dae251e1-f808-708e-902c-05cfcbbea9cf@redhat.com>
 <20230509225818.GA16290@aepfle.de> <20230626231901.5b5d11c1.olaf@aepfle.de>
 <c939b695-2b68-085a-0f19-108ecdcc1a05@redhat.com>
 <5DB37FA5-41DF-4ED6-8C8A-CDDD6F276F42@gmail.com>
 <20230627140740.2736f6e8.olaf@aepfle.de>
 <4F5609FD-4A89-4450-89E2-3311CC5A9317@gmail.com>
 <20230630092921.392b302d.olaf@aepfle.de>
Message-ID: <367317C5-DB65-40EF-B45B-97E0E802A994@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
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



Am 30=2E Juni 2023 07:29:21 UTC schrieb Olaf Hering <olaf@aepfle=2Ede>:
>Wed, 28 Jun 2023 09:27:16 +0000 Bernhard Beschow <shentey@gmail=2Ecom>:
>
>> Would you mind sending a patch fixing the BMIBA register to be reset as=
 32 bit?
>
>Will do so next week=2E

Great! Perhaps it could then be picked up by maintainers together with my =
other IDE changes=2E

>
>Are the specs for this chipset available,

Yes=2E Have a look for piix3/piix4 here: https://www=2Eintel=2Ecom/design/=
archives/chipsets/440/index=2Ehtm

> does this address really need
>to be accessed in quantities of u32, or is perhaps u16 required? I guess
>for this specific bug pci_set_word may work as well=2E
>
>Either way, commit e6a71ae327a388723182a504bb253777ec36869b was wrong=2E
>Does the comment added in this commit mean, the quantity is really u32?

As per the datasheet (and per the comment in the source code) the BMIBA re=
gister is 32 bit=2E Search the datasheet for the register name and you'll a=
lso find its default value which it holds after reset=2E

Best regards,
Bernhard

>
>
>Olaf

