Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AD973473A
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 19:32:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAwFd-0004DA-BP; Sun, 18 Jun 2023 13:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qAwFb-00047X-LY
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 13:31:43 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qAwFa-0007sn-1q
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 13:31:43 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30e3caa6aa7so2519559f8f.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687109500; x=1689701500;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u485/JfSnTPD54vkc1Evb28cQ71rmunaWzYsknPHm2k=;
 b=a+qlniEKtXDxuBvzH+cz+moIHPl+9EoJu8ec9i0XkOVaxgVSpYEtBlIDSgbDp2GZpd
 O05PjC3t9swzxG+aW24+zOh/8CYIbcSinStuNhDSSsBAjvvGrf64yAkyI0p7Ke0pTemI
 9QZ2gYVPwHMSk4lzY8IVdFIUmGWzOfMj+i/sKosvewROhoHSEmHaKtjj8HmQu2EVRv/x
 gumaJTbyXptpqgmgjah+HkZqRl41UGlndQF6CdQEQ0tPqDG96mcBcnjy6v5pjiZnvhg6
 Hs9K+DhUbSIgsAr/U4jXrWne9EYZYQ0GWGpjFJgsE1h/ykJTJzR2luYLeMsSvOkTi/CQ
 KMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687109500; x=1689701500;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u485/JfSnTPD54vkc1Evb28cQ71rmunaWzYsknPHm2k=;
 b=UxIjuxxTn9HKfquXTOsMSFs0wXqKPSXtBaqUIsE0aPYE91ZAMngkc/xs16f9fvLaQ/
 gdHxEh6lyoBZ7jn0jDR1b4MVRuKIjWmyxGbUPcsiWA0eNieGDfaPGCzE4EQMYADXJWZJ
 Pif4MJG3XXX7eANnMk87q6GXYoIFCMX6BX78HTQGBtn6UOTU5B5OvjdKNn18rpD5m6gB
 70jdzeJt/ObM7wGayfjla+7ko9i00PeiKVUMZp++6b+dLsMfIoUk7eU8kVdXNOgUjIe+
 zjN9nQR3o+hfCKORb51eou370YAYCxei0NqPyzsBZiFSVh0c6g2lTSKIamDsYAMZQJZL
 y/uQ==
X-Gm-Message-State: AC+VfDz2du1zJKuMonCuMNaZ1v9ly1Q5eQstRcDqqtVz+eyzniIF2B1b
 ZjANF/Fv1OprEb3oiCEvuSjXHg==
X-Google-Smtp-Source: ACHHUZ5+5JVU9cuwFhtAMPCavzaM4jiqRqNAVX7wwjeSRJs0SFHjpl+H4mTAzDyA6hrJxjZvs69mqg==
X-Received: by 2002:adf:cf05:0:b0:310:fe5e:894a with SMTP id
 o5-20020adfcf05000000b00310fe5e894amr6199562wrj.6.1687109500233; 
 Sun, 18 Jun 2023 10:31:40 -0700 (PDT)
Received: from [192.168.69.129] (mon75-h03-176-184-51-101.dsl.sta.abo.bbox.fr.
 [176.184.51.101]) by smtp.gmail.com with ESMTPSA id
 i17-20020a5d6311000000b0030fae360f14sm23754471wru.68.2023.06.18.10.31.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jun 2023 10:31:39 -0700 (PDT)
Message-ID: <db46abbc-cb4d-2727-299a-b7eb634c2b41@linaro.org>
Date: Sun, 18 Jun 2023 19:31:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/8] target/tricore: Introduce DISAS_TARGET_EXIT
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230616152808.1499082-1-kbastian@mail.uni-paderborn.de>
 <20230616152808.1499082-3-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230616152808.1499082-3-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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

On 6/16/23 17:28, Bastian Koppelmann wrote:
> this replaces all calls to tcg_gen_exit_tb() and moves them to
> tricore_tb_stop().
> 
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c | 25 ++++++++++++-------------
>   1 file changed, 12 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

