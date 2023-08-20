Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 292E7781E41
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 16:26:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXjNC-0001bx-9X; Sun, 20 Aug 2023 10:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjN6-0001Yx-Pw
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:25:40 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjN3-0006uD-L3
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:25:39 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-790f831c6fbso86285939f.2
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 07:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692541535; x=1693146335;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EYj8QVdIwiEFfQzS2mP0JtqlbbDEMzho5oS43Wx91ik=;
 b=EX0GlsL/50XW+tdDAt/yPPnRO4ttkhtFpLWUZrbZrqOerKtsSYu39nqOREn3nVElZ6
 kNOh56K0DZBD13J+k6Y5Q9tV8fhOgQqzs22abt9YPWPnvNokef66aV2mZe7obvZwg4mz
 3jr57jllIlUTkxURjUKgpxUZuymZUjhna4kZ8G5G7cmCy1+4mOe9zeNSUxxSpYPZ6+f6
 eC0u+kq7uSNmokQRkRPN27RmZtKjSuARFydk7rbSAWDsuOQMAU/9tJgSwPOFTvmBTbn1
 +fUx8CnLw3t82ewQthf7xAwzbkcV8M7PcDU2MSFOyFeEahe2yTERyNBFbIqjPWGGSahk
 91dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692541535; x=1693146335;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EYj8QVdIwiEFfQzS2mP0JtqlbbDEMzho5oS43Wx91ik=;
 b=VBijRL0MDRadHSX2A3XYv7r1IMogLGR3o4WTRIk7bpNd8HByShW2loiX6MxUjbEZgt
 96Pw+QBpCi2HDgurqllIMEYVYblF1kG0LgbNyGlgSdWa3sUvb4C5okIwDaEPcbQ4EN45
 pn2uajRa50E7PPmxYezm+NXjNv8rFQzdMrsiZRm1lv/AlbuU8yGHg9p2zxtEXQGytDxQ
 SPpd2mmDmdkW6lR8nEwj0Lz8FPus5xqB6x6CdNBbvhLf+rGUaYUL4jkQ/mG3smfrowMg
 LDXbE60YyFXDbP99jhqU+Owv8s9fqWgvehuRzEyl9E+7KeYuprHxgPbjra9/O/q0Z0zN
 3Zhw==
X-Gm-Message-State: AOJu0YyDjGYCt37CXfYhrEo4OC/o1wfZHSg8+riuQfWIUAkAr84QuXKq
 /WT1/pjBDW75gQUkw5fBB61dlQ==
X-Google-Smtp-Source: AGHT+IHTGwHMbyE43YKNHag8OylukOReWitHFydRv6+dqzuA3GLP0MN5fXhCzyBaUBjjUJ4N/OSbfQ==
X-Received: by 2002:a05:6e02:118d:b0:348:dbbf:a9f5 with SMTP id
 y13-20020a056e02118d00b00348dbbfa9f5mr6067426ili.26.1692541534967; 
 Sun, 20 Aug 2023 07:25:34 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a656aa9000000b00563ea47c948sm4357667pgu.53.2023.08.20.07.25.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 07:25:34 -0700 (PDT)
Message-ID: <00005378-71f6-d44e-7f25-a67ff46db434@linaro.org>
Date: Sun, 20 Aug 2023 07:25:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 13/22] Implement mprotect(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-14-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-14-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd36.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 8/19/23 02:47, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-mem.h            | 7 +++++++
>   bsd-user/freebsd/os-syscall.c | 4 ++++
>   2 files changed, 11 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

