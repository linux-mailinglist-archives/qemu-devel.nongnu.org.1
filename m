Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0773E74ABBB
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 09:20:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHfkz-0003vB-M6; Fri, 07 Jul 2023 03:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHfkx-0003uM-9w; Fri, 07 Jul 2023 03:19:55 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHfkv-0006lQ-EX; Fri, 07 Jul 2023 03:19:55 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a36b309524so1460987b6e.3; 
 Fri, 07 Jul 2023 00:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688714392; x=1691306392;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HLoyEcGFP3OeRHinpegdbi9huoY9RipcCCkgUvponis=;
 b=D4R7CxxLwQpX3dIlSkQB5sMQxNU6+Xxvzj7Ia60j/Yy694QkxwIO6vAAIa0f9z68Te
 oYEkjbDtICava3mETWA9N0htbceCwLRMqYgo7XcgR6vY47VU4djtXAl8Scqwu89krLn2
 op/1MEhmDXVvNLv9Fw1Fap+K+zRvAhDaYwRGKeLOqiRBcsHWiGE18IzgVrznu0xOF52J
 1V5+0iajbnY+oPA4Zw1mGco7mZa4jO0OuCuFBdKZHgLukgrBEsuh+xW7Co2Kfc3B8Ga5
 N4z4Om+BwzelV2TBu19xE4qHeGsdlxLc/1/1W3ZazA5u5o6+5O2/RHti+G35QRHLDd1Z
 uDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688714392; x=1691306392;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HLoyEcGFP3OeRHinpegdbi9huoY9RipcCCkgUvponis=;
 b=MTdhywVGEai0MQsxrzZjXD0EduG/paeFkJt0DpIf8L1RKvxy4fRcveOq6hncSg8sa5
 pVQl4rNSx0Q8+7OM20s58Bfe3lNTJi7z+iSK7EJt7TTqEV7tf5pf+vrW+u0IqJugCxi8
 e227ATLcixytY250CO6NQrdfru3UR5KWgbSz8c/6VHKJR66F7bKjfgK+nVLnXI1l5ZZz
 08iQtrQYV+sDCaRSwv2FhuZjCmdybX8bI8f3ItDv1JQKg/DD+GG4H7gLpM1VgR7Wb+Oz
 /9/RuCjy3Rom0tVEnjP/tFx9GQvn6cLWRiZzsmvpd7jQi5qTTlkBGZQbcnIJRU6qWXr3
 3vpQ==
X-Gm-Message-State: ABy/qLZkJ7jXRhxyrriehmI9KqlWn7Q0xzi09dd8BPyxybFmfJ4H5s2C
 stHit8GUeFnjMHs71oi30UK4DdybUm8=
X-Google-Smtp-Source: APBJJlEMj5izZOINweHL9pW8QQv3pVEOgWmlbPA7J+DtQd+gIy46mxGOeaGs74IGHc5w9jBkIsimGQ==
X-Received: by 2002:a54:450f:0:b0:3a3:6f89:5de1 with SMTP id
 l15-20020a54450f000000b003a36f895de1mr3821653oil.49.1688714391819; 
 Fri, 07 Jul 2023 00:19:51 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-19.dial-up.telesp.net.br.
 [201.69.66.19]) by smtp.gmail.com with ESMTPSA id
 4-20020a544184000000b003a361fbec60sm1388334oiy.47.2023.07.07.00.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 00:19:51 -0700 (PDT)
Message-ID: <7ff056fa-3e01-1d81-da8d-6aa7360fa949@gmail.com>
Date: Fri, 7 Jul 2023 04:19:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH v3 0/4] PPC440 devices misc clean up
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: philmd@linaro.org
References: <cover.1688641673.git.balaton@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <cover.1688641673.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
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

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

On 7/6/23 08:16, BALATON Zoltan wrote:
> These are some small misc clean ups to PPC440 related device models
> which is all I have ready for now.
> 
> v3:
> - rebased on ppc-next moving already reviewed patch to front
> 
> v2:
> - Added R-b tags from Philippe
> - Addressed review comments
> - Added new patch to rename parent field of PPC460EXPCIEState to parent_obj
> 
> BALATON Zoltan (4):
>    ppc440_pcix: Stop using system io region for PCI bus
>    ppc4xx_pci: Rename QOM type name define
>    ppc4xx_pci: Add define for ppc4xx-host-bridge type name
>    ppc440_pcix: Rename QOM type define abd move it to common header
> 
>   hw/ppc/ppc440_bamboo.c  |  3 +--
>   hw/ppc/ppc440_pcix.c    | 21 ++++++++++++---------
>   hw/ppc/ppc4xx_pci.c     | 10 +++++-----
>   hw/ppc/sam460ex.c       |  8 ++------
>   include/hw/ppc/ppc4xx.h |  4 +++-
>   5 files changed, 23 insertions(+), 23 deletions(-)
> 

