Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4738D4C97
	for <lists+qemu-devel@lfdr.de>; Thu, 30 May 2024 15:26:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfn0-0003ll-2o; Thu, 30 May 2024 09:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1sCXRE-0005Su-FP
 for qemu-devel@nongnu.org; Thu, 30 May 2024 00:30:53 -0400
Received: from out-179.mta1.migadu.com ([95.215.58.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1sCXR7-0000g3-2G
 for qemu-devel@nongnu.org; Thu, 30 May 2024 00:30:48 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1717043434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IsSqR/9PrUFezTcU0F9N/cE2YB56p4PWUZ0YgmQQVvo=;
 b=fu7+0j0ic9rTW1uqCQuFHkuvB5qRHw0xHVgz7tZqZStL8/zrvl3baHpegFb2ce5n4YulUJ
 5QIYp5RQ0cQIIG7E6TCu8OgJ2bB4LnqMHt2pxIhEHbsvDrBEg+vgGAefIT57JHX6ns0Iu9
 /XcXXJM4CUGoBxIvmb85gePAGv1TjR8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Unexpected error in rme_configure_one() at ../target/arm/kvm-rme.c:159
Message-Id: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
Date: Thu, 30 May 2024 13:30:17 +0900
To: qemu-devel@nongnu.org
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.179;
 envelope-from=itaru.kitayama@linux.dev; helo=out-179.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 30 May 2024 09:25:50 -0400
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

When I see a Realm VM creation fails with:

Unexpected error in rme_configure_one() at ../target/arm/kvm-rme.c:159:
qemu-system-aarch64: RME: failed to configure SVE: Invalid argument
test.sh: line 8:  2502 Aborted                 qemu-system-aarch64 -M =
'virt,acpi=3Doff,gic-version=3D3' -cpu host -enable-kvm -smp 2 -m 512M =
-overcommit 'mem-lock=3Don' -M 'confidential-guest-support=3Drme0' =
-object =
'rme-guest,id=3Drme0,measurement-algo=3Dsha512,num-pmu-counters=3D6,sve-ve=
ctor-length=3D256' -kernel Image -initrd rootfs.cpio -append 'earycon =
console=3DttyAMA0 rdinit=3D/sbin/init' -nographic -net none

do I need to suspect first the VMM, QEMU, or the Image? The kernel is =
built with LLVM, does it matter?

Thanks,
Itaru.=

