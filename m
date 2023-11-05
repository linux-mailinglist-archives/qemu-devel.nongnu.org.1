Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2E87E1337
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 12:50:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzbcw-00035f-2j; Sun, 05 Nov 2023 06:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qzbcs-00035R-Ss
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 06:49:11 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qzbcq-0002K3-Ju
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 06:49:10 -0500
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1qzbcp-0003Yo-8i; Sun, 05 Nov 2023 12:49:07 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
Subject: [PULL 9/9] MAINTAINERS: Add an entry for Hyper-V Dynamic Memory
 Protocol
Date: Sun,  5 Nov 2023 12:47:57 +0100
Message-ID: <2b49ecabc6bf15efa6aa05f20a7c319ff65c4e11.1699184105.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1699184105.git.maciej.szmigiero@oracle.com>
References: <cover.1699184105.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e8a7d5be5de..d4a480ce5a62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2656,6 +2656,14 @@ F: hw/usb/canokey.c
 F: hw/usb/canokey.h
 F: docs/system/devices/canokey.rst
 
+Hyper-V Dynamic Memory Protocol
+M: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
+S: Supported
+F: hw/hyperv/hv-balloon*.c
+F: hw/hyperv/hv-balloon*.h
+F: include/hw/hyperv/dynmem-proto.h
+F: include/hw/hyperv/hv-balloon.h
+
 Subsystems
 ----------
 Overall Audio backends

