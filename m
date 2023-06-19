Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C567735D95
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 20:53:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBJxn-0002Tl-FO; Mon, 19 Jun 2023 14:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBJxk-0002TA-LL
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 14:50:52 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBJxh-0001zS-FZ
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 14:50:52 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-311275efaf8so2480970f8f.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 11:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687200647; x=1689792647;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNqWrtUV0GXJy04gneesdLWAsrQYDrB019QL7f+8cBc=;
 b=oriCJcOF5anspWxUTRKIzb+j9qHG3C2zSQiQOJC5IKrTkbCaZ77kGbbzH+TiuYP7+h
 Bjp9DzuHbBLbLK0ZLowALrdeyG7jOUcrgGuEAw4x7vGpKW40g0NVsrKmVIzAQoMOXsPy
 zrvnFVXIozsjHHKqn4AgL4XAL3fu1ygd9qXZQNy3Y1f6Yhmjn5wsUULQY3DhxX0WFQKc
 NhP2BmcThJEbP8jKt/FDyKWq3MfxcJlS2e2CttKmT14Z9iENs7Sx+DTagB0n1wwmCNW+
 /pj6OSDTDShCsCG307HIK4VS6y2DLUZPHkRtO4AVoBlmlfzylYT2jV94ZCdtvXqWAWBv
 L8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687200647; x=1689792647;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KNqWrtUV0GXJy04gneesdLWAsrQYDrB019QL7f+8cBc=;
 b=FD30lAgDYopzpQADpUo0OTTB1s0YPWS+pmAWJrUg9S3d+vMgxcCoRvzuQ5gOyP8OPs
 wHS9SOQalH+UF8ubctSXrGngOP0uWO02fqQlUmuAcFx9JsMigG/TMrPrbC4zEUgXS5NS
 S0sa6JMX35apF3zUvdImz9JT8oMN4zARimzR7uEjsxarCors6kWuEbtukctFMmygy2Zl
 6GpaIzlFvxbwxRKNqmVGbAWVaud1915LG5qv4dQZfArqql8UxQKDlntMJGuykvbiioTj
 CohQ28rKXPz8namrYavBcRHIjKWvFLJ3t2KJpQfFchASRtR2bylI19MkAuh92/v8DIC+
 5gVw==
X-Gm-Message-State: AC+VfDxr+TjvK7GZeZPZQEXXqAFsB316PPAtKRTYM3uZpHd/nj7eAuWP
 pMdMIcCCgvvmAdf6KEIF65YcdA==
X-Google-Smtp-Source: ACHHUZ6C/VkpQ0YmPdlOy3np91iSA3qhbbWPHhKCtd2BiUJz3Sd0PUwAMDIVY/OPt6ST6gHVPLeX2w==
X-Received: by 2002:adf:f607:0:b0:30e:4c8d:c6c with SMTP id
 t7-20020adff607000000b0030e4c8d0c6cmr6894547wrp.55.1687200647238; 
 Mon, 19 Jun 2023 11:50:47 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p1-20020adfcc81000000b0030ada01ca78sm252540wrj.10.2023.06.19.11.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 11:50:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 483901FFBB;
 Mon, 19 Jun 2023 19:50:46 +0100 (BST)
References: <20230419161226.1012884-1-alex.bennee@linaro.org>
 <0ed8aacf-9fbc-5f67-153c-f052eabc7fa6@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Robert Henry <robhenry@microsoft.com>, Aaron
 Lindsay <aaron@os.amperecomputing.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, "open
 list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [RFC PATCH] plugins: force slow path when plugins instrument
 memory ops
Date: Mon, 19 Jun 2023 19:49:59 +0100
In-reply-to: <0ed8aacf-9fbc-5f67-153c-f052eabc7fa6@linaro.org>
Message-ID: <87edm7jng9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Richard Henderson <richard.henderson@linaro.org> writes:

