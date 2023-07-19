Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7CC759622
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 15:04:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM6p7-0008Qw-Kv; Wed, 19 Jul 2023 09:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM6oz-0008Pi-KA
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM6ox-0001yz-Sw
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689771740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lHvW96hFNQVWGMpTYLUDmDMiBAO9ZROfHRUwTiA239s=;
 b=TPVRmIt8QHZEs1X0AcRIkKJOELY7b0KKUGbCXHe3+jSUcpkgvANI3Wl3/YpCgw1p6WKUyE
 /fowwJqrg2KWOYQ0BeT+Se6Xf9UzdProawkupRIa4tHpYybSs9DtIvOHuKEjCkibw5PZTb
 L74sUcTcA/pxU4vfsPz41zHbBRJ4t0E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-NUhZFp1SP5uD2d8Qu2QVvQ-1; Wed, 19 Jul 2023 09:02:17 -0400
X-MC-Unique: NUhZFp1SP5uD2d8Qu2QVvQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31429e93f26so4157141f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 06:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689771734; x=1692363734;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lHvW96hFNQVWGMpTYLUDmDMiBAO9ZROfHRUwTiA239s=;
 b=cdB5xQLX72bssq5U/EZ5swhVydC0F/SXyKhoL5cr3sEtmnGlvx2A3w3dsfqkEw8/qd
 YVpHbhB1aDCIi443II6JGobYV3n71/cnEHKfg2Ts3AjkV1630eUjx6Wy1vhYwIPUlCS1
 ILGKd8eweQA3Xny1Z1d+/2yiHYuzfQqdCorFggoqD1kSyOkgSSZoW+wxhBxY7aJBf2qu
 NiKqvVGCSUu9DKwYHpRochUKvImbQcT+bu8kCaRg6ofsonLKQnzYbEpkOP6mrSNiwDrl
 BjxsMsNrXZqhwR1VxUERZZkRx7KFOR1/Ia6Dy1a3MUgWjKFDe5PDphj72bUeCST5g9XS
 yCEA==
X-Gm-Message-State: ABy/qLbmsFLrCI+zIh2QeW1lsN9zRI0S+CcMFQ24Wy0g43vFqk8BoDE0
 R9cdkG+Qj7uBOG6kRGgaJkRuni8PZACdsb/Q/gUiV5iXmmsGkhooKfaliEPj+IPdmIx/e0W+Qtr
 K6A1f5bD0zvjaOvI=
X-Received: by 2002:a5d:60c6:0:b0:315:9de4:92f0 with SMTP id
 x6-20020a5d60c6000000b003159de492f0mr15260352wrt.5.1689771734661; 
 Wed, 19 Jul 2023 06:02:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGPyxSfg4E0Tsggy3a8qzsnLNyd+GdsJvpIhEGB2+pu7QzDeWJ4JUwnhNAjR/9lVLkY6jYaww==
X-Received: by 2002:a5d:60c6:0:b0:315:9de4:92f0 with SMTP id
 x6-20020a5d60c6000000b003159de492f0mr15260312wrt.5.1689771733971; 
 Wed, 19 Jul 2023 06:02:13 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 q22-20020a7bce96000000b003fbca05faa9sm1663716wmj.24.2023.07.19.06.02.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 06:02:13 -0700 (PDT)
Message-ID: <373f7d28-788b-99d1-1606-b73db45720c1@redhat.com>
Date: Wed, 19 Jul 2023 15:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Milan Zamazal <mzamazal@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <cover.1689030052.git.mst@redhat.com>
 <b6f53ae005a1c05034769beebf799e861b82d48a.1689030052.git.mst@redhat.com>
 <22589b2f-8dcf-b86b-2d77-bf27bf81ce27@redhat.com> <87pm4pcrbe.fsf@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 10/66] tests/qtest: enable tests for virtio-scmi
In-Reply-To: <87pm4pcrbe.fsf@redhat.com>
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

On 18/07/2023 14.55, Milan Zamazal wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 11/07/2023 01.02, Michael S. Tsirkin wrote:
>>> From: Milan Zamazal <mzamazal@redhat.com>
>>> We don't have a virtio-scmi implementation in QEMU and only support
>>
>>> a
>>> vhost-user backend.  This is very similar to virtio-gpio and we add the same
>>> set of tests, just passing some vhost-user messages over the control socket.
>>> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
>>> Acked-by: Thomas Huth <thuth@redhat.com>
>>> Message-Id: <20230628100524.342666-4-mzamazal@redhat.com>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>    tests/qtest/libqos/virtio-scmi.h |  34 ++++++
>>>    tests/qtest/libqos/virtio-scmi.c | 174 +++++++++++++++++++++++++++++++
>>>    tests/qtest/vhost-user-test.c    |  44 ++++++++
>>>    MAINTAINERS                      |   1 +
>>>    tests/qtest/libqos/meson.build   |   1 +
>>>    5 files changed, 254 insertions(+)
>>>    create mode 100644 tests/qtest/libqos/virtio-scmi.h
>>>    create mode 100644 tests/qtest/libqos/virtio-scmi.c
>>
>>   Hi!
>>
>> I'm seeing some random failures with this new scmi test, so far only
>> on non-x86 systems, e.g.:
>>
>>   https://app.travis-ci.com/github/huth/qemu/jobs/606246131#L4774
>>
>> It also reproduces on a s390x host here, but only if I run "make check
>> -j$(nproc)" - if I run the tests single-threaded, the qos-test passes
>> there. Seems like there is a race somewhere in this test?
> 
> Hmm, it's basically the same as virtio-gpio.c test, so it should be OK.
> Is it possible that the two tests (virtio-gpio.c & virtio-scmi.c)
> interfere with each other in some way?  Is there possibly a way to
> serialize them to check?

I think within one qos-test, the sub-tests are already run serialized. But there might be multiple qos-tests running in parallel, e.g. one for the aarch64 target and one for the ppc64 target. And indeed, I can reproduce the problem on my x86 laptop by running this in one terminal window:

for ((x=0;x<1000;x++)); do \
  QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon \
  G_TEST_DBUS_DAEMON=.tests/dbus-vmstate-daemon.sh \
  QTEST_QEMU_BINARY=./qemu-system-ppc64 \
  MALLOC_PERTURB_=188 QTEST_QEMU_IMG=./qemu-img \
  tests/qtest/qos-test -p \
  /ppc64/pseries/spapr-pci-host-bridge/pci-bus-spapr/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile \
  || break ; \
done

And this in another terminal window at the same time:

for ((x=0;x<1000;x++)); do \
  QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon \
  G_TEST_DBUS_DAEMON=.tests/dbus-vmstate-daemon.sh \
  QTEST_QEMU_BINARY=./qemu-system-aarch64 \
  MALLOC_PERTURB_=188 QTEST_QEMU_IMG=./qemu-img \
  tests/qtest/qos-test -p \
  /aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile \
  || break ; \
done

After a while, the aarch64 test broke with:

/aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile: qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost_set_vring_call failed 22
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost_set_vring_call failed 22
qemu-system-aarch64: Failed to write msg. Wrote -1 instead of 20.
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
qemu-system-aarch64: ../../devel/qemu/hw/pci/msix.c:659: msix_unset_vector_notifiers: Assertion `dev->msix_vector_use_notifier && dev->msix_vector_release_notifier' failed.
../../devel/qemu/tests/qtest/libqtest.c:200: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
**
ERROR:../../devel/qemu/tests/qtest/qos-test.c:191:subprocess_run_one_test: child process (/aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile/subprocess [488457]) failed unexpectedly
Aborted (core dumped)

Can you also reproduce it this way?

  Thomas


