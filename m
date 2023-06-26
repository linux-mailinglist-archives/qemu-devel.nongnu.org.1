Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F4773E157
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:00:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmkq-0005dg-Ow; Mon, 26 Jun 2023 09:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDmko-0005dF-RR
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:59:42 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDmkn-0007eK-1R
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:59:42 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-313f363a6f1so905189f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687787979; x=1690379979;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qG+cGB9l3NF1JXUtt4vTsDiGdvEOXy9H7M9M7poWpQs=;
 b=hKGBOq94PbFY2sWsqD0Rih3tHpvHZAVzjlhQslnwU8wBDIBMVuBDYVeLNBulfz0yuD
 qFhAN0K7BClbg1bG0uc7ulGkPYI0qbgX/SdPGqAxnN4OX97ti+O8eHxvYsCLHZSx2+N5
 qTQJinYc98BflDoo4oid6Cu+EgOdlbgXnjvOqgQb51UNcto1s2hLPrgtYO0OQYyurfhw
 EXGrhbtIIcuclqqiZ0LH9BQMW+FKWV1hHl+L26SDH0o8bfDENZ5Gp+PpLBIgvnGnVjaR
 67rgNO64Yo7VRmxU6dXuXaAO8FOXSIklqghfVVXD+x/ErGJEfyPGa0h1BPhqoLPbMtcm
 uh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687787979; x=1690379979;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qG+cGB9l3NF1JXUtt4vTsDiGdvEOXy9H7M9M7poWpQs=;
 b=U3B1iIwN9uBI4yB9vt2H+ZFkgLBTMAt52YEcsqelNFE//mo4KuowyU/19ONS7u1toM
 FXBWo8UAWNmqFGUUxsrb9HBPlaYKf5qA1vwiC56gPWFqUA337z6Caqb0r2yIFrCl1EiY
 gakmP3Fh0I4sGCbpW34PESm6b//eEOxqpByP/BEYkFezaKkgQHnCa6qjB6q+xPWhmnl2
 lif1GVhHTWEcvwxGR9ZKjP1VUOcdwRrH4ezXGGel8UhBTRY2AopFPb0IjAR2mYfetENX
 uMCoOKG4780GTZMDxkngw3Lpa0hul30XX51KE7agl882R7S2w66qApi6ZvSh/y0ZnebR
 hNVg==
X-Gm-Message-State: AC+VfDz8wxkOkOpGDfjY/nl1c6azmAr3PMjbccjEGuGji+356W+4RwzN
 2CuE9KP2u9K0HB23zYX6fI2gaA==
X-Google-Smtp-Source: ACHHUZ5Q++GvjDLRV6oH12FHL67LjTjEsA+SoVEEl39PkA9vl/PvI87inxqSZgfsL/T+NJk7tK7BBg==
X-Received: by 2002:adf:f887:0:b0:313:e08e:5599 with SMTP id
 u7-20020adff887000000b00313e08e5599mr5800228wrp.67.1687787979446; 
 Mon, 26 Jun 2023 06:59:39 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a5d504a000000b00313e8dc7facsm5669322wrt.116.2023.06.26.06.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 06:59:39 -0700 (PDT)
Message-ID: <98f4a7b1-bd4b-7975-cf39-8c5a10df5150@linaro.org>
Date: Mon, 26 Jun 2023 15:59:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 11/12] accel/tcg: Replace target_ulong with vaddr in
 page_*()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, eduardo@habkost.net, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com
References: <20230621135633.1649-1-anjo@rev.ng>
 <20230621135633.1649-12-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230621135633.1649-12-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/21/23 15:56, Anton Johansson via wrote:
> Use vaddr for guest virtual addresses for functions dealing with page
> flags.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/user-exec.c        | 44 +++++++++++++++++-------------------
>   include/exec/cpu-all.h       | 10 ++++----
>   include/exec/translate-all.h |  2 +-
>   3 files changed, 27 insertions(+), 29 deletions(-)

This causes other failures, such as

https://gitlab.com/rth7680/qemu/-/jobs/4540151776#L4468

qemu-hppa: ../accel/tcg/user-exec.c:490: page_set_flags: Assertion `last <= 
GUEST_ADDR_MAX' failed.

which is caused by

#8  0x00005555556e5b77 in do_shmat (cpu_env=cpu_env@entry=0x555556274378,
     shmid=54, shmaddr=<optimized out>, shmflg=0)
     at ../src/linux-user/syscall.c:4598

4598	    page_set_flags(raddr, raddr + shm_info.shm_segsz - 1,
4599	                   PAGE_VALID | PAGE_RESET | PAGE_READ |
4600	                   (shmflg & SHM_RDONLY ? 0 : PAGE_WRITE));

The host shm_info.shm_segsz is uint64_t, which means that the whole expression gets 
converted to uint64_t.  With this patch, it is not properly truncated to a guest address.

In this particular case, raddr is signed (abi_long), which is a mistake.  Fixing that 
avoids this particular error.

But since user-only is outside of the scope of this work, I'm going to drop this patch for 
now.


r~

