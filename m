Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 670BB7B7AB3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:52:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxV7-0006ig-R9; Wed, 04 Oct 2023 04:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnxV4-0006gY-Ml; Wed, 04 Oct 2023 04:44:58 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnxV2-0001uw-QX; Wed, 04 Oct 2023 04:44:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2541D27690;
 Wed,  4 Oct 2023 11:44:54 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 74BF82CC52;
 Wed,  4 Oct 2023 11:44:53 +0300 (MSK)
Message-ID: <e314d38a-4223-e72b-3729-615da41b8025@tls.msk.ru>
Date: Wed, 4 Oct 2023 11:44:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Stable-8.1.2 00/45] Patch Round-up for stable 8.1.2, freeze on
 2023-10-14
Content-Language: en-US
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
 <20231004101921.03d0260e.olaf@aepfle.de>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20231004101921.03d0260e.olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -79
X-Spam_score: -8.0
X-Spam_bar: --------
X-Spam_report: (-8.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.09,
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

04.10.2023 11:19, Olaf Hering wrote:

> How about this change for 8.1.x? This will allow usage in openSUSE Tumbleweed.
> 
> c01196bddd subprojects/berkeley-testfloat-3: Update to fix a problem with compiler warnings

Hm.  I don't think this one is a good candidate (not that it can't be included).

This just fixes compiler warning (the original code is good, and I'd even question
the patch "fixing" the warnings in berkeley-testfloat-3, - at the very least, this
"default:" case warrants a comment, since all possible values of the switch are
already explicitly specified.  This is a clear compiler defect, the changes does
not affect the result in any way.

Second, this is not even the production code, it is testing code.

And the most important, third: even with the warning being emitted, 8.1 is still
usable on openSUSE Tumbleweed: all qemu released tarballs are built WITHOUT
-Werror option, so when building a release there, these warnings wont fail the
build.  Currently, this is controlled by presence of .git in the top-level
source dir, -Werror is only enabled if .git is present.

I'm including this change, if not only because we both spent quite some time
already on this ;)  Overall though, it is not needed.

Thanks,

/mjt

