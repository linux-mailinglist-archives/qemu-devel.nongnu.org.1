Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 335BB76774C
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 22:58:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPUPl-0001Hp-A6; Fri, 28 Jul 2023 16:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPUPS-0001HZ-9Y
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 16:50:02 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPUPQ-0003Bd-Jb
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 16:50:02 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bba04b9df3so19748675ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 13:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690577399; x=1691182199;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XgtZUTNtUDXB1i15EqvT3EqEpEn4gjKig9qZs/eviqM=;
 b=io79vJpUd90PvRYNBAFGFW0Nz+CZ0uVKm7RSIYD86b/0mQEbM3nXB296PULnj8jOLO
 kuWRiprBjc0kAJ7DT+d0eyc6UpUTrVl7s86vZ6+FvBFrEZnKSAPGznuGIsvv8EVNdImb
 CuG/n2+3HJwEB9uLAzCeI/ZYXQYk8E7MSAQBlCI6SY9FGdv6luHIcnnjBhRSc4tMNcfG
 I1denNK6+6i7Vl7KSDQa0ljCIkpEJIieYlMYM/uvEbz8QNOMHVLfhVspBydq/wWdle2i
 OrL7O9H5FDRRwb1LnzgNO18cmrCXcCaQCNvw4w78CYUkcXoJKwgIvir0VN45njmDObbQ
 +Ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690577399; x=1691182199;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XgtZUTNtUDXB1i15EqvT3EqEpEn4gjKig9qZs/eviqM=;
 b=aK5A4w2lko58kIYISxsb9KW4YcMsM1DbTyQBQNYQfBvcCNCjWQqx+XF1p0axJQvjz4
 wH5OdHWc7jFzWzWj+NVkJ5hDeSVrUYqPSK+Zk0yIkKWDbBDxXLsqgcnE128Ggwbk+0v9
 4EjkkLWXLDfBbN7vpImLolI78y9uJLfZJaXuzcLc5aow7jdf3SrB7OHkihfqGLmLpF6M
 3HY7Tln/mo2LrGrGelvACWQEQmCDYrovtly75JIVYouxV4+4kDUTP+lhcEzUZj6ki2Q4
 aSS6cEhexT8wdXR7CNf83u1FhoO5YfTvhAJaDoSJqk7dA3Q3BSIKzC38q1ZRBcxOaXg6
 TwEQ==
X-Gm-Message-State: ABy/qLZax12L49R6OKfsyEqnBOH/oqMI643ZEpgYn4PDJpqRH570JOqC
 iV9XN3WY52yM6OCcHYQT2kp1LQ==
X-Google-Smtp-Source: APBJJlGaNttW3kOPvbwqHjSsWjHkVnYr2CM0Gk6XQovU4utqBHKIjOlK7Zb4A6P3Qdt9WlltZKBc2w==
X-Received: by 2002:a17:902:d382:b0:1bb:aa83:f848 with SMTP id
 e2-20020a170902d38200b001bbaa83f848mr2933897pld.43.1690577399146; 
 Fri, 28 Jul 2023 13:49:59 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a170902ce9000b001b5656b0bf9sm3977283plg.286.2023.07.28.13.49.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 13:49:58 -0700 (PDT)
Message-ID: <60dba863-e6e6-f72a-a40a-4dec37b76a9d@linaro.org>
Date: Fri, 28 Jul 2023 13:49:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] linux-user/armeb: Fix __kernel_cmpxchg() for armeb
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 John Reiser <jreiser@bitwagon.com>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
References: <ZMQVnqY+F+5sTNFd@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZMQVnqY+F+5sTNFd@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/28/23 12:23, Helge Deller wrote:
> Commit 7f4f0d9ea870 ("linux-user/arm: Implement __kernel_cmpxchg with host
> atomics") switched to use qatomic_cmpxchg() to swap a word with the memory
> content, but missed to endianess-swap the oldval and newval values when
> emulating an armeb CPU, which expects words to be stored in big endian in
> the guest memory.
> 
> The bug can be verified with qemu >= v7.0 on any little-endian host, when
> starting the armeb binary of the upx program, which just hangs without
> this patch.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-stable@nongnu.org
> Reported-by: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
> Reported-by: John Reiser <jreiser@BitWagon.com>
> Closes: https://github.com/upx/upx/issues/687
> 
> --
> v3:
> - use tswap64() in arm_kernel_cmpxchg64_helper() [review from Richard]
> - mention that bug exists since qemu v7.0 [info from Markus]
> v2:
> - add tswap32() in arm_kernel_cmpxchg64_helper() [bisected by John]


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

