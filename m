Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FE777E1CA
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 14:42:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWFq0-0002v5-Od; Wed, 16 Aug 2023 08:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWFpk-0002Uv-Fg
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 08:41:09 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWFpf-0002Ng-MG
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 08:41:08 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99c0cb7285fso804379066b.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 05:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692189660; x=1692794460;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9kvBi5fEowBW2HuI8nVdpqcb808Pu4Oq74FuMs/OXCQ=;
 b=wT+aUo3uKV3xUq9VHKGNTaXL+PtgBDvy1D1XBgW73XMjEw1MHCg+Svl18H4HyiMLvR
 6iDVoTBs51D47f1WdA9uac2pEIajBriBW7D9WeMIIpKhhMvkfM8nVV1KGzKd+KUrQQkF
 75gSF16xTMTQxLPqbrZj14e8VJXmyO8UW8wlhKa4kvat5C6DKnQejU++Hym6PSzmw2+T
 +uR9Gtc7FPlP7sKvltO61QgPll12jEtXUDkCwKhU2Hv3vLHuv1L90KxBQNSwLqnJSWgI
 BwDMFCSdxs01TTdg/+s0gjz/12/dJvVNb9NFIZyI58XA2LN10cg7OaX5fJJTSdCRQQA/
 PZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692189660; x=1692794460;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9kvBi5fEowBW2HuI8nVdpqcb808Pu4Oq74FuMs/OXCQ=;
 b=ONTeQCMeUDPvG7UGVcmOKg27AKoPUYzG+S4mnQf+3f7pKRWF9Lc0GW+7ZfZSUe/jue
 YyRglEnWiTs6PCpQAr1X2Ot0f35b7fsbD+ImD0EzhvNX5c0v+aPOD5YA2wBZkT+Ab9y/
 SNBuGZzp/uKRR/BJcGDT26KaEvSorUzY2Drx6KuZI6Fci73XxFbTKaJiZkIwCbJ1tcIv
 jaj2MteUGeNHA7w6Q5aYd3DNsVJoF2xf7TgCGa2cTU7gwzvCbKz10BY/jfs1jhxa1LVz
 kSlUxN6UyNqNRnulFwiyOcQ8AcVVN89kPnjuUnwy2Ecc/pMHQZ0rhEKtPIF/FjxGjdtW
 BSdA==
X-Gm-Message-State: AOJu0YxWfmnTvFBwbBaKqzEgO+OJu7gHSAE4f4WiYyBZpb9YKK4zShDF
 UrmfPYZwaLj4rvQ1Da9OAwIc4g==
X-Google-Smtp-Source: AGHT+IF+q5ksjLYe3HwZFjs5c///uexOhrNVNWZL0+DFCchXpnitME//rOV76fnJJDDloZ5INzO9vQ==
X-Received: by 2002:a17:906:20d7:b0:99c:613c:9027 with SMTP id
 c23-20020a17090620d700b0099c613c9027mr1484668ejc.21.1692189660038; 
 Wed, 16 Aug 2023 05:41:00 -0700 (PDT)
Received: from [192.168.1.102] (mna75-h02-176-184-40-35.dsl.sta.abo.bbox.fr.
 [176.184.40.35]) by smtp.gmail.com with ESMTPSA id
 gg15-20020a170906e28f00b00982b204678fsm8436608ejb.207.2023.08.16.05.40.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 05:40:59 -0700 (PDT)
Message-ID: <3c3ddf27-00e4-465e-fb2b-a06e0f370188@linaro.org>
Date: Wed, 16 Aug 2023 14:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 5/9] tests/tcg: clean-up gdb confirm/pagination settings
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20230815145126.3444183-1-alex.bennee@linaro.org>
 <20230815145126.3444183-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230815145126.3444183-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/8/23 16:51, Alex Bennée wrote:
> We can do this all in the run-test.py script so remove the extraneous
> bits from the individual tests which got copied from the original
> non-CI gdb tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/guest-debug/run-test.py                         | 2 ++
>   tests/tcg/aarch64/gdbstub/test-sve-ioctl.py           | 3 ---
>   tests/tcg/aarch64/gdbstub/test-sve.py                 | 3 ---
>   tests/tcg/multiarch/gdbstub/memory.py                 | 3 ---
>   tests/tcg/multiarch/gdbstub/sha1.py                   | 4 ----
>   tests/tcg/multiarch/gdbstub/test-proc-mappings.py     | 4 ----
>   tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py   | 4 ----
>   tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py | 4 ----
>   tests/tcg/s390x/gdbstub/test-signals-s390x.py         | 4 ----
>   tests/tcg/s390x/gdbstub/test-svc.py                   | 4 ----
>   10 files changed, 2 insertions(+), 33 deletions(-)

No change since previous version ([*]), so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

[*] 
https://lore.kernel.org/qemu-devel/20230810153640.1879717-6-alex.bennee@linaro.org/

