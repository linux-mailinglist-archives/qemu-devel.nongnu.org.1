Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA7E75AAA0
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 11:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMPul-00066x-Qw; Thu, 20 Jul 2023 05:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qMPuS-00066d-V5
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 05:25:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qMPuO-0005YC-SQ
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 05:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689845115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DvyVPj5UGVgAQU0s/QoN5hre3cr3wvfsYEF1gFC5DWw=;
 b=Wf1JcuDRuBXZhNKX7CJxPAo+PkzvRp3LdfFq95AusIwfOhazZJra+QiWk0t9RCsx2oqGrQ
 INtd8HptXvTPi1HelwCj/5f0MXNd1srXvQO+8VJwD8rtweCrtmz7dXf8VAD0t3clNt6Pna
 1KMSoYFMs11JntlsX2mPOWgFm+/LDtc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-X7rgOL1pM6iWnYFev23_2w-1; Thu, 20 Jul 2023 05:25:13 -0400
X-MC-Unique: X7rgOL1pM6iWnYFev23_2w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a355cf318so52529166b.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 02:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689845112; x=1690449912;
 h=mime-version:user-agent:message-id:in-reply-to:date:references
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DvyVPj5UGVgAQU0s/QoN5hre3cr3wvfsYEF1gFC5DWw=;
 b=Z8/7vhWmn5aEQyQSntBbh2RWFf7QRO/2w4CLw9zUidbf0vvC4QJ+hr8LeC5ex0Sh/E
 YAnIVEePO/S0+A6WUKInvwBsW4VrBpst+/qaRaFtAm3CC4U00q0tUEoCeMr0FmnEc47X
 5V59PasRcKHJs5SjUrL+REc99l8wfWPalzQVmUiZRphFUmWcJadWyfcmdvhvVhvIxEXC
 G3trOYm1fwoSszCR+8FqqZ9N29xEFZAowxP7xHL3AtHowX5SEV7opzvS8lwG54Yom0+2
 kwFrufc6Y7h/XOaspqKdSxDwalsiJ2LEQiMroLZVWy1SGuFRxAKuzqz2KnOxtWpT+mwT
 O96A==
X-Gm-Message-State: ABy/qLa1024Ua49PaxCiFUAln8UCh1H4UP/WmbzYgwHlS0yTJf5oZKFX
 Tn7sw3DFVxuat6Ly3BTmgQjgweirUa7aoy1+TXsl0bU9Cvfdltq56eOIpIF3aKL8GduRTZZhJm4
 662PJaOoznrigJEg=
X-Received: by 2002:a17:906:2403:b0:98e:1484:5954 with SMTP id
 z3-20020a170906240300b0098e14845954mr4063240eja.71.1689845112027; 
 Thu, 20 Jul 2023 02:25:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHFVmazhjrBB2hYWPzeKrQDHWgySuGQIYK1VqpEVa6X9PtIGeJ6HiRIUIXnemB99g0kGFLpjA==
X-Received: by 2002:a17:906:2403:b0:98e:1484:5954 with SMTP id
 z3-20020a170906240300b0098e14845954mr4063225eja.71.1689845111705; 
 Thu, 20 Jul 2023 02:25:11 -0700 (PDT)
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
 by smtp.gmail.com with ESMTPSA id
 bt16-20020a170906b15000b00993159ce075sm402866ejb.210.2023.07.20.02.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 02:25:11 -0700 (PDT)
From: Milan Zamazal <mzamazal@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  qemu-devel@nongnu.org,  Peter
 Maydell <peter.maydell@linaro.org>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PULL 10/66] tests/qtest: enable tests for virtio-scmi
References: <cover.1689030052.git.mst@redhat.com>
 <b6f53ae005a1c05034769beebf799e861b82d48a.1689030052.git.mst@redhat.com>
 <22589b2f-8dcf-b86b-2d77-bf27bf81ce27@redhat.com>
 <87pm4pcrbe.fsf@redhat.com>
 <373f7d28-788b-99d1-1606-b73db45720c1@redhat.com>
 <87mszrptes.fsf@redhat.com>
 <3d058944-263d-adb3-8f76-e64388574b48@redhat.com>
Date: Thu, 20 Jul 2023 11:25:10 +0200
In-Reply-To: <3d058944-263d-adb3-8f76-e64388574b48@redhat.com> (Thomas Huth's
 message of "Thu, 20 Jul 2023 10:40:07 +0200")
