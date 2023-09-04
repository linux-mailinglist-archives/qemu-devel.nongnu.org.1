Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A77D791913
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 15:46:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd9uW-0002Jq-A8; Mon, 04 Sep 2023 09:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd9uH-0002IE-OO
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:46:21 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd9uF-0004dh-EN
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:46:21 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50087d47d4dso2507024e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 06:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693835178; x=1694439978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y1/9yHxhR/RjzLVaCkZST93HX1zcDr7VO983zyArYbY=;
 b=fLZPz2CD5R6VwbH6mzi4J8miwRvFOUX4UqpZkql0pU2mTIuaLq0N3kT9D0h4iG8zPF
 PILrjeKZfk+lNvgv3zgAK+tswLKfIaUMSvenj2dUNXmHvHjS57kAD+q5Gh54jeO1jb2n
 Uy1r45acrNooptw15u9J26Uc9l4woVqk+lDQGyMiglJVd6y4t3Mc/7d85H6HMGPoHxZX
 SqJwyycoNm5fQRIXMHGoKdEGv7Q3ff1451z/1zxmVB357v/qyMBgH7kkY/dB5jpiOlQe
 PRkE7mw2Jb0S8tnwrKqiB/Zcv+Sdb5/Om42u5uwtNEclzX2INa4mK6xcmXtJZd3aNkSC
 Ei3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693835178; x=1694439978;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y1/9yHxhR/RjzLVaCkZST93HX1zcDr7VO983zyArYbY=;
 b=ZH1Lb0FsiKV2yda43wqPwY5aVdAZ2VQbGzdunf4heW+jkD80AiGhS1TtkD/rl3e6u5
 uZzgTQyZLtjW+uOK2VBxOlsYMiHlHjXC+VO9rTGwhvwP6CgoFfTy9cghEeLQ3jsWpm71
 sj/AFb86QJxyzoOL8X9+KBhAi6G+BaLH+A1QwKid/Pl+9b2hbQmcZEiY7I+TPqbj/TwS
 qPDoKBUGabqg8qkqiQ7o6FvrfVvGvGKnr0zeo6SlccZMiZ/h2NY8KqHblH9Hb4G6exMh
 EXxA916v+Bw09930X9JzYx18+L6H1UPNzEurjQivumlW+/rbUs0ARRdUQeb+YjYE3a8B
 e3Bw==
X-Gm-Message-State: AOJu0YzCKpXvy1mEgXtVdWkqAH6oUK4sV6akldsCec1Il5OpnTMR1mRC
 Gie1hz5mUR6pzr1KkrYDHVTJwg==
X-Google-Smtp-Source: AGHT+IEx/ADFu+ggbqe0qHOBB/D30C3Xm43xVFRvIBtxSoRHK5wBGxhHaJnG0FU2g6UE0V30v++HMw==
X-Received: by 2002:a05:6512:b8e:b0:4fe:3e89:fcb2 with SMTP id
 b14-20020a0565120b8e00b004fe3e89fcb2mr8266245lfv.34.1693835177794; 
 Mon, 04 Sep 2023 06:46:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 t3-20020aa7d4c3000000b0051bed21a635sm5818208edr.74.2023.09.04.06.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 06:46:17 -0700 (PDT)
Message-ID: <b4c9daf6-e262-18b7-b100-5e904fd0758b@linaro.org>
Date: Mon, 4 Sep 2023 15:46:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 3/4] hw/cxl/cxl_device: Replace magic number in CXLError
 definition
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Dave Jiang <dave.jiang@intel.com>, 
 linuxarm@huawei.com
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
 <20230904132806.6094-4-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904132806.6094-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

On 4/9/23 15:28, Jonathan Cameron wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Replace the magic number 32 with CXL_RAS_ERR_HEADER_NUM for better code
> readability and maintainability.

Thanks :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   include/hw/cxl/cxl_device.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


