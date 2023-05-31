Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAE5718465
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:12:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MYI-0005Ih-4a; Wed, 31 May 2023 10:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MYG-0005IH-2h
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:11:48 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MYD-0008JQ-J7
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:11:47 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30c2bd52f82so320062f8f.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 07:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685542304; x=1688134304;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bidlw002eB0fLQ7ttTGOGjugWJDqRVOFDANiarByciI=;
 b=Ly6NVreQD/Es8SH9jZGvyXBQUo2605i1m4uwE9f/hTf/G8l0+iWRqSYUt8pgOmNmd0
 TpBu/DY2l2eyd6+snDOcQ96tKwZlaCp+wvqxG4p0Ih8CVli22flf2rwy4SgE133mC4/H
 PSXi5uqaGigAZ25n7OgpadwMcqMor2xqJkMmmOTH8WRmTUCiFdPei/gPWSJf4qKlYzdO
 s6qvvnbyYAJ7b3thTrWPe4/XnJ6SBIaWLsi4fHc6lz/BKM5f+I02gP8TIxOy/z9FJuF1
 FcSZ6I5GeU8sWc1OF61enSL1oMGjv/gIEbaysz3eb4g4is9ZCMK85y1DNhMT3HOT0uGt
 PfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685542304; x=1688134304;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bidlw002eB0fLQ7ttTGOGjugWJDqRVOFDANiarByciI=;
 b=bfQeWrMDTL3SLGq3K+AHmGnNktk3MtRSZh1i+e5HN+mUvb6RcJfriH644FXdYBE8ZD
 bXO2uR4x+S9t2x1PnX0zVlxoW7YWHybmkHFX+R8M/JTx0YvGtyVQYgyEd3MCLfj0pYW2
 4+aWIg4EWeGzdH/7hmT6e9qyI/h1dzzckd4fWb+HGKbBYAC0jW4RGXQHUWpwDMiKeN9g
 VBY+3/xhiUypr8IwbOlwM+1BLyFJi2rahQHuD9X52gvVw2vHVWQaxncegfhyEfoykOxe
 blKefBmz/FJSK9gSZIOlM/0Pf7+Cb8PVvZ/N3Swxt2oELRAxVl/ddHnDVynj6PZC5JwC
 WvdA==
X-Gm-Message-State: AC+VfDwAmQvysqoPGLYUR00iI3QWtSsCLVlKZyZulwttKfmyP+o/kQ+f
 XLgJSvElPGspQL+BLhLN0SmKzTZ+wpq2PRttS0A=
X-Google-Smtp-Source: ACHHUZ7POIAJy+XajyJsiihBvnqBv9irCiQbVtbvSHYLWQQmEcmKcUTu7RJwf23iz2+of8UTP4HytQ==
X-Received: by 2002:a05:6000:1a52:b0:309:4358:5afd with SMTP id
 t18-20020a0560001a5200b0030943585afdmr4236825wry.54.1685542304084; 
 Wed, 31 May 2023 07:11:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a5d4d87000000b0030af8da022dsm4067106wru.44.2023.05.31.07.11.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 07:11:43 -0700 (PDT)
Message-ID: <338db652-c3d0-7343-480a-533e3a18b1ad@linaro.org>
Date: Wed, 31 May 2023 16:11:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 03/48] tcg/s390x: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 31/5/23 06:02, Richard Henderson wrote:
> All uses replaced with TCGContext.addr_type.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/s390x/tcg-target.c.inc | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


