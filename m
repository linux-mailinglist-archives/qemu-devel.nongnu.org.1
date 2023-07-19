Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D817594BA
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 14:01:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM5qL-0004lA-Ss; Wed, 19 Jul 2023 07:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM5qK-0004kM-3B
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 07:59:44 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM5qI-0007Zq-Ep
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 07:59:43 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso70064755e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 04:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689767981; x=1692359981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nJ524wIlrJOTWcaFTiuk8cB0cM2nlCrmPTgUO+0DOtM=;
 b=uJJqksm8nLQWy1gIaxVLErBddWepd3nYrfa2GvyBJXUxT8PAuxoez4hb5Z7Q58Vy0M
 khhh0ZMEEKVyoyEMfdS6NPwzcTqzlL7K0XTHZoP8uSQMxKbPR36u48RKteHKqHP/UoNx
 wJaHohvRcyBe9Fd3pXQfuX0DJnDJgPg26QlVE571UtY/ihpj5okBuI4Xz8j0wJsfIIBK
 LFjvHpudBdS91sXqZpkeUQN48QiZJC92nSb15jW4eSUTFhfyOFGzuJToW+H2DPopwrhi
 US4UW2K8m7vd8GN3w6BUkkuEIBMd4/7Ht8rE/2X3fzefvA451++pBGuV/YPVGnWueQfU
 gVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689767981; x=1692359981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nJ524wIlrJOTWcaFTiuk8cB0cM2nlCrmPTgUO+0DOtM=;
 b=OIS5PT6ScWq+tMPUYWoUII2wDApJLWlqwZ7kVZKgfx8MUw+Ht1OWTXYXjxbO98fPc/
 e0Nlziq8+6L8ukbx0m7TC23eT3YCesPHWUapVBd3i18vpXSTlwQQRVcHsxH3tUjaemcE
 zqQ9wACI8UE9LknikgA8WcHF7Z68cHw+Y42Zf7KM4lnm6rD0qqpA8umSCuyLhb8sw//d
 7Vtpiiyl+9niTE84E/d0Y90m+qV8tIWbDA1JEO7lXZwfmJydwlu/AdwBHZEloNRvPO7E
 wtZ2hUWEbiDpgFUwp9Z5fTeVngcwbLKzpQvs6nLcYR+NJ2vrJeXe6GYKMDvezce0bF2X
 Y5Kg==
X-Gm-Message-State: ABy/qLbhv+3K5Ru6QQD6ecc/q5c3BWXaP6MuvMMEBrtnj9d+fjsfyqFA
 VEaiLzhWDfoBwcifn+UGnVJ9nA==
X-Google-Smtp-Source: APBJJlF6RDmapr7L4tnhb9ITshTBhmXjHOZVCpN5uFELcpxfmskjKY62nylPA+vdEaKz1vyhOy8YPw==
X-Received: by 2002:a1c:ed0e:0:b0:3fb:40ff:1cbc with SMTP id
 l14-20020a1ced0e000000b003fb40ff1cbcmr4109186wmh.10.1689767980823; 
 Wed, 19 Jul 2023 04:59:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.201.220])
 by smtp.gmail.com with ESMTPSA id
 x21-20020a05600c21d500b003fb41491670sm1536178wmj.24.2023.07.19.04.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 04:59:40 -0700 (PDT)
Message-ID: <e1966f41-5e65-7cd8-d558-46b11a0eb553@linaro.org>
Date: Wed, 19 Jul 2023 13:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 8/8] hw/ide/ahci: fix broken SError handling
Content-Language: en-US
To: Niklas Cassel <nks@flawful.org>, John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
References: <20230609140844.202795-1-nks@flawful.org>
 <20230609140844.202795-9-nks@flawful.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230609140844.202795-9-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 9/6/23 16:08, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> When encountering an NCQ error, you should not write the NCQ tag to the
> SError register. This is completely wrong.
> 
> The SError register has a clear definition, where each bit represents a
> different error, see PxSERR definition in AHCI 1.3.1.
> 
> If we write a random value (like the NCQ tag) in SError, e.g. Linux will
> read SError, and will trigger arbitrary error handling depending on the
> NCQ tag that happened to be executing.
> 
> In case of success, ncq_cb() will call ncq_finish().
> In case of error, ncq_cb() will call ncq_err() (which will clear
> ncq_tfs->used), and then call ncq_finish(), thus using ncq_tfs->used is
> sufficient to tell if finished should get set or not.
> 

Cc: qemu-stable@nongnu.org
Fixes: f6ad2e32f8 ("ahci: add ahci emulation")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>   hw/ide/ahci.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)


