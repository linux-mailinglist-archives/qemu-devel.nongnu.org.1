Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8689F7B4B5D
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 08:19:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnCG5-0002J4-7H; Mon, 02 Oct 2023 02:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCFz-0002I3-1I
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:18:15 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCFw-000600-Qi
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:18:14 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-503065c4b25so24713250e87.1
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 23:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696227489; x=1696832289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/wYXpS80+mlwznfgTFHO6dZbZGpug/2dvJbl3dla8Sc=;
 b=WybudFHWnXdE8ASrBWKcCpla5AIvZb6Q5DKyxMlw4n19gqToyNIV9cNi0e0Q+leRko
 jNEnp9ysGKdOPQbTG6Ni/6NRoXEB4NgrKs8tSsux1UPyKFvYhwXaxirXq00jjlzkji8N
 +cq3O1wNzjYv8Zo5QUS+NovhmG4KE8qVlb3FdTTImkCcnJPb7EW0bg1qTSc1iQe55Oh/
 74bUPPJj+xGkWb4xlNUwShoKfNxMEktBH0572cYMgEtYbg2/+AEUldGldaSTjj6Xqbgb
 h0FgixFr+4na/LwWI+6DdnlyLD6wtk6eovylo/ZEfWqtfa+476Uu8o28eszPcuZpk9Gb
 JFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696227489; x=1696832289;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/wYXpS80+mlwznfgTFHO6dZbZGpug/2dvJbl3dla8Sc=;
 b=Eyd1Kxm+Ai8F7Ik82NEVQVpW430+6kJGU/8JWmFTLe16AUEGE06c7hUXYLmQXATH6G
 KzZSm4mJ2tQRmZLghQ/LDVAL5FrraSzTRZUn5Ni5hHlT5oC0kp0gom4sG2uPFaohly0h
 K/ObpHEwecyDy6Od/YYqyuu6IdbbOmolTIxOCjKWMr3G7KQsH/RlEpiNgFhycCUB6mUD
 7RsEOiVsnj9Mr6sU4EtTxrFRZz8p22YXlp604JpFXvyzs8DlUzDFgvC+U+pA4gq0a3HU
 hxIKEZPsCq2waPW/HIe+VA+9Jsk+Evu7jjORAFZMnkzjb//2yIU9iEHRPYvGeXEtdLC1
 BqXg==
X-Gm-Message-State: AOJu0YyiuGtj2yLDIglqIKNtWCL1yEmd2TAvHERf+69DVW5Qds1481wv
 TTjme7v+apzj8jEZu/TtKBAAaMGxTNzcozfqAGM=
X-Google-Smtp-Source: AGHT+IFIuRks3fs6xPGsZhcXUQhRQlDoiDCaQTGClRE6UUspfKlsnK/3rZJ61eWGoUfocGedlAeKgg==
X-Received: by 2002:a05:6512:31d0:b0:503:186b:e0a8 with SMTP id
 j16-20020a05651231d000b00503186be0a8mr11486567lfe.60.1696227488924; 
 Sun, 01 Oct 2023 23:18:08 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 f14-20020a7bc8ce000000b00402d34ea099sm6442837wml.29.2023.10.01.23.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Oct 2023 23:18:08 -0700 (PDT)
Message-ID: <89b74108-0379-97c8-455e-cb0c5058785c@linaro.org>
Date: Mon, 2 Oct 2023 08:18:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: MAINTAINERS still leaves more files uncovered than I'd like
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87lecp6w7x.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <87lecp6w7x.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.058,
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

Hi Markus,

On 29/9/23 13:43, Markus Armbruster wrote:
> Back in 2014 (time flies), I posted
> 
>      Subject: MAINTAINERS leaves too many files uncovered
>      Message-ID: <87mw8rumhb.fsf@blackfin.pond.sub.org>
>      https://lore.kernel.org/qemu-devel/87mw8rumhb.fsf@blackfin.pond.sub.org/
> 
> I updated my findings in 2015, 2016 (at commit e00da552a0d), and 2018
> (at v3.1.0-rc2).  This is another update, at commit 36e9aab3c56.
> 
> Unsurprisingly, the number of files in the tree
> 
>      $ git-ls-files | wc -l
> 
> grows over time:
> 
>      year  2014  2015  2016  2018  2023
>      #     3746  4387  4921  6461  9788
> 
> Looks exponential to me, doubling every seven years or so.
> 
> The number of .c files has grown more slowly:
> 
>      year  2014  2015  2016  2018  2023
>      #     1836  1945  2132  2633  3588
> 
> The number of .c files not covered by MAINTAINERS

[...]

> hw/sensor/dps310.c
> hw/sensor/emc141x.c
> hw/sensor/lsm303dlhc_mag.c
> hw/sensor/max31785.c
> hw/sensor/meson.build
> hw/sensor/tmp105.c
> hw/sensor/tmp421.c

I sent a patch for these but the community didn't
seem very interested back then:
https://lore.kernel.org/qemu-devel/20230220110235.24472-1-philmd@linaro.org/

