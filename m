Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E04B1EE2C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Aug 2025 20:05:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukRRh-0005SR-4e; Fri, 08 Aug 2025 14:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukRRf-0005Py-S7
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:03:59 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukRRd-0008OS-ON
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:03:59 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b4233978326so1441506a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754676235; x=1755281035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GvYpd9MHwnk/+asHOjhm91VkqDH5RTJn0yCb30oeMns=;
 b=PGJ+o9HqEF2c/NuiNllAOjmw9PWW/fiOR+Aaoriad5yYFOpVIxsRgiiLBsiTREe2Mm
 pexSlLfABTTJ8DdYAWu4WUuvaEOBfyUZs3JM4R1HziVkwKBH5ghBCcJMMX401HSAxAKB
 CDdSIYPe9LbgkmLUbcwf5qHBsVHu8TtLR86/vpVnbvsFVOr1smhfpgvJIlVDNJ+myHGa
 TRngj6iJP4E3gy30crlmL3JQS2mi0sqCzvhQkqq7n5+ZY4WLgscJc2brYm0vPmlkd2z1
 b4Tu6qm263vb+lqD+qQtqk/BGeB+tWrYPAm0VbiNspaFiwbM0rWnav1pEtXyCJxGr/9D
 kShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754676235; x=1755281035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GvYpd9MHwnk/+asHOjhm91VkqDH5RTJn0yCb30oeMns=;
 b=CytPY39NApV3fEAXujnmliyG9/cksxTKsr9wgxZCS6vSHVnyUQh2WTu3kjwWhoWoSQ
 KefB3RFj29Jd0B7B4732ZCjRW9qfCtEUhVQUkFrYoHPQ8DiujHx0oSRz2fPWdlzk0beU
 SVrB33nfkzY2/YSqgLX9dYuNSWm5yD2+nTJGd0sxihrVGDvuMZZzz1sNhZrMEfiLTMYI
 1/9v739JECH3K8sAvVdpjG4QGuKttKJvi4WDbPI2hCrrJwJyWoLZtdVqXOJlhc/howXW
 ZNhl3MayWs261H32nK7hJkeMD7BeF4cf+/w6bW6HjFhYPZlfxdx5Y04f0smUgKL6rOde
 yCjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuAaCAPvb54B9V9LF3wi+RXRpNvLfO6iuUAgNfPhjTH+8irDQfseddqPvnhrMJL25FNuA+o6UnHtt7@nongnu.org
X-Gm-Message-State: AOJu0YykqNu4MJx5vCyCCca3D25XyefClF9vKP+SS4Gpb/Twhcmryyx+
 4pF4cx3oobwII4PrliA99crjmA5YjRH6mENneT8TNgGLucq0qjDDp98pDzug0UTL+/o=
X-Gm-Gg: ASbGncu0IfVJUWm/OmLu4KD7hE25LvOlXLjrv2OYaNr0TTIeAHu5Mu59QyBKcFtE/76
 nbA444D06rCSHBr3xQWZypc899QcDuM4HBcGasIA4NzbQFRDzOXw2aiNYa5rlUJjBIefV3/49L3
 42fHwuPPdKB5HMl3a6dKagP8s/blGbyg/QYIBmcpvT+eFzPRh3bS2OQCFqj9aLuBiaH+6XGGk5I
 nX3eBiYHkb6+ekGXdvxuSBXcvzxN7v+79Hg39qitVFrwt3mUz6dzw/h3vuB719kWt2aVhkGfDPf
 LZ3tP4bydJfYQ1x3wiuZ6x8+9VspN2aQ+tNuWRzBwI7NAtnpHBz2M+36yAgak5uVKfXIvTqBk9R
 uE4ZpfX/RfySc3IT3JRF5LSiV+x8Y5Wz+daA=
X-Google-Smtp-Source: AGHT+IH4v5wp7Ki50vSTmV5a1+slCQhsuxo3EbejRDw9CbjBaN2lbgtYxjiCBf8QdC8X0mJBcIaLbw==
X-Received: by 2002:a17:903:124b:b0:240:3b9e:dd65 with SMTP id
 d9443c01a7336-242c223c78emr53026305ad.38.1754676235240; 
 Fri, 08 Aug 2025 11:03:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef671fsm216652105ad.9.2025.08.08.11.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 11:03:54 -0700 (PDT)
Message-ID: <401440fc-c25b-4abc-94d2-4b21593c6eac@linaro.org>
Date: Fri, 8 Aug 2025 11:03:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] contrib/plugins/uftrace: implement tracing
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, =?UTF-8?Q?Alex_Benn_=C3=A9_e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-5-pierrick.bouvier@linaro.org>
 <t0o4ts.nym46t847yx5@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <t0o4ts.nym46t847yx5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 8/8/25 2:11 AM, Manos Pitsidianakis wrote:
