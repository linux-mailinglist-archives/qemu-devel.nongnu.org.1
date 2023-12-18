Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FE481653F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 04:12:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF42C-0006pp-Sr; Sun, 17 Dec 2023 22:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rF42A-0006pT-RH
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 22:11:10 -0500
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rF428-0006kO-Ds
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 22:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702869068; x=1734405068;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=6q6ySzPr5wtqyeeeardb0KdQzzaz3UoxOoPsjkKheHw=;
 b=ExQokvDRV1ihUa64rs6v10CkVwFYITtA6WLzmhp9a1yMrNqt+fztSmn2
 ixsGa4Zepqc+n7DW8B7tN4siQ01GR78DybI6aa4InrNiMJeL/L79RUtJA
 rrRoNq24Z20PFJP+GpgpaleSkB9APJUY61U/IXZ2WkXS1VlYDqqrq0eN5
 wmIJelmwbz9qxr79hxXcM2tyE/0gwY1lCqE2XTZf4rmFX/5vOF/OS9OHY
 R2tGsHxdnqIdEGekKbSAlcAtmh0IPp7AIwbmGgCV4QfnAwZsYGix4ue8y
 SDMuufpk/4JADSP65rRU98Zzdi0/nAUmelf1jvIP7YELDocqbSKJGSYkx g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="375603139"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; d="scan'208";a="375603139"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2023 19:11:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="804383179"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; d="scan'208";a="804383179"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.93.5.108])
 ([10.93.5.108])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2023 19:11:02 -0800
Message-ID: <543e9270-4ab7-4096-bda7-187dd9be47ef@intel.com>
Date: Mon, 18 Dec 2023 11:11:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/20] util/dsa: Implement DSA task asynchronous
 completion thread model.
Content-Language: en-US
To: Hao Xiang <hao.xiang@bytedance.com>, farosas@suse.de,
 peter.maydell@linaro.org, quintela@redhat.com, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com, qemu-devel@nongnu.org
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-10-hao.xiang@bytedance.com>
From: "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <20231114054032.1192027-10-hao.xiang@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.086,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/14/2023 13:40, Hao Xiang wrote:> * Create a dedicated thread for DSA task
completion.
> * DSA completion thread runs a loop and poll for completed tasks.
> * Start and stop DSA completion thread during DSA device start stop.
> 
> User space application can directly submit task to Intel DSA
> accelerator by writing to DSA's device memory (mapped in user space).

> +            }
> +            return;
> +        }
> +    } else {
> +        assert(batch_status == DSA_COMP_BATCH_FAIL ||
> +            batch_status == DSA_COMP_BATCH_PAGE_FAULT);

Nit: indentation is broken here.

> +    }
> +
> +    for (int i = 0; i < count; i++) {
> +
> +        completion = &batch_task->completions[i];
> +        status = completion->status;
> +
> +        if (status == DSA_COMP_SUCCESS) {
> +            results[i] = (completion->result == 0);
> +            continue;
> +        }
> +
> +        if (status != DSA_COMP_PAGE_FAULT_NOBOF) {
> +            fprintf(stderr,
> +                    "Unexpected completion status = %u.\n", status);
> +            assert(false);
> +        }
> +    }
> +}
> +
> +/**
> + * @brief Handles an asynchronous DSA batch task completion.
> + *
> + * @param task A pointer to the batch buffer zero task structure.
> + */
> +static void
> +dsa_batch_task_complete(struct buffer_zero_batch_task *batch_task)
> +{
> +    batch_task->status = DSA_TASK_COMPLETION;
> +    batch_task->completion_callback(batch_task);
> +}
> +
> +/**
> + * @brief The function entry point called by a dedicated DSA
> + *        work item completion thread.
> + *
> + * @param opaque A pointer to the thread context.
> + *
> + * @return void* Not used.
> + */
> +static void *
> +dsa_completion_loop(void *opaque)

