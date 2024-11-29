Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0C09DB73C
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Nov 2024 13:12:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGdMw-0007zD-KU; Thu, 28 Nov 2024 07:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tGdMt-0007z0-IO
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 07:11:35 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tGdMr-0006e7-2i
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 07:11:35 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tGdMZ-00000002uzq-2TbQ; Thu, 28 Nov 2024 13:11:15 +0100
Message-ID: <731236b1-1bc5-4d3e-ae7f-2cae6c0a1237@maciej.szmigiero.name>
Date: Thu, 28 Nov 2024 13:11:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/24] thread-pool: Implement generic (non-AIO) pool
 support
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <babda1bbe43024baaa4a9ac855f7930b6679f2b7.1731773021.git.maciej.szmigiero@oracle.com>
 <e1ea0647-e71b-4278-8cf6-15c52b14f6b7@nvidia.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <e1ea0647-e71b-4278-8cf6-15c52b14f6b7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 28.11.2024 11:08, Avihai Horon wrote:
> Hi Maciej,
> 
> On 17/11/2024 21:19, Maciej S. Szmigiero wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Migration code wants to manage device data sending threads in one place.
>>
>> QEMU has an existing thread pool implementation, however it is limited
>> to queuing AIO operations only and essentially has a 1:1 mapping between
>> the current AioContext and the AIO ThreadPool in use.
>>
>> Implement generic (non-AIO) ThreadPool by essentially wrapping Glib's
>> GThreadPool.
>>
>> This brings a few new operations on a pool:
>> * thread_pool_wait() operation waits until all the submitted work requests
>> have finished.
>>
>> * thread_pool_set_max_threads() explicitly sets the maximum thread count
>> in the pool.
>>
>> * thread_pool_adjust_max_threads_to_work() adjusts the maximum thread count
>> in the pool to equal the number of still waiting in queue or unfinished work.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   include/block/thread-pool.h |   9 +++
>>   util/thread-pool.c          | 109 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 118 insertions(+)
>>
>> diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
>> index 6f27eb085b45..3f9f66307b65 100644
>> --- a/include/block/thread-pool.h
>> +++ b/include/block/thread-pool.h
>> @@ -38,5 +38,14 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
>>   int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
>>   void thread_pool_update_params(ThreadPoolAio *pool, struct AioContext *ctx);
>>
>> +typedef struct ThreadPool ThreadPool;
>> +
>> +ThreadPool *thread_pool_new(void);
>> +void thread_pool_free(ThreadPool *pool);
>> +void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
>> +                        void *opaque, GDestroyNotify opaque_destroy);
>> +void thread_pool_wait(ThreadPool *pool);
>> +bool thread_pool_set_max_threads(ThreadPool *pool, int max_threads);
>> +bool thread_pool_adjust_max_threads_to_work(ThreadPool *pool);
>>
>>   #endif
>> diff --git a/util/thread-pool.c b/util/thread-pool.c
>> index 908194dc070f..d80c4181c897 100644
>> --- a/util/thread-pool.c
>> +++ b/util/thread-pool.c
>> @@ -374,3 +374,112 @@ void thread_pool_free_aio(ThreadPoolAio *pool)
>>       qemu_mutex_destroy(&pool->lock);
>>       g_free(pool);
>>   }
>> +
>> +struct ThreadPool { /* type safety */
>> +    GThreadPool *t;
>> +    size_t unfinished_el_ctr;
>> +    QemuMutex unfinished_el_ctr_mutex;
>> +    QemuCond unfinished_el_ctr_zero_cond;
>> +};
>> +
>> +typedef struct {
>> +    ThreadPoolFunc *func;
>> +    void *opaque;
>> +    GDestroyNotify opaque_destroy;
>> +} ThreadPoolElement;
>> +
>> +static void thread_pool_func(gpointer data, gpointer user_data)
>> +{
>> +    ThreadPool *pool = user_data;
>> +    g_autofree ThreadPoolElement *el = data;
>> +
>> +    el->func(el->opaque);
>> +
>> +    if (el->opaque_destroy) {
>> +        el->opaque_destroy(el->opaque);
>> +    }
>> +
>> +    QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex);
>> +
>> +    assert(pool->unfinished_el_ctr > 0);
>> +    pool->unfinished_el_ctr--;
>> +
>> +    if (pool->unfinished_el_ctr == 0) {
>> +        qemu_cond_signal(&pool->unfinished_el_ctr_zero_cond);
>> +    }
>> +}
>> +
>> +ThreadPool *thread_pool_new(void)
>> +{
>> +    ThreadPool *pool = g_new(ThreadPool, 1);
>> +
>> +    pool->unfinished_el_ctr = 0;
>> +    qemu_mutex_init(&pool->unfinished_el_ctr_mutex);
>> +    qemu_cond_init(&pool->unfinished_el_ctr_zero_cond);
>> +
>> +    pool->t = g_thread_pool_new(thread_pool_func, pool, 0, TRUE, NULL);
>> +    /*
>> +     * g_thread_pool_new() can only return errors if initial thread(s)
>> +     * creation fails but we ask for 0 initial threads above.
>> +     */
>> +    assert(pool->t);
>> +
>> +    return pool;
>> +}
>> +
>> +void thread_pool_free(ThreadPool *pool)
>> +{
>> +    g_thread_pool_free(pool->t, FALSE, TRUE);
>> +
>> +    qemu_cond_destroy(&pool->unfinished_el_ctr_zero_cond);
>> +    qemu_mutex_destroy(&pool->unfinished_el_ctr_mutex);
>> +
>> +    g_free(pool);
>> +}
>> +
>> +void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
>> +                        void *opaque, GDestroyNotify opaque_destroy)
>> +{
>> +    ThreadPoolElement *el = g_new(ThreadPoolElement, 1);
>> +
>> +    el->func = func;
>> +    el->opaque = opaque;
>> +    el->opaque_destroy = opaque_destroy;
>> +
>> +    WITH_QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex) {
>> +        pool->unfinished_el_ctr++;
>> +    }
>> +
>> +    /*
>> +     * Ignore the return value since this function can only return errors
>> +     * if creation of an additional thread fails but even in this case the
>> +     * provided work is still getting queued (just for the existing threads).
>> +     */
>> +    g_thread_pool_push(pool->t, el, NULL);
>> +}
>> +
>> +void thread_pool_wait(ThreadPool *pool)
>> +{
>> +    QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex);
>> +
>> +    if (pool->unfinished_el_ctr > 0) {
>> +        qemu_cond_wait(&pool->unfinished_el_ctr_zero_cond,
>> +                       &pool->unfinished_el_ctr_mutex);
>> +        assert(pool->unfinished_el_ctr == 0);
>> +    }
> 
> Shouldn't we put the condition in a while loop and remove the assert (as the wait may wake up spuriously)?

You're right - spurious wake-ups can theoretically happen.

> Thanks.
> 

Thanks,
Maciej