Message-ID: <871qh3exzd.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mzamazal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> On 19/07/2023 21.56, Milan Zamazal wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>
>>> On 18/07/2023 14.55, Milan Zamazal wrote:
>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>
>>>
>>>>> On 11/07/2023 01.02, Michael S. Tsirkin wrote:
>>>>>> From: Milan Zamazal <mzamazal@redhat.com>
>>>>>> We don't have a virtio-scmi implementation in QEMU and only support
>>>>>
>>>>>> a
>>>>>> vhost-user backend.  This is very similar to virtio-gpio and we add the same
>>>>>> set of tests, just passing some vhost-user messages over the control socket.
>>>>>> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
>>>>>> Acked-by: Thomas Huth <thuth@redhat.com>
>>>>>> Message-Id: <20230628100524.342666-4-mzamazal@redhat.com>
>>>>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>> ---
>>>>>>     tests/qtest/libqos/virtio-scmi.h |  34 ++++++
>>>>>>     tests/qtest/libqos/virtio-scmi.c | 174 +++++++++++++++++++++++++++++++
>>>>>>     tests/qtest/vhost-user-test.c    |  44 ++++++++
>>>>>>     MAINTAINERS                      |   1 +
>>>>>>     tests/qtest/libqos/meson.build   |   1 +
>>>>>>     5 files changed, 254 insertions(+)
>>>>>>     create mode 100644 tests/qtest/libqos/virtio-scmi.h
>>>>>>     create mode 100644 tests/qtest/libqos/virtio-scmi.c
>>>>>
>>>>>    Hi!
>>>>>
>>>>> I'm seeing some random failures with this new scmi test, so far only
>>>>> on non-x86 systems, e.g.:
>>>>>
>>>>>    https://app.travis-ci.com/github/huth/qemu/jobs/606246131#L4774
>>>>>
>>>>> It also reproduces on a s390x host here, but only if I run "make check
>>>>> -j$(nproc)" - if I run the tests single-threaded, the qos-test passes
>>>>> there. Seems like there is a race somewhere in this test?
>>>> Hmm, it's basically the same as virtio-gpio.c test, so it should be
>>>> OK.
>>>> Is it possible that the two tests (virtio-gpio.c & virtio-scmi.c)
>>>> interfere with each other in some way?  Is there possibly a way to
>>>> serialize them to check?
>>>
>>> I think within one qos-test, the sub-tests are already run
>>> serialized.
>> I see, OK.
>> 
>>> But there might be multiple qos-tests running in parallel, e.g. one
>>> for the aarch64 target and one for the ppc64 target. And indeed, I can
>>> reproduce the problem on my x86 laptop by running this in one terminal
>>> window:
>>>
>>> for ((x=0;x<1000;x++)); do \
>>>   QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon \
>>>   G_TEST_DBUS_DAEMON=.tests/dbus-vmstate-daemon.sh \
>>>   QTEST_QEMU_BINARY=./qemu-system-ppc64 \
>>>   MALLOC_PERTURB_=188 QTEST_QEMU_IMG=./qemu-img \
>>>   tests/qtest/qos-test -p \
>>>   /ppc64/pseries/spapr-pci-host-bridge/pci-bus-spapr/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile
>>> \
>>>   || break ; \
>>> done
>>>
>>> And this in another terminal window at the same time:
>>>
>>> for ((x=0;x<1000;x++)); do \
>>>   QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon \
>>>   G_TEST_DBUS_DAEMON=.tests/dbus-vmstate-daemon.sh \
>>>   QTEST_QEMU_BINARY=./qemu-system-aarch64 \
>>>   MALLOC_PERTURB_=188 QTEST_QEMU_IMG=./qemu-img \
>>>   tests/qtest/qos-test -p \
>>>   /aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile
>>> \
>>>   || break ; \
>>> done
>>>
>>> After a while, the aarch64 test broke with:
>>>
>>> /aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile:
>>> qemu-system-aarch64: Failed to set msg fds.
>>> qemu-system-aarch64: Failed to set msg fds.
>>> qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
>>> qemu-system-aarch64: Failed to set msg fds.
>>> qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
>>> qemu-system-aarch64: Failed to set msg fds.
>>> qemu-system-aarch64: vhost_set_vring_call failed 22
>>> qemu-system-aarch64: Failed to set msg fds.
>>> qemu-system-aarch64: vhost_set_vring_call failed 22
>>> qemu-system-aarch64: Failed to write msg. Wrote -1 instead of 20.
>>> qemu-system-aarch64: Failed to set msg fds.
>>> qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
>>> qemu-system-aarch64: Failed to set msg fds.
>>> qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
>>> qemu-system-aarch64: ../../devel/qemu/hw/pci/msix.c:659:
>>> msix_unset_vector_notifiers: Assertion `dev->msix_vector_use_notifier
>>> && dev->msix_vector_release_notifier' failed.
>>> ../../devel/qemu/tests/qtest/libqtest.c:200: kill_qemu() detected QEMU
>>> death from signal 6 (Aborted) (core dumped)
>>> **
>>> ERROR:../../devel/qemu/tests/qtest/qos-test.c:191:subprocess_run_one_test:
>>> child process
>>> (/aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile/subprocess
>>> [488457]) failed unexpectedly
>>> Aborted (core dumped)
>> Interesting, good discovery.
>> 
>>> Can you also reproduce it this way?
>> Unfortunately not.  I ran the loops several times and everything
>> passed.
>> I tried to compile and run it in a different distro container and it
>> passed too.  I also haven't been successful in getting any idea how the
>> processes could influence each other.
>> What OS and what QEMU configure flags did you use to compile and run
>> it?
>
> I'm using RHEL 8 on an older laptop ... and maybe the latter is
> related: I just noticed that I can also reproduce the problem by just
> running one of the above two for-loop while putting a lot of load on
> the machine otherwise, e.g. by running a "make -j$(nproc)" to rebuild
> the whole QEMU sources. So it's definitely a race *within* one QEMU
> process.

Ah, great, now I can easily reproduce it by running kernel compilation
in the background.  And I could also check that the supposed fix
remedies the problem.  I'll post the patch soon.

Thank you,
Milan


