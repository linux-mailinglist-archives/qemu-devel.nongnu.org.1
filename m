Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 565F172AC6A
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 16:59:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q802q-0002gm-IC; Sat, 10 Jun 2023 10:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q802o-0002fz-Fo
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 10:58:22 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q802n-0003ll-12
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 10:58:22 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1b3b3f67ad6so1829195ad.3
 for <qemu-devel@nongnu.org>; Sat, 10 Jun 2023 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686409099; x=1689001099;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rp8xfNDEMhMdsOezO8FxT6A+pttVl9KLZZnKJ1VrHk4=;
 b=h7CpKGtIvc5o2l8HVfqgA3+KcOEPag/ZGeR0IkU6q5Qf9NczLuTkpL+mYLltG/GO0n
 h0PpFi5rkl+MqRXxBn+/m/+sIQuT/vU+bGfwSHiKcx7Jf68e7vSxBtmgHFVX+WtO83zw
 kBC4vOEUV9YbXVZtUxj9hPzdfew8u1gw/PWYVvQDE3+ynuDNog/t1QOzHyd9gGQ1/MhP
 wvrz8EzKmiuKTOt8RRKN7AANQZvbeEOY44c32w7bGrnj8W8nWRBudPI3AP8ct4YkO4X4
 ofMc3EorRAk8TLTU2D157T04xfS8YLD3i30OV4OzLswgbVDXcM4rg6Eb3XUwRXaLIfrZ
 Olag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686409099; x=1689001099;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rp8xfNDEMhMdsOezO8FxT6A+pttVl9KLZZnKJ1VrHk4=;
 b=aHNsc4Yw1NE6QyfG5zFIPdlUMAm67LfYSlZHHS5eToDfmnWC7kro45aeavHVFS74kZ
 lLocmVYNUCFaHYBItJjocBE3HJ9iABJZViOQ9FMlb4kaQzAl9HfTTuPqrm521lCwE2AG
 Tb6tsZAKsbPlcuuOeDgtjSz0Z1pw6FHYbDq0rSM/drvGljr6Z89/OTYLDyN+R2ctoiOV
 Dxl8BNLHeOttSix8KyxvWJzMcE8nbM6CILIf6PwftZ2I8SxqUctCloZZBZag3Pi/n8RI
 yHZhS/68RbVq6pWQNSbASJOusd0ivTl9tny51hKuiWP2E+aWY1epaaoBU/Q1CNPGImh+
 5gKw==
X-Gm-Message-State: AC+VfDz3usjRntRG5vZFbB2HehtvC6wD3JHpYLjhAgnbeXCv8nlMCMpw
 EcRVjcrV2onXTtneX2URrTJIWQ==
X-Google-Smtp-Source: ACHHUZ7Uh1/nVcq5sPhM5gW9pTbntKoeQClNwN0VLK7FNTDGPUc8pGXq8J62ZQg5IUBqVtl7DRm7og==
X-Received: by 2002:a17:902:d4d0:b0:1a9:b0a3:f03a with SMTP id
 o16-20020a170902d4d000b001a9b0a3f03amr2117474plg.9.1686409099455; 
 Sat, 10 Jun 2023 07:58:19 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:2db6:3c02:bd87:f559?
 ([2602:ae:1598:4c01:2db6:3c02:bd87:f559])
 by smtp.gmail.com with ESMTPSA id
 k1-20020a170902694100b001b025aba9edsm5114335plt.220.2023.06.10.07.58.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jun 2023 07:58:18 -0700 (PDT)
Message-ID: <a25652e0-9242-86ff-b997-c70463ee5187@linaro.org>
Date: Sat, 10 Jun 2023 07:58:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/6] target/tricore: Add popcnt.w insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230610105547.159148-1-kbastian@mail.uni-paderborn.de>
 <20230610105547.159148-3-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230610105547.159148-3-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 6/10/23 03:55, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c       | 7 +++++++
>   target/tricore/tricore-opcodes.h | 1 +
>   2 files changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

