Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56543797117
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 11:03:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeAuU-0000qi-2C; Thu, 07 Sep 2023 05:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeAuI-0000mt-Nd
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeAuE-0000ha-K8
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694077348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=czpo+vVdjPMhbuheVKdjBudl7WQGCPFRmrBAm3ysABI=;
 b=I+NUeV1HrDXrNPI2ilaY7WwKgzjt5hQ6INT+hGsiQ4gLGuf2DDnMjH6QekMNBS6W27AkoC
 wuAfKUnp3SvUV5TLJcqofFF4jIRFxhJdntkwGXLL2WH/35Fz/o3ms4bRE0BSK7b8ScHgpC
 AuW8vT1Fps29fqosVypnX4ITf5nkM0s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-ibeE773hPHaXjmJVvD-RMg-1; Thu, 07 Sep 2023 05:02:26 -0400
X-MC-Unique: ibeE773hPHaXjmJVvD-RMg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-402493d2997so4687865e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 02:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694077345; x=1694682145;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=czpo+vVdjPMhbuheVKdjBudl7WQGCPFRmrBAm3ysABI=;
 b=JKrjVXcSZ4aFV+3a9rql0FTOMkQFtN7RVXH9dAgCnIr9rzG05aOZkfOdm0Dp0xKM/a
 7tnOKh2e0Bc9OWzmmMOUon4Dtozuq2O87QsZbn1pneodLndReSvWsWiEwtPHmCC2xfv7
 jHQ+rH16wv8KhZ83X47hBPke8Fw8m0RipPN34pbDO29axfL5zGG0WVskkfhyPgJGPN5K
 xHjNggyJ6RjeB+ncMMkLY63EXZocIsbZ/zZOsmiUOZJwR0Pw0tRQrec4HVI9BXGU/xaO
 LVP0cPOBYIF726Cnxe5z9BHjaCL04a3OzDMMSCrpFDsvq26td8hi9EdvAavVHgZoQPlH
 o9Cg==
X-Gm-Message-State: AOJu0Ywn00x8BZW96OmXFKc1BtN3U/XiKbrltuSpTRjg3FOe5YT1xRLm
 1zkaBBYFB8y5Hd3fFeaPl3Jmixs/ClZaUD6i4eVt1sUzQXwkvnFSNprBsaTTMxnrICVdBpcLRFB
 Oqc1Mcjprb0OJePU=
X-Received: by 2002:a05:600c:4f44:b0:402:e6a2:c8c7 with SMTP id
 m4-20020a05600c4f4400b00402e6a2c8c7mr2719793wmq.7.1694077345625; 
 Thu, 07 Sep 2023 02:02:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBDimg0gaOB8J9HqRpUgrLa98Sooi0h4oNswVlri5pzxd/FYWxU3YF2ZYWv1L9h48QSiRKwg==
X-Received: by 2002:a05:600c:4f44:b0:402:e6a2:c8c7 with SMTP id
 m4-20020a05600c4f4400b00402e6a2c8c7mr2719754wmq.7.1694077345277; 
 Thu, 07 Sep 2023 02:02:25 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-5.web.vodafone.de. [109.43.176.5])
 by smtp.gmail.com with ESMTPSA id
 24-20020a05600c029800b003fbe4cecc3bsm1892594wmk.16.2023.09.07.02.02.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 02:02:24 -0700 (PDT)
Message-ID: <529821b9-71f1-a137-172a-e697feaf6abd@redhat.com>
Date: Thu, 7 Sep 2023 11:02:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v22 15/20] tests/avocado: s390x cpu topology polarization
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-16-nsg@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230901155812.2696560-16-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 01/09/2023 17.58, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> Polarization is changed on a request from the guest.
> Let's verify the polarization is accordingly set by QEMU.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   tests/avocado/s390_topology.py | 45 ++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
> index 3a54fe2e00..d7ee36cb89 100644
> --- a/tests/avocado/s390_topology.py
> +++ b/tests/avocado/s390_topology.py
> @@ -41,6 +41,7 @@ class S390CPUTopology(QemuSystemTest):
>       The polarization is changed on a request from the guest.
>       """
>       timeout = 90
> +    event_timeout = 10
>   
>       KERNEL_COMMON_COMMAND_LINE = ('printk.time=0 '
>                                     'root=/dev/ram '
> @@ -103,6 +104,14 @@ def kernel_init(self):
>                            '-initrd', initrd_path,
>                            '-append', kernel_command_line)
>   
> +    def system_init(self):
> +        self.log.info("System init")
> +        exec_command_and_wait_for_pattern(self,
> +                """ mount proc -t proc /proc;
> +                    mount sys -t sysfs /sys;
> +                    /bin/cat /sys/devices/system/cpu/dispatching """,

Is the /bin/ prefix really required here?

> +                    '0')
> +
>       def test_single(self):
>           """
>           This test checks the simplest topology with a single CPU.
> @@ -198,3 +207,39 @@ def test_hotplug_full(self):
>           self.check_topology(3, 1, 1, 1, 'high', False)
>           self.check_topology(4, 1, 1, 1, 'medium', False)
>           self.check_topology(5, 2, 1, 1, 'high', True)
> +
> +
> +    def guest_set_dispatching(self, dispatching):
> +        exec_command(self,
> +                f'echo {dispatching} > /sys/devices/system/cpu/dispatching')
> +        self.vm.event_wait('CPU_POLARIZATION_CHANGE', self.event_timeout)
> +        exec_command_and_wait_for_pattern(self,
> +                '/bin/cat /sys/devices/system/cpu/dispatching', dispatching)

dito?

> +
> +    def test_polarization(self):
> +        """
> +        This test verifies that QEMU modifies the entitlement change after
> +        several guest polarization change requests.
> +
> +        :avocado: tags=arch:s390x
> +        :avocado: tags=machine:s390-ccw-virtio
> +        """
> +        self.kernel_init()
> +        self.vm.launch()
> +        self.wait_until_booted()
> +
> +        self.system_init()
> +        res = self.vm.qmp('query-s390x-cpu-polarization')
> +        self.assertEqual(res['return']['polarization'], 'horizontal')
> +        self.check_topology(0, 0, 0, 0, 'medium', False)
> +
> +        self.guest_set_dispatching('1');
> +        res = self.vm.qmp('query-s390x-cpu-polarization')
> +        self.assertEqual(res['return']['polarization'], 'vertical')
> +        self.check_topology(0, 0, 0, 0, 'medium', False)
> +
> +        self.guest_set_dispatching('0');
> +        res = self.vm.qmp('query-s390x-cpu-polarization')
> +        self.assertEqual(res['return']['polarization'], 'horizontal')
> +        self.check_topology(0, 0, 0, 0, 'medium', False)

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>


