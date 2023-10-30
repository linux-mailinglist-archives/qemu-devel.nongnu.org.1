Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EEB7DB24C
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 04:38:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxJ5B-0004FM-FS; Sun, 29 Oct 2023 23:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxJ59-0004Ex-Qc
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:36:51 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxJ57-0000Ll-IE
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:36:51 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4083f613275so29520355e9.2
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 20:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698637008; x=1699241808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mf4/7UVRiLpRnuSKTdGQjFO3fn80t7w58PQBuFU5/TM=;
 b=zP5UmK9vruggYD5JOKnFxOUjwxmtBBeTZRXBKRgKLNegGdRTi88LC4sWER4nj1IKRB
 g/CEvTOZIeg9LaR4JK3c/M2zioXeBKWtwlky8waJlg/+jDW6gqXURZD+natdfXN2Gx1X
 0aEwnj9y/YKysWEa1N8jdoKuNsSduw6hYLGP8CnRnWuBerrctx3D3gRldFh6GCZdBHnq
 uthVC41e6juq24eMwpnVyE+hGhoQD8pTw6QdTB2YBcFW+zxylFxyjEC2AvO69x/ZsBV2
 XsINL2qXbz4qdhp9v/p9VDdpXBGSPF0CRTrnynh4zEII440qomYeOjaOYhSuSMn1Pjc8
 qM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698637008; x=1699241808;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mf4/7UVRiLpRnuSKTdGQjFO3fn80t7w58PQBuFU5/TM=;
 b=cibxeBB3klRH9nBSGRS5sg7wW0s3cyP0QKWjrRBgA7O+NCUia0ra9IojBNHnk2fHJm
 uM0rsx6y6hVKVpndhHpZMa2PsrKzhMpdwydDWVRR83X4I+VTEeLEgIHVEn7YnlLXh7GQ
 zO2qKYo+lyG4hPiqHUfLAxFvJWoo/Mf9zdi/V4NnyhuSYZPJtWdoTI3iWvleQbpCNSKN
 N9qLb2QpNQCCLTqXnkAAaSTiG5P+x4PMF2t0G8FNy6r+2JhelhnKHsAQxGGR2Bn8BiV6
 aHMhrylCkjQHzQ9dU7h4qbUMz4X8ZzY56UZhaq0f3yqH9tAViTvP0hXXwJKhKOnkmd8Z
 /aCg==
X-Gm-Message-State: AOJu0YyT/wyf6NO6nGDp5IWtnNd7CPpRquSP5oDHdJuUZdnQXZsUFpAm
 3hsdeeA/MSFMVQO4h5QPuVmFhQ==
X-Google-Smtp-Source: AGHT+IHsda1F7DhuUVCxt75nE0w6EOx9pXP+FV0GRWsc2gySdJdTYHwj3dLpEFXW8ODMjOmGX9bqlQ==
X-Received: by 2002:a05:600c:164a:b0:409:1841:3f42 with SMTP id
 o10-20020a05600c164a00b0040918413f42mr6954044wmn.13.1698637007884; 
 Sun, 29 Oct 2023 20:36:47 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 gy14-20020a05600c880e00b004064741f855sm7947914wmb.47.2023.10.29.20.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 20:36:47 -0700 (PDT)
Message-ID: <fd799a65-8dbd-4206-241b-6b9a300caf8c@linaro.org>
Date: Mon, 30 Oct 2023 04:36:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 6/6] system/memory: Trace names of MemoryRegions rather
 than host pointers
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20231028122415.14869-1-shentey@gmail.com>
 <20231028122415.14869-7-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231028122415.14869-7-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.972,
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

Hi Bernhard,

On 28/10/23 14:24, Bernhard Beschow wrote:
> Tracing the host pointer of the accessed MemoryRegion seems to be a debug
> feature for developing QEMU itself. When analyzing guest behavior by comparing
> traces, these pointers generate a lot of noise since the pointers differ between
> QEMU invocations, making this task harder than it needs to be. Moreover, the
> pointers seem to be redundant to the names already assigned to MemoryRegions.

I tried that few years ago but this got lost:
https://lore.kernel.org/qemu-devel/20210307074833.143106-1-f4bug@amsat.org/

> Remove the pointers from the traces and trace the names where missing. When
> developing QEMU, developers could just add the host pointer tracing for
> themselves.

But sometimes an object exposing a MR is instantiated multiple times,
each time, and now you can not distinct which object is accessed.

IIRC a suggestion was to cache the QOM parent path and display that,
which should be constant to diff tracing logs. But then IIRC again the
issue was the QOM path is resolved once the object is realized, which
happens *after* we initialize the MR within the object. Maybe the
solution is to add a memory_region_qom_pathname() getter and do lazy
initialization?

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   docs/devel/tracing.rst |  4 ++--
>   system/memory.c        | 26 ++++++++++++++++----------
>   system/trace-events    | 12 ++++++------
>   3 files changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/docs/devel/tracing.rst b/docs/devel/tracing.rst
> index d288480db1..8c31d5f76e 100644
> --- a/docs/devel/tracing.rst
> +++ b/docs/devel/tracing.rst
> @@ -18,8 +18,8 @@ events::
>   
>       $ qemu --trace "memory_region_ops_*" ...
>       ...
> -    719585@1608130130.441188:memory_region_ops_read cpu 0 mr 0x562fdfbb3820 addr 0x3cc value 0x67 size 1
> -    719585@1608130130.441190:memory_region_ops_write cpu 0 mr 0x562fdfbd2f00 addr 0x3d4 value 0x70e size 2
> +    719585@1608130130.441188:memory_region_ops_read cpu 0 addr 0x3cc value 0x67 size 1
> +    719585@1608130130.441190:memory_region_ops_write cpu 0 addr 0x3d4 value 0x70e size 2

