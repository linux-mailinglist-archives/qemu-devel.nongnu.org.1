Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B99817F4C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 02:35:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFOzT-0008CM-MN; Mon, 18 Dec 2023 20:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rFOzP-0008C7-In
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 20:33:43 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rFOzM-0005hX-Ss
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 20:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702949621; x=1734485621;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=lrMlTGx84nAza5b7Oa9KxSKj8I36gG22SE7M9wsUauU=;
 b=R2xqDZIRmVkdmWYHsdvGVlIV4NWH6NKKfdRlsQuGcDecTbX/zkKrfcBo
 4LBiB6CkwGqPcNrcfnVrRJHQkc37HhLHsL5UgWoN3VPfVP/FKAKx+trIm
 D8J7nu8eaonKUFRYeIW4bLTToVacce3ME4TTf/BzusODp09pB9yFnmtgD
 FHz6NmmjGlONBKQmsRs/MMRFcDL3k0U4D1pTdn0jXZN8e5PP19dFVQwkm
 kl7bt0N1pkjLVCa6Nm2EzJC3bJE6+F8PC4sHdVmYwNIu+ZBGE2w4ZC9bq
 bpqN/r3mXsBztjTLSD0cr11b9yr/e26ixRX7F4bznliTi5xZqwpPCyQPF w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2805139"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="2805139"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2023 17:33:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="804717185"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; d="scan'208";a="804717185"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.93.5.108])
 ([10.93.5.108])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2023 17:33:34 -0800
Message-ID: <6ec82a24-f040-43a9-a81d-b5dad0e07a22@intel.com>
Date: Tue, 19 Dec 2023 09:33:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2 09/20] util/dsa: Implement DSA task
 asynchronous completion thread model.
Content-Language: en-US
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-10-hao.xiang@bytedance.com>
 <543e9270-4ab7-4096-bda7-187dd9be47ef@intel.com>
 <CAAYibXh4YeePb4rZNxLjo+UAed51cV+0zE7pxaS9zGn2=aDXOw@mail.gmail.com>