> On 4/19/23 17:12, Alex Benn=C3=A9e wrote:
>> The lack of SVE memory instrumentation has been an omission in plugin
>> handling since it was introduced. Fortunately we can utilise the
>> probe_* functions to force all all memory access to follow the slow
>> path. We do this by checking the access type and presence of plugin
>> memory callbacks and if set return the TLB_MMIO flag.
>> We have to jump through a few hoops in user mode to re-use the flag
>> but it was the desired effect:
>>   ./qemu-system-aarch64 -display none -serial mon:stdio \
>>     -M virt -cpu max -semihosting-config enable=3Don \
>>     -kernel ./tests/tcg/aarch64-softmmu/memory-sve \
>>     -plugin ./contrib/plugins/libexeclog.so,ifilter=3Dst1w,afilter=3D0x4=
0001808 -d plugin
>> gives (disas doesn't currently understand st1w):
>>    0, 0x40001808, 0xe54342a0, ".byte 0xa0, 0x42, 0x43, 0xe5", store,
>> 0x40213010, RAM, store, 0x40213014, RAM, store, 0x40213018, RAM
>> And for user-mode:
>>    ./qemu-aarch64 \
>>      -plugin contrib/plugins/libexeclog.so,afilter=3D0x4007c0 \
>>      -d plugin \
>>      ./tests/tcg/aarch64-linux-user/sha512-sve
>> gives:
>>    1..10
>>    ok 1 - do_test(&tests[i])
>>    0, 0x4007c0, 0xa4004b80, ".byte 0x80, 0x4b, 0x00, 0xa4", load, 0x5500=
800370, load, 0x5500800371, load, 0x5500800372, load, 0x5500800373, load, 0=
x5500800374, load, 0x5500800375, load, 0x5500800376, load, 0x5500800377, lo=
ad, 0x5500800378, load, 0x5500800379, load, 0x550080037a, load, 0x550080037=
b, load, 0x550080037c, load, 0x550080037d, load, 0x550080037e, load, 0x5500=
80037f, load, 0x5500800380, load, 0x5500800381, load, 0x5500800382, load, 0=
x5500800383, load, 0x5500800384, load, 0x5500800385, load, 0x5500800386, lo
>>    ad, 0x5500800387, load, 0x5500800388, load, 0x5500800389, load, 0x550=
080038a, load, 0x550080038b, load, 0x550080038c, load, 0x550080038d, load, =
0x550080038e, load, 0x550080038f, load, 0x5500800390, load, 0x5500800391, l=
oad, 0x5500800392, load, 0x5500800393, load, 0x5500800394, load, 0x55008003=
95, load, 0x5500800396, load, 0x5500800397, load, 0x5500800398, load, 0x550=
0800399, load, 0x550080039a, load, 0x550080039b, load, 0x550080039c, load, =
0x550080039d, load, 0x550080039e, load, 0x550080039f, load, 0x55008003a0, l=
oad, 0x55008003a1, load, 0x55008003a2, load, 0x55008003a3, load, 0x55008003=
a4, load, 0x55008003a5, load, 0x55008003a6, load, 0x55008003a7, load, 0x550=
08003a8, load, 0x55008003a9, load, 0x55008003aa, load, 0x55008003ab, load, =
0x55008003ac, load, 0x55008003ad, load, 0x55008003ae, load, 0x55008003af
>> (4007c0 is the ld1b in the sha512-sve)
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Robert Henry <robhenry@microsoft.com>
>> Cc: Aaron Lindsay <aaron@os.amperecomputing.com>
>> ---
>>   include/exec/cpu-all.h            |  2 +-
>>   include/hw/core/cpu.h             | 17 +++++++++++++++++
>>   accel/tcg/cputlb.c                |  6 +++++-
>>   accel/tcg/user-exec.c             |  6 +++++-
>>   target/arm/tcg/sve_helper.c       |  4 ----
>>   tests/tcg/aarch64/Makefile.target |  8 ++++++++
>>   6 files changed, 36 insertions(+), 7 deletions(-)
>
> Looks good, mostly.
>
>> @@ -1530,6 +1530,7 @@ static int probe_access_internal(CPUArchState *env=
, target_ulong addr,
>>       target_ulong tlb_addr, page_addr;
>>       size_t elt_ofs;
>>       int flags;
>> +    bool not_fetch =3D true;
>>         switch (access_type) {
>>       case MMU_DATA_LOAD:
>> @@ -1540,6 +1541,7 @@ static int probe_access_internal(CPUArchState *env=
, target_ulong addr,
>>           break;
>>       case MMU_INST_FETCH:
>>           elt_ofs =3D offsetof(CPUTLBEntry, addr_code);
>> +        not_fetch =3D false;
>>           break;
>>       default:
>>           g_assert_not_reached();
>> @@ -1578,7 +1580,9 @@ static int probe_access_internal(CPUArchState *env=
, target_ulong addr,
>>       *pfull =3D &env_tlb(env)->d[mmu_idx].fulltlb[index];
>>         /* Fold all "mmio-like" bits into TLB_MMIO.  This is not
>> RAM.  */
>> -    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY))) {
>> +    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY))
>> +        ||
>> +        (not_fetch && cpu_plugin_mem_cbs_enabled(env_cpu(env)))) {
>
> Rather than introduce a new variable, just test access_type !=3D
> MMU_INST_FETCH.

w.r.t to not instrumenting the TLB accesses how ugly would something
like this be:

--8<---------------cut here---------------start------------->8---
modified   include/hw/core/cpu.h
@@ -80,10 +80,24 @@ DECLARE_CLASS_CHECKERS(CPUClass, CPU,
     typedef struct ArchCPU CpuInstanceType; \
     OBJECT_DECLARE_TYPE(ArchCPU, CpuClassType, CPU_MODULE_OBJ_NAME);
=20
+/**
+ * typedef MMUAccessType - describe the type of access for cputlb
+ *
+ * When handling the access to memory we need to know the type of
+ * access we are doing. Loads and store rely on read and write page
+ * permissions where as the instruction fetch relies on execute
+ * permissions. Additional bits are used for TLB access so we can
+ * suppress instrumentation of memory when the CPU is probing.
+ */
 typedef enum MMUAccessType {
     MMU_DATA_LOAD  =3D 0,
     MMU_DATA_STORE =3D 1,
-    MMU_INST_FETCH =3D 2
+    MMU_INST_FETCH =3D 2,
+    /* MMU Mask */
+    MMU_VALID_MASK =3D (MMU_DATA_LOAD | MMU_DATA_STORE | MMU_INST_FETCH),
+    /* Represents the CPU walking the page table */
+    MMU_TLB_ACCESS =3D 0x4,
+    MMU_TLB_LOAD =3D MMU_DATA_LOAD | MMU_TLB_ACCESS
 } MMUAccessType;
=20
 typedef struct CPUWatchpoint CPUWatchpoint;
modified   accel/tcg/cputlb.c
@@ -1503,11 +1503,12 @@ static void notdirty_write(CPUState *cpu, vaddr mem=
_vaddr, unsigned size,
 }
=20
 static int probe_access_internal(CPUArchState *env, target_ulong addr,
-                                 int fault_size, MMUAccessType access_type,
+                                 int fault_size, MMUAccessType full_access=
_type,
                                  int mmu_idx, bool nonfault,
                                  void **phost, CPUTLBEntryFull **pfull,
                                  uintptr_t retaddr)
 {
+    MMUAccessType access_type =3D full_access_type & MMU_VALID_MASK;
     uintptr_t index =3D tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
     target_ulong tlb_addr =3D tlb_read_idx(entry, access_type);
@@ -1546,7 +1547,9 @@ static int probe_access_internal(CPUArchState *env, t=
arget_ulong addr,
     /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
     if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY))
         ||
-        (access_type !=3D MMU_INST_FETCH && cpu_plugin_mem_cbs_enabled(env=
_cpu(env)))) {
+        (access_type !=3D MMU_INST_FETCH &&
+         !(full_access_type & MMU_TLB_ACCESS) &&
+         cpu_plugin_mem_cbs_enabled(env_cpu(env)))) {
         *phost =3D NULL;
         return TLB_MMIO;
     }
--8<---------------cut here---------------end--------------->8---

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

