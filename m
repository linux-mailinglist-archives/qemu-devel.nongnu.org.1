Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E757878D7F1
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 20:15:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbPi8-0004fL-Bz; Wed, 30 Aug 2023 14:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbPi6-0004fB-Tx
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 14:14:34 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbPi4-0005Lk-PH
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 14:14:34 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1c8e9d75ce1so3436653fac.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693419271; x=1694024071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=THANX2MrM72wDm/WPBvZ/8aFv8m9+yeZROnv6tWedGw=;
 b=EVChWk1fIIXgfxRV8fM+/D+axY7JTu4kKX5lOrrV9XGiDczmW4lUelPEnH7jj4wjP3
 vvWK2eW22FqU/PC0E3D6X0zSU/WXv5C0o7yLm0G9c27M5VyIdpH3a+OE4ppszi36mj/o
 sN+Hy8BG+6B90DzJ6nGzjWq8vCyJgjgP/OkegQDwOh2Neno+W1UEjDIp+SsfXpXfzlMO
 A5Gh2YJduVG6K0K1+x83RvxjhGzbmmfCrEOnS113KAL2oVOCtjq+n5Ps0ASOcYYrwMf2
 SyQ9wbGBy/iTKEKpG3JdGUYYCDPzXdOmg6Zmq1DQpcc+eAntzsCjAQ9MT2JFHbnsSlHw
 jWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693419271; x=1694024071;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=THANX2MrM72wDm/WPBvZ/8aFv8m9+yeZROnv6tWedGw=;
 b=PFRj6NYzqYF8J/45EhtSrv0HW+i6kv9SDqKv+aOoxgnX0KK7RGsmoT7QfYUGfImBao
 oYIG2g9ChjVunxBjwxLdOMn/WlVzIOscjK3AGWIURgAPxXrbEMpYJQ1hvekUJDtjBsSD
 Uho6yed1dRWahnu9IlZ48MMKvvzIDAHEaaK9DE1mCT/Ya7VittrbNrY+5TlU15yCatSC
 aYJTD91FO88jLkQuw05G99lxzYBGTPdt4l6CP1IAx6szQXqW13NZFvnGVtaY6wax0OFF
 XKn1g+UZJLxcOoVllu0zioTcuP3ls90tfNT5uzHOS/qgBqrcqFTa61Fi54oH5lH8XWoM
 /JaQ==
X-Gm-Message-State: AOJu0YxXRNCowP0N4z9zWiwecVwjSb4l/oKmKpklOvTM+w3gWrjyD0bv
 nVcebZfTkQmrqQxyZC/MlnIijA==
X-Google-Smtp-Source: AGHT+IEFl5q5b2SzmkxdaIEFmfwVS0h4LCcoLag9LIVMpd4ztc3PspPzImD74tKze5nyCmkQt+hL5g==
X-Received: by 2002:a05:6870:c18e:b0:1ba:466d:5f9e with SMTP id
 h14-20020a056870c18e00b001ba466d5f9emr3504777oad.49.1693419271370; 
 Wed, 30 Aug 2023 11:14:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a17090ace0200b002696aeb72e5sm1550899pju.2.2023.08.30.11.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 11:14:30 -0700 (PDT)
Message-ID: <f525fbed-2e56-debe-138b-fb2479e412ff@linaro.org>
Date: Wed, 30 Aug 2023 11:14:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 13/48] target/loongarch: Implement xavg/xvagr
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-14-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-14-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> --- a/target/loongarch/vec.h
> +++ b/target/loongarch/vec.h
> @@ -50,4 +50,7 @@
>   #define DO_ADD(a, b)  (a + b)
>   #define DO_SUB(a, b)  (a - b)
>   
> +#define DO_VAVG(a, b)  ((a >> 1) + (b >> 1) + (a & b & 1))
> +#define DO_VAVGR(a, b) ((a >> 1) + (b >> 1) + ((a | b) & 1))
> +

No need to move.


r~

