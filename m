Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A96742102
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 09:31:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEm7b-0006AO-R1; Thu, 29 Jun 2023 03:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEm7G-00069p-P9
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:30:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEm7D-0002b3-N4
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:30:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fa96fd79feso3633235e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 00:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688023853; x=1690615853;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0lOXHXqCerDPfT/4U+yKc+jXZqERXL9Qi4vT1mrkf20=;
 b=fX5bMKEyH6ukw4oqx5qsKyFB3QPRlYy8szlnfHibo8qGLSqvj7nnBV5fDSlXD3+jNK
 tfEarFhApfZxypQg0SjO1aEPgx+/5DJfKIvxSSL6FAYBVdwogGg8KVu2cFThYiwQlnBP
 MRlHsKjLnqCtlfUvKb/y7fDyMkM6AG9emeUp52ubmbw2U0FJPW3tn+GSPcHCKpe7kV5V
 8g9syc3ekdk/oW5Nf3zgWG5lKBGEWV/ZZhdUe5SSpTKnK1ZiY6TmcSk9X4f1fOpXyodO
 ara8o4bah+P6Fe23TfCEc69gG1ddmlWLTveJ1OzHMStzmtFOP4YeHetIqblxz12JY5aK
 5r5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688023853; x=1690615853;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0lOXHXqCerDPfT/4U+yKc+jXZqERXL9Qi4vT1mrkf20=;
 b=kq2BqJwm0RW9ddC9i0bB9eGSgUDkhrCZZK8ioT2C7YuYOLO6FczbGLzK0mgzeESYpm
 nYOPuD5luZ8baHu6yCWSz1Ht40RadouNwYmpp6RPwY4JGLsEzdNaUHIYVzarN3CCwTei
 4JW56cgtJw9M7rgA9zT/KnGpbiX+ToyLxvT1V+NtBdJQ2JRvjaXjo8N58kp3/8b9/m+W
 0+dP2IRcNbmZbpxan0Nwx2aLC70O1gGjVOkDdA2AUHp/5cUP90QrqDsTBISYNV3/2ako
 Nmv9sJVXnzhwKmrdJ18T03aW2iklb1Hu1EoT8lrUFFXMWA0pxu455gi0UR5K0cs7gEfA
 UpYw==
X-Gm-Message-State: AC+VfDy9IHepY6EyHc01Vn8VshNsVtJ3yqFxmVvfwz+rmKTjcKZFxbKW
 Sh0376gZClBW1kApijFNEqJaeQ==
X-Google-Smtp-Source: ACHHUZ6fSTUXFye6zswI35ZkyDEgnRKJlkHMEmai65HlqpBbNFmtHJmvRWViolKMinLmdTSi+UDz4A==
X-Received: by 2002:a1c:7417:0:b0:3f9:b87c:10db with SMTP id
 p23-20020a1c7417000000b003f9b87c10dbmr20824700wmc.3.1688023853541; 
 Thu, 29 Jun 2023 00:30:53 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a7bc446000000b003fba137857esm7167331wmi.14.2023.06.29.00.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 00:30:53 -0700 (PDT)
Message-ID: <7491e886-026c-4f97-3469-d9f7abe74f1c@linaro.org>
Date: Thu, 29 Jun 2023 09:30:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v6 15/20] target/riscv/cpu.c: add satp_mode properties
 earlier
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com
References: <20230628213033.170315-1-dbarboza@ventanamicro.com>
 <20230628213033.170315-16-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230628213033.170315-16-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 28/6/23 23:30, Daniel Henrique Barboza wrote:
> riscv_cpu_add_user_properties() ended up with an excess of "#ifndef
> CONFIG_USER_ONLY" blocks after changes that added KVM properties
> handling.
> 
> KVM specific properties are required to be created earlier than their
> TCG counterparts, but the remaining props can be created at any order.
> Move riscv_add_satp_mode_properties() to the start of the function,
> inside the !CONFIG_USER_ONLY block already present there, to remove the
> last ifndef block.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/cpu.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


