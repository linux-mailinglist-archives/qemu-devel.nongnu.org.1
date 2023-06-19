Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6717734C13
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:06:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB8xH-0004T2-Gh; Mon, 19 Jun 2023 03:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB8xF-0004RN-1e
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:05:37 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB8xB-0005II-8U
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:05:36 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f769c37d26so3817147e87.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687158329; x=1689750329;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XAqe97nizz/My4OBzz6Cnwo17WHaNMKCWhzgZLTBGYI=;
 b=RQriIboYmsK+IgFIWlEIpRo/ObrufFxIXIqi/qUbqcxJ250pbFtu/vbxW06bEU2As4
 Bcz1z424Kck2eeml0laOn5uRhiVH/e6qNE8ONnQAc2dLGW4CHltfujWtQjkNAUPYguOu
 s3S+m76547EGmyqvQsd2k4nX27HdYcjDmgYKNEbu39ZyEWew634wMBwoPZfCRzd8GsuU
 wPMVlpk550VMX3DL89a2dX0MbqI5JfisBSBU8ONajomKfys1naxnB7P/x2GCirtqTYeW
 6gXjlPrMRHwVie+CB1KljLw+Gam/j8cRQStHN/qkiesposuZx/I58ekseUIRRG5kwoUj
 fyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687158329; x=1689750329;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XAqe97nizz/My4OBzz6Cnwo17WHaNMKCWhzgZLTBGYI=;
 b=Bx9+D583FkkUUUQ80GMGVGifOQiNA6NhJdGZwcZDUXHvwHsu3+iKiBrnFm2atrg2de
 IUf3nAsASWJbrCw3CMhsNJj9MMwYhvvh0MPjVdBiBD5DQQpSWlMTXenV2q0qtVuB6Bdx
 Unr/mXL7FyWEcMo56O8xUd9BnhGNzNttfqKdy1JW0suO87cLmnzs9YkVOCzcAaQGxYy9
 6UAAhNOGgtZPBhewJO3B0PPqQnJ9hy717dQD6TM0GoOjkXUUgF9rx44qto4BqhkMpExp
 30ZdymIWwHuOfrHXuv/bCzHtEKNaEUmVkBu34GZR7CXe3SkeHWCtgywU36dck2usJser
 GC0Q==
X-Gm-Message-State: AC+VfDzWV7in9RWKhAhlD04OmBLyRzXCqCAplaXhKjalAIGdPfeSY/Au
 +CxA0lP5Y0F3sGFmylNSk5nHQQ==
X-Google-Smtp-Source: ACHHUZ49rVcNhHM7Ia8Xf5QjomIRKBgAfHnwPTN2kbkuwCXsUwe0X3y848EjHFx/GYMe+lzgNbCN8g==
X-Received: by 2002:a2e:8296:0:b0:2b4:76f6:63a8 with SMTP id
 y22-20020a2e8296000000b002b476f663a8mr1116892ljg.12.1687158329303; 
 Mon, 19 Jun 2023 00:05:29 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 c25-20020a05600c0ad900b003f18b942338sm9756832wmr.3.2023.06.19.00.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 00:05:28 -0700 (PDT)
Message-ID: <c3259ff3-e986-06b9-4b92-26469a9e3679@linaro.org>
Date: Mon, 19 Jun 2023 09:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5/6] util/async-teardown: Use qemu_close_range() to
 close fds
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230616152737.23545-1-bmeng@tinylab.org>
 <20230616152737.23545-6-bmeng@tinylab.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230616152737.23545-6-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
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

On 6/16/23 17:27, Bin Meng wrote:
> +    qemu_close_range(0, ~0U);

This is clearly assuming that close_range exists.

Should qemu_close_range attempt to lower last if >= _SC_OPEN_MAX?
Or better to use that here.


r~

