Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01647B2CFDE
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Aug 2025 01:24:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoVgH-0001wB-Ud; Tue, 19 Aug 2025 19:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uoVgF-0001vR-3e; Tue, 19 Aug 2025 19:23:51 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uoVgC-0005Xv-IQ; Tue, 19 Aug 2025 19:23:50 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7e87035a7c3so814626585a.0; 
 Tue, 19 Aug 2025 16:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755645826; x=1756250626; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k53bPKY8terWpZ7Pq7EHPrx4xvjZ1UVjkatBDMk6bP8=;
 b=UfmOEM5RaoE0ja683k3uEpp93swQpxwlT3CT2BErEYx4eUlUnkCK0MtBz9YoGy/AVq
 WGIVqjLwNPBUX9x7wjJ4h2kmBKLICBeUWLuh+qdsf0bQ5nOBbHEe3aXEWKKG3QniELTN
 FQaM3SeVUY2c5PVBvkSve1oQotKbnow2eZUPjWf5SuBKQFKZnBcSkUiwiRSvWVnGi6i/
 HOIssu3h35xpBGh4fCLkrC7SnroWRJdxaoRtZHsJ+yJMnsDVhVrqsjZ0F0vXZMxtWyMu
 cyPXx4+ZtXZgvj7MXbRPEiTQYUOprE4RDlq+jNSZlN0po5HWkOFZbHrozaQs/rYqvRRj
 T3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755645826; x=1756250626;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k53bPKY8terWpZ7Pq7EHPrx4xvjZ1UVjkatBDMk6bP8=;
 b=LGlDR2aROdls5wJRPOS/yBWuNijmCQkxmo2ljksTOxXnKTAYefCcTQDnooifgp/B6E
 p3ugd22KhQfEj3YDbmYaPFVlUVQRvtrgqWMIMEHpkx8nIo5m1T68hJ9P0QwNtnGof68c
 5I1ajCcM0c0GBBF1yD1R4bInzGbvot5OaLuewB4PHVLML8guNb+PcD1Xxbx1Eb1SP1Bx
 sWrITCjS9NGOOb8gyuxuOzc7mlro19VrYaNYYZFc0wV1preJTLqeN1guTzHcnSGCqLTu
 UEHz/gXUVj9csH+ONwsC+SrkuJGs3wiPhnEEq+fBNweblK+RnLwtS9cXz/nHXLOEJUpg
 otVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULT3cBupzUdZNXGJ3FYS7U5a0BjF/1cxS8jG9c7lTwdQnf83rlCSEsczTo9/63aWbYwzu3dGIiU4JS@nongnu.org
X-Gm-Message-State: AOJu0YwSy0Bu/oXSZJCnMqkCFZHMECYYKinjBn519FjEABnWnLAyo2Qy
 KZXLa512U1q/uN3mMKlwgY57YQiWKVpVeq80A/dhrHc0csCWkXPjs5ID
X-Gm-Gg: ASbGncsthB0fvYsCRn3MnLrqhVRGnSA+yp3StqZethYHJnqq8r0hjVMwZjvilwedcOQ
 QOmmb5m9WwHZmHV7q73slrk5+VD8mykC0FrfTLcrtqrjuxaxVe1GY0UI6BB+JSFHFFkvlRKplL1
 G/MqJd6AFUcZeMwQapV8L4Prc1wwmkV7woP66VGJeYi+NLtSrRxP/vRFK6KPYEhI1jDel/3JtJ1
 sJX8PqRXi3ELUKnCF79LHgesEW4Y8DZQ5NRNJkxkgQJwJJVb492ekDRyhs3a0nWZ616u28/rHhY
 OWVS0qwZpuTWHwqlHLyMK5zlSyJCNn8yr2a9+x/ABPDHKykKKVQQV4QmTroDNIjqNS3pCNKYvdM
 mF92WVYIJQ5/ns2XLpC0yKr0RDDAZN2oAzkXqAwDVcwS9pqdhUXPwY+8X8Q3mwlAAHo+EQ/Wvi6
 1ueQ4PZQ==
