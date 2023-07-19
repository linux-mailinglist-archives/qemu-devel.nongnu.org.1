Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9A375A039
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 22:52:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qME8z-0001ze-Fd; Wed, 19 Jul 2023 16:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qME8x-0001zW-7r
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:51:31 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qME8v-0006yp-3X
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:51:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 406F2221CC;
 Wed, 19 Jul 2023 20:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689799886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kqMg/wlXGha42WQXQCKIfwS5MQ9jpGN6yBaaz1IugJw=;
 b=u97Pqz0GqLmMhQ5oQBHQOzCR8HZe5KXbjh62bRuRJ8IxnKNogIeYqfiX5iMCiQUApUCoSm
 T1iD98hOL3ibe0MJNC4iB8E9QhIEPdoorCBaOzWSVX2SKIX1oLOA5mzQCLu4svapeOPY3Z
 f3DFJ6ia5P2kKOqgvou8CQNQSZkWc94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689799886;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kqMg/wlXGha42WQXQCKIfwS5MQ9jpGN6yBaaz1IugJw=;
 b=XSZI3CIyFVcHzh3MzO3058ZeOHekgcEPCW6YeVQ0P86zWEINLY2tioCy+f3GKhhQE1201M
 emvx9mkwVnnbwTAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C55401361C;
 Wed, 19 Jul 2023 20:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lQbuI81MuGRZAgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 19 Jul 2023 20:51:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, Milan Zamazal <mzamazal@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter
 Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PULL 10/66] tests/qtest: enable tests for virtio-scmi
In-Reply-To: <373f7d28-788b-99d1-1606-b73db45720c1@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
 <b6f53ae005a1c05034769beebf799e861b82d48a.1689030052.git.mst@redhat.com>
 <22589b2f-8dcf-b86b-2d77-bf27bf81ce27@redhat.com>
 <87pm4pcrbe.fsf@redhat.com>
 <373f7d28-788b-99d1-1606-b73db45720c1@redhat.com>
Date: Wed, 19 Jul 2023 17:51:23 -0300
Message-ID: <87wmyvr5f8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
>> 
>> Hmm, it's basically the same as virtio-gpio.c test, so it should be OK.
>> Is it possible that the two tests (virtio-gpio.c & virtio-scmi.c)
>> interfere with each other in some way?  Is there possibly a way to
>> serialize them to check?
>
> I think within one qos-test, the sub-tests are already run serialized. But there might be multiple qos-tests running in parallel, e.g. one for the aarch64 target and one for the ppc64 target. And indeed, I can reproduce the problem on my x86 laptop by running this in one terminal window:
>
> for ((x=0;x<1000;x++)); do \
>   QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon \
>   G_TEST_DBUS_DAEMON=.tests/dbus-vmstate-daemon.sh \
>   QTEST_QEMU_BINARY=./qemu-system-ppc64 \
>   MALLOC_PERTURB_=188 QTEST_QEMU_IMG=./qemu-img \
>   tests/qtest/qos-test -p \
>   /ppc64/pseries/spapr-pci-host-bridge/pci-bus-spapr/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile \
>   || break ; \
> done
>
> And this in another terminal window at the same time:
>
> for ((x=0;x<1000;x++)); do \
>   QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon \
>   G_TEST_DBUS_DAEMON=.tests/dbus-vmstate-daemon.sh \
>   QTEST_QEMU_BINARY=./qemu-system-aarch64 \
>   MALLOC_PERTURB_=188 QTEST_QEMU_IMG=./qemu-img \
>   tests/qtest/qos-test -p \
>   /aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile \
>   || break ; \
> done
>
> After a while, the aarch64 test broke with:
>
> /aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/vhost-user-scmi-pci/vhost-user-scmi/vhost-user-scmi-tests/scmi/read-guest-mem/memfile: qemu-system-aarch64: Failed to set msg fds.
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
> qemu-system-aarch64: ../../devel/qemu/hw/pci/msix.c:659: msix_unset_vector_notifiers: Assertion `dev->msix_vector_use_notifier && dev->msix_vector_release_notifier' failed.
> ../../devel/qemu/tests/qtest/libqtest.c:200: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)

If it helps,

it looks like msix_unset_vector_notifiers is being called twice, once
from vu_scmi_set_status() and another from vu_scmi_disconnect():

msix_unset_vector_notifiers
virtio_pci_set_guest_notifiers
vu_scmi_stop
vu_scmi_disconnect   <-
vu_scmi_event
chr_be_event
qemu_chr_be_event
tcp_chr_disconnect_locked
tcp_chr_write
qemu_chr_write_buffer

msix_unset_vector_notifiers
virtio_pci_set_guest_notifiers
vu_scmi_stop
vu_scmi_set_status   <-
virtio_set_status
virtio_vmstate_change
vm_state_notify
do_vm_stop
vm_shutdown
qemu_cleanup

