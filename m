Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF3970E4AD
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WlF-0000fg-68; Tue, 23 May 2023 14:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WlC-0000fI-AG
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:29:26 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Wl6-0004U0-ID
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:29:25 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d3fbb8c1cso87131b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684866558; x=1687458558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ph8wDPNyIGsnKmbMytjzS39w2JcUalNBiOXt0U/rTdo=;
 b=MVzFeaVdPK+ZITRGmifbIC1yWl/4lU4vNa3psqpI4sO0DMW6ww8GTXMA2U3nrL0LUY
 bg7i77QA69pwl76fKN8Bmk0/ZNtzxz2GOxiqjxnS5bEghIEJN0lOIeIY9/AAieK7OZMi
 MQSkvqQFOpYwOZXE4VbKqsD/hPC2DY+2mvyRgOtttP5HlS39bL4Lpfbc0DNBrSbJSo5J
 2tSWv114Y4XJVPRrpaiS/RKl03SQV64VXsmxmcfDh8KeafABU09KoVr0yK9mbpJqyHa4
 S++IbGMP3rG7QOtFo+2OnTyKgLiQuUcspGWrHFTGhzZhGEjVyAB5L0KUQk8aIKml0Gz4
 JJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684866558; x=1687458558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ph8wDPNyIGsnKmbMytjzS39w2JcUalNBiOXt0U/rTdo=;
 b=VUWP5aZHdGJwKO5rzIhlO7Mjx02O0TMXhOsl8nVUEdVJh0pC7axokznVZ7A83UyCsH
 C92Bx6JnWIo9CE1cpsRBeO4/psZIEtHliZ8lBb2qgkkfsMgzt1O2QHojpiy6jc9wDiS/
 MwgJw2FtNHDIg8gL5neESRfHWaR89cINZtmPgUZWhpO+3YTgVriz6w4U8VmslHs75e2U
 fOo824ypURwKJs3pd6FYe2jJdfal7Oe36m1/SnKQQu780DnCYLIfzYfXfBG+4Zl1UHiC
 ASckA90YmAEMVCVmJj3pfv3HRsh6N2Xw+IVeWKrL+6M7ONYtoUsk8tNzrCEhlsWS0SyU
 3NmQ==
X-Gm-Message-State: AC+VfDyC3gFNnn9f+wREt4b4rkJb9OkCPTlT7KpMPf1pwC2wCkixIa+g
 EVrlLvD5oKcYgqzTNzDL0Q8XDw==
X-Google-Smtp-Source: ACHHUZ5f4xHfCExY78msVNyxNlXr2+Si3zcJUZrDSGai+d9BBLykM9Yth6VRtfQAyqFizvY2npsqeQ==
X-Received: by 2002:a05:6a00:2282:b0:63f:18ae:1d5f with SMTP id
 f2-20020a056a00228200b0063f18ae1d5fmr21700947pfe.29.1684866558289; 
 Tue, 23 May 2023 11:29:18 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j24-20020aa783d8000000b0063f0c9eadc7sm4057473pfn.200.2023.05.23.11.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 11:29:17 -0700 (PDT)
Message-ID: <23722375-ddb4-a91c-2048-f78439f5ae33@linaro.org>
Date: Tue, 23 May 2023 11:29:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] hw/ppc/e500plat: Fix modifying QOM class internal
 state from instance
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Titus Rwantare <titusr@google.com>, Stuart Yoder
 <stuart.yoder@freescale.com>, Alexander Graf <agraf@csgraf.de>
References: <20230523064408.57941-1-philmd@linaro.org>
 <20230523064408.57941-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523064408.57941-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/22/23 23:44, Philippe Mathieu-Daudé wrote:
> QOM object instance should not modify its class state (because
> all other objects instanciated from this class get affected).
> 
> Instead of modifying the PPCE500MachineClass 'mpic_version' field
> in the instance machine_init() handler, set it in the machine
> class init handler (e500plat_machine_class_init).
> 
> Inspired-by: Bernhard Beschow<shentey@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/ppc/e500plat.c | 25 +++++++++++--------------
>   1 file changed, 11 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

