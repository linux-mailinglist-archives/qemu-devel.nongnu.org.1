Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F02720EB6
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 10:19:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5MSK-0003ub-Iv; Sat, 03 Jun 2023 04:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q5MSF-0003nw-VB; Sat, 03 Jun 2023 04:17:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q5MSD-0001vq-Uf; Sat, 03 Jun 2023 04:17:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2FE72A798;
 Sat,  3 Jun 2023 11:17:28 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8C29D932E;
 Sat,  3 Jun 2023 11:17:27 +0300 (MSK)
Message-ID: <62d84222-7da7-d036-7ef1-37b88de69572@tls.msk.ru>
Date: Sat, 3 Jun 2023 11:17:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 07/21] cutils: Fix wraparound parsing in qemu_strtoui
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>
References: <20230601220305.2130121-1-eblake@redhat.com>
 <20230601220305.2130121-8-eblake@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230601220305.2130121-8-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

02.06.2023 01:02, Eric Blake пишет:
> While we were matching 32-bit strtol in qemu_strtoi, our use of a
> 64-bit parse was leaking through for some inaccurate answers in
> qemu_strtoui in comparison to a 32-bit strtoul (see the unit test for
> examples).  The comment for that function even described what we have
> to do for a correct parse, but didn't implement it correctly: since
> strtoull checks for overflow against the wrong values and then
> negates, we have to temporarily undo negation before checking for
> overflow against our desired value.
> 
> Our int wrappers would be a lot easier to write if libc had a
> guaranteed 32-bit parser even on platforms with 64-bit long.
> 
> Whether we parse C2x binary strings like "0b1000" is currently up to
> what libc does; our unit tests intentionally don't cover that at the
> moment, though.
> 
> Fixes: 473a2a331e ("cutils: add qemu_strtoi & qemu_strtoui parsers for int/unsigned int types", v2.12.0)
> Signed-off-by: Eric Blake <eblake@redhat.com>
> CC: qemu-stable@nongnu.org

Trying to pick this one up for -stable. The implementation changes are good.
But the testsuite changes are.. difficult.  The thing is that testsuite changes
(here and in the other -stable patch) applies on top of previous changes in
there (in the same series), which, in turn, requires other previous code changes
in the implementation to succeed.

For example, this patch changes test_qemu_strtoui_overflow() which was introduced
in previous patch "Test more integer corner cases" from this series and further
modified in "Test integral qemu_strto* value on failures" one.  Picking them result
in testsuite failing due to missing previous code changes.

I tried to drop just the testsuite changes, but the result is that the testsuite
fails with fixed code :)

It's quite fun situation actually, like it fails no matter what you do, one way
or another.

I'll try to find the most stright-forward way from here.  Good stuff.

Thanks,

/mjt


