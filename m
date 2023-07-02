Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED93D744C5F
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 07:56:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFq3f-0004Cg-V1; Sun, 02 Jul 2023 01:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFq3U-0004CM-6v
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 01:55:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFq3S-0001G6-00
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 01:55:27 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so3882929f8f.1
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 22:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688277324; x=1690869324;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J+xmhGnb1o/tRClTmSm3boivYSiY/dpJmVHGsQFvvaM=;
 b=QIn0H1WFejA1rEXVEbGy9fv4RkXrNZgEt8xVICTOLrFMlU1k2RZQ3GCDW0iTeqS7F5
 YSQy2BQ5nztISmTb3h9KS329d3Tnv6lr/jg0J8dGC07KfhjCTDm7Svkysl+VbtEOjo7d
 nGG0S3Hh5pynkcOoXJ6Ih+/PlwrFWAl561IYjz3MsL8iMI3+AWPPP2HC83MaAlSRkU38
 lFzTMyWHfSAJrfz5fig11vrOpjkNx+crdNAOgqh4Ub+/G6J2D1XCMdJgUhd0H3QZvwob
 z4mm3Y27FU2kuvqGVY7gvO9TG8VwleW8NASKPrfVA8yOOSz3drPSK3BH7o+H5RsHW+RE
 gVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688277324; x=1690869324;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J+xmhGnb1o/tRClTmSm3boivYSiY/dpJmVHGsQFvvaM=;
 b=JPUVpIzxnXnJihFrhfYJKTZBH1g1uUxQMMbNpylHqJ0UPVPLynDUWm4kIdQlFuAs4Y
 euVrH8vsUG71h9HXi1TW0gSd5kDqalx2Ezye9wEXTUEufT+ItjZwezmx5eSjmtod2B9s
 o8mnu8mIDyTb2BKgP6eNsC1Coq3fb8eu/uprDqu7XRyffkVXa/3/vr/buCmXmcOS+5vX
 RCzv65UT4UjZx0o0JHIe1u8F3E44H/tRmOfkD9RwoU8OYAl2WYXwEo4QUApkFt7Ce4C4
 O5KierM+QxmW25Iktc4WG1vG5B7GmOXJiqG/AGmDPNBpRNbsiaMh64st2Bbgjkh2NQvW
 r0Ww==
X-Gm-Message-State: ABy/qLYvdjKv0wD4a0lakDQ0ZZU/1TyNez7Tc8vMFGLtxR3IleFeZlSk
 1dEVislTzFQbRB4i4s8tkPtmng==
X-Google-Smtp-Source: APBJJlFnAEVPHMnqmeDgRnSwubq9QsJQpAYRIfXlde1MA6lzyDCKsm8SyQn4oJo5EBKl+mi5O7lGMA==
X-Received: by 2002:a5d:5272:0:b0:313:ea59:7ded with SMTP id
 l18-20020a5d5272000000b00313ea597dedmr6249254wrc.24.1688277324013; 
 Sat, 01 Jul 2023 22:55:24 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 s15-20020adfeccf000000b003127741d7desm10836522wro.58.2023.07.01.22.55.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 22:55:23 -0700 (PDT)
Message-ID: <6dee242a-dcbf-f693-5732-3241f5218f51@linaro.org>
Date: Sun, 2 Jul 2023 07:55:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 02/46] target/loongarch: meson.build support build LASX
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-3-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/30/23 09:58, Song Gao wrote:
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insn_trans/trans_lasx.c.inc | 6 ++++++
>   target/loongarch/translate.c                 | 1 +
>   2 files changed, 7 insertions(+)
>   create mode 100644 target/loongarch/insn_trans/trans_lasx.c.inc

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

