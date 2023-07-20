Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A628475A961
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 10:36:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMP7g-0006XX-EQ; Thu, 20 Jul 2023 04:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qMP7f-0006Wa-3l
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 04:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qMP7d-0007DG-87
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 04:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689842091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BSQycOFO03NLHVIhcyT9v43dUwNWQyuH+xgjcamqJCc=;
 b=cVV0wvMCiwfmsDrvuX3Z25a7q74XG1NYE2n0nMYbzLu2kNXoV2IxlFrwidqxEOB23BDyzn
 tDdv3JPtQceXFc1P/bTwmL5qveB09jXgCz8HQmRxI6thZWuidzkXdPbMYgnkHpcMKyEN53
 QYu5h/wKvvccai5j9ZMN7dGKbSrkry8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-kDQ0MtO6PHSEQ2yqaGywSA-1; Thu, 20 Jul 2023 04:34:49 -0400
X-MC-Unique: kDQ0MtO6PHSEQ2yqaGywSA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-993d631393fso48636766b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 01:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689842088; x=1690446888;
 h=mime-version:user-agent:message-id:in-reply-to:date:references
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BSQycOFO03NLHVIhcyT9v43dUwNWQyuH+xgjcamqJCc=;
 b=B9rjOs6ixJ13fh6683oi5Ff8QLWSbk/MZglUufWOkSd+J4JHGibejLFtFYSl8bHBY2
 zpOlEAzOt5kWnNONt/pCzRYz4mwTU8SaiOcBQKXzEL5DKcYHxmJMRVQ2ngkf2rlIJTa5
 Nr4KMjZCpEID9YTgIykN1GCCJY5Zx6O02GAJYpV+o3fxmHhSsyr8HYJwN3sJKwvqgAF8
 gdtTugI3pRSq9XiHd3TeN0XHPoQJl8JcUBhM66q+iVAl/QGUz5bk29zBnMSZVZJXucgJ
 pGFL+ttyU19DRch2HxU7zEEvMTCRZXUY5ohbtxF4Ykg/M5yQcfvwLEpf20TET2Muwcg2
 vfEA==
X-Gm-Message-State: ABy/qLaw3M30cCqloDn9GdkZGzpY41fHueqJORXF01hQ6MPl/U9FS6SF
 itKGbjzqlMVh4/UvdeeBhSDCerymUK73X3/RWcFqggrhVYAAkfr8nAVIBOzJfWPj5t4Xn5wH7C9
 5Cf4WHxAWe1Gdhgg=
X-Received: by 2002:a17:906:19:b0:974:1d8b:ca5f with SMTP id
 25-20020a170906001900b009741d8bca5fmr1938124eja.9.1689842088682; 
 Thu, 20 Jul 2023 01:34:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE8cwsQDORisly7ImoQI5G65KSITbwErZ6lOuF56aMPmnd4E1yNs3OXhtSjA71NeoB26CHAOQ==
X-Received: by 2002:a17:906:19:b0:974:1d8b:ca5f with SMTP id
 25-20020a170906001900b009741d8bca5fmr1938113eja.9.1689842088312; 
 Thu, 20 Jul 2023 01:34:48 -0700 (PDT)
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
 by smtp.gmail.com with ESMTPSA id
 y19-20020a170906471300b00992b8d56f3asm349898ejq.105.2023.07.20.01.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 01:34:47 -0700 (PDT)
From: Milan Zamazal <mzamazal@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Thomas Huth <thuth@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 10/66] tests/qtest: enable tests for virtio-scmi
References: <cover.1689030052.git.mst@redhat.com>
 <b6f53ae005a1c05034769beebf799e861b82d48a.1689030052.git.mst@redhat.com>
 <22589b2f-8dcf-b86b-2d77-bf27bf81ce27@redhat.com>
 <87pm4pcrbe.fsf@redhat.com>
 <373f7d28-788b-99d1-1606-b73db45720c1@redhat.com>
 <87wmyvr5f8.fsf@suse.de>
Date: Thu, 20 Jul 2023 10:34:47 +0200
In-Reply-To: <87wmyvr5f8.fsf@suse.de> (Fabiano Rosas's message of "Wed, 19 Jul
 2023 17:51:23 -0300")
Message-ID: <875y6ff0bc.fsf@redhat.com>
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

Fabiano Rosas <farosas@suse.de> writes:

> Thomas Huth <thuth@redhat.com> writes:
>
>> On 18/07/2023 14.55, Milan Zamazal wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>> 
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
>>>>>    tests/qtest/libqos/virtio-scmi.h |  34 ++++++
>>>>>    tests/qtest/libqos/virtio-scmi.c | 174 +++++++++++++++++++++++++++++++
>>>>>    tests/qtest/vhost-user-test.c    |  44 ++++++++
>>>>>    MAINTAINERS                      |   1 +
>>>>>    tests/qtest/libqos/meson.build   |   1 +
>>>>>    5 files changed, 254 insertions(+)
>>>>>    create mode 100644 tests/qtest/libqos/virtio-scmi.h
>>>>>    create mode 100644 tests/qtest/libqos/virtio-scmi.c
>>>>
>>>>   Hi!
>>>>
>>>> I'm seeing some random failures with this new scmi test, so far only
>>>> on non-x86 systems, e.g.:
>>>>
>>>>   https://app.travis-ci.com/github/huth/qemu/jobs/606246131#L4774
>>>>
>>>> It also reproduces on a s390x host here, but only if I run "make check
>>>> -j$(nproc)" - if I run the tests single-threaded, the qos-test passes
>>>> there. Seems like there is a race somewhere in this test?
>>> 
>>> Hmm, it's basically the same as virtio-gpio.c test, so it should be OK.
>>> Is it possible that the two tests (virtio-gpio.c & virtio-scmi.c)
>>> interfere with each other in some way?  Is there possibly a way to
>>> serialize them to check?
>>
>> I think within one qos-test, the sub-tests are already run
>> serialized. But there might be multiple qos-tests running in
>> parallel, e.g. one for the aarch64 target and one for the ppc64
>> target. And indeed, I can reproduce the problem on my x86 laptop by
>> running this in one terminal window:
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
>> msix_unset_vector_notifiers: Assertion
>> `dev->msix_vector_use_notifier && dev->msix_vector_release_notifier'
>> failed.
>> ../../devel/qemu/tests/qtest/libqtest.c:200: kill_qemu() detected
>> QEMU death from signal 6 (Aborted) (core dumped)
>
> If it helps,

It helps a lot, thank you!

> it looks like msix_unset_vector_notifiers is being called twice, once
> from vu_scmi_set_status() and another from vu_scmi_disconnect():

Interesting.  Usually, vu_scmi_stop is called only once, which explains
why the test regularly passes.  Both the vu_scmi_stop callers have a
check protecting from duplicate vu_scmi_stop calls but it's perhaps not
fully reliable.  I can see vhost-user-gpio has an extra protection.
I'll post a patch adding a similar thing, hopefully it will fix the
problem.

> msix_unset_vector_notifiers
> virtio_pci_set_guest_notifiers
> vu_scmi_stop
> vu_scmi_disconnect   <-
> vu_scmi_event
> chr_be_event
> qemu_chr_be_event
> tcp_chr_disconnect_locked
> tcp_chr_write
> qemu_chr_write_buffer
>
> msix_unset_vector_notifiers
> virtio_pci_set_guest_notifiers
> vu_scmi_stop
> vu_scmi_set_status   <-
> virtio_set_status
> virtio_vmstate_change
> vm_state_notify
> do_vm_stop
> vm_shutdown
> qemu_cleanup


