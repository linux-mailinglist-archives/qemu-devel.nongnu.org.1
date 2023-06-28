Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79745740BBC
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 10:41:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEQj3-0001Hu-OV; Wed, 28 Jun 2023 04:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEQj2-0001Hd-8E
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:40:32 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEQj0-00068q-65
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:40:31 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b699a2fe86so59356381fa.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687941628; x=1690533628;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WtqTGNQgll00hcJJrLoHKotUK6PyfLyby7zxhKFYDUg=;
 b=D1u9pU55YPGy7r6bL0/oYVIWgZquoViSCWtdRIA4DQzpamNaHu0MYBJK5RRPjb8bmU
 hy6Z+6GF8h8p1bbZli88eNlO4GOu4+rXkRxjomjiRHUJImnb9jp4I72holZx8ACZZGtT
 78+qu7lD1S4KzWSQbMhdDildpGMy8ACS3bUguWFDroC6sx6iQmFWKJPsdrEvhuLEXVvN
 oNnDpIXqWkotYm7MVPziXDDxhH3pnt95szzMyEZms4xzZPIDt2Z2moCjA5lcO3BegvNE
 0O+VwDEFe7SDXZY4koWPd0Re0T+9q+CILg+PS0tMe5n6tjvwnoZv9qjkl5YdlSIGi6/c
 WjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687941628; x=1690533628;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WtqTGNQgll00hcJJrLoHKotUK6PyfLyby7zxhKFYDUg=;
 b=aV1w5mb1Dk/cP4bQ0lU6LoHc4QGoXvqlIzpaMosFZKr8qoGBPHhXxCe17RlhJzTH57
 t54h3W2LSLgsxBGRzFbXslCppwRJMrSYP4wRsT70ylVucFbBy+G6UpHyBNW1STZDo9bA
 0uYXn0AHdxPzQHJ2mBOPjXlXUHEsYjza7jo7GHc9HE+0bwOrTcl6E2oLHs/dZ1w4wERX
 fBEqSem/bhnNRhlacnUhOg4mxf37lT54QE8c7AIMd8NT2SLuugysEW9w9SocIBubAi+8
 E2yli6b0VJYxOgoG6pF5luBAZguvptF624vCQ7A/OIMUxcX5URJFqpA2Al4ekA/PkT5v
 CKHg==
X-Gm-Message-State: AC+VfDxpEQBfbOPqeuYEx6Ej5C2BdEthADJ4iPuHQB0QknkqoSHVLy+E
 VrhpQaLyVtumY/0V+dOurs+e2Q==
X-Google-Smtp-Source: ACHHUZ7VSTJ1+8Egtuj2rFei3XC1FYP+r8YRTT9Vpd+GykMF6D50EKB+0ioW8yN2JiwyF9KAfg5XWA==
X-Received: by 2002:a05:651c:207:b0:2b4:8487:5f77 with SMTP id
 y7-20020a05651c020700b002b484875f77mr17924725ljn.27.1687941628128; 
 Wed, 28 Jun 2023 01:40:28 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 c21-20020a7bc855000000b003f8fac0ad4bsm13015660wml.17.2023.06.28.01.40.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 01:40:27 -0700 (PDT)
Message-ID: <832d49b4-4d53-729e-c8aa-004a71bdf99f@linaro.org>
Date: Wed, 28 Jun 2023 10:40:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 17/36] plugins: force slow path when plugins instrument
 memory ops
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
 Bandan Das <bsd@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Robert Henry <robhenry@microsoft.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
 <20230627160943.2956928-18-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230627160943.2956928-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 6/27/23 18:09, Alex Bennée wrote:
> The lack of SVE memory instrumentation has been an omission in plugin
> handling since it was introduced. Fortunately we can utilise the
> probe_* functions to force all all memory access to follow the slow
> path. We do this by checking the access type and presence of plugin
> memory callbacks and if set return the TLB_MMIO flag.
> 
> We have to jump through a few hoops in user mode to re-use the flag
> but it was the desired effect:
> 
>   ./qemu-system-aarch64 -display none -serial mon:stdio \
>     -M virt -cpu max -semihosting-config enable=on \
>     -kernel ./tests/tcg/aarch64-softmmu/memory-sve \
>     -plugin ./contrib/plugins/libexeclog.so,ifilter=st1w,afilter=0x40001808 -d plugin
> 
> gives (disas doesn't currently understand st1w):
> 
>    0, 0x40001808, 0xe54342a0, ".byte 0xa0, 0x42, 0x43, 0xe5", store, 0x40213010, RAM, store, 0x40213014, RAM, store, 0x40213018, RAM
> 
> And for user-mode:
> 
>    ./qemu-aarch64 \
>      -plugin contrib/plugins/libexeclog.so,afilter=0x4007c0 \
>      -d plugin \
>      ./tests/tcg/aarch64-linux-user/sha512-sve
> 
> gives:
> 
>    1..10
>    ok 1 - do_test(&tests[i])
>    0, 0x4007c0, 0xa4004b80, ".byte 0x80, 0x4b, 0x00, 0xa4", load, 0x5500800370, load, 0x5500800371, load, 0x5500800372, load, 0x5500800373, load, 0x5500800374, load, 0x5500800375, load, 0x5500800376, load, 0x5500800377, load, 0x5500800378, load, 0x5500800379, load, 0x550080037a, load, 0x550080037b, load, 0x550080037c, load, 0x550080037d, load, 0x550080037e, load, 0x550080037f, load, 0x5500800380, load, 0x5500800381, load, 0x5500800382, load, 0x5500800383, load, 0x5500800384, load, 0x5500800385, load, 0x5500800386, lo
>    ad, 0x5500800387, load, 0x5500800388, load, 0x5500800389, load, 0x550080038a, load, 0x550080038b, load, 0x550080038c, load, 0x550080038d, load, 0x550080038e, load, 0x550080038f, load, 0x5500800390, load, 0x5500800391, load, 0x5500800392, load, 0x5500800393, load, 0x5500800394, load, 0x5500800395, load, 0x5500800396, load, 0x5500800397, load, 0x5500800398, load, 0x5500800399, load, 0x550080039a, load, 0x550080039b, load, 0x550080039c, load, 0x550080039d, load, 0x550080039e, load, 0x550080039f, load, 0x55008003a0, load, 0x55008003a1, load, 0x55008003a2, load, 0x55008003a3, load, 0x55008003a4, load, 0x55008003a5, load, 0x55008003a6, load, 0x55008003a7, load, 0x55008003a8, load, 0x55008003a9, load, 0x55008003aa, load, 0x55008003ab, load, 0x55008003ac, load, 0x55008003ad, load, 0x55008003ae, load, 0x55008003af
> 
> (4007c0 is the ld1b in the sha512-sve)
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson<richard.henderson@linaro.org>
> Cc: Robert Henry<robhenry@microsoft.com>
> Cc: Aaron Lindsay<aaron@os.amperecomputing.com>
> 
> ---
> v2
>   - allow TLB_MMIO to appear in user-mode probe_access
> v3
>   - checkpatch cleanups
> ---

I thought we dropped this patch until we could do something with TLB accesses.


r~

