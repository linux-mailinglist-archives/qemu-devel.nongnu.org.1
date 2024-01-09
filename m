Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A178287E1
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 15:17:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNCtV-0001V8-V7; Tue, 09 Jan 2024 09:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rNCtS-0001RI-M3
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:15:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rNCtP-0003k6-P7
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704809745;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LqtgOqmxwlMBm7PGaB+24Mh/jl6pwgFi0hbi9WZJZ4M=;
 b=X3PMFUL14shFKVuRjB6JttuO4vFzCAiTgtnViaS5oFs6Nl2HgO0VkCbqgy57JVPjXUQIEq
 sJtQ1p7BJ6r2yKSKNXlbknvWrSWzUrl2N4skY/qph0c0X/ipOtuAWi+ADrA4piYi2m0AXN
 wFJMXosGcNUbymA8ux+wF2pZ1c5wBvw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-b33GgDuyNCmLXvcF6lKhfw-1; Tue,
 09 Jan 2024 09:15:43 -0500
X-MC-Unique: b33GgDuyNCmLXvcF6lKhfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93D0838425A3;
 Tue,  9 Jan 2024 14:15:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96A303C39;
 Tue,  9 Jan 2024 14:15:42 +0000 (UTC)
Date: Tue, 9 Jan 2024 14:15:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Mark Kanda <mark.kanda@oracle.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Subject: Re: [PATCH v1 1/2] oslib-posix: refactor memory prealloc threads
Message-ID: <ZZ1VDF0U7PkOwgWh@redhat.com>
References: <20240108151041.529716-1-mark.kanda@oracle.com>
 <20240108151041.529716-2-mark.kanda@oracle.com>
 <2be78fc2-f76a-44de-8db7-fbc1bbdc0d2b@redhat.com>
 <1854ecdd-88d8-462d-aa0f-990c2bbe57ff@oracle.com>
 <02801117-4408-4069-b0ba-b54f4d050fc4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02801117-4408-4069-b0ba-b54f4d050fc4@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jan 09, 2024 at 03:02:00PM +0100, David Hildenbrand wrote:
