Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A1D77EF3F
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 04:59:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWTCc-0000Jd-LW; Wed, 16 Aug 2023 22:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>) id 1qWTCZ-0000Gp-Qc
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 22:57:35 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>) id 1qWTCX-00080Y-1A
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 22:57:35 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68878ca7ca0so1499037b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 19:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20221208.gappssmtp.com; s=20221208; t=1692241049; x=1692845849;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NIYpAT/cYzxFB59WFnwJkqf+qr0OBNGgodWl9NyOVkY=;
 b=sA4ph0ffpXFS9dSawuqGXkR2ypW4PbwakTDnj+n2bZK/6+/PKRzD6O6bAVVkJnYe/W
 Vg/XPgZUrbsamYRUkKIeRcWH+SqRmvQ0CKR+U915UQQsBhVdgAdwYDBqLzXUZ/j9cB1p
 ag+G1VqJA5RemQV4zTi+5dy6Nq6ttI4vFWtJl11LUjKrDWYigejJOJx/LUZZSCeZVnP3
 fFRMzfQ0xKPSW/Vwi/FQo0eUuFqffyKi8i2TL+PETiBLC+2GgNt10OZfs9clnpKHcHNQ
 YdYM9BNUBMrFDMu8Bzx70dZqg18Ns4CqVK7TMFIgSVv8dJkjddLBhK4CBPGnDS7Jd3HG
 VB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692241049; x=1692845849;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NIYpAT/cYzxFB59WFnwJkqf+qr0OBNGgodWl9NyOVkY=;
 b=IeLemJOMGFWinU8ETjiMMYYFfy4NHkwRYm+Gsytf5c3uJcs21XGLh6scGtuz3M1p4F
 /m3/W0DVxPJf337hK5f6h8m3k7Zw/o9CYtu0inH8k4x+aDWXOsMSs75YKXYgJgPCrqCD
 9Bh7Rd7sZCvalO51/+bMuJV8p/Ou47KFPj47aXA/3nitxaNSJq+3+3wz8cdepzBJIjYT
 8bmOHOPtc9PKcLWTqAmeMRNZkM0SHkYuwoCbibzKHi8nT7a40o9ySHF9f3jKZkD2Ou72
 oUjgpWsrh46jqchFQ2qCTk8dfWRGLPQV8G8Kw3mppUyL3+ASjTY4izDDCzWKGji1yEfA
 IdYw==
X-Gm-Message-State: AOJu0YzFGcRuNwi/1lZgmaMOXDeSFrVS6x1H0ST1oHU02RvIvLvnXgV8
 ckMQoUIGDuQUpfF5Mu+dit6EKg==
X-Google-Smtp-Source: AGHT+IGT1w+BI29x/g99A6MtdHXTM9zxJqItbrkVi7ZnEsuI5skuMYpHP/JRIWhP43kXHpxp8h07Vw==
X-Received: by 2002:a05:6a00:3990:b0:687:6184:deed with SMTP id
 fi16-20020a056a00399000b006876184deedmr4405116pfb.22.1692241049265; 
 Wed, 16 Aug 2023 19:57:29 -0700 (PDT)
Received: from [192.168.10.153]
 (ppp118-208-171-7.cbr-trn-nor-bras39.tpg.internode.on.net. [118.208.171.7])
 by smtp.gmail.com with ESMTPSA id
 fe22-20020a056a002f1600b00682a0184742sm12172416pfb.148.2023.08.16.19.57.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 19:57:28 -0700 (PDT)
Message-ID: <659a53cb-2dc7-45c0-7598-38f60a3dd923@ozlabs.ru>
Date: Thu, 17 Aug 2023 12:57:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101
 Thunderbird/108.0
Subject: Re: [PATCH v2 02/19] ppc/vof: Fix missed fields in VOF cleanup
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230808042001.411094-1-npiggin@gmail.com>
 <20230808042001.411094-3-npiggin@gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20230808042001.411094-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=aik@ozlabs.ru; helo=mail-pf1-x435.google.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-3.165, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 08/08/2023 14:19, Nicholas Piggin wrote:
> Failing to reset the of_instance_last makes ihandle allocation continue
> to increase, which causes record-replay replay fail to match the
> recorded trace.
> 
> Not resetting claimed_base makes VOF eventually run out of memory after
> some resets.
> 
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Fixes: fc8c745d501 ("spapr: Implement Open Firmware client interface")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Cool to see it still in use :)


> ---
>   hw/ppc/vof.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> index 18c3f92317..e3b430a81f 100644
> --- a/hw/ppc/vof.c
> +++ b/hw/ppc/vof.c
> @@ -1024,6 +1024,8 @@ void vof_cleanup(Vof *vof)
>       }
>       vof->claimed = NULL;
>       vof->of_instances = NULL;
> +    vof->of_instance_last = 0;
> +    vof->claimed_base = 0;
>   }
>   
>   void vof_build_dt(void *fdt, Vof *vof)

-- 
Alexey

