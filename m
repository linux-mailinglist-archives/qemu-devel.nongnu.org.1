Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AC8799B6E
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 23:32:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf5Ye-0000Ca-NQ; Sat, 09 Sep 2023 17:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf5Yc-0000CA-KE
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 17:31:58 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf5Ya-0005Hq-FC
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 17:31:58 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-573f722b86eso2339016a12.1
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 14:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694295115; x=1694899915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0D+zoqviSDLMVx8e2naBcrIc//S9u9IlCOkNcli4Xgs=;
 b=p+DPf9P6mS9z8RqB7AfO+dyomYSaKtZ+PCfrPDT9USpUTSjyP97xHyZpjuAwYcGDPk
 SdEc0rCNHI5g0mDza3JE454QVOIM59EaLLCkrWiz2vqfW4RK7eaco2TKinCIb5gCkqr4
 0gS7UyGZeda+8KWFgraBFnFu4ok4rgmu60qVcM0x5x3zC5ZgNZBgTzdxY4UGwCQ7NAlS
 E3oIK1d/vKy3GTwBntqM4GsEy2n0fQbkgxvKfiiqqVk/hzxMynx9M3wbQVRMUkWCydQt
 D7pMkoJWMLPD1dFvOe+n78ydvOdFvRzIj5Vt2ko2tUwGG8iX8UgSFRQK7vZldy226QdK
 aEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694295115; x=1694899915;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0D+zoqviSDLMVx8e2naBcrIc//S9u9IlCOkNcli4Xgs=;
 b=WPoijuj/1WMFzgLAjmDBjw6g8+DxRyZzoHthIaEaDftBDTiW/hhIN2EbVgCOT7Yzba
 11znu7f2VcR8k/jkae9SQxoJrF2AktmzTyQpPgttxKbm+4NpcJ4BFnE/dcZqCG2057WU
 JJwhhZix2iDtwBNYxfPyIrVdUoe5ZdtgYdb4L2rdPrBrURtFtq9haIq+Qzv2xVVfDF2O
 GXLTd+iO5ihaKCzuQ/eSTLej21idCCECIDn08tfKxQi05SY0r+5Y2Rdnx5Q7LEaNRRTH
 m8JWzg/D7X7dNrz6BiD2IzAUSidz/Rwdly0wnfulk3i+RxsJdfGzXbbCTOFk7gPZIiOO
 3Xmw==
X-Gm-Message-State: AOJu0YydjvZnG1Iak4YWf9KqXQzvc8re5fiaw5d3rEHxQj6OW/3AMUfy
 UPzNOx4zrI1B07kaAdQHhTbjaQ==
X-Google-Smtp-Source: AGHT+IFwz9XVCl2NDWBw5727eNWCTFVcehIiw+U2e6SagNs52b5+cL/uBIFqaLQnE+OAZRdnVTYY2g==
X-Received: by 2002:a17:90a:164f:b0:273:4bbc:c3d0 with SMTP id
 x15-20020a17090a164f00b002734bbcc3d0mr4800547pje.27.1694295114884; 
 Sat, 09 Sep 2023 14:31:54 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 ga24-20020a17090b039800b0026b41363887sm4924378pjb.27.2023.09.09.14.31.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 14:31:54 -0700 (PDT)
Message-ID: <b68ab7d3-d3d3-9f81-569d-454ae9c11b16@linaro.org>
Date: Sat, 9 Sep 2023 14:31:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/1] accel/tcg: Fix the comment for CPUTLBEntryFull
Content-Language: en-US
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20230901060118.379-1-zhiwei_liu@linux.alibaba.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230901060118.379-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 8/31/23 23:01, LIU Zhiwei wrote:
> When memory region is ram, the lower TARGET_PAGE_BITS is not the
> physical section number. Instead, its value is always 0.
> 
> Add comment and assert to make it clear.
> 
> Signed-off-by: LIU Zhiwei<zhiwei_liu@linux.alibaba.com>
> ---
>   accel/tcg/cputlb.c      | 11 +++++++----
>   include/exec/cpu-defs.h | 12 ++++++------
>   2 files changed, 13 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued to tcg-next.


r~

