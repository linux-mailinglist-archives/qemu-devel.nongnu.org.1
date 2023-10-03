Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3567B6A6E
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 15:26:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnfP6-0005tW-LT; Tue, 03 Oct 2023 09:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnfP4-0005rI-9h
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:25:34 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnfP2-0003DW-CB
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:25:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4064867903cso9386765e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696339530; x=1696944330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b9EKo/m7U4EHVQlsRnB/t3McfyOJ+8zxrsmJXyTxX70=;
 b=Wc/RmjVTh48Wl4lQt4zqVOuuVryu82iiPHhO5bS/3qhkxmdvl4kC2Zd51JDHzZSZZC
 ySJnitXKyr8aCxm83pCV0osyDROZQ9nbdStTQYhV6MuQ47MM+UpaouHXKE4pobNBGOkJ
 zHRv0+kdau8QkVIwjiUoiDxBzf3u4WnY3xP3XgbZR793u32P/FMDgUXYI5RhMrs4L1PL
 lOJqBXdOOd3tvhTGcIt3DeF/vqeUL/oOkbpfqubj0WvkUABogT1gmw6R1SYZFbDuZ6jb
 fiuqiQzJyO3evp26Udkn6cwhYS0hmShgZC+T1lp89iKpxUNyGBI6ZlZaflbJ8ZL0yDeK
 QL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696339530; x=1696944330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b9EKo/m7U4EHVQlsRnB/t3McfyOJ+8zxrsmJXyTxX70=;
 b=ND+uYc5WemGUOuaa2oIDxwxlLs7foUB8QzTS6rWJMi4mHePLXeozJlEgE7A2O3XrYX
 Lf8uE8xRwPtAQTLybdRTsOY+1U8yLUI0n4YiXj9cAR/nQp1NhoMsrXk1TFRDebgxf6yf
 yLeBpAZdjWgTzPHyAWqrOiWuo2OMs8Lg1pTWgT9zhvRR08Gq1/MJbcH2samVlzR35Cpo
 3SJnHPqaVuOeFnOYC5ygriCM1vjSANwc0oGgSYm3d6Er7dqb33DeGycgxYuKE1JwHtz2
 zSvExxEEXMYDDIDt7VUt9P2BGG+M0opuIfYWI+aY2B+PCrNj/pHPKASIukvHrf1rfcfN
 zpjA==
X-Gm-Message-State: AOJu0Yx2x2Um0thdvwMMftpIxNAh1XMMh4mwDngRuk1MhB7sf1T90yKO
 oNXElly6pouDIJe9pXCkqFSPPA==
X-Google-Smtp-Source: AGHT+IFq/np3a3QICu6ak5G3P5O6TsQtDP1Ui3Jjchdu4E6/uG3kG2vWCTAI7mo7T11KJC8rkguQaQ==
X-Received: by 2002:a7b:ce16:0:b0:406:4501:9095 with SMTP id
 m22-20020a7bce16000000b0040645019095mr13747249wmc.40.1696339530534; 
 Tue, 03 Oct 2023 06:25:30 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-246.abo.bbox.fr.
 [176.131.222.246]) by smtp.gmail.com with ESMTPSA id
 z20-20020a7bc7d4000000b004064e3b94afsm9480975wmk.4.2023.10.03.06.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 06:25:29 -0700 (PDT)
Message-ID: <d6bd1212-5613-28a4-1cf2-ef5208a4c434@linaro.org>
Date: Tue, 3 Oct 2023 15:25:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] target/riscv/kvm: improve 'init_multiext_cfg'
 error msg
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com
References: <20231003132148.797921-1-dbarboza@ventanamicro.com>
 <20231003132148.797921-2-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003132148.797921-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 3/10/23 15:21, Daniel Henrique Barboza wrote:
> Our error message is returning the value of 'ret', which will be always
> -1 in case of error, and will not be that useful:
> 
> qemu-system-riscv64: Unable to read ISA_EXT KVM register ssaia, error -1
> 
> Improve the error message by outputting 'errno' instead of 'ret'. Use
> strerrorname_np() to output the error name instead of the error code.
> This will give us what we need to know right away:
> 
> qemu-system-riscv64: Unable to read ISA_EXT KVM register ssaia, error code: ENOENT
> 
> Given that we're going to exit(1) in this condition instead of
> attempting to recover, remove the 'kvm_riscv_destroy_scratch_vcpu()'
> call.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/kvm/kvm-cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


