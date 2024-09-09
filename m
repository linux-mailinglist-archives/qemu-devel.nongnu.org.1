Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A273972200
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Sep 2024 20:39:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snjI5-000460-70; Mon, 09 Sep 2024 14:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1snjI0-00044f-K6
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:39:05 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1snjHy-00052D-68
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:39:04 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1snjHm-0006cJ-IV; Mon, 09 Sep 2024 20:38:50 +0200
Message-ID: <24d8e48e-2967-44b7-b294-a398f61dfbd8@maciej.szmigiero.name>
Date: Mon, 9 Sep 2024 20:38:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] thread-pool: Implement non-AIO (generic) pool
 support
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <54947c3a1df713f5b69d8296938f3da41116ffe0.1724701542.git.maciej.szmigiero@oracle.com>
 <CAJSP0QU+dhh_e2LJRoGCxtCEh6C2-GBoZoFZL2W-SMSQPzUtYg@mail.gmail.com>
 <d6e7dbd4-634f-4f62-8516-7bbf404b7adf@maciej.szmigiero.name>
 <CAJSP0QXURSS4cHj0i6xy27HMbtF2D4ckL4fwDk5rHA3vFFtHUg@mail.gmail.com>
 <Zt8mPlBLO9FUHgxG@x1n>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <Zt8mPlBLO9FUHgxG@x1n>
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

On 9.09.2024 18:45, Peter Xu wrote:
> Hi, Stefan, Maciej,
> 
> Sorry to be slow on responding.
> 
> On Tue, Sep 03, 2024 at 03:04:54PM -0400, Stefan Hajnoczi wrote:
>> On Tue, 3 Sept 2024 at 12:54, Maciej S. Szmigiero
>> <mail@maciej.szmigiero.name> wrote:
>>>
>>> On 3.09.2024 15:55, Stefan Hajnoczi wrote:
>>>> On Tue, 27 Aug 2024 at 13:58, Maciej S. Szmigiero
>>>> <mail@maciej.szmigiero.name> wrote:
>>>>>
>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>
>>>>> Migration code wants to manage device data sending threads in one place.
>>>>>
>>>>> QEMU has an existing thread pool implementation, however it was limited
>>>>> to queuing AIO operations only and essentially had a 1:1 mapping between
>>>>> the current AioContext and the ThreadPool in use.
>>>>>
>>>>> Implement what is necessary to queue generic (non-AIO) work on a ThreadPool
>>>>> too.
>>>>>
>>>>> This brings a few new operations on a pool:
>>>>> * thread_pool_set_minmax_threads() explicitly sets the minimum and maximum
>>>>> thread count in the pool.
>>>>>
>>>>> * thread_pool_join() operation waits until all the submitted work requests
>>>>> have finished.
>>>>>
>>>>> * thread_pool_poll() lets the new thread and / or thread completion bottom
>>>>> halves run (if they are indeed scheduled to be run).
>>>>> It is useful for thread pool users that need to launch or terminate new
>>>>> threads without returning to the QEMU main loop.
>>>>
>>>> Did you consider glib's GThreadPool?
>>>> https://docs.gtk.org/glib/struct.ThreadPool.html
>>>>
>>>> QEMU's thread pool is integrated into the QEMU event loop. If your
>>>> goal is to bypass the QEMU event loop, then you may as well use the
>>>> glib API instead.
>>>>
>>>> thread_pool_join() and thread_pool_poll() will lead to code that
>>>> blocks the event loop. QEMU's aio_poll() and nested event loops in
>>>> general are a source of hangs and re-entrancy bugs. I would prefer not
>>>> introducing these issues in the QEMU ThreadPool API.
>>>>
>>>
>>> Unfortunately, the problem with the migration code is that it is
>>> synchronous - it does not return to the main event loop until the
>>> migration is done.
>>>
>>> So the only way to handle things that need working event loop is to
>>> pump it manually from inside the migration code.
>>>
>>> The reason why I used the QEMU thread pool in the first place in this
>>> patch set version is because Peter asked me to do so during the review
>>> of its previous iteration [1].
>>>
>>> Peter also asked me previously to move to QEMU synchronization
>>> primitives from using the Glib ones in the early version of this
>>> patch set [2].
>>>
>>> I personally would rather use something common to many applications,
>>> well tested and with more pairs of eyes looking at it rather to
>>> re-invent things in QEMU.
>>>
>>> Looking at GThreadPool it seems that it lacks ability to wait until
>>> all queued work have finished, so this would need to be open-coded
>>> in the migration code.
>>>
>>> @Peter, what's your opinion on using Glib's thread pool instead of
>>> QEMU's one, considering the above things?
>>
>> I'll add a bit more about my thinking:
>>
>> Using QEMU's event-driven model is usually preferred because it makes
>> integrating with the rest of QEMU easy and avoids having lots of
>> single-purpose threads that are hard to observe/manage (e.g. through
>> the QMP monitor).
>>
>> When there is a genuine need to spawn a thread and write synchronous
>> code (e.g. a blocking ioctl(2) call or something CPU-intensive), then
> 
> Right, AFAIU this is the current use case for VFIO, and anything beyond in
> migration context, where we want to use genuine threads with no need to
> integrate with the main even loop.
> 
> Currently the VFIO workfn should read() the VFIO fd in a blocked way, then
> dump them to multifd threads (further dump to migration channels), during
> which it can wait on a semaphore.
> 
>> it's okay to do that. Use QEMUBH, EventNotifier, or other QEMU APIs to
>> synchronize between event loop threads and special-purpose synchronous
>> threads.
>>
>> I haven't looked at the patch series enough to have an opinion about
>> whether this use case needs a special-purpose thread or not. I am
>> assuming it really needs to be a special-purpose thread. Peter and you
>> could discuss that further if you want.
>>
>> I agree with Peter's request to use QEMU's synchronization primitives.
>> They do not depend on the event loop so they can be used outside the
>> event loop.
>>
>> The issue I'm raising with this patch is that adding new join()/poll()
>> APIs that shouldn't be called from the event loop is bug-prone. It
>> will make the QEMU ThreadPool code harder to understand and maintain
>> because now there are two different contexts where different subsets
>> of this API can be used and mixing them leads to problems. To me the
>> non-event loop case is beyond the scope of QEMU's ThreadPool. I have
>> CCed Paolo, who wrote the thread pool in its current form in case he
>> wants to participate in the discussion.
>>
>> Using glib's ThreadPool solves the issue while still reusing an
>> existing thread pool implementation. Waiting for all work to complete
>> can be done using QemuSemaphore.
> 
> Right.  It's a pity that g_thread_pool_unprocessed() only monitors
> unqueuing of tasks, and looks like there's no g_thread_pool_flush().
> 
> Indeed the current thread poll is very aio-centric, and if we worry about
> misuse of the APIs we can switch to glib's threadpool.  Sorry Maciej, looks
> like I routed you to a direction that I didn't see the side effects..
> 
> I think the fundamental request from my side (on behalf of migration) is we
> should avoid a specific vmstate handler managing threads on its own.  E.g.,
> any future devices (vdpa, vcpu, etc.) that may also be able to offload
> save() processes concurrently to threads (just like what VFIO can already
> do right now) should share the same pool of threads.  As long as that can
> be achieved I am ok.

So, to be clear - do you still prefer using the (extended) QEMU's thread pool
or rather prefer switching to the Glib thread pool instead (with
thread_pool_wait() equivalent reimplemented inside QEMU since Glib lacks it)?
  
> Thanks,
> 

Thanks,
Maciej


