Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD68D96A6BD
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Sep 2024 20:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slYTb-0006Gi-G8; Tue, 03 Sep 2024 14:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1slYTY-0006Fe-MJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 14:42:00 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1slYTW-0004L8-EW
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 14:42:00 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1slYTI-00005e-T5; Tue, 03 Sep 2024 20:41:44 +0200
Message-ID: <a7fc885e-b373-4e98-af33-efe11687a258@maciej.szmigiero.name>
Date: Tue, 3 Sep 2024 20:41:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/17] migration/multifd: Device state transfer support
 - receive side
To: Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <84141182083a8417c25b4d82a9c4b6228b22ac67.1724701542.git.maciej.szmigiero@oracle.com>
 <87ttf1n4lm.fsf@suse.de>
 <00eeacd5-ad27-4899-8526-0941b30e759d@maciej.szmigiero.name>
 <87frqgn6ha.fsf@suse.de>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <87frqgn6ha.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3.09.2024 16:42, Fabiano Rosas wrote:
> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
> 
>> On 30.08.2024 22:22, Fabiano Rosas wrote:
>>> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
>>>
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> Add a basic support for receiving device state via multifd channels -
>>>> channels that are shared with RAM transfers.
>>>>
>>>> To differentiate between a device state and a RAM packet the packet
>>>> header is read first.
>>>>
>>>> Depending whether MULTIFD_FLAG_DEVICE_STATE flag is present or not in the
>>>> packet header either device state (MultiFDPacketDeviceState_t) or RAM
>>>> data (existing MultiFDPacket_t) is then read.
>>>>
>>>> The received device state data is provided to
>>>> qemu_loadvm_load_state_buffer() function for processing in the
>>>> device's load_state_buffer handler.
>>>>
>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>> ---
>>>>    migration/multifd.c | 127 +++++++++++++++++++++++++++++++++++++-------
>>>>    migration/multifd.h |  31 ++++++++++-
>>>>    2 files changed, 138 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/migration/multifd.c b/migration/multifd.c
>>>> index b06a9fab500e..d5a8e5a9c9b5 100644
>>>> --- a/migration/multifd.c
>>>> +++ b/migration/multifd.c
(..)
>>>> +
>>>> +            ret = qio_channel_read_all_eof(p->c, (char *)pkt_buf, pkt_len,
>>>> +                                           &local_err);
>>>>                if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
>>>>                    break;
>>>>                }
>>>> @@ -1181,8 +1239,33 @@ static void *multifd_recv_thread(void *opaque)
>>>>                has_data = !!p->data->size;
>>>>            }
>>>>    
>>>> -        if (has_data) {
>>>> -            ret = multifd_recv_state->ops->recv(p, &local_err);
>>>> +        if (!is_device_state) {
>>>> +            if (has_data) {
>>>> +                ret = multifd_recv_state->ops->recv(p, &local_err);
>>>> +                if (ret != 0) {
>>>> +                    break;
>>>> +                }
>>>> +            }
>>>> +        } else {
>>>> +            g_autofree char *idstr = NULL;
>>>> +            g_autofree char *dev_state_buf = NULL;
>>>> +
>>>> +            assert(use_packets);
>>>> +
>>>> +            if (p->next_packet_size > 0) {
>>>> +                dev_state_buf = g_malloc(p->next_packet_size);
>>>> +
>>>> +                ret = qio_channel_read_all(p->c, dev_state_buf, p->next_packet_size, &local_err);
>>>> +                if (ret != 0) {
>>>> +                    break;
>>>> +                }
>>>> +            }
>>>
>>> What's the use case for !next_packet_size and still call
>>> load_state_buffer below? I can't see it.
>>
>> Currently, next_packet_size == 0 has not usage indeed - it is
>> a leftover from an early version of the patch set (not public)
>> that had device state packet (chunk) indexing done by
>> the common migration code, rather than by the VFIO consumer.
>>
>> And then an empty packet could be used to mark the stream
>> boundary - like the max chunk number to expect.
>>
>>> ...because I would suggest to set has_data up there with
>>> p->next_packet_size:
>>>
>>> if (use_packets) {
>>>      ...
>>>      has_data = p->next_packet_size || p->zero_num;
>>> } else {
>>>      ...
>>>      has_data = !!p->data_size;
>>> }
>>>
>>> and this whole block would be:
>>>
>>> if (has_data) {
>>>      if (is_device_state) {
>>>          multifd_device_state_recv(p, &local_err);
>>>      } else {
>>>          ret = multifd_recv_state->ops->recv(p, &local_err);
>>>      }
>>> }
>>
>> The above block makes sense to me with two caveats:
> 
> I have suggestions below, but this is no big deal, so feel free to go
> with what you think works best.
> 
>> 1) If empty device state packets (next_packet_size == 0) were
>> to be unsupported they need to be rejected cleanly rather
>> than silently skipped,
> 
> Should this be rejected on the send side? That's the most likely source
> of the problem if it happens. Don't need to send something we know will
> cause an error when loading.

Definitely we should send correct bit stream :), it was about the
case of bit stream corruption or simply using some future bit stream
format that the QEMU version with this patch set does not understand
yet.

> And for the case of stream corruption of some sort we could hoist the
> check from load_buffer into here:
> 
>   else if (is_device_state) {
>      error_setg(errp, "empty device state packet);
>      break;
> }

Right.

>> 2) has_data has to have its value computed depending on whether
>> this is a RAM or a device state packet since looking at
>> p->normal_num and p->zero_num makes no sense for a device state
>> packet while I am not sure that looking at p->next_packet_size
>> for a RAM packet won't introduce some subtle regression.
> 
> It should be ok to use next_packet_size for RAM, it must always be in
> sync with normal_num.

Then it should be ok, but I'll look at this deeper to be sure when
I will be preparing the next patch set version.

Thanks,
Maciej


