Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC357CA1E0
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:42:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJ9k-0004WE-Cu; Mon, 16 Oct 2023 04:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qsJ9f-0004W6-EL
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qsJ9d-0008V2-1y
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697445646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G4nq+OYDwagTD34N/zJ2fFU6RHTuZVx1gaH8W6JaGfA=;
 b=iLWBacYW7b4OTFBEozhCKeY008aFOBfes+vZyrVdbPvstAxWcSbvA6bLWDrO8/8a1fqC9a
 Uw8uC8SYPUtlaDodZly/0lc3hb02hItwGMVti0yNRRJ9gix838PJDU2zruTuSmqMiJc4vs
 wRhl87VeJCS3Go8t5kGj9o2z+00Xirc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-UWDxMY-iP6CmArz29qau_Q-1; Mon, 16 Oct 2023 04:40:28 -0400
X-MC-Unique: UWDxMY-iP6CmArz29qau_Q-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66d155fc53eso51064546d6.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 01:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697445628; x=1698050428;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G4nq+OYDwagTD34N/zJ2fFU6RHTuZVx1gaH8W6JaGfA=;
 b=ZVKLTB5t2APjZRixnTHyrgXQ5cqp0vuX0E6FG5DcGJ9lEoPZbMIQ6vn5ufFTPzpkOj
 2bgQ3fN6jAiyX+NQScXrUb3swLU+bUP6u1fwSXmcQHeIdFML23Gesc841s1PGPL/Cv4N
 rQraVKZl1+nGxhswKIs6h6ucZnHN2/+hdj4S5YXi+u5xfQyp8xq96I7LqsWCdmRtT9yB
 FsfD5KSCkPJF4xi6ke2lXLJBmwklDLGkZyv1VWoRQorTDwsIB8W4ZquQD29TEQsBvA91
 YNO1Ua7X1WpkNirASKRJq07a+sOp5UAj0GhUWXXQG/4Kcvw1VoN7Yp5EOiwKbE0DnJ3U
 gbTA==
X-Gm-Message-State: AOJu0Yyht11IX/4Uwr8/Y6WtR9j53xwV3FwGU8A/Bt7GFVebnJE8o2Tx
 igSuURdiSn/3jgJK4lU7Z1oouAHQHFfmW2FZ2CnrWXLHoV+4o4Y+OhxM7KbJ3mBZrlT5NtBYvGN
 vE63V1st3RHG/nxk=
X-Received: by 2002:ad4:4ee5:0:b0:66d:1f11:8b85 with SMTP id
 dv5-20020ad44ee5000000b0066d1f118b85mr12997260qvb.13.1697445628297; 
 Mon, 16 Oct 2023 01:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbZdyjYvxT0VwLWgZ6thFk8+rqFvJT2BtEdzJiIeSB/Olr4NTCiEI58nBkuBp8l6Up4sYuVw==
X-Received: by 2002:ad4:4ee5:0:b0:66d:1f11:8b85 with SMTP id
 dv5-20020ad44ee5000000b0066d1f118b85mr12997247qvb.13.1697445628019; 
 Mon, 16 Oct 2023 01:40:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 dy18-20020ad44e92000000b0065b17ec4b49sm3248480qvb.46.2023.10.16.01.40.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 01:40:27 -0700 (PDT)
Message-ID: <c60120e5-7d07-4249-8bb8-335fd649e988@redhat.com>
Date: Mon, 16 Oct 2023 10:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/11] tests/avocado: Add ppc pseries and powernv Hash
 MMU tests
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-3-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20231010075238.95646-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> The Hash MMU mode is supported along side Radix in POWER hardware, and
> Linux supports running in either mode. Radix is the default so to keep
> up testing of QEMU Hash MMU, add some explicit Hash MMU tests.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Nice ! Could we do the same with XICS and XIVE (xive=off) ? since XIVE
is the default now.

May be we should add a boot test for all CPUs supported by pseries :

   970, 970mp, POWER5+, P8, P9, P10.

Same for PowerNV.

Thanks,

C.

