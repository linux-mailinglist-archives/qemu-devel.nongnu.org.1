Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4299D70623B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:09:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC71-0003Sd-50; Wed, 17 May 2023 04:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6p-0002sM-77
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:07 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6h-0000ud-Lc
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:06 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MmCyE-1qPUMm3dbc-00iC8J; Wed, 17
 May 2023 10:01:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 6/9] linux-user: Add new flag VERIFY_NONE
Date: Wed, 17 May 2023 10:01:49 +0200
Message-Id: <20230517080152.108660-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517080152.108660-1-laurent@vivier.eu>
References: <20230517080152.108660-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oAT+Una1TjyWTn6GqRDNTiKsxtCZy6xtgSSGjhEfdQKcl7CbQcJ
 RaCWc2yOlzNU71JGA4nhC6UylGF+tvDHKk6EmqR/B6h3P0AIRZjVzAO7xZWBpNAEpRgWupl
 uxcV8spH8DKinKRv1tfxF7Dq2SSvNkiom/bevSCOzDJuzoOGaxyURf4srHkmys4f4jrhAiK
 7FRLW6u3At6RDUXLlsoag==
UI-OutboundReport: notjunk:1;M01:P0:UjIRLd+bJ24=;ZKVpAVUDfOaPUv8JY/TOH8SLPCr
 igT8UlgfR3ON9VsXVN5AxJhY3OphOO612XhDOGZbDz7P58SsCnCg1rQuvg1SKawkAUYKIJjj/
 g/snzejH02m47m+qO95/7powrh6Y3biN+9AOdJbfyY5RzexHuFM1YHi2McMKweau3Tc4mrhgQ
 fM34t7XKQjhRD4kQ6TurIr4ZiqcEDcLkUPgDNl20izygtV5gUmYIOZvBD4+s4XVORbFRk3KST
 tJ3ZrsMwEB3Yjj6HtFxS/KIFFjQUl7AnAZZyExfeC/pbJ+48LcZ6hFpNS1MRMGisLrUb4ErBZ
 rlHiIsu2MsTtUng5v7cptiidBYpcYxQ/twt2FUJER0Ie76ur0E6L0Q9Fe4BYvdG5ylMQfcAWd
 e5SyNsUYJMVEWVDOQrritf8WKOg59T5vLHpedG+wSqKn2nTUQwIP9FiCsQssWR08f5UCTq/oy
 3NE+Cx7FUWloWzZJZnsYaDUkdeWpC/U56+B+n43GJh277xGmO8krgcunQ3ays8xdAx6/kGHJk
 D+NMzzNa5qCW1sP4x3fI3Jb5fPxQCxe5rjv/rYlnwPBa/1aYQ+sU+sVBJq8yA4t5ifMRuW/MB
 L/RkwCD1FxAAZZOeGNLKQ7NRE3MGERnveHEgI0hBgU+3RUjlQiAan1Sb1RLiPGu4L/SHAbrD4
 ivIhzfWk1uDbiKSByga8gt9DEk2DgMsFiL7hh/BX6g==
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
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


