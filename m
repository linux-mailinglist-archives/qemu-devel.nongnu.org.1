Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0C47A4722
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:33:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBYq-00075j-RN; Mon, 18 Sep 2023 06:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qiBYo-00074q-GZ; Mon, 18 Sep 2023 06:32:58 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qiBYn-0001Y7-1y; Mon, 18 Sep 2023 06:32:58 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-576918d0a42so2620823eaf.3; 
 Mon, 18 Sep 2023 03:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695033175; x=1695637975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=acM2OFT6Rc1IMvNhiAwmuo9b/6DL6VJ/wLtG98/F5U4=;
 b=JYE28/HA5yP5pnJQcc86Mc61gchAQJNvGYgNxTYiiiO59u2Qt5qopSvyoSE8PFzWhC
 dOIo1OmEJDgsXOlzImYfZvssiN/NKZW68zNd9hprPmHltmmLPOr+Yf56X5nZUH0fcHg6
 TIJYCOHAzCwIoKDNoNh26i99hUWGiJUzDKu5AzJN9cqi+7QShCmmIZ9R1rJBk5A6IUNV
 ZvfllF0BsemvYWscgAVjQpQ+EpR1LRCeZQagQIuVXbPeWHfXQtrxpYrCcwePmo46prE7
 bxuFOnm8eLNQXeiAe+12cHwLKpKB8JqA4KQW/kr6K7tZAm35MoU9KBXlYPSNg6CEYHPq
 0VNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695033175; x=1695637975;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=acM2OFT6Rc1IMvNhiAwmuo9b/6DL6VJ/wLtG98/F5U4=;
 b=pZTfEdOZ3w9PywfPMZAi4hzkYFZqw3dQqgKDT8CBEMvKt3pEpJvAqWbopAWNkljIW4
 ihhxgfJgfY3lY07A1sMDNv9ovcAu56jBQuhzYvIEzJosOuzT86QxctbyDDi4HEnvVyRE
 8FLdRrrLARy4orhCG3YRyokHAX1bQesw0nI0syPKmC1bjT35b8TeGpJCoMzzA5LH1gfr
 DVJZJ5uC3E6P2wjDRSETV+hocQLn/9YDf8DLI+JyaF/C04roAxzRstoo+QMqJ9V0tIvr
 WAzfBdXdN9odz4WGx1zYGBeMURhZibpmnxcoPozfXjXMzpbbYmVQFBBNv+rCeupoBF5S
 Ejqg==
X-Gm-Message-State: AOJu0Yyx7QxH6YZpAtlffhNMNKHV04qcoQOjLnW04nofatHeS/duY2rP
 cTm9t4sr5kl9Y6JHjFZndp/4WJxGyqs=
X-Google-Smtp-Source: AGHT+IFy7AlaxPqf5NOFK9jdbrUy6R8KVQx16nTR879I4C9CZMEXU2GEd8vFIrUEkZSzjuCVzn5NRA==
X-Received: by 2002:a4a:3541:0:b0:56e:a1d3:747e with SMTP id
 w1-20020a4a3541000000b0056ea1d3747emr7459010oog.6.1695033174392; 
 Mon, 18 Sep 2023 03:32:54 -0700 (PDT)
Received: from [192.168.68.107] ([152.234.127.211])
 by smtp.gmail.com with ESMTPSA id
 p63-20020a4a4842000000b0056d361ca33fsm4446575ooa.16.2023.09.18.03.32.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 03:32:54 -0700 (PDT)
Message-ID: <a0b4b3e8-6d86-d494-88d7-6eade5004d04@gmail.com>
Date: Mon, 18 Sep 2023 07:32:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ppc/xive: Fix uint32_t overflow
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
References: <20230914154650.222111-1-clg@kaod.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230914154650.222111-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-1.473,
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

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

On 9/14/23 12:46, Cédric Le Goater wrote:
> As reported by Coverity, "idx << xive->pc_shift" is evaluated using
> 32-bit arithmetic, and then used in a context expecting a "uint64_t".
> Add a uint64_t cast.
> 
> Fixes: Coverity CID 1519049
> Fixes: b68147b7a5bf ("ppc/xive: Add support for the PC MMIOs")
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---
> 
>   v2: removed extra space after cast
>   
>   hw/intc/pnv_xive.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 9b10e905195a..bda3478b1f84 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -210,7 +210,7 @@ static uint64_t pnv_xive_vst_addr_remote(PnvXive *xive, uint32_t type,
>           return 0;
>       }
>   
> -    remote_addr |= idx << xive->pc_shift;
> +    remote_addr |= ((uint64_t)idx) << xive->pc_shift;
>   
>       vst_addr = address_space_ldq_be(&address_space_memory, remote_addr,
>                                       MEMTXATTRS_UNSPECIFIED, &result);

