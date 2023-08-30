Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 494BA78E355
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 01:38:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbUl5-0003KQ-UY; Wed, 30 Aug 2023 19:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUl3-0003K2-W6
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:37:58 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUl1-0002DQ-Qj
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:37:57 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso1499145ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 16:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693438674; x=1694043474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=opGRtcvl41uAK41vvbSUnXlu41fZ3z+s71gGlxyVwO8=;
 b=nZHAeKuNd6VKzNSydMyShYP3pRxKUHu3jsItUQyQuh01lv2WB888VsjNw6Z1nexeWR
 Ie7du36H7nxvqMQJUz7wZdWMAGpP7zf9iBV5X2JTXItuqsyScqvhuqst5rfmQDNCRSsQ
 AFE3w8eiV2pOrnX9rBtsCeAosk4k1Ii9Wj3ehhgjui4HSwk0Ga6RY9I13K75Cz1ZyA/a
 cpl+5Dqude81SUJ3WBGuJvn49zwNlerCHvN+hR3T+/k7Vwb7YII92LVDvoEjs8fY7ob0
 qJll88xq5vRD2UblKrCZH/jQrAJceYBBYmQeHgs4CKa20AJfuBM4q3KCXZQczJDCp77I
 Ez4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693438674; x=1694043474;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=opGRtcvl41uAK41vvbSUnXlu41fZ3z+s71gGlxyVwO8=;
 b=RRg1vsiJdqZpKhYPqLnvezhq/zuk+DzP9DMQ3Of/RZCh8ngwaGGsaVSocxWMApfq2J
 iq9xf30XG4y76WPMUgjkZsqud2Hf8BIUtoUzLqGCcG3OVFRs7wExv0LkOl3s/O7nE/iF
 ZZrsCuuBgLLPWCMqutLvOGd14P8QobEn2euTe4LM+8Ylx7dW7hvUVgIXQR89R7VMxIU8
 /NIJ3eY9ei6URVRxVkFfAu4MJnLKl0x+FfnTIecun+7qw6VBQCCQuZZzGyaIikirn1Z3
 1EFqPmmV8rRNkqe4YBaC1yInd0Gj/ZAadj9o1/nlkkENTnLjVr1TNLlfXSNaUSRMYkde
 AtnA==
X-Gm-Message-State: AOJu0YxC+WjpMAHZm7oXU89hpJZ7Jbf+vFN1ocbF8wgO/7Wt82Xbx5hI
 HpzUBvCb+J0Fk/NzjCGUsrEGPg==
X-Google-Smtp-Source: AGHT+IFFn/WfDNMSOPq76r1f2al+RxbV3JGQ8HEFiJuQFGUPJgd1OXfdAMLTQSJmIDbA9OgZ9CGWLw==
X-Received: by 2002:a17:902:efc1:b0:1bc:506a:58f2 with SMTP id
 ja1-20020a170902efc100b001bc506a58f2mr3140385plb.46.1693438674122; 
 Wed, 30 Aug 2023 16:37:54 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a170902da8300b001bdc2fdcf7esm49906plx.129.2023.08.30.16.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 16:37:53 -0700 (PDT)
Message-ID: <7ca72907-2271-1a9a-98b7-249363e1eabe@linaro.org>
Date: Wed, 30 Aug 2023 16:37:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 38/48] target/loongarch: Implement LASX fpu arith
 instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-39-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-39-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> This patch includes:
> - XVF{ADD/SUB/MUL/DIV}.{S/D};
> - XVF{MADD/MSUB/NMADD/NMSUB}.{S/D};
> - XVF{MAX/MIN}.{S/D};
> - XVF{MAXA/MINA}.{S/D};
> - XVFLOGB.{S/D};
> - XVFCLASS.{S/D};
> - XVF{SQRT/RECIP/RSQRT}.{S/D}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode                | 41 ++++++++++
>   target/loongarch/disas.c                     | 46 +++++++++++
>   target/loongarch/vec_helper.c                | 82 +++++++++++---------
>   target/loongarch/insn_trans/trans_lasx.c.inc | 41 ++++++++++
>   4 files changed, 172 insertions(+), 38 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

