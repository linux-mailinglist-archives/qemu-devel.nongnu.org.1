Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E31E478B70C
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:12:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qagiE-0007dx-JZ; Mon, 28 Aug 2023 14:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qagiB-0007ao-9u
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:11:39 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qagi9-0001do-7r
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:11:39 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c1e780aa95so6164215ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693246295; x=1693851095;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gCUcKVhvOAGgALn+gfjq83p4tX8yTrf2rvgp57ONngc=;
 b=kQk9EcDj3v4ym8KCg/Clrel0xwkKBBel7H50V5JCgo6v1V0HlzGcwV6zvI8qCX85qH
 HtsGMNPIxlf/UiFgtO+UzrwSy3BYIwwn+al9YIqiFpeKaYK8dVG3z/+i8J+AIQDOeRou
 WjRO9sSe2IMQ+Oqg2Famp3vLQ6AjhSr+4kOhVQjzSd1Lm8EQcoebucv3iZwGUocMe+Zc
 5nln9hXYvof9/nexgVgUKYcAp43nXTR2gIEtAgDJAyxFwjcP4Mx69R+tRMlFoH/qkh2k
 ETlpizyd+aa+5hT3r32JLHThOrdl5QT80BXP6H7P1GD/Tbnq6sNyhSZxwvuw6RE56PVC
 lE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693246295; x=1693851095;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gCUcKVhvOAGgALn+gfjq83p4tX8yTrf2rvgp57ONngc=;
 b=iijBFyZCN0HVMJLx1Ej9oM4L5XViodRl+IJ9Mbl7v03jq9QlpPI2CB+mSddoRPSy16
 P4QMVGNWn+6rFaVaqTxB2z7WL2irjX8PB5H3bwruNcltzcK3aDKOzmyBl2TsYognr7l1
 Oj2PkFk+YzfijoU26RzryDYSncIWMUPTVCAZuQMTPacp3f9jFjg+lcBB/NYFvw4uoIX2
 Z2MhcH7i63DwUQ7cudErt1XNvLnjaLbALUSRDyGnO4Q2pPI83qP9WqwUx5SeE4M+rP9N
 eaa2wAM3CBmwW4xt83tx+WBIRAb3QYnq634vedaQTjVvOWtAS8oISp+xTLyL4zJPT9oN
 pOtQ==
X-Gm-Message-State: AOJu0YxNyvqnq3dweF5VOnkDmtGOkWjo0mpefoonAGs9hEgJz7f/uHbW
 xbMHm7DqenmImPzDEzjokquoog==
X-Google-Smtp-Source: AGHT+IFnIKYv95LN2yroB4SBv7UkjgxOmqQbZ0JSOyQy1nHqblP01uGYVjijNHLVo82PCGM5tRgsZg==
X-Received: by 2002:a17:903:24d:b0:1bc:6c00:a2cf with SMTP id
 j13-20020a170903024d00b001bc6c00a2cfmr25540197plh.53.1693246295566; 
 Mon, 28 Aug 2023 11:11:35 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 jd13-20020a170903260d00b001b81a97860asm7720552plb.27.2023.08.28.11.11.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 11:11:35 -0700 (PDT)
Message-ID: <5df06d28-52d9-29c4-9b5b-46656ff8d0a8@linaro.org>
Date: Mon, 28 Aug 2023 11:11:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 05/11] target/tricore: Clarify special case for FTOUZ
 insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me
References: <20230828112651.522058-1-kbastian@mail.uni-paderborn.de>
 <20230828112651.522058-6-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828112651.522058-6-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 8/28/23 04:26, Bastian Koppelmann wrote:
> this is not something other ISAs do, so clarify it with a comment.
> 
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/fpu_helper.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

