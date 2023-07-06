Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4371C7492C1
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 02:49:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHDBI-0005RB-J9; Wed, 05 Jul 2023 20:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHDB8-0005Qp-8K; Wed, 05 Jul 2023 20:49:02 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHDB6-0005xY-2d; Wed, 05 Jul 2023 20:49:01 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6b74b37fbe0so134525a34.1; 
 Wed, 05 Jul 2023 17:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688604537; x=1691196537;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hCDXdhZZuCPWOq2URkfGwiulau0hdVBXSX3tRPjGmoE=;
 b=nGXTUOZaQ++W3g6dh9A2n2jFou9kRcOJfg4KLK9RT6WW6KQr1xxXltSom+Vjd64bt+
 P2HDUx4vxsvA7Ae6Bg79xp8Px9qLG9Eti3yFfme7syeKgzeZEy/JbqU2Zm6jtl6gUgw2
 9vXHWi6bl4u3JgYQVRF2qSbQ2LJnkKM559AgmZdfu+KUDCYRJ4byeY9zxViWI683/kVw
 DpRTyRTkyzxwRV0Aez3AFGU/p3QoJ7RhsrA8wLJtx+ELahspwRrIXyut37hctdiQ5AJ6
 tiIUrd6QTkQ7xZ1CFxCb7HrYfTx04y7hewgN4/Hs8t+PL74LpSvChsiryOlxe6YucT3Y
 +AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688604537; x=1691196537;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hCDXdhZZuCPWOq2URkfGwiulau0hdVBXSX3tRPjGmoE=;
 b=CdR5sNG4J2sDTcpvwhdkvDi5PSJTnbgPKLebSDE77bdnk3MUSeJ8T1kV6rx2u9wWvB
 0C3qzsLKJw4Ke1BuZOHEJ0jUmagXUiKfRU/C/9Zli6rlxUIEJNgVfTVP8TFe1K1SnxKA
 L1dGUGir8prDajPQCKsTimcbxBhYbQKdMN5eeO54GMc/T/0avXyOweGGLa/WUR/+5lbg
 7a7j30z52Km2QEc6M5RmDauioIGFhr9BV/RRAfAwZ50NJt1wdbIR4+lOk6WudCvOAdsB
 Gn1UhUOgd59zdkOvJd2Jj/EqR7LKicIShaghImsUyERj/0q17rmOOdGHiRC4d5hGbbgw
 IoJg==
X-Gm-Message-State: ABy/qLY6r0rHORpRa0g9WUmQNgJglYIONdGwFQnD5knJ1nM8Grct5N6p
 qh8LHz2tmvvkM6GbFhZp1j/QqnybRc4=
X-Google-Smtp-Source: APBJJlG+Ayr1jKM8Hb96L7Fzk1HI4rGU2nEmBVKViTQUvOFw+Nq3NS6szfeM8TpKWszIy0YQhTQtKA==
X-Received: by 2002:a05:6870:65ac:b0:1b3:d6eb:2b77 with SMTP id
 fp44-20020a05687065ac00b001b3d6eb2b77mr697998oab.13.1688604537343; 
 Wed, 05 Jul 2023 17:48:57 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 x12-20020a4ac58c000000b0056360466d3esm173850oop.48.2023.07.05.17.48.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 17:48:57 -0700 (PDT)
Message-ID: <d192a786-6019-f1d3-6491-c245527da417@gmail.com>
Date: Wed, 5 Jul 2023 21:48:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 00/14] PPC440 devices misc clean up
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <cover.1688586835.git.balaton@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <cover.1688586835.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.089,
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

Zoltan,

Patches 1-9 are queued. Don't need to re-send those.


Thanks,

Daniel

On 7/5/23 17:12, BALATON Zoltan wrote:
> These are some small misc clean ups to PPC440 related device models
> which is all I have ready for now.
> 
> v2:
> - Added R-b tags from Philippe
> - Addressed review comments
> - Added new patch to rename parent field of PPC460EXPCIEState to parent_obj
> 
> Patches needing review: 6 7 10-13
> 
> BALATON Zoltan (14):
>    ppc440: Change ppc460ex_pcie_init() parameter type
>    ppc440: Add cpu link property to PCIe controller model
>    ppc440: Add a macro to shorten PCIe controller DCR registration
>    ppc440: Rename parent field of PPC460EXPCIEState to match code style
>    ppc440: Rename local variable in dcr_read_pcie()
>    ppc440: Stop using system io region for PCIe buses
>    ppc/sam460ex: Remove address_space_mem local variable
>    ppc440: Add busnum property to PCIe controller model
>    ppc440: Remove ppc460ex_pcie_init legacy init function
>    ppc4xx_pci: Rename QOM type name define
>    ppc4xx_pci: Add define for ppc4xx-host-bridge type name
>    ppc440_pcix: Rename QOM type define abd move it to common header
>    ppc440_pcix: Don't use iomem for regs
>    ppc440_pcix: Stop using system io region for PCI bus
> 
>   hw/ppc/ppc440.h         |   1 -
>   hw/ppc/ppc440_bamboo.c  |   3 +-
>   hw/ppc/ppc440_pcix.c    |  28 +++---
>   hw/ppc/ppc440_uc.c      | 192 +++++++++++++++++-----------------------
>   hw/ppc/ppc4xx_pci.c     |  10 +--
>   hw/ppc/sam460ex.c       |  33 ++++---
>   include/hw/ppc/ppc4xx.h |   5 +-
>   7 files changed, 129 insertions(+), 143 deletions(-)
> 

