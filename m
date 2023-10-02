Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D7A7B5DC3
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 01:37:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnSSm-00014L-Mq; Mon, 02 Oct 2023 19:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qnSSj-000143-4S
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 19:36:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qnSSh-0002Ok-E7
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 19:36:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5372226E47;
 Tue,  3 Oct 2023 02:37:07 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 84DE62C46B;
 Tue,  3 Oct 2023 02:36:23 +0300 (MSK)
Message-ID: <ae2cc8bc-4eed-dd2f-db41-098c8f60d5a6@tls.msk.ru>
Date: Tue, 3 Oct 2023 02:36:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/8] migration fixes
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20230918172822.19052-1-farosas@suse.de>
 <1531b1d7-2c8c-4a69-109a-170bd686d894@tls.msk.ru> <ZRtSXxz0TeDY8odY@x1n>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <ZRtSXxz0TeDY8odY@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -91
X-Spam_score: -9.2
X-Spam_bar: ---------
X-Spam_report: (-9.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.321,
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

03.10.2023 02:29, Peter Xu:
> On Tue, Oct 03, 2023 at 01:55:35AM +0300, Michael Tokarev wrote:

>> What can be done for -stable?
>>
>> At least the whole thing applies cleanly to 8.1.
> 
> It seems v8.0.5 needs at least a few conflict resolutions.

As I stated in recent 8.0.5 stable announce, it was the last
from 8.0.x series unless someone really needs a new version.
So far no one said anything, so be it the last one :)

> I'd say we go apply those to 8.1.1, and we can skip 8.0 unless someone
> requests for it.

Okay, that's exactly what I thought, - queued whole thing,
will fire up some testing tomorrow.

THank you!

/mjt

