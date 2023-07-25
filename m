Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 381B6761B26
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:13:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIkp-00058I-Gr; Tue, 25 Jul 2023 10:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIkk-0004hs-MH; Tue, 25 Jul 2023 10:11:06 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIki-0007ld-Rz; Tue, 25 Jul 2023 10:11:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 098A516171;
 Tue, 25 Jul 2023 17:10:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A02761950A;
 Tue, 25 Jul 2023 17:10:13 +0300 (MSK)
Received: (nullmailer pid 3372614 invoked by uid 1000);
 Tue, 25 Jul 2023 14:10:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 00/14] Patch Round-up for stable 7.2.5,
 freeze on 2023-08-05
Date: Tue, 25 Jul 2023 17:10:09 +0300
Message-Id: <qemu-stable-7.2.5-20230725170615@cover.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230725170615@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230725170615@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

The following patches are queued for QEMU stable v7.2.5:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2023-08-05, and the release is planned for 2023-08-07:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 230dfd9257e9 Olaf Hering:
   hw/ide/piix: properly initialize the BMIBA register
02 d921fea338c1 Mauro Matteo Cascella:
   ui/vnc-clipboard: fix infinite loop in inflate_buffer (CVE-2023-3255)
03 518f32221af7 Helge Deller:
   linux-user: Fix qemu-arm to run static armhf binaries
04 03b67621445d Denis V. Lunev:
   qemu-nbd: pass structure into nbd_client_thread instead of plain char*
05 5c56dd27a2c9 Denis V. Lunev:
   qemu-nbd: fix regression with qemu-nbd --fork run over ssh
06 761b0aa9381e Ilya Leoshkevich:
   target/s390x: Make CKSM raise an exception if R2 is odd
07 4b6e4c0b8223 Ilya Leoshkevich:
   target/s390x: Fix CLM with M3=0
08 53684e344a27 Ilya Leoshkevich:
   target/s390x: Fix CONVERT TO LOGICAL/FIXED with out-of-range inputs
09 a2025557ed4d Ilya Leoshkevich:
   target/s390x: Fix ICM with M3=0
10 9c028c057adc Ilya Leoshkevich:
   target/s390x: Make MC raise specification exception when class >= 16
11 ff537b0370ab Ilya Leoshkevich:
   target/s390x: Fix assertion failure in VFMIN/VFMAX with type 13
12 c34ad459926f Thomas Huth:
   target/loongarch: Fix the CSRRD CPUID instruction on big endian hosts
13 ee071f67f7a1 Viktor Prutyanov:
   vhost: register and change IOMMU flag depending on Device-TLB state
14 cd9b83468843 Viktor Prutyanov:
   virtio-net: pass Device-TLB enable/disable events to vhost

