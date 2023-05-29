Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FE0715233
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 01:04:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ltA-0004oW-EI; Mon, 29 May 2023 19:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q3lt5-0004nq-PK
 for qemu-devel@nongnu.org; Mon, 29 May 2023 19:02:51 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q3lt4-0006bq-35
 for qemu-devel@nongnu.org; Mon, 29 May 2023 19:02:51 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d2f99c8c3so2766636b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 16:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685401368; x=1687993368;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8RYc+s4FY5h47EtkzWXr6/lNwLuQ/k90fMta5i1oKJA=;
 b=VxMzx6KPhs6wPyKYBb8mmpW4Zc6uxri0jEXGtNszO4paZK5tQ8Zey3hvh4mY57FdS4
 L9DsPwRcwDYxz1rxVzx7fdBhtBe01oGyIDdGRPbd1AxZcAUhHCvvKy58EDdkRzClq85p
 qzqNFiiD44c1qpAfDTJdwrImUN02XqQxUAn0/m5O7oW8HMcPEwg3VgumuulyOGrGy30/
 HcUL/LvyLMy0xxGRCwLQiSkv25VS/zNRCcYgP4UfkRvs6b9DaGMpwVUl3+ZNL/7YWlPM
 CnKDECVBOeYSE74HzI8oowbjRi7lKHhm6a+qpQwj/4meh4Kns2RxxLJV5AP+uQntCkZC
 46hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685401368; x=1687993368;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8RYc+s4FY5h47EtkzWXr6/lNwLuQ/k90fMta5i1oKJA=;
 b=YWm6gAjmbBe/NePh7Fwx9clM7oiKHJi0+49obOSJPltN7y0U6SLx2zmQf9prd80dbP
 pzVVjkZZnwHawSposbYX2Lj4wHX+mTnY//Pi9Lho4Ado1EtvgXoNqkshnyicpavSnL99
 pdniW5R/fgJeJEi8jBdJ2MUCMbe3y4GFsueuEd+8r+nHZZxq3W8FGqvsJn0Aqv75azrM
 oOoIitHZo/XR1oiUeOxQ72/rIPqhw2cK5Cbkwles1lysIBVCYajsAJ8bY8AQCTwP3iRp
 j/GV2XNtq4zr1b7Z68zYHoMZ25Vc91dGdAn99WYl0hB2Zjeq4eJgRBXno0Gk5w6ZVKdK
 x4PA==
X-Gm-Message-State: AC+VfDzs53nsFr6SOH8VGNI/wjT4+BDDXeW8UmdDZx6CMR+FCXd4fHMK
 OUd90apq0CBKM1sOqOolfMZpzQ==
X-Google-Smtp-Source: ACHHUZ494S3FmhNXOWAtWLlUHSGorrW1MV8bHvvzOiswdiHXQuvJr7yiIuYC0/ERQiK0duHZYb7UNQ==
X-Received: by 2002:a05:6a00:390c:b0:645:ac97:5295 with SMTP id
 fh12-20020a056a00390c00b00645ac975295mr152837pfb.9.1685401368317; 
 Mon, 29 May 2023 16:02:48 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9923:e5b8:e7d9:7a28?
 ([2602:ae:1598:4c01:9923:e5b8:e7d9:7a28])
 by smtp.gmail.com with ESMTPSA id
 d4-20020aa78144000000b0064ccc164c9fsm386650pfn.194.2023.05.29.16.02.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 May 2023 16:02:47 -0700 (PDT)
Message-ID: <9dd89827-9520-1a49-e1d4-c0564f1e48e6@linaro.org>
Date: Mon, 29 May 2023 16:02:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/10] ppc queue
Content-Language: en-US
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peter.maydell@linaro.org
References: <20230528164922.20364-1-danielhb413@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230528164922.20364-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 5/28/23 09:49, Daniel Henrique Barboza wrote:
> The following changes since commit ac84b57b4d74606f7f83667a0606deef32b2049d:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2023-05-26 14:40:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/danielhb/qemu.git  tags/pull-ppc-20230528
> 
> for you to fetch changes up to 56b8bfe9bb6b94184b8bbfc4be9196404a81e450:
> 
>    ppc/pegasos2: Change default CPU to 7457 (2023-05-28 13:25:45 -0300)
> 
> ----------------------------------------------------------------
> ppc patch queue for 2023-05-28:
> 
> This queue includes several assorted fixes for PowerPC SPR
> emulation, a change in the default Pegasos2 CPU, the addition
> of AIL mode 3 for spapr, a PIC->CPU interrupt fix for prep and
> performance enhancements in fpu_helper.c.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


