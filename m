Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A41CB74E1A2
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:00:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzqy-0000s2-6s; Mon, 10 Jul 2023 18:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIzqq-0000r4-RH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:59:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIzqo-0003Er-Lj
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:59:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fc02a92dcfso33157395e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689029964; x=1691621964;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V1g+RSj3yg/L1Ze85XhM+KcD6fZhWS7/3tH0tSgGGqQ=;
 b=dTLErG+hQN2zV87Gw8ug9M3LhsxgJVkrmiipAKu84Y+7WVB1pmNShfxHMxHuBpZ8ns
 YD/DexbGN4WSyMQgrNg51FPtk5rlikSoFAgrZKgfh2k7O+IFT0A1I26Caxw4n43UOXl7
 nYLbxe23nceggZ/JmDDbCMVLmTXc96lM8dlCtRiexfzj6DhVBuQXUxxFdqitxtP+rjgH
 xCZ8nj063RQF/JDJ6k7w4t2dJ2HG0w7dj8i4i9SkOpiai1XbLSqKglXzUcK6bta7MU65
 Dnm+Cz7ouOSev+A7SCUGJvmVVCriNihfu2l7GXBJtdF4ChrBrtwAgHJO1DEoN5Xx2Iac
 runw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689029964; x=1691621964;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V1g+RSj3yg/L1Ze85XhM+KcD6fZhWS7/3tH0tSgGGqQ=;
 b=BDF40EL8ueiwSQRenP4UTbH8Tmexd52fneCKkLDYQoozXGWGHp+w03eSJE2P2JSM6r
 yBwAtSF8qflrvcr5w/fG47gUzjnxiI1zTTGNpjC16DrW7HHr9C1BkmTG6DEsl8fKCyhP
 rXKG7fUw77ZZc+GFKqrLRmw1jVCzsjwa82C11Urlg5USeE8Q5JboXR5x3tCfbSpZvpXW
 JgWotq+Lg/YsB6ypk72lNPBwdQjh6qgMlUbriUPvSZ7qk/qDOjFgFp/KGaH9khLhZL3W
 dpDBUjwQSdMtfxoPdo3WOWp479swCpKp1xRn7lMi7N9QwUrIsavag3+OdWZi5xtzjo/s
 mkEg==
X-Gm-Message-State: ABy/qLY4zwuVccNmsbE0el1EeGvS8ffYK9/AX/gi5x/pzV6fLK7UkCP4
 gX4K9MUsXRR1IuTXbaswPjh/Bw==
X-Google-Smtp-Source: APBJJlGUmURumYgTbyyerJv1c+Q+ceB6k9vW3LSh0HAC7Lxs3VouUvN39kv58+B7LTu7m6DXRNCmVQ==
X-Received: by 2002:a05:600c:d5:b0:3fc:55c:440a with SMTP id
 u21-20020a05600c00d500b003fc055c440amr8247815wmm.7.1689029963917; 
 Mon, 10 Jul 2023 15:59:23 -0700 (PDT)
Received: from [192.168.8.133] ([85.255.236.57])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a1c4c13000000b003fb225d414fsm11328475wmf.21.2023.07.10.15.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 15:59:23 -0700 (PDT)
Message-ID: <eae0eabc-a374-82de-8075-c68490a785bf@linaro.org>
Date: Mon, 10 Jul 2023 23:59:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/7] Misc QGA patches 2023-07-10
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230710132810.1049912-1-kkostiuk@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710132810.1049912-1-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/10/23 14:28, Konstantin Kostiuk wrote:
> The following changes since commit 2ff49e96accc8fd9a38e9abd16f0cfa0adab1605:
> 
>    Merge tag 'pull-tcg-20230709' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-07-09 15:01:43 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/kostyanf14/qemu.git  tags/qga-pull-2023-07-10
> 
> for you to fetch changes up to 61df91b33caf646cd39f9879d4b190eab5b7201b:
> 
>    QGA VSS: Add log in functions begin/end (2023-07-10 15:54:40 +0300)
> 
> ----------------------------------------------------------------
> qga-pull-2023-07-10

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


