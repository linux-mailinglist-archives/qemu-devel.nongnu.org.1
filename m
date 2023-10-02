Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F777B56C8
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 17:39:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKzZ-0001z8-UC; Mon, 02 Oct 2023 11:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qnKzY-0001xm-2x; Mon, 02 Oct 2023 11:37:52 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qnKzW-0002ui-NJ; Mon, 02 Oct 2023 11:37:51 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-27736c2a731so11084304a91.3; 
 Mon, 02 Oct 2023 08:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696261069; x=1696865869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iRq8V4+HiMXts1NbA4HibQ/8v0ahVDNNgXP72zTzgz0=;
 b=iJc/KSLQWqpTKgM8XIVUbftkFDaCZttUlgn5epcsZo9asBeWCB3ean9fzlzOeXl94b
 2JmUQnKKNitBHQJG23zWT0wz0uYf9RceXAd0pD70STVZSIrDD61swrw7AfEfS/YEoAhI
 wvuh06siC6QPEuseyouC2NjElYBayRy/AzSuCA4RRr9Se3W9V6uT3dml9jp1l93HUdn+
 gIMqFDIQA7AS0+1bkm+emchEuoOvHAeittM5cMNf1y5Scv/k7nLqJ6/3DYjCz8hVIaUr
 wGpgJEO1ftAy/7DGyhkN15Ujp9SSbw94nafR5BS2LRpVB1gvV09WIO4KqpqfQNipYN9Y
 EkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696261069; x=1696865869;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iRq8V4+HiMXts1NbA4HibQ/8v0ahVDNNgXP72zTzgz0=;
 b=AZrPFjyrr3XxtIH8zMqcfggFqeOkx/CWCm3BaTUEGzRCSYoXVYUnBAFHsvNbWRINq5
 Qo1KNzl3IJqwgEiL51OyjHOYHONms5CwR5gtEDMqiMPVALg4DgbnlKNFFmTLQ0gguTUW
 OnRb2DZkVQWlg2eVU2/xbIrw00GCbsx15nJzihXYva7lkApmnBqMBlcbuY/1ve2VLWcx
 eTAISeOXIWBWAf7qvw1TsFYLTSHiyRyUmhRbd4sZe6tMkFqTEop1gfx+tZDsj3YrTAE2
 DNkDVIJT0G5bDw5ZXkabcHDHAHswVWws9Q0pWpISG8R9fEKyn79mAbsFwV/x33Q7RCNz
 jp+Q==
X-Gm-Message-State: AOJu0Yw/Y6vYLIBJ9vmewPxb6hRNKyyKL3ybmKXbpJnQS39XT9Zfvu3c
 kAOUAcC8edctKfQA+p5iXDk=
X-Google-Smtp-Source: AGHT+IEdzBKO3WogsENzmn6bhlyD8CM7kiTHBt8747tBbn+KtIFl6j1G7aZ4+eSLw+8q+cciXuLhLA==
X-Received: by 2002:a17:90a:2f24:b0:269:524f:2a19 with SMTP id
 s33-20020a17090a2f2400b00269524f2a19mr10818023pjd.26.1696261068675; 
 Mon, 02 Oct 2023 08:37:48 -0700 (PDT)
Received: from [192.168.68.107] ([177.94.15.124])
 by smtp.gmail.com with ESMTPSA id
 19-20020a17090a199300b0026b46ad94c9sm7009194pji.24.2023.10.02.08.37.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 08:37:48 -0700 (PDT)
Message-ID: <e94660fa-ef72-01d7-0926-64afe1790856@gmail.com>
Date: Mon, 2 Oct 2023 12:37:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/8] MAINTAINERS: Adjust file list for PPC ref405ep machine
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
References: <20231002122326.365368-1-clg@kaod.org>
 <20231002122326.365368-3-clg@kaod.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20231002122326.365368-3-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=danielhb413@gmail.com; helo=mail-pj1-x102b.google.com
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
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 355b1960ce46..3f90264203cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1345,7 +1345,7 @@ PowerPC Machines
>   405 (ref405ep)
>   L: qemu-ppc@nongnu.org
>   S: Orphan
> -F: hw/ppc/ppc405_boards.c
> +F: hw/ppc/ppc405*
>   
>   Bamboo
>   L: qemu-ppc@nongnu.org

