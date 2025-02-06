Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AE3A2A7C1
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Feb 2025 12:42:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg0Gp-0002Aw-Hc; Thu, 06 Feb 2025 06:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tg0Gl-0002Aa-Ij
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:42:07 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tg0Gh-0005By-Kg
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:42:07 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tg0GZ-00000006xmA-3bEB; Thu, 06 Feb 2025 12:41:55 +0100
Message-ID: <495c4c76-ffb2-4d63-adf7-97a22c03bbdd@maciej.szmigiero.name>
Date: Thu, 6 Feb 2025 12:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/33] migration: Add save_live_complete_precopy_thread
 handler
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <7561a5d67e113e166c7d43246d52feec6ca06fb5.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6JUP2w9u_FQRP6u@x1.local>
 <4ad3e311-e701-4029-bb51-e69da4f69468@maciej.szmigiero.name>
 <Z6J5vyd1_gdWlYAB@x1.local>
 <c107d827-6913-4af5-8a63-c71000060fec@maciej.szmigiero.name>
 <Z6OKDxw1hnNKCjJn@x1.local>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <Z6OKDxw1hnNKCjJn@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.069, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 5.02.2025 16:55, Peter Xu wrote:
> On Wed, Feb 05, 2025 at 12:53:21PM +0100, Maciej S. Szmigiero wrote:
>> On 4.02.2025 21:34, Peter Xu wrote:
>>> On Tue, Feb 04, 2025 at 08:32:15PM +0100, Maciej S. Szmigiero wrote:
>>>> On 4.02.2025 18:54, Peter Xu wrote:
>>>>> On Thu, Jan 30, 2025 at 11:08:40AM +0100, Maciej S. Szmigiero wrote:
>>>>>> +static int multifd_device_state_save_thread(void *opaque)
>>>>>> +{
>>>>>> +    struct MultiFDDSSaveThreadData *data = opaque;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    ret = data->hdlr(data->idstr, data->instance_id, &send_threads_abort,
>>>>>> +                     data->handler_opaque);
>>>>>
>>>>> I thought we discussed somewhere and the plan was we could use Error** here
>>>>> to report errors.  Would that still make sense, or maybe I lost some
>>>>> context?
>>>>
>>>> That was about *load* threads, here these are *save* threads.
>>>
>>> Ah OK.
>>>
>>>>
>>>> Save handlers do not return an Error value, neither save_live_iterate, nor
>>>> save_live_complete_precopy or save_state does so.
>>>
>>> Let's try to make new APIs work with Error* if possible.
>>
>> Let's assume that these threads return an Error object.
>>
>> What's qemu_savevm_state_complete_precopy_iterable() supposed to do with it?
> 
> IIUC it's not about qemu_savevm_state_complete_precopy_iterable() in this
> context, as the Error* will be used in one of the thread of the pool, not
> migration thread.
> 
> The goal is to be able to set Error* with migrate_set_error(), so that when
> migration failed, query-migrate can return the error to libvirt, so
> migration always tries to remember the 1st error hit if ever possible.
>
> It's multifd_device_state_save_thread() to do migrate_set_error(), not in
> migration thread.  qemu_savevm_state_complete_*() are indeed not ready to
> pass Errors, but it's not in the discussed stack.

I understand what are you proposing now - you haven't written about using
migrate_set_error() for save threads earlier, just about returning an Error
object.

While this might work it has tendency to uncover errors in other parts of
the migration core - much as using it in the load threads case uncovered
the TLS session error.

(Speaking of which, could you please respond to the issue at the bottom of
this message from 2 days ago?:
https://lore.kernel.org/qemu-devel/150a9741-daab-4724-add0-f35257e862f9@maciej.szmigiero.name/
It is blocking rework of the TLS session EOF handling in this patch set.
Thanks.)

But I can try this migrate_set_error() approach here and see if something
breaks.

(..)
>>>>
>>>>> Meanwhile, I still feel uneasy on having these globals (send_threads_abort,
>>>>> send_threads_ret).  Can we make MultiFDDSSaveThreadData the only interface
>>>>> between migration and the threads impl?  So I wonder if it can be:
>>>>>
>>>>>      ret = data->hdlr(data);
>>>>>
>>>>> With extended struct like this (I added thread_error and thread_quit):
>>>>>
>>>>> struct MultiFDDSSaveThreadData {
>>>>>        SaveLiveCompletePrecopyThreadHandler hdlr;
>>>>>        char *idstr;
>>>>>        uint32_t instance_id;
>>>>>        void *handler_opaque;
>>>>>        /*
>>>>>         * Should be NULL when struct passed over to thread, the thread should
>>>>>         * set this if the handler would return false.  It must be kept NULL if
>>>>>         * the handler returned true / success.
>>>>>         */
>>>>>        Error *thread_error;
>>>>
>>>> As I mentioned above, these handlers do not generally return Error type,
>>>> so this would need to be an *int;
>>>>
>>>>>        /*
>>>>>         * Migration core would set this when it wants to notify thread to
>>>>>         * quit, for example, when error occured in other threads, or migration is
>>>>>         * cancelled by the user.
>>>>>         */
>>>>>        bool thread_quit;
>>>>
>>>>               ^ I guess that was supposed to be a pointer too (*thread_quit).
>>>
>>> It's my intention to make this bool, to make everything managed per-thread.
>>
>> But that's unnecessary since this flag is common to all these threads.
> 
> One bool would be enough, but you'll need to export another API for VFIO to
> use otherwise.  I suppose that's ok too.
> 
> Some context of multifd threads and how that's done there..
> 
> We started with one "quit" per thread struct, but then we switched to one
> bool exactly as you said, see commit 15f3f21d598148.
> 
> If you want to stick with one bool, it's okay too, you can export something
> similar in misc.h, e.g. multifd_device_state_save_thread_quitting(), then
> we can avoid passing in the "quit" either as handler parameter, or
> per-thread flag.

Of course I can "export" this flag via a getter function rather than passing
it as a parameter to SaveLiveCompletePrecopyThreadHandler.

>>
>>> It's actually what we do with multifd, these are a bunch of extra threads
>>> to differeciate from the "IO threads" / "multifd threads".
>>>
>>>>
>>>>> };
>>>>>
>>>>> Then if any multifd_device_state_save_thread() failed, for example, it
>>>>> should notify all threads to quit by setting thread_quit, instead of
>>>>> relying on yet another global variable to show migration needs to quit.
>>>>
>>>> multifd_abort_device_state_save_threads() needs to access
>>>> send_threads_abort too.
>>>
>>> This may need to become something like:
>>>
>>>     QLIST_FOREACH() {
>>>         MultiFDDSSaveThreadData *data = ...;
>>>         data->thread_quit = true;
>>>     }
>>
>> At the most basic level that's turning O(1) operation into O(n).
>>
>> Besides, it creates a question now who now owns these MultiFDDSSaveThreadData
>> structures - they could be owned by either thread pool or the
>> multifd_device_state code.
> 
> I think it should be owned by migration, and with this idea it will need to
> be there until waiting thread pool completing their works, so migration
> core needs to free them.
> 
>>
>> Currently the ownership is simple - the multifd_device_state code
>> allocates such per-thread structure in multifd_spawn_device_state_save_thread()
>> and immediately passes its ownership to the thread pool which
>> takes care to free it once it no longer needs it.
> 
> Right, this is another reason why I think having migration owing these
> structs is better.  We used to have task dangling issues when we shift
> ownership of something to mainloop then we lose track of them (e.g. on TLS
> handshake gsources).  Those are pretty hard to debug when hanged, because
> migration core has nothing to link to the hanged tasks again anymore.
> 
> I think we should start from having migration core being able to reach
> these thread-based tasks when needed.  Migration also have control of the
> thread pool, then it would be easier.  Thread pool is so far simple so we
> may still need to be able to reference to per-task info separately.

These are separate threads, so they are are pretty easy to identify
in a debugger or a core dump.

Also, one can access them via the thread pool pointer if absolutely
necessary.

If QMP introspection ever becomes necessary then it could be simply
built into the generic thread pool itself.
Then all thread pool consumers will benefit from it.

>>
>> Now, with the list implementation if the thread pool were to free
>> that MultiFDDSSaveThreadData it would also need to release it from
>> the list.
>>
>> Which in turn would need appropriate locking around this removal
>> operation and probably also each time the list is iterated over.
>>
>> On the other hand if the multifd_device_state code were to own
>> that MultiFDDSSaveThreadData then it would linger around until
>> multifd_device_state_send_cleanup() cleans it up even though its
>> associated thread might be long gone.
> 
> Do you see a problem with it?  It sounds good to me actually.. and pretty
> easy to understand.
> 
> So migration creates these MultiFDDSSaveThreadData, then create threads to
> enqueue then, then wait for all threads to complete, then free these
> structs.

One of the benefits of using a thread pool is that it can abstract
memory management away by taking ownership of the data pointed to by
the passed thread opaque pointer (via the passed GDestroyNotify).

I don't see a benefit of re-implementing this also in the migration
code (returning an Error object does *not* require such approach).

>>
>>> We may want to double check qmp 'migrate_cancel' will work when save
>>> threads are running, but this can also be done for later.
>>
>>>>
>>>> And multifd_join_device_state_save_threads() needs to access
>>>> send_threads_ret.
>>>
>>> Then this one becomes:
>>>
>>>     thread_pool_wait(send_threads);
>>>     QLIST_FOREACH() {
>>>         MultiFDDSSaveThreadData *data = ...;
>>>         if (data->thread_error) {
>>>            return false;
>>>         }
>>>     }
>>>     return true;
>>
>> Same here, having a common error return would save us from having
>> to iterate over a list (or having a list in the first place).
> 
> IMHO perf isn't an issue here. It's slow path, threads num is small, loop
> is cheap.  I prefer prioritize cleaness in this case.
> 
> Otherwise any suggestion we could report an Error* in the threads?

Using Error doesn't need a list, load threads return an Error object
just fine without it:
>     if (!data->function(data->opaque, &mis->load_threads_abort, &local_err)) {
>         MigrationState *s = migrate_get_current();
> 
>         assert(local_err);
> 
>         /*
>          * In case of multiple load threads failing which thread error
>          * return we end setting is purely arbitrary.
>          */
>         migrate_set_error(s, local_err);
>     }
> 

Same can be done for save threads here (with the caveat of migrate_set_error()
uncovering possible other errors that I mentioned earlier).

>>
>>>>
>>>> These variables ultimately will have to be stored somewhere since
>>>> there can be multiple save threads and so multiple instances of
>>>> MultiFDDSSaveThreadData.
>>>>
>>>> So these need to be stored somewhere where
>>>> multifd_spawn_device_state_save_thread() can reach them to assign
>>>> their addresses to MultiFDDSSaveThreadData members.
>>>
>>> Then multifd_spawn_device_state_save_thread() will need to manage the
>>> qlist, making sure migration core remembers what jobs it submitted.  It
>>> sounds good to have that bookkeeping when I think about it, instead of
>>> throw the job to the thread pool and forget it..
>>
>> It's not "forgetting" about the job but rather letting thread pool
>> manage it - I think thread pool was introduced so these details
>> (thread management) are abstracted from the migration code.
>> Now they would be effectively duplicated in the migration code.
> 
> Migration is still managing those as long as you have send_threads_abort,
> isn't it?  The thread pool doesn't yet have an API to say "let's quit all
> the tasks", otherwise I'm OK too to use the pool API instead of having
> thread_quit.

The migration code does not manage each thread separately.

It manages them as a pool, and does each operation (wait, abort)
on the pool itself (either literally via ThreadPool or by setting
a variable that's shared by all threads).

>>
>>>>
>>>> However, at that point multifd_device_state_save_thread() can
>>>> access them too so it does not need to have them passed via
>>>> MultiFDDSSaveThreadData.
>>>>
>>>> However, nothing prevents putting send_threads* variables
>>>> into a global struct (with internal linkage - "static", just as
>>>> these separate ones are) if you like such construct more.
>>>
>>> This should be better than the current global vars indeed, but less
>>> favoured if the per-thread way could work above.
>>
>> You still need that list to be a global variable,
>> so it's the same amount of global variables as just putting
>> the existing variables in a struct (which could be even allocated
>> in multifd_device_state_send_setup() and deallocated in
>> multifd_device_state_send_cleanup() for extra memory savings).
> 
> Yes this works for me.
> 
> I think you got me wrong on "not allowing to introduce global variables".
> I'm OK with it, but please still consider..
> 
>    - Put it under some existing global object rather than having separate
>      global variables all over the places..
> 
>    - Having Error reports

Ok.

> And I still think we can change:
> 
> typedef int (*SaveLiveCompletePrecopyThreadHandler)(char *idstr,
>                                                      uint32_t instance_id,
>                                                      bool *abort_flag,
>                                                      void *opaque);
> 
> To:
> 
> typedef int (*SaveLiveCompletePrecopyThreadHandler)(MultiFDDSSaveThreadData*);
> 
> No matter what.

We can do that, although this requires "exporting" the MultiFDDSSaveThreadData
type.

>>
>> These variables are having internal linkage limited to (relatively
>> small) multifd-device-state.c, so it's not like they are polluting
>> namespace in some major migration translation unit.
> 
> If someone proposes to introduce 100 global vars in multifd-device-state.c,
> I'll strongly stop that.
> 
> If it's one global var, I'm OK.
> 
> What if it's 5?
> 
> ===8<===
> static QemuMutex queue_job_mutex;
> 
> static ThreadPool *send_threads;
> static int send_threads_ret;
> static bool send_threads_abort;
> 
> static MultiFDSendData *device_state_send;
> ===8<===
> 
> I think I should start calling a stop.  That's what happened..
> 
> Please consider introducing something like multifd_send_device_state so we
> can avoid anyone in the future randomly add static global vars.

As I wrote before, I will pack it all into one global variable,
could be called multifd_send_device_state as you suggest.

>>
>> Taking into consideration having to manage an extra data structure
>> (list), needing more code to do so, having worse algorithms I don't
>> really see a point of using that list.
>>
>> (This is orthogonal to whether the thread return type is changed to
>> Error which could be easily done on the existing save threads pool
>> implementation).
> 
> My bet is changing to list is as easy (10-20 LOC?).  If not, I can try to
> provide the diff on top of your patch.
> 
> I'm also not strictly asking for a list, but anything that makes the API
> cleaner (less globals, better error reports, etc.).

I just think introducing that list is a step back due to reasons I described
above.

And its not actually necessary for returning an Error code.

> Thanks,
> 

Thanks,
Maciej


