Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 807B3784531
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 17:13:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYT39-0007oC-Cd; Tue, 22 Aug 2023 11:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYT2y-0007nI-8M
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:11:57 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYT2v-0001ln-Np
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:11:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bf1935f6c2so31100385ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692717112; x=1693321912;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1xii/lB8E9xyRJssEMiiQEzD981/lW0wSZRI3rNo2JI=;
 b=BpddwhnvVS2WnGcdm06QrUhpcVAvRTf57NN1ThZZEYYg4JFBFU5gzmcCcIqble+RTo
 QXrsOWXeQb/zwC0T8pW8C7fHhOnxpk52CPGzRo/NaZgczJa6fuVvHzF2TO2ppilzB6e9
 Y0KsQUj20xAsjgLQ/GtlOplplxIh+0BRf3Lko6HyOLxNvoKnUEu27bvICNP8QrWN6x/T
 +x/g1mYKQyhGrqkxUK3gpMIozJZ+D6Pmlis+JMwbFHD60HMKceKB7nI8BPiNuEnwE8Wg
 /Fprm/suGYjM50p02POFjnbaJXK4bXRp+mY4TBqHuIZRaylFOMNR4MxEDOX7vzMN9PWg
 PEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692717112; x=1693321912;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1xii/lB8E9xyRJssEMiiQEzD981/lW0wSZRI3rNo2JI=;
 b=jvZfJQjlqGVGlIFs54EcSa50rNcIuz8sQPKwAKdTwc+ZM8fx2V2Ae4wctHncJhlByz
 zpgjiZ5R+g8EJEQ1XolEYDXaRgN0hlL2eg4qNW41WqkSadCxA1qmzknkEIa0ey/AkQRs
 WJo1JgGfeTDmw4/uaZDIpL/Ro0U2XuZ95a/Z3328SoAwNCAawavDYlw/6SIH9H+YRm9d
 /ixbLwGOzjYk3GwTHen4SAzYlR+JYP44wttzKbZcEvzKDju2wZFlod2zMSxu/fCOcmqJ
 efGColygoJqyQ59DpMVAYMqau6FioTM9vFGmIdIvQ+WfwCD1Kfx/cCLdHU3DXKbxdVwi
 SUdg==
X-Gm-Message-State: AOJu0YySrWXS+8aZJzUcjF/kmuVgR+YHJm1foJVBLi8LSfLzjxwGwe1F
 SsfOu8j34cId9tyAzuZ1VZP5oA==
X-Google-Smtp-Source: AGHT+IG6fyeoGTc9md76yvzBHYI/sPLllG0o1HFXZ7Nw9PPEiF6cH+ABLkQj5yu3AxyE+ROkMPxndg==
X-Received: by 2002:a17:902:c1cd:b0:1c0:91f9:aca4 with SMTP id
 c13-20020a170902c1cd00b001c091f9aca4mr2471055plc.22.1692717111987; 
 Tue, 22 Aug 2023 08:11:51 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 j10-20020a170902da8a00b001a5fccab02dsm9173848plx.177.2023.08.22.08.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 08:11:51 -0700 (PDT)
Message-ID: <ff04a8bb-375f-bbdf-f9af-af4a03aefdaf@linaro.org>
Date: Tue, 22 Aug 2023 08:11:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/6] target/loongarch: Use hswap_i64() in REVH.D opcode
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
References: <20230822110129.41022-1-philmd@linaro.org>
 <20230822110129.41022-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822110129.41022-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 8/22/23 04:01, Philippe Mathieu-Daudé wrote:
> Commit 46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}")
> introduced the generic hswap_i32(). Use it instead of open-coding
> it as gen_revh_d().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/loongarch/insn_trans/trans_bit.c.inc | 16 +---------------
>   1 file changed, 1 insertion(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

