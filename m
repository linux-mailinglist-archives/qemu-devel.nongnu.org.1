Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4382078E401
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 02:32:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbVba-00022K-RW; Wed, 30 Aug 2023 20:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbVbX-00020D-LI
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 20:32:12 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbVbU-00048g-Cl
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 20:32:10 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c1e3a4a06fso1636635ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 17:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693441927; x=1694046727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AsgnYeh1qa/gbFAWI2eUESc/uoyp334a7kOwAY5RmPA=;
 b=JshJVwFJZ5/XK8/XzTrnCGRXq4U8oJIjH1pKRmqDpUwXzDSLpIwY1asS6Xjt8SNlgY
 NkXaY+g6bLFG/4Ms5PM/oErADiGNqnq08IUqayFLzqrfRpq/4lVN2imzrgjsvx8rmO77
 6Mhc/8VogrZjVeZsGICsgXDXUQTkpx+ujTDKBUCJ0EkFpF8HWTJ90yDhR4j0TxF9O5Ze
 AqhCn4/YXjkr5z4j2Cws7CzxCK3lgZ46kJkiZFrbpifrAGq2EtftV9qD6ixPCbNOTUCj
 jqzE21eyqpS2yJexMUiZd2bba0UNwJvpupBkN8DeDegGhBleHsRUK0gTQIuBq79MaMFn
 YEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693441927; x=1694046727;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AsgnYeh1qa/gbFAWI2eUESc/uoyp334a7kOwAY5RmPA=;
 b=UxmgVZc72Klmc+9OWdYgZGglGU9aMx2qCKZCi0qmdWzRpUYf7R5UgguJY1h11ktLqV
 AKUfIm6VNDz2mHnQiGmfZ193vzitVU7qrLEM6lKVMuPmmQPMoNHYC3b+0GP2X0ayxKKe
 OsDMbYrt3XDRanJ/G5ocGCIj/yjRGO1RBtfNl/iDAoxPxnNlmPbQXeUENxAB3//hVYjQ
 iZQ/kUpFc2kBc2vFNKzYynPkPSSP8RlteqAwhgT8qYKswYkuKbyU6aEBffO8gU2RyV4w
 QOqhDo4q/mLC0VzkN7jUEnJKzl0qru0WWKb67Q7Zaxk35SwYZBNHJvcH66ANn4YFxwrK
 edgw==
X-Gm-Message-State: AOJu0Yybs9DlI5sGnvzDmV9EIfapJIC7gdFW+2ugjPrdeovyS8vKuKVs
 efyIxMObb+TesUCT+1N0B3LIJVbDuq17hcZt108=
X-Google-Smtp-Source: AGHT+IGat45XDjU4FsvazEIpo3LiVZE1MTNqaxqxOC6ldkSzCMlP0vwvyMzvLEEIMyaFL8aG/B1nVw==
X-Received: by 2002:a17:903:2344:b0:1bf:73ec:b980 with SMTP id
 c4-20020a170903234400b001bf73ecb980mr4110675plh.66.1693441926856; 
 Wed, 30 Aug 2023 17:32:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a170902704a00b001b9da8b4eb7sm94637plt.35.2023.08.30.17.32.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 17:32:06 -0700 (PDT)
Message-ID: <13cd736b-fe63-7e82-56e9-d4b5f58ce417@linaro.org>
Date: Wed, 30 Aug 2023 17:32:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 42/48] target/loongarch: Implement xvbitsel xvset
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-43-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-43-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 8/30/23 01:48, Song Gao wrote:
> This patch includes:
> - XVBITSEL.V;
> - XVBITSELI.B;
> - XVSET{EQZ/NEZ}.V;
> - XVSETANYEQZ.{B/H/W/D};
> - XVSETALLNEZ.{B/H/W/D}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/helper.h                    | 16 +++----
>   target/loongarch/insns.decode                | 15 +++++++
>   target/loongarch/disas.c                     | 19 ++++++++
>   target/loongarch/vec_helper.c                | 40 ++++++++++-------
>   target/loongarch/insn_trans/trans_lasx.c.inc | 46 ++++++++++++++++++++
>   target/loongarch/insn_trans/trans_lsx.c.inc  | 44 +++++++++----------
>   6 files changed, 134 insertions(+), 46 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

