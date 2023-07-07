Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A31B374AD31
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 10:37:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHgxS-0004os-36; Fri, 07 Jul 2023 04:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHgxM-0004o0-CP
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:36:49 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHgxK-0004ww-VL
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:36:48 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51e362e4c61so1230142a12.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 01:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688719005; x=1691311005;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=haze2Yo/UqqGEJZK8eXeUON10WbrJ97ov7y0KcZu/F0=;
 b=kAP488mViZVBhJWl/9PrVDZQL0MTMQ9RFxS6A7z1oI5o2+U5tIudtyfD8zl/un86AJ
 wZhgL8a573nip1xHtpkTyH/KA2aHznoxwZ6LDdtKFUFxIs1opWd8m74PM6gdjuRPUH9u
 +V+/cX+XMXUpsaBij6gkwAUmmeHMEoWZVyVDvsGGqyYn4QJr5WnDcBQ+5YnENIBGNP+X
 JDVThVoC+Fb/bx4wEZa6qcSmWT2/Oxkf71+MQwbGUylGChjVCIk+/qoxG0hbbvJhToQP
 onOBOUzuKI7vCQnJWX8kyLiRqMjaUHQekphSiEcboPJJWHQy2wZMvlfQU5ggSvxqAmry
 DClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688719005; x=1691311005;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=haze2Yo/UqqGEJZK8eXeUON10WbrJ97ov7y0KcZu/F0=;
 b=YlhrfsbErXDLV2F3w6o8qPI7YW1fpxFf6YM57YnTMophwuVVnNX5gLBjloUWpPA6W2
 v2SeeirdABFOVCarFUXY/haenrNFmjIHtGZW/nYyYDBBtI3JjOQnnEEn7scXXXnVCj5J
 71C4ZhtWTPkzaAjYNG+NifQxYb5/uzFl43k6S34t/ebW3GBEkrKlxR07CqofeVOoAcTW
 kKrfBQcouNifN3MYPiIHh/eRqiAVyJEeDLsNB9Z3KS/6nMgOdI7LhC7ye56f3+TSzoCk
 FiIpimaNvi5JzGBl9/EPfyZQirjj17Fz8cw8kwYD3KA9NtrE1TShUjQg55aEtQ6VS10M
 OKZw==
X-Gm-Message-State: ABy/qLYbKM9d92hzrOrnPFZXvRGrz2CDf3D8cEB37mTOR37ZC5mcFitA
 vGDwoTYbZbysKR6MNCAn7GJ+KQ==
X-Google-Smtp-Source: APBJJlGf6TAFsCcMEQCjIqISCeN3n+ic51AMAOKwuCd6B2a3lcJ3z/B19Rh5kRz+xEV6lSTSPpyJbw==
X-Received: by 2002:aa7:c303:0:b0:514:af52:e49a with SMTP id
 l3-20020aa7c303000000b00514af52e49amr3114771edq.25.1688719005445; 
 Fri, 07 Jul 2023 01:36:45 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a056402068700b0051e24284fc8sm1739803edy.12.2023.07.07.01.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 01:36:45 -0700 (PDT)
Message-ID: <c0e9ea3c-e23a-37f8-0382-06dbde082b99@linaro.org>
Date: Fri, 7 Jul 2023 10:36:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/4] QGA VSS: Print error in err_set
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>
References: <20230707083105.746811-1-kkostiuk@redhat.com>
 <20230707083105.746811-4-kkostiuk@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230707083105.746811-4-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/7/23 10:31, Konstantin Kostiuk wrote:
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>   qga/vss-win32/requester.cpp | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


