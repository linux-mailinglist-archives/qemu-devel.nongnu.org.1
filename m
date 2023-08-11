Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F4F7793F6
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:11:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUip-0003FV-87; Fri, 11 Aug 2023 12:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUUik-00038O-Le
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:10:40 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUUii-0001iv-NH
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:10:38 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-686b91c2744so1599973b3a.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691770235; x=1692375035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OU1n18ssdJ6TQENSfoyKLyi/ifrrqrVtLSSVkfCWZ6o=;
 b=PttyEa2NiJkBNYWpeeZs2fIHmY0ccRJRwOft4pXyAxT4/SFdoh7HbfIZoNQAfT7EXo
 e/Fsf90CREPdpOrxQ2O6mqUTgaC4QVG6R9oHKz8+lmw5vqu7EHl5GTiDp3jQO8Hv3xDM
 6rrNqn/DUmt1smERXrzq9HNk0WRTI+0ZiWmc4Kg6jDgwWlmI9GY66sBVcBzN4fYS+PeH
 H6QI7g7+nN2EuGr0pQFw4OG0kKBQWWMpt2Y0VgtJ36GiMww2JEXnKIrO3kYD+kUl1bhX
 UHDBCRCCD6BSawXR6/Q8G2b5a0ALPtI7Llo1yhJul93cIWUnAyTlhZVtw3c/TGLY8uMX
 Z6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691770235; x=1692375035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OU1n18ssdJ6TQENSfoyKLyi/ifrrqrVtLSSVkfCWZ6o=;
 b=iqm0IWO9NAoMjzZbNoje2Dt9ACKkY1w1nrrvCN0A1NAyivMVq8Ea7c9P/E5F3MNh6W
 3j2q31bemjNBwnoxaprhhGmuyaJwCsXJXvKe7CG32cOLaCzNZxXxCO7OfR1DWwAJNcTR
 z0UAEzL93MjYcwIq5j6utD2eXtKoJ5/wlJ7cnXfk6Tsf6SVR8ouX8Hzr+szJ4GMT+/Jm
 b2wx2VWfb9P9DP/yICWE8GXWeKHuq2HvANidwD9BnsEKskW2yHq9P8Vl+it995LM7QBc
 pM6L0lE0h+BD9PsCfgpH6jVer8QQwOjf9YP5M7vP0JqJwMe4w8iPHxPIrdiZR+BDkAob
 RRIA==
X-Gm-Message-State: AOJu0Yyds0/thFZWHX1IkFaMDcMyt6R6QoupsQT3PJdW82iI/6+BoU/7
 3c2gNBZDtnzebBADwvUwYGrFig==
X-Google-Smtp-Source: AGHT+IEaqIyM405tF+1naDScOfsDrNxWhlti0o5eQNpA25ISDBTdIK0r7Siu0/txqJ7oxw6tCdjeCQ==
X-Received: by 2002:a05:6a00:b96:b0:682:26e4:599e with SMTP id
 g22-20020a056a000b9600b0068226e4599emr2234181pfj.21.1691770235380; 
 Fri, 11 Aug 2023 09:10:35 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:e773:351d:2db2:8a8a?
 ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 m19-20020aa78a13000000b006871dad3e74sm3522144pfa.65.2023.08.11.09.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 09:10:34 -0700 (PDT)
Message-ID: <db230abf-7b10-7efb-2f2b-05f03ff4188f@linaro.org>
Date: Fri, 11 Aug 2023 09:10:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/8] target/loongarch: Add avail_LSPW to check LSPW
 instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn, c@jia.je
References: <20230811100208.271649-1-gaosong@loongson.cn>
 <20230811100208.271649-6-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230811100208.271649-6-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 8/11/23 03:02, Song Gao wrote:
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/insn_trans/trans_privileged.c.inc | 8 ++++++++
>   target/loongarch/translate.h                       | 1 +
>   2 files changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

