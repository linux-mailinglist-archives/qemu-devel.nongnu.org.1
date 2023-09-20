Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A7B7A7193
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 06:48:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qip6s-0001dk-Q5; Wed, 20 Sep 2023 00:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qip6p-0001dQ-Na
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 00:46:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qip6n-00039f-M6
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 00:46:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 286DC236C3;
 Wed, 20 Sep 2023 07:46:56 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5BD58293D2;
 Wed, 20 Sep 2023 07:46:36 +0300 (MSK)
Message-ID: <84f08f14-7911-4cdc-04e6-548287349d00@tls.msk.ru>
Date: Wed, 20 Sep 2023 07:46:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: stable-8.1.1: which bug do we keep?
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

I'm in somewhat doubt what to do with 8.1.1 release.

There are 2 compelling issues, fixing one discovers the other.

https://gitlab.com/qemu-project/qemu/-/issues/1864
"x86 VM with TCG and SMP fails to start on 8.1.0"
is fixed by 0d58c660689f "softmmu: Use async_run_on_cpu in tcg_commit"

But this brings up

https://gitlab.com/qemu-project/qemu/-/issues/1866
"mips/mip64 virtio broken on master (and 8.1.0 with tcg fix)"
(which is actually more than mips, as I've shown down the line,
https://gitlab.com/qemu-project/qemu/-/issues/1866#note_1558221926 )

Also, one commit alone,
86e4f93d827 "softmmu: Assert data in bounds in iotlb_to_section",
when not followed with "async_run_on_cpu in tcg_commit", causes
assertion failures, eg
https://www.mail-archive.com/qemu-devel@nongnu.org/msg989846.html
I don't know if "async_run_on_cpu in tcg_commit" was supposed to
fix this assertion or not, or maybe some additional fix is needed, -
but I haven't see this is triggered with 0d58c660689f applied.

There were at least two attempts by Richard to fix issues after
0d58c660689f, one "accel/tcg: Always require can_do_io", which fixes
both reproducers for #1866 but at a high cost, and another,
"softmmu: Introduce cpu_address_space_sync", which addresses the
mips regression but does not fix my reproducer with ovmf
and none of the 2 landed on master so far.

Right now I have a "which bug to keep?" situation for 8.1.1, and
I'd love to have at least *some* comments about all this.  I've got
no replies to my earlier emails in this area.

To mee, it *feels* like 0d58c660689f should be there.
Note: the scheduled deadline for staging-8.1.1 is gone yesterday.
But this stuff seems to be important enough to delay 8.1.1 further.

Just some comments please? :)

Thank you!

/mjt