X-Google-Smtp-Source: AGHT+IGZDHTZBXZd5RKywZEk+vBIfgJeXFpA0LMbdw/TklEvOrblg2iFEBgwPxB9BhV6CMk+li7vyg==
X-Received: by 2002:a05:620a:7012:b0:7e8:c99:96bd with SMTP id
 af79cd13be357-7e9fcbba7camr113858485a.66.1755645826041; 
 Tue, 19 Aug 2025 16:23:46 -0700 (PDT)
Received: from [10.36.3.90] (wn-campus-nat-129-97-124-90.dynamic.uwaterloo.ca.
 [129.97.124.90]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e87e06a389sm843801785a.27.2025.08.19.16.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 16:23:45 -0700 (PDT)
Message-ID: <daa0d4eb-363a-4553-8f61-b3aa3ae58600@gmail.com>
Date: Tue, 19 Aug 2025 19:23:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] fuse: add FUSE-over-io_uring enable opt and init
Content-Language: en-US
To: Bernd Schubert <bernd@bsbernd.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, fam@euphon.net,
 hreitz@redhat.com, kwolf@redhat.com, stefanha@redhat.com
References: <20250815034619.51980-1-hizhisong@gmail.com>
 <20250815034619.51980-2-hizhisong@gmail.com>
 <beb43845-a761-4031-a7b7-aaca56abb6de@gmail.com>
 <105d583b-e931-4e60-a113-9a571c18c726@bsbernd.com>
 <a76de187-f181-47d3-a36e-6eb1a865cc5e@gmail.com>
 <4896b694-6f00-49d9-ad8e-04225824eb6c@bsbernd.com>
