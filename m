Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8E475A97E
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 10:41:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMPD1-0000He-Dv; Thu, 20 Jul 2023 04:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qMPCp-0000HS-PG
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 04:40:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qMPCn-0008Li-GT
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 04:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689842412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NrE7o2NHxb1vlzM1/PIWKl3Q3cb4YEUSDoCgv7uXYBM=;
 b=C4TGOPrfu0V4i1jUYDK1t36GrIC21zfW/wKhPSU8IJudZWlaZ0hj5Ki2GpsJHmvDCoHerR
 0dQqjqqdLMRpdIzWVzzHrNGPbQ2A20+fJY7BoL+rsuBKAF8P5zCuscCOOORaWGyWZbnKNM
 ObKfvnE/uY26st4n/xHpn3GXVKhtlM0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-9l7ZnkwkN0Gir8mFqcLOog-1; Thu, 20 Jul 2023 04:40:11 -0400
X-MC-Unique: 9l7ZnkwkN0Gir8mFqcLOog-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31455dcc30eso368571f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 01:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689842410; x=1692434410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NrE7o2NHxb1vlzM1/PIWKl3Q3cb4YEUSDoCgv7uXYBM=;
 b=Rrhtj/EXoHS/r+yQBHaU85Rr7dzvgFSkJAGmgjprZDtmme3lOVe5WLs2Y+mIIKqxVN
 Cv2sGMFYz64trlr50Z968JrshhI/zDydpCQMoqIXt5LI+tztqv/duVeIoaUi4n2EfN0V
 YZkQxXB7tFxH57qgwJSaKh3f2IYmUYebSe8EZa5Ct9CqIZI2BP4U6uqKi13EP1v+1lYM
 ghTKA++Gj8+Fkpk998lkp9n3w/BZCyF3q3IjpMQm9l5bWecgIcC9kiU/qdrDzwTrJ2cX
 yYnb/Tu2frQpv1urGLTOsZmJ25j6UE3I+/abulxqt+nRoIayJ0u5vF04+UeTYrY0AtbY
 qanA==
X-Gm-Message-State: ABy/qLb0JFpTx+n0hXkahylTdbz55LesDLftSh2cQfDnZjUT/JqZYDr2
 SYXEKOBo9Wp4uxh+wbcZFG4OpgkffBIneCWFPQdJLLJKReczSLDwssGfIorB9YTPlfriQhs+3Jl
 LMmgdIcBgU2GiasM=
X-Received: by 2002:a5d:61ce:0:b0:314:545b:4f3 with SMTP id
 q14-20020a5d61ce000000b00314545b04f3mr1641768wrv.36.1689842410018; 
 Thu, 20 Jul 2023 01:40:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFhYE+jQMbRGxEz3a/q0lp9wQzcTMKkH+eaObUMCCrg1Dp4twBuFk2ot3jwUXUjkmJUsyRJvg==
X-Received: by 2002:a5d:61ce:0:b0:314:545b:4f3 with SMTP id
 q14-20020a5d61ce000000b00314545b04f3mr1641746wrv.36.1689842409256; 
 Thu, 20 Jul 2023 01:40:09 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 i7-20020a05600011c700b00313fd294d6csm660834wrx.7.2023.07.20.01.40.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jul 2023 01:40:08 -0700 (PDT)
Message-ID: <3d058944-263d-adb3-8f76-e64388574b48@redhat.com>
Date: Thu, 20 Jul 2023 10:40:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 10/66] tests/qtest: enable tests for virtio-scmi
Content-Language: en-US
To: Milan Zamazal <mzamazal@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <cover.1689030052.git.mst@redhat.com>
 <b6f53ae005a1c05034769beebf799e861b82d48a.1689030052.git.mst@redhat.com>
 <22589b2f-8dcf-b86b-2d77-bf27bf81ce27@redhat.com> <87pm4pcrbe.fsf@redhat.com>
 <373f7d28-788b-99d1-1606-b73db45720c1@redhat.com> <87mszrptes.fsf@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <87mszrptes.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 19/07/2023 21.56, Milan Zamazal wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 18/07/2023 14.55, Milan Zamazal wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>