Per my understanding, if a multifd sending thread corresponds to a DSA device,
then the batch tasks are executed in parallel which means a task may be
completed slower than another even if this task is enqueued earlier than it. If
we poll on the slower task first it will block the handling of the faster one,
even if the zero checking task for that thread is finished and it can go ahead
and send the data to the wire, this may lower the network resource utilization.

> +{
> +    struct dsa_completion_thread *thread_context =
> +        (struct dsa_completion_thread *)opaque;
> +    struct buffer_zero_batch_task *batch_task;
> +    struct dsa_device_group *group = thread_context->group;
> +
> +    rcu_register_thread();
> +
> +    thread_context->thread_id = qemu_get_thread_id();
> +    qemu_sem_post(&thread_context->sem_init_done);
> +
> +    while (thread_context->running) {
> +        batch_task = dsa_task_dequeue(group);
> +        assert(batch_task != NULL || !group->running);
> +        if (!group->running) {
> +            assert(!thread_context->running);
> +            break;
> +        }
> +        if (batch_task->task_type == DSA_TASK) {
> +            poll_task_completion(batch_task);
> +        } else {
> +            assert(batch_task->task_type == DSA_BATCH_TASK);
> +            poll_batch_task_completion(batch_task);
> +        }
> +
> +        dsa_batch_task_complete(batch_task);
> +    }
> +
> +    rcu_unregister_thread();
> +    return NULL;
> +}
> +
> +/**
> + * @brief Initializes a DSA completion thread.
> + *
> + * @param completion_thread A pointer to the completion thread context.
> + * @param group A pointer to the DSA device group.
> + */
> +static void
> +dsa_completion_thread_init(
> +    struct dsa_completion_thread *completion_thread,
> +    struct dsa_device_group *group)
> +{
> +    completion_thread->stopping = false;
> +    completion_thread->running = true;
> +    completion_thread->thread_id = -1;
> +    qemu_sem_init(&completion_thread->sem_init_done, 0);
> +    completion_thread->group = group;
> +
> +    qemu_thread_create(&completion_thread->thread,
> +                       DSA_COMPLETION_THREAD,
> +                       dsa_completion_loop,
> +                       completion_thread,
> +                       QEMU_THREAD_JOINABLE);
> +
> +    /* Wait for initialization to complete */
> +    while (completion_thread->thread_id == -1) {
> +        qemu_sem_wait(&completion_thread->sem_init_done);
> +    }
> +}
> +
> +/**
> + * @brief Stops the completion thread (and implicitly, the device group).
> + *
> + * @param opaque A pointer to the completion thread.
> + */
> +static void dsa_completion_thread_stop(void *opaque)
> +{
> +    struct dsa_completion_thread *thread_context =
> +        (struct dsa_completion_thread *)opaque;
> +
> +    struct dsa_device_group *group = thread_context->group;
> +
> +    qemu_mutex_lock(&group->task_queue_lock);
> +
> +    thread_context->stopping = true;
> +    thread_context->running = false;
> +
> +    dsa_device_group_stop(group);
> +
> +    qemu_cond_signal(&group->task_queue_cond);
> +    qemu_mutex_unlock(&group->task_queue_lock);
> +
> +    qemu_thread_join(&thread_context->thread);
> +
> +    qemu_sem_destroy(&thread_context->sem_init_done);
> +}
> +
>  /**
>   * @brief Check if DSA is running.
>   *
> @@ -446,7 +685,7 @@ submit_batch_wi_async(struct buffer_zero_batch_task *batch_task)
>   */
>  bool dsa_is_running(void)
>  {
> -    return false;
> +    return completion_thread.running;
>  }
>  
>  static void
> @@ -481,6 +720,7 @@ void dsa_start(void)
>          return;
>      }
>      dsa_device_group_start(&dsa_group);
> +    dsa_completion_thread_init(&completion_thread, &dsa_group);
>  }
>  
>  /**
> @@ -496,6 +736,7 @@ void dsa_stop(void)
>          return;
>      }
>  
> +    dsa_completion_thread_stop(&completion_thread);
>      dsa_empty_task_queue(group);
>  }
>  

