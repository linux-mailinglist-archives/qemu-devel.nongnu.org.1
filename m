Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9D0772CEF
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 19:29:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT41M-0006g6-9G; Mon, 07 Aug 2023 13:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qT41J-0006ds-Md; Mon, 07 Aug 2023 13:27:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qT41H-0006Eu-8W; Mon, 07 Aug 2023 13:27:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 68C6A18BBE;
 Mon,  7 Aug 2023 20:27:47 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 850D31C1B7;
 Mon,  7 Aug 2023 20:27:45 +0300 (MSK)
Message-ID: <14b6e0d5-2824-5f9f-e9b6-dc15b0123742@tls.msk.ru>
Date: Mon, 7 Aug 2023 20:27:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] target/s390x: Use a 16-bit immediate in VREP
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230807163459.849766-1-iii@linux.ibm.com>
 <baa436ac-ffe4-8c7d-6eee-af9c26fe3c0f@redhat.com>
 <558af8b33fa9164b0a5a21f61aa583a3776784f7.camel@linux.ibm.com>
 <f4d98473-1ddd-e45c-ba01-767bde208a77@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <f4d98473-1ddd-e45c-ba01-767bde208a77@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -86
X-Spam_score: -8.7
X-Spam_bar: --------
X-Spam_report: (-8.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.809,
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

> On 07.08.23 19:02, Ilya Leoshkevich wrote:
..>> None that I know of, but I thought this was still nice to have, and at
>> the same time small enough to not cause any trouble.

Ilya, do you have an idea why your messages don't reach qemu-stable@?

I see e.g. David's replies to yuor messages in qemu-stable@ - this way
I know you sent something, and copy that message from qemu-devel@.

For example, this thread is shown in the archive with your messages
unavailable:

https://mail.gnu.org/archive/html/qemu-stable/2023-08/threads.html#00118