> On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>> We implement tracing, following uftrace format.
>> Trace is flushed every 32 MB, so file operations don't impact
>> performance at runtime.
>>
>> A different trace is generated per cpu, and we ensure they have a unique
>> name, based on vcpu_index, while keeping room for privilege level coming
>> in next commit.
> 
> Suggestion (not a request): put some kind of documentation about the
> format this patch implements, maybe a commit sha & URL to a header file
> from upstream uftrace.
> 
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> contrib/plugins/uftrace.c | 149 +++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 148 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>> index d51faceb344..402a242433e 100644
>> --- a/contrib/plugins/uftrace.c
>> +++ b/contrib/plugins/uftrace.c
>> @@ -12,6 +12,13 @@
>> #include <qemu-plugin.h>
>> #include <glib.h>
>> #include <stdio.h>
>> +#include <sys/stat.h>
>> +#include <sys/time.h>
>> +#include <time.h>
>> +#include <unistd.h>
>> +
>> +#define MiB     (INT64_C(1) << 20)
>> +#define NANOSECONDS_PER_SECOND 1000000000LL
>>
>> QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>>
>> @@ -24,6 +31,13 @@ typedef struct {
>>      uint64_t frame_pointer;
>> } CallstackEntry;
>>
>> +typedef struct {
>> +    GArray *t;
>> +    GString *path;
>> +    GString *name;
>> +    uint32_t id;
>> +} Trace;
>> +
>> typedef struct Cpu Cpu;
>>
>> typedef struct {
>> @@ -34,6 +48,7 @@ typedef struct {
>> } CpuOps;
>>
>> typedef struct Cpu {
>> +    Trace *trace;
>>      Callstack *cs;
>>      GByteArray *buf;
>>      CpuOps ops;
>> @@ -44,9 +59,41 @@ typedef struct {
>>      struct qemu_plugin_register *reg_fp;
>> } Aarch64Cpu;
>>
>> +typedef struct {
>> +    uint64_t timestamp;
>> +    uint64_t data;
>> +} UftraceEntry;
>> +
>> +typedef enum {
>> +    UFTRACE_ENTRY,
>> +    UFTRACE_EXIT,
>> +    UFTRACE_LOST,
>> +    UFTRACE_EVENT
>> +} UftraceRecordType;
>> +
>> static struct qemu_plugin_scoreboard *score;
>> static CpuOps arch_ops;
>>
>> +static uint64_t gettime_ns(void)
>> +{
>> +#ifdef _WIN32
>> +    /*
>> +     * On Windows, timespec_get is available only with UCRT, but not with
>> +     * MinGW64 environment. Simplify by using only gettimeofday on this
>> +     * platform. This may result in a precision loss.
>> +     */
>> +    struct timeval tv;
>> +    gettimeofday(&tv, NULL);
>> +    uint64_t now_ns = tv.tv_sec * NANOSECONDS_PER_SECOND + tv.tv_usec * 1000;
>> +#else
>> +    /* We need nanosecond precision for short lived functions. */
>> +    struct timespec ts;
>> +    timespec_get(&ts, TIME_UTC);
>> +    uint64_t now_ns = ts.tv_sec * NANOSECONDS_PER_SECOND + ts.tv_nsec;
>> +#endif
>> +    return now_ns;
>> +}
>> +
>> static Callstack *callstack_new(void)
>> {
>>      Callstack *cs = g_new0(Callstack, 1);
>> @@ -112,6 +159,85 @@ static CallstackEntry callstack_pop(Callstack *cs)
>>      return e;
>> }
>>
>> +static Trace *trace_new(uint32_t id, GString *name)
>> +{
>> +    Trace *t = g_new0(Trace, 1);
>> +    t->t = g_array_new(false, false, sizeof(UftraceEntry));
>> +    t->path = g_string_new(NULL);
>> +    g_string_append_printf(t->path, "./uftrace.data/%"PRIu32".dat", id);
>> +    t->name = g_string_new(name->str);
>> +    t->id = id;
>> +    return t;
>> +}
>> +
>> +static void trace_free(Trace *t)
>> +{
>> +    g_assert(t->t->len == 0);
>> +    g_array_free(t->t, true);
>> +    t->t = NULL;
>> +    g_string_free(t->path, true);
>> +    t->path = NULL;
>> +    g_string_free(t->name, true);
>> +    t->name = NULL;
>> +    g_free(t);
>> +}
>> +
>> +static void trace_flush(Trace *t, bool append)
>> +{
>> +    int create_dir = g_mkdir_with_parents("./uftrace.data",
>> +                                          S_IRWXU | S_IRWXG | S_IRWXO);
>> +    g_assert(create_dir == 0);
>> +    FILE *dat = fopen(t->path->str, append ? "a" : "w");
>> +    g_assert(dat);
>> +    GArray *data = t->t;
>> +    if (data->len) {
>> +        fwrite(data->data, data->len, sizeof(UftraceEntry), dat);
> 
> fwrite might not write all bytes, how about using the
> g_file_set_contents() wrapper?
>

If I see correctly, g_file_set_contents does not allow to append data, 
which is what we need to do here (that's the point of flushing every 
32MB). I can add an assert on fwrite return to make sure we wrote 
everything.

>> +    }
>> +    fclose(dat);
>> +    g_array_set_size(data, 0);
>> +}
>> +
>> +static void trace_add_entry(Trace *t, uint64_t timestamp, uint64_t pc,
>> +                            size_t depth, UftraceRecordType type)
>> +{
>> +    /* libmcount/record.c:record_event */
>> +    const uint64_t record_magic = 0x5;
>> +    uint64_t data = type | record_magic << 3;
>> +    data += depth << 6;
>> +    data += pc << 16;
>> +    UftraceEntry e = {.timestamp = timestamp, .data = data};
>> +    g_array_append_val(t->t, e);
>> +    if (t->t->len * sizeof(UftraceEntry) > 32 * MiB) {
>> +        trace_flush(t, true);
>> +    }
>> +}
>> +
>> +static void trace_enter_function(Trace *t, uint64_t timestamp,
>> +                                 uint64_t pc, size_t depth)
>> +{
>> +    trace_add_entry(t, timestamp, pc, depth, UFTRACE_ENTRY);
>> +}
>> +
>> +static void trace_exit_function(Trace *t, uint64_t timestamp,
>> +                                uint64_t pc, size_t depth)
>> +{
>> +    trace_add_entry(t, timestamp, pc, depth, UFTRACE_EXIT);
>> +}
>> +
>> +static void trace_enter_stack(Trace *t, Callstack *cs, uint64_t timestamp)
>> +{
>> +    for (size_t depth = 1; depth <= callstack_depth(cs); ++depth) {
>> +        trace_enter_function(t, timestamp, callstack_at(cs, depth)->pc, depth);
>> +    }
>> +}
>> +
>> +static void trace_exit_stack(Trace *t, Callstack *cs, uint64_t timestamp)
>> +{
>> +    for (size_t depth = callstack_depth(cs); depth > 0; --depth) {
>> +        trace_exit_function(t, timestamp, callstack_at(cs, depth)->pc, depth);
>> +    }
>> +}
>> +
>> static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
>> {
>>      GByteArray *buf = cpu->buf;
>> @@ -223,7 +349,9 @@ static void track_callstack(unsigned int cpu_index, void *udata)
>> {
>>      uint64_t pc = (uintptr_t) udata;
>>      Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
>> +    uint64_t timestamp = gettime_ns();
>>      Callstack *cs = cpu->cs;
>> +    Trace *t = cpu->trace;
>>
>>      uint64_t fp = cpu->ops.get_frame_pointer(cpu);
>>      if (!fp && callstack_empty(cs)) {
>> @@ -232,6 +360,7 @@ static void track_callstack(unsigned int cpu_index, void *udata)
>>           * long as a proper call does not happen.
>>           */
>>          callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
>> +        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
>>          return;
>>      }
>>
>> @@ -244,7 +373,8 @@ static void track_callstack(unsigned int cpu_index, void *udata)
>>      CallstackEntry caller = callstack_caller(cs);
>>      if (fp == caller.frame_pointer) {
>>          /* return */
>> -        callstack_pop(cs);
>> +        CallstackEntry e = callstack_pop(cs);
>> +        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs));
>>          return;
>>      }
>>
>> @@ -252,12 +382,16 @@ static void track_callstack(unsigned int cpu_index, void *udata)
>>      if (caller_fp == top.frame_pointer) {
>>          /* call */
>>          callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
>> +        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
>>          return;
>>      }
>>
>>      /* discontinuity, exit current stack and unwind new one */
>> +    trace_exit_stack(t, cs, timestamp);
>>      callstack_clear(cs);
>> +
>>      cpu_unwind_stack(cpu, fp, pc);
>> +    trace_enter_stack(t, cs, timestamp);
>> }
>>
>> static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>> @@ -296,6 +430,16 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>>      cpu->ops.init(cpu);
>>      cpu->buf = g_byte_array_new();
>>
>> +    g_assert(vcpu_index < UINT32_MAX / 100);
>> +    /* trace_id is: cpu_number * 100 */
>> +    uint32_t trace_id = (vcpu_index + 1) * 100;
>> +
>> +    g_autoptr(GString) trace_name = g_string_new(NULL);
>> +    g_string_append_printf(trace_name, "cpu%u", vcpu_index);
>> +    cpu->trace = trace_new(trace_id, trace_name);
>> +    /* create/truncate trace file */
>> +    trace_flush(cpu->trace, false);
>> +
>>      cpu->cs = callstack_new();
>> }
>>
>> @@ -304,6 +448,7 @@ static void vcpu_end(unsigned int vcpu_index)
>>      Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>>      g_byte_array_free(cpu->buf, true);
>>
>> +    trace_free(cpu->trace);
>>      callstack_free(cpu->cs);
>>      memset(cpu, 0, sizeof(Cpu));
>> }
>> @@ -311,6 +456,8 @@ static void vcpu_end(unsigned int vcpu_index)
>> static void at_exit(qemu_plugin_id_t id, void *data)
>> {
>>      for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
>> +        Cpu *cpu = qemu_plugin_scoreboard_find(score, i);
>> +        trace_flush(cpu->trace, true);
>>          vcpu_end(i);
>>      }
>>
>> -- 
>> 2.47.2
>>
> 
> Looks good overall.