Is this example missing the MR name?

>   
>   This output comes from the "log" trace backend that is enabled by default when
>   ``./configure --enable-trace-backends=BACKENDS`` was not explicitly specified.
> diff --git a/system/memory.c b/system/memory.c
> index 4928f2525d..076a992b74 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -444,10 +444,11 @@ static MemTxResult  memory_region_read_accessor(MemoryRegion *mr,
>   
>       tmp = mr->ops->read(mr->opaque, addr, size);
>       if (mr->subpage) {
> -        trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
> +        trace_memory_region_subpage_read(get_cpu_index(), addr, tmp, size,
> +                                         memory_region_name(mr));
>       } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_READ)) {
>           hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
> -        trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size,
> +        trace_memory_region_ops_read(get_cpu_index(), abs_addr, tmp, size,
>                                        memory_region_name(mr));
>       }
>       memory_region_shift_read_access(value, shift, mask, tmp);
> @@ -467,10 +468,11 @@ static MemTxResult memory_region_read_with_attrs_accessor(MemoryRegion *mr,
>   
>       r = mr->ops->read_with_attrs(mr->opaque, addr, &tmp, size, attrs);
>       if (mr->subpage) {
> -        trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
> +        trace_memory_region_subpage_read(get_cpu_index(), addr, tmp, size,
> +                                         memory_region_name(mr));
>       } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_READ)) {
>           hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
> -        trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size,
> +        trace_memory_region_ops_read(get_cpu_index(), abs_addr, tmp, size,
>                                        memory_region_name(mr));
>       }
>       memory_region_shift_read_access(value, shift, mask, tmp);
> @@ -488,10 +490,11 @@ static MemTxResult memory_region_write_accessor(MemoryRegion *mr,
>       uint64_t tmp = memory_region_shift_write_access(value, shift, mask);
>   
>       if (mr->subpage) {
> -        trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, size);
> +        trace_memory_region_subpage_write(get_cpu_index(), addr, tmp, size,
> +                                          memory_region_name(mr));
>       } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_WRITE)) {
>           hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
> -        trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size,
> +        trace_memory_region_ops_write(get_cpu_index(), abs_addr, tmp, size,
>                                         memory_region_name(mr));
>       }
>       mr->ops->write(mr->opaque, addr, tmp, size);
> @@ -509,10 +512,11 @@ static MemTxResult memory_region_write_with_attrs_accessor(MemoryRegion *mr,
>       uint64_t tmp = memory_region_shift_write_access(value, shift, mask);
>   
>       if (mr->subpage) {
> -        trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, size);
> +        trace_memory_region_subpage_write(get_cpu_index(), addr, tmp, size,
> +                                          memory_region_name(mr));
>       } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_WRITE)) {
>           hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
> -        trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size,
> +        trace_memory_region_ops_write(get_cpu_index(), abs_addr, tmp, size,
>                                         memory_region_name(mr));
>       }
>       return mr->ops->write_with_attrs(mr->opaque, addr, tmp, size, attrs);
> @@ -1356,7 +1360,8 @@ static uint64_t memory_region_ram_device_read(void *opaque,
>           break;
>       }
>   
> -    trace_memory_region_ram_device_read(get_cpu_index(), mr, addr, data, size);
> +    trace_memory_region_ram_device_read(get_cpu_index(), addr, data, size,
> +                                        memory_region_name(mr));
>   
>       return data;
>   }
> @@ -1366,7 +1371,8 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
>   {
>       MemoryRegion *mr = opaque;
>   
> -    trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
> +    trace_memory_region_ram_device_write(get_cpu_index(), addr, data, size,
> +                                         memory_region_name(mr));
>   
>       switch (size) {
>       case 1:
> diff --git a/system/trace-events b/system/trace-events
> index 69c9044151..21f1c005e0 100644
> --- a/system/trace-events
> +++ b/system/trace-events
> @@ -9,12 +9,12 @@ cpu_in(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
>   cpu_out(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
>   
>   # memory.c
> -memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size, const char *name) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
> -memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size, const char *name) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
> -memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
> -memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
> -memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> -memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> +memory_region_ops_read(int cpu_index, uint64_t addr, uint64_t value, unsigned size, const char *name) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
> +memory_region_ops_write(int cpu_index, uint64_t addr, uint64_t value, unsigned size, const char *name) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
> +memory_region_subpage_read(int cpu_index, uint64_t offset, uint64_t value, unsigned size, const char *name) "cpu %d offset 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
> +memory_region_subpage_write(int cpu_index, uint64_t offset, uint64_t value, unsigned size, const char *name) "cpu %d offset 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
> +memory_region_ram_device_read(int cpu_index, uint64_t addr, uint64_t value, unsigned size, const char *name) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
> +memory_region_ram_device_write(int cpu_index, uint64_t addr, uint64_t value, unsigned size, const char *name) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
>   memory_region_sync_dirty(const char *mr, const char *listener, int global) "mr '%s' listener '%s' synced (global=%d)"
>   flatview_new(void *view, void *root) "%p (root %p)"
>   flatview_destroy(void *view, void *root) "%p (root %p)"


