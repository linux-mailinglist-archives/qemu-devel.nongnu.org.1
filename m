Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0766970CDBF
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 00:21:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Dsz-000527-UF; Mon, 22 May 2023 18:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Dsu-00051c-Cl
 for qemu-devel@nongnu.org; Mon, 22 May 2023 18:20:08 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Dss-0001ap-Dl
 for qemu-devel@nongnu.org; Mon, 22 May 2023 18:20:08 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64a9335a8e7so2786514b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 15:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684794004; x=1687386004;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mt7/+bhbm+0BfTQQEpMlnfBq6koNA1upsSJKM3q4Quo=;
 b=WwmmIrCQSsgB3HRlEBuYtTfMVPHRYwh1feoUaBV4Gpe4t+6CkGbutZrq+R3on7UBHn
 T0diYvQyrG8C5a0ZljU1KY1UxrgdtBIpKpg9HTO9/gECQvn5ui2trO8GzAWgbCEtzx+y
 C6WRBMcEl/OYsQFCT2ayZVlvwkXGvam1n+b7KYtbHRiOixxRPiuXjfWWYIqEqe/tRqtT
 c79QiYF67+1TdSvZmM9L7Q46upLTy2bYQxtREAu42zCmgyYV/o0w+3j5mY7t608MyyzB
 bhkVwDctJEpCmWydizoCpw8f8+5yP2xOQ/BzNnF93TSBmokuwsTVqde06KqtvoGRv2ki
 96UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684794004; x=1687386004;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mt7/+bhbm+0BfTQQEpMlnfBq6koNA1upsSJKM3q4Quo=;
 b=SQEso6sUQ0tbFqhuTYs2h85mqF6Xl4tp3N2rMPgL3F+ws/NAo5QdIxGmdZkZt2DqGr
 ILCfY6agp/DpeVYo8WCt179mSisSBfHfrnJN2p2+kJRjKNzfIx7iB7jkz9+e3dwH504r
 kDRxmeHAuHZRIICiOR294+JiNymQLXLt6YBy93DEtTFG33Nk2m0Ptb+pNRyLMbpxU6W6
 8cbwTBCUlx3p7j99Hhvhcl8rzLpABauQcubznjCdG1Vpdt7/NE0yYrBvCuM3sjWDjOZE
 Fs4flxsUyBKGf58aVxthV1xzPYUcgoaOHMKs4DTMPmCsQcJaTZ8kgR0mN+UmzHZ9i1B2
 yYow==
X-Gm-Message-State: AC+VfDxFm9JrmZEfYrJMTqV383QYiO/RCYGe7LSmfmc1owx0krU727fM
 JnymtQrUrjB/uCpIURgvZYufnQ==
X-Google-Smtp-Source: ACHHUZ46i/jTlkxg+zk14jgQDDRa3zoeCLAd6w1+WDeyirFKO2Hq9DOS9YXoeidgATojfLsjo+s2cg==
X-Received: by 2002:a05:6a20:6a03:b0:f0:50c4:4c43 with SMTP id
 p3-20020a056a206a0300b000f050c44c43mr14181785pzk.5.1684794004510; 
 Mon, 22 May 2023 15:20:04 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86fe:2b34:5897:c8ef?
 ([2602:ae:1598:4c01:86fe:2b34:5897:c8ef])
 by smtp.gmail.com with ESMTPSA id
 r25-20020a62e419000000b0062d859a33d1sm4552116pfh.84.2023.05.22.15.20.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 15:20:04 -0700 (PDT)
Message-ID: <560439e1-d35e-cf36-c4bc-6165ded65fdf@linaro.org>
Date: Mon, 22 May 2023 15:20:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/20] Allow "make check" with "--without-default-devices"
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20230522115014.1110840-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230522115014.1110840-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/22/23 04:49, Thomas Huth wrote:
> The following changes since commit aa222a8e4f975284b3f8f131653a4114b3d333b3:
> 
>    Merge tag 'for_upstream' ofhttps://git.kernel.org/pub/scm/virt/kvm/mst/qemu  into staging (2023-05-19 12:17:16 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2023-05-22
> 
> for you to fetch changes up to 3884bf6468ac6bbb58c2b3feaa74e87f821b52f3:
> 
>    memory: stricter checks prior to unsetting engaged_in_io (2023-05-22 10:35:28 +0200)
> 
> ----------------------------------------------------------------
> * First batch of fixes to allow "make check" with "--without-default-devices"
> * Enable the "bios bits" avocado test in the gitlab-CI
> * Another minor fix for the redundancy DMA blocker code
> 
> ----------------------------------------------------------------
> Alexander Bulekov (1):
>        memory: stricter checks prior to unsetting engaged_in_io
> 
> Ani Sinha (1):
>        acpi/tests/avocado/bits: enable bios bits avocado tests on gitlab CI pipeline
> 
> Thomas Huth (18):
>        hw/i386/Kconfig: ISAPC works fine without VGA_ISA
>        softmmu/vl.c: Check for the availability of the VGA device before using it
>        hw: Move the default NIC machine class setting from the x86 to the generic one
>        softmmu/vl.c: Disable default NIC if it has not been compiled into the binary
>        hw/ppc: Use MachineClass->default_nic in the ppc machines
>        hw/s390x: Use MachineClass->default_nic in the s390x machine
>        hw/sh4: Use MachineClass->default_nic in the sh4 r2d machine
>        hw/char/parallel: Move TYPE_ISA_PARALLEL to the header file
>        hw/i386: Ignore the default parallel port if it has not been compiled into QEMU
>        hw/sparc64/sun4u: Use MachineClass->default_nic and MachineClass->no_parallel
>        tests/qtest/readconfig-test: Check for the availability of USB controllers
>        tests/qtest/usb-hcd-uhci-test: Skip test if UHCI controller is not available
>        tests/qtest/cdrom-test: Fix the test to also work without optional devices
>        tests/qtest/virtio-ccw-test: Remove superfluous tests
>        tests/qtest: Check for the availability of virtio-ccw devices before using them
>        tests/qtest/meson.build: Run the net filter tests only with default devices
>        tests/qemu-iotests/172: Run QEMU with -vga none and -nic none
>        .gitlab-ci.d/buildtest.yml: Run full "make check" with --without-default-devices

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


