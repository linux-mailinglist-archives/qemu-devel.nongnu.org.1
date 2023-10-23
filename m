Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C657D42E6
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 00:52:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv3lC-0005cN-UX; Mon, 23 Oct 2023 18:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv3lA-0005bs-0b
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 18:50:57 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv3l7-0001oc-TY
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 18:50:55 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1e9ac336589so2762362fac.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 15:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698101451; x=1698706251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KWyDEZPagJlMaLIZxGrNdVp1KZYSebN0dCF4nHEh4yo=;
 b=A+0+MYY5duHFZ1UU0pugqAsEkZznzVZGM2miJgdc0nDIQ4aJxq1JONH06gxEujMb6V
 s9okDtpXY1y/hEfWQa+lMHlM9kUsan2yy4BBZxK/gFL3szVNMAbcE6uBGbh8L0IFUK03
 w+JkHqbIbHT5C8HybMHCugpzEDh4k1D7l7OtVSyoqr8ORuX07Y86XdvjVxa4bPPVMGR7
 kspDAJEColWDZ6XVV5Mgs8CoEfWzod0JHgZTNUbLJtN1HmKmtUT44IoOk9d/R/u/7aOL
 wTXe7IzTtnwY2ECL/O12yrnnzwvhEhhLfkBAowumvEYKue6SgHtbKaJ375Hq7NXCU7eA
 Ilfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698101451; x=1698706251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KWyDEZPagJlMaLIZxGrNdVp1KZYSebN0dCF4nHEh4yo=;
 b=ogS75nvUxyEdgP7u3VTb8Dl5CmayWaxeJo27SBTFPaqqRXrf4z4rFBH69UKj/j5TXX
 IY0od1CzFh4PNTGbxJZYiMOjfCWNfdKQpj39+7rcUaYLzGtOkpt27g0kNlZA72wXxsS4
 Z7OfhpwpcI6TJ6b/o/Q9wtknWWFROSJaK8JMuElEfFZyjLZGupMSuHM3mTS2a6AGO3Ds
 ZulrmA90KK5uNgV44+nShFiuTN/HBxilkrwuOp9hck0E6FRu0IREaZXa/egC7JqUO0XW
 Tlv6C0knaNffk9KBukZ/EbVU43L9e07rU172FrMjMzXat4694NWZyMnO3+XiJJ13KYuF
 BiuA==
X-Gm-Message-State: AOJu0Yw1TdQc1Kbz/gtKsI4KFNm7YzXGly5dCPfiNjf+2xxvtnKsLB4V
 /0PZXeeRiDjHE9i1qWZ9cWXhKA==
X-Google-Smtp-Source: AGHT+IEVYB8NcZr4brMsz6kmlQdctZo0ZKt/nvWulSFb3GyKUR5nE1DM7NgCZixKYXEb2ejIlMH1Jg==
X-Received: by 2002:a05:6870:7907:b0:1d5:8fb8:98ef with SMTP id
 hg7-20020a056870790700b001d58fb898efmr14384979oab.31.1698101451380; 
 Mon, 23 Oct 2023 15:50:51 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 v12-20020a63f20c000000b005b32d6b4f2fsm6245632pgh.81.2023.10.23.15.50.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 15:50:50 -0700 (PDT)
Message-ID: <c84297bd-7e51-4d39-a78c-01acc4071514@linaro.org>
Date: Mon, 23 Oct 2023 15:50:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/loongarch: Add am{swap/add}[_db].{b/h}
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20231023153029.269211-2-c@jia.je>
 <20231023153029.269211-4-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231023153029.269211-4-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/23/23 08:29, Jiajie Chen wrote:
> The new instructions are introduced in LoongArch v1.1:
> 
> - amswap.b
> - amswap.h
> - amadd.b
> - amadd.h
> - amswap_db.b
> - amswap_db.h
> - amadd_db.b
> - amadd_db.h
> 
> The instructions are gated by CPUCFG2.LAM_BH.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>

Except for the use of MO_TESB,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

