Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4817729FE
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:01:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2f7-000500-6B; Mon, 07 Aug 2023 12:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT2el-0004vx-UI
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:00:35 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT2ek-0003OY-4m
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:00:31 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-26934bc3059so1544337a91.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691424028; x=1692028828;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mh4/1T5p5CcMaSp6EnEGfr1HOB7cThm9avf4Wux9eRw=;
 b=GzIbFR8yKHHbU6WR0r7lOsXZ8gJi/PK5L/xctEffEZaBF1we/TOe/zTHwGAcViuf/n
 vQaABDssyxCu2uXn47nqpnMC7nR4uIabK4iWZ+ZB0iui93ZSc6ezZLwFDc4RTICaGzkz
 uQBeS+qO4gEiRjdYHu1FhkJovEcoRhGsrljC84TVq58Col3jcVukf9/XOnlmB6EDqTa3
 khWIyvEKN/tYCfyI7nhGRu00shKbTnmkgD0t9y3HPs2a0WZGxMwFG+HUI4Fj2TYlw/iJ
 2ALbxWD8LotJ8VUClSj0zYx7VYQbo11aZxYN3jo+23jxagfjbGsxIedj0N/vVJSauvGf
 vRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691424028; x=1692028828;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mh4/1T5p5CcMaSp6EnEGfr1HOB7cThm9avf4Wux9eRw=;
 b=HAVM1UaXahEwn/DvUh+4MsPC/cX/corWdszI282MMvz/OZekzb+t4RaTxoK/QrpqIL
 jP6HxcZ/moa5lNrZrWUxNfGS4U0+By3QzQLc5hlsLMSyz0kb7VxIo5KZJR8HyJYH9yI3
 JbU8H2jfyK83F1jvDh2dRKLKrqj8M3qDlvAsBxc5YJHhtfcDznVVhoRCeT/Qvv6mkkRx
 scOxQ9CbMkIMVURVoNokCelSnAzHdDG2h1y3oh1Sprz86ohcVn1K1tijmgumaYIMZUz9
 2kadpBLHDSdIe9UNrJjn4QZcg0ANazNlI0AMYfrJsWsZ1I3IIEU/FHgXLFWd21MH8YZY
 bzuw==
X-Gm-Message-State: AOJu0YwRIuTWhwFNZGrxljWVaOQNAAxVlwhg2w58VCDKd0V3IhQKoIHq
 XCZr3DC8ODXk4A2oYspdOCb3jcKk44FEb/KljPY=
X-Google-Smtp-Source: AGHT+IFQQSFbDbC6TXyAn51blW/8Xzv+Zd3V90bPTXjsXAILe2kzOV5C4YyKpFciTziKB9qzD7Dl7g==
X-Received: by 2002:a17:90a:8505:b0:261:219b:13b3 with SMTP id
 l5-20020a17090a850500b00261219b13b3mr9116430pjn.16.1691424028166; 
 Mon, 07 Aug 2023 09:00:28 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 pj1-20020a17090b4f4100b00263d3448141sm6182536pjb.8.2023.08.07.09.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 09:00:27 -0700 (PDT)
Message-ID: <609387ae-de8e-61bf-842a-b277ecfc345c@linaro.org>
Date: Mon, 7 Aug 2023 09:00:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] configure: Fix linux-user host detection for riscv64
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org
References: <20230805180214.57198-1-richard.henderson@linaro.org>
 <CACPK8XdWpOhwKrdxh+NoMMkP=63g7ib1PdXSrR8f1snAsLu8Nw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CACPK8XdWpOhwKrdxh+NoMMkP=63g7ib1PdXSrR8f1snAsLu8Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 8/7/23 01:26, Joel Stanley wrote:
> On Sat, 5 Aug 2023 at 18:02, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Mirror the host_arch variable from meson.build, so that we
>> probe for the correct linux-user/include/host/ directory.
> 
> This broke all of the linux-user targets for me on a ppc64le host.
> None show up when running configure --help, and trying to select one
> with --target-list errors out:
> 
>    ERROR: Unknown target name 'aarch64-linux-user'
> 
> Reverting this patch restores the old behaviour.
> 
> This test is the one that fails with the patch applied:
> 
> if [ "$linux_user" != no ]; then
>      if [ "$targetos" = linux ] && [ -d
> "$source_path/linux-user/include/host/$host_arch" ]; then
>          linux_user=yes
> 
> WIth your patch $host_arch is ppc64le. Previously the line was:
> 
>   if [ "$linux_user" != no ]; then
>       if [ "$targetos" = linux ] && [ -d
> "$source_path/linux-user/include/host/$cpu" ]; then
>        linux_user=yes
> 
> The directory needs to be /linux-user/include/host/ppc64 for even for ppc64le.
> 
> You've put the new test just above the switch statement that does
> normalisation of the host CPU name. Could add riscv to that switch
> statement instead of adding the host_arch variable?
> 
> @@ -508,6 +501,9 @@ case "$cpu" in
>       cpu="ppc64"
>       CPU_CFLAGS="-m64 -mlittle-endian" ;;
> 
> +  riscv*)
> +    cpu="riscv" ;;
> +
>     s390)
>       CPU_CFLAGS="-m31" ;;
>     s390x)

Grr.  No, I cannot simply do that, because passing "riscv" and not "riscv64" to meson also 
breaks things.  See e3e477c3 and 887cba85.

I'll figure out something else.


r~

