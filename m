Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CADE75E1BB
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 14:14:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNXxv-0001fJ-6C; Sun, 23 Jul 2023 08:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qNXxs-0001eO-QF; Sun, 23 Jul 2023 08:13:32 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qNXxr-0000RS-6B; Sun, 23 Jul 2023 08:13:32 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6b9b89627c3so2685902a34.1; 
 Sun, 23 Jul 2023 05:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690114409; x=1690719209;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UGrh1zB/pVwIat8zpIchypgdJDZ6k8/1zbDZDRGwRVk=;
 b=Z55NMq9FylEbdm+3EBkn7D3GNwVt+Nv5V09gukvZ9Ut3zHRAGyhYCP056ZaGU4WMcU
 Cny05aT59XN3XpbYpLEEw+nvugvU17DxSk/stdOrhzENqmBgmDDacPIA5EmfcBf+tOtU
 aLYx7bcUuC+ItjE1DrBgu4rzQ3nOlMtATnp91eKqBZf7CnQq++wE2M2uj75PjIHNeeCG
 vYVAlavwoKlxKHYFUcVaWxOEej4MfyWcLphHNZZbBLFOIB3kuDz8B1NTc6jOI6M7XJem
 wF9XzElatUpeMW479KXBw4M7hMg9OedsASMt3/kfepzI8nG4avgEMehLDSJIovyCwpQD
 feGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690114409; x=1690719209;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UGrh1zB/pVwIat8zpIchypgdJDZ6k8/1zbDZDRGwRVk=;
 b=FlU/UW2Q9zkrisJ8gqlmzWl9q7+Bl0PbY3vtq0ebUiJbsOmg3Lwsl2Dn1XsA3Nk26I
 oI8B4wN3LHgfGKV8PSksF7ncwUyiGt+L2jHUy1hoibWMuUTgKJKJdxaWJIcEpmmmJ0yV
 TWJl+iIQXg3arH6dpA/ICk0qLfVHLIB1t9/e0Y557JhHH8X/E1qiqb9lEEdIPWkockwg
 TLy6LwQ2ruk/TqSh6+vhlr2WQY37yHl3tfFgWjBP82PCwg9vzxb5yLh+18tlWOg8bnZk
 oulN3/shqeFr8lwCy1cSucXRDl62XzaLN/QmyxFzH5GXfBgZ/Roy7fiQbF9PcolmyK3i
 M8SA==
X-Gm-Message-State: ABy/qLYzyQ8kfiMXwwshVWGiEHUMHwlnDpxk4pzLzt7I2y9uBHFEY4JS
 p9eH2ErJDeumBei1WDrne0M=
X-Google-Smtp-Source: APBJJlGagM5dgUYe6rYWxmZ4ddiMYZPSQCubEbsWffdfuy5ax94rO8vtNGfpmswOyUYgGlvrN4iZcQ==
X-Received: by 2002:a54:4591:0:b0:3a3:9337:4099 with SMTP id
 z17-20020a544591000000b003a393374099mr6751437oib.56.1690114408772; 
 Sun, 23 Jul 2023 05:13:28 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-36.dial-up.telesp.net.br.
 [201.69.66.36]) by smtp.gmail.com with ESMTPSA id
 b8-20020a056808010800b003a463ded3a3sm3134223oie.53.2023.07.23.05.13.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 05:13:28 -0700 (PDT)
Message-ID: <2c2157ec-4736-9fee-691c-97fe081093e2@gmail.com>
Date: Sun, 23 Jul 2023 09:13:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ppc/pegasos2: Fix reg property of 64 bit BARs in device
 tree
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20230721221320.1311E7456AB@zero.eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230721221320.1311E7456AB@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.093,
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



On 7/21/23 19:13, BALATON Zoltan wrote:
> The board firmware handles this correctly following the Open Firmware
> standard which we missed. This fixes 64 bit BARs when using VOF.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---


Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>


And queued. Thanks,

Daniel

>   hw/ppc/pegasos2.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index 6475acfbed..075367d94d 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -781,7 +781,11 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
>           if (d->io_regions[i].type & PCI_BASE_ADDRESS_SPACE_IO) {
>               cells[j] |= cpu_to_be32(1 << 24);
>           } else {
> -            cells[j] |= cpu_to_be32(2 << 24);
> +            if (d->io_regions[i].type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> +                cells[j] |= cpu_to_be32(3 << 24);
> +            } else {
> +                cells[j] |= cpu_to_be32(2 << 24);
> +            }
>               if (d->io_regions[i].type & PCI_BASE_ADDRESS_MEM_PREFETCH) {
>                   cells[j] |= cpu_to_be32(4 << 28);
>               }

