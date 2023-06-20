Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 316AF736BA6
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:11:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaCO-00072i-5N; Tue, 20 Jun 2023 08:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaCL-00072P-Eb
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:11:01 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaCJ-0002MM-PJ
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:11:01 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-988aefaa44eso316669566b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687263057; x=1689855057;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0XBjVlzdu44bpsTFRFCHJYPtSoJe7rD1scO2Qs+zChs=;
 b=OsMXHScPVgZhNTc0M2olpXX86uJ5V83ukVtpjrmpF+nW+wEXfD9WrJ3lGKl5UKFBiH
 0brLkSkmZawaKMJ1wDC3oshaSFsfPMMXkq1tQqIFFU4qT2F5X7/hxWfCzBLGGvsA9lSo
 YwauXe/8zAQ9cikQlTwDEO8NWgAaXDCMDw0cQwvrTOL9fX4/mr5lwakBBLpWEEoRsAGt
 a8fmD3RfvmrP/OGQM5TX1qHxPvR9q5IgM9ADZ8hJkq5HhI/Gf9/xpbmTMLlCm9ToZiAv
 25OqlWVOJXCal7/4DIbB1RlnPpciVvpCUYRwQp0fD7CViBX0b46mZhuGOdPJRigao1GO
 nVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687263057; x=1689855057;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0XBjVlzdu44bpsTFRFCHJYPtSoJe7rD1scO2Qs+zChs=;
 b=YPaN75Qxe9Z3tFQrvYimmKDQ7pWXh+eXrb/281yJ+4YW3dRBQKHCKrn5CgBK4xosHa
 mDbKga431fAvsQwCyDJEy5f9sjSc20fe4tHnWpEvnaR7/0vhg7HBkKm9yOmHw7aqeWna
 eLyoyHuAhfktX88vCkiR8FpcIVE7qsj/QgNfwRoFUdTji+mlSDaxXphYYW+CGwqv2WnK
 JRRGNiXJU5TQpZd6+B8h6hCFNpOu4Or9C8WSSuC6gTYxBlAq9FZMbdToRoL9te8tO9ZE
 crnO8PGUjKZaBN8txr93TESJefritnGcu0/W8ZPXRvgTNP0yZaPIQgVIog0V2WD9vvAC
 KOKw==
X-Gm-Message-State: AC+VfDxQroX/W3Iamjp3hl+Ia+/jGs0qfRcDdvje43MPOUbYf7Wh81r+
 lRp+z6uDHxBz9j8Q6k4SZvkDEg==
X-Google-Smtp-Source: ACHHUZ6Xe4DOJk+4NFXvQegVJ4xc5nLC2Va6jx42yWBaAkOzvPpw2nEIdaIkwCHDcCEJ0dVzmof+kg==
X-Received: by 2002:a17:907:7d86:b0:96a:928c:d391 with SMTP id
 oz6-20020a1709077d8600b0096a928cd391mr12192235ejc.4.1687263057070; 
 Tue, 20 Jun 2023 05:10:57 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 lf4-20020a170906ae4400b0098822e05eddsm1286769ejb.100.2023.06.20.05.10.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 05:10:56 -0700 (PDT)
Message-ID: <36ef5d68-0bfe-16b6-3ae6-5a5817f16211@linaro.org>
Date: Tue, 20 Jun 2023 14:10:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 03/46] target/loongarch: Add CHECK_ASXE maccro for
 check LASX enable
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230620093814.123650-1-gaosong@loongson.cn>
 <20230620093814.123650-4-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620093814.123650-4-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x630.google.com
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

On 6/20/23 11:37, Song Gao wrote:
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c                       |  2 ++
>   target/loongarch/cpu.h                       |  2 ++
>   target/loongarch/insn_trans/trans_lasx.c.inc | 10 ++++++++++
>   3 files changed, 14 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

