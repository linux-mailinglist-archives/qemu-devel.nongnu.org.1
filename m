Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D31DB08B40
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Jul 2025 12:55:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucMGM-0007F2-CY; Thu, 17 Jul 2025 06:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucMGF-00079w-JQ; Thu, 17 Jul 2025 06:54:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucMGD-00036r-AN; Thu, 17 Jul 2025 06:54:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B69F3137E1B;
 Thu, 17 Jul 2025 13:54:34 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B1594249265;
 Thu, 17 Jul 2025 13:54:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.19 v2 00/26] Patch Round-up for stable 7.2.19,
 freeze on 2025-07-21
Date: Thu, 17 Jul 2025 13:54:29 +0300
Message-ID: <qemu-stable-7.2.19-20250717135416@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following patches are queued for QEMU stable v7.2.19:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2025-07-21, and the release is planned for 2025-07-23:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* fb8e59abbe46 Jamin Lin:
   hw/misc/aspeed_hace: Ensure HASH_IRQ is always set to prevent firmware 
   hang
02* a9403bfcd930 Huaitong Han:
   vhost: Don't set vring call if guest notifier is unused
03* 5ddd6c8dc849 Volker Rümelin:
   audio: fix SIGSEGV in AUD_get_buffer_size_out()
04* eef2dd03f948 Fiona Ebner:
   hw/core/qdev-properties-system: Add missing return in set_drive_helper()
05* 9c55c03c05c1 Bibo Mao:
   hw/loongarch/virt: Fix big endian support with MCFG table
06* f5ec751ee70d Shameer Kolothum:
   hw/arm/virt: Check bypass iommu is not set for iommu-map DT property
07* e372214e663a Ethan Chen:
   qemu-options.hx: Fix reversed description of icount sleep behavior
08* 5ad2b1f443a9 J. Neuschäfer:
   linux-user/arm: Fix return value of SYS_cacheflush
09* 0d0fc3f46589 Richard Henderson:
   tcg: Fix constant propagation in tcg_reg_alloc_dup
10* a412575837b6 Philippe Mathieu-Daudé:
   target/arm: Correct KVM & HVF dtb_compatible value
11* f9b0f6930407 Richard Henderson:
   target/arm: Fix SME vs AdvSIMD exception priority
12* b4b2e070f41d Richard Henderson:
   target/arm: Fix sve_access_check for SME
13* e6ffd009c771 Richard Henderson:
   target/arm: Fix 128-bit element ZIP, UZP, TRN
14* 3801c5b75ffc Richard Henderson:
   target/arm: Fix PSEL size operands to tcg_gen_gvec_ands
15* cfc688c00ade Richard Henderson:
   target/arm: Fix f16_dotadd vs nan selection
16 e4e839b2eeea Geoffrey Thomas:
   linux-user: Hold the fd-trans lock across fork
17 983899eab493 Chaney, Ben:
   migration: Don't sync volatile memory after migration completes
18 091c7d7924f3 Alejandro Jimenez:
   amd_iommu: Fix Miscellaneous Information Register 0 encoding
19 c63b8d1425ba Alejandro Jimenez:
   amd_iommu: Fix Device ID decoding for INVALIDATE_IOTLB_PAGES command
20 ff3dcb3bf652 Alejandro Jimenez:
   amd_iommu: Update bitmasks representing DTE reserved fields
21 108e10ff6909 Alejandro Jimenez:
   amd_iommu: Fix masks for various IOMMU MMIO Registers
22 123cf4bdd378 Alejandro Jimenez:
   amd_iommu: Fix mask to retrieve Interrupt Table Root Pointer from DTE
23 67d3077ee403 Alejandro Jimenez:
   amd_iommu: Fix the calculation for Device Table size
24 5959b641c98b Alejandro Jimenez:
   amd_iommu: Remove duplicated definitions
25 5788929e05e1 Ethan Milon:
   amd_iommu: Fix truncation of oldval in amdvi_writeq
26 aef22331b5a4 Akihiko Odaki:
   ui/vnc: Do not copy z_stream

(commit(s) marked with * were in previous series and are not resent)

