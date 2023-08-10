Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EECFA77810E
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 21:12:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUB3o-0006gt-0H; Thu, 10 Aug 2023 15:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUB3m-0006fk-Qc
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:11:02 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUB3l-0006HK-AZ
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:11:02 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso11266525ad.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691694659; x=1692299459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1dPyWzHu7diDYuuF+y/q8xst7+qAPYRhO3VTAThnUEo=;
 b=NucXWAG1cRuXtMI9C5CfJlVfSw7LruDbIe5AvZwIycHh0W63uGPqIPaVHlUrXKC4Ho
 FGLmkZYlIiZIxMtA1uN8rnvcZYH6jLGmnEJ8084AvFYnM0d1zNAaJeV2J1Z5WnuRU1LF
 avH75q95AcxESoZ0WNx6XRoa8e0wwVi0uFrezgbP8HXbHR+1v8z0KN+4zo8181psKYvb
 NJukcLC0OWPDyNL5nE31/2vtm8819YKG3AiwKF8LkVN2e467W3ZEBXeAW5ehdjJadtLu
 OfEblbvIpgeR3MSl54t3i8olqNlL22Gu6DRe8CcJiauX1zh60jtKGNIBJ/jnyGhx46RQ
 Ue0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691694659; x=1692299459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1dPyWzHu7diDYuuF+y/q8xst7+qAPYRhO3VTAThnUEo=;
 b=JsHYKKEw9ubmpBzF+1eJ2+TlHJpDoNtjS502/wdZomAZFk0hEW56Cf/DaoX74+iAUZ
 5MBLFkuAuHd6tkUvpJqmotSMb/1b5ygTHzp/EPXhzwsBxSB01A1O2gGmg/qYjOqno60q
 7XsCyL0Sm2oEYlRzC9UnRsdQcciA5f/ZIkj9MEWDyLlEiDrEeEehseRXUU9bkCmYs5nK
 6zn0g+9Vv7CfJT3wW3zDNfuZnjlk5hvjXzUBM4GSlB/JBL+jyldzHVqpYExDb3hTQVKy
 Zdk33qIT/klqVS1VCgmAw1FUPYAptxGW56brR7izfUB7O8i2cLKb0W48/8s4PiFLHGlm
 E8qg==
X-Gm-Message-State: AOJu0YwVduFanDrg9MyXwd/xUJnQ4Hjv29ri/SL/8ys0T0YT8UO7vFwX
 EL/RfX+FGFB10q2jCK7K4uBku3oyW+o2yuyFNgE=
X-Google-Smtp-Source: AGHT+IEO+GTL+7/alAljT7bLUtlj+PURseQYaqJvFo+NL13lO5Xobslg82v5tiAUArJiukQasv0jGA==
X-Received: by 2002:a17:902:f801:b0:1bd:b073:a55e with SMTP id
 ix1-20020a170902f80100b001bdb073a55emr1137238plb.5.1691694659707; 
 Thu, 10 Aug 2023 12:10:59 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:9e4d:b830:d4fd:9164?
 ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a170903018600b001bbdf32f011sm2122436plg.269.2023.08.10.12.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 12:10:59 -0700 (PDT)
Message-ID: <8793650b-4e48-c4c1-be75-1f79692496d7@linaro.org>
Date: Thu, 10 Aug 2023 12:10:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/5] target/arm: Support more GM blocksizes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230810023548.412310-1-richard.henderson@linaro.org>
 <20230810023548.412310-5-richard.henderson@linaro.org>
 <CAFEAcA8YcX0qq392chnpVdB2-qjk7Jb-4gBEu-e2uDGka3Ccvg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8YcX0qq392chnpVdB2-qjk7Jb-4gBEu-e2uDGka3Ccvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 8/10/23 07:23, Peter Maydell wrote:
>> +    case 4:
>> +        /* 64 bytes -> 4 tags -> 16 result bits */
>> +        ret = cpu_to_le16(*(uint16_t *)tag_mem);
> 
> Does this really make a difference compared to ldw_le_p() ?

ldw_le_p uses memcpy, though only mips and sparc hosts do not have unaligned reads, so 
perhaps it doesn't make much difference.

I had originally been thinking about atomicity, but then noticed that the pseudocode uses 
a loop and so the instruction is therefore non-atomic.


> Is it worth having an assert in CPU realize for an invalid
> blocksize, so that we can catch duff ID register values
> without having to rely on there being a test run that
> uses ldgm/stgm ?

Yes, that's a good idea.


r~

