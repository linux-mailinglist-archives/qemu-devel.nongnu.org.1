Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D127DEF56
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:00:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUU0-00078v-NI; Thu, 02 Nov 2023 05:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qyUTx-000785-OV; Thu, 02 Nov 2023 05:59:21 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qyUTv-0008Hz-KG; Thu, 02 Nov 2023 05:59:21 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5401bab7525so1227622a12.2; 
 Thu, 02 Nov 2023 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698919157; x=1699523957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGB9pNtDuCkcqudpHSxApPG4Hxyl2dRueatHmhaU/tU=;
 b=f3qNCWQUgISe9Cwdzan4HBr4RJ33024hQQBQZytopAe0UT5ykMpxcZXsBN1rQo7Yvf
 9rt3gmOiwbaxoMgcyXlWqjJNkivJ6IOoqa3JI0ixmG8aQcplc1H7NfSPBjW5XNlwSyzD
 dtSpDIE1idctEG1u3tig/UKDkSyo0O46BdzOGWVB+ksds1e+mNagAfLVUUlyVlm2r75h
 ThZceiai/N0JjQZTbbvqMx2rXZUFoA/Ui4zjcNfWs4dCgRDezMqtVjc2nN+a92+CDsmS
 Ls9K0T5AKrIGAhPCKIVP9e53NErSHkMFMuDUyT6uvIGP3kEIFoGwXLr7KjdSurQCZR6f
 YCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698919157; x=1699523957;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGB9pNtDuCkcqudpHSxApPG4Hxyl2dRueatHmhaU/tU=;
 b=PS7YS78NlGn4lhqwFjRpSmFQno7EG1aWANjrIMtRjgUjPaEs0aw6cKsiZBT9Jiwm4q
 wB1Gpmwau0hCkI6ze2/PZB4s8p+uQMXMscK6xEad2BYIXHKwJCdLEecBvthSyzZznANS
 9JnA87RgxjrXfJjkxp5Ohz76oz7r0KCkvz1SyeyboXzmV/7sgIqYU1+wkzY6C3eTTtPs
 952tzyzPoPzRvcVC/HE9v/4vPqjO0BTWHN4C5ceICrWt4wG9+KJDfrJGnPcM4maoepHH
 C0tcMdZUALJimw3hpQGFKBGRh1tbBacAP5Fiji/4gsyA33gw/7Z2xJgpnnf/Wge93hjd
 Fydw==
X-Gm-Message-State: AOJu0YzbIFLFwkFv+v2zLXJKM34i67Y0YDLn60FWDcVapBLRZ9FWNYAI
 NyVWa8mxTWw+2+mWUwjva0U=
X-Google-Smtp-Source: AGHT+IHOlwY8NhkHc7X9bjOXWv9Vm56u/dVFG0JKbT8uaIjbS7CxjnJB8YqOdzjs0K9uogLkTjNJEQ==
X-Received: by 2002:a17:906:4fc8:b0:9be:ddad:61db with SMTP id
 i8-20020a1709064fc800b009beddad61dbmr3481845ejw.56.1698919157128; 
 Thu, 02 Nov 2023 02:59:17 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 b22-20020a1709062b5600b0099bd0b5a2bcsm922486ejg.101.2023.11.02.02.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 02:59:16 -0700 (PDT)
Date: Thu, 02 Nov 2023 09:05:30 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_6/6=5D_system/memory=3A_Trace_names?=
 =?US-ASCII?Q?_of_MemoryRegions_rather_than_host_pointers?=
In-Reply-To: <fd799a65-8dbd-4206-241b-6b9a300caf8c@linaro.org>
References: <20231028122415.14869-1-shentey@gmail.com>
 <20231028122415.14869-7-shentey@gmail.com>
 <fd799a65-8dbd-4206-241b-6b9a300caf8c@linaro.org>
Message-ID: <3125D7B5-AE22-42E7-817D-A961E96AE548@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



Am 30=2E Oktober 2023 03:36:44 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>Hi Bernhard,
>
>On 28/10/23 14:24, Bernhard Beschow wrote:
>> Tracing the host pointer of the accessed MemoryRegion seems to be a deb=
ug
>> feature for developing QEMU itself=2E When analyzing guest behavior by =
comparing
>> traces, these pointers generate a lot of noise since the pointers diffe=
r between
>> QEMU invocations, making this task harder than it needs to be=2E Moreov=
er, the
>> pointers seem to be redundant to the names already assigned to MemoryRe=
gions=2E
>
>I tried that few years ago but this got lost:
>https://lore=2Ekernel=2Eorg/qemu-devel/20210307074833=2E143106-1-f4bug@am=
sat=2Eorg/
>
>> Remove the pointers from the traces and trace the names where missing=
=2E When
>> developing QEMU, developers could just add the host pointer tracing for
>> themselves=2E
>
>But sometimes an object exposing a MR is instantiated multiple times,
>each time, and now you can not distinct which object is accessed=2E
>
>IIRC a suggestion was to cache the QOM parent path and display that,
>which should be constant to diff tracing logs=2E But then IIRC again the
>issue was the QOM path is resolved once the object is realized, which
>happens *after* we initialize the MR within the object=2E Maybe the
>solution is to add a memory_region_qom_pathname() getter and do lazy
>initialization?

