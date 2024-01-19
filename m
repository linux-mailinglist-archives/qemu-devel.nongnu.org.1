Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E248832AF8
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:08:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQpWf-00073O-GK; Fri, 19 Jan 2024 09:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQpWV-00070m-U0
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:07:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQpWT-0006h8-5s
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705673224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N1DGpg8/fTJWxDpWxVdCh8xT1g7v6BPXQaAsxR/ulxc=;
 b=gr8MIZ9FIyScOqg0mpK08ndRAvg72ABHXSUr1dplhGnV+oarmpHToeGt1B+lYrVkL1p3cG
 ncucJ2GHLK3c7rUK0jqvcCzVESQbCkHP2LsOyK5nqOaMRYGdhr7+s4t/BcrAfi13BVed6I
 ZT8klZ+ejE2L8Ewe3q+N4HCXZUzeHTo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-8ojSSeeLNTSgI8Mht7Hllw-1; Fri, 19 Jan 2024 09:07:01 -0500
X-MC-Unique: 8ojSSeeLNTSgI8Mht7Hllw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE1F48950A0;
 Fri, 19 Jan 2024 14:07:00 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42B59C158BD;
 Fri, 19 Jan 2024 14:07:00 +0000 (UTC)
Date: Fri, 19 Jan 2024 15:06:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Hanna Reitz <hreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Subject: Re: how do the iotests pick a machine model to run on ?
Message-ID: <ZaqCA5uYWFSgK6F-@redhat.com>
References: <CAFEAcA_7s=scvgYfG8kGmJ==5cKmvvA-ZqVkpt4M9jV6eS1Zow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_7s=scvgYfG8kGmJ==5cKmvvA-ZqVkpt4M9jV6eS1Zow@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 19.01.2024 um 13:55 hat Peter Maydell geschrieben:
> If you build QEMU with support for the sh4 target only
> (configure --target-list=sh4-softmmu) then 'make check' fails
> in the iotests, because some iotests, including for instance 040,
> try to create a machine with a virtio-scsi device, but they don't
> do anything to ensure that the machine they create actually
> has a PCI bus to plug the virtio-scsi device into, and so the test
> fails:
> 
> +Traceback (most recent call last):
> +  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/qemu-iotests/040",
> line 94, in setUp
> +    self.vm.launch()
> +  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/python/qemu/machine/machine.py",
> line 455, in launch
> +    raise VMLaunchFailure(
> +qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to
> establish session: EOFError
> +       Exit code: 1
> +       Command:
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/sh4/qemu-system-sh4
> -display none -vga none -chardev socket,id=mon,fd=5 -mon
> chardev=mon,mode=control -chardev socket,id=qtest,fd=3 -qtest
> chardev:qtest -accel qtest -nodefaults -display none -accel qtest
> -drive if=none,id=drive0,file=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/sh4/scratch/qcow2-file-040/test.img,format=qcow2,cache=writeback,aio=threads,node-name=top,backing.node-name=mid,backing.backing.node-name=base
> -device virtio-scsi -device scsi-hd,id=scsi0,drive=drive0
> +       Output: [I 0.000000] OPENED
> +qemu-system-sh4: -device virtio-scsi: No 'PCI' bus found for device
> 'virtio-scsi-pci'
> 
> (It happens that the default machine type for 'sh4'
> does not have a PCI bus.)
> 
> How are the iotests supposed to select a machine model to run
> on, and how are they intended to mark themselves as requiring
> particular facilities, like PCI? Presumably some of the tests
> are missing the appropriate annotations to ensure they're
> skipped when the facilities required aren't present.

Probably next to nobody builds only sh4 and then runs 'make check'...

I think the following patch should fix this test case (but as nobody
ever tested it, I fully expect other cases to fail, too). The fix could
of course be a lot more fine grained and skip only some individual tests
instead of all of them. I doubt we care, though, as long as it passes.

iotests use machine_map in tests/qemu-iotests/testenv.py to decide which
machine to use for which target (unless the individual test case
overrides that). If the target isn't the list, it gets the default
machine type.

Kevin

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 5c18e413ec..19f0bb1010 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -952,5 +952,6 @@ class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
         self.vm.event_wait('BLOCK_JOB_COMPLETED')
 
 if __name__ == '__main__':
+    iotests.verify_virtio_scsi_pci_or_ccw()
     iotests.main(supported_fmts=['qcow2', 'qed'],
                  supported_protocols=['file'])


