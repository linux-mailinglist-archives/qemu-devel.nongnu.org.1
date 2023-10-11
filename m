Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEAF7C5563
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:27:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZEs-0001rV-UR; Wed, 11 Oct 2023 09:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZEh-0001aF-FH
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:26:53 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZEd-0005NT-8k
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:26:50 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53b962f09e0so6864416a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697030804; x=1697635604; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jzG+6ppPtgBmeXWuxnmwh0vDZwCFhfNprCXe5rixV1I=;
 b=TWCh1gJ87Tivrk3f6mKFgqAJ1KUImPA7667qUQQjYspnCFpjLDDV6h3Bt00fu598CD
 j5zgY1aEnNkJdgibWYPieZJO8MFOjyNNOPPz7degipJzmLbY3uj4326W4F/bVB7PV23s
 Z3AvbvJmuqPM4u2zMyqzWAbb8FrYbIw4eSHj3n5ZS+FLQ5mg66ifimaAL62s6pgJgQFO
 oQmNFfLMQL7A93BiORrQH6X81YQHBsAsQZsgP7msYAxKOL08+Xch17ZA4OSMqtHIm4Ea
 SVn6KwPYOrmxtYTluGGK6jG0Pb5DN7oC2j7k04fqQb3uFdBfalXfTb06W3P9ylNG1ulU
 l1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697030804; x=1697635604;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jzG+6ppPtgBmeXWuxnmwh0vDZwCFhfNprCXe5rixV1I=;
 b=k8+InP3+44mcOq2+ggUYz3sR9CusMovEV3//3TujGDzm/rv7z625oTqtUvxsmmoJzu
 K9DhV5TavOTihebdZvkMTLWGGwagNJnhyn2yvgP7cn440PmJijjIK8BKfLcdrKv4r4+e
 N/0lVONEF8pjQ5YmqgAgJtpd0NK5k1m4YQlQi2kluezQW61EGKZpqZzXeZzNC9wrplMJ
 3H74tRXIhU5z4uGVM5nQntCpI3dNzZBdgPj82crlsdfB2EOlAg820oQbFGEy6DyprJTT
 ppnVPog/aUgMG/lZgeDh8lf4+v2BdBg5E9hpSUDFO4C8nEYnKHCoCGTYoAadvZjS557D
 ZyqA==
X-Gm-Message-State: AOJu0YyPF9rmG1XGT5Up7otk0CPS3xZ88QRbVK+GNc8EU3+4qyZHuEXD
 +Q3jqnCaqb5K0T8vH/5sjoQEEg==
X-Google-Smtp-Source: AGHT+IFWDfDn/KLpPSRzFdxjpGJMX2v+L4IFyqdgkP4b+yiP8xgFKVuPCv7XECzhjQHOqof7ccu7sg==
X-Received: by 2002:aa7:dd12:0:b0:51e:4439:f474 with SMTP id
 i18-20020aa7dd12000000b0051e4439f474mr17641600edv.35.1697030804636; 
 Wed, 11 Oct 2023 06:26:44 -0700 (PDT)
Received: from [192.168.69.115] (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 p7-20020a056402074700b0052f3471ccf6sm8878809edy.6.2023.10.11.06.26.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 06:26:43 -0700 (PDT)
Message-ID: <2e7bd8f1-d593-330c-cff4-4568430af1e8@linaro.org>
Date: Wed, 11 Oct 2023 15:26:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/ide/ahci: trigger either error IRQ or regular IRQ, not
 both
Content-Language: en-US
To: Niklas Cassel <nks@flawful.org>, John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Niklas Cassel <niklas.cassel@wdc.com>
References: <20231011131220.1992064-1-nks@flawful.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231011131220.1992064-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/10/23 15:12, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> According to AHCI 1.3.1, 5.3.8.1 RegFIS:Entry, if ERR_STAT is set,
> we jump to state ERR:FatalTaskfile, which will raise a TFES IRQ
> unconditionally, regardless if the I bit is set in the FIS or not.
> 
> Thus, we should never raise a normal IRQ after having sent an error
> IRQ.
> 
> NOTE: for QEMU platforms that use SeaBIOS, this patch depends on QEMU
> commit 784155cdcb02 ("seabios: update submodule to git snapshot"), and
> QEMU commit 14f5a7bae4cb ("seabios: update binaries to git snapshot").
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>   hw/ide/ahci.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


