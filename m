Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE6A74E5B9
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 06:13:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ4kg-0000F0-1X; Tue, 11 Jul 2023 00:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qJ4kc-0000EZ-Ou
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 00:13:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qJ4ka-0007Qe-Bf
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 00:13:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EB66112E3E;
 Tue, 11 Jul 2023 07:13:25 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7950E13EBE;
 Tue, 11 Jul 2023 07:13:16 +0300 (MSK)
Message-ID: <d616ff70-c975-674e-2501-9702655e6de5@tls.msk.ru>
Date: Tue, 11 Jul 2023 07:13:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 6/6] hw/pci: add comment explaining the reason for
 checking function 0 in hotplug
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel
 <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20230705115925.5339-1-anisinha@redhat.com>
 <20230705115925.5339-7-anisinha@redhat.com>
 <F99D12E7-135A-4A03-8B9D-1FF384FBCA5A@redhat.com>
 <20230710154155-mutt-send-email-mst@kernel.org>
 <878CC014-DC18-43CC-83D8-B2524EE09373@redhat.com>
 <9b2935a1-af38-3373-6441-c0179df0cbfb@tls.msk.ru>
 <F8856123-70CC-44FF-9E7A-E7E27DD07944@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <F8856123-70CC-44FF-9E7A-E7E27DD07944@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.101,
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

11.07.2023 07:03, Ani Sinha wrote:
> 
> 
>> On 11-Jul-2023, at 9:21 AM, Michael Tokarev <mjt@tls.msk.ru> wrote:
>>
>> 11.07.2023 06:46, Ani Sinha wrote:
>>
>>> Sure. Since this is only a comment addition, should I also CC qemu-trivial?
>>
>> A comment change does not mean the change is trivial.  It's a trivial in a sense
>> the code changes are trivial (actually not-existent), but the meaning of the comment
>> is not trivial at all. I for one know nothing about this.
> 
> This comment was already disucussed in qemu-devel between me, mst and Igor. Perhaps you missed it.

It doesn't matter really. The thing is that it needs explanation, hence it is not "trivial",
that's what I tried to say. It is trivial for sure for someone who knows this particular
subsystem well enough, - I'm not one of them ;)

/mjt

