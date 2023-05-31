Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFB9718BBE
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 23:23:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4TG2-0008Gh-Tj; Wed, 31 May 2023 17:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4TG0-0008GG-Ax
 for qemu-devel@nongnu.org; Wed, 31 May 2023 17:21:24 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4TFy-00035o-Mh
 for qemu-devel@nongnu.org; Wed, 31 May 2023 17:21:24 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f6e1393f13so1299535e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685568080; x=1688160080;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w3SE6tJtRpbm+//75LKhdXLBcIc9bgW7Gbbx8WgHG3A=;
 b=nf99CFSgXHTPN/OoyXRMAVT+nScGP2jotdIvTMwJghDYei8u/J0XdmGMJx+H1kPCVO
 aBIasxnhPsTC/Pysuvp319U1FpKPXCzqvlheSVVV30mRy7vb3tBLJNX6QutFY4PxKqwd
 Ot0Fu6MLp3fG4n2d5KGMN0WDtAjSTYsGsqZFlYO5Cu02ue0h0ddqlbL7b6PVJCAQJ680
 Py9GY1RQkThUQojcQFD1Ili6v8345/AacvheY417R1WyKIavufvUv0mK18AldwVGnV0r
 r5QW+UX/chhx4e8Xm4fsx7GAgqEtgwlsgPqbnA9kXW5XTbWElzNX6ITrVWRmOkG1iXzc
 RC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685568080; x=1688160080;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w3SE6tJtRpbm+//75LKhdXLBcIc9bgW7Gbbx8WgHG3A=;
 b=DTMwTnn4Nzj8TTffV1UHmuOKDgg+8SYcAFxwufZpDtFDQt9Sr1J0Rikb77HVtxIr7g
 cDB9Z5z03ugI5tFjMo4It2FgjXdpDtdxs6Q9eaPviZmRG5ECFRQIHgnd1oasSHlLdRx5
 qbZUdfyWoT15u1qUgz8gatry6BJYz8pEBIw/frJKL37WSaxTw2x52sEvbrO9CEUwPlbf
 hM0ByyBPbgjLApo8zq3WjqIJzDLOnSZrrtp17/uA05KQ0iFFGyHxsQEs8OGMPaCDHWrS
 HjHGWX8aMhyoWOx4RD5wERwE98si4jPIb7agwzL8NsLh+tgby2cjDx4QbiuD0tYw4C50
 E7Yg==
X-Gm-Message-State: AC+VfDzENjGcS4BRloeBD2o5OPILpV7ZnuWYJH8adGXKfDn5KF0CDvYD
 0AAmgOeZM9ZSZwgUEaeYA/zm8A==
X-Google-Smtp-Source: ACHHUZ6Li7HaXFIqaQXtSDZ10n5DFSshqmLhc0KsnGexu3nLDU1Ze/gi/JuxNrqM8iutIHbQ5AO7bA==
X-Received: by 2002:adf:e682:0:b0:309:4ba8:86a0 with SMTP id
 r2-20020adfe682000000b003094ba886a0mr242744wrm.17.1685568080595; 
 Wed, 31 May 2023 14:21:20 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 x15-20020adfdd8f000000b0030ae3a6be4asm8019718wrl.72.2023.05.31.14.21.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 14:21:20 -0700 (PDT)
Message-ID: <94c319f8-ce74-9deb-5693-e2c9191765d9@linaro.org>
Date: Wed, 31 May 2023 23:21:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/7] hw/ide: Extract bmdma_status_writeb()
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20230531211043.41724-1-shentey@gmail.com>
 <20230531211043.41724-6-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531211043.41724-6-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 31/5/23 23:10, Bernhard Beschow wrote:
> Every TYPE_PCI_IDE device performs the same not-so-trivial bit manipulation by
> copy'n'paste code. Extract this into bmdma_status_writeb(), mirroring
> bmdma_cmd_writeb().
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   include/hw/ide/pci.h | 1 +
>   hw/ide/cmd646.c      | 2 +-
>   hw/ide/pci.c         | 5 +++++
>   hw/ide/piix.c        | 2 +-
>   hw/ide/sii3112.c     | 6 ++----
>   hw/ide/via.c         | 2 +-
>   6 files changed, 11 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


