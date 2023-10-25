Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC0B7D6154
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 07:53:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvWo3-00064V-CO; Wed, 25 Oct 2023 01:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWo1-00063v-9V
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:51:49 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWnz-00054V-7Z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:51:49 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5b8f68ba4e5so888145a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698213106; x=1698817906;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TBFIow2hH/JaDs5sLq6CgDtHJ0Hj4bpR/MWqGNToE5I=;
 b=oju6cHxRESNgrppMyt2TTJYTQW3YMGPPWu3mZEdOOkpsTtSL8MnwVe+q0Acb3x8u3F
 MHnMLNcfFkTOsRpSW1hcVxtucLJQ5Z4kVgdoE+qpqZPtt2ynI0mJuy8KqNFTld8RsoAR
 VdJRlUa8v+46dgGnMznJfPE8oiurW2QYvciNtTC6rjR/SWXl687gLi2J6hQ/XL3B5Tah
 o5EJUt6+tD4IX8ygClvc2RPHxu9YiiBN/hGKWdQ9znw8JfuBbPcH/ybhmTol3WQXKOsF
 cIC9vYcLQrGrAxinjLcAKFubzHT0OZGGMsudKKRGbcteTaPFLv4psWORsoE3gg3IgzEu
 IGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698213106; x=1698817906;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TBFIow2hH/JaDs5sLq6CgDtHJ0Hj4bpR/MWqGNToE5I=;
 b=bkWS8wnNOuvmBy+RGB6UF5ARiwmE7ooEjg7BH5YYncjauchhKMo9jbqtLCIlR/bOgd
 0JhKzQq10M14dSkd8Hk8ajB06n2qED+80MN5TQxSimFFNZVA4bzhs5vJB6zkhWOzFeCO
 AnLQOtVTvqQM7iOvJKAu/i6xi57kUtBZBzrwEDb2U9Sqiyx4nVIj7Vsots1vUXj/y4tP
 6TXEIvzsdAtwSBSpMSdM33nnw14J4bkUarZIamAtMaDxlB23ilG70vB1LGyfE1HnoKiG
 YmAwBFIsP9SDIfVkAPK4AKN1L2fDTC1MR65l6ZRs9uRy8jKORPZ+8YKsVnxHHWzLK8Q8
 JMrQ==
X-Gm-Message-State: AOJu0Yw+9joXGS8LpkQDF4phVkjqQNTHC3XiSBBR3YLGZj2llE7zVcpd
 czhBEq964KDmphaj5y4PwR+g5A==
X-Google-Smtp-Source: AGHT+IFH+hJwgRuzHSSZmDydjWmFE8I05uJsIV5QOnZiPolNOuuonGfNr98aJ6Yh8Hs2/Mbf8yFSKw==
X-Received: by 2002:a05:6a21:a592:b0:156:e1ce:d4a1 with SMTP id
 gd18-20020a056a21a59200b00156e1ced4a1mr6355785pzc.9.1698213105816; 
 Tue, 24 Oct 2023 22:51:45 -0700 (PDT)
Received: from [157.82.204.207] ([157.82.204.207])
 by smtp.gmail.com with ESMTPSA id
 q21-20020a631f55000000b0059b2316be86sm8009719pgm.46.2023.10.24.22.51.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 22:51:45 -0700 (PDT)
Message-ID: <186c2393-0a88-46dc-a215-f9a5edddb47b@daynix.com>
Date: Wed, 25 Oct 2023 14:51:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/18] plugins: Allow to read registers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Cc: Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20231019102657.129512-1-akihiko.odaki@daynix.com>
 <87cyx40wq6.fsf@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87cyx40wq6.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/25 2:08, Alex Bennée wrote:
> 
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> Based-on: <20231019101030.128431-1-akihiko.odaki@daynix.com>
>> ("[PATCH v5 0/6] gdbstub and TCG plugin improvements")
>>
>> I and other people in the University of Tokyo, where I research processor
>> design, found TCG plugins are very useful for processor design
>> exploration.
> 
> So I reviewed this on top of my gdbstub/next series so needed to make
> some tweaks as I didn't have the riscv misa_mxl patches from above
> because there still seems to be some debate about them.

I think we have sorted out major design questions but two patches in 
"[PATCH v5 0/6] gdbstub and TCG plugin improvements" still have no 
Reviewed-by or Acked-by. Namely,
   [PATCH v4 3/5] target/riscv: Move misa_mxl_max to class
   [PATCH v4 4/5] target/riscv: Validate misa_mxl_max only once

Can anyone interested in RISC-V look at them?

Regards,
Akihiko Odaki

