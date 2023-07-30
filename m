Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F0376871D
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 20:19:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQAZL-0006CA-8o; Sun, 30 Jul 2023 13:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQAZJ-0006A0-2r
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 13:51:01 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQAZD-0006AY-E5
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 13:51:00 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-563de62f861so2200038a12.1
 for <qemu-devel@nongnu.org>; Sun, 30 Jul 2023 10:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690739452; x=1691344252;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V5C+q1hDP46rXQTn3Sqn5gPM8wPaQ2ax9Bdf7ROhUdA=;
 b=EIcbNMJLt/1vxh0dNXGnEz7hHIW/ScqUSonj9xg25GtqQc9cNRljbrU6qFlWIXFV17
 Y5hgm8b3G/xvRQFAkf2pkxbtzrU6fwgNVeQiRPISZ54pnbkANNpvVb6mWiTDg4jysQrv
 X+x8p9QzFB103lMQoi1AVNeaPh+KW8s6TvNeeoydcyKyFkfyvo9WUiUDKcQ5KtNxSMpD
 0RjnIX37d6NErUxnBPBfBiBQUf0/q+UFzDhC7egJ0sdJJBp7riYTnLiCdhrjbOC/dTNM
 48f4MN/4YZKUPfYTTQ5ImVsLcrRlRLCwtAYdxNJkLUOCLnR7oIZmosQJZKGRhIQGdhyM
 ZF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690739452; x=1691344252;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V5C+q1hDP46rXQTn3Sqn5gPM8wPaQ2ax9Bdf7ROhUdA=;
 b=IAwn5gF1Sv2L5bMmPKiOUMb/AIHE7FNOSKjrwHg6cJrCQ0PTv3RT4sZ0VqyekQ7rWQ
 bjJ4XQ95xW/ZoMZ5m7EI7gwUQ4MXUc6JqreoQV9Brb9F67hV3iNq5o9gz0KwADspdb0s
 yK46XmzPOmzmG7vC+QGRqrVjGJ4sdUF9w3SmyV29mF6FhTT9eLIBr1cUNEv0Jj8XoXiI
 FmcaKU2vD8kXO2pQnR0ZI6ngok2xkAC4+LQgAydrHG1peib/zPtmsQzHt7vOOhHvq/XG
 M7fD0aBj/iD9RseiB+JEA/QYtIjaZfjwrvBAbh7sVr1I0qH42YUObeXWLdvFOJwSc00G
 b7iw==
X-Gm-Message-State: ABy/qLZHqkaod8ncfUk7QZbFUqPMopGegxYyIr56eEjYCn+LBsEs53LB
 6KDC9DwooOTWCPK0vwP7aGbHqA==
X-Google-Smtp-Source: APBJJlFudyPKdpq1suW2HyuhWIrYytlkLUOgOYUglvO6cTro6dzEwl894CG7U41a1Fq9EelOaPDpEw==
X-Received: by 2002:a17:90a:b101:b0:268:5575:93d9 with SMTP id
 z1-20020a17090ab10100b00268557593d9mr7043079pjq.10.1690739452468; 
 Sun, 30 Jul 2023 10:50:52 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:a7b4:380e:e513:5ef2?
 ([2602:47:d490:6901:a7b4:380e:e513:5ef2])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a17090a150700b002636dfcc6f5sm5341979pja.3.2023.07.30.10.50.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jul 2023 10:50:52 -0700 (PDT)
Message-ID: <8dcbe033-bf15-4df3-5042-5fbd3319ad22@linaro.org>
Date: Sun, 30 Jul 2023 10:50:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/hppa: Move iaoq registers and thus reduce
 generated code size
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <ZMaQGwK1Ikj27ZPk@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZMaQGwK1Ikj27ZPk@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 7/30/23 09:30, Helge Deller wrote:
> On hppa the Instruction Address Offset Queue (IAOQ) registers specifies
> the next to-be-executed instructions addresses. Each generated TB writes those
> registers at least once, so those registers are used heavily in generated
> code.
> 
> Looking at the generated assembly, for a x86-64 host this code
> to write the address $0x7ffe826f into iaoq_f is generated:
> 0x7f73e8000184:  c7 85 d4 01 00 00 6f 82  movl     $0x7ffe826f, 0x1d4(%rbp)
> 0x7f73e800018c:  fe 7f
> 0x7f73e800018e:  c7 85 d8 01 00 00 73 82  movl     $0x7ffe8273, 0x1d8(%rbp)
> 0x7f73e8000196:  fe 7f
> 
> With the trivial change, by moving the variables iaoq_f and iaoq_b to
> the top of struct CPUArchState, the offset to %rbp is reduced (from
> 0x1d4 to 0), which allows the x86-64 tcg to generate 3 bytes less of
> generated code per move instruction:
> 0x7fc1e800018c:  c7 45 00 6f 82 fe 7f     movl     $0x7ffe826f, (%rbp)
> 0x7fc1e8000193:  c7 45 04 73 82 fe 7f     movl     $0x7ffe8273, 4(%rbp)
> 
> Overall this is a reduction of generated code (not a reduction of
> number of instructions).
> A test run with checks the generated code size by running "/bin/ls"
> with qemu-user shows that the code size shrinks from 1616767 to 1569273
> bytes, which is ~97% of the former size.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

