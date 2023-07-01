Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C81D47448C9
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 14:07:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFZN1-0007Fs-9g; Sat, 01 Jul 2023 08:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFZMz-0007FU-8x
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 08:06:29 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFZMx-0004IQ-Oh
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 08:06:29 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6b71cdb47e1so2472270a34.2
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 05:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688213186; x=1690805186;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/1H45VmIvMku10dk4lDT69pGQe4+i/UvfEGCxr7c/GA=;
 b=jdhW7m7WlnsGHmEd8NF6n0WyMIMB867hSaQ6sbqEXstlP4+c69Xd2/DdLwgbbna4gc
 LHw/6FRqPyWZIvvLzI/tlLKSifHzLs0yR7+OpOiy/6lzkNqQwoab3FgfEps2h7knZ6VB
 iusO+m7XulF73/Y9+t4HjUbNJPuIEK4vrp2GgdsKE4rirExtPyiUG7T+KvI0HvTrwL0u
 IyTsJajxD66hukRt8K9Knj8ZGMmseQ0G2Ch/87B1/ptm0olIH9ccHCWzpJvsKowlWTB6
 Vjw/7qSk/xWS69QYBUEX7BixD1Bka9mHFrPp1kCRe71CM8nuXSYzUXgEPaYPKkrUW99+
 OGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688213186; x=1690805186;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/1H45VmIvMku10dk4lDT69pGQe4+i/UvfEGCxr7c/GA=;
 b=Dr0vlxiJ9Uj+axjP/fYjpYu9bBSw1tRFcNapHT9ARjxHLnQEnGANh4ls1GpCRtaKdW
 wh2DwCmdNaQ6NMfkjwlr0LH0OnsYvmSVcY8V2KuuUfglc9AddZEHnu6DW2KGm/L9dz0N
 1aO+HRh3MvzN79Aa8Mkz87ivZQw8HG+dG6+h/hkGst2VTZG/7sRvXeyYDuTZZZ403j3+
 sR9PMb5/DY/GzkIhSt8HZSLxUyDHXrUq7Ad7hTSKudPcAie7sHjqjDe3uLYbU2CnmhET
 oMoQlXwQfE1Jvf3sCX9B8nuVxj3c6GgcY+ZxmZYAhnamN/nVuci7KoSxm5KNxr/eo20r
 tJtA==
X-Gm-Message-State: AC+VfDzRzTQfqdWiY1ooB/8NR28PCZJt7k5bm7raIZ5e8sQMIYPph4AW
 SQPPlwKEZnAOMmnmWNKWGL6b3abnpbmSp6/k5zg=
X-Google-Smtp-Source: ACHHUZ4gHTRuO67g1HhgpKPa4vgcX4fszt7IY/ObRRjdbUrOZPJzNAR+K/+3CZcaWEmfb2zE/NrpOA==
X-Received: by 2002:a05:6830:3:b0:6b1:604f:3f22 with SMTP id
 c3-20020a056830000300b006b1604f3f22mr6809660otp.2.1688213186476; 
 Sat, 01 Jul 2023 05:06:26 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 h17-20020a9d6411000000b006b720475c38sm7552893otl.45.2023.07.01.05.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 05:06:26 -0700 (PDT)
Message-ID: <f0cb1662-f186-a9bb-8913-d92ee319d0df@ventanamicro.com>
Date: Sat, 1 Jul 2023 09:06:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] tests/avocado: riscv: Enable 32-bit Spike OpenSBI
 boot testing
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, Alistair Francis
 <alistair.francis@wdc.com>, qemu-devel@nongnu.org
References: <20230630160717.843044-1-bmeng@tinylab.org>
 <20230630160717.843044-2-bmeng@tinylab.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230630160717.843044-2-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32d.google.com
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



On 6/30/23 13:07, Bin Meng wrote:
> The 32-bit Spike boot issue has been fixed in the OpenSBI v1.3.
> Let's enable the 32-bit Spike OpenSBI boot testing.
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---


(03/17) tests/avocado/riscv_opensbi.py:RiscvOpenSBI.test_riscv32_spike: PASS (0.10 s)

Nice!

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>



> 
>   tests/avocado/riscv_opensbi.py | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/tests/avocado/riscv_opensbi.py b/tests/avocado/riscv_opensbi.py
> index e02f0d404a..bfff9cc3c3 100644
> --- a/tests/avocado/riscv_opensbi.py
> +++ b/tests/avocado/riscv_opensbi.py
> @@ -6,7 +6,6 @@
>   # later.  See the COPYING file in the top-level directory.
>   
>   from avocado_qemu import QemuSystemTest
> -from avocado import skip
>   from avocado_qemu import wait_for_console_pattern
>   
>   class RiscvOpenSBI(QemuSystemTest):
> @@ -21,7 +20,6 @@ def boot_opensbi(self):
>           wait_for_console_pattern(self, 'Platform Name')
>           wait_for_console_pattern(self, 'Boot HART MEDELEG')
>   
> -    @skip("requires OpenSBI fix to work")
>       def test_riscv32_spike(self):
>           """
>           :avocado: tags=arch:riscv32

