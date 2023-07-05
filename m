Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E227B748032
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 10:55:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGyGd-00065T-Pw; Wed, 05 Jul 2023 04:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGyGc-00064i-34
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 04:53:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGyGa-0006xH-IW
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 04:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688547219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JEyFUuSpxw2m67++RhGuJGOEC/oiC8glFPbfTSquf1M=;
 b=fEtTxe7PRK7Xzp/4mpzF7iB9BTeHpdT/d3Iz5otK8VNIeKY3k59jFumNFrxeJoV8MtjGBw
 vs/Fr0IGZpt5ukSOoHaAtVPZgOwrbE0/FwUwVertq6K6CKA6YytY3pCUjo/dHBN5LygQ7i
 aW2UIrdBHLvph81qQhCuA2xlexAOjv4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-znQSuRAwNWes5ZjNjW2OMA-1; Wed, 05 Jul 2023 04:53:37 -0400
X-MC-Unique: znQSuRAwNWes5ZjNjW2OMA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-765986c0521so548754485a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 01:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688547217; x=1691139217;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JEyFUuSpxw2m67++RhGuJGOEC/oiC8glFPbfTSquf1M=;
 b=E+ge8CzAFVYaTfpmgFgKdF3YZ7kQauIfUcpQV7XS4qkHnwEf5EtTw12v21S0Ubn2FG
 bQaMPksMfssaHlJ48kVFkzdSWfa4FmxZk8CGZhf4918zs+0pjr6a6f+pjz0sSPz4lCuT
 bEtji/rw8X/kyk5p/c2HK7iDoXTBqZgBNs7zzvUZLq3ptifu7g4Un+GCeG7wj3Igx+jY
 NWJggxBMO7qwlRhhDtnudgis61wAX4aJyRfLzmoRcrmmlufMwdtmDiFEp78aaEJ2kAJ+
 M9dzyIDBxj8+cvzprdAX5xUqPpF6jfftSj+ZhJ+8ITzyfJA0yqchInnob2u/LJxTSaUD
 oGIA==
X-Gm-Message-State: ABy/qLYfjsXN0GzFjqyoo2VBAfQhhRVm+faLf+HsWDrp7PnUjleURTpw
 gGMdv3Fav0Mjz4ldP6Cqp8xA+sxlBpXLteB0yuWj3VylG/RfEC4PntgNhujpMkdeGDrFidLMyE3
 6dKSXMvwBKL4s7dg=
X-Received: by 2002:a37:ef11:0:b0:767:35a:5f19 with SMTP id
 j17-20020a37ef11000000b00767035a5f19mr14196405qkk.14.1688547217372; 
 Wed, 05 Jul 2023 01:53:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5l+Up1PuHm9a+E1pNEtgMCCz4on7wAJIpTXcsQBkkWCgz0dkqS4GCRKF9kVD3pOGTuatoxSA==
X-Received: by 2002:a37:ef11:0:b0:767:35a:5f19 with SMTP id
 j17-20020a37ef11000000b00767035a5f19mr14196389qkk.14.1688547217126; 
 Wed, 05 Jul 2023 01:53:37 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a05620a01e900b00765f8e5ac7csm10127935qkn.48.2023.07.05.01.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 01:53:36 -0700 (PDT)
Message-ID: <eb088f47-6b16-d8fc-cddc-b3a8f0e53ffe@redhat.com>
Date: Wed, 5 Jul 2023 10:53:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-16-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v21 15/20] tests/avocado: s390x cpu topology polarisation
In-Reply-To: <20230630091752.67190-16-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 30/06/2023 11.17, Pierre Morel wrote:
> Polarization is changed on a request from the guest.
> Let's verify the polarization is accordingly set by QEMU.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   tests/avocado/s390_topology.py | 46 ++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
> 
> diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
> index 1758ec1f13..2cf731cb1d 100644
> --- a/tests/avocado/s390_topology.py
> +++ b/tests/avocado/s390_topology.py
> @@ -40,6 +40,7 @@ class S390CPUTopology(QemuSystemTest):
>       The polarization is changed on a request from the guest.
>       """
>       timeout = 90
> +    event_timeout = 1

When running tests in CI and the machines are very loaded, the tests can be 
stalled easily by multiple seconds. So using a timeout of 1 seconds sounds 
way too low for me. Please use at least 5 seconds, or maybe even 10.

>       KERNEL_COMMON_COMMAND_LINE = ('printk.time=0 '
>                                     'root=/dev/ram '
> @@ -99,6 +100,15 @@ def kernel_init(self):
>                            '-initrd', initrd_path,
>                            '-append', kernel_command_line)
>   
> +    def system_init(self):
> +        self.log.info("System init")
> +        exec_command(self, 'mount proc -t proc /proc')
> +        time.sleep(0.2)
> +        exec_command(self, 'mount sys -t sysfs /sys')
> +        time.sleep(0.2)

Hard coded sleeps are ugly... they are prone to race conditions (e.g. on 
loaded test systems), and they artificially slow down the test duration.

What about doing all three commands in one statement instead:

     exec_command_and_wait_for_pattern(self,
            """mount proc -t proc /proc ;
               mount sys -t sysfs /sys ;
               /bin/cat /sys/devices/system/cpu/dispatching""",
            '0')

?

> +        exec_command_and_wait_for_pattern(self,
> +                '/bin/cat /sys/devices/system/cpu/dispatching', '0')
> +
>       def test_single(self):
>           """
>           This test checks the simplest topology with a single CPU.
> @@ -194,3 +204,39 @@ def test_hotplug_full(self):
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
> +
> +
> +    def test_polarisation(self):
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
> +        res = self.vm.qmp('query-cpu-polarization')
> +        self.assertEqual(res['return']['polarization'], 'horizontal')
> +        self.check_topology(0, 0, 0, 0, 'medium', False)
> +
> +        self.guest_set_dispatching('1');
> +        res = self.vm.qmp('query-cpu-polarization')
> +        self.assertEqual(res['return']['polarization'], 'vertical')
> +        self.check_topology(0, 0, 0, 0, 'medium', False)
> +
> +        self.guest_set_dispatching('0');
> +        res = self.vm.qmp('query-cpu-polarization')
> +        self.assertEqual(res['return']['polarization'], 'horizontal')
> +        self.check_topology(0, 0, 0, 0, 'medium', False)


