Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 693C2742506
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 13:36:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpwG-0001AK-Mj; Thu, 29 Jun 2023 07:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEpwE-0001A4-SH
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEpwC-0003vq-QC
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688038547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dAAExhketPUizSM1YvAVgwKqizEKZFdMPLWYFAA8tkE=;
 b=NRNRZqQnUXxiqO3iuv+EX/JI4AcDfT3TLfdSiAuwhcZ2ol4M+Rc4TjR+iq0koU4xdbfzTS
 fT2LSHs9j89EF4rTxUXbLlDW2ZHYU06UdD67m6WUCXT1ksVaUgMKHba64UuDkfMgoEW3rP
 zjz0NDOyPqCAN4VNKHD02IEAyEZSvr4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-xQJdMdAsOIWc3zgTtZPMOg-1; Thu, 29 Jun 2023 07:35:46 -0400
X-MC-Unique: xQJdMdAsOIWc3zgTtZPMOg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f8727c7fb6so682701e87.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 04:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688038545; x=1690630545;
 h=content-transfer-encoding:in-reply-to:subject:from:cc:references:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dAAExhketPUizSM1YvAVgwKqizEKZFdMPLWYFAA8tkE=;
 b=IvxqViGJSRJOeFQXwvr++m0Rad9u84S1DheEYOOhFWp6e7bse9O+Yv7F+DV6mEH5qc
 ECHmjyDFciF9iCB6abn4CHK1YSzHtC3mzllaIf0WmgytG+DtVYEsa7o37W3y6D3xY4Bq
 X/mJY2zs77CxpgBhxMr4nu1gijxB8cYnkWJbeHEaA89kK6qmc7/rKG3VMYh1f3JoCmTA
 oOGiJwZzZqptU/559DqP6oIna4FwHdmMLQciyxKZ9Q7o4JVYav38fY4qCe74vdWbD9YM
 KxjPhbsIOuQp+QtrJOy7oQym+OkTZAmZSw5XFaD8144h+LKbH8RH9GMga+p+Azr9fJAl
 Il6w==
X-Gm-Message-State: AC+VfDwy/MvjLpySuFHIp1oHlmXW3CfIPX5OPTsUOJN7NhDt8WjflavX
 Q+UC10hn04VdD6hTRNRorPAN6C1XMq4g+2T39NYlAP1XeeMU6EyVx52zx+IycoOJx/TBQoCjxuF
 ib4KViJwmx7CrCRoq2NbOI8g=
X-Received: by 2002:a19:6909:0:b0:4f8:71bf:8b93 with SMTP id
 e9-20020a196909000000b004f871bf8b93mr18001331lfc.6.1688038544858; 
 Thu, 29 Jun 2023 04:35:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6upXNn65BseiUJeBjJy0DLYJwQGG3wsoNu8UYpFb53alZ2q353PXOq7gxLqAXY/Fc5xjLBNQ==
X-Received: by 2002:a19:6909:0:b0:4f8:71bf:8b93 with SMTP id
 e9-20020a196909000000b004f871bf8b93mr18001319lfc.6.1688038544514; 
 Thu, 29 Jun 2023 04:35:44 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d590a000000b0030631a599a0sm15610710wrd.24.2023.06.29.04.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 04:35:43 -0700 (PDT)
Message-ID: <280c57d2-9648-36ea-74e9-6ffc7f3b4388@redhat.com>
Date: Thu, 29 Jun 2023 13:35:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qianfan Zhao <qianfanguijin@163.com>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
 <20230606094814.3581397-19-peter.maydell@linaro.org>
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 18/42] tests: avocado: boot_linux_console: Add test case
 for bpim2u
In-Reply-To: <20230606094814.3581397-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 06/06/2023 11.47, Peter Maydell wrote:
> From: qianfan Zhao <qianfanguijin@163.com>
> 
> Add test case for booting from initrd and sd card.
> 
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/avocado/boot_linux_console.py | 176 ++++++++++++++++++++++++++++
>   1 file changed, 176 insertions(+)
...
> +    def test_arm_bpim2u_gmac(self):
> +        """
> +        :avocado: tags=arch:arm
> +        :avocado: tags=accel:tcg
> +        :avocado: tags=machine:bpim2u
> +        :avocado: tags=device:sd
> +        """
> +        self.require_netdev('user')
> +
> +        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
> +                   'linux-image-current-sunxi_21.02.2_armhf.deb')
> +        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        kernel_path = self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinuz-5.10.16-sunxi')
> +        dtb_path = ('/usr/lib/linux-image-current-sunxi/'
> +                    'sun8i-r40-bananapi-m2-ultra.dtb')
> +        dtb_path = self.extract_from_deb(deb_path, dtb_path)
> +        rootfs_url = ('http://storage.kernelci.org/images/rootfs/buildroot/'
> +                      'buildroot-baseline/20221116.0/armel/rootfs.ext2.xz')
> +        rootfs_hash = 'fae32f337c7b87547b10f42599acf109da8b6d9a'
> +        rootfs_path_xz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
> +        rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
> +        archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
> +        image_pow2ceil_expand(rootfs_path)
> +
> +        self.vm.set_console()
> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=ttyS0,115200 '
> +                               'root=/dev/mmcblk0 rootwait rw '
> +                               'panic=-1 noreboot')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-drive', 'file=' + rootfs_path + ',if=sd,format=raw',
> +                         '-net', 'nic,model=gmac,netdev=host_gmac',
> +                         '-netdev', 'user,id=host_gmac',
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        shell_ready = "/bin/sh: can't access tty; job control turned off"
> +        self.wait_for_console_pattern(shell_ready)
> +
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
> +                                                'Allwinner sun8i Family')
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
> +                                                'mmcblk0')
> +        exec_command_and_wait_for_pattern(self, 'ifconfig eth0 up',
> +                                                 'eth0: Link is Up')
> +        exec_command_and_wait_for_pattern(self, 'udhcpc eth0',
> +            'udhcpc: lease of 10.0.2.15 obtained')
> +        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2',
> +            '3 packets transmitted, 3 packets received, 0% packet loss')
> +        exec_command_and_wait_for_pattern(self, 'reboot',
> +                                                'reboot: Restarting system')
> +        # Wait for VM to shut down gracefully
> +        self.vm.wait()

FYI, the test_arm_bpim2u_gmac test just failed during one of my CI runs:

https://gitlab.com/thuth/qemu/-/jobs/4565108610#L300

Looking at the debug.log in the artifacts, it looks like the kernel was 
hanging during boot:

10:53:56 DEBUG| of_cfs_init
10:53:56 DEBUG| of_cfs_init: OK
10:53:56 DEBUG| ALSA device list:
10:53:56 DEBUG| No soundcards found.
10:53:56 DEBUG| Waiting for root device /dev/mmcblk0...
10:54:26 DEBUG| dcdc4: disabling
10:54:26 DEBUG| dc5ldo: disabling
10:54:26 DEBUG| vcc5v0: disabling
10:55:15 ERROR|
...
10:55:15 ERROR| RuntimeError: Test interrupted by SIGTERM

I can reproduce the problem locally on my laptop when running the test 
repeatedly, e.g. with:

  make check-venv
  for ((x=0;x<10;x++)); do \
   ./tests/venv/bin/avocado run \
     tests/avocado/boot_linux_console.py:test_arm_bpim2u_gmac ; \
  done

1 out of 10 runs were failing.

Any ideas what could be wrong in those failing cases?

  Thomas


