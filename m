Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE43F7A30D0
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 16:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhVvH-0004DA-EF; Sat, 16 Sep 2023 10:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhVvF-0004Cz-Mn
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 10:05:21 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhVvE-0005N6-1a
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 10:05:21 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso23721025ad.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 07:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694873118; x=1695477918; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tUdCXusw34LMhPGf/olzk0oM9ArVYpQgXJWWCeYXEog=;
 b=LJwYAb4m1xyQkHOpSeZ1YAtiG35CNJujimoBvqynbDtSY6BDU81u4pTovAbvFswEEU
 D/qP9eKnXgZytoyXUzGvDQ/UXfQp4hwrPIu+Uq2Sq+ay3G/0gWJHEM6BRnot8L5r6z7C
 TxLlZh66iSZi7Kgcdt/hhkcoUxc9KLfjJFZGxHoIYg917b4+6miWtJQaxdHU4YxrSeP/
 VTcDBqwGk/rWNnAak/D5GzAVegELcyeR1vlfTvy8OK4On+j3ktLlA5G2Ol1cIn4RaDwS
 GTSbsFy1MSf5Y+YJaNuhVukD8bbZvpdki1yK9R29ZyqeyBs8SjhgiE876fJtn7d2mpsz
 5azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694873118; x=1695477918;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tUdCXusw34LMhPGf/olzk0oM9ArVYpQgXJWWCeYXEog=;
 b=F+LX7BRvSKGpT2ZkpvmptJNNSDLwfF8rl0Ol8O8Jj5jzLX+9KQ3K90q/DHENCi7L38
 89eaKwH4NNpgz2Ay8DnZ9S/IGIidlhGUyeJ6gZBPAVkttIwnJ+AsQPL65njCR8Y6ehQd
 Bg4HxTI98YMxPL0Du4Pu+IL5zI/LbmkbId/xBkdPOt2ky+N87MFAK2Rg0mNk0EdFDujS
 eg2PLPyc+B7aGYE3zrU/9r1JnrUHlygJDdSH9Sjz3smZSl8U3mCuANhjX0I6UwM6sHiV
 UunWx92NBd8eKbS2NccvP72X532DGYXb1mv/8AmyyyNHYkQqTyTinL8VgDKghndsrzjg
 cfnQ==
X-Gm-Message-State: AOJu0Yw7Nt4jnAFga/VQQPHOnHRHS+gKdGF5L0cV4qqJ3IRBojyWQ411
 xmKNmFvQ/s3MsKFothdXRnHf2lAmV+SGjWxsFws=
X-Google-Smtp-Source: AGHT+IHvP8Vv769WqZGM71JmR5YSxlIzfXpZAbf+sr+A7jtsNnbfK9MSoJkzVaq4SGhzvJNopfNhFg==
X-Received: by 2002:a17:902:e744:b0:1bb:30c5:835a with SMTP id
 p4-20020a170902e74400b001bb30c5835amr4945510plf.7.1694873118198; 
 Sat, 16 Sep 2023 07:05:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a1709028c9100b001bf52834696sm5260965plo.207.2023.09.16.07.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Sep 2023 07:05:17 -0700 (PDT)
Message-ID: <8b41cece-1c57-14b4-44de-866caa409d58@linaro.org>
Date: Sat, 16 Sep 2023 07:05:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 54/57] target/loongarch: Implement xvshuf xvperm{i}
 xvshuf4i
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230914022645.1151356-1-gaosong@loongson.cn>
 <20230914022645.1151356-55-gaosong@loongson.cn>
 <8c58b6b0-730c-36b1-c3f0-d4e51597c3e5@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8c58b6b0-730c-36b1-c3f0-d4e51597c3e5@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 9/16/23 00:55, gaosong wrote:
> Hi, Richard
> 
> Could you review this patch?  it's the lastet patch no review.
> 
> Thanks.
> Song Gao
> 
> 
> 在 2023/9/14 上午10:26, Song Gao 写道:
>> This patch includes:
>> - XVSHUF.{B/H/W/D};
>> - XVPERM.W;
>> - XVSHUF4i.{B/H/W/D};
>> - XVPERMI.{W/D/Q};
>> - XVEXTRINS.{B/H/W/D}.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/helper.h                   |   3 +
>>   target/loongarch/insns.decode               |  21 +++
>>   target/loongarch/disas.c                    |  21 +++
>>   target/loongarch/vec_helper.c               | 146 ++++++++++++++------
>>   target/loongarch/insn_trans/trans_vec.c.inc |  30 +++-
>>   5 files changed, 175 insertions(+), 46 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

