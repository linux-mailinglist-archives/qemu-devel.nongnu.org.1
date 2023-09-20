Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FD57A7E73
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:17:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiw8F-0002OE-TD; Wed, 20 Sep 2023 08:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiw83-0002Dp-0T; Wed, 20 Sep 2023 08:16:31 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiw7y-0005La-Eh; Wed, 20 Sep 2023 08:16:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 23A5B23A02;
 Wed, 20 Sep 2023 15:16:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 839D5296F9;
 Wed, 20 Sep 2023 15:15:55 +0300 (MSK)
Received: (nullmailer pid 105898 invoked by uid 1000);
 Wed, 20 Sep 2023 12:15:53 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 60/63] hw/tpm: TIS on sysbus: Remove unsupport ppi
 command line option
Date: Wed, 20 Sep 2023 15:15:45 +0300
Message-Id: <20230920121553.105832-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230920151401@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230920151401@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Stefan Berger <stefanb@linux.ibm.com>

The ppi command line option for the TIS device on sysbus never worked
and caused an immediate segfault. Remove support for it since it also
needs support in the firmware and needs testing inside the VM.

Reproducer with the ppi=on option passed:

qemu-system-aarch64 \
   -machine virt,gic-version=3 \
   -m 4G  \
   -nographic -no-acpi \
   -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
   -tpmdev emulator,id=tpm0,chardev=chrtpm \
   -device tpm-tis-device,tpmdev=tpm0,ppi=on
[...]
Segmentation fault (core dumped)

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20230713171955.149236-1-stefanb@linux.ibm.com
(cherry picked from commit 4c46fe2ed492f35f411632c8b5a8442f322bc3f0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 45e63efd63..6724b3d4f6 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -93,7 +93,6 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
 static Property tpm_tis_sysbus_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
-    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.39.2


