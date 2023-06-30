Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F25037437B2
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:46:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF9lE-0004AY-0t; Fri, 30 Jun 2023 04:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qianfanguijin@163.com>)
 id 1qF9l5-0004AK-5g
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:45:39 -0400
Received: from m12.mail.163.com ([220.181.12.199])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qianfanguijin@163.com>) id 1qF9kz-0005Ee-RC
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
 Content-Type; bh=KhnzPWZK7I9Uzd8AGDscVG44H5aPT9pNm2+NvWEQUOY=;
 b=lgQHdoaU43o5iixwBTVeEsnRGmRnxzoRJLYgdvYGIFPpEEVIzHhw6POqQl8bAQ
 bkpDs/MMnuLMmiD3ERynNIn8dzXOZEszLxD8Fw4Nly1YyDihUzLFg0wOrxaOLE5J
 JgXR9H4/QuOMvBiy+Xa+fGoiLKe2QRoIjpocBhKQG7fM8=
Received: from [172.21.25.67] (unknown [218.201.129.20])
 by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wCHNfIilp5kGKfbBA--.61421S2;
 Fri, 30 Jun 2023 16:45:23 +0800 (CST)
Message-ID: <f7d5a8eb-cd7f-e0f5-91cc-4b3840b5de2c@163.com>
Date: Fri, 30 Jun 2023 16:45:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 18/42] tests: avocado: boot_linux_console: Add test case
 for bpim2u
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
 <20230606094814.3581397-19-peter.maydell@linaro.org>
 <280c57d2-9648-36ea-74e9-6ffc7f3b4388@redhat.com>
 <b954eaad-508c-2341-eaeb-8ec4111de664@163.com>
 <4f749512-a395-40e4-c20e-ed4928c2cb87@redhat.com>
Content-Language: en-US
From: qianfan <qianfanguijin@163.com>
In-Reply-To: <4f749512-a395-40e4-c20e-ed4928c2cb87@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHNfIilp5kGKfbBA--.61421S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr17ZF1rCw1DAF1kZryUAwb_yoW3GF1xpr
 WUJF1jkFW8JF15Jr1Sga4jqr9xtw10ka43Wr9rCr1ruF4qy3s3JF4Ikr4F9rykZws2kas5
 ZFZ0qa4xWw45A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKJPiUUUUU=
X-Originating-IP: [218.201.129.20]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiQgSe7VaEF1HOogAAsN
Received-SPF: pass client-ip=220.181.12.199;
 envelope-from=qianfanguijin@163.com; helo=m12.mail.163.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



