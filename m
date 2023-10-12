Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C67F7C6787
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 10:25:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqqzt-0005PI-Gc; Thu, 12 Oct 2023 04:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqqzq-0005O4-Tp
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 04:24:42 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqqzo-0007rX-Av
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 04:24:42 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32d885e97e2so678793f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 01:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697099079; x=1697703879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z0B/zUQt4r9Sd9Z0pRfhOqwpjiNd9udYAUApKHcIwPA=;
 b=ONkR0cHKH3uS4aCqhqipSUSL7ivLg9RCCF7L5Ly+UbcyfNU7d4qbHCWLIkokbAPqWZ
 12ixicIQbnDb31zwwfYobOO3TlR9NerhR9hk993rXc5Bf3hYD19bSeBGmVWnV7HuJuaL
 /JMNQdVywvmGoG/E837Wj260yLpi+UTkcMiUAxJCsnbK2tUSiP7yKjp10pRvQT6F1pxa
 aH9lX4A8eyZ7Da9N9spBA21sweY6xqKBIUxDKObAS/ptbOnFGRXRsOSX2OCfVTrAqnPu
 OdGOkMpIo4NZ7j32+OWTaC2FjOo2HvxAAFyI4Nupx7Ue/mTNA9EpN5GdwuZj/Uyk/7hG
 aoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697099079; x=1697703879;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0B/zUQt4r9Sd9Z0pRfhOqwpjiNd9udYAUApKHcIwPA=;
 b=o6fU149a41UePScMZOwB+Y/v65uK9/fBFbFvq+Xiuq2ZhvOJP5OdWmdvjPLc03kbkb
 2/+SpVKKRSQDir4FDJJh3DVRTaveL0ezk5IfssMZN93QITF2QXYzoZJXrk1onPBpwW2S
 oYr7HcHUfwOzw/oP3sZQUGZZoRTM1T9s8cMoc6gDr00XmoFwjvqqE5mG2HA2+RQoqno3
 jSDQxNM+VKYjHKiWR5KeVaVGqj3ST9iYZphOztCfcegjXNvY/k9WHLXQX4xZ+v2+m7h3
 lMaf65EO4bCc4IFOT38HTgeoGCnJMHM3EN1Pz/MLcfGrZxBGLxvHZo1j7F1V42bolPdk
 Jd9g==
X-Gm-Message-State: AOJu0YyDnlV013guPuGwcir7CKRCYd+sq8YFGFZhITik9y0JHzxjPO9Y
 Yo4zPIb3PE/HMt3y/HhmcReDiLzPEkLs4Lq7a+8bXQ==
X-Google-Smtp-Source: AGHT+IESvyr/dyHa3eGJMTqPQm58iINOwrNg5kxtGvK7diJKgFWZSjPUo5HwWvLKfIeYgWd1yb2qIg==
X-Received: by 2002:a05:6000:84:b0:32d:570b:c0a4 with SMTP id
 m4-20020a056000008400b0032d570bc0a4mr5547266wrx.27.1697099078685; 
 Thu, 12 Oct 2023 01:24:38 -0700 (PDT)
Received: from [192.168.26.175] (192.red-88-28-24.dynamicip.rima-tde.net.
 [88.28.24.192]) by smtp.gmail.com with ESMTPSA id
 w16-20020adf8bd0000000b0032d81837433sm4938766wra.30.2023.10.12.01.24.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 01:24:38 -0700 (PDT)
Message-ID: <df9bd85f-fae3-140b-9f5f-cfc198aff611@linaro.org>
Date: Thu, 12 Oct 2023 10:24:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] hw/loongarch/virt: Remove unused 'loongarch_virt_pm'
 region
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, richard.henderson@linaro.org, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn
References: <20231012072351.1409344-1-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231012072351.1409344-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 12/10/23 09:23, Song Gao wrote:
> The system test shutdown uses the 'loongarch_virt_pm' region.
> We can use the write AcpiFadtData.sleep_clt register to realize the shutdown.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c                 | 48 +----------------------------
>   tests/tcg/loongarch64/system/boot.S |  7 +++--
>   2 files changed, 5 insertions(+), 50 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


