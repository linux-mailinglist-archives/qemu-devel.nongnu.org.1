Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1986B7A924B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:52:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjETm-0002xh-I1; Thu, 21 Sep 2023 03:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qjETi-0002xW-7f
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:52:03 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qjETe-0000tU-OR
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:52:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BDA1923D42;
 Thu, 21 Sep 2023 10:52:16 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8876F299AD;
 Thu, 21 Sep 2023 10:51:55 +0300 (MSK)
Message-ID: <fd2b7868-2ac5-64a1-d66f-3025c1da6bd1@tls.msk.ru>
Date: Thu, 21 Sep 2023 10:51:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Vikram Garhwal <vikram.garhwal@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: intermittent qtest-aarch64/xlnx-canfd-test test failure
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi!

While doing stable-8.1.1 preparation, I've a CI failure of ubuntu-20.04-s390x-all here:

https://gitlab.com/qemu-project/qemu/-/jobs/5132720046

▶ ERROR:../tests/qtest/xlnx-canfd-test.c:265:match_rx_tx_data: \
   assertion failed ((buf_rx[size] & DLC_FD_BIT_MASK) == (buf_tx[size] & DLC_FD_BIT_MASK)): (2281701376 == 2147483648)

  qemu:qtest+qtest-aarch64 / qtest-aarch64/xlnx-canfd-test  \
            ERROR           0.77s   killed by signal 6 SIGABRT

Re-run of this test went successfully.  However, the assert looks
a bit scary, and the fact that it does not fail in a reliable way
is a bit troubling too.  Is it a flaky test or there's something
else in qemu with concurrent threads?

I don't see this assert in previous test runs.  But ubuntu-20.04-s390x-all
test fails quite often due to other reasons, so it isn't conclusive.

Should something be done with this?

The testing is done for commit f2fc49c302036315db6e8c9f74592decc3be0476,
which is in staging-8.1 branch only temporarily.

Thanks,

/mjt

