Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE823704E0A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 14:49:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyu6J-0004Lg-C7; Tue, 16 May 2023 08:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6G-0004JC-8L
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:20 -0400
Received: from mout.kundenserver.de ([212.227.126.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6D-00063E-I7
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:19 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MNfgZ-1pmyxA0eRn-00P8Pz; Tue, 16
 May 2023 14:48:15 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 6/9] linux-user: Add new flag VERIFY_NONE
Date: Tue, 16 May 2023 14:48:07 +0200
Message-Id: <20230516124810.90494-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516124810.90494-1-laurent@vivier.eu>
References: <20230516124810.90494-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SPkbVstJZDvesHceEMJLQg5s0j3O+V3rLtfzIVRJPPVrVScuQ5y
 hCTIDAbz0ThjSvN9fen8ku6BR/qyeiqjVmvKY1/srczw9T3GFYgjAwFn/8XjJNupIuOFAUx
 iO6hrLkoiHw4Okp4x33WShG2FMsMs3Bc+PPf3JCopXsAjkAHJNTYyay1B5xpHJ6MxNSeYLM
 KqmcvN+gBIp7mHBVJCw7A==
UI-OutboundReport: notjunk:1;M01:P0:Hntt3cMpydw=;jtiyvER8NGXjqQ3PiWCQ9zEFRQH
 kPm5Cs1bI+NqErn4jG+AfWAQaWVROwsQIOGDpsykWjWrhJ5aviByRZP49v408aPsw9XEsXcrD
 miJeIYnc3MTsY9URXTA/U3GYnqCKY6phR9/8lHlstOavrbAONPHnlf97rZAuavvL1TDjEM7u/
 rd2Hyg9g2o9o87V1fpszrQGi55k+NNbRVd3Ptc6KQ0KdnNZTuP6+R9GHArV2f61dOz5AjpFMM
 sVcOfNzFVZx15cDz//BzXrSrs3mIKvDNhddnh9mapP/1pGOagueAazWmsEH/4yKRj/GLqDzVh
 arbKWs9AzD2vyoF8BaGAK22AqwtZIFSD03xpWrncNfXqwJIcKX6zT2iASAMi5D7wVH/BibFGo
 2zJloLf251eo4KHf1L4SkM9U7mx8wTfqmOfqVylbTYyFVMvXoQFS6I728BKjNVcWl77c97WsB
 kM85jdPf1jz1u90/q/54Zu81ReEQWHDa1tpR0MXID2ZAamAQl37iOzn7TzbQI62xFLeaLh6Ws
 9kTy0AC4DSD0l/QPgZkO030hJED8ZByQnzsUfrGER76B4CBWnlTFj96kRY+5vSzDn9SvD4cbV
 //2lPytGh4IJUx7YeRlcR8NtyYXJRUgJIpQvcx7xaZ6c/k7+6tgp5Yt0R/ONixS5T2PtOp5BU
 x6Otg0wSCF6Vl8C1scb1FDE2KywHjdB0onNw9k7ShQ==
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Thomas Weißschuh <thomas@t-8ch.de>

This can be used to validate that an address range is mapped but without
being readable or writable.

It will be used by an updated implementation of mincore().

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230422100314.1650-2-thomas@t-8ch.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/qemu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index e2e93fbd1d5d..92f9f5af41c7 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -168,6 +168,7 @@ abi_long do_brk(abi_ulong new_brk);
 
 /* user access */
 
+#define VERIFY_NONE  0
 #define VERIFY_READ  PAGE_READ
 #define VERIFY_WRITE (PAGE_READ | PAGE_WRITE)
 
-- 
2.40.1


