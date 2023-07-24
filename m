Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9086175F55E
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 13:45:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNtzU-0005IQ-K9; Mon, 24 Jul 2023 07:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qNtzR-0005GP-HE
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:44:38 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qNtzQ-00062R-2t
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:44:37 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1qNtzI-00077O-Gt; Mon, 24 Jul 2023 13:44:28 +0200
Message-ID: <d01815db-786b-b6ad-9986-ba084e4c1e16@maciej.szmigiero.name>
Date: Mon, 24 Jul 2023 13:44:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v6_0/6=5d_Hyper-V_Dynamic_Memory_Protocol_?=
 =?UTF-8?B?ZHJpdmVyIChodi1iYWxsb29uIPCfjojvuI8p?=
Content-Language: en-US, pl-PL
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <cover.1689786474.git.maciej.szmigiero@oracle.com>
 <87wmypo9wh.fsf@pond.sub.org>
 <d8f2654d-2464-7cd3-f890-95cd6b8fc2fe@maciej.szmigiero.name>
 <87y1j5mtc4.fsf@pond.sub.org>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
In-Reply-To: <87y1j5mtc4.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 24.07.2023 13:39, Markus Armbruster wrote:
> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
> 
>> On 24.07.2023 12:56, Markus Armbruster wrote:
>>> Doesn't apply to master.  Care to rebase?
>>>
>>
>> The series is now based on David's virtio-mem-memslots patches
>> (specifically, commit 6769107d1a4f from [1]) since it depends
>> on support for exposing device memory via multiple memslots
>> provided by that series.
>>
>> I'm sorry if that wasn't clear from the cover letter.
> 
> Aha!  I just fetched David's branch, applied your patches on top, and
> rebased to current master.
> 
> I recommend to list dependencies like
> 
>      Based-on: <message-id>
> 
> so Patchew applies them.

Didn't know that notation, thanks for point this out.
Will use it in the future version(s).
  
>>
>> [1]: https://github.com/davidhildenbrand/qemu/tree/virtio-mem-memslots
> 

Thanks,
Maciej


