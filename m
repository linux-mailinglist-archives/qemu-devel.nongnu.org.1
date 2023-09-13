Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0A179E029
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 08:42:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgJZW-0007OM-Nj; Wed, 13 Sep 2023 02:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgJZT-0007O2-4i; Wed, 13 Sep 2023 02:41:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgJZQ-0004db-DX; Wed, 13 Sep 2023 02:41:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 031E7214C8;
 Wed, 13 Sep 2023 09:41:54 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 82EF527A4F;
 Wed, 13 Sep 2023 09:41:48 +0300 (MSK)
Message-ID: <c3238434-2ec8-c060-9bb6-59a1a5f9de3a@tls.msk.ru>
Date: Wed, 13 Sep 2023 09:41:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL v1 1/1] tpm: fix crash when FD >= 1024
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, qemu-stable@nongnu.org
References: <20230912214110.482744-1-stefanb@linux.ibm.com>
 <20230912214110.482744-2-stefanb@linux.ibm.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230912214110.482744-2-stefanb@linux.ibm.com>
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

13.09.2023 00:41, Stefan Berger wrote:
> From: Marc-Andr޸ Lureau <marcandre.lureau@redhat.com>
> 
> Replace select() with poll() to fix a crash when QEMU has a large number
> of FDs.
> 
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=2020133

Please keep these on the same line next time.

And there's an UTF8 issue with Marc-André's name writing
as Phil already pointed out (fixing in Cc of this email).
Git usually DTRT here, dunno how that can happen.

BTW, it would also be good to mention newly introduced
usage of non-EINTR operation, - before this change, EINTR
were returned to the caller, now it is not anymore.

I'm sorry for late notes..

/mjt

