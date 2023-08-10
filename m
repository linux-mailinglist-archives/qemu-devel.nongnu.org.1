Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E29EA77745B
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 11:22:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU1s8-0007kP-0X; Thu, 10 Aug 2023 05:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU1s6-0007kF-0i
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:22:22 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU1s4-0001YN-HT
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:22:21 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fe45481edfso6435045e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691659339; x=1692264139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OoHPzX4vN+XzzZJgwo1k/onNfJk/03myYTswo6U5Q14=;
 b=f9N7h3vW1AcGDJA0mqajbSmLi13aNJDWkJTovufp9lL+jkUmJmQNd++3z6jo/xa6HQ
 0X0lco7BmAV1SliNehZtHw2/ot5+PLPUiqYuwJnCR5G5K6aZG99EFY+ecqncsxGEeqqQ
 U+yCp6Gl3QiUkjkscoZnYzOvzQC1ZqmEQ+W3dJB0lXCjMHmLUwQZ9BSuDCjseOwG5VBh
 p1NGyVL1zzF+ocxOFlI0QKHsFU6bceNtbFyxNvcweOy6OKdbL+IKwjRzr9bAMoEWjq/y
 ztv1RcXaC7jgH6QP9c6JzcspMBj2qOBhqOeXjiEYFK8WqEDdUyvPVCqt7Hw64t9x1yID
 YVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691659339; x=1692264139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OoHPzX4vN+XzzZJgwo1k/onNfJk/03myYTswo6U5Q14=;
 b=DcZnmUefMW+i5jSTw6vfFBBWBNarE0o8+VFV+ovCjB1EVbJQxpyr6Vr2Lg5ycAdPBX
 g/z4RB4Z+7phapxXeUmciKkdf7sHFNblmI3v0THHDxOI3J2JTYxOsQtpYCohoOWQs1zq
 Bg/lO/uxpd3VuMcY4XJvTwmRSoWpKhfA/EZBAdzVowElxJyjVpj+HXwb/41P8hqE901F
 O/lDu8ZU7KDclSdXh6brTTkeqL382XAAnUdsd+3u51SJHAQ1OF8M4zqPr7hGmBs125ZW
 xjOZzV8M7n+RXJKAsBeQMeU0A6q+Ivo9ES+6VMx4VKuddYGQm9oziSXZTbteFunhwuTI
 q+kg==
X-Gm-Message-State: AOJu0YzaKlGxd8EwqBEddjQ8pZWW1b0QaJFzbI+tXH4Y1Cbw/MtGL8Ng
 /ilG9xohP2ue6wEu00hxWQTP5w==
X-Google-Smtp-Source: AGHT+IHrjSlSFHTxs+X7BkxbVGQLCo6YIq/YBQjTa4QskhIp7aMn+ruLunu7PMuUZ7EYnah/WKjrJQ==
X-Received: by 2002:a7b:c3d6:0:b0:3fe:374f:f7fd with SMTP id
 t22-20020a7bc3d6000000b003fe374ff7fdmr1350027wmj.33.1691659338769; 
 Thu, 10 Aug 2023 02:22:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a7bce85000000b003fe17e04269sm1503684wmj.40.2023.08.10.02.22.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 02:22:18 -0700 (PDT)
Message-ID: <188ddaf5-d43f-26d1-97bf-d27f3e6c0829@linaro.org>
Date: Thu, 10 Aug 2023 11:22:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2] configure: fix container_hosts misspellings and
 duplications
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20230807092222.467446-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230807092222.467446-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 7/8/23 11:22, Paolo Bonzini wrote:
> container_hosts is matched against $cpu, so it must contain QEMU
> canonical architecture names, not Debian architecture names.
> Also do not set $container_hosts inside the loop, since it is
> already set before.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


