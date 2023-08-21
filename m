Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F31967824A5
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:40:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzUt-0002dC-6z; Mon, 21 Aug 2023 03:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXzUR-00022L-L1
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:38:20 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXzUF-0006Up-Hq
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:38:10 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-319559fd67dso2813148f8f.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692603485; x=1693208285;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r45e+D9cr99FqzP0XNLuaNvvcQCjzXJ0CGgBW0Viugg=;
 b=e4z1FJNho5C4wPoDiVNkS5+jblfOJuyzKHgez6W6tSvVDdOQL6WrTobb5bmMt8D+8Y
 WwLfYzW6qQObe8MCXK7e858+AG28XaCW6vMstV3lSq1estz3geGlBfl8gHQQgmiAhFrw
 7rTPD2dlN0+R7IeZrHkpv8LNF52pSvR56Ww4lmreCkKBduimdgS9GtTek7oa6Zuk7gIx
 0gwmBnOLwjVT6hVJgLYfRhUM0uhCamaRrUnT6DxbK44JBBXLsQUUqZKXb/7aiA4c7L9g
 gDa1L3lqRMOpYvfafwo6qgxpTksDyblphIh2LgQw8PIGJi4r8pqz/CBwcCHDePfJ6md+
 tfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692603485; x=1693208285;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r45e+D9cr99FqzP0XNLuaNvvcQCjzXJ0CGgBW0Viugg=;
 b=BqWZIi/lUYsmZTW84KOAHvqdsf0fyW06x3i2LlWBJYghiIqQH91nrErNfqFS18Jaio
 1SrMQl/ox4XFbhQhWOXeeR8Yx1MlSAME2SJuu5U2WSw50kuThaN6odF29UhItNaDIjNB
 OGL50jYo/3HMOFETHTNZE0nyZD+y2xe8qQe3nIYlIZKhwysljXaEmXC2gViSmauQKNDy
 M1ZOsK2ZS+4MYieUv8IylUUpuVOfW2loOVH8SrIh6j5jQ5cQhHpypiINZEM8VvX/+TLG
 RWNCP1uug3/V0bMozq+WITT+HkW6xY9MZIAfyYuqJJqM2zhzeBH6ZzTsaBz6K3CD5r+a
 JYmw==
X-Gm-Message-State: AOJu0YyJqry5aZrygv4x6jPmMw3NMRjqvcp9Zns8wQVm01Ru7iTm7zXe
 AvYGA0P+I7P0AGDOMtvIYbm2RZcA9qtUobqLwzg=
X-Google-Smtp-Source: AGHT+IGrBlktaJsNq9FEABbW53bM7nBwaYLiYJV+SfU3+Ncpp6UilLwmfPEhscA6walw232J5O/iog==
X-Received: by 2002:a5d:4d8d:0:b0:31a:ea86:cbb8 with SMTP id
 b13-20020a5d4d8d000000b0031aea86cbb8mr5034865wru.2.1692603485595; 
 Mon, 21 Aug 2023 00:38:05 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 i4-20020a5d6304000000b0031431fb40fasm11492604wru.89.2023.08.21.00.38.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:38:05 -0700 (PDT)
Message-ID: <eee064fc-1c50-40d6-6bce-1613aaccd416@linaro.org>
Date: Mon, 21 Aug 2023 09:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] bsd-user: Add missing break after do_bsd_preadv
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
References: <20230820045419.89691-1-imp@bsdimp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230820045419.89691-1-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 20/8/23 06:54, Warner Losh wrote:
> Without it, we'd call preadv, then write with weird parameters, which is
> clearly not ideal...
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/freebsd/os-syscall.c | 1 +
>   1 file changed, 1 insertion(+)

Ouch.

Fixes: 770d8abae7 ("bsd-user/bsd-file.h: Meat of the write system calls")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



