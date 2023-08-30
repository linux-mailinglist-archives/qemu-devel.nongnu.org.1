Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F7B78E34D
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 01:35:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbUiG-0005G2-18; Wed, 30 Aug 2023 19:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUiE-0005Ft-81
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:35:02 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUiC-0001ZV-1p
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:35:01 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68bed286169so177642b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 16:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693438498; x=1694043298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2hhiQrW4rVAiCViwZmJGV6lA9+3KuNlIa0rUTKm1r+o=;
 b=lfRU6gnM2lWB4tTb8QkpTRC3Ws/IOT2+W8exZEWq0e3RbXO60LtqcqVt9YaaHGe+K1
 UGkt3OhLAp6gcRrqbFB7QdV3N9LcXl6304QkjUdq6TAnPwaHgjni4O+hx/sr9Yif96ej
 WsTUipmnixUaOi2tTJ1QNBu2V5Qb0UrTQWfmdM0bPPKWecHGBB0D0O2ISCfTKA48LMnQ
 iiYZT2PIQwVIHsQEM4tP0osazenVxvyha28flaaoMNtWfqVNpR1SwUc3Z04aVzwJCtTu
 7TMr/PRGdp+de4gBfKYYG83pAK442zIC4KV//10xy3Jbgunw16BaYkWcQxHeP4jmvcmo
 bRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693438498; x=1694043298;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2hhiQrW4rVAiCViwZmJGV6lA9+3KuNlIa0rUTKm1r+o=;
 b=l1PTzel0nittIzaw0OM04EK44S32PG1ycb+s1i02WW75UBJrwF8RzAcjxPmqcE26NJ
 Cf1/92VS0Hqzrrs6MIki5NnQxGJ0VCENch97X1x3+3LdwpSY2Gu/X0IzoS4SSDdNDO9q
 Xs2aC2nrh17pYq/a80KDRwrosshJ/OuPILREjsUHbvRruo9N6azbTLSuYpnpXhoqidmS
 O1veWnz1I5e3wRTjjDco9zoWtQQWsXkinWm+Of8vhrHciI3VmFDnN8KvuAK7dmJkMCjq
 ZWQqB/S3OoTD7AGGT/r5yWwYysAXM3VoOE1LFCL11oXHdaDBa0MMNQFqkm7J056jF46M
 Vs6A==
X-Gm-Message-State: AOJu0YzBavnC85jYOsKNgXg+qDHDHeMsJjEsukTln7yYSjgknXVoA4yG
 7RGuFVvJhUZs3QkrvqMuBnTYPg==
X-Google-Smtp-Source: AGHT+IFsiaMF2vW+UCeswrUJ+XpSsAs98VXrkmVZMzb1/fpWuhSHyw8R2+dPVAxio3cYCedT7ufQBA==
X-Received: by 2002:a05:6a00:1a90:b0:68a:6e81:60a2 with SMTP id
 e16-20020a056a001a9000b0068a6e8160a2mr3996221pfv.26.1693438498512; 
 Wed, 30 Aug 2023 16:34:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 j15-20020aa78d0f000000b00686ec858fb0sm114441pfe.190.2023.08.30.16.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 16:34:58 -0700 (PDT)
Message-ID: <cb1d4b68-5c54-4a4f-8783-f62fc1a25cbe@linaro.org>
Date: Wed, 30 Aug 2023 16:34:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 37/48] target/loongarch: Implement xvfrstp
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-38-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-38-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> This patch includes:
> - XVFRSTP[I].{B/H}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode                |  5 ++
>   target/loongarch/disas.c                     |  5 ++
>   target/loongarch/vec_helper.c                | 48 ++++++++++++--------
>   target/loongarch/insn_trans/trans_lasx.c.inc |  5 ++
>   4 files changed, 43 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

