Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A21756BFC
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 20:27:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLSvA-0000iW-8z; Mon, 17 Jul 2023 14:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLSv6-0000hm-PR
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:26:05 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLSv4-0004NG-Jc
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:26:03 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-767582c6c72so462904285a.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689618361; x=1692210361;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2fcb7Hm8Q+2wyrfsuksV/VNKzvgCqbnJD8JPGLwRQ90=;
 b=JtCX/yJpsjxi0Lmtq0jPahjcmuRvq68sgd0xK8jYalzX8FUqBh4mK5acK5gLRkqhG2
 aW9Xl7AY11v9gFcxq3bcS/FsG/MQnrp55HIOgMJvQfEZ+uHAgmBFAALbO3q/fCFUDMNi
 Q5YfT2wpBuXF7R8lMYMuhMXxvqJg/VyRtmu20YNo+Wbo/X004I7qj1k632+3a6MB1r0m
 X+jQ5vwagRq0PNtDPOh/G8wXckMuenpDMx9mNDyqUzcFE6CeknJsooF4pTq9LuDiLDfI
 AhuMuJ6I35NPZaHWPoJYVgAV4yk9ZuBSzdQjFwbUwk0YnUslZUuwyBIXgMJ+Rl5R1vmY
 k0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689618361; x=1692210361;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2fcb7Hm8Q+2wyrfsuksV/VNKzvgCqbnJD8JPGLwRQ90=;
 b=YRecoqhypZRVryXmhL+ugUGlVt1Q6Wum3E4fZfeAtyd+mHO8x1jq/ToCcn1xfUT7Ak
 1nPAbYy/ujwAUda3aK18LGccNjAyyjbITjjk31XilBls/p4ELZby8UBUa3xGNgUBiFza
 YISmaqNRCILRxo+eW40cgL8lrgZyqlD+2wwNXNXAdJH3t8fSuJ84C0I/XyiqMUI8/lPG
 gmd4w+lSEFMfKj+TRIY7VHXtmxiHRloQzK7f7QJXO4WylOtN/IuAyuDT0I5Appz+huYW
 OounW1vewOfMl4lg/vwRnZ4nW7UqVO2DwqrRrYjW2QXcQ0tnYCU85I8S/xSfI14hbu8t
 35Dg==
X-Gm-Message-State: ABy/qLb0ZCh1JHqoNLHtj5rRHQhs38k4qx5aXFD7DRvNOAYtSWMFqipn
 1tCBppi9z7ll3riDZT1lqnwXIA==
X-Google-Smtp-Source: APBJJlG7uHv/sfTdkxcgZqVQLD9tfpJUYQZ9dhRet1TkGUncgyRIoJgw8tVtYxOUhN991fk4T5/sQA==
X-Received: by 2002:a0c:df90:0:b0:636:b633:9fd6 with SMTP id
 w16-20020a0cdf90000000b00636b6339fd6mr11795940qvl.17.1689618361010; 
 Mon, 17 Jul 2023 11:26:01 -0700 (PDT)
Received: from [192.168.224.227] ([172.58.27.30])
 by smtp.gmail.com with ESMTPSA id
 a24-20020a0cb358000000b0062dfdafa0b7sm78178qvf.136.2023.07.17.11.25.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 11:26:00 -0700 (PDT)
Message-ID: <10893737-8628-672d-af7d-7d959d1773f5@linaro.org>
Date: Mon, 17 Jul 2023 16:07:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] accel/tcg: Take mmap_lock in load_atomic16_or_exit
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230716170150.22398-1-richard.henderson@linaro.org>
 <878rbeyg5m.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <878rbeyg5m.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x731.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.097, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 7/17/23 11:40, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> For user-only, the probe for page writability may race with another
>> thread's mprotect.  Take the mmap_lock around the operation.  This
>> is still faster than the start/end_exclusive fallback.
> 
> Did we have a bug report or replication for this?

See the comment:

> +         * We must take mmap_lock so that the query remains valid until
> +         * the write is complete -- tests/tcg/multiarch/munmap-pthread.c
> +         * is an example that can race.


r~