>>>> On 11/07/2023 01.02, Michael S. Tsirkin wrote:
>>>>> From: Milan Zamazal <mzamazal@redhat.com>
>>>>> We don't have a virtio-scmi implementation in QEMU and only support
>>>>
>>>>> a
>>>>> vhost-user backend.  This is very similar to virtio-gpio and we add the same
>>>>> set of tests, just passing some vhost-user messages over the control socket.
>>>>> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
>>>>> Acked-by: Thomas Huth <thuth@redhat.com>
>>>>> Message-Id: <20230628100524.342666-4-mzamazal@redhat.com>
>>>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> ---
>>>>>     tests/qtest/libqos/virtio-scmi.h |  34 ++++++
>>>>>     tests/qtest/libqos/virtio-scmi.c | 174 +++++++++++++++++++++++++++++++
>>>>>     tests/qtest/vhost-user-test.c    |  44 ++++++++
>>>>>     MAINTAINERS                      |   1 +
>>>>>     tests/qtest/libqos/meson.build   |   1 +
>>>>>     5 files changed, 254 insertions(+)
>>>>>     create mode 100644 tests/qtest/libqos/virtio-scmi.h
>>>>>     create mode 100644 tests/qtest/libqos/virtio-scmi.c
>>>>
>>>>    Hi!
>>>>
>>>> I'm seeing some random failures with this new scmi test, so far only
>>>> on non-x86 systems, e.g.:
>>>>
>>>>    https://app.travis-ci.com/github/huth/qemu/jobs/606246131#L4774
>>>>
>>>> It also reproduces on a s390x host here, but only if I run "make check
>>>> -j$(nproc)" - if I run the tests single-threaded, the qos-test passes
>>>> there. Seems like there is a race somewhere in this test?
>>> Hmm, it's basically the same as virtio-gpio.c test, so it should be
>>> OK.
>>> Is it possible that the two tests (virtio-gpio.c & virtio-scmi.c)
>>> interfere with each other in some way?  Is there possibly a way to
>>> serialize them to check?
>>
>> I think within one qos-test, the sub-tests are already run
>> serialized.
> 
> I see, OK.
> 
>> But there might be multiple qos-tests running in parallel, e.g. one
>> for the aarch64 target and one for the ppc64 target. And indeed, I can
>> reproduce the problem on my x86 laptop by running this in one terminal
>> window:
>>
>> for ((x=0;x<1000;x++)); do \
>>   QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon \
>>   G_TEST_DBUS_DAEMON=.tests/dbus-vmstate-daemon.sh \
>>   QTEST_QEMU_BINARY=./qemu-system-ppc64 \
>>   MALLOC_PERTURB_=188 QTEST_QEMU_IMG=./qemu-img \
>>   tests/qtest/qos-test -p \
>>   /ppc64/pseries/spapr-pci-host-bridge/pci-bus-spapr/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile
>> \
>>   || break ; \
>> done
>>
>> And this in another terminal window at the same time:
>>
>> for ((x=0;x<1000;x++)); do \
>>   QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon \
>>   G_TEST_DBUS_DAEMON=.tests/dbus-vmstate-daemon.sh \
>>   QTEST_QEMU_BINARY=./qemu-system-aarch64 \
>>   MALLOC_PERTURB_=188 QTEST_QEMU_IMG=./qemu-img \
>>   tests/qtest/qos-test -p \
>>   /aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile
>> \
>>   || break ; \
>> done
>>
>> After a while, the aarch64 test broke with:
>>
>> /aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile:
>> qemu-system-aarch64: Failed to set msg fds.
>> qemu-system-aarch64: Failed to set msg fds.
>> qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
>> qemu-system-aarch64: Failed to set msg fds.
>> qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
>> qemu-system-aarch64: Failed to set msg fds.
>> qemu-system-aarch64: vhost_set_vring_call failed 22
>> qemu-system-aarch64: Failed to set msg fds.
>> qemu-system-aarch64: vhost_set_vring_call failed 22
>> qemu-system-aarch64: Failed to write msg. Wrote -1 instead of 20.
>> qemu-system-aarch64: Failed to set msg fds.
>> qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
>> qemu-system-aarch64: Failed to set msg fds.
>> qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
>> qemu-system-aarch64: ../../devel/qemu/hw/pci/msix.c:659:
>> msix_unset_vector_notifiers: Assertion `dev->msix_vector_use_notifier
>> && dev->msix_vector_release_notifier' failed.
>> ../../devel/qemu/tests/qtest/libqtest.c:200: kill_qemu() detected QEMU
>> death from signal 6 (Aborted) (core dumped)
>> **
>> ERROR:../../devel/qemu/tests/qtest/qos-test.c:191:subprocess_run_one_test:
>> child process
>> (/aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile/subprocess
>> [488457]) failed unexpectedly
>> Aborted (core dumped)
> 
> Interesting, good discovery.
> 
>> Can you also reproduce it this way?
> 
> Unfortunately not.  I ran the loops several times and everything passed.
> I tried to compile and run it in a different distro container and it
> passed too.  I also haven't been successful in getting any idea how the
> processes could influence each other.
> 
> What OS and what QEMU configure flags did you use to compile and run it?

I'm using RHEL 8 on an older laptop ... and maybe the latter is related: I 
just noticed that I can also reproduce the problem by just running one of 
the above two for-loop while putting a lot of load on the machine otherwise, 
e.g. by running a "make -j$(nproc)" to rebuild the whole QEMU sources. So 
it's definitely a race *within* one QEMU process.

  Thomas



