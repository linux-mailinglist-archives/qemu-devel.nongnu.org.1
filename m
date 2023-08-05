Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF3D770E3D
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 08:59:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSBFl-0005Mw-0W; Sat, 05 Aug 2023 02:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSBFQ-0005E0-PL; Sat, 05 Aug 2023 02:58:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSBFN-0004Lu-0h; Sat, 05 Aug 2023 02:58:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B6B231858F;
 Sat,  5 Aug 2023 09:59:01 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 75B241B9A8;
 Sat,  5 Aug 2023 09:58:40 +0300 (MSK)
Message-ID: <65176dab-b593-7191-1c10-7b474d44a08d@tls.msk.ru>
Date: Sat, 5 Aug 2023 09:58:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] Fixed incorrect LLONG alignment for openrisc and cris
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Luca Bonissi <qemu@bonslack.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Stafford Horne <shorne@gmail.com>,
 Jia Liu <proljc@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <8cca5c06-4df8-b7d4-4aee-f52f956437f8@bonslack.org>
 <044ceb14-e5cc-6d78-deaf-254dc3d1e170@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <044ceb14-e5cc-6d78-deaf-254dc3d1e170@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.093,
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

03.08.2023 07:42, Thomas Huth wrote:
> On 03/08/2023 02.29, Luca Bonissi wrote:
>> From: Luca Bonissi <qemu@bonslack.org>
>> Date: Thu, 3 Aug 2023 02:15:57 +0200
>> Subject: [PATCH] Fixed incorrect LLONG alignment for openrisc and cris
>>
>> OpenRISC (or1k) has long long alignment to 4 bytes, but currently not
>> defined in abitypes.h. This lead to incorrect packing of /epoll_event/
>> structure and eventually infinite loop while waiting for file
>> descriptor[s] event[s].
>>
>> Fixed also CRIS alignments (1 byte for all types).

Applied to my trivial-patches tree, thanks!

/mjt

