Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBAB79AB5D
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 22:48:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfnoJ-0005ks-BG; Mon, 11 Sep 2023 16:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfnoH-0005j8-J5
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 16:47:05 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfnoF-0000Hg-B9
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 16:47:05 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2bcd7a207f7so78252051fa.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 13:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694465221; x=1695070021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ibXo406aZEbmYWqXvF8iN1KKwgslNX+IDF38l2S2/YM=;
 b=gErTgC5AQE73y5D7TqugAsXWXnQl4bZvbhasgGKip/ehJdcXlvalaEmLU2otMIe4nM
 RHCLN6UtaFYPcolGHPJw/6ThTwAHlGpQ3bZQ+YadcSJBH81VbBn6+FWFOqlhU7K8OzJN
 mHxqwqdAxe2D3xJG0SpaQPphIgx/d7tQJiaKvwp21s0pOamMVxHAbgpy3angDwXWCSPw
 3vRN1CSTh3U45p8/3EfL4cnQiD9aDYUQQyswHZYCpZUXYjPSsun8tiDz40X/v1vtSXlR
 gA3M466vZNdKt/ADVwH/VwaSrltOy7Aca5/CF/tdzRtPCFP6hmjBLMWXtJEwMQttflxw
 XZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694465221; x=1695070021;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ibXo406aZEbmYWqXvF8iN1KKwgslNX+IDF38l2S2/YM=;
 b=xGExvd4ZpDozvxGoLgC1t3ZXHokA5dZfee7TVsmSObPHoYJdTNNo2CqwOyvbJI+lXs
 dkZ38BMVtRjf5KiGQQsnA0bHl5KBcynkr8SVWMhcbCk6z7nH5M74GoSJ495UwLIkVAft
 Z9DF6jl5F3Jivcda6ioi1yCjamqC4NNvCfKMmHGaaV/9z9x0l+NNbVTSrnDbVHN/Z8/T
 lLXZD6eLcz/CkdrXM5GOrY9c44DmTwjsXoeIK1XhoVmQBUouptFrzwEr4r7BYd7Eh5WC
 jOdu4kyrguj/JrhoMYippMf/WDLssAXZPnMjijOwOx6XMtZGcZcgswTDxYq4HPkfMhJ8
 r4mg==
X-Gm-Message-State: AOJu0YyeO6Q4x5jTt9CnvGUZFD9o8D0uv1ibc2e90f7dby6W1/SiOXWP
 SiLglzD9DVPsHtkMbVA0ZApb3A==
X-Google-Smtp-Source: AGHT+IGCVEvpADzoHDOLohirVOGYjggU073BHWxCreRulGl9bqY/RwMiXg1uSfnJA6s/e+d04K9Trw==
X-Received: by 2002:a2e:bc88:0:b0:2bf:9664:b761 with SMTP id
 h8-20020a2ebc88000000b002bf9664b761mr2700550ljf.53.1694465221397; 
 Mon, 11 Sep 2023 13:47:01 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 lc1-20020a170906dfe100b00982a92a849asm5835625ejc.91.2023.09.11.13.46.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 13:47:00 -0700 (PDT)
Message-ID: <91f0ad35-c496-3c49-2111-74ffa607b45d@linaro.org>
Date: Mon, 11 Sep 2023 22:46:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v6 08/10] migration/yank: Use channel features
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Leonardo Bras <leobras@redhat.com>
References: <20230911171320.24372-1-farosas@suse.de>
 <20230911171320.24372-9-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230911171320.24372-9-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 11/9/23 19:13, Fabiano Rosas wrote:
> Stop using outside knowledge about the io channels when registering
> yank functions. Query for features instead.
> 
> The yank method for all channels used with migration code currently is
> to call the qio_channel_shutdown() function, so query for
> QIO_CHANNEL_FEATURE_SHUTDOWN. We could add a separate feature in the
> future for indicating whether a channel supports yanking, but that
> seems overkill at the moment.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   migration/yank_functions.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


