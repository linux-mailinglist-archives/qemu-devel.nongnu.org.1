Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4099C75F82D
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:24:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvXi-0002XE-FD; Mon, 24 Jul 2023 09:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qNvXe-0002Wr-Nk
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qNvXd-00072f-1Z
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690205039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8OFr16gdY6ZaPBtVaWV/96ym/jxb/lzao24AL0W+UvA=;
 b=WnP8sVAZcOng3+kQPikepGqtuRY8h9A5A+ceivAchzKZdfYMO266c1YYdhjzedqds7mugA
 9hKAOimLg29ewOnbT0uKxgy8iC//hXkZAb9kb8J1LoH1CulInUT3fZmoAfh+MeHMbW1o4c
 fbLwGEhcQW1Z7qLl8pCp7cgPE/LxySM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-SAMLBneSMQyYk9r666aMYw-1; Mon, 24 Jul 2023 09:23:58 -0400
X-MC-Unique: SAMLBneSMQyYk9r666aMYw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-765ab532883so619852785a.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 06:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690205037; x=1690809837;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8OFr16gdY6ZaPBtVaWV/96ym/jxb/lzao24AL0W+UvA=;
 b=BV8FE3vKrt3gA4SGwvxoCdEhOMcNqVsRwfanlVKfCB0tnAfGytBaEV2Ijg0Wd9KM7a
 7qDIZ0P6w9dDTKFJ3FIrxAuftknsbsYRAFgA/NFswa5X9uUTh8YvrU9Hce22qDAYNepc
 SkJI3cY9XmSUJInskyYykua9TdmnmRJJn6Gw1x6zw9wUJwssHTn+Pm6DSpFEC2svNiZC
 dsZRXbT/03JxRTyoBQWuuYKcDqMRiFd5a7HJW7TaFJJx6Rm+aErsL9IfIX61J5y3UPLg
 5ihGN3FOEjTOSd0d/yclq+A1aeofm56oHR+/Pd8K+ozfdr43uO/vf3CHGXHaNJu1rHsc
 1Z4A==
X-Gm-Message-State: ABy/qLa4pOHu1x9cdgNb7lWjbUIAxuytjiqr3H3tqFZn2bygbq2BeNLh
 1zECRNKMhhkKQikBq7AfxGP/zkp/eT1Wxhkd5YT33ehJA5P1h3QjqcKZUTIyOnkeqjqMMTejZ67
 w1KqP7sPqGB11+5I=
X-Received: by 2002:a05:620a:2956:b0:767:27c8:968d with SMTP id
 n22-20020a05620a295600b0076727c8968dmr11502711qkp.6.1690205037662; 
 Mon, 24 Jul 2023 06:23:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHltPoEfVvfhOB7giyJbyc/f+ppmdlCsgbeyg6FVVe2Gnq2DhlQbnjdTipo+3p1Bg7OFnssrw==
X-Received: by 2002:a05:620a:2956:b0:767:27c8:968d with SMTP id
 n22-20020a05620a295600b0076727c8968dmr11502694qkp.6.1690205037389; 
 Mon, 24 Jul 2023 06:23:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:9283:b79f:cbb3:327a?
 ([2a01:e0a:9e2:9000:9283:b79f:cbb3:327a])
 by smtp.gmail.com with ESMTPSA id
 g2-20020a05620a108200b00767b07ec8adsm2983283qkk.82.2023.07.24.06.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 06:23:57 -0700 (PDT)
