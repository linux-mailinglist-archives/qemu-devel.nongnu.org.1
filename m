Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EA077F573
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 13:41:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWbMD-0005d4-C7; Thu, 17 Aug 2023 07:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qWbM6-0005c8-Px
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 07:39:58 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qWbM2-0001nD-ND
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 07:39:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 687C51B1AA
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 14:39:59 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B6EEB1FE9F
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 14:39:51 +0300 (MSK)
Message-ID: <f3079d7a-2bc4-9b94-2227-e630f0071670@tls.msk.ru>
Date: Thu, 17 Aug 2023 14:39:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: unrelated modules listed in modinfo files?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi!

Noticed relatively new modules, accel-tcg-i386.so and accel-tcg-x86_64.so
(built after commit dae0ec159f9205002696).  At first I thought these are
x86-specific, but it turns out these are listed in *all* qemu-system-*
binaries.  For example, during build, modinfo-s390x-softmmu.c contains:

},{
     /* accel-tcg-i386.modinfo */
     .name = "accel-tcg-i386",
     .arch =  "i386",
     .objs = ((const char*[]){  ("tcg" "-" "accel" "-ops"), NULL }),
},{
     /* accel-tcg-x86_64.modinfo */
     .name = "accel-tcg-x86_64",
     .arch =  "x86_64",
     .objs = ((const char*[]){  ("tcg" "-" "accel" "-ops"), NULL }),
},{



Also, all the qtest "accel" modules are in there too, eg

},{
     /* accel-qtest-xtensa.modinfo */
     .name = "accel-qtest-xtensa",
     .arch =  "xtensa",
     .objs = ((const char*[]){  ("qtest" "-" "accel"),  ("qtest" "-" "accel" "-ops"), NULL }),
},{


Shouldn't these be arch-specific, and be included only in the binaries where it
makes sense?  Like, for example, hw-s390x-virtio-gpu-ccw is a module specific
to s390x architecture, and it is not listed in other .modinfo files besides
s390x one, like this:

},{
     /* hw-s390x-virtio-gpu-ccw.modinfo */
     /* module VIRTIO_CCW isn't enabled in Kconfig. */
/* },{



Also, why do we have this check in module_load() to begin with:

                 if (!module_check_arch(modinfo)) {
                     error_setg(errp, "module arch does not match: "
                         "expected '%s', got '%s'", module_arch, modinfo->arch);
                     goto out;
                 }


?

