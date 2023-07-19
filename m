Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BA6759F1D
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 21:57:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMDHb-0004dZ-EY; Wed, 19 Jul 2023 15:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qMDHZ-0004b1-70
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 15:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qMDHX-0004pF-0p
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 15:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689796576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NXE64z5yd9ECPUGYAydL1K9ddDdHA34gbyW/hPb6vZo=;
 b=ZlZHl8ZfDRrxpj7CvPkh3MzVYP0icOGJvhZfyqXIZivQOExytu5n+lyMmaaPCtnvk2Dsf/
 2cHvYjEGgWQryDt6d7WxT78dK7ZsbCxEN09MlXn11rZWkxZG7YBzCfsSYQP6fAvXMyH+gK
 +nGofzbMcMTvOnfND8yjPHtgHZkxIeU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-yBHDq6K3Ml6kouJ_TvXlQg-1; Wed, 19 Jul 2023 15:56:14 -0400
X-MC-Unique: yBHDq6K3Ml6kouJ_TvXlQg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-316f5d82bf4so7493f8f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 12:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689796573; x=1690401373;
 h=mime-version:user-agent:message-id:in-reply-to:date:references
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXE64z5yd9ECPUGYAydL1K9ddDdHA34gbyW/hPb6vZo=;
 b=K20AsOAu460AloLGVuna2KJjjIKXPIwoyRoDXkBrV3JAt7guQXY0/JYHdp2btvipij
 rMqAWUOSzKqQyKHP+ScV9teRY9Ir1DtJtLn1pEEa0M2AwgW0E6BqQ860NZCv7w+tWIjW
 nrr+0FLpRJPy1aTuX4aL8UUUEsh0cdni/wRsuQS+69Y0AZelydibueKnmavBBlM0JWB2
 gTsfWWRaHu8JSK9k0D3x0mzeVlTMQsThCwmtDREcDifs86sLwFViKz3lp5ltbkygR5mR
 INhhoMsO5JbSTOudO0YFSJbFlf1DybVvCkER07iNsBl7tZTRi43jXXuIpUz+VvaOvy+d
 4XYA==
X-Gm-Message-State: ABy/qLZAjqOfVtJuoa5RlNvX7IuawIgAM61qC8b9OlcqGnfDef3rnSCN
 mub6yZfOVAD4X32k6DEPT07qylwhd1MV+bsQIxIUyWdDVBghCvCL0S2/vSCrRqs8d6697mLpZEm
 BGEvzWQw0XLZfgVg=
X-Received: by 2002:adf:e84b:0:b0:314:3ac8:c277 with SMTP id
 d11-20020adfe84b000000b003143ac8c277mr365243wrn.9.1689796573154; 
 Wed, 19 Jul 2023 12:56:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGqa+tidjZe/3E1kKqy48p/6+TiKqjb6cBKpcUXT5vSgzruTqmY89lQJclk3MqdaSjyOkiFQg==
X-Received: by 2002:adf:e84b:0:b0:314:3ac8:c277 with SMTP id
 d11-20020adfe84b000000b003143ac8c277mr365232wrn.9.1689796572800; 
 Wed, 19 Jul 2023 12:56:12 -0700 (PDT)
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a5d49d2000000b0030647449730sm6103895wrs.74.2023.07.19.12.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 12:56:11 -0700 (PDT)
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
Date: Wed, 19 Jul 2023 21:56:11 +0200
In-Reply-To: <373f7d28-788b-99d1-1606-b73db45720c1@redhat.com> (Thomas Huth's
 message of "Wed, 19 Jul 2023 15:02:11 +0200")
Message-ID: <87mszrptes.fsf@redhat.com>
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

