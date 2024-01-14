Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E15CD82D29F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 00:56:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPAJU-0005eQ-KJ; Sun, 14 Jan 2024 18:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPAJS-0005dJ-6X
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 18:54:46 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPAJQ-0007y6-Lq
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 18:54:45 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6db81c6287dso253980b3a.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 15:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705276482; x=1705881282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vb3snNAQBuA2VQyRq3zqnzAi6jZkbIu2pbpUjjHqvwA=;
 b=w2L+52aVCWSp3JASIczsm2yA5omymYuN8veZ+RfvPCpV21UrHlEUruF/ErwCY4ojdz
 8IgXOy1Yv3yfxZguHmBbpN/WSoIjqTS2CJLtNM6mOksTDQFoQHhyBvkUB1EL6wzu7/27
 xDd05ZkplR/PGAp+9VEMfMNdBQlcWrnL0eXZQbA4LXKdXI0zBoiSp5BVo1zQHMBYxhrw
 TmxaKE3L+Mb+ulUaYYpnXROd7NySxpphzjuzxPmRqocRBSN+mRwtMWd3rMfhtYeFZ9hN
 CUnPSXEodQYE6HEPYRezpT2JKiFhBH9IBRGQp7DTICsSokbVQ7NrE9FVEjGtAF+yaexM
 Z/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705276482; x=1705881282;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vb3snNAQBuA2VQyRq3zqnzAi6jZkbIu2pbpUjjHqvwA=;
 b=Yojk91MmM4ucpPPlgGE3Pc9p2H4p8ZvBBhVhzzm9b3FgFF7ZyB/3Uq9cr+Fhnm/L7J
 5okmuxtzQVS/4RE+7VGjO3iH2jtiiFjjQbOVkWlgt6JJgdSM+1d4YkPA2vh6YvjtP0SD
 Tl66WlI97/kGsAKztdrySCWDTNfH1QQYXj3b6GejPwbrczsrNYOGrodMrvpgphD2RLXz
 836Nv+qAnup2jHg2JDb2g3JUCyJNN784hGyAs4wjUVXd3TWyBo992RCpIpSUOSDnxDIO
 +zHcqWduxP8MYQPXfQT7tptYIkHb370Bj4MdtfIOWm54xeUZnDF4jRb5cjlKqAEq/w6k
 9spQ==
X-Gm-Message-State: AOJu0Yz7HKh/YfEaP/hJJjq/Mpb1vxrIu8xGHpaL0uBmK39+1MmXVpEm
 eL0kqlOYiQDH4SqKdKwO6/jY90/N9vwuhQ==
X-Google-Smtp-Source: AGHT+IG8MiZu5ZkZuVwYhaJJfLg8/AcFSHy4H8+mNl0m9qQ9Nu7IG5BW62U97vTu6z1xERl6LjcWAQ==
X-Received: by 2002:a05:6a20:e608:b0:19a:e84a:fff with SMTP id
 my8-20020a056a20e60800b0019ae84a0fffmr1663032pzb.46.1705276482643; 
 Sun, 14 Jan 2024 15:54:42 -0800 (PST)
Received: from [192.168.1.57] ([1.145.66.112])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a63e350000000b005ce472f2d0fsm6942749pgj.66.2024.01.14.15.54.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jan 2024 15:54:42 -0800 (PST)
Message-ID: <d9de433a-9ec8-45d5-80f5-bd8b83c67d34@linaro.org>
Date: Mon, 15 Jan 2024 10:52:19 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/21] linux-user/riscv: Add vdso
To: Vineet Gupta <vineetg@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Edwin Lu <ewlu@rivosinc.com>, gnu-toolchain <gnu-toolchain@rivosinc.com>,
 Palmer Dabbelt <palmer@rivosinc.com>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
 <20231030211727.165090-16-richard.henderson@linaro.org>
 <d5265d3a-7df7-4f93-93c4-a5d3a6251372@rivosinc.com>
 <119848b9-0cd7-4d33-bc43-385c86069388@linaro.org>
 <b84e0809-669f-49c9-8163-847485cfe7e4@rivosinc.com>
 <db63ee9b-901a-48ab-beca-4275e12a88d0@linaro.org>
 <6a328673-c30f-4947-8d2f-0c70441c55ce@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6a328673-c30f-4947-8d2f-0c70441c55ce@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/13/24 11:22, Vineet Gupta wrote:
> Now we just need to debug what in the vdso call frame information is
> wrong and any pointers to debug that would be appreciated, even if you
> are able to fix it right away ;-)

The only way is to step through uw_frame_state_for() in libgcc and figure out what's wrong 
with the unwind information.  Probably with a simultaneous debugging of setup_rt_frame() 
in qemu in order to compare addresses.

I thought I had enough _Static_asserts added so that any mistakes would be caught at 
compile time, but obviously not.  I'll have a look.


r~

