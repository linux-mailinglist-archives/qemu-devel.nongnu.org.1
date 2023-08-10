Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A557780F8
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 21:03:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUAvR-00047I-EP; Thu, 10 Aug 2023 15:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUAvO-00046x-Vp
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:02:22 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUAvM-0004nz-W4
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:02:22 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bd99c7b3e2so8234525ad.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691694139; x=1692298939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8e55NR5/t5QYbd8hG7i/D0JykSsu8dQrhmMs0zGhOoU=;
 b=gv5plG40HhCstz3NSVu0LKu3IFiB7eJJQDrt9NRPtLEp4DxH3SKl9yO697acp8oO4r
 uocL8Bs5N2WeqOFFPFspnjARO+2JIUNNV68atMtPIZ0G0y7kReeabarXjiMwWZAEwbWl
 Ul6fqaYmWMCW5ARjpvUffVX9bN43yFf31ff2c/+j4F8nb+/+jemAeFJqimy1LLDhTpPm
 /iD1HnEsMu+D2U3UZx7wZNvBJXGqiBAEno3ki4+0rfZZJnHls8V+xUYfPPp87IJJyWZh
 6SfSeUgyk3L4aBJcaKlk7nrtU7R+W774OZ4bs0vqgsYdYPOrzc7Wwy+AhH6kFDnQPo7m
 KIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691694139; x=1692298939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8e55NR5/t5QYbd8hG7i/D0JykSsu8dQrhmMs0zGhOoU=;
 b=TA/UHJF+3C12y1lQcpGJTf/Hqgx6obuafRliWL1wgrpzfgXxihWpxzM4CG+LiVCDAH
 /ocvw85F8Xv1CLfBLFlNBL/qePrWFBKDmvTPQWcotMzSc2/iNim9sriW1SHcY4OqacsC
 Irrz0Zx24Pd9ljiv+46AKhVBQevey/PNNh8iKJCr16VEqDZWkJKT3JRZbq2radqaCv70
 3bf9xerZec7DlKucZy72PXPmSQqnH4cI5SrGP8nxG8SDtH48Z4Wn/Yi5D+dXYRzB2Xus
 N37u/AorcTngNTwMo7gpS7zH3VPtZ9Zrdcv2o3Q99rD4IzfYbaCAsyHaJAhWjP+u827C
 9mog==
X-Gm-Message-State: AOJu0YxuF3b4NI9wZMrZhP2TJ9puBKRDHyIqxQ+v0J+UfoHfibboMaxe
 3J/8Cy7zO0QNqbgWiHAV+ZDoTQ==
X-Google-Smtp-Source: AGHT+IE+FrE/UBLZuCmaHF+KRqhKSB/Z9iqYSmZFlt941LboHRFXWAAFT2VNmqG0xA/bkuRPkzedrA==
X-Received: by 2002:a17:902:6941:b0:1ac:8be5:8787 with SMTP id
 k1-20020a170902694100b001ac8be58787mr2677121plt.21.1691694138972; 
 Thu, 10 Aug 2023 12:02:18 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:9e4d:b830:d4fd:9164?
 ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 1-20020a170902ee4100b001bb8be10a84sm2132683plo.304.2023.08.10.12.02.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 12:02:18 -0700 (PDT)
Message-ID: <d3674431-8eff-bdc1-9f96-c294e429718e@linaro.org>
Date: Thu, 10 Aug 2023 12:02:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/5] target/arm: Reduce dcz_blocksize to uint8_t
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230810023548.412310-1-richard.henderson@linaro.org>
 <20230810023548.412310-3-richard.henderson@linaro.org>
 <CAFEAcA9JC_-R5AsvmtBK+ngb7LEuvaxU_7UT2U+jDvze7CqyxQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9JC_-R5AsvmtBK+ngb7LEuvaxU_7UT2U+jDvze7CqyxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
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

On 8/10/23 07:09, Peter Maydell wrote:
> On Thu, 10 Aug 2023 at 03:37, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This value is only 4 bits wide.
> 
> True. Any particular reason to change the type, though?

To save space.


r~

> 
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/cpu.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM


