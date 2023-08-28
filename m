Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 815AB78B62F
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:17:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qafre-0001Fa-82; Mon, 28 Aug 2023 13:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qafrZ-0001Dk-VH
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:17:18 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qafrX-0006ES-RB
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:17:17 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68a440a8a20so3019195b3a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693243034; x=1693847834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FaPIQJI0old0u0VJRWlDyIazJvGv4g7Ob034ojLBFdw=;
 b=ZTFbLhIw1DZDse5Y08V5f9RbkoXi7wwKSWeSrlJmHz8qKSFqqs9O5xyuc1JSYX3Uzd
 So33OEt8ahos90KKGuHbcdnweZTxnNpGUeSn7Q2SOLT6sJax2oe5lmPw7U2YBuqgrkq4
 XET83o2k9bgRlP0ID1xOu1ShNM4CH8E7iysfp+XZU0tzIqXDmJkkNCIdXa7T9JDq288t
 0+wdKGWuwJzGXf7pNfo1AwcciMsCv/9y3b9Mdmx8FzNmy70SwsmJOgw4nFAcd0S3nyWH
 vS9j1GFsK2oM9m2Az/Lyfk+wQM4qeJHyjp4orkcWAUlqBK5G/cqyFqsAkzdYq+/0qQwA
 KR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693243034; x=1693847834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FaPIQJI0old0u0VJRWlDyIazJvGv4g7Ob034ojLBFdw=;
 b=ZK5rZpEqmLT5ohGPOWJPxxKPyTOkEqnjCm2j1209aZZ7Cjf899XxeZVzOJbJ5UuWSh
 tZJWFZwuQuNEck+vVqT1eoWpKumgGbzxp41zHaaEOuZvrUrX3TEW43toZo9zfR5PCn4b
 jUiezxos06ALcqGZ5Wn2Lx9KekyDc1f24pANH3wQMUdLDBi6nYErwzNCDL4fQEmkM5Q5
 x1K4/S2C5MKSEjuMImEbhujBVrMC0AVEGm/LGEkwAnRV02phsMJQDbycG1zqyYEbZk5z
 aqQNq8u7l0qWMTBONfUwNYi9VPjMAJAE7vlnhWk77y4oqbhwdyBH0Q5UfxjScwLJyJMm
 AurA==
X-Gm-Message-State: AOJu0Yz/vYezoQGcZJz0/XS7x3kz1yLHj3h2WfsA+bIxwf9QQ3oUEyu9
 x5Y0sZRys/thB+Us+z2MTaOjog==
X-Google-Smtp-Source: AGHT+IER13q2KQwPlqS44jiFNKlnnsCawSG4hwcK/mq+OUXdNZF+IGlQSIIx/5OnuaqX3APvahxZ1g==
X-Received: by 2002:a05:6a00:330e:b0:68c:57c7:1eb0 with SMTP id
 cq14-20020a056a00330e00b0068c57c71eb0mr2569997pfb.11.1693243034184; 
 Mon, 28 Aug 2023 10:17:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a62ea14000000b006887b69f034sm6868888pfh.102.2023.08.28.10.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 10:17:13 -0700 (PDT)
Message-ID: <005212a9-b0c0-303b-2a93-e38b8f14544e@linaro.org>
Date: Mon, 28 Aug 2023 10:17:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/11] tcg/loongarch64: Lower vector bitwise operations
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, WANG Xuerui <git@xen0n.name>
References: <20230828152009.352048-1-c@jia.je>
 <20230828152009.352048-6-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828152009.352048-6-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 8/28/23 08:19, Jiajie Chen wrote:
> Lower the following ops:
> 
> - and_vec
> - andc_vec
> - or_vec
> - orc_vec
> - xor_vec
> - nor_vec
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 35 ++++++++++++++++++++++++++++++++
>   tcg/loongarch64/tcg-target.h     |  6 +++---
>   2 files changed, 38 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

