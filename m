Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB5F7E48CB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:54:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RD3-0005eL-IO; Tue, 07 Nov 2023 13:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0RCz-0005cw-T0; Tue, 07 Nov 2023 13:53:54 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0RCy-0002Xw-Cb; Tue, 07 Nov 2023 13:53:53 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-da37522a363so6355134276.0; 
 Tue, 07 Nov 2023 10:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699383230; x=1699988030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hkWsks7ta1p6k6GLqg2B714e4HOapj1CsWPsWZbXV6A=;
 b=G0mX0f9xMN2upw/eRRCkfazpHvw8u1n19fMjIJOjje+f6hDbYfbaDvoKg9p2srB+Bq
 Z8dO8nSPV/mK9RXON2ljYHbqjF3kqWaXcrt1kmsnubtMGufTX4oziinyMrXDSSFborEu
 HvawDHPIVkLjuqSDVMJazkzRTi4NxGuAwvdmE9OEHwtMW8HjWcdX9ccGucqvjbW64hNx
 c2+tqR7HCrCvqE0laktrXgOMFb4Tx/5TEJv3Lo+l+EqSXlRaiVaH1TFQX3AREc1zsnZB
 J7m93teeKF65NSIgFDQRdran8WMZzzLmFMemJsinbgiUE/CXF4rf01UToed03406Cizd
 fxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699383230; x=1699988030;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hkWsks7ta1p6k6GLqg2B714e4HOapj1CsWPsWZbXV6A=;
 b=SuLuD4PKhr/YmP523qM9IMlcZYpJ3XKDUKqLk5PnYcKRxpT7hcj8H8cq2+TWzZ/2J3
 OlnlQC4OBDYce6mfPGJFXr7jcw0NlUPeNp9sgpFL2UhO5FbBaeZ5fNJAU9RigpUiPUtB
 8HF3YnJWkeimwmi8LY/qzl1lbq/hnY8GufbBYP44/qcDO6QkDXmjKcSs+U4r56PW9adv
 l6/j6z7IXIEfHv/XsnS+l0oVXtslCpoQPI7mlRH3vPp5coFbB6seqMiE0VMlKB0UOdG8
 hyu7ncPkGaHJ1uYScwHsY50zzaGEC66VdWm760kujetOSyb9fQFSQn7Bri3UQe9RL7t+
 Ls2w==
X-Gm-Message-State: AOJu0YwHLkXFLEJ9zGqngHEk53Cl7pFUvcQz6xnTu+GNzBAeCgwWeoSO
 sQ/USmp08I+12w11RSsmNIUXqkZeQiA=
X-Google-Smtp-Source: AGHT+IHkx+hAaajzfBqZSZbASCeASP/H4KR0cLilCKS3nsdQTOxGa3MEjt5/9gaVonENxNhiyB6pQA==
X-Received: by 2002:a25:aaae:0:b0:d9a:5666:7ab5 with SMTP id
 t43-20020a25aaae000000b00d9a56667ab5mr33678363ybi.10.1699383229744; 
 Tue, 07 Nov 2023 10:53:49 -0800 (PST)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a259111000000b00d7b8a1074d4sm5286568ybl.57.2023.11.07.10.53.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 10:53:49 -0800 (PST)
Message-ID: <02dff207-a1b2-4705-8350-3ca5b5c65978@gmail.com>
Date: Tue, 7 Nov 2023 15:53:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] Add emulation of AmigaOne XE board
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, clg@kaod.org, philmd@linaro.org,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
References: <cover.1698406922.git.balaton@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <cover.1698406922.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=danielhb413@gmail.com; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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


Patches 1 and 3 from v7, and 2 from v9, queued in ppc-next.


Thanks,

Daniel

On 10/27/23 08:54, BALATON Zoltan wrote:
> Changes in v7:
> - Increase default memory size to 512m to match pegasos2 and sam460ex
> and it's a better default for AmigaOS
> 
> Changes in v6:
> - Dropped patch 1, now it's
> 
> Based-on: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
> 
> ([PATCH v2 0/3] ide: implement simple legacy/native mode switching for PCI IDE controllers)
> - Added Tested-by from Rene
> 
> Changes in v5:
> - Fixed avocado test
> 
> Changes in v4:
> - Found typo in comment in patch 1 so ended up rewording it again
> trying to make it more concise. Also take the idea of using
> range_covers_byte from Mark's patch
> - Added RFC patch for avocado test (untested, I don't have Avocado)
> 
> Changes in v3:
> - Update values, comment and commit message in patch 1 again
> 
> Changes in v2:
> - Update comment and commit message in patch 1 (Mark)
> - Fix irq mapping in patch 2 (Volker)
> 
> Regards,
> BALATON Zoltan
> 
> BALATON Zoltan (3):
>    hw/pci-host: Add emulation of Mai Logic Articia S
>    hw/ppc: Add emulation of AmigaOne XE board
>    tests/avocado: Add test for amigaone board
> 
>   MAINTAINERS                             |   8 +
>   configs/devices/ppc-softmmu/default.mak |   1 +
>   hw/pci-host/Kconfig                     |   5 +
>   hw/pci-host/articia.c                   | 293 ++++++++++++++++++++++++
>   hw/pci-host/meson.build                 |   2 +
>   hw/ppc/Kconfig                          |   7 +
>   hw/ppc/amigaone.c                       | 164 +++++++++++++
>   hw/ppc/meson.build                      |   2 +
>   include/hw/pci-host/articia.h           |  17 ++
>   tests/avocado/ppc_amiga.py              |  38 +++
>   10 files changed, 537 insertions(+)
>   create mode 100644 hw/pci-host/articia.c
>   create mode 100644 hw/ppc/amigaone.c
>   create mode 100644 include/hw/pci-host/articia.h
>   create mode 100644 tests/avocado/ppc_amiga.py
> 

