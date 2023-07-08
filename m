Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E08C74BC66
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 08:40:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI1cN-00028M-SQ; Sat, 08 Jul 2023 02:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI1cM-00026N-2C
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 02:40:30 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI1cK-0002gG-H2
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 02:40:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso28306225e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 23:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688798427; x=1691390427;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M4XBeiz1Bs3UEbFkO0Pc/PUq5lc07r0fRx5G2B6Z1vU=;
 b=OscovhgvrCOJvorn0JxjpLK4N9iR1ysX8qGcfq1SCvDqpqoLCYOjOJp93SJalxB1gN
 UyTtfdodJz7/FKeRRbVfEN7fZlnZQiHbnL0piISAwAidSFSprDXTeBAD0msOQxQvETiT
 X/6HPA4G2DwMIDzW4uDnj6wekin1J4484FNNO65nwiixaseAq8ri60TQ3oEh3WIeUxgO
 n9RQCisCLvHNSRKFn5cCXIulO7U4N4BXVS7XSLJ/VAhxtPSDCQGa7TlBsANl+oGxs2jG
 GuUEcKACDZTBimT18uKnc6GGAtZ0JvyBkFKd2p7IiLPCdcOK7RLmWQH8c7DI8OGYCs9Z
 XfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688798427; x=1691390427;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M4XBeiz1Bs3UEbFkO0Pc/PUq5lc07r0fRx5G2B6Z1vU=;
 b=Nl9jiyXUT8pYv39fsZCSt0ZeKs3wjQj1iYczDPa3hnbzQrJOxVbdaXJUR/71jtmg3p
 EIVSDNJ+k1gBIldTnE8MRuvOV708/kvViPo4h+Co2C/LJSyaAGoDy1TEb8OV4ppCx5yx
 MYFfIw/T0o4k3RJj6jc3TPYB+B5f88ODILrudTQm6TwlMZMRQAJ+tQ3XyyLLfrHFwVu6
 56b3lH3ri/NZIrRpvwX+GQe0eEBQ7pu9ezJT0u3mJa/BtsGj/UvL53x/YcW41YtB6SII
 CngXLwXuAITVG7wpgckY9GPPa0pWMIZXqkdAUcy2SFNIziVelrKtAAyAL4vTzr67vYlT
 cvpw==
X-Gm-Message-State: ABy/qLYmRCiTgPKWtKzXPHppDJq1S4+iRkmlI3htIovot+6023CJWStl
 o8eLFzq3yjVYzBDXiutFK6jC+Q==
X-Google-Smtp-Source: APBJJlG1jHzCn4QmysKY822vV1dkbYDfh3jZZFieG3rnQOPGKEA+nrLANmg16Gk0MpncVr2mMfsVqQ==
X-Received: by 2002:adf:f98b:0:b0:313:ee5b:d4bc with SMTP id
 f11-20020adff98b000000b00313ee5bd4bcmr5494545wrr.5.1688798426845; 
 Fri, 07 Jul 2023 23:40:26 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 h9-20020adfe989000000b0030647449730sm6228051wrm.74.2023.07.07.23.40.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 23:40:26 -0700 (PDT)
Message-ID: <b62134eb-773c-3b97-f310-dd04a45ddaee@linaro.org>
Date: Sat, 8 Jul 2023 07:40:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/3] linux-user: Fix accept4(SOCK_NONBLOCK) syscall
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20230708054249.10245-1-deller@gmx.de>
 <20230708054249.10245-3-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230708054249.10245-3-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 7/8/23 06:42, Helge Deller wrote:
> The Linux accept4() syscall allows two flags only: SOCK_NONBLOCK and
> SOCK_CLOEXEC, and returns -EINVAL if any other bits have been set.
> 
> Change the qemu implementation accordingly, which means we can not use
> the fcntl_flags_tbl[] translation table which allows too many other
> values.
> 
> Beside the correction in behaviour, this actually fixes the accept4()
> emulation for hppa, mips and alpha targets for which SOCK_NONBLOCK is
> different than TARGET_SOCK_NONBLOCK (aka O_NONBLOCK).
> 
> The fix can be verified with the testcase of the debian lwt package,
> which hangs forever in a read() syscall without this patch.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   linux-user/syscall.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