Message-ID: <144f34b9-c465-0607-15a6-d3114561c04d@redhat.com>
Date: Mon, 24 Jul 2023 15:23:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tests/avocado/machine_s390_ccw_virtio: Skip the flaky
 virtio-gpu test by default
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20230724084851.24251-1-thuth@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230724084851.24251-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 7/24/23 10:48, Thomas Huth wrote:
> The virtio-gpu test is known to be flaky - that's why we also did
> not enable the test_s390x_fedora in the gitlab CI. However, a flaky
> test can also be annoying when testing locally, so let's rather skip
> this subtest by default and start running the test_s390x_fedora test
> in the gitlab CI again (since the other things that are tested here
> are quite valuable).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   tests/avocado/machine_s390_ccw_virtio.py | 51 +++++++++++++-----------
>   1 file changed, 27 insertions(+), 24 deletions(-)
> 
> diff --git a/tests/avocado/machine_s390_ccw_virtio.py b/tests/avocado/machine_s390_ccw_virtio.py
> index 78152f2ad1..e7a2a20ba6 100644
> --- a/tests/avocado/machine_s390_ccw_virtio.py
> +++ b/tests/avocado/machine_s390_ccw_virtio.py
> @@ -159,7 +159,6 @@ def test_s390x_devices(self):
>                                             'MemTotal:         115640 kB')
>   
>   
> -    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>       def test_s390x_fedora(self):
>   
>           """
> @@ -229,31 +228,35 @@ def test_s390x_fedora(self):
>           # writing to the framebuffer. Since the PPM is uncompressed, we then
>           # can simply read the written "magic bytes" back from the PPM file to
>           # check whether the framebuffer is working as expected.
> -        self.log.info("Test screendump of virtio-gpu device")
> -        exec_command_and_wait_for_pattern(self,
> +        # Unfortunately, this test is flaky, so we don't run it by default
> +        if os.getenv('QEMU_TEST_FLAKY_TESTS'):
> +            self.log.info("Test screendump of virtio-gpu device")
> +            exec_command_and_wait_for_pattern(self,
>                           'while ! (dmesg | grep gpudrmfb) ; do sleep 1 ; done',
>                           'virtio_gpudrmfb frame buffer device')
> -        exec_command_and_wait_for_pattern(self,
> -            'echo -e "\e[?25l" > /dev/tty0', ':/#')
> -        exec_command_and_wait_for_pattern(self, 'for ((i=0;i<250;i++)); do '
> -            'echo " The  qu ick  fo x j ump s o ver  a  laz y d og" >> fox.txt;'
> -            'done',
> -            ':/#')
> -        exec_command_and_wait_for_pattern(self,
> -            'dd if=fox.txt of=/dev/fb0 bs=1000 oflag=sync,nocache ; rm fox.txt',
> -            '12+0 records out')
> -        with tempfile.NamedTemporaryFile(suffix='.ppm',
> -                                         prefix='qemu-scrdump-') as ppmfile:
> -            self.vm.command('screendump', filename=ppmfile.name)
> -            ppmfile.seek(0)
> -            line = ppmfile.readline()
> -            self.assertEqual(line, b"P6\n")
> -            line = ppmfile.readline()
> -            self.assertEqual(line, b"1280 800\n")
> -            line = ppmfile.readline()
> -            self.assertEqual(line, b"255\n")
> -            line = ppmfile.readline(256)
> -            self.assertEqual(line, b"The quick fox jumps over a lazy dog\n")
> +            exec_command_and_wait_for_pattern(self,
> +                'echo -e "\e[?25l" > /dev/tty0', ':/#')
> +            exec_command_and_wait_for_pattern(self, 'for ((i=0;i<250;i++)); do '
> +                'echo " The  qu ick  fo x j ump s o ver  a  laz y d og" >> fox.txt;'
> +                'done',
> +                ':/#')
> +            exec_command_and_wait_for_pattern(self,
> +                'dd if=fox.txt of=/dev/fb0 bs=1000 oflag=sync,nocache ; rm fox.txt',
> +                '12+0 records out')
> +            with tempfile.NamedTemporaryFile(suffix='.ppm',
> +                                             prefix='qemu-scrdump-') as ppmfile:
> +                self.vm.command('screendump', filename=ppmfile.name)
> +                ppmfile.seek(0)
> +                line = ppmfile.readline()
> +                self.assertEqual(line, b"P6\n")
> +                line = ppmfile.readline()
> +                self.assertEqual(line, b"1280 800\n")
> +                line = ppmfile.readline()
> +                self.assertEqual(line, b"255\n")
> +                line = ppmfile.readline(256)
> +                self.assertEqual(line, b"The quick fox jumps over a lazy dog\n")
> +        else:
> +            self.log.info("Skipped flaky screendump of virtio-gpu device test")
>   
>           # Hot-plug a virtio-crypto device and see whether it gets accepted
>           self.log.info("Test hot-plug virtio-crypto device")


