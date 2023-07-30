Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C127687CD
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 22:04:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQCdS-0001Rm-ET; Sun, 30 Jul 2023 16:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQCdQ-0001Re-PN
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 16:03:24 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQCdP-0004WI-9b
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 16:03:24 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b9c5e07c1bso32758975ad.2
 for <qemu-devel@nongnu.org>; Sun, 30 Jul 2023 13:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690747401; x=1691352201;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tTMRyA2MQre4KleArxU4diJpXc22LJ+IEdIFzEfdJzg=;
 b=bVYbqWr5Xul4Jq0UzVzx/6/UIKCvcG9HsHEy7+TylSIowkuvRA1hyAYIiTgy2cBxD9
 LeaRsPynwcEiq2D4Ne3Ndmx06DFW32iioQpUS7JAK4fU3Ywhmeb+OX78ZBimO0Q53kel
 kPAhR1gQYZZRwopS9oqfzw9Qnv7G+q1TfORqRNASWcuGqf7pNISpSmwUjshNfhBihKvx
 MkI5RDBhlCx9eTLDB71xYfpnNqnVaR4788Pj+eeWMpY3njV97htDZJ9jEaytQY1ktJ89
 /rZuab/nQP7hKtQ21ESbxvbL6NxDYOI9SpJ4TsBSqJ+SaeGqg7BLS8ptoNcI41LqwIow
 TYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690747401; x=1691352201;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tTMRyA2MQre4KleArxU4diJpXc22LJ+IEdIFzEfdJzg=;
 b=TktX+7zs4tYd6o5MOdxImUmRL45owjzo5S4dOdQ7yAAOX+Bk7cNknowLnzhjJPPwJH
 NY6rQyCXs7gA79iLGc+psxa+VuXLNjSkbmSK+Y5Eim76wM4JBoQB98hTS+jTPEffJt2b
 kSAGVk51ZiC4ZWWPxVImA9P+M8O70KW9GfJThkDDRv/du6dNz2hL0zEEyBd+/vpZhhl0
 T1UmJb6T77hkSWi+q6c8JMEhd1xOIQvolqJpn69AzyJ1SC8aeprLZWX0u7JWma1T7qOE
 HAj5Q3Hwl3WFs1H13PyTd+ntdgU2Ko67SNR5EBrVt+BPspyAN8HCPoeMBpUwZvOuWmKh
 O4PQ==
X-Gm-Message-State: ABy/qLbT4LOHCGzRYcwuS285Pctkm9YSr1zU3Tp1mioDpJCR3U0+tMhS
 7LX3rVuixlwFj0zB2j3nnjX4uw==
X-Google-Smtp-Source: APBJJlFyVVfCjMX95FXu2MvvRBy+k1pHCkOTHjCQ+aAq3YRWXDXsitGAhlWO2USGKjW3o6X/BWr6bQ==
X-Received: by 2002:a17:902:db08:b0:1b8:a19e:a3d3 with SMTP id
 m8-20020a170902db0800b001b8a19ea3d3mr9512019plx.52.1690747401254; 
 Sun, 30 Jul 2023 13:03:21 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:bc22:a670:ff11:5de6?
 ([2602:47:d490:6901:bc22:a670:ff11:5de6])
 by smtp.gmail.com with ESMTPSA id
 co4-20020a17090afe8400b00267e299f71dsm5100852pjb.7.2023.07.30.13.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jul 2023 13:03:20 -0700 (PDT)
Message-ID: <b0ff6b75-60c9-aa3e-e701-a4062558a9bf@linaro.org>
Date: Sun, 30 Jul 2023 13:03:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC][PATCH] accel/tcg: Use lookup_and_goto_ptr() for linux-user
 in translator_use_goto_tb()
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <ZMakYpOgco2Ihg0G@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZMakYpOgco2Ihg0G@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 7/30/23 10:56, Helge Deller wrote:
> I'm quite unclear about translator_use_goto_tb() for qemu-user
> emulation....(and in general).
> 
> Based on the function name, the function translator_use_goto_tb() shall
> help to decide if a program should use goto_tb() and exit_tb() to jump
> to the next instruction.
> 
> Currently, if the destination is on the same page, it returns true.
> I wonder, if it shouldn't return false in this case instead, because
> arches have code like this: (taken from target/hppa/translate.c):
>      if (... && translator_use_goto_tb(ctx, f)) {
>          tcg_gen_goto_tb(which);
>          tcg_gen_movi_reg(cpu_iaoq_f, f);
>          tcg_gen_movi_reg(cpu_iaoq_b, b);
>          tcg_gen_exit_tb(ctx->base.tb, which);
>      } else {
>          copy_iaoq_entry(cpu_iaoq_f, f, cpu_iaoq_b);
>          copy_iaoq_entry(cpu_iaoq_b, b, ctx->iaoq_n_var);
>          tcg_gen_lookup_and_goto_ptr();
>      }
> 
> Shouldn't, if the destination is on the same page, the (faster?)
> path with tcg_gen_lookup_and_goto_ptr() be taken instead?

No, because tcg_gen_lookup_and_goto_ptr is not the faster path.
That always involves a lookup, then an indirect branch.

The goto_tb path is linked, so only requires a lookup once, and the branch may be direct 
(depending on the host architecture).


r~

