Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C51F703259
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:09:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyakn-00018P-GY; Mon, 15 May 2023 12:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pyakl-00014f-2G; Mon, 15 May 2023 12:08:51 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pyakj-0002c6-1T; Mon, 15 May 2023 12:08:50 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1BC236021;
 Mon, 15 May 2023 19:08:47 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id F0E1C55A7;
 Mon, 15 May 2023 19:08:45 +0300 (MSK)
Message-ID: <147b4e5e-009a-7ab8-7dfc-ea7735319c97@msgid.tls.msk.ru>
Date: Mon, 15 May 2023 19:08:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] hw/pvrdma: Protect against buggy or malicious guest
 driver
Content-Language: en-US
To: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
Cc: Claudio Fontana <cfontana@suse.de>,
 qemu devel list <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, wxhusst@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20220403095234.2210-1-yuval.shaia.ml@gmail.com>
 <CAC_L=vXsKpai6Wr0Fi2r5sr4U+tshPB9VizqntDppqE=1_FbVQ@mail.gmail.com>
 <339b8c7d-1f54-a515-8854-c22d10f79d1d@suse.de>
 <CAMPkWoOFXfyx=ZOv8i6AJ8Lv2GFKt11gnXYZ2W_4roS9UP9m5w@mail.gmail.com>
 <CAC_L=vUD2vVNSaP7UcDuRUCyd8XNmb4iRY_LXK0UNEE-+Rr4TQ@mail.gmail.com>
 <6cd36e7e-dae7-6258-736a-44630cee9010@redhat.com>
 <5779382f-9f8d-439e-b474-1ac1606d65a5@vivier.eu>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <5779382f-9f8d-439e-b474-1ac1606d65a5@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -106
X-Spam_score: -10.7
X-Spam_bar: ----------
X-Spam_report: (-10.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.811,
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

16.01.2023 20:50, Laurent Vivier wrote:
> Le 28/12/2022 à 20:32, Thomas Huth a écrit :
>> On 19/12/2022 12.21, Marcel Apfelbaum wrote:
>>> On Mon, Dec 19, 2022 at 10:57 AM Yuval Shaia <yuval.shaia.ml@gmail.com> wrote:
>>>>
>>>> Can anyone else pick this one?
>>>
>>> Adding Thomas,
>>>
>>> I dropped the ball with this one, I am sorry about that, maybe it
>>> doesn't worth a Pull Request only for it.
>>
>> Why not? Pull request for single patches aren't that uncommon.
>>
>>> Maybe it can go through the Misc tree?
>>
>> hw/rdma/ is really not my turf, but since the patch is small, it sounds like a good candidate for qemu-trivial, I think.
> 
> Applied to my trivial-patches branch.

Has it been forgotten again? :)

/mjt