Would logging the guest rather than the host address (in addition to the M=
R name) work?

Best regards,
Bernhard

>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   docs/devel/tracing=2Erst |  4 ++--
>>   system/memory=2Ec        | 26 ++++++++++++++++----------
>>   system/trace-events    | 12 ++++++------
>>   3 files changed, 24 insertions(+), 18 deletions(-)
>>=20
>> diff --git a/docs/devel/tracing=2Erst b/docs/devel/tracing=2Erst
>> index d288480db1=2E=2E8c31d5f76e 100644
>> --- a/docs/devel/tracing=2Erst
>> +++ b/docs/devel/tracing=2Erst
>> @@ -18,8 +18,8 @@ events::
>>         $ qemu --trace "memory_region_ops_*" =2E=2E=2E
>>       =2E=2E=2E
>> -    719585@1608130130=2E441188:memory_region_ops_read cpu 0 mr 0x562fd=
fbb3820 addr 0x3cc value 0x67 size 1
>> -    719585@1608130130=2E441190:memory_region_ops_write cpu 0 mr 0x562f=
dfbd2f00 addr 0x3d4 value 0x70e size 2
>> +    719585@1608130130=2E441188:memory_region_ops_read cpu 0 addr 0x3cc=
 value 0x67 size 1
>> +    719585@1608130130=2E441190:memory_region_ops_write cpu 0 addr 0x3d=
4 value 0x70e size 2
>
>Is this example missing the MR name?
>
>>     This output comes from the "log" trace backend that is enabled by d=
efault when
>>   ``=2E/configure --enable-trace-backends=3DBACKENDS`` was not explicit=
ly specified=2E
>> diff --git a/system/memory=2Ec b/system/memory=2Ec
>> index 4928f2525d=2E=2E076a992b74 100644
>> --- a/system/memory=2Ec
>> +++ b/system/memory=2Ec
>> @@ -444,10 +444,11 @@ static MemTxResult  memory_region_read_accessor(M=
emoryRegion *mr,
>>         tmp =3D mr->ops->read(mr->opaque, addr, size);
>>       if (mr->subpage) {
>> -        trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tm=
p, size);
>> +        trace_memory_region_subpage_read(get_cpu_index(), addr, tmp, s=
ize,
>> +                                         memory_region_name(mr));
>>       } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS=
_READ)) {
>>           hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>> -        trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tm=
p, size,
>> +        trace_memory_region_ops_read(get_cpu_index(), abs_addr, tmp, s=
ize,
>>                                        memory_region_name(mr));
>>       }
>>       memory_region_shift_read_access(value, shift, mask, tmp);
>> @@ -467,10 +468,11 @@ static MemTxResult memory_region_read_with_attrs_=
accessor(MemoryRegion *mr,
>>         r =3D mr->ops->read_with_attrs(mr->opaque, addr, &tmp, size, at=
trs);
>>       if (mr->subpage) {
>> -        trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tm=
p, size);
>> +        trace_memory_region_subpage_read(get_cpu_index(), addr, tmp, s=
ize,
>> +                                         memory_region_name(mr));
>>       } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS=
_READ)) {
>>           hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>> -        trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tm=
p, size,
>> +        trace_memory_region_ops_read(get_cpu_index(), abs_addr, tmp, s=
ize,
>>                                        memory_region_name(mr));
>>       }
>>       memory_region_shift_read_access(value, shift, mask, tmp);
>> @@ -488,10 +490,11 @@ static MemTxResult memory_region_write_accessor(M=
emoryRegion *mr,
>>       uint64_t tmp =3D memory_region_shift_write_access(value, shift, m=
ask);
>>         if (mr->subpage) {
>> -        trace_memory_region_subpage_write(get_cpu_index(), mr, addr, t=
mp, size);
>> +        trace_memory_region_subpage_write(get_cpu_index(), addr, tmp, =
size,
>> +                                          memory_region_name(mr));
>>       } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS=
_WRITE)) {
>>           hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>> -        trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, t=
mp, size,
>> +        trace_memory_region_ops_write(get_cpu_index(), abs_addr, tmp, =
size,
>>                                         memory_region_name(mr));
>>       }
>>       mr->ops->write(mr->opaque, addr, tmp, size);
>> @@ -509,10 +512,11 @@ static MemTxResult memory_region_write_with_attrs=
_accessor(MemoryRegion *mr,
>>       uint64_t tmp =3D memory_region_shift_write_access(value, shift, m=
ask);
>>         if (mr->subpage) {
>> -        trace_memory_region_subpage_write(get_cpu_index(), mr, addr, t=
mp, size);
>> +        trace_memory_region_subpage_write(get_cpu_index(), addr, tmp, =
size,
>> +                                          memory_region_name(mr));
>>       } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS=
_WRITE)) {
>>           hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>> -        trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, t=
mp, size,
>> +        trace_memory_region_ops_write(get_cpu_index(), abs_addr, tmp, =
size,
>>                                         memory_region_name(mr));
>>       }
>>       return mr->ops->write_with_attrs(mr->opaque, addr, tmp, size, att=
rs);
>> @@ -1356,7 +1360,8 @@ static uint64_t memory_region_ram_device_read(voi=
d *opaque,
>>           break;
>>       }
>>   -    trace_memory_region_ram_device_read(get_cpu_index(), mr, addr, d=
ata, size);
>> +    trace_memory_region_ram_device_read(get_cpu_index(), addr, data, s=
ize,
>> +                                        memory_region_name(mr));
>>         return data;
>>   }
>> @@ -1366,7 +1371,8 @@ static void memory_region_ram_device_write(void *=
opaque, hwaddr addr,
>>   {
>>       MemoryRegion *mr =3D opaque;
>>   -    trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, =
data, size);
>> +    trace_memory_region_ram_device_write(get_cpu_index(), addr, data, =
size,
>> +                                         memory_region_name(mr));
>>         switch (size) {
>>       case 1:
>> diff --git a/system/trace-events b/system/trace-events
>> index 69c9044151=2E=2E21f1c005e0 100644
>> --- a/system/trace-events
>> +++ b/system/trace-events
>> @@ -9,12 +9,12 @@ cpu_in(unsigned int addr, char size, unsigned int val=
) "addr 0x%x(%c) value %u"
>>   cpu_out(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c=
) value %u"
>>     # memory=2Ec
>> -memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_=
t value, unsigned size, const char *name) "cpu %d mr %p addr 0x%"PRIx64" va=
lue 0x%"PRIx64" size %u name '%s'"
>> -memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64=
_t value, unsigned size, const char *name) "cpu %d mr %p addr 0x%"PRIx64" v=
alue 0x%"PRIx64" size %u name '%s'"
>> -memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, u=
int64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PR=
Ix64" size %u"
>> -memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, =
uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"P=
RIx64" size %u"
>> -memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, =
uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRI=
x64" size %u"
>> -memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr,=
 uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PR=