From: Brian Song <hibriansong@gmail.com>
In-Reply-To: <4896b694-6f00-49d9-ad8e-04225824eb6c@bsbernd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=hibriansong@gmail.com; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 8/19/25 6:26 PM, Bernd Schubert wrote:
> 
> 
> On 8/19/25 03:15, Brian Song wrote:
>>
>>
>> On 8/18/25 7:04 PM, Bernd Schubert wrote:
>>>
>>>
>>> On 8/17/25 01:13, Brian Song wrote:
>>>>
>>>>
>>>> On 8/14/25 11:46 PM, Brian Song wrote:
>>>>> From: Brian Song <hibriansong@gmail.com>
>>>>>
>>>>> This patch adds a new export option for storage-export-daemon to enable
>>>>> or disable FUSE-over-io_uring via the switch io-uring=on|off (disable
>>>>> by default). It also implements the protocol handshake with the Linux
>>>>> kernel during the FUSE-over-io_uring initialization phase.
>>>>>
>>>>> See: https://docs.kernel.org/filesystems/fuse-io-uring.html
>>>>>
>>>>> The kernel documentation describes in detail how FUSE-over-io_uring
>>>>> works. This patch implements the Initial SQE stage shown in thediagram:
>>>>> it initializes one queue per IOThread, each currently supporting a
>>>>> single submission queue entry (SQE). When the FUSE driver sends the
>>>>> first FUSE request (FUSE_INIT), storage-export-daemon calls
>>>>> fuse_uring_start() to complete initialization, ultimately submitting
>>>>> the SQE with the FUSE_IO_URING_CMD_REGISTER command to confirm
>>>>> successful initialization with the kernel.
>>>>>
>>>>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>>>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>> Signed-off-by: Brian Song <hibriansong@gmail.com>
>>>>> ---
>>>>>     block/export/fuse.c                  | 161 ++++++++++++++++++++++++---
>>>>>     docs/tools/qemu-storage-daemon.rst   |  11 +-
>>>>>     qapi/block-export.json               |   5 +-
>>>>>     storage-daemon/qemu-storage-daemon.c |   1 +
>>>>>     util/fdmon-io_uring.c                |   5 +-
>>>>>     5 files changed, 159 insertions(+), 24 deletions(-)
>>>>>
>>>>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>>>>> index c0ad4696ce..59fa79f486 100644
>>>>> --- a/block/export/fuse.c
>>>>> +++ b/block/export/fuse.c
>>>>> @@ -48,6 +48,11 @@
>>>>>     #include <linux/fs.h>
>>>>>     #endif
>>>>>
>>>>> +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
>>>>> +
>>>>> +/* room needed in buffer to accommodate header */
>>>>> +#define FUSE_BUFFER_HEADER_SIZE 0x1000
>>>>> +
>>>>>     /* Prevent overly long bounce buffer allocations */
>>>>>     #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
>>>>>     /*
>>>>> @@ -63,12 +68,31 @@
>>>>>         (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
>>>>>
>>>>>     typedef struct FuseExport FuseExport;
>>>>> +typedef struct FuseQueue FuseQueue;
>>>>> +
>>>>> +typedef struct FuseRingEnt {
>>>>> +    /* back pointer */
>>>>> +    FuseQueue *q;
>>>>> +
>>>>> +    /* commit id of a fuse request */
>>>>> +    uint64_t req_commit_id;
>>>>> +
>>>>> +    /* fuse request header and payload */
>>>>> +    struct fuse_uring_req_header req_header;
>>>>> +    void *op_payload;
>>>>> +    size_t req_payload_sz;
>>>>> +
>>>>> +    /* The vector passed to the kernel */
>>>>> +    struct iovec iov[2];
>>>>> +
>>>>> +    CqeHandler fuse_cqe_handler;
>>>>> +} FuseRingEnt;
>>>>>
>>>>>     /*
>>>>>      * One FUSE "queue", representing one FUSE FD from which requests are fetched
>>>>>      * and processed.  Each queue is tied to an AioContext.
>>>>>      */
>>>>> -typedef struct FuseQueue {
>>>>> +struct FuseQueue {
>>>>>         FuseExport *exp;
>>>>>
>>>>>         AioContext *ctx;
>>>>> @@ -109,7 +133,12 @@ typedef struct FuseQueue {
>>>>>          * Free this buffer with qemu_vfree().
>>>>>          */
>>>>>         void *spillover_buf;
>>>>> -} FuseQueue;
>>>>> +
>>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>>> +    int qid;
>>>>> +    FuseRingEnt ent;
>>>>> +#endif
>>>>> +};
>>>>>
>>>>>     /*
>>>>>      * Verify that FuseQueue.request_buf plus the spill-over buffer together
>>>>> @@ -148,6 +177,7 @@ struct FuseExport {
>>>>>         bool growable;
>>>>>         /* Whether allow_other was used as a mount option or not */
>>>>>         bool allow_other;
>>>>> +    bool is_uring;
>>>>>
>>>>>         mode_t st_mode;
>>>>>         uid_t st_uid;
>>>>> @@ -257,6 +287,93 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
>>>>>         .drained_poll  = fuse_export_drained_poll,
>>>>>     };
>>>>>
>>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>>> +
>>>>> +static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
>>>>> +                    const unsigned int qid,
>>>>> +                    const unsigned int commit_id)
>>>>> +{
>>>>> +    req->qid = qid;
>>>>> +    req->commit_id = commit_id;
>>>>> +    req->flags = 0;
>>>>> +}
>>>>> +
>>>>> +static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue *q,
>>>>> +               __u32 cmd_op)
>>>>> +{
>>>>> +    sqe->opcode = IORING_OP_URING_CMD;
>>>>> +
>>>>> +    sqe->fd = q->fuse_fd;
>>>>> +    sqe->rw_flags = 0;
>>>>> +    sqe->ioprio = 0;
>>>>> +    sqe->off = 0;
>>>>> +
>>>>> +    sqe->cmd_op = cmd_op;
>>>>> +    sqe->__pad1 = 0;
>>>>> +}
>>>>> +
>>>>> +static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, void *opaque)
>>>>> +{
>>>>> +    FuseQueue *q = opaque;
>>>>> +    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
>>>>> +
>>>>> +    fuse_uring_sqe_prepare(sqe, q, FUSE_IO_URING_CMD_REGISTER);
>>>>> +
>>>>> +    sqe->addr = (uint64_t)(q->ent.iov);
>>>>> +    sqe->len = 2;
>>>>> +
>>>>> +    fuse_uring_sqe_set_req_data(req, q->qid, 0);
>>>>> +}
>>>>> +
>>>>> +static void fuse_uring_submit_register(void *opaque)
>>>>> +{
>>>>> +    FuseQueue *q = opaque;
>>>>> +    FuseExport *exp = q->exp;
>>>>> +
>>>>> +
>>>>> +    aio_add_sqe(fuse_uring_prep_sqe_register, q, &(q->ent.fuse_cqe_handler));
>>>>
>>>> I think there might be a tricky issue with the io_uring integration in
>>>> QEMU. Currently, when the number of IOThreads goes above ~6 or 7,
>>>> there’s a pretty high chance of a hang. I added some debug logging in
>>>> the kernel’s fuse_uring_cmd() registration part, and noticed that the
>>>> number of register calls is less than the total number of entries in the
>>>> queue. In theory, we should be registering each entry for each queue.
>>>
>>> Did you also try to add logging at the top of fuse_uring_cmd()? I wonder
>>> if there is a start up race and if initial commands are just getting
>>> refused. I had run into issues you are describing in some versions of
>>> the -rfc patches, but thought that everything was fixed for that.
>>> I.e. not excluded that there is still a kernel issue left.
>>>
>>> Thanks,
>>> Bernd
>>>
>>>
>>
>> Yes. I added a printk at the beginning of fuse_uring_cmd(), another at
>> the beginning of fuse_uring_register(), and one more at the end of
>> fuse_uring_do_register(). Then I created and registered 20 queues, each
>> with a single ring entry. It printed 37 times(diff every time) with
>> opcode FUSE_IO_URING_CMD_REGISTER (would expect 20), and only 6 queues
>> were registered successfully. The rest of fuse_uring_cmd (x31) exited
>> inside the if (!fc->initialized) branch in fuse_uring_cmd()
>>
>> dmesg: https://gist.github.com/hibriansong/4eda6e7e92601df497282dcd56fd5470
> 
> Thank you for the logs, could you try this?
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 2aa20707f40b..cea57ad5d3ab 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -1324,6 +1324,9 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>          if (!fc->connected)
>                  return -ENOTCONN;
>   
> +       /* Matches smp_wmb() in fuse_set_initialized() */
> +       smp_rmb();
> +
>          /*
>           * fuse_uring_register() needs the ring to be initialized,
>           * we need to know the max payload size
> 
> 
> 
> Thanks,
> Bernd

I realized the issue actually comes from QEMU handling the FUSE_INIT 
request. After I processed outargs, I didn't send the response back to 
the kernel before starting the fuse-over-io_uring initialization. So 
it's possible that the 20 registration requests submitted via 
io_uring_cmd() reach the kernel before process_init_reply() has run and 
set fc->initialized = 1, which causes fuse_uring_cmd to bail out repeatedly.

I also noticed that in libfuse, they first send the init request 
response, then allocate queues and submit the register SQEs. But even 
there, during the fuse-over-io_uring init after sending the response, if 
the kernel hasn't finished process_init_reply() and set fc->initialized 
= 1, wouldn't they run into a similar issue fuse_uring_cmd repeatedly 
bailing on register requests because fc->initialized isn't set yet?



