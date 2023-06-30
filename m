Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C498744203
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:17:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIey-00009r-9W; Fri, 30 Jun 2023 14:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFIeZ-0008VG-K4
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:15:32 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFIeX-0004C5-LG
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:15:31 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-313df030ccaso2417046f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148928; x=1690740928;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BksmU6oe/Wd0dWUD1U5s9s6SahQpUMJeTNq1qn09ocw=;
 b=e3PoM2NOK4woYYIosBu32RpK5V5c2A7N1ZWZ0jS4y2Q3X+QQVCPjrpyRYOHXqhljZN
 cz5hadhgpYcHONIZHyOmd0BOjEJ6iS1g1i2AdgmaVqJ0pMFiM0cF23Lt3p5qzrOuq+Si
 U+8GkLWjmS5vCH5/bhgezUm3FTHga3lmgbPxzOvYEqNC7vIFxpM+6U32plRY7e5qXx5+
 8TL7SCybGAAyVmTZOPux9MKSiazAgEBA6HAUeYIhYB1CN6sHuAiw8aJkk1uzhKjCUF31
 5ColoVRx9a+w1Y8aV8zQQCQCPqqZte3hs2iUxEZ9YM/VEH+2PD4WyLoGwKRwjjTQ9C0T
 DPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148928; x=1690740928;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BksmU6oe/Wd0dWUD1U5s9s6SahQpUMJeTNq1qn09ocw=;
 b=P6bMM8n0xAOpBCPFpRDfRKaLGtfGInXMDRf2ZjTOWPyZMlfKg3fyHCD0IPAswU9SJX
 xa+aZ8S8nvL8GOpyGFPtuFStdGlPkfHBqB0VmutDleYiVFF12DAdsEUaMVYt0B5QyCXH
 /SPsuPjzxHve+vXaurp7sXoxvFFSPdYVnHT2mk7BcLQE+9EUeNDE2llbOz84U7EFC9It
 kJxZTAGRcqL6jyKAngDiB+styQZwEP7rh0upznPIk4abARYu9MAqOjmdBNeOhOig2XRR
 G+x4g5E/LubD+ZdhJ3/6CWuOhXRNZyrYkXcIAQturutJzDOHxF6Ti95I5yc/0v4XVUli
 ZxpQ==
X-Gm-Message-State: ABy/qLbQ9KZwafNb+q8hAXRrNZRwp8pHz1IN8087BHXHHuH0AXhZEKak
 sMyN8avVEY7arIqFfVxtOVW7Lw==
X-Google-Smtp-Source: APBJJlGr7Owfkzk1Kspg28NpsBCKpIKkyqyawpQ4dMAYkTzlKsQ+EBvYVnfIROiUhcIcikvDzEiqog==
X-Received: by 2002:a5d:4a91:0:b0:314:101f:bb7c with SMTP id
 o17-20020a5d4a91000000b00314101fbb7cmr2993481wrq.34.1688148928095; 
 Fri, 30 Jun 2023 11:15:28 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a05600004cf00b0030e52d4c1bcsm19087859wri.71.2023.06.30.11.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 11:15:27 -0700 (PDT)
Message-ID: <d5172420-ed34-2fb6-fca7-6d4405958d3f@linaro.org>
Date: Fri, 30 Jun 2023 20:15:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] target/nios2 : Explicitly ask for target-endian loads and
 stores
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
References: <20230623172556.1951974-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623172556.1951974-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/23/23 19:25, Peter Maydell wrote:
> When we generate code for guest loads and stores, at the moment they
> end up being requests for a host-endian access. So for target-system-nios2
> (little endian) a load like
>     ldw        r3,0(r4)
> results on an x86 host in the TCG IR
>     qemu_ld_a32_i32 r3,loc2,al+leul,0
> but on s390 it is
>     qemu_ld_a32_i32 r3,loc2,al+beul,0
> 
> The result is that guests don't work on big-endian hosts.
> 
> Use the MO_TE* memops rather than the plain ones.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1693
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> Presumably this got lost in a recent conversion somewhere,
> but I can't figure out where, so maybe it's been broken much
> longer...
> ---
>   target/nios2/translate.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Queued to tcg-next, for lack of anything better.


r~

