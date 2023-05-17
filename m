Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A5D706229
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:04:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC71-0003Tc-Nc; Wed, 17 May 2023 04:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6k-0002mP-7y
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:02 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6h-0000ub-JV
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:01 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M3DeV-1q0Z1E16Wz-003b4A; Wed, 17
 May 2023 10:01:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 7/9] linux-user: Don't require PROT_READ for mincore
Date: Wed, 17 May 2023 10:01:50 +0200
Message-Id: <20230517080152.108660-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517080152.108660-1-laurent@vivier.eu>
References: <20230517080152.108660-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cqryMb7V7oFhMu2vdHsnFSagyd+sZZB1Bi3Fr2Jz17mWuf8DSyo
 BLHml4hLjgOhX0WfYkcZ9mezhguGDMKOrfpXRHXDv6GJp74YgM0MRAkVa1UsFC7Whcrza4q
 wvR3GgHLCmEzYifgfqhfLNZK3Wi53MxPsZRmkinRYt++/WVzLo3T9clu5NDXymGR3UKzjpM
 kuVUSpUgp05AIwS+1C6QA==
UI-OutboundReport: notjunk:1;M01:P0:k3ah0thcQ8I=;a0SoY/SSPjdLBBXmglTjHVBIXuV
 Rpi+2AiBHgNa5H7ZqCcxZT+aW4ykXUIGXwKaik+WQvDhFffOEhFu7k5gmevagahVbWoldA6AH
 jPXVSRUQLge9UeZSrR0GGHhEY/CHjn/fSmPU7gtDkbd9CBUWMvmO86v3hLuzPKOU9MFUoBVS+
 0OxgUO9+o8VQPsZswA9SSOA18AeG1z1XaBwRPFI/WdjgBvtS+YjZgDFqki+ApyPhCzwB5zJIz
 Wxb0jEJCCI4rncYef3ujotFrI9Z5GB8eBpymRUCD4F8NY6AjquhVzrGYf5G6Yx7jZ5/uVuf6f
 IhRpokMpbXi00++KcS7QdVPllPoEc7ruy4ViqAeNGZlZJA+PhEBdZggfRCy+YZ10YOVjKQmS+
 /nsdLhfoul3O/w0f7xRHL5Opyt/ofL3vrmNWK+fxMupMePoJYl2RA+YReEEnDHgKq7gOPYJHw
 P+0L49t04/+fATN6/z9S7yv4XqFhtVkEUGXw+zdKx3v8pqzqv0kFQAQbCP7nFHtgp/A1BrUip
 v4nfdH1VYtfcG1MY+Xvb67KwG2IIh0in/LNNyB5SYlMSYxPAlYDDVrLDG0RL3JkOo4yfFNZvV
 5cSPgmIyH2nKuS4+xGEJr0LXufHpXvWOvzVa32ohQPR86OQsw/8aedRwymFhuAgIGtc6MLMoL
 HF/yD8I/rNqz7dFhMlEyY4FmHFsplVgcQQdoWWkzNw==
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
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

The kernel does not require PROT_READ for addresses passed to mincore.
For example the fincore(1) tool from util-linux uses PROT_NONE and
currently does not work under qemu-user.

Example (with fincore(1) from util-linux 2.38):

$ fincore /proc/self/exe
RES PAGES  SIZE FILE
24K     6 22.1K /proc/self/exe

$ qemu-x86_64 /usr/bin/fincore /proc/self/exe
fincore: failed to do mincore: /proc/self/exe: Cannot allocate memory

With this patch:

$ ./build/qemu-x86_64 /usr/bin/fincore /proc/self/exe
RES PAGES  SIZE FILE
24K     6 22.1K /proc/self/exe

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230422100314.1650-3-thomas@t-8ch.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 00a779797efb..6655982821ba 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11993,7 +11993,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_mincore
     case TARGET_NR_mincore:
         {
-            void *a = lock_user(VERIFY_READ, arg1, arg2, 0);
+            void *a = lock_user(VERIFY_NONE, arg1, arg2, 0);
             if (!a) {
                 return -TARGET_ENOMEM;
             }
-- 
2.40.1


