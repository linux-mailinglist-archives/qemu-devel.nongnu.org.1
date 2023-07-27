Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BA9766089
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 02:10:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPAmJ-00036k-8S; Thu, 27 Jul 2023 19:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPAmH-00036b-OH
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:52:17 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPAmF-0001RE-Mb
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:52:17 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-267ffa7e441so1083152a91.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 16:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690501934; x=1691106734;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0XyNgCHCsYz04Jk6gTK0hdoPhBowKTtWi9C/iSWfenc=;
 b=PTLe1axylaHpsFegMUJrkHh9gM/LbQ6TMu/u1FmkTWrugZ85cGsaqx/7J484y7n5vr
 JY88eOuaoHzPA9OkGeSH8yCG0IqRXydUnBVIBEP456gmkvn1sEWb2xvfmEM3+71rqVTm
 09UHWu2I7+XJuyb2Kx7EN/lB6RDXtmqLUkVf70oWnKBipuwJWfaDpZPv8P4vL9q2mqz5
 jBal42hp4B4NRxWjgLQ9bQPASEUAeEQDm6olzekFPtv023Z5Rr8lu+n2hsVk7oAZNXb8
 Htm7PLY9yrVPzcgoCmS4tc6mLRbwF/7OpgEgjbfcz6tj7dQdcsQqbfpyvbxRrXRvisxv
 yRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690501934; x=1691106734;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0XyNgCHCsYz04Jk6gTK0hdoPhBowKTtWi9C/iSWfenc=;
 b=SLGRckqS1Mx+fEbK2y0mNn4ZzAARZVBJAlGBDMiZnyK9ISTbBYUkN1ECmTKFkdwBs5
 +TJcj+1czWXh+qoydJtIIWnu99RfVdJUEEruBdHb2EJSGSlxTMAaOtewYKZ+aDTq6meB
 Yv6CpRAzmvdTWQqzNEPEKFcV/JLDu7Ys/M2NJP4YMqEWyDAfv+ZueJ3FSbPDI8UfGAvJ
 1mam+b75LSH1J3YjvsBSa1Pk6s/pmjItPopgSHRCKSJ+jjQlVSD/9bieRzDAZ+nRyLEn
 S4Q1zFcYmgkliqcyezgwpfRmRhkFqXQym7hovFII3gni6gso4d6RyFg8tyP3d6vyxebt
 XSPQ==
X-Gm-Message-State: ABy/qLY9zcKCK1XaXYWDmo9C6BGDlInQ4ZSyPLMbVgolYnTVvtLK4H7d
 wqikOgzzLbjovVmWJP4RNpbQbg==
X-Google-Smtp-Source: APBJJlGKveFOR8/v3l+dNh1KDjY8Y9yHNWstyj5oXGjEelVmXttYRKYBLpyWhO5pF1YRJgFP0RoG/w==
X-Received: by 2002:a17:90b:897:b0:261:685:95b6 with SMTP id
 bj23-20020a17090b089700b00261068595b6mr88071pjb.13.1690501934228; 
 Thu, 27 Jul 2023 16:52:14 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:943b:b6e1:1f00:9721?
 ([2602:ae:154e:c001:943b:b6e1:1f00:9721])
 by smtp.gmail.com with ESMTPSA id
 gz24-20020a17090b0ed800b002677739860fsm1607433pjb.34.2023.07.27.16.52.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 16:52:13 -0700 (PDT)
Message-ID: <efe27780-e634-0be0-8dd3-0415892c21a9@linaro.org>
Date: Thu, 27 Jul 2023 16:52:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 7/9] include/exec: Widen tlb_hit/tlb_hit_page()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org, agraf@csgraf.de,
 dirty@apple.com, rbolshakov@ddn.com, anielhb413@gmail.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
References: <20230721205827.7502-1-anjo@rev.ng>
 <20230721205827.7502-8-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230721205827.7502-8-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/21/23 13:58, Anton Johansson wrote:
> tlb_addr is changed from target_ulong to uint64_t to match the type of
> a CPUTLBEntry value, and the addressed is changed to vaddr.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/exec/cpu-all.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

