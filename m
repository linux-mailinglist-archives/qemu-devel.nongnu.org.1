Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E57442C6
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 21:39:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFJxg-0004uQ-6c; Fri, 30 Jun 2023 15:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFJxe-0004uC-MD; Fri, 30 Jun 2023 15:39:18 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFJxd-0007sO-0g; Fri, 30 Jun 2023 15:39:18 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-565db4666d7so744497eaf.0; 
 Fri, 30 Jun 2023 12:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688153955; x=1690745955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0GnykpZdfhhlL7Sb0sTjVvC9UOgORxCP2SNZzGdsqb8=;
 b=Af29pXl6qBk2QesJoroufoajV77xcUruBE274vUSMTSzXowKISqvNRocGmeD/JEF6p
 6WpkwDVD6i7gg14bYJZMcdOVUX022SVviQPs/ywCcy5UXZBOsNJ0PQWXCzJLqxuFFXo2
 i0yzSj82vkbkxi/hMx2wcBC1SiNw/dCVwSrKOGVfVM7eUJg7PEooWlt1Fv9CIDn+4ofz
 Cdi3QxyO7khY/AKIF03q8rMQlg6Xq2nwHxp3TTfc5b9VF80hBVMzrcrqEOmFKJLYH9pt
 WCL3cEM3qcQjgxkBvzUGLvncd0yHV9BJRlq2io+8b1ChzW0BxkESPy2aXMvyjagPDt4j
 NxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688153955; x=1690745955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0GnykpZdfhhlL7Sb0sTjVvC9UOgORxCP2SNZzGdsqb8=;
 b=IIQZxta4tE5Bajf7e8a7r2sexJ4u5rZkHN7KdyP5YNRkPEGb9pxQB1m5E22dOeS31t
 OtGaccgP1wTlm7ecWiKyxNOzslLDRucAO3RLSbaGDisOOfykpU72fZGMU2MJbroRg/Dg
 vmh9VHDDQ680nMI2gXmX2DGlye9HMMKGFeTqzmOixkwPUGjvrHKueMRgo+LEOBs5FBlx
 FgLO057e4XPaBpPF0TDfq92CUlMq6dHGakgXiaYcvyhmRudNZ0QHQ2pXhZJQTjD/m6iw
 k6lY+YGwG0ub7onj3Wr/s+JO1924cmhe6mNN1nEcszaiBYfk+6leFj7vI8UU3pgYJidN
 AKyQ==
X-Gm-Message-State: AC+VfDxdoQ5UFpoVYqig2bCZyFgLDNuW3AIU8OoWRTl2vc0Ch/kWhrbB
 b8PzoYV9JnRs/P+i+eEBqIk=
X-Google-Smtp-Source: ACHHUZ6kqdoNCNbe/9IYu9Sb0/PZ/14fFVuROu2uBTlyzklSZWPeE4WQNIcYeSiApTAe1kgF0Mq87A==
X-Received: by 2002:a4a:98c2:0:b0:563:51d2:8449 with SMTP id
 b2-20020a4a98c2000000b0056351d28449mr2333857ooj.7.1688153955312; 
 Fri, 30 Jun 2023 12:39:15 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 z6-20020a9d7a46000000b006b8ad42654csm422158otm.0.2023.06.30.12.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 12:39:15 -0700 (PDT)
Message-ID: <b6cad07b-7529-271d-1f8b-bf2b3a8afdb9@gmail.com>
Date: Fri, 30 Jun 2023 16:39:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] tests/avocado: record_replay test for ppc powernv
 machine
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230625103700.8992-1-npiggin@gmail.com>
 <20230625103700.8992-2-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230625103700.8992-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.095,
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



On 6/25/23 07:37, Nicholas Piggin wrote:
> The powernv machine can boot Linux to VFS mount with icount enabled.
> Add a test case for it.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

>   tests/avocado/replay_kernel.py | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
> index a4dc8c0d6c..dc350fd781 100644
> --- a/tests/avocado/replay_kernel.py
> +++ b/tests/avocado/replay_kernel.py
> @@ -258,6 +258,22 @@ def test_ppc64_pseries(self):
>           console_pattern = 'VFS: Cannot open root device'
>           self.run_rr(kernel_path, kernel_command_line, console_pattern)
>   
> +    def test_ppc64_powernv(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:powernv
> +        :avocado: tags=accel:tcg
> +        """
> +        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
> +                      '/fedora-secondary/releases/29/Everything/ppc64le/os'
> +                      '/ppc/ppc64/vmlinuz')
> +        kernel_hash = '3fe04abfc852b66653b8c3c897a59a689270bc77'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=tty0 console=hvc0'
> +        console_pattern = 'VFS: Cannot open root device'
> +        self.run_rr(kernel_path, kernel_command_line, console_pattern)
> +
>       def test_m68k_q800(self):
>           """
>           :avocado: tags=arch:m68k