在 2023/6/30 15:27, Thomas Huth 写道:
> On 30/06/2023 08.15, qianfan wrote:
>>
>>
>> 在 2023/6/29 19:35, Thomas Huth 写道:
>>> On 06/06/2023 11.47, Peter Maydell wrote:
>>>> From: qianfan Zhao <qianfanguijin@163.com>
>>>>
>>>> Add test case for booting from initrd and sd card.
>>>>
>>>> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
>>>> Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>>>> Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>> ---
>>>>   tests/avocado/boot_linux_console.py | 176 
>>>> ++++++++++++++++++++++++++++
>>>>   1 file changed, 176 insertions(+)
>>> ...
>>>> +    def test_arm_bpim2u_gmac(self):
>>>> +        """
>>>> +        :avocado: tags=arch:arm
>>>> +        :avocado: tags=accel:tcg
>>>> +        :avocado: tags=machine:bpim2u
>>>> +        :avocado: tags=device:sd
>>>> +        """
>>>> +        self.require_netdev('user')
>>>> +
>>>> +        deb_url = 
>>>> ('https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
>>>> + 'linux-image-current-sunxi_21.02.2_armhf.deb')
>>>> +        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
>>>> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>>>> +        kernel_path = self.extract_from_deb(deb_path,
>>>> + '/boot/vmlinuz-5.10.16-sunxi')
>>>> +        dtb_path = ('/usr/lib/linux-image-current-sunxi/'
>>>> +                    'sun8i-r40-bananapi-m2-ultra.dtb')
>>>> +        dtb_path = self.extract_from_deb(deb_path, dtb_path)
>>>> +        rootfs_url = 
>>>> ('http://storage.kernelci.org/images/rootfs/buildroot/'
>>>> + 'buildroot-baseline/20221116.0/armel/rootfs.ext2.xz')
>>>> +        rootfs_hash = 'fae32f337c7b87547b10f42599acf109da8b6d9a'
>>>> +        rootfs_path_xz = self.fetch_asset(rootfs_url, 
>>>> asset_hash=rootfs_hash)
>>>> +        rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
>>>> +        archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
>>>> +        image_pow2ceil_expand(rootfs_path)
>>>> +
>>>> +        self.vm.set_console()
>>>> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
>>>> +                               'console=ttyS0,115200 '
>>>> +                               'root=/dev/mmcblk0 rootwait rw '
>>>> +                               'panic=-1 noreboot')
>>>> +        self.vm.add_args('-kernel', kernel_path,
>>>> +                         '-dtb', dtb_path,
>>>> +                         '-drive', 'file=' + rootfs_path + 
>>>> ',if=sd,format=raw',
>>>> +                         '-net', 'nic,model=gmac,netdev=host_gmac',
>>>> +                         '-netdev', 'user,id=host_gmac',
>>>> +                         '-append', kernel_command_line,
>>>> +                         '-no-reboot')
>>>> +        self.vm.launch()
>>>> +        shell_ready = "/bin/sh: can't access tty; job control 
>>>> turned off"
>>>> +        self.wait_for_console_pattern(shell_ready)
>>>> +
>>>> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
>>>> +                                                'Allwinner sun8i 
>>>> Family')
>>>> +        exec_command_and_wait_for_pattern(self, 'cat 
>>>> /proc/partitions',
>>>> +                                                'mmcblk0')
>>>> +        exec_command_and_wait_for_pattern(self, 'ifconfig eth0 up',
>>>> +                                                 'eth0: Link is Up')
>>>> +        exec_command_and_wait_for_pattern(self, 'udhcpc eth0',
>>>> +            'udhcpc: lease of 10.0.2.15 obtained')
>>>> +        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2',
>>>> +            '3 packets transmitted, 3 packets received, 0% packet 
>>>> loss')
>>>> +        exec_command_and_wait_for_pattern(self, 'reboot',
>>>> +                                                'reboot: 
>>>> Restarting system')
>>>> +        # Wait for VM to shut down gracefully
>>>> +        self.vm.wait()
>>>
>>> FYI, the test_arm_bpim2u_gmac test just failed during one of my CI 
>>> runs:
>>>
>>> https://gitlab.com/thuth/qemu/-/jobs/4565108610#L300
>>>
>>> Looking at the debug.log in the artifacts, it looks like the kernel 
>>> was hanging during boot:
>>>
>>> 10:53:56 DEBUG| of_cfs_init
>>> 10:53:56 DEBUG| of_cfs_init: OK
>>> 10:53:56 DEBUG| ALSA device list:
>>> 10:53:56 DEBUG| No soundcards found.
>>> 10:53:56 DEBUG| Waiting for root device /dev/mmcblk0...
>>> 10:54:26 DEBUG| dcdc4: disabling
>>> 10:54:26 DEBUG| dc5ldo: disabling
>>> 10:54:26 DEBUG| vcc5v0: disabling
>>> 10:55:15 ERROR|
>>> ...
>>> 10:55:15 ERROR| RuntimeError: Test interrupted by SIGTERM
>>>
>>> I can reproduce the problem locally on my laptop when running the 
>>> test repeatedly, e.g. with:
>>>
>>>  make check-venv
>>>  for ((x=0;x<10;x++)); do \
>>>   ./tests/venv/bin/avocado run \
>>>     tests/avocado/boot_linux_console.py:test_arm_bpim2u_gmac ; \
>>>  done
>>>
>>> 1 out of 10 runs were failing.
>>>
>>> Any ideas what could be wrong in those failing cases?
>> Hi:
>>
>> I can reproduce this issue based on master 
>> code(v8.0.0-rc1-2442-g4d541f63e9) with your's
>> test scripts, and I have tested 50 times only failed once.
>>
>> Copy liunx boot logs and make a diff:
>>
>> $ diff ~/a/qemu_bpi_good.txt ~/a/qemu_bpi_bad.txt
> ...
>> 288a289,291
>>  > mmc1: host does not support reading read-only switch, assuming 
>> write-enable
>>  > mmc1: new high speed SD card at address 4567
>>  > mmcblk1: mmc1:4567 QEMU! 64.0 MiB
>> 296,298d298
>> < mmc0: host does not support reading read-only switch, assuming 
>> write-enable
>> < mmc0: new high speed SD card at address 4567
>> < mmcblk0: mmc0:4567 QEMU! 64.0 MiB
>> 322,331c322,325
>> < EXT4-fs (mmcblk0): mounting ext2 file system using the ext4 subsystem
>> < EXT4-fs (mmcblk0): mounted filesystem without journal. Opts: (null)
>> < VFS: Mounted root (ext2 filesystem) on device 179:0.
>> < devtmpfs: mounted
>> < Freeing unused kernel memory: 1024K
>> < Run /sbin/init as init process
>> < EXT4-fs (mmcblk0): re-mounted. Opts: (null)
>> < Starting syslogd: OK
>> < Starting klogd: OK
>> < Running sysctl: OK
>> \ No newline at end of file
>> ---
>>  > Waiting for root device /dev/mmcblk0...
>>  > dcdc4: disabling
>>  > dc5ldo: disabling
>>  > vcc5v0: disabling
>> \ No newline at end of file
>>
>> The first mmc device should be mmc0, but the linux kernel named it as 
>> mmcblk1.
>> So it always 'Waiting for root device /dev/mmcblk0...', that make the 
>> rootfs
>> can not mounted.
>>
>> I'm not make sure where the problem came from.
>
> Oh, that's ugly, I think the problem is likely that the numbering
> of device names that are directly in /dev/ is never guaranteed by
> the Linux kernel.
>
> Could you please try whether this work more reliably for you
> instead:
>
> diff a/tests/avocado/boot_linux_console.py 
> b/tests/avocado/boot_linux_console.py
> --- a/tests/avocado/boot_linux_console.py
> +++ b/tests/avocado/boot_linux_console.py
> @@ -869,7 +869,7 @@ def test_arm_bpim2u_gmac(self):
>          self.vm.set_console()
>          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
>                                 'console=ttyS0,115200 '
> -                               'root=/dev/mmcblk0 rootwait rw '
> +                               'root=b300 rootwait rw '
>                                 'panic=-1 noreboot')
>          self.vm.add_args('-kernel', kernel_path,
>                           '-dtb', dtb_path,
>
> ?
Yes, this patch is useful.

The rootfs can mount successful even if the mmc block enumed as mmcblk1, 
next is the
kernel logs:

mmc1: new high speed SD card at address 4567
mmcblk1: mmc1:4567 QEMU! 64.0 MiB
EXT4-fs (mmcblk1): mounting ext2 file system using the ext4 subsystem
EXT4-fs (mmcblk1): mounted filesystem without journal. Opts: (null)
VFS: Mounted root (ext2 filesystem) on device 179:0.

But the test scripts still fail due to it always waiting mmc0blk:

     exec_command_and_wait_for_pattern(self, 'cat /proc/partitions', 
'mmcblk0')

Could you please explain where is the "b300" come from?

Thanks.
>
>  Thomas


