Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E1A78D095
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:28:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nn-0001Uc-LX; Tue, 29 Aug 2023 19:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4a7-0000L4-7W
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:40:55 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4a4-00047b-4s
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:40:54 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68a3e943762so4127131b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693338050; x=1693942850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vmzs9SzAXzQOoIw3rQmeg1TsRBUW1rBaMvyoSaOdmuI=;
 b=ddrAjN2Twu0Eae54J7+bewAp93OH/bVcojKItwGOxjeeua451vsF8x6SLwYBq21BA/
 6LXJe5I6P209vb3ITmEBQZfJI6j0TaPgDWlCsNMn5ZrwDIilIVESd3NS9c+PvR6SaMNP
 Q7mbgeoZj+vI0ZqaMeJ6PTFhU/CMrZ3T2447l0UIxNiVK86r4ALpSQ3bmyGyp3cEQvWB
 tFuqBQOzyjgBQLvzN8/HVDTLx51UBCzCOfXhZ/plfc510+Od7AI/aWp9irv5oSixRjZO
 AVc/NiAwqXT8dhNTJ6Q3oXuQ+6zQo9e2MTQtHeX49bhs/Ae6a2BGoGh1Vs4hWCFJyl1D
 er8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693338050; x=1693942850;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vmzs9SzAXzQOoIw3rQmeg1TsRBUW1rBaMvyoSaOdmuI=;
 b=bPwD/hmRS8+T2op4fu5d/R8MWjcmRHHMfMFk7G8oevmeTUTuDzL6T1qK/BetPCkCFj
 zWDBthslmpqFBRAgx01XGtWmKdPkP923IRNq5/f/RUl495bTGaZknb25XFr8vspDgmyK
 9uR4gcMQ3CNQAwsYzhjpzQK/LtFQJuUEijCdWylKPjJ8Bso7EaczMOl4492E/NgvzlX8
 t/dBk32YKMZRieMiQpcoOnfGseF0OuuXMWoeXYB5P1z95+4cp5bjMOr+T4qne28jjXHW
 93+SwihpA9ulOHfwXief5yfwdDLr4CxV/4+oCGwKLy+qRr8IuJCOaLwyD0QzKnKGdF3N
 k2wA==
X-Gm-Message-State: AOJu0Yz24wuUyhu0P5fJgYRhXPR6yLMNea7gF/DuR/5tHs9+rSyOzPey
 GhFNZWTuvDAZjftnZpH7lriC+w==
X-Google-Smtp-Source: AGHT+IFIhcUVzJnJsANKKN8gSB3R9MXgHJiop2lv5YHOVN/GnQ3aPNtNziOJCfSNevGoZhYH0DBv3Q==
X-Received: by 2002:a05:6a00:1387:b0:68a:54e5:24e6 with SMTP id
 t7-20020a056a00138700b0068a54e524e6mr211787pfg.8.1693338050500; 
 Tue, 29 Aug 2023 12:40:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 x5-20020aa793a5000000b0068a3dd6c1dasm9091055pff.142.2023.08.29.12.40.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:40:50 -0700 (PDT)
Message-ID: <4fb57729-82d2-ff4e-3f8b-d5ca71b5f665@linaro.org>
Date: Tue, 29 Aug 2023 12:40:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/32] bsd-user: Implement host_to_target_waitstatus
 conversion.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-11-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-11-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-proc.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

