Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A57720D9C
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 05:29:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Hwx-0006Te-Qk; Fri, 02 Jun 2023 23:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5Hwr-0006NO-Po
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:29:02 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5Hwp-0004Du-98
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:29:00 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3980f2df1e7so2290714b6e.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 20:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685762938; x=1688354938;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=90OVWhSvfeuahQ1nkOs3ms+6HyMVALOqvyrfKrIdRps=;
 b=ajZBzqzzBstBCeTQb0QBEMgMNlj/D6qnb44zAnPWtRScKbGc5vD8QaY6oSqjHWhGs0
 HYMOWRgkyvYvtl4O54Oj7diqLWzQ840Z8IHgBQi503goNxtPcNzzbURe1qbyoUsMVloG
 ufsc8JQZfViinviKFe3idqcfjXOKzinCJdifqSdlq2+ZnvSOcp2+F1SA8cO/TC7sfdr3
 qmrV6ncpY8CM9pMQJLfA6whmNQPwC/0QLXv/eLZQ5VJ+s+qwvsHwkNtxjHMavKkn9bNm
 QFyF/Y8HAS6njEQDyg0D2LuTIktOrl0ia7qENA5+xNji3cbGQRdADo64sKsm08CVMtmw
 sLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685762938; x=1688354938;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=90OVWhSvfeuahQ1nkOs3ms+6HyMVALOqvyrfKrIdRps=;
 b=aAFmTJrTa64/0WgJniwZLcBcNn9xRbOEOtpKfFLOLy0aAbemQ5Fon/JIW+d8exJHXy
 hcTpgt8o6dXBiQucizn7lb5HDCd/ZTLgxYLfSH7hbQySKhv1cBxo+5/g/QBYcXs4+9ck
 24tfchuhIUl/c9s2uUnH3PQpYytaYL8YcTpX9AcYTQ+EJ6huCNno3UWbKtmz8hWDHfFd
 97TpSD2uVjNrWg3CvSXKY1mUO2GV84FhvZir5A6xpXjwPimlizmA1wJIuQ5MwVlhURJ6
 O+1FcYuz4KGH3Rdm3R3lMSk+cJo7yrHV/dnXsmnhi5EaFCoZ/DQHvbClPyLA8O2yABWX
 Ud2g==
X-Gm-Message-State: AC+VfDxqiaI8OUhdbCdJEvCcVtapR9c6bZH4vhM9Ag+0337jcasfr43g
 DbeCsPJbN3XYjfTUT74406vFpw==
X-Google-Smtp-Source: ACHHUZ5DaWPwW7k0nispuP/LI5A9ErFZip+/Zq+LbXyBOQ+qFQbjBHn02tocivB8c3dn7Hu88jGIjg==
X-Received: by 2002:a05:6808:a95:b0:38d:f794:26c with SMTP id
 q21-20020a0568080a9500b0038df794026cmr1760675oij.56.1685762937936; 
 Fri, 02 Jun 2023 20:28:57 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a170903200a00b001acad024c8asm2088353pla.40.2023.06.02.20.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 20:28:57 -0700 (PDT)
Message-ID: <f5d8ac15-2e39-b292-af0d-19ab2847dd3e@linaro.org>
Date: Fri, 2 Jun 2023 20:28:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] target/riscv: Add Zacas ISA extension support
Content-Language: en-US
To: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20230602121638.36342-1-rbradford@rivosinc.com>
 <20230602121638.36342-2-rbradford@rivosinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602121638.36342-2-rbradford@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/2/23 05:16, Rob Bradford wrote:
> +#if TARGET_LONG_BITS == 32
> +static bool trans_amocas_w(DisasContext *ctx, arg_amocas_w *a)

You need to eliminate all of the ifdefs, because we can switch a 64-bit cpu into 32-bit 
mode -- get_xl(ctx) shows which mode we are in.


r~

