Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D29E78FB9C
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 12:11:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc16t-0005Gs-DT; Fri, 01 Sep 2023 06:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qc16p-0005FT-CE
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:10:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qc16l-0000x3-W4
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:10:35 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2DB171E72A;
 Fri,  1 Sep 2023 13:11:03 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7F3F225063;
 Fri,  1 Sep 2023 13:10:27 +0300 (MSK)
Message-ID: <dbf46ee8-459d-6840-6ac4-a66121135f06@tls.msk.ru>
Date: Fri, 1 Sep 2023 13:10:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 1/7] include/sysemu/os-posix.h: move *daemonize*
 declaration together
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
References: <cover.1691843673.git.mjt@tls.msk.ru>
 <2321b2404d3bc9b12ac1605dd59b221f61e294b8.1691843673.git.mjt@tls.msk.ru>
 <spv6irkv7exu427tsirclisgyqjsvfeowfobggvhfejnh3ywpq@f22krtelhbex>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <spv6irkv7exu427tsirclisgyqjsvfeowfobggvhfejnh3ywpq@f22krtelhbex>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -103
X-Spam_score: -10.4
X-Spam_bar: ----------
X-Spam_report: (-10.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.478,
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

15.08.2023 19:22, Eric Blake wrote:
> On Sat, Aug 12, 2023 at 03:47:55PM +0300, Michael Tokarev wrote:
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> ---
>>   include/sysemu/os-posix.h | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Eric, thank you very much for the review!
This is usually an ungrateful work.. :)

/mjt