Ix64" size %u"
>> +memory_region_ops_read(int cpu_index, uint64_t addr, uint64_t value, u=
nsigned size, const char *name) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" =
size %u name '%s'"
>> +memory_region_ops_write(int cpu_index, uint64_t addr, uint64_t value, =
unsigned size, const char *name) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64"=
 size %u name '%s'"
>> +memory_region_subpage_read(int cpu_index, uint64_t offset, uint64_t va=
lue, unsigned size, const char *name) "cpu %d offset 0x%"PRIx64" value 0x%"=
PRIx64" size %u name '%s'"
>> +memory_region_subpage_write(int cpu_index, uint64_t offset, uint64_t v=
alue, unsigned size, const char *name) "cpu %d offset 0x%"PRIx64" value 0x%=
"PRIx64" size %u name '%s'"
>> +memory_region_ram_device_read(int cpu_index, uint64_t addr, uint64_t v=
alue, unsigned size, const char *name) "cpu %d addr 0x%"PRIx64" value 0x%"P=
RIx64" size %u name '%s'"
>> +memory_region_ram_device_write(int cpu_index, uint64_t addr, uint64_t =
value, unsigned size, const char *name) "cpu %d addr 0x%"PRIx64" value 0x%"=
PRIx64" size %u name '%s'"
>>   memory_region_sync_dirty(const char *mr, const char *listener, int gl=
obal) "mr '%s' listener '%s' synced (global=3D%d)"
>>   flatview_new(void *view, void *root) "%p (root %p)"
>>   flatview_destroy(void *view, void *root) "%p (root %p)"
>