> On 18/07/2023 14.55, Milan Zamazal wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>
>>> On 11/07/2023 01.02, Michael S. Tsirkin wrote:
>>>> From: Milan Zamazal <mzamazal@redhat.com>
>>>> We don't have a virtio-scmi implementation in QEMU and only support
>>>
>>>> a
>>>> vhost-user backend.  This is very similar to virtio-gpio and we add the same
>>>> set of tests, just passing some vhost-user messages over the control socket.
>>>> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
>>>> Acked-by: Thomas Huth <thuth@redhat.com>
>>>> Message-Id: <20230628100524.342666-4-mzamazal@redhat.com>
>>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>> ---
>>>>    tests/qtest/libqos/virtio-scmi.h |  34 ++++++
>>>>    tests/qtest/libqos/virtio-scmi.c | 174 +++++++++++++++++++++++++++++++
>>>>    tests/qtest/vhost-user-test.c    |  44 ++++++++
>>>>    MAINTAINERS                      |   1 +
>>>>    tests/qtest/libqos/meson.build   |   1 +
>>>>    5 files changed, 254 insertions(+)
>>>>    create mode 100644 tests/qtest/libqos/virtio-scmi.h
>>>>    create mode 100644 tests/qtest/libqos/virtio-scmi.c
>>>
>>>   Hi!
>>>
>>> I'm seeing some random failures with this new scmi test, so far only
>>> on non-x86 systems, e.g.:
>>>
>>>   https://app.travis-ci.com/github/huth/qemu/jobs/606246131#L4774
>>>
>>> It also reproduces on a s390x host here, but only if I run "make check
>>> -j$(nproc)" - if I run the tests single-threaded, the qos-test passes
>>> there. Seems like there is a race somewhere in this test?
>> Hmm, it's basically the same as virtio-gpio.c test, so it should be
>> OK.
>> Is it possible that the two tests (virtio-gpio.c & virtio-scmi.c)
>> interfere with each other in some way?  Is there possibly a way to
>> serialize them to check?
>
> I think within one qos-test, the sub-tests are already run
> serialized. 

I see, OK.

> But there might be multiple qos-tests running in parallel, e.g. one
> for the aarch64 target and one for the ppc64 target. And indeed, I can
> reproduce the problem on my x86 laptop by running this in one terminal
> window:
>
> for ((x=0;x<1000;x++)); do \
>  QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon \
>  G_TEST_DBUS_DAEMON=.tests/dbus-vmstate-daemon.sh \
>  QTEST_QEMU_BINARY=./qemu-system-ppc64 \
>  MALLOC_PERTURB_=188 QTEST_QEMU_IMG=./qemu-img \
>  tests/qtest/qos-test -p \
>  /ppc64/pseries/spapr-pci-host-bridge/pci-bus-spapr/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile
> \
>  || break ; \
> done
>
> And this in another terminal window at the same time:
>
> for ((x=0;x<1000;x++)); do \
>  QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon \
>  G_TEST_DBUS_DAEMON=.tests/dbus-vmstate-daemon.sh \
>  QTEST_QEMU_BINARY=./qemu-system-aarch64 \
>  MALLOC_PERTURB_=188 QTEST_QEMU_IMG=./qemu-img \
>  tests/qtest/qos-test -p \
>  /aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile
> \
>  || break ; \
> done
>
> After a while, the aarch64 test broke with:
>
> /aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile:
> qemu-system-aarch64: Failed to set msg fds.
> qemu-system-aarch64: Failed to set msg fds.
> qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
> qemu-system-aarch64: Failed to set msg fds.
> qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
> qemu-system-aarch64: Failed to set msg fds.
> qemu-system-aarch64: vhost_set_vring_call failed 22
> qemu-system-aarch64: Failed to set msg fds.
> qemu-system-aarch64: vhost_set_vring_call failed 22
> qemu-system-aarch64: Failed to write msg. Wrote -1 instead of 20.
> qemu-system-aarch64: Failed to set msg fds.
> qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
> qemu-system-aarch64: Failed to set msg fds.
> qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
> qemu-system-aarch64: ../../devel/qemu/hw/pci/msix.c:659:
> msix_unset_vector_notifiers: Assertion `dev->msix_vector_use_notifier
> && dev->msix_vector_release_notifier' failed.
> ../../devel/qemu/tests/qtest/libqtest.c:200: kill_qemu() detected QEMU
> death from signal 6 (Aborted) (core dumped)
> **
> ERROR:../../devel/qemu/tests/qtest/qos-test.c:191:subprocess_run_one_test:
> child process
> (/aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile/subprocess
> [488457]) failed unexpectedly
> Aborted (core dumped)

Interesting, good discovery.

> Can you also reproduce it this way?

Unfortunately not.  I ran the loops several times and everything passed.
I tried to compile and run it in a different distro container and it
passed too.  I also haven't been successful in getting any idea how the
processes could influence each other.

What OS and what QEMU configure flags did you use to compile and run it?

Thanks,
Milan


