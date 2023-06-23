Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A6173BB67
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 17:19:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCiYu-0008Sy-T0; Fri, 23 Jun 2023 11:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCiYs-0008RP-JY
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:18:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCiYq-0004ov-QK
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:18:58 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-307d20548adso772386f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687533527; x=1690125527;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=njCrCzkwdxHHewhkNmAyfjrE2jaXcq1sg/qlGFRUahw=;
 b=BZ+cpK2biHykh+zB7N025zo4VSlle5Xjz/P3GEaEI9vut1elSAztpGtBm5jXWWljTs
 mxsmW4Ne6Og1k7jprK+UL17TpiiwGCugrjx87wrhUtqy4uS6/o1pW/+WRTnreUu4Emfp
 cpXYi4zUErVTvpGPc4cA11YDD8+ntXvE7BmGCfj4g0MESgANT1oo5wcFAotOh3B8qesG
 irfnCGBmvv/X8hc+QCLb9ZSQlG6y60hVOlXgm26Cqi8Va1utPkyjMfQ12UJwraFo3qUO
 uS+B3w1szz1wzPdp3cENczGC8ryX148vgnT5N15y8loOw0knAIC2a57TEgVANvk4EE3o
 jDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687533527; x=1690125527;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=njCrCzkwdxHHewhkNmAyfjrE2jaXcq1sg/qlGFRUahw=;
 b=iTP6h90yuFBeHSF0hgWZOyZgp/5RIi0xLJK2kgc5QYlLwnydKJeVUnqJsO5Ct3Kutx
 1C6cNd916ndYQH0DrzK8XC/fcxGR+AJScoXZmC7YAIGDD0QgTQ20Kgbt85RFQb+fxBfN
 yQoNdvpsBniPhcavO6QIHNynMUWFE8Z63/xmu46KxTZyHeS/bxXhJiCEf1aVz97XfwjI
 UoG5ziExoeGU/dC2t7lIVnsy4U81REGu5rOE28v+nttoRncWUyrrhRSiiuTDJ/nL4o23
 9N/jOWKBlubX5Z90nQzxh6kystjOs0M/ZvBAnoLAd5O02IJP+jvJPef5An1t9P3QDsxN
 npGg==
X-Gm-Message-State: AC+VfDwp8oKMXbNm20nXKVuIT/8l6/PrsOsmsdABjfdp+0yVAVxzTkNx
 KENqJWYm1mKQRzBYklsuhmkzkw==
X-Google-Smtp-Source: ACHHUZ4uEh4Fy03mzccOzvgYb4yePyr4yDj9tqkUTQzBncXEejaNS5BOT7zbgbQVNuZ23k13wRAKnQ==
X-Received: by 2002:a5d:6ad1:0:b0:2f4:4e1a:bea2 with SMTP id
 u17-20020a5d6ad1000000b002f44e1abea2mr15028387wrw.59.1687533527682; 
 Fri, 23 Jun 2023 08:18:47 -0700 (PDT)
Received: from [192.168.93.175] (94.red-88-29-173.dynamicip.rima-tde.net.
 [88.29.173.94]) by smtp.gmail.com with ESMTPSA id
 n11-20020a5d4c4b000000b003113ccbf388sm9896662wrt.13.2023.06.23.08.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 08:18:47 -0700 (PDT)
Message-ID: <b2b23b53-b774-4bf4-e103-4afc1b8dd909@linaro.org>
Date: Fri, 23 Jun 2023 17:18:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] linux-user: Remove pointless NULL check in clock_adjtime
 handling
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20230623144410.1837261-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230623144410.1837261-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 23/6/23 16:44, Peter Maydell wrote:
> In the code for TARGET_NR_clock_adjtime, we set the pointer phtx to
> the address of the local variable htx.  This means it can never be
> NULL, but later in the code we check it for NULL anyway.  Coverity
> complains about this (CID 1507683) because the NULL check comes after
> a call to clock_adjtime() that assumes it is non-NULL.
> 
> Since phtx is always &htx, and is used only in three places, it's not
> really necessary.  Remove it, bringing the code structure in to line
> with that for TARGET_NR_clock_adjtime64, which already uses a simple
> '&htx' when it wants a pointer to 'htx'.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/syscall.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


