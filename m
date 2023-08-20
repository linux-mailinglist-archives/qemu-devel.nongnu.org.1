Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDB0781E01
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 15:55:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXis0-0001PT-2W; Sun, 20 Aug 2023 09:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXiry-0001PL-9g
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 09:53:30 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXirw-0000hX-8x
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 09:53:30 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6bd0a0a6766so1906586a34.2
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692539606; x=1693144406;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ysLZ9+shxdReUpGzuwqor8utFJDRhs02RtjNqz/OsCI=;
 b=oaK4B6TZmxzQiNaw7wQS9nqVu2cQUfwzEqKA9QOXu21W6SPLPBpCtfiXH31nX/M0Bq
 gBVcphX1VfcnY/57qNXrU/KfHRrKOGsELO1Tm69y7Je/wpHrarVnee+lcR1V3CxdYe4s
 EeLWtgfIlr1QhkYkBbtWiPhBtMFzvCQopzKBDB6l/Xl5b1oEh9HdBJaE/Ct6Gxa/dBYV
 tX8DNKiCW0DPayAWOYl21woAhnZ3a4slrYeiasDJ8yaZo8xf6UrzmIZMkn7YI9NJ8lP4
 wWtf77H/UKSMzLcFZ4+w9rMgbhcMrQuJr0lO4YPxnbRJy89ma+yfNbdY/W4vNuUXz6DI
 JQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692539606; x=1693144406;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ysLZ9+shxdReUpGzuwqor8utFJDRhs02RtjNqz/OsCI=;
 b=gN3ddJSHY3IwSm6r623cJ5k8XNxuDCgpJvLgBGkT60AngdkZ6/nEeV4HCrO6mkRZb3
 56wrJ7Qe3bTwtD63MHbtQnp8wxPz4pBTi5SxQe9aIjAA7SvAsIgjh/OOU4FH//I0JK+u
 KXYvkU5nCjc43+9x+4uFenYPBNePixI9KHwQ74dfivbMXH2hJ8XItB9O2D28HNBg+zkt
 smtZNypBW4l5mHQjr+hZaDbXkgV/esBINVyInfU124cRrRLCssnRWj1FOlib76lAWbDg
 dUvKkUDirADGDQ4WnapsZegeSdRg34t+5OEzY6BaIm9gXC/cg7tXZ4QQMbdtUbdrYO6g
 tWyg==
X-Gm-Message-State: AOJu0YzIaFXoLv3b2oeYhuC2Mw8QdyTqlBnw8rAD95C4SCeR3S2dC4hE
 HU7d5l+OJoeAPiT4sDqqQunOEF6Hau+FqIaZ+z4=
X-Google-Smtp-Source: AGHT+IGC0N+QUzhS8n7k+24uNNnS4l5axT7KsAP0/N+/qLN615Jpr4HEHTXJntA68cgc+Nk3m+K0Gg==
X-Received: by 2002:a9d:6c97:0:b0:6bc:fb5f:7b06 with SMTP id
 c23-20020a9d6c97000000b006bcfb5f7b06mr5339106otr.17.1692539605853; 
 Sun, 20 Aug 2023 06:53:25 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 c190-20020a6335c7000000b005697e8cc5f3sm2609577pga.22.2023.08.20.06.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 06:53:25 -0700 (PDT)
Message-ID: <2e7d8be5-1802-6701-09d1-4eb45bc54725@linaro.org>
Date: Sun, 20 Aug 2023 06:53:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] bsd-user: Add missing break after do_bsd_preadv
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
References: <20230820045419.89691-1-imp@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230820045419.89691-1-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 8/19/23 21:54, Warner Losh wrote:
> Without it, we'd call preadv, then write with weird parameters, which is
> clearly not ideal...
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/freebsd/os-syscall.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

