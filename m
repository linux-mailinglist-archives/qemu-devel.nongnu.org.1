Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6217E208E
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:56:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzyD7-0005ax-7v; Mon, 06 Nov 2023 06:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzyCx-0005Zh-Hh
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:55:55 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzyCv-0007Hm-Qf
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:55:55 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40839652b97so33045095e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271752; x=1699876552; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/aL6guVbdZxtt19lArb3y/b2R7I3V7jwG48PeLFbpe4=;
 b=UVw9GDg6TgKJZegCgGo8DAhUGIs2Lk7Vns6u+1DpkRm3dl/jc/h/+MudlBRaFSESeh
 O7U4jsD6U3Hckh+HKTzhxzZwclwDd3TxQLunOla40MVWlOofxnuqLvMY/sCwvk4rhr+m
 8274AXqRhIqNJ0mHFGgcCoh1Bom5rGv15MuppXJkXAVz/0SH1LoDoF6GY8dMHJUblb3x
 0kLrKM6n+EIECJ0Reelm3P/BT6s97Hkk+9O5KaYSST/f01D/NDVQw/bHpXWf1yuAo63X
 lwAnW3X9j7Xy9aFPIJgOzFCJf+tNU9FH9HNvVCayRZcseRmn/u1+HS7CiiguZ7Jzc2ed
 RZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271752; x=1699876552;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/aL6guVbdZxtt19lArb3y/b2R7I3V7jwG48PeLFbpe4=;
 b=fM7PW0Rh1rXWZIZfAdc4sxM/Dss7zb14/j/LcybrHEXq/toym+uImiew7QjzUXZwHs
 einXJKUsf9tYMBfKWxDizdhHffwra25uMqB01cURBfLlnKsUHthPpb5EQMJdHWDvEMHE
 WHhJCF4RJakhg2fqV+38Rr12M5+DALFIiWnzFw8tNPQIPoAWIH17Qr/wNkKDg+/Vr/ar
 I3itd5xWCrdxbY8yaxMf7KSadmYO1Dmb8QoT6Nd79tp0svr6s6+QKcrsnSvVfmfgaBo7
 EfK/RzMQu0qMOq1EWI7yYNcB1QXBpuKBe0ReWUrHSVxeFHtekLmIjTmtH4PvS5eR5IVD
 zWgg==
X-Gm-Message-State: AOJu0Yy5xNbuGQwYkIBz/uRDjWzO38MQzfxmgeJ/2FtA/6rtgkUcpnDS
 H3z2PBHy5dmp6TUziaUBMEZGeA==
X-Google-Smtp-Source: AGHT+IGXmMdzzBKpUWoctMOT40Y3kjgeKhDr7E7YCCrMq4Yh/8ZQlXXThbomuJUdXkfKYYve5F82QQ==
X-Received: by 2002:a05:600c:c0f:b0:409:50b4:3da8 with SMTP id
 fm15-20020a05600c0c0f00b0040950b43da8mr15272001wmb.38.1699271752277; 
 Mon, 06 Nov 2023 03:55:52 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 ha7-20020a05600c860700b004080f0376a0sm11687455wmb.42.2023.11.06.03.55.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 03:55:51 -0800 (PST)
Message-ID: <a19becb2-6f32-2ea1-fd4d-5800bd120923@linaro.org>
Date: Mon, 6 Nov 2023 12:55:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 53/71] hw/sensor: Constify VMState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-54-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-54-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 6/11/23 07:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/sensor/adm1272.c        | 2 +-
>   hw/sensor/dps310.c         | 2 +-
>   hw/sensor/emc141x.c        | 2 +-
>   hw/sensor/lsm303dlhc_mag.c | 2 +-
>   hw/sensor/max31785.c       | 2 +-
>   hw/sensor/max34451.c       | 2 +-
>   hw/sensor/tmp105.c         | 6 +++---
>   hw/sensor/tmp421.c         | 2 +-
>   8 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Possibly another one in hw/sensor/adm1266.c if
https://lore.kernel.org/qemu-devel/20231106110336.358-54-philmd@linaro.org/
gets merged.

