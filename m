Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C977BF536
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 10:02:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7h0-0000JC-Nj; Tue, 10 Oct 2023 04:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq7gt-0000IG-Df
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 04:02:07 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq7gr-0007W0-Mr
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 04:02:06 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9b64b98656bso902337266b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 01:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696924923; x=1697529723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1JCDLCMvLBC/YNTb53hWk8l+aZWZpln8CGpMQlpmp7M=;
 b=KdJ6IOvwxAwICgos5MR0jJkqptaj8Jk8Z42qF9f6xqC4LTWouCYwkSAZCByXjHhNPL
 /wKO3xk+UbsxPK2T6tgKMuR+Bfx33I5oHuDvhBcTrt87PLoVihJdmiLzVMrzVhIVLm7n
 tUXN3SoWaQKroDxebtzOx/2oBA/tAAMRiLCQo7R8cQ0LlGOPeeEMYbjCFOhMZSshNYwa
 ZWI6vJbNM1AWfKf5qxY3k6RzDALMvSU+xcgOCUN/psHuHenrMOgGexBGWCA2U2H6ZXhf
 uNm4f87KhfvAm0Jmrl6f+tO7BB+PVwgMj7jsV+C7pXwISMGqwItODZdR7T6rjAC9KQ8n
 VRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924923; x=1697529723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1JCDLCMvLBC/YNTb53hWk8l+aZWZpln8CGpMQlpmp7M=;
 b=dq3KK1KaRZoNS0WCPidQdX3/nSFJ6l50BE57WrAP2Sqap7yRwcwyLiF51E8jeiHLTU
 iNNNwwHmXZu2XbjaJFDpERy3T3FYnkEvK15zntOCI/Znt7Gn3Cw/FJELnq4qeUKTkvkg
 HpGnqiGugKnBOhRTVj42sUCJe+/HulSR7sFItZm1MFDmw2m1Fp74H/7zraClFK7bFBNs
 b6qy2gSk8KAfs9hzbgAmiYcz/JNIaB2Ma95fwB4MZ4FahGZHgIw5e/wvpvPjHv9Vz0Gi
 t/FGLnplwiLm3JP35Y9vVitLsiPuE9T9o8HuRZ3wx/llOkVMw/WuSAsXC0xva6cBWGqP
 LiqA==
X-Gm-Message-State: AOJu0YxcxBstGEjv07UFxR+yMCRTd7HhDwJ5CYC6tGruoj+4IpUesCxw
 HyiPL3FfnQgoN823V8xvmNIMfQ==
X-Google-Smtp-Source: AGHT+IGKnk6mQemAr87cV32YxiaSNz8Jyi2zggys5sXqg33I5qf4UCvTP1vzvfdhjdsieJSjUz1lWw==
X-Received: by 2002:a17:906:1dd:b0:9ae:540c:90ef with SMTP id
 29-20020a17090601dd00b009ae540c90efmr15438352ejj.18.1696924922882; 
 Tue, 10 Oct 2023 01:02:02 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 h16-20020a17090619d000b00997e99a662bsm7951589ejd.20.2023.10.10.01.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 01:02:02 -0700 (PDT)
Message-ID: <95400f38-e8dd-bb90-82c2-634f2e52ba90@linaro.org>
Date: Tue, 10 Oct 2023 10:02:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 05/11] testing/avocado: ppc add new BookE
 boot_linux_console.py tests
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-6-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231010075238.95646-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 10/10/23 09:52, Nicholas Piggin wrote:
> Add simple Linux kernel boot tests for BookE 64-bit and 32-bit CPUs
> using Guenter Roeck's rootfs images for Linux testing, and a gitlab
> repository with kernel images that I built since there are very few
> sources of modern BookE images now.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/avocado/boot_linux_console.py | 53 +++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


