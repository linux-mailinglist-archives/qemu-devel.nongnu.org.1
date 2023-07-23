Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5795675E3DD
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 18:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNc1h-0005GD-Bu; Sun, 23 Jul 2023 12:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNc1d-0005FL-7w
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:33:41 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNc1b-0003cw-Pa
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:33:41 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9928abc11deso612549966b.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690130018; x=1690734818;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I0unnyybHXEy14SuAlsO+MrsQDhfoSZRJyBZ1uQzdpc=;
 b=AmD3Ql2jNVteZYe52VqVCJgKYZk18OvrMR9PcArdS2OPeDqfgJUgAuX/mbtky1Fgax
 M43PlyrCch0PYchFxU+Ily+28lb4SVXkY7X0yCy4D+/VPFzvbii6XxxDCOp8F2ChF8LE
 1NTJ+KAROPRrYeu8zPHqczbmcr3vJ2ulO9baVLP57jd8aWBXNTfWKSckoe/IC7mkgJrB
 7YJ/AG6PZXb2rHd3Ut45Dst9aPNiPq3D6EQ99PvhUAtUqBah6IDCAFtNcDLqwUxsnPpH
 NkcdxsTFx4dVQy60QaVoBl/qWKSjdCkvgYn5q6Etk7B6t93Q/Qigh81Yutg6z/LyT52p
 KR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690130018; x=1690734818;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I0unnyybHXEy14SuAlsO+MrsQDhfoSZRJyBZ1uQzdpc=;
 b=AYP0IJ4f9kpJZTM6FiQbMWGZXboM/YoUzff0ffhSV+dh4TD1qFWlUt/UmNri3RTJU9
 bAmpw2MtR697enCa6t6at4uNN/Ts0mwn7ml3v6DXeAOVG4XOYDTKP1O9hJF/jQUEhe+c
 m86+5wOfVlTBQDrXMUvEIEnVror8cRl+tU+zjrFZ16ThljAhNG4T2XXZiRVCpzif4RC7
 J3h/E0p9+/9Q/Zr+9rstRDnoqfvzp0KYcTImosXmkY2IcCy5NmnGRgDfwgH0XwNK5eTj
 wKYrrduyVLWLOaDyaPF7PzFm2N2deBFGcAhGZ4IXwQpIrzjT5/5oGHbHAwL2JFbeKA4e
 01qA==
X-Gm-Message-State: ABy/qLYXwoO2PZ1MOn4dLrRfK3TmukbGCiLJ5NwT8R0pSfkeFWchRChl
 HFjDTbrmm0UWOhTJR2sS0AQfWQ==
X-Google-Smtp-Source: APBJJlFvDJtoHjB5d7xd329isgUYSWSMOJFZNpZco3AfpvG8SX7IPAiQwCu8sdWGUupHgxZJv5kWGA==
X-Received: by 2002:a17:906:31d2:b0:994:3037:c1f with SMTP id
 f18-20020a17090631d200b0099430370c1fmr8017507ejf.24.1690130017828; 
 Sun, 23 Jul 2023 09:33:37 -0700 (PDT)
Received: from [172.20.2.0] (179.181-106-213.static.virginmediabusiness.co.uk.
 [213.106.181.179]) by smtp.gmail.com with ESMTPSA id
 c1-20020adfe701000000b00311299df211sm10140500wrm.77.2023.07.23.09.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 09:33:37 -0700 (PDT)
Message-ID: <15c706b2-96bc-8e94-4a2b-2f449d81a725@linaro.org>
Date: Sun, 23 Jul 2023 17:33:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 05/14] target/s390x: Make MC raise specification
 exception when class >= 16
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230719221310.1968845-1-iii@linux.ibm.com>
 <20230719221310.1968845-6-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230719221310.1968845-6-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/19/23 23:11, Ilya Leoshkevich wrote:
> MC requires bit positions 8-11 (upper 4 bits of class) to be zeros,
> otherwise it must raise a specification exception.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 20d143e2cab8 ("s390x/tcg: Implement MONITOR CALL")
> Reviewed-by: David Hildenbrand<david@redhat.com>
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   target/s390x/tcg/excp_helper.c | 2 +-
>   target/s390x/tcg/translate.c   | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

