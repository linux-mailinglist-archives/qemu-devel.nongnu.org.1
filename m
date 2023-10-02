Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB86E7B4BA6
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 08:48:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnCiv-0004M8-5h; Mon, 02 Oct 2023 02:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCis-0004Ls-Va
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:48:07 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCir-0002se-Co
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:48:06 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-405361bba99so159587545e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696229284; x=1696834084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lDJ3scug1GaAjDYMk8E5K7n4piDZ9aKayediD3OjqJk=;
 b=PuC2POOTjmOtlsINNhdrPc+Vo0l9BK+SMF/KWbmoAK313Hstple74/QLYzEPO4QprS
 fle6/V4YuxiaGIfFfs7VlnXbNwXJ1Pp7w3MIWfs3+uXw0+TmODJLtHlNDWYY0qnKJ7Bw
 nbQFeQG58LElGoyoioPLVaUCRS0mZ3XXVBsULitL2uckg9Fri8JCkhFfDbzS0kvVYY2K
 k4cP7wx9Ncfw/NLNPkO4F8d3jkVBN0nFu7E9SJkS4Q4LRtDByDfOaqLHBFBG8KrIdmTZ
 R7ddYvjjoQEohwr03d98i18ZaU1F/SLNhikM49VZ1MwZfxF38ME19XhfvOTrxV0z15UV
 SLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696229284; x=1696834084;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lDJ3scug1GaAjDYMk8E5K7n4piDZ9aKayediD3OjqJk=;
 b=qA5ci/YNDGGm8MBRBNkFb7k0ZPb3dnsPI5zPOpW05ZQdogUz/RFQxw84puGeF39D7F
 1UESTfUUY+BDVtq+f7bBICRBT1L7KaxjVzwkaNth4LWggi3T7jLI6zHP7uEMmmPzpWYX
 YLCjyjz3fluPQdvbZso0yVIkKjkgszUf6HpOWHZv3I04ei5dWDr53WI2G3Zi3Bq91wA+
 u09/l34FT6ZVeYQVQV60oY423cUqxybeDyTKPFxQ8AJNvUl8K2ODR7Us6Iu52K6h3gG1
 G8VI3qgBei/cSO8S9KkpO8mbawAZ7yuIno9fi1V09XKbLaLdcNj177e6z4BU2eaHgrvU
 JiZw==
X-Gm-Message-State: AOJu0YxNSkyFEUfiuTGMCWNQCysyZT5L3l21DVpNXYnCqJSDECNSHr2N
 RmIrgFJ7Y5wMcIWO6k7t1GKs7AWImkAecwy6nfw=
X-Google-Smtp-Source: AGHT+IGWXXYUEVThAJiTMQ7h5DU0NsQZzG3Kc9uHyCjPMDsPv59qDgNCyQIajjj/pf8PrHVHqYav9g==
X-Received: by 2002:a7b:ce09:0:b0:3fe:d630:f568 with SMTP id
 m9-20020a7bce09000000b003fed630f568mr9030934wmc.39.1696229283897; 
 Sun, 01 Oct 2023 23:48:03 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 r1-20020a05600c298100b0040586360a36sm6554080wmd.17.2023.10.01.23.48.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Oct 2023 23:48:03 -0700 (PDT)
Message-ID: <41af7952-1020-39a8-b055-d0262e637627@linaro.org>
Date: Mon, 2 Oct 2023 08:48:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] mailmap: Fix Andrey Drobyshev author email
Content-Language: en-US
To: andrey.drobyshev@virtuozzo.com, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com
References: <20230926102801.512107-1-andrey.drobyshev@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230926102801.512107-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.058,
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

On 26/9/23 12:28, andrey.drobyshev@virtuozzo.com wrote:
> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> This fixes authorship of commits 2848289168, 52b10c9c0c as the mailing
> list rewrote the "From:" field in the corresponding patches.  See commit
> 3bd2608db7 ("maint: Add .mailmap entries for patches claiming list
> authorship") for explanation.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   .mailmap | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



