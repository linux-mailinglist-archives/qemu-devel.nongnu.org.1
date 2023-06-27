Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AF8740575
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 23:08:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEFua-0000oB-BY; Tue, 27 Jun 2023 17:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEFuX-0000Uc-N3
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 17:07:41 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEFuS-0001Py-PN
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 17:07:41 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4fb863edcb6so1809624e87.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 14:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687900054; x=1690492054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E0JQjSjSQX8h/L1YEAK41dw+1ezNzjmO2CuBo78K9nY=;
 b=RzYUvYmHzfSqGbKsz4uBPMzzXrHvmEUe4ja2k70ENcynVrJ4l9o35S3u/GEAUZOXEY
 6loQ4zwgvB3AkS4okRR5CO6grpbeV6l8yjJpFdHpR+bvA9lynR2jHo3B9h4fe8X4njdW
 2bgWjlZf+TZeUTvfudnFSOHSAoSoxFmeDegYZ52vjSWMzozMyeM9p36twdVjAyKCZ6r2
 1/bPZ5Hg5fi6zyEo2yvPf2I+siMDWvyK6sRr1D3eUXirwISWxppMtyoDGKzgyY5MMmWN
 iGPE3xSem3cWO9ShPyU7l95MDxOq079kd03i/w8TndLmmaHnVy1FeZT0UEOwXjF4R0JL
 Ke/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687900054; x=1690492054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E0JQjSjSQX8h/L1YEAK41dw+1ezNzjmO2CuBo78K9nY=;
 b=LF/wy7q/hhw7z0dF1cPBTF+H2AOuoNe5vB2aK5suWZyjC7Z3WcTMfB00dyMigzEGCT
 LjyOzf1kS4DwQD3fl+UW12E2D3GA9Z71kAx8IuuAFlpIfO8ezcxsFvRhc6BSyZa3tjVX
 CNJPkVrSb4TzlNYyD6RHKaoILEIrbgPUJzcfWJslW9hyfNg3T16ezX8L9ClTP8Ek+row
 SrWVAa086Ra4+Ii5jDpIKnYlSPVWHUNl63ku2bD5W3yS9SrKWTfJyUPkz01pPrFv45Cw
 ksiEeNhRWOZ2iIjHPmj3Q2TK+UrA9bS8VXhTo+hJhDuJ1mGxm5QQKOg46fU0NGnmIC0S
 4S9w==
X-Gm-Message-State: AC+VfDzS3ce+Re0s0KrMQqbK4ZTcWWQRim8bXeXacwkFup4CnzQonLRC
 iskgH6xAjTyHC3giwXWLiFVz/Q==
X-Google-Smtp-Source: ACHHUZ627yEd6xOoOv0d8TWjwzaD7x7aAJgcbv9ncS054FTjHjeUi23K9wsb0IDFH8GAFWH26dMpBw==
X-Received: by 2002:a05:6512:2343:b0:4fa:9817:c1da with SMTP id
 p3-20020a056512234300b004fa9817c1damr6561711lfu.21.1687900054110; 
 Tue, 27 Jun 2023 14:07:34 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a1ccc0b000000b003fa8158135esm12571961wmb.11.2023.06.27.14.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 14:07:33 -0700 (PDT)
Message-ID: <3755b80c-8831-b54e-793d-26ae3acc383f@linaro.org>
Date: Tue, 27 Jun 2023 23:07:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 08/36] tests/qtests: clean-up and fix leak in
 generic_fuzz
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Bandan Das
 <bsd@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
 <20230627160943.2956928-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230627160943.2956928-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 27/6/23 18:09, Alex Bennée wrote:
> An update to the clang tooling detects more issues with the code
> including a memory leak from the g_string_new() allocation. Clean up
> the code to avoid the allocation and use ARRAY_SIZE while we are at
> it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/qtest/fuzz/generic_fuzz.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


