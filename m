Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A157895E9
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Aug 2023 12:22:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZqPj-00013A-I8; Sat, 26 Aug 2023 06:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qZqPP-00012j-Uz
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 06:20:49 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qZqPM-0002fH-A7
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 06:20:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A973F1CFE0;
 Sat, 26 Aug 2023 13:20:56 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 46F8823952;
 Sat, 26 Aug 2023 13:20:32 +0300 (MSK)
Message-ID: <2f63a7b2-e70f-42a4-a0c7-346e7e00ebda@tls.msk.ru>
Date: Sat, 26 Aug 2023 13:20:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Frederic Konrad <konrad.frederic@yahoo.fr>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: hw/display/xlinx-dp: fixing comment
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

Hopefully this address still works. If not, let's just commit Peter's comment.

Back in 2016, this commit introduced xlinx-dp.c:

commit 58ac482a66de09a7590f705e53fc6a3fb8a055e8
Author: Frederic Konrad <konrad.frederic@yahoo.fr>
Date:   Tue Jun 14 15:59:15 2016 +0100

     introduce xlnx-dp

     This is the implementation of the DisplayPort.
     It has an aux-bus to access dpcd and edid.


This commit has the following comment in it:

+static void xlnx_dp_audio_callback(void *opaque, int avail)
+{
+    /*
+     * Get some data from the DPDMA and compute these datas.
+     * Then wait for QEMU's audio subsystem to call this callback.
+     */

As it is, the commit is difficult to understand and has spelling
error in it (datas).  Is the following interpretation by Peter
Maydell correct?

    /*
     * Get the individual left and right audio streams from
     * the DPDMA, and fill the output buffer with the
     * combined stereo audio data adjusted by the volume
     * controls.
     * QEMU's audio subsystem will call this callback
     * repeatedly; we return it the data from the output
     * buffer until it is emptied, and then we will read
     * data from the DPDMA again.
     */

Thanks,

/mjt

