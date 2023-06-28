Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD93740991
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 08:54:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEP4O-0004wW-Lw; Wed, 28 Jun 2023 02:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEP4M-0004w2-PB
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:54:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEP4L-0005hb-9S
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:54:26 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fa99f6a4a1so31251895e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 23:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687935264; x=1690527264;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o01F2pQOyJMo97sgVD+TonNfeazQz1neZ+cxvJw8Ixs=;
 b=WHu9NVg0AhAz1QNZQR4HnYIdDOB1cFVHaS1UBBPjV9HD2sq55+5EEj5AWr6s5YxSOh
 82zYJ68WEHR49m9oHglphmPCjI99VnqDvB2EgytVvANIuCkRsdbGL4JTDchjfBJn7U9I
 dgfJVBd1prquPhehYbW82C36Uci7Zs6WcX+y55sum6N1q/8o+J6IXeXD1tDtYirnqwz9
 v+akxCd5DiQufEQgBgJbFLqd671+N8FXp5FW85s8W5K3i5IfjSDWWXZyQzAuOBChwNmV
 9XgEXoDgw2cL0xoToxDsipY7qR3b3tt1HTZZUCLI9GZSCzIlS5JfwnBSflp5StBBf8Pc
 2XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687935264; x=1690527264;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o01F2pQOyJMo97sgVD+TonNfeazQz1neZ+cxvJw8Ixs=;
 b=jyWDQOBSW++KEs5Hv5FyKmnG+VEZr/CfpVcG5HdGWvKsqfSgYLKjvTmsxCu3/CAEih
 oscyMeLEascPyCX2AswZ4bIG0tiShIHhIL5qyale8ZDPDTSKzcQVCA70fUZ7/2Va4mAo
 NmZ6yxlCdD0VsNZ0S0BpU4MsO3fDsK9FmceLVmDI68ATEYluIV1AHr2N7t5/XR85Xpji
 v+p6z4py1eXUlVSzI+RRELqa5EZkUnIQP1X0upUcjPqhuAfmW3/D4qy+NyZVxNRyC62/
 9EwX/lrbhmIjZlzp4HkjN9WRJ2eGdfSb8UELfuYe0c/YKESzImDDaFaj+6EcHQt7z909
 z0uA==
X-Gm-Message-State: AC+VfDw83Xyylsk7PmBt6PGnC5mSr4W0mSBqlBAN8cezu6erkoaI6yRY
 ykjT1c+ShgCbkntn/9Fol48BPg==
X-Google-Smtp-Source: ACHHUZ55jhcXxLUip9ePrC+QulZgQ5U+zKqaUoY7oV7le63rMPugUer0zNY5WhMkr0t8Mfj2mRLoyA==
X-Received: by 2002:a05:600c:3799:b0:3fb:a0fc:1ba1 with SMTP id
 o25-20020a05600c379900b003fba0fc1ba1mr3720802wmr.35.1687935263775; 
 Tue, 27 Jun 2023 23:54:23 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a05600c378b00b003fa95f328afsm8274346wmr.29.2023.06.27.23.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 23:54:23 -0700 (PDT)
Message-ID: <54d7a7b2-5bfb-40d8-b0f5-7bec5dd9c7fa@linaro.org>
Date: Wed, 28 Jun 2023 08:54:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/4] target/arm: Fix SME full tile indexing
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230622151201.1578522-1-richard.henderson@linaro.org>
 <CAFEAcA-LNDGcddHiTOuyc7XcaSS4KWMFYu_-532rfjcvF5_c7g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-LNDGcddHiTOuyc7XcaSS4KWMFYu_-532rfjcvF5_c7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 6/27/23 15:36, Peter Maydell wrote:
> On Thu, 22 Jun 2023 at 16:12, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Fix #1620 and add its test case.
>> Several cleanups to aid debugging ZA[].  :-)
> 
> I'm going to apply patches 1,2 and 4 to target-arm.next.
> I've tagged 4 as cc: qemu-stable (but will remove that if
> you disagree).

No, it should go back to 8.0.


r~


