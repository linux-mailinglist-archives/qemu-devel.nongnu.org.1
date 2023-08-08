Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD43774F6D
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 01:39:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTWHu-0008HX-En; Tue, 08 Aug 2023 19:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTWHp-0008HP-Mz
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:38:49 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTWHo-0006qW-4K
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:38:49 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686b91c2744so4616760b3a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 16:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691537927; x=1692142727;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aWdTr+BVDgUi7XgYueB7BGQnoAP1uNh6N8HvaqlRTm0=;
 b=lVdBuHWdYMcnWfx88DSo8UzsfqG70P4sJk3ECBxww/mZ/VW2XfjWTDHRFnjWcbcQNn
 I92cVJ3RLBffvnp1I3oITZouY+p+FRbXNsbLTEa+Y4smSdqlY1/mquAcziRnMUiw5dEC
 BtYqqsTMW/Cbv137jW3miTVyQqMXuujVCeknOHBU7EMfsuCTrt1dMFlm1wBcUu5dg+q/
 XhXitWXxTGB5cYvl3cCCETHYYqsZMILZ0r8lEV87RM57LagzX0qKJt+6WHlRFt9WFLi2
 vBbFwWesFG2Z69Qt0HDMJdvuaJ/ccjBzJenlgT694oqpT0XoqXWK8rWo2eDERTOxXmmU
 5rpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691537927; x=1692142727;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aWdTr+BVDgUi7XgYueB7BGQnoAP1uNh6N8HvaqlRTm0=;
 b=C8gTigpiSOw6vU7JERH9RyUBRyIg0pPxYJW1ri+WSX0ovqqwTQrOjnAwLnZQ46tPnI
 F9rbfBN8mwvmWcM6z4JzyArGR/4bQO0NDZZEtFWEGHZIpVWMvSwdAWBx/mH2UumVlhQo
 UFKZSSB7QnDpQYZR4CLt+L0chnuq18waCFNPpD/42YLxRmu2dxEMl5E9vvC/VuncLW7A
 t5JuLGK7pYfTX99clcchyK7GI+Q3KUe7yYRHwKBMi0imzWZtnXX/35erlonoiXgsT/iO
 m7juGIx6e0G7fVFsYsQBTa2xTK+soalkw9rSHaKyKIBULATsa2VukNacYA+9Qc5VCYQl
 P72g==
X-Gm-Message-State: AOJu0YwqK4XeYTXbpVHF7J3JWzP0C7106CIerhpF68QL4iO40etuvofo
 /iv+2LbsQk9WN+SL2en5wBxDT8TsClmjnr2c+wI=
X-Google-Smtp-Source: AGHT+IHm55twR6xkFhcRUl/Hc/yjl3la3FhBDcYj88b9tvJlmPQKNt+U9yEcbZwxtBl5dvrAg2dqYw==
X-Received: by 2002:a05:6a20:9694:b0:125:f3d8:e65b with SMTP id
 hp20-20020a056a20969400b00125f3d8e65bmr745292pzc.18.1691537926739; 
 Tue, 08 Aug 2023 16:38:46 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a170902ceca00b001b7e63cfa19sm9604876plg.234.2023.08.08.16.38.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 16:38:46 -0700 (PDT)
Message-ID: <2a5e66e4-ac7c-4ab0-037b-3e1561acd012@linaro.org>
Date: Tue, 8 Aug 2023 16:38:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/14] linux-user image mapping fixes
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230808210856.95568-1-richard.henderson@linaro.org>
In-Reply-To: <20230808210856.95568-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/8/23 14:08, Richard Henderson wrote:
> The following changes since commit 0450cf08976f9036feaded438031b4cba94f6452:
> 
>    Merge tag 'fixes-pull-request' ofhttps://gitlab.com/marcandre.lureau/qemu  into staging (2023-08-07 13:55:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-lu-20230808
> 
> for you to fetch changes up to dd55885516f42f718d0d121c59a5f7be5fdae3e6:
> 
>    linux-user: Rewrite non-fixed probe_guest_base (2023-08-08 13:41:55 -0700)
> 
> ----------------------------------------------------------------
> linux-user: Adjust guest image layout vs reserved_va
> linux-user: Do not adjust image mapping for host page size
> linux-user: Adjust initial brk when interpreter is close to executable
> util/selfmap: Rewrite using qemu/interval-tree.h
> linux-user: Rewrite probe_guest_base

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