> On 08.01.24 19:40, Mark Kanda wrote:
> > On 1/8/24 9:40 AM, David Hildenbrand wrote:
> > > On 08.01.24 16:10, Mark Kanda wrote:
> > > > Refactor the memory prealloc threads support:
> > > > - Make memset context a global qlist
> > > > - Move the memset thread join/cleanup code to a separate routine
> > > > 
> > > > This is functionally equivalent and facilitates multiple memset contexts
> > > > (used in a subsequent patch).
> > > > 
> > > > Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> > > > ---
> > > >    util/oslib-posix.c | 104 +++++++++++++++++++++++++++++----------------
> > > >    1 file changed, 68 insertions(+), 36 deletions(-)
> > > > 
> > > > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > > > index e86fd64e09..293297ac6c 100644
> > > > --- a/util/oslib-posix.c
> > > > +++ b/util/oslib-posix.c
> > > > @@ -63,11 +63,15 @@
> > > >      struct MemsetThread;
> > > >    +static QLIST_HEAD(, MemsetContext) memset_contexts =
> > > > +    QLIST_HEAD_INITIALIZER(memset_contexts);
> > > > +
> > > >    typedef struct MemsetContext {
> > > >        bool all_threads_created;
> > > >        bool any_thread_failed;
> > > >        struct MemsetThread *threads;
> > > >        int num_threads;
> > > > +    QLIST_ENTRY(MemsetContext) next;
> > > >    } MemsetContext;
> > > >      struct MemsetThread {
> > > > @@ -81,7 +85,7 @@ struct MemsetThread {
> > > >    typedef struct MemsetThread MemsetThread;
> > > >      /* used by sigbus_handler() */
> > > > -static MemsetContext *sigbus_memset_context;
> > > > +static bool sigbus_memset_context;
> > > >    struct sigaction sigbus_oldact;
> > > >    static QemuMutex sigbus_mutex;
> > > >    @@ -295,13 +299,16 @@ static void sigbus_handler(int signal)
> > > >    #endif /* CONFIG_LINUX */
> > > >    {
> > > >        int i;
> > > > +    MemsetContext *context;
> > > >          if (sigbus_memset_context) {
> > > > -        for (i = 0; i < sigbus_memset_context->num_threads; i++) {
> > > > -            MemsetThread *thread = &sigbus_memset_context->threads[i];
> > > > +        QLIST_FOREACH(context, &memset_contexts, next) {
> > > > +            for (i = 0; i < context->num_threads; i++) {
> > > > +                MemsetThread *thread = &context->threads[i];
> > > >    -            if (qemu_thread_is_self(&thread->pgthread)) {
> > > > -                siglongjmp(thread->env, 1);
> > > > +                if (qemu_thread_is_self(&thread->pgthread)) {
> > > > +                    siglongjmp(thread->env, 1);
> > > > +                }
> > > >                }
> > > >            }
> > > >        }
> > > > @@ -417,14 +424,15 @@ static int touch_all_pages(char *area, size_t
> > > > hpagesize, size_t numpages,
> > > >                               bool use_madv_populate_write)
> > > >    {
> > > >        static gsize initialized = 0;
> > > > -    MemsetContext context = {
> > > > -        .num_threads = get_memset_num_threads(hpagesize, numpages,
> > > > max_threads),
> > > > -    };
> > > > +    MemsetContext *context = g_malloc0(sizeof(MemsetContext));
> > > >        size_t numpages_per_thread, leftover;
> > > >        void *(*touch_fn)(void *);
> > > > -    int ret = 0, i = 0;
> > > > +    int i = 0;
> > > >        char *addr = area;
> > > >    +    context->num_threads =
> > > > +        get_memset_num_threads(hpagesize, numpages, max_threads);
> > > > +
> > > >        if (g_once_init_enter(&initialized)) {
> > > >            qemu_mutex_init(&page_mutex);
> > > >            qemu_cond_init(&page_cond);
> > > > @@ -433,7 +441,7 @@ static int touch_all_pages(char *area, size_t
> > > > hpagesize, size_t numpages,
> > > >          if (use_madv_populate_write) {
> > > >            /* Avoid creating a single thread for MADV_POPULATE_WRITE */
> > > > -        if (context.num_threads == 1) {
> > > > +        if (context->num_threads == 1) {
> > > >                if (qemu_madvise(area, hpagesize * numpages,
> > > >                                 QEMU_MADV_POPULATE_WRITE)) {
> > > >                    return -errno;
> > > > @@ -445,49 +453,74 @@ static int touch_all_pages(char *area, size_t
> > > > hpagesize, size_t numpages,
> > > >            touch_fn = do_touch_pages;
> > > >        }
> > > >    -    context.threads = g_new0(MemsetThread, context.num_threads);
> > > > -    numpages_per_thread = numpages / context.num_threads;
> > > > -    leftover = numpages % context.num_threads;
> > > > -    for (i = 0; i < context.num_threads; i++) {
> > > > -        context.threads[i].addr = addr;
> > > > -        context.threads[i].numpages = numpages_per_thread + (i <
> > > > leftover);
> > > > -        context.threads[i].hpagesize = hpagesize;
> > > > -        context.threads[i].context = &context;
> > > > +    context->threads = g_new0(MemsetThread, context->num_threads);
> > > > +    numpages_per_thread = numpages / context->num_threads;
> > > > +    leftover = numpages % context->num_threads;
> > > > +    for (i = 0; i < context->num_threads; i++) {
> > > > +        context->threads[i].addr = addr;
> > > > +        context->threads[i].numpages = numpages_per_thread + (i <
> > > > leftover);
> > > > +        context->threads[i].hpagesize = hpagesize;
> > > > +        context->threads[i].context = context;
> > > >            if (tc) {
> > > > -            thread_context_create_thread(tc,
> > > > &context.threads[i].pgthread,
> > > > +            thread_context_create_thread(tc,
> > > > &context->threads[i].pgthread,
> > > >                                             "touch_pages",
> > > > -                                         touch_fn, &context.threads[i],
> > > > +                                         touch_fn,
> > > > &context->threads[i],
> > > > QEMU_THREAD_JOINABLE);
> > > >            } else {
> > > > - qemu_thread_create(&context.threads[i].pgthread, "touch_pages",
> > > > -                               touch_fn, &context.threads[i],
> > > > + qemu_thread_create(&context->threads[i].pgthread, "touch_pages",
> > > > +                               touch_fn, &context->threads[i],
> > > >                                   QEMU_THREAD_JOINABLE);
> > > >            }
> > > > -        addr += context.threads[i].numpages * hpagesize;
> > > > +        addr += context->threads[i].numpages * hpagesize;
> > > >        }
> > > >    +    QLIST_INSERT_HEAD(&memset_contexts, context, next);
> > > > +
> > > >        if (!use_madv_populate_write) {
> > > > -        sigbus_memset_context = &context;
> > > > +        sigbus_memset_context = true;
> > > 
> > Thanks David,
> > 
> > > Could we just use the sigbus handling alone and support parallel init
> > > only when using MADV_POPULATE_WRITE where we don't have to mess with
> > > signal handlers?
> > > 
> > 
> > Ideally, we're hoping to support this with earlier kernels which don't
> > support MADV_POPULATE _WRITE. But, I will check to see if we really need it.
> 
> That's around since Linux 5.14, so please try simplifying.
> 
> > 
> > > Further, how do you changes interact with other callers of
> > > qemu_prealloc_mem(), like virtio-mem?
> > > 
> > 
> > I'm not familiar with the intricacies of virtio-mem, but the basic idea
> > of this series is to *only* allow parallel init during the start up
> > phase (while prealloc_init == false). Once we have parsed all the
> > command line args, we set prealloc_init = true
> > (wait_mem_prealloc_init()) which causes all subsequent calls to
> > qemu_prealloc_mem() to perform initialization synchronously. So, I
> > *think* this covers the virtio-mem use case. Am I missing something?
> 
> Good, so this should likely not affect virtio-mem (which also ends up
> preallocating memory when loading from a vmstate).
> 
> To make this all a bit clearer, what about the following to make this:
> 
> * Optimize for MADV_POPULATE_WRITE. If we really need support for
>   !MADV_POPULATE_WRITE, this is better added on top later.
> * Pass in via a parameter that the caller requests async handling. "bool
>   async" should be good enough. Then, pass that only from the memory
>   backend call, while QEMU is still initializing (we can find a way to
>   make that work).
> * Provide a function that waits for any remaining async os-mem-prealloc
>   activity. That is essentially "wait_mem_prealloc_init", but without
>   the special internal flag handling.
> 
> Further, I do wonder if we want to make that behavior configurable. For
> example, one might want to initialize backends sequentially using 16 threads
> max, instead of consuming multiple times 16 threads concurrently.

Seems to me that no matter what parallelisation we use (within
mem regions, or across mem regions, or a mix of both), we should
never use more threads than there are host CPUs.

Can we have a pool of threads sized per available host CPUs that
QEMU can access. Then for each memory backend fire off a set of
init jobs that get distributed to "appropriate" threads in the
pool. By appropriate I mean threads with the same NUMA affinity
as the memory backend. This would give parallelisation both
within a single large memory region, as well as across memory
regions.


eg 4 host CPUs, 3 memory regions (1GB for 1st numa node, 1GB
for 2nd numa node, and 1 GB with no numa affinity). If we
spread the init work then we end up with

 1st thread gets 500MB to init from 1st memory region, and
     250MB to init from 3rd memory region

 2st thread gets 500MB to init from 1st memory region, and
     250MB to init from 3rd memory region

 3st thread gets 500MB to init from 2nd memory region, and
     250MB to init from 3rd memory region

 4th thread gets 500MB to init from 2nd memory region, and
     250MB to init from 3rd memory region

>                                                                    Could
> either be a machine option or a memory backend option (async-prealloc=on).
> Once hotplugging such backends, we would disable it for now, but could allow
> it in the future.

IMHO "do the right thing" without user config is preferrable to adding
yet more cli options here.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