From: "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <CAAYibXh4YeePb4rZNxLjo+UAed51cV+0zE7pxaS9zGn2=aDXOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.083,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/19/2023 2:57, Hao Xiang wrote:> On Sun, Dec 17, 2023 at 7:11 PM Wang, Lei
<lei4.wang@intel.com> wrote:
>>
>> On 11/14/2023 13:40, Hao Xiang wrote:> * Create a dedicated thread for DSA task
>> completion.
>>> * DSA completion thread runs a loop and poll for completed tasks.
>>> * Start and stop DSA completion thread during DSA device start stop.
>>>
>>> User space application can directly submit task to Intel DSA
>>> accelerator by writing to DSA's device memory (mapped in user space).
>>
>>> +            }
>>> +            return;
>>> +        }
>>> +    } else {
>>> +        assert(batch_status == DSA_COMP_BATCH_FAIL ||
>>> +            batch_status == DSA_COMP_BATCH_PAGE_FAULT);
>>
>> Nit: indentation is broken here.
>>
>>> +    }
>>> +
>>> +    for (int i = 0; i < count; i++) {
>>> +
>>> +        completion = &batch_task->completions[i];
>>> +        status = completion->status;
>>> +
>>> +        if (status == DSA_COMP_SUCCESS) {
>>> +            results[i] = (completion->result == 0);
>>> +            continue;
>>> +        }
>>> +
>>> +        if (status != DSA_COMP_PAGE_FAULT_NOBOF) {
>>> +            fprintf(stderr,
>>> +                    "Unexpected completion status = %u.\n", status);
>>> +            assert(false);
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +/**
>>> + * @brief Handles an asynchronous DSA batch task completion.
>>> + *
>>> + * @param task A pointer to the batch buffer zero task structure.
>>> + */
>>> +static void
>>> +dsa_batch_task_complete(struct buffer_zero_batch_task *batch_task)
>>> +{
>>> +    batch_task->status = DSA_TASK_COMPLETION;
>>> +    batch_task->completion_callback(batch_task);
>>> +}
>>> +
>>> +/**
>>> + * @brief The function entry point called by a dedicated DSA
>>> + *        work item completion thread.
>>> + *
>>> + * @param opaque A pointer to the thread context.
>>> + *
>>> + * @return void* Not used.
>>> + */
>>> +static void *
>>> +dsa_completion_loop(void *opaque)
>>
>> Per my understanding, if a multifd sending thread corresponds to a DSA device,
>> then the batch tasks are executed in parallel which means a task may be
>> completed slower than another even if this task is enqueued earlier than it. If
>> we poll on the slower task first it will block the handling of the faster one,
>> even if the zero checking task for that thread is finished and it can go ahead
>> and send the data to the wire, this may lower the network resource utilization.
>>
> 
> Hi Lei, thanks for reviewing. You are correct that we can keep pulling
> a task enqueued first while others in the queue have already been
> completed. In fact, only one DSA completion thread (pulling thread) is
> used here even when multiple DSA devices are used. The pulling loop is
> the most CPU intensive activity in the DSA workflow and that acts
> directly against the goal of saving CPU usage. The trade-off I want to
> take here is a slightly higher latency on DSA task completion but more
> CPU savings. A single DSA engine can reach 30 GB/s throughput on
> memory comparison operation. We use kernel tcp stack for network
> transfer. The best I see is around 10GB/s throughput.  RDMA can
> potentially go higher but I am not sure if it can go higher than 30
> GB/s throughput anytime soon.

Hi Hao, that makes sense, if the DSA is faster than the network, then a little
bit of latency in DSA checking is tolerable. In the long term, I think the best
form of the DSA task checking thread is to use an fd or such sort of thing that
can multiplex the checking of different DSA devices, then we can serve the DSA
task in the order they complete rather than FCFS.

> 
>>> +{
>>> +    struct dsa_completion_thread *thread_context =
>>> +        (struct dsa_completion_thread *)opaque;
>>> +    struct buffer_zero_batch_task *batch_task;
>>> +    struct dsa_device_group *group = thread_context->group;
>>> +
>>> +    rcu_register_thread();
>>> +
>>> +    thread_context->thread_id = qemu_get_thread_id();
>>> +    qemu_sem_post(&thread_context->sem_init_done);
>>> +
>>> +    while (thread_context->running) {
>>> +        batch_task = dsa_task_dequeue(group);
>>> +        assert(batch_task != NULL || !group->running);
>>> +        if (!group->running) {
>>> +            assert(!thread_context->running);
>>> +            break;
>>> +        }
>>> +        if (batch_task->task_type == DSA_TASK) {
>>> +            poll_task_completion(batch_task);
>>> +        } else {
>>> +            assert(batch_task->task_type == DSA_BATCH_TASK);
>>> +            poll_batch_task_completion(batch_task);
>>> +        }
>>> +
>>> +        dsa_batch_task_complete(batch_task);
>>> +    }
>>> +
>>> +    rcu_unregister_thread();
>>> +    return NULL;
>>> +}
>>> +
>>> +/**
>>> + * @brief Initializes a DSA completion thread.
>>> + *
>>> + * @param completion_thread A pointer to the completion thread context.
>>> + * @param group A pointer to the DSA device group.
>>> + */
>>> +static void
>>> +dsa_completion_thread_init(
>>> +    struct dsa_completion_thread *completion_thread,
>>> +    struct dsa_device_group *group)
>>> +{
>>> +    completion_thread->stopping = false;
>>> +    completion_thread->running = true;
>>> +    completion_thread->thread_id = -1;
>>> +    qemu_sem_init(&completion_thread->sem_init_done, 0);
>>> +    completion_thread->group = group;
>>> +
>>> +    qemu_thread_create(&completion_thread->thread,
>>> +                       DSA_COMPLETION_THREAD,
>>> +                       dsa_completion_loop,
>>> +                       completion_thread,
>>> +                       QEMU_THREAD_JOINABLE);
>>> +
>>> +    /* Wait for initialization to complete */
>>> +    while (completion_thread->thread_id == -1) {
>>> +        qemu_sem_wait(&completion_thread->sem_init_done);
>>> +    }
>>> +}
>>> +
>>> +/**
>>> + * @brief Stops the completion thread (and implicitly, the device group).
>>> + *
>>> + * @param opaque A pointer to the completion thread.
>>> + */
>>> +static void dsa_completion_thread_stop(void *opaque)
>>> +{
>>> +    struct dsa_completion_thread *thread_context =
>>> +        (struct dsa_completion_thread *)opaque;
>>> +
>>> +    struct dsa_device_group *group = thread_context->group;
>>> +
>>> +    qemu_mutex_lock(&group->task_queue_lock);
>>> +
>>> +    thread_context->stopping = true;
>>> +    thread_context->running = false;
>>> +
>>> +    dsa_device_group_stop(group);
>>> +
>>> +    qemu_cond_signal(&group->task_queue_cond);
>>> +    qemu_mutex_unlock(&group->task_queue_lock);
>>> +
>>> +    qemu_thread_join(&thread_context->thread);
>>> +
>>> +    qemu_sem_destroy(&thread_context->sem_init_done);
>>> +}
>>> +
>>>  /**
>>>   * @brief Check if DSA is running.
>>>   *
>>> @@ -446,7 +685,7 @@ submit_batch_wi_async(struct buffer_zero_batch_task *batch_task)
>>>   */
>>>  bool dsa_is_running(void)
>>>  {
>>> -    return false;
>>> +    return completion_thread.running;
>>>  }
>>>
>>>  static void
>>> @@ -481,6 +720,7 @@ void dsa_start(void)
>>>          return;
>>>      }
>>>      dsa_device_group_start(&dsa_group);
>>> +    dsa_completion_thread_init(&completion_thread, &dsa_group);
>>>  }
>>>
>>>  /**
>>> @@ -496,6 +736,7 @@ void dsa_stop(void)
>>>          return;
>>>      }
>>>
>>> +    dsa_completion_thread_stop(&completion_thread);
>>>      dsa_empty_task_queue(group);
>>>  }
>>>

