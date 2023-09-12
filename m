Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D0B79B753
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 02:06:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfqv2-0005ci-Nb; Mon, 11 Sep 2023 20:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqv0-0005cU-Tb
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:06:14 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfquy-0003Yg-N2
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:06:14 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso4280900a12.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 17:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694477171; x=1695081971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G3NwlG3W9UqXQLwLNlX2w2AQd2isOLqTWv6GotVWPQs=;
 b=mPmsVg7P5rYbpCwjt9RP9idNl6GrDmFEYiJ1+4bexzeWCcam07ESjv/0WB+/B8ln4n
 utn5GWuygJX1Z6UBp4lor7KMKyZDg+8AEdEG1N/OPVVVh2pjZQ93xtuckDpPdd/XSYih
 PUN3zE8lp7aWdA00v4ONpTv4j1rvpiDZTC+Fl+56ox93OdaY7TWQkT1RlKpzFZN4JKrR
 lMpSQ+b47Lb/kknpRTwK47y6sckBJG3U6w/sjWyW6dgd0SMAvg/e/nzp4HzFKV2S9jjH
 GkjABi8q3LEDUwC05+JkamPg2FYbc9h0x0xW8jbKQ/P4XwRy9ATKhNQX2fdhELP9EAnm
 k+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694477171; x=1695081971;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G3NwlG3W9UqXQLwLNlX2w2AQd2isOLqTWv6GotVWPQs=;
 b=bic8oRjcVWJ6wWNUjrW9IdlYLisjlrVMSf8CkG10TigEhhr8HmkFm0NcJj1PaVyfna
 LLN5WkPytFYyNH5jOak6JltYGmmohZBxo+qodVj3VIRhf2uOw84u+Hs0NUIgixbtW1Dx
 DNJx9Y9rwTctrxvxefHi1RKjxtsv3eKl1H0oiVFl45Qi2IDnLrA3Kj0aSJl9bgRujSDO
 jzNPOKmRl1Dxj7adISuFEah1OvuY4M4JQhtw+cUL1Z9cueiwDLZhYWZvm308vd+aKZGs
 m0F6Gjv1n3XZJO4x31nTYLFAnIpY5wdRiWKj7DN6pJm6mG/LITEaadfGBDmwI7qXYwBb
 XIWQ==
X-Gm-Message-State: AOJu0YxW5K5CnVW7FDvB+yYXf4dGM6lSJgZ8E91UG//NtZ70yZuPw0f9
 be4fBWHl5M7l6YBRv7J/r/Ga6g==
X-Google-Smtp-Source: AGHT+IFGKgZucqxjy6z+RIoKUU+OCIzcrshDiQePaGj3ZKpWuKkxRVS7nky96eosTn8kwOqI6H1bzg==
X-Received: by 2002:a17:90b:384e:b0:269:85d:2aef with SMTP id
 nl14-20020a17090b384e00b00269085d2aefmr10350916pjb.20.1694477171190; 
 Mon, 11 Sep 2023 17:06:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 on10-20020a17090b1d0a00b0026b76edd607sm6340825pjb.15.2023.09.11.17.06.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 17:06:10 -0700 (PDT)
Message-ID: <9d016f94-a25d-86ea-636a-3ac5959aad34@linaro.org>
Date: Mon, 11 Sep 2023 17:06:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 19/23] bsd-user: Implement shm_open(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
 <20230909193704.1827-20-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230909193704.1827-20-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/9/23 12:37, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Co-authored-by: Kyle Evans<kevans@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Kyle Evans<kevans@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-mem.h            | 25 +++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  4 ++++
>   2 files changed, 29 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

