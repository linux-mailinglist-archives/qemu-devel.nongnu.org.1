Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2D39721E3
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Sep 2024 20:34:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snjCO-0007hY-2f; Mon, 09 Sep 2024 14:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1snjCD-0007gG-WA
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:33:06 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1snjCA-0004NX-Ts
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:33:05 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1snjBz-0006a7-8R; Mon, 09 Sep 2024 20:32:51 +0200
Message-ID: <fa64bf51-7fec-454b-b204-f92f5d06f731@maciej.szmigiero.name>
Date: Mon, 9 Sep 2024 20:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/17] migration: Add
 save_live_complete_precopy_{begin,end} handlers
To: Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <afe0bc649007593edaa77f5f3923acb733a24c6a.1724701542.git.maciej.szmigiero@oracle.com>
 <9f9f0408-866d-4dc8-8c8e-80c3cfdd190a@nvidia.com> <Zt83mWWlMomX4mRD@x1n>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <Zt83mWWlMomX4mRD@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On 9.09.2024 19:59, Peter Xu wrote:
> On Thu, Sep 05, 2024 at 04:45:48PM +0300, Avihai Horon wrote:
>>
>> On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> These SaveVMHandlers help device provide its own asynchronous
>>> transmission of the remaining data at the end of a precopy phase.
>>>
>>> In this use case the save_live_complete_precopy_begin handler might
>>> be used to mark the stream boundary before proceeding with asynchronous
>>> transmission of the remaining data while the
>>> save_live_complete_precopy_end handler might be used to mark the
>>> stream boundary after performing the asynchronous transmission.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>    include/migration/register.h | 36 ++++++++++++++++++++++++++++++++++++
>>>    migration/savevm.c           | 35 +++++++++++++++++++++++++++++++++++
>>>    2 files changed, 71 insertions(+)
>>>
>>> diff --git a/include/migration/register.h b/include/migration/register.h
>>> index f60e797894e5..9de123252edf 100644
>>> --- a/include/migration/register.h
>>> +++ b/include/migration/register.h
>>> @@ -103,6 +103,42 @@ typedef struct SaveVMHandlers {
>>>         */
>>>        int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
>>>
>>> +    /**
>>> +     * @save_live_complete_precopy_begin
>>> +     *
>>> +     * Called at the end of a precopy phase, before all
>>> +     * @save_live_complete_precopy handlers and before launching
>>> +     * all @save_live_complete_precopy_thread threads.
>>> +     * The handler might, for example, mark the stream boundary before
>>> +     * proceeding with asynchronous transmission of the remaining data via
>>> +     * @save_live_complete_precopy_thread.
>>> +     * When postcopy is enabled, devices that support postcopy will skip this step.
>>> +     *
>>> +     * @f: QEMUFile where the handler can synchronously send data before returning
>>> +     * @idstr: this device section idstr
>>> +     * @instance_id: this device section instance_id
>>> +     * @opaque: data pointer passed to register_savevm_live()
>>> +     *
>>> +     * Returns zero to indicate success and negative for error
>>> +     */
>>> +    int (*save_live_complete_precopy_begin)(QEMUFile *f,
>>> +                                            char *idstr, uint32_t instance_id,
>>> +                                            void *opaque);
>>> +    /**
>>> +     * @save_live_complete_precopy_end
>>> +     *
>>> +     * Called at the end of a precopy phase, after @save_live_complete_precopy
>>> +     * handlers and after all @save_live_complete_precopy_thread threads have
>>> +     * finished. When postcopy is enabled, devices that support postcopy will
>>> +     * skip this step.
>>> +     *
>>> +     * @f: QEMUFile where the handler can synchronously send data before returning
>>> +     * @opaque: data pointer passed to register_savevm_live()
>>> +     *
>>> +     * Returns zero to indicate success and negative for error
>>> +     */
>>> +    int (*save_live_complete_precopy_end)(QEMUFile *f, void *opaque);
>>
>> Is this handler necessary now that migration core is responsible for the
>> threads and joins them? I don't see VFIO implementing it later on.
> 
> Right, I spot the same thing.
> 
> This series added three hooks: begin, end, precopy_thread.
> 
> What I think is it only needs one, which is precopy_async.  My vague memory
> was that was what we used to discuss too, so that when migration precopy
> flushes the final round of iterable data, it does:
> 
>    (1) loop over all complete_precopy_async() and enqueue the tasks if
>        existed into the migration worker pool.  Then,
> 
>    (2) loop over all complete_precopy() like before.
> 
> Optionally, we can enforce one vmstate handler only provides either
> complete_precopy_async() or complete_precopy().  In this case VFIO can
> update the two hooks during setup() by detecting multifd && !mapped_ram &&
> nocomp.
> 

The "_begin" hook is still necessary to mark the end of the device state
sent via the main migration stream (during the phase VM is still running)
since we can't start loading the multifd sent device state until all of
that earlier data finishes loading first.

We shouldn't send that boundary marker in .save_live_complete_precopy
either since it would meant unnecessary waiting for other devices
(not necessary VFIO ones) .save_live_complete_precopy bulk data.

And VFIO SaveVMHandlers are shared for all VFIO devices (and const) so
we can't really change them at runtime.

Thanks,
Maciej


