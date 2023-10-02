Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF427B56CE
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 17:41:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnL2F-0004a1-5j; Mon, 02 Oct 2023 11:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qnL1u-0004PL-Mk; Mon, 02 Oct 2023 11:40:29 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qnL1p-0003Wh-Gk; Mon, 02 Oct 2023 11:40:15 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c61bde0b4bso106595465ad.3; 
 Mon, 02 Oct 2023 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696261211; x=1696866011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rjvmDqFv4orrfC95p0yacDFvrrxG21haWHxoPMQSPZY=;
 b=ewt7S72uXBsHr42S0xUbMYkjdoOP1nzfO+WR52pvLKWZF0yLDlTv9akkBXTdHU/392
 6L0DD1ViTKSw+9vB2Ixz8Zu3gaqSy5rmpsM4XbvDLja8sS1V/IFWwe61BAxLCa/NRjlI
 4QUo2TM1OYihC4S7MMEuuxxg7fdXAemXfw7jxY2G+5CwV0PNM4/eUZl2se7CJ+Nw3UNK
 UT/llfkvssK+jXcoc14kJ6r+CUQcu726k5Iyu6LiKGtSzQFw102OGxq+fZBXLnIbEKbz
 xI3adtJ68TlwutuaLQmbvLxpuzfGP0nW+J4h02D75Bh1YqyH/d4exWzyRDJzJDXvHdvH
 1oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696261211; x=1696866011;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rjvmDqFv4orrfC95p0yacDFvrrxG21haWHxoPMQSPZY=;
 b=xTo7n4Q/iWDeP7bAmyS8IimG5Gjtg11GvYOs6JpYZsuwpyfX3lq3BWR9zAdE7YJucN
 PUpwDT8wxf8UDs9ozkkBXF9DbB9zohQPRhd+3IOmmt4YT/BpnBk3vDLg7frubY/9UiPi
 cvnZVOuYIAtmTqgnO4onX+XBnALPZH5pqqEkRZHUhG0Zwmi/iaTX/45wvHhh7KMETy/T
 qW65J62w+p2zQy2l6PJPtUdqXzfXBJTjH2f59IxyQVD3maIFaMPn3UxN3dJM1CA2O5PZ
 lbIjQLAftj5vGgfGKLxNseoUnIo4X6v12u6TelojEOQcIXH9gpksWRFGKnmfR0jzf0D9
 nFVQ==
X-Gm-Message-State: AOJu0YyoaD54VlncjqGODGjfb2O4tsqHIM6vEDWm0BCdes2SjThCcRvq
 KW1Cr1L/s8PKKUVAjIFsUj6gea5VtyA=
X-Google-Smtp-Source: AGHT+IGMP6S04rhEQVl4H8OhAsZAx/HHomTmh1vXA7REIDm99/02s7yZnkvAOkKTwT/3OLXiSoJiIQ==
X-Received: by 2002:a17:902:7d92:b0:1c3:2532:ac71 with SMTP id
 a18-20020a1709027d9200b001c32532ac71mr11987531plm.31.1696261210968; 
 Mon, 02 Oct 2023 08:40:10 -0700 (PDT)
Received: from [192.168.68.107] ([177.94.15.124])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a170902ed4300b001bdd68b3f4bsm14009201plb.295.2023.10.02.08.40.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 08:40:10 -0700 (PDT)
Message-ID: <a46b7525-1110-bc25-0bf8-85a222fa7892@gmail.com>
Date: Mon, 2 Oct 2023 12:40:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6/8] MAINTAINERS: Add fw_cfg.c to PPC mac99 machine
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20231002122326.365368-1-clg@kaod.org>
 <20231002122326.365368-7-clg@kaod.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20231002122326.365368-7-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=danielhb413@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-2.321,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/2/23 09:23, Cédric Le Goater wrote:
> The hw/ppc/fw_cfg.c file contains the implementation of
> fw_cfg_arch_key_name(), used by the common nvram model. List it under
> mac99 machine next to the mac_nvram model.
> 
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b3ba402f7943..1f72931ac2a4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1387,6 +1387,7 @@ F: hw/pci-bridge/dec.[hc]
>   F: hw/misc/macio/
>   F: hw/misc/mos6522.c
>   F: hw/nvram/mac_nvram.c
> +F: hw/ppc/fw_cfg.c
>   F: hw/input/adb*
>   F: include/hw/misc/macio/
>   F: include/hw/misc/mos6522.h

