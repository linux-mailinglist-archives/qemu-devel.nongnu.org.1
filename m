Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1893670AD6C
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 12:25:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0gER-0004Gw-Kd; Sun, 21 May 2023 06:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0gEQ-0004GL-2v
 for qemu-devel@nongnu.org; Sun, 21 May 2023 06:24:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0gEN-0003K9-Ok
 for qemu-devel@nongnu.org; Sun, 21 May 2023 06:24:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 4BCA45C00FF;
 Sun, 21 May 2023 06:24:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Sun, 21 May 2023 06:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1684664643; x=
 1684751043; bh=0784/bt8cqIJNIgnKytV5uBzkiiFa5ovKD7coZu8JNo=; b=h
 WBq7V51s9xUzBRRHtTkHLogE/rsjXe5uO0vdWoEwRhEMm6quSuLZ8wNWFj5bLV1a
 pa1gOXgwCKJeHg8BoccCSbgHBklMhBFIjGhUq8CCYEtX7i0pMZNzdMhFz9LCEmRj
 XcMLjlRUoKX3IXMrNG3hTHgWbPLsRGUXEODZ565U3CMWEIbicozKO5RxuB7ec16q
 5k05h2XC7fiwS75iAnTSi0mI0GyyYx1BNkBt5JV4jPo1ZQ3NlZvqnpOSaCWDQ8zw
 6px68ZY417aTSjq8CKSyVZa/QOgkbA2pmxjmw4PBw2n60q/N3HsjkwCZLivjugCN
 Vsv0PUvUChSttA2GtZFTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684664643; x=
 1684751043; bh=0784/bt8cqIJNIgnKytV5uBzkiiFa5ovKD7coZu8JNo=; b=C
 fdFSzVq17U1Y1mIr+3Y6UZXclI1v5bCBtx0Fb8B8gwEnHJ0oAJ9xQ8mMfTqrBTyj
 Nyj64NYW606V+Eimw3Pkc1qckZYYeXqETWEnZA+dUZ1rU+vt4XM1VB5TkVpuQ5Jz
 Rvi1lmM3OsRuQqMeN3fDb70STEWiwwX3M2841M19oX2QQxL/5A5k5smekspsfH6I
 tti7jKsVrcyN5xoq6HnE1yD9S6xIGc/FAHqQHB+p6L7yj0gETDkZo4DSB6Zz0jYo
 JnPbtS7A5NLMjZlNbXhZ8c9Bpd+zeqXQli+pSeYYT1AgSs5Asiull5flu6G0woIp
 v3qSDYm2nAIHGOL09RV+g==
X-ME-Sender: <xms:Q_FpZAsgdBROjnM2yfprCCCGoJ5B2xszitueUe1Pd5kKKW8nmZbREw>
 <xme:Q_FpZNeiVWZUVW2o9pZfCLve2Ja_ZGSTzPd3gtsURU8cFHmebcWsFx_d19jR1TYrh
 lDa-3OT6K2PM4ceuSI>
X-ME-Received: <xmr:Q_FpZLzXVwrlfkBrG-B2UagO1f4WrbqHUb3SK9Z6_To3q9Np3xgpNyPG2u2K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiledgvdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
 ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepgfelgeekvddtjedule
 dutdfffeeutdfgkedvgfeftdelveffjeekfeehffegteegnecuffhomhgrihhnpeguvggs
 ihgrnhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
 tghomh
X-ME-Proxy: <xmx:Q_FpZDMvbYEsOPgu3cuXLDOCLc7JMg_c7d3MQkR1GfRDYwA33fzo2g>
 <xmx:Q_FpZA-vLC034_pGS86w98_0auJQm9i_2WBc-WxCBIDV-ij8dinZ7Q>
 <xmx:Q_FpZLWfCEa-IU94YS_4AUCHGm9vZy8yYem_1wXIrBn-g_RXCFDV9A>
 <xmx:Q_FpZNOQ2QJdplfZ2lkmqZFRgOwtNbplqTX7PRNW6BwODgMHBAOUtA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 May 2023 06:24:01 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Cc: yangxiaojuan@loongson.cn, gaosong@loongson.cn, philmd@linaro.org,
 chenhuacai@kernel.org, crosa@redhat.com, wainersm@redhat.com,
 bleal@redhat.com, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 4/4] tests/avocado: Add boot_linux_console test for
 loongson3-virt
Date: Sun, 21 May 2023 11:23:07 +0100
Message-Id: <20230521102307.87081-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.25; envelope-from=jiaxun.yang@flygoat.com;
 helo=out1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, PDS_BTC_ID=0.017,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Test loongson3-virt machine againt debian kernel and cpio rootfs.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 tests/avocado/boot_linux_console.py | 46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index c0675809e641..fdb479448e47 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -191,6 +191,52 @@ def test_mips64el_fuloong2e(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
+    def test_mips64el_loongson3_virt_cpio(self):
+        """
+        :avocado: tags=arch:mips64el
+        :avocado: tags=endian:little
+        :avocado: tags=machine:loongson3-virt
+        :avocado: tags=cpu:Loongson-3A1000
+        :avocado: tags=device:liointc
+        :avocado: tags=device:loongarch_ipi
+        :avocado: tags=device:goldfish_rtc
+        """
+        deb_url = ('http://snapshot.debian.org/archive/debian/'
+                   '20230501T024743Z/pool/main/l/linux/'
+                   'linux-image-5.10.0-22-loongson-3_5.10.178-3_mips64el.deb')
+        deb_hash = 'af4fcc721b727df0bef31057325e4cc02725ae0c'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                        '/boot/vmlinuz-5.10.0-22-loongson-3')
+        initrd_url = ('https://github.com/groeck/linux-build-test/'
+                      'raw/8584a59e/rootfs/'
+                      'mipsel64/rootfs.mipsel64r1.cpio.gz')
+        initrd_hash = '1dbb8a396e916847325284dbe2151167'
+        initrd_path_gz = self.fetch_asset(initrd_url, algorithm='md5',
+                                          asset_hash=initrd_hash)
+        initrd_path = self.workdir + "rootfs.cpio"
+        archive.gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0,115200 '
+                               + 'rdinit=/sbin/init noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'ICT Loongson-3')
+        exec_command_and_wait_for_pattern(self, 'uname -a',
+                                                '5.10.0-22-loongson-3')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
+
     def test_mips_malta_cpio(self):
         """
         :avocado: tags=arch:mips
-- 
2.39.2 (Apple Git-143)


