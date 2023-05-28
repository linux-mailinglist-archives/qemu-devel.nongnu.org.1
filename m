Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FAD713A9A
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 18:38:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3JOn-0007JB-Lc; Sun, 28 May 2023 12:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3JOl-0007Iy-Bb; Sun, 28 May 2023 12:37:39 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3JOj-0000or-Sa; Sun, 28 May 2023 12:37:39 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6af9dcc98f0so2015212a34.0; 
 Sun, 28 May 2023 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685291856; x=1687883856;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZGh0wPYavG9UnUhAzmA50yDBLWVfGqVVlQLV8dLsr+M=;
 b=O+D9dZsLVxmF0MKhLQSUmls6Y6D+Aff/nH6XSbXBszcJkSa/kQXeHsDh79H9TVAeXk
 66rjz/VtWWxsWQj7HoAIZbpsmW4xCrD16RIai1dQp66Wtcw0dkIHJl8TRN0FTRbDaua/
 ck5x7sG45jOjl46cXCQHqTy4oRKa3FqQExwpHCB9xnLiSl31y8MnBIZr/YmzIJ19zu71
 SJOFA1s74EgODEy8ngUrj4FhCnlpaFQrIWXrRMKs4BhPiAvF4iC13jEi0fFCGbIidYUW
 7ZnPfaYNY4XmNje/FokgzvpZ2gH64Ick3Y1WxnMikNce+llOUGGiVqVjRoT10ahuoL+m
 XY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685291856; x=1687883856;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZGh0wPYavG9UnUhAzmA50yDBLWVfGqVVlQLV8dLsr+M=;
 b=Myw+lFSruEFkWSkEvg5DbF6CZ23KY9FXDF7yVzUGhO8vYvvcczxI0TgOQ7Ej9RrVG/
 VVCJgkziITIT5Kha8ffanOF6F7WV2R3x7885MkH1AplId5e4wc+5RjfrsSHSCNSF9zP/
 07apvk4J/gt8sD8O/fzwJ65dvXBFPTo5AwBDAV9Wl7s9FfMIn+VK2pcN5oarU5rVirHg
 DM9VqoNRe0XjaMThfNxF3VNYi7zOygUdRMLyCTHHDtJ/UG9Vq9EHVYc4X+VlNuiOfe3h
 VGuMhsdAqcyRJF0iMgF8L3l+y1GNeBh5T7fVRu3hF4SsZdgjrmEBJdJ4Ta+0TCoD61It
 jhpg==
X-Gm-Message-State: AC+VfDxH/DqsRBhQoEamgtzVRqqYOVnOa4z2uZRbkNkfiHPshcz2AYcW
 tLofetk5+xM4/ftbEXVrXoE=
X-Google-Smtp-Source: ACHHUZ6XiCDwICdCB3IVWgPUbjU/7I7b8n7WEcWq5hLd9a2ZS9RNJhAc4Y0fLCaouqE3Nup0MDBfeQ==
X-Received: by 2002:a9d:75d2:0:b0:6b0:f9b:2526 with SMTP id
 c18-20020a9d75d2000000b006b00f9b2526mr3959445otl.7.1685291855998; 
 Sun, 28 May 2023 09:37:35 -0700 (PDT)
Received: from [192.168.68.107] (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 m9-20020a9d7ac9000000b006a64043ed69sm3697423otn.56.2023.05.28.09.37.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 May 2023 09:37:35 -0700 (PDT)
Message-ID: <4990b9d9-b9cd-d359-b0ab-2cf53cfb5e8d@gmail.com>
Date: Sun, 28 May 2023 13:37:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ppc/pegasos2: Change default CPU to 7457
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: ReneEngel80@emailn.de
References: <20230528152937.B8DAD74633D@zero.eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230528152937.B8DAD74633D@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x329.google.com
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



On 5/28/23 12:29, BALATON Zoltan wrote:
> Previously 7400 was selected as a safe choice as that is used by other
> machines so it's better tested but AmigaOS does not know this CPU and
> disables some features when running on it. The real hardware has
> 7447/7457 G4 CPU so change the default to match that now that it was
> confirmed to work better with AmigaOS.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Tested-by: Rene Engel <ReneEngel80@emailn.de>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

And queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

>   hw/ppc/pegasos2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index f1650be5ee..af5489de26 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -524,7 +524,7 @@ static void pegasos2_machine_class_init(ObjectClass *oc, void *data)
>       mc->block_default_type = IF_IDE;
>       mc->default_boot_order = "cd";
>       mc->default_display = "std";
> -    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7400_v2.9");
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7457_v1.2");
>       mc->default_ram_id = "pegasos2.ram";
>       mc->default_ram_size = 512 * MiB;
>   

