Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC30799C38
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 03:04:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf8rX-0007IQ-DO; Sat, 09 Sep 2023 21:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf8rP-0007G7-4Y
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 21:03:35 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf8rL-0006N5-Vs
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 21:03:34 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c39bc0439bso3603165ad.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 18:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694307809; x=1694912609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CPkVKAOfzfoWc61MLIAaycvE8zxfklaxHTEnzmPJrTE=;
 b=I5jz+8ZniuSa2s0Dt9JbZugPvL1s9WlO4Okc/0iXSWlukpwaK2qbzop8phwUO5yjvb
 a866FwZFDo1hugYvvjQLCMt8McKdSzpaLAj7q/Q8gcZbWLIWrR1XMnU89foOSD/EFIKR
 +L08AOLUD7qlWKZJt3dmqh9Ua0QQ8e1UFv7b0SlCu4f54NPTLEQ2pZ1D2soTjFAi9yQ7
 xHRVxBi1BhWhLkkqWVSkVWkL45lZ0IyMLQiOx2F0NWAVbR6U3rHAqP9WCc4Hgikl0hUT
 FnQRjNdISHA9r2qyCd85RQ++RmTP8KLpHnegwo8jgaKx2m/KXUHXbo0EIVKzOTEmi3vU
 mASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694307809; x=1694912609;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CPkVKAOfzfoWc61MLIAaycvE8zxfklaxHTEnzmPJrTE=;
 b=AruZuuj7O3cXnUBTJIHa8NFuupXE5ns2QbSo5d/dMLLfXBkTYO4jM3VI0vfoxzHLov
 bnH8jnUpTngFUUknAMfP4kYQZhzMcJqFnksRlEJZa0DKZTlgPVBr9+0kLOZfAG/UfaMN
 ExF/g7XjKB3h7TdErv1zC16a05BE5qi7AarvLLeZ98G0aHYqZQTYZVVO8vlx+opMSHSd
 ZIguLlCyHm7p5qxvSP1L2yFyQdXUwN4H0XcSVdZiwptGz6X7edfv4KNneXKmi+P/hnbP
 WFkjC2qMIVKAwIXoSVLmNbF7wFSCXH5TNLHZk6ljckIzFvYkbwp2CK8JZ1i93WiKHG/K
 vpFw==
X-Gm-Message-State: AOJu0YztOB4mTdYrDi8qAHNWXzncrGebPzOoD9bCWx5DgHobb9NLQVxE
 +pnpgSyTu2tIQl8hTVYBI0uO768QDSGEvmXuPrw=
X-Google-Smtp-Source: AGHT+IHbQxpNAzc9sO56aBXYfb7HVnlIkWTb2wDV8N0xrQstEuYegefeZ83OiwZ6448ENAWtxFirsw==
X-Received: by 2002:a17:902:e88b:b0:1bb:cd5a:ba53 with SMTP id
 w11-20020a170902e88b00b001bbcd5aba53mr13452993plg.14.1694307809329; 
 Sat, 09 Sep 2023 18:03:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 x18-20020a170902ec9200b001bbd1562e75sm3791024plg.55.2023.09.09.18.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 18:03:28 -0700 (PDT)
Message-ID: <76ed0648-6217-fc14-d277-1216383ec49f@linaro.org>
Date: Sat, 9 Sep 2023 18:03:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 09/57] target/loongarch: Use gen_helper_gvec_2i
 for 2OP + imm vector instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-10-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-10-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 9/7/23 01:31, Song Gao wrote:
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/helper.h                   | 146 +++----
>   target/loongarch/vec_helper.c               | 445 +++++++++-----------
>   target/loongarch/insn_trans/trans_vec.c.inc |  18 +-
>   3 files changed, 291 insertions(+), 318 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

