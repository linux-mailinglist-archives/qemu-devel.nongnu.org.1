Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4443F7792D1
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 17:19:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUTuD-00087X-1g; Fri, 11 Aug 2023 11:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUTuB-000879-8m
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:18:23 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUTu9-0007vh-FJ
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:18:23 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bc73a2b0easo15978905ad.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 08:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691767100; x=1692371900;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=So6T/DK2nYqbNPN3py5XJkbU6qHsf0SZlljjv130jIE=;
 b=PqrTCol+J/c8OIha+xu3EcHHrxhVKprhElLYYZPEJTNbeLTfMvWyMeVOUwJbBMcgT1
 JcUlR7faNUFt7SFQDbGDI0y+jKTwyBWrPDKNmRIw325xc4uRJSe6IB6cdy2B0PbeYsEg
 4ESARpbQDPDCiED2joDZFoHv8uT8mdsVYwx92mT0RNjmjDolurKfOjZttcewfmgkoN3H
 Y83Cwq9bKDfVUzQDBg+GGOYR3yUuAcOYCzK/oL65cq74JKHUQ5KXyr1LSeU/A9Nx7Fzm
 u+0trckD1DTLCDxsbnp/g26rskEGfMPoo/xoomy2+08G9Q5/xYAvdKQyoy8ZBHfrW/R5
 Lfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691767100; x=1692371900;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=So6T/DK2nYqbNPN3py5XJkbU6qHsf0SZlljjv130jIE=;
 b=QpFQWDPDh5wW3eU9H1cKHpoq3U2hvkVG7sXCC3ecHLa1ABhd1wLA2CUQpLQSrJ7Gb2
 xx2nae2lHhT/Q0EGKjlCMm1eUtDiRYP8Puvf9iLCE38UymQt0UAVzOuOdBeRj2bJtX1h
 9uqbv3sYQnWG8PO88gI8HNsTZfj8Hfz1EbsoVfRV49rFOl07OtaKr3Yysfb23OLiHfv5
 mYJhrfPXsEl0ANyTc+RSldRYD9ALWlyg01i7/XzjpCroJvxrkkm6vX5h3VdfJVkPWuMv
 2Nr2zAOKV+xOEkBULBpelr5NO0smQYMvGsec8tx9UILCIJtCMBwxYef6FwlMS17cizsI
 7YsA==
X-Gm-Message-State: AOJu0Yxw+uxaaCnIs2sYqWz2H+WOUEr9caPPgTbEy3FAR/s8zxdlgmoT
 JSpWwMRiKypkMVNXwaDNhLl8ydJa0wKrTVZL658=
X-Google-Smtp-Source: AGHT+IEwnotT5AjVzGiG1R0z084shkhcdgG2kAkf6rKUu9c8bns1KBNNmeSjcqfLtDpXJozAowhcDQ==
X-Received: by 2002:a17:902:8d83:b0:1bb:f82f:fb93 with SMTP id
 v3-20020a1709028d8300b001bbf82ffb93mr1588048plo.2.1691767099842; 
 Fri, 11 Aug 2023 08:18:19 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:e773:351d:2db2:8a8a?
 ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a1709026b0c00b001bbc9e36d55sm4021402plk.268.2023.08.11.08.18.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 08:18:19 -0700 (PDT)
Message-ID: <ea9dbc59-b1af-5abc-55d0-f4e4e85f99c9@linaro.org>
Date: Fri, 11 Aug 2023 08:18:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 08/11] target/loongarch: Reject la64-only instructions
 in la32 mode
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, Jiajie Chen <c@jia.je>,
 qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, i.qemu@xen0n.name,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230809083258.1787464-1-c@jia.je>
 <20230809083258.1787464-9-c@jia.je>
 <b87f51eb-6e82-5ecd-5412-5a892c9510d1@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b87f51eb-6e82-5ecd-5412-5a892c9510d1@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
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

On 8/11/23 01:12, gaosong wrote:
>> +TRANS_64(sra_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d)
>>   TRANS(rotr_w, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
> TRANS_64(rotr_w, ...)
...
>>   TRANS(rotri_w, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
> TRANS_64(rotri_w, ...)
> 
> I see the manual from https://www.loongson.cn/download/index
> 
> insn cpucfg also not support on la32.


I see all 3 of these, ROTR.W, ROTRI.W and CPUCFG listed in Table 2 at

https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#overview-of-basic-integer-instructions


r~

