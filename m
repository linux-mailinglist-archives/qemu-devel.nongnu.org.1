Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A501C734D0C
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 10:06:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB9tb-00063P-1d; Mon, 19 Jun 2023 04:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9tL-00062w-Sz
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 04:05:41 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9tK-00018g-23
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 04:05:39 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-988aefaa44eso111571066b.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 01:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687161935; x=1689753935;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pkuyy9Qu55P6NOyPQmGtz0+oG22qvc0HNbqokeNrZNg=;
 b=nyHVpnefgOD5WWUdiP7CwN9VtJziD0KZGfpc1fbLbhv3LPxpgABgehY1G+2OjuPZPd
 LEKMEUk4MM0AQHzJAHVBHX6mSlghAQf5OQ1VkjVeGKvcfpudSD8TgzR4bcCHWIJzw6OK
 iN6crXqrsGRiYkBRt0geWLcqRVhPMf0JuG1mPqAKUjBPxnw34xRLFJNArGtWcaEbSrgT
 QufYOHJxXsHDQ7yjWxsYU8eChGLmZRWq/qgsjypMgIECJZ0FreNLjV9XbZ1Ilmzxqi04
 pt8fghYbxfmEWDs/9i1v9eiiy4eR/VqDMkIsGhM3dhdxGOh3F/LCSgVMnDkvMmZwXCtx
 VCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687161935; x=1689753935;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pkuyy9Qu55P6NOyPQmGtz0+oG22qvc0HNbqokeNrZNg=;
 b=LVoRWjTWosIZErWdtBD3Ijo0gS/svv9qPf5bE5YA94PJouas+PQDSq8dfhsPi2hPIC
 d29n5XkI91nAN22dc9lUVgJ7XwU6LkPqaWoKegNiXJBrgthoV7U50rqna6WaQyxJvG43
 YGDUMMctNwn0c0eP5t3PmTHZ+DMjePVYCOJGpupf3rGYi3xpJa4MUGbKVSzTrRKPfCmV
 2+SlAvhVavbvlNWiDdFEnah1CH9GhkJq76J2g5c7o2uzaf6uEjXacZJA2Tx7ZldYv4QG
 xXqxvWQX0hAKUfdEhKM8gyI7Z8rRrzWI2yJIDEEQG3sPqSpUoPRCIbldUGaIenCtaCOM
 2qwQ==
X-Gm-Message-State: AC+VfDxe9QrLoEKkgLh5rwU67AD5CCLjY3DirsY+Ttnds8YOxWqwCwJW
 I6COD7qlYud/XaVp4fyuYtuDmA==
X-Google-Smtp-Source: ACHHUZ5t4qYonxd0izt5cd45PC+spp5Z2UupLaYQNRCYkX1hLwqWNPaaHdPkzG9hGa19M9USGRnSJw==
X-Received: by 2002:a17:906:9b88:b0:988:9641:fe38 with SMTP id
 dd8-20020a1709069b8800b009889641fe38mr2275959ejc.32.1687161934788; 
 Mon, 19 Jun 2023 01:05:34 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 gz17-20020a170906f2d100b00988936b142bsm1476186ejb.147.2023.06.19.01.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 01:05:34 -0700 (PDT)
Message-ID: <2920d8da-4298-82e9-7d41-f00892a03e29@linaro.org>
Date: Mon, 19 Jun 2023 10:05:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] hw/net/i82596: Include missing
 'exec/address-spaces.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20230619074153.44268-1-philmd@linaro.org>
 <20230619074153.44268-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619074153.44268-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 09:41, Philippe Mathieu-Daudé wrote:
> hw/net/i82596.c access the global 'address_space_memory'
> calling the ld/st_phys() API. address_space_memory is
> declared in "exec/address-spaces.h". Currently this header
> is indirectly pulled in via another header. Explicitly include
> it to avoid when refactoring unrelated headers:
> 
>    hw/net/i82596.c:91:23: error: use of undeclared identifier 'address_space_memory'; did you mean 'address_space_destroy'?
>      return ldub_phys(&address_space_memory, addr);
>                        ^~~~~~~~~~~~~~~~~~~~
>                        address_space_destroy
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/net/i82596.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