> ---
>   tests/avocado/ppc_powernv.py | 21 ++++++++++++++++++---
>   tests/avocado/ppc_pseries.py | 20 +++++++++++++++++---
>   2 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/avocado/ppc_powernv.py b/tests/avocado/ppc_powernv.py
> index d0e5c07bde..2be322c47d 100644
> --- a/tests/avocado/ppc_powernv.py
> +++ b/tests/avocado/ppc_powernv.py
> @@ -12,11 +12,11 @@
>   class powernvMachine(QemuSystemTest):
>   
>       timeout = 90
> -    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
>       panic_message = 'Kernel panic - not syncing'
>       good_message = 'VFS: Cannot open root device'
>   
> -    def do_test_linux_boot(self):
> +    def do_test_linux_boot(self, kernel_command_line = KERNEL_COMMON_COMMAND_LINE):
>           self.require_accelerator("tcg")
>           kernel_url = ('https://archives.fedoraproject.org/pub/archive'
>                         '/fedora-secondary/releases/29/Everything/ppc64le/os'
> @@ -25,7 +25,6 @@ def do_test_linux_boot(self):
>           kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>   
>           self.vm.set_console()
> -        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
>           self.vm.add_args('-kernel', kernel_path,
>                            '-append', kernel_command_line)
>           self.vm.launch()
> @@ -54,6 +53,22 @@ def test_linux_smp_boot(self):
>           wait_for_console_pattern(self, console_pattern, self.panic_message)
>           wait_for_console_pattern(self, self.good_message, self.panic_message)
>   
> +    def test_linux_smp_hpt_boot(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:powernv
> +        :avocado: tags=accel:tcg
> +        """
> +
> +        self.vm.add_args('-smp', '4')
> +        self.do_test_linux_boot(self.KERNEL_COMMON_COMMAND_LINE +
> +                                'disable_radix')
> +        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
> +        wait_for_console_pattern(self, 'hash-mmu: Initializing hash mmu',
> +                                 self.panic_message)
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        wait_for_console_pattern(self, self.good_message, self.panic_message)
> +
>       def test_linux_smt_boot(self):
>           """
>           :avocado: tags=arch:ppc64
> diff --git a/tests/avocado/ppc_pseries.py b/tests/avocado/ppc_pseries.py
> index a8311e6555..74aaa4ac4a 100644
> --- a/tests/avocado/ppc_pseries.py
> +++ b/tests/avocado/ppc_pseries.py
> @@ -12,11 +12,11 @@
>   class pseriesMachine(QemuSystemTest):
>   
>       timeout = 90
> -    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
>       panic_message = 'Kernel panic - not syncing'
>       good_message = 'VFS: Cannot open root device'
>   
> -    def do_test_ppc64_linux_boot(self):
> +    def do_test_ppc64_linux_boot(self, kernel_command_line = KERNEL_COMMON_COMMAND_LINE):
>           kernel_url = ('https://archives.fedoraproject.org/pub/archive'
>                         '/fedora-secondary/releases/29/Everything/ppc64le/os'
>                         '/ppc/ppc64/vmlinuz')
> @@ -24,7 +24,6 @@ def do_test_ppc64_linux_boot(self):
>           kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>   
>           self.vm.set_console()
> -        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
>           self.vm.add_args('-kernel', kernel_path,
>                            '-append', kernel_command_line)
>           self.vm.launch()
> @@ -62,6 +61,21 @@ def test_ppc64_linux_smp_boot(self):
>           wait_for_console_pattern(self, console_pattern, self.panic_message)
>           wait_for_console_pattern(self, self.good_message, self.panic_message)
>   
> +    def test_ppc64_linux_hpt_smp_boot(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        """
> +
> +        self.vm.add_args('-smp', '4')
> +        self.do_test_ppc64_linux_boot(self.KERNEL_COMMON_COMMAND_LINE +
> +                                      'disable_radix')
> +        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
> +        wait_for_console_pattern(self, 'hash-mmu: Initializing hash mmu',
> +                                 self.panic_message)
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        wait_for_console_pattern(self, self.good_message, self.panic_message)
> +
>       def test_ppc64_linux_smt_boot(self):
>           """
>           :avocado: tags=arch:ppc64


