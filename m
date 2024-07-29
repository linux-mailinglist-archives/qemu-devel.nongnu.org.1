Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B6693ED83
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Jul 2024 08:34:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYJwt-0002cC-1V; Mon, 29 Jul 2024 02:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1sYJwn-0002bO-A5
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 02:33:30 -0400
Received: from out-179.mta0.migadu.com ([2001:41d0:1004:224b::b3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1sYJwl-0004YP-0W
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 02:33:29 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1722234799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uaNcfsPp6cOXVA0X2ZSc24J+4vt3LCveJBLOpem8U+Y=;
 b=IJ41qOnsljUNVUAev6iMYfmFuudwZZhkbGYUslo7abE/CDrdZCcbfC66O2Z6KmBgb1l7uU
 U0htp1hIBbvwJ9Yj79kDDTAbte2EyRwrvRVrN/dI7+BlkjPVnRdP01PNJgVpc83qF+XXhD
 TE90H3YsOMwDDU2MIvbyIsfwuhyKH0E=
From: Itaru Kitayama <itaru.kitayama@linux.dev>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: QEMU unexpectedly closed the monitor
Message-Id: <8AFDCC22-C476-45EF-9119-2E3C9A2A91C3@linux.dev>
Date: Mon, 29 Jul 2024 15:33:02 +0900
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
To: qemu-devel@nongnu.org
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::b3;
 envelope-from=itaru.kitayama@linux.dev; helo=out-179.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hi,

Executing virt-install with the following options:

sudo virt-install --machine=3Dvirt --arch=3Daarch64 --name=3Dtest8 =
--disk =
path=3D/var/lib/libvirt/images/jammy.qcow2,format=3Dqcow2,device=3Ddisk,bu=
s=3Dvirtio,cache=3Dnone --memory=3D2048 --vcpu=3D1 --nographic --check =
all=3Doff --features acpi=3Doff --import --os-variant=3Dubuntu22.04 =
--virt-type kvm --boot =
kernel=3DImage-guest-cca-v4,initrd=3Drootfs.cpio,kernel_args=3D'earlycon =
console=3DttyAMA0 rdinit=3D/sbin/init rw root=3D/dev/vda acpi=3Doff' =
--network none

receives an error:

Starting install...
ERROR    internal error: QEMU unexpectedly closed the monitor =
(vm=3D'test8'): 2024-07-29T06:23:04.717118Z qemu-system-aarch64: could =
not load kernel '/home/realm/Image-guest-cca-v4=E2=80=99

I am not sure how to investigate as the kernel Image =
(Image-guest-cca-v4) can work if it is used directly with the =
qemu-system-aarch64, like:

sudo qemu-system-aarch64 -kernel Image-guest-cca-v4 -initrd rootfs.cpio =
-cpu host -M virt,gic-version=3D3,acpi=3Doff -enable-kvm -smp 2 -m 2048M =
-nographic -append 'earlycon console=3DttyAMA0 rdinit=3D/sbin/init rw =
root=3D/dev/vda acpi=3Doff' -net none

Userland is Ubuntu 24.04, and the host and guest kernels are for the =
protected VM (Realm) execution.
Any help would be appreciated.

Thanks,
Itaru.=

