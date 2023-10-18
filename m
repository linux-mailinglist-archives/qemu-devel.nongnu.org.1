Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8717E7CD356
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 07:03:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsyi5-0006XG-Ez; Wed, 18 Oct 2023 01:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsyi4-0006Tr-4V
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 01:03:08 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsyi1-0003V2-V4
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 01:03:07 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso5346690f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 22:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697605383; x=1698210183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z1UBsv8xTpsNQKsz+oMHxs/WYEMDgK4yy/kJz1PlCWY=;
 b=IXW0kAIz5ceYhD+FuebYgK6zbTx8jwKlfJ82TzV56YhBxFW+CwhkZN+yzIT5bhRVT6
 Vs93SDlZVrVv7tEKj+kfkMKKTEqbFF7OYzfgjBgEITdtacNQs8/lfMLJIni3+AumFo1J
 UHfEmJ77PslvNJGqsJG3Baf/IMeSEBd7OrKuE6DiTj0+agWOJGdd5prDaGlUGjQftl7D
 bhWPesNEqiMHBFq4sW+7Laq2evLlhLr02VUw1XyS51BaT6VckuXYs+dap4acafnpCc47
 zSUR1VrRF+LoRJwjj0NlKNHIgFDEytZ5x9NV7xyeyAZXIljv1VTyh6lpYNkSOZg6UQdx
 GnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697605383; x=1698210183;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z1UBsv8xTpsNQKsz+oMHxs/WYEMDgK4yy/kJz1PlCWY=;
 b=pZO3c/NCGBFBBS4ACrO6Ot/lzKAWGKXhwma9eVQfY1UPopBgSCN8LDnLiplxT88rCr
 TIGF+9oesCLHL8K/6tZ7NqsXTND0UDKu/i8+I9cI5Hxl8aE8KSzRtCTko0LXqlgFgpj/
 iDLTs1JjYOx4Le+IuRRU/iTCZjXnw3Cgb+FV1PpCe/0PtCcu+88D8uaJmspdabCR40Ey
 IpHLZOhRoM9qaM8bqewbX1uQXsbyplkwDtlAZ+6seUKD2SYlAE48s83fhVsjNNFoO15m
 MzL1l38hBVIaxOL82sVzKgUhyDYlBSHwq2FRdeRDI2GxfksLVFBAAKCVhLaRsi+tbU5R
 IJzg==
X-Gm-Message-State: AOJu0Yy01yZiCD4B//sh9vJR9CAm53jWUgoxi7atCnq0/f09bP2SYcmb
 V6JbaH8G3IorZbhoRfMzV4s5Kw==
X-Google-Smtp-Source: AGHT+IF0frWFCkt/UncbriSh/iMTEZE/2VXlShZQTPI/U6mJkw3ikRBLXGKJ7KQPD7PKbBUThPpo8g==
X-Received: by 2002:a5d:4990:0:b0:32d:9b52:e7a4 with SMTP id
 r16-20020a5d4990000000b0032d9b52e7a4mr3744446wrq.17.1697605383297; 
 Tue, 17 Oct 2023 22:03:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a5d5592000000b0032da471c0c1sm1190973wrv.7.2023.10.17.22.03.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 22:03:02 -0700 (PDT)
Message-ID: <578cafa3-8a6a-91dc-eb32-80ae1ec4ae9c@linaro.org>
Date: Wed, 18 Oct 2023 07:03:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] tcg: Add tcg_gen_{ld,st}_i128
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231013175109.124308-1-richard.henderson@linaro.org>
 <20231013175109.124308-2-richard.henderson@linaro.org>
 <33e8747b-7a0e-ad9a-8328-1bba68b5572f@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <33e8747b-7a0e-ad9a-8328-1bba68b5572f@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 18/10/23 03:19, gaosong wrote:
> 在 2023/10/14 上午1:51, Richard Henderson 写道:
>> Do not require the translators to jump through concat and
>> extract of i64 in order to move values to and from  env.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg-op-common.h |  3 +++
>>   tcg/tcg-op.c                | 22 ++++++++++++++++++++++
>>   2 files changed, 25 insertions(+)
> Reviewed-by: Song Gao <gaosong@loongson.cn>

And per 
https://lore.kernel.org/qemu-devel/88015945-49f7-195b-7e78-08d9281d10d6@loongson.cn/:

Tested-by: Song Gao <gaosong@loongson.cn>


