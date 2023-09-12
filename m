Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1469079CF86
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 13:11:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg1HJ-0000op-F2; Tue, 12 Sep 2023 07:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg1HH-0000oT-Kh
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg1HE-0006GY-0D
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694516989;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4v7/DcU71xk0bqZvsyq1U32j6GNNSyK29K/OPFtrl2o=;
 b=FQ5929SbMcqqiL+XtN/vxc4EOqJfbVRlbhrL/vatB5KQj+751sPtEaUnf/Wqu/hTB7YMP9
 dFt6Wj4XAjiEazGyfz/jG+VDvRk41bcTi/QDEhY0qsMWS3RrI23FAVIu4MJACOdMD1U8XO
 rB/ankwizF6Nwa2IBlZQu/XbJvCMR9Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-HwxFZIXZNgWQJSntW3rSag-1; Tue, 12 Sep 2023 07:09:46 -0400
X-MC-Unique: HwxFZIXZNgWQJSntW3rSag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B33BF18B12E3;
 Tue, 12 Sep 2023 11:09:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D45547B62;
 Tue, 12 Sep 2023 11:09:44 +0000 (UTC)
Date: Tue, 12 Sep 2023 12:09:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PULL 13/14] ui: fix crash when there are no active_console
Message-ID: <ZQBG9oFlj07a3TLX@redhat.com>
References: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
 <20230912104649.1638640-14-marcandre.lureau@redhat.com>
 <6dc8152b-1098-56dd-c7dc-53814c106c7e@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6dc8152b-1098-56dd-c7dc-53814c106c7e@tls.msk.ru>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Sep 12, 2023 at 02:00:46PM +0300, Michael Tokarev wrote:
> 12.09.2023 13:46, marcandre.lureau@redhat.com пишет:
> > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > 
> > Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> > 0x0000555555888630 in dpy_ui_info_supported (con=0x0) at ../ui/console.c:812
> > 812	    return con->hw_ops->ui_info != NULL;
> > (gdb) bt
> > #0  0x0000555555888630 in dpy_ui_info_supported (con=0x0) at ../ui/console.c:812
> > #1  0x00005555558a44b1 in protocol_client_msg (vs=0x5555578c76c0, data=0x5555581e93f0 <incomplete sequence \373>, len=24) at ../ui/vnc.c:2585
> > #2  0x00005555558a19ac in vnc_client_read (vs=0x5555578c76c0) at ../ui/vnc.c:1607
> > #3  0x00005555558a1ac2 in vnc_client_io (ioc=0x5555581eb0e0, condition=G_IO_IN, opaque=0x5555578c76c0) at ../ui/vnc.c:1635
> > 
> > Fixes:
> > https://issues.redhat.com/browse/RHEL-2600
> 
> FWIW, this link does not work for me (requires auth).

This particular bug is marked as Red Hat employee access only, so
should be dropped from the commit message.

FWIW, it says in terms of reproducability

Steps to reproduce
1. Boot up guest, but only add vnc device and without graphics device
/usr/libexec/qemu-kvm \
-name guest=gg \
-machine pc-q35-rhel8.6.0,kernel_irqchip=split \
-cpu host \
-m 8192 \
-smp 4,maxcpus=4,cores=2,threads=1,dies=1,sockets=2  \
-nodefaults \
-boot menu=on \
-device pcie-root-port,port=16,chassis=1,id=pci.1,bus=pcie.0,addr=0x2 \
-blockdev '\{"driver":"file","filename":"/home/kvm_autotest_root/images/rhel890-64-virtio-scsi.qcow2","node-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '\{"node-name":"libvirt-1-format","read-only":false,"driver":"qcow2","file":"libvirt-1-storage","backing":null}' \
-device virtio-blk-pci,bus=pci.1,addr=0x0,drive=libvirt-1-format,id=virtio-disk0 \
-enable-kvm \
-monitor stdio \
-vnc :0 \

2. Try to connect this guest
remote-viewer vnc://10.73.210.78:5900

3. About 10 seconds to trigger qemu core dump.


The trigger appears to be the lack of any VGA device hardware
present, despite having VNC enabled.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


