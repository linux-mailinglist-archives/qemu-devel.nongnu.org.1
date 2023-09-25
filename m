Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AE67ADB0A
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:11:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknEd-0008Ux-1C; Mon, 25 Sep 2023 11:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qknEN-0008EL-6O
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:10:39 -0400
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qknEK-0005LI-Nz
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:10:38 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MJmX3-1r4OXp2F0T-00K9Ym; Mon, 25
 Sep 2023 17:10:32 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 4/5] linux-user/syscall.c: clean up local variable shadowing
 in TARGET_NR_getcpu
Date: Mon, 25 Sep 2023 17:10:28 +0200
Message-ID: <20230925151029.461358-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925151029.461358-1-laurent@vivier.eu>
References: <20230925151029.461358-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cp5dII6cz88MTj0fA1R1qPDmWd1psJxUUAR6VVu3GthE25r/YIl
 TEs+hoOHlRnUjcnNPQFhXoz5lhb/Hm0O/T6afo8Sq+ROEcfF4k8wcVyadvRfjLjLApz6PtD
 mIGrXp6Z8A7KiTidIaW1DS5/NgvNR554049Ke/QC56enQZvmcwXpZxYS2LSt0VuT5ycBO3b
 1BrEKA7LSVhmwmDdHUI8Q==
UI-OutboundReport: notjunk:1;M01:P0:j471AQwSMtM=;vlXNSr11vhmXo9Cc37ngCW+XZcc
 Yv7dtsmGHUmyMibeo9nJ/a57/tI6EU2XVbt8wd7BHmTitfo6QZF105+dSe/+eJYaU6UoiyecS
 Rcl0ylyAyvPQC+L+v0VdyFvRQLGfFlSCQx8enM+U1K0CkYY5lq37I1Nd3hq0292eM5uHvOmuB
 ZVIwXxHzBOj4xT+EiGNYj6c9VkmMtj2+nu7VcNbctkEcsC1h4NtALpaYBYs0M02y4w5LWo2xd
 ufZqnISd4JpjyE4LR0+JRKeWeiJWbHRl2/c8eZ/AsvTjyeKPM2LyVJz6ZJ1ltoLCqaS9T1qyK
 KKrBZwM7wzdGAjo9npyavZ7QNv5bg+Y8hVPSoUFqxPJ3D59WAyHPNb46YN1AGdXIIa9IrwUEt
 oJwM5wI64i5YrtECoDDm2aQTT6yOK/iRCUvezR61r1XJnPysWJe5QmkhYAURrORamH6BRkbWt
 qyueo7EcAo3e8EBexsbZDJzaSCLIlhHoZxaWCuziq0eGoKBg6O1urU4gHCBxxQ6yW31MQ1bKQ
 ITQm03JWfAMOhWhcXvGY5XfkItxlJLU2iXmRF5hBGPu4kHpQHluMmMvUh9Ja3C/AMgJyR2hYd
 XPghZZTJG7zgDCvXCUvDUqZEfGKDgHE8CpQRrnBtCTxk09YAQ+X3ztRxll8/QHBLL/VVV2Qjp
 GiF6s8EVJb4tHNQuL66gf1SsrtAS+LtYt88y8S93poNNfhjHgrBiYpH10AiTPwaAuN2CiF+0Z
 6xxP9cC6LSjAZ3rXZg57Mf1g0qDTDrqTx5ECADsBkwFToTILdIYHYnGhLH7pmvJllTnHwYaY8
 idiXQY/XA1WMl0ldEKuqZF7VkyEQYta5lR9F1srmscwH4Z0/fWQE1FSQiHdhd+AG7a88KwyCd
 nn28P1/3fX9fQ5w==
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Fix following warnings:

.../linux-user/syscall.c: In function 'do_syscall1':
.../linux-user/syscall.c:11180:22: warning: declaration of 'cpu' shadows a previous local [-Wshadow=local]
11180 |             unsigned cpu, node;
      |                      ^~~
.../linux-user/syscall.c:8963:15: note: shadowed declaration is here
 8963 |     CPUState *cpu = env_cpu(cpu_env);
      |               ^~~

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c81e8d344486..6139c00ddceb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11177,14 +11177,14 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         }
     case TARGET_NR_getcpu:
         {
-            unsigned cpu, node;
-            ret = get_errno(sys_getcpu(arg1 ? &cpu : NULL,
+            unsigned cpuid, node;
+            ret = get_errno(sys_getcpu(arg1 ? &cpuid : NULL,
                                        arg2 ? &node : NULL,
                                        NULL));
             if (is_error(ret)) {
                 return ret;
             }
-            if (arg1 && put_user_u32(cpu, arg1)) {
+            if (arg1 && put_user_u32(cpuid, arg1)) {
                 return -TARGET_EFAULT;
             }
             if (arg2 && put_user_u32(node, arg2)) {
-- 
2.41.0


