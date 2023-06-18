Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E88D573448E
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 02:42:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAgTT-00069c-S1; Sat, 17 Jun 2023 20:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qianfanguijin@163.com>)
 id 1qAgTN-000691-Mo; Sat, 17 Jun 2023 20:40:53 -0400
Received: from m12.mail.163.com ([220.181.12.216])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qianfanguijin@163.com>)
 id 1qAgTI-00087r-54; Sat, 17 Jun 2023 20:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
 Content-Type; bh=I6TqtY4KPSoXZG8OJ1QcUnW+BY4AXr6VCSHCzkQy7og=;
 b=iRfRBfgubmmEPqiVlp8HUTq8BQcFOQO0mOTVezsXuWIMIQC+BwsDDxe5KDtB/g
 IsroFcwnjq8dEsPbFTSDi3p6PIcDF9D1jHXmuB1dURpTZflolrO7vS0HfjiNlcgp
 9R0cWRAWVbtNuoUJ6E7CAuTSBNQ8ZhX1qUWda9gyCM0TU=
Received: from [192.168.31.2] (unknown [27.216.213.168])
 by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wBXDSJ8Uo5knpLSAA--.32248S2;
 Sun, 18 Jun 2023 08:40:29 +0800 (CST)
Message-ID: <10cf3c5e-655d-fc8b-cf48-3949588c2dcf@163.com>
Date: Sun, 18 Jun 2023 08:40:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 01/11] hw: arm: Add bananapi M2-Ultra and allwinner-r40
 support
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20230523100508.32564-1-qianfanguijin@163.com>
 <20230523100508.32564-2-qianfanguijin@163.com>
 <41e71eae-72ad-410d-9cd8-cc495c06dac4@roeck-us.net>
From: qianfan <qianfanguijin@163.com>
In-Reply-To: <41e71eae-72ad-410d-9cd8-cc495c06dac4@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXDSJ8Uo5knpLSAA--.32248S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWkZr48AFy8ZryUtFW7XFb_yoW8Zw1fpr
 WY9an8Gay8Kr1Yy3W0qw48XrW5Wa1kWrWFgr98G3s5t3Z8Kr92vrySyws8Cay3uws09ayY
 yFWjya47u34DZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR5rcfUUUUU=
X-Originating-IP: [27.216.213.168]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/xtbBzgGS7WI0ZjFKjQAAs2
Received-SPF: pass client-ip=220.181.12.216;
 envelope-from=qianfanguijin@163.com; helo=m12.mail.163.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_BL=0.001,
 RCVD_IN_MSPIKE_L3=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


在 2023/6/18 0:29, Guenter Roeck 写道:
> Hi,
>
> On Tue, May 23, 2023 at 06:04:58PM +0800, qianfanguijin@163.com wrote:
>> From: qianfan Zhao <qianfanguijin@163.com>
>>
>> Allwinner R40 (sun8i) SoC features a Quad-Core Cortex-A7 ARM CPU,
>> and a Mali400 MP2 GPU from ARM. It's also known as the Allwinner T3
>> for In-Car Entertainment usage, A40i and A40pro are variants that
>> differ in applicable temperatures range (industrial and military).
>>
>> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
>> Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> I tried this in mainline linux with the following command.
>
> qemu-system-arm -M bpim2u \
> 	-kernel arch/arm/boot/zImage -no-reboot \
> 	-snapshot -drive file=rootfs-armv7a.ext2,format=raw,if=sd \
> 	-nic user \
> 	--append "root=/dev/mmcblk0 rootwait console=ttyS0,115200" \
> 	-dtb arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dtb \
> 	-nographic -monitor null -serial stdio
>
> Main problem is that the SD card gets instantiated randomly to
> mmc0, mmc1, or mmc2, making it all but impossible to specify a
> root file system device. The non-instantiated cards are always
> reported as non-removable, including mmc0. Example:
>
> mmc0: Failed to initialize a non-removable card
>
> Using "-sd <file>" instead of "-drive file=<file>" does not
> make a difference.
>
> I can fix (work around ?) the problem by adding the following information
> to the devicetree file.
>
>          aliases {
>                  ethernet0 = &gmac;
>                  serial0 = &uart0;
> +               mmc0 = &mmc0;
> +               mmc1 = &mmc1;
> +               mmc2 = &mmc2;
>          };
>
> Linux upstream commits fa2d0aa96941 and 2a43322ca7f3 describe the
> logic behind this change.
>
> Is this a bug in the Linux kernel, or a problem with the qemu emulation ?

On my work, the linux kenrel doesn't startup ext4 rootfs directly, it start

a custom ramdisk and we can handle this in ramdisk scripts.

> Either case, is there a way to specify a qemu command line that doesn't
> result in random assignments of the provided drive to mmc0/1/2 ?
>
> Thanks,
> Guenter


