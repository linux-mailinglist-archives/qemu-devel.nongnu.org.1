Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0B47AB4DF
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:37:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiDo-0004MD-LG; Fri, 22 Sep 2023 11:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjiDf-0004LU-6K; Fri, 22 Sep 2023 11:37:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjiDc-0001fl-2f; Fri, 22 Sep 2023 11:37:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7D5EE245B2;
 Fri, 22 Sep 2023 18:37:43 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B107E2A1C8;
 Fri, 22 Sep 2023 18:37:19 +0300 (MSK)
Message-ID: <d10f3c6a-016f-5d12-3397-b43596a83d10@tls.msk.ru>
Date: Fri, 22 Sep 2023 18:37:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [ANNOUNCE] QEMU 8.1.1 Stable released
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-stable <qemu-stable@nongnu.org>
References: <d0d2ac8f-313a-c937-dc3a-88e45fce933c@tls.msk.ru>
In-Reply-To: <d0d2ac8f-313a-c937-dc3a-88e45fce933c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

22.09.2023 18:18, Michael Tokarev wrote:
> This update contains a pile of fixes for various architectures/subsystems,
> fixing a number of various bugs.  Unfortunately some known bugs remain
> unfixed still, and hopefully will be addressed in subsequent 8.1.x releases.
> In particular, the following issues (which exists in 8.1.0 release too)
> remain unfixed in this release:
> 
>     https://gitlab.com/qemu-project/qemu/-/issues/1826
>     https://gitlab.com/qemu-project/qemu/-/issues/1834
>     https://gitlab.com/qemu-project/qemu/-/issues/1846

And here are another 2 incarnations of the same theme:

      https://gitlab.com/qemu-project/qemu/-/issues/1864

These are *not* fixed in 8.1.1.

/mjt

