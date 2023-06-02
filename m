Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B80F3720ABB
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 23:02:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5BuA-0006Ex-S8; Fri, 02 Jun 2023 17:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5Bu8-00069P-64
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:01:48 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5Bu6-0004k8-Jx
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:01:47 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-651ffcc1d3dso1471037b3a.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 14:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685739705; x=1688331705;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rfpw67tqnazZcvniRDP+9SPQmzu+ny679sOtzV+qA3k=;
 b=C+OFtPD39VOUCoQkGdGr0iS6J8A3nMlPQjCLf3dnAc8F6LLi2jrnz6IlyLfSTKE+Q4
 N9NMxt3UsuopvmqGpOFe5wO5ILrOzUGi4d3bHvVHrP4MWkMVqLZRjQw/M94fIWnIR9Ef
 TA8RaBgXaADX9oMthF3ANvJxKDiSEpJKSPfB8SWmSM2hcoLofM52sjH4foFDCxV6tGcp
 7dIb6KU59XcO8LjkekHkp5ZopEUUMPLHB75B/k36z61ebByFTHNDay9x2mhQnbchcYOc
 DhEXL5nHldB0Vm//dcJNQhRkJtizVtk2CmvihrDDGouLI4PCKpIXQw5PMoXz5EeOWGp8
 +gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685739705; x=1688331705;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rfpw67tqnazZcvniRDP+9SPQmzu+ny679sOtzV+qA3k=;
 b=XCxtaS3kBCS5Sn/WEbocWWivrB1/uW7fgCxdX8jTbiT6hBjyNMqzH6fX6jfKX7Q3n/
 J0yCzesfEby8OHcnozwV0E1Ultt9zNQ8TW1wwQ5ZEEaLiK/A5m2pmZKZSdBItraOCEkk
 1deUNUmF+1/riWO+7ti51+ymbK3g0LhZv9F43NifyFsshK+DUORNnCRln0luZ02Q9tUz
 eld/OzTeaMHAsxc5y9ryBvnY5us0zTS4LM/wvYwY+scezixm9IPadYAkgb0/FYfam8Bl
 DgS1kleC8AcXtzKYIPLi38Y2jCD0XH2ji0CiYT04FDlORT7r1k+f2TK4kTeoDqjM+VQH
 V6tw==
X-Gm-Message-State: AC+VfDxF9CHO9sX32BcQPdLrOYA5JZJcpJ2mhdFZeDyts+OSDI4jMzS7
 Y5ZYHCufkE0AWh6UzBI5uTsKcg==
X-Google-Smtp-Source: ACHHUZ4w55pnjxwuWV3MVvQ4playDYiVoYxMFgVUufi8uDKywwWpNkQ9x4z5MA/tR4Y0knENnZrufA==
X-Received: by 2002:a05:6a00:c8e:b0:653:cfa8:dc51 with SMTP id
 a14-20020a056a000c8e00b00653cfa8dc51mr1536758pfv.22.1685739705062; 
 Fri, 02 Jun 2023 14:01:45 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a62bd0a000000b0063b86aff031sm1369037pff.108.2023.06.02.14.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 14:01:44 -0700 (PDT)
Message-ID: <01547b15-1a1a-f1e4-627d-3bf2477a69b9@linaro.org>
Date: Fri, 2 Jun 2023 14:01:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] target/riscv: Remove check on mode for MPRV
Content-Language: en-US
To: Weiwei Li <liweiwei@iscas.ac.cn>, Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
References: <20230529121719.179507-1-liweiwei@iscas.ac.cn>
 <20230529121719.179507-3-liweiwei@iscas.ac.cn>
 <CAKmqyKPmXXoVdSndTF+aF7A-3PqVrnw-NFG26sQQicxybwWpQA@mail.gmail.com>
 <18e4da39-cbd4-aa60-7628-7105a788b6e8@iscas.ac.cn>
 <CAKmqyKMP0aX=_3ffQXSNQ0pWCjeXEF+h=QgPbL80=0J8v_gOrA@mail.gmail.com>
 <be90143f-1c8b-eb31-3c75-ae9846f00a22@iscas.ac.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <be90143f-1c8b-eb31-3c75-ae9846f00a22@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/1/23 18:31, Weiwei Li wrote:
> Even though MPRV normally can be set to 1 in M mode, it seems possible to set it to 1 in 
> other mode by gdbstub.

That would seem to be a gdbstub bug, since it is cleared on exit from M-mode, and cannot 
be set again until we re-enter M-mode.


r~

