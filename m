Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CFA786061
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 21:12:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYtGf-0008Ag-Nk; Wed, 23 Aug 2023 15:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYtGG-00089o-9P
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 15:11:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYtGC-00086s-1M
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 15:11:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A20461C716;
 Wed, 23 Aug 2023 22:11:34 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4DB4A215E2;
 Wed, 23 Aug 2023 22:11:15 +0300 (MSK)
Message-ID: <357b7f2c-da44-e653-5edc-02f05bd8be56@tls.msk.ru>
Date: Wed, 23 Aug 2023 22:11:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 24/24] misc/other: spelling fixes
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
 <20230823065335.1919380-23-mjt@tls.msk.ru>
 <jmq5dlhxylaq47ortk242z3yqnmkgcfdvcbia3rgu4tuwblbj7@3t64tyl7fdxv>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <jmq5dlhxylaq47ortk242z3yqnmkgcfdvcbia3rgu4tuwblbj7@3t64tyl7fdxv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.684,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

23.08.2023 21:23, Eric Blake wrote:
> On Wed, Aug 23, 2023 at 09:53:35AM +0300, Michael Tokarev wrote:
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> ---
>>   accel/tcg/tb-maint.c       | 2 +-
>>   backends/tpm/tpm_ioctl.h   | 2 +-
>>   chardev/char-socket.c      | 6 +++---
>>   chardev/char.c             | 2 +-
>>   contrib/plugins/cache.c    | 2 +-
>>   contrib/plugins/lockstep.c | 2 +-
>>   crypto/afalg.c             | 2 +-
>>   crypto/block-luks.c        | 6 +++---
>>   crypto/der.c               | 2 +-
>>   crypto/der.h               | 6 +++---
>>   linux-user/flatload.c      | 2 +-
>>   linux-user/syscall.c       | 4 ++--
>>   nbd/client-connection.c    | 2 +-
>>   net/checksum.c             | 4 ++--
>>   net/filter.c               | 4 ++--
>>   net/vhost-vdpa.c           | 8 ++++----
>>   semihosting/config.c       | 2 +-
>>   semihosting/syscalls.c     | 4 ++--
>>   softmmu/icount.c           | 2 +-
>>   softmmu/ioport.c           | 2 +-
>>   20 files changed, 33 insertions(+), 33 deletions(-)
> 
> Wide-ranging; but since the nbd/ change caught my eye (rather, my mail
> filters), I went ahead and reviewed the entire patch.

Yeah, it's "all over", a trade-off between large number of patches
and patches of large size.

..
> With those tweaks,
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Added the tweaks here too. Thank you!

/mjt



