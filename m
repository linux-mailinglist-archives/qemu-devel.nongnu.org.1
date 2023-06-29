Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA8A742539
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 14:01:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEqKp-0001Hx-6W; Thu, 29 Jun 2023 08:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEqKU-0001FA-69
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:00:57 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEqKR-0004cN-3V
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:00:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc1218262so1729475e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688040046; x=1690632046;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmN0mOPrSrIqLPdkrcWJq7RQCZ1nY5zZSDkZNTPJKbY=;
 b=kznQ11ejtOMd9SSkEDfSFdOIKgAyWfh5du80PX9+7OggZUu34lbSTRa8JAJNWIBeoR
 Fbd2Cchjp9oyNxcLaPiLDN4f3Ww0d9cMsr13t4/pYqo6Wu82L7mspSlfjFBijfoy9yiu
 rlPnBiKkps47VyxHj3NQnT9DhMli3cPA+wXoHiPHsuMBQdRTvCwmP3Ut9IDsXnbrHwvW
 33ead1GFumC9FmIqu3UYHGVncYRSnWjYt8dUDSFBHP2YN5eHqlToarCjD3Uu0RHcFLqv
 YMybYg1PDIhhmqf2EVDC0UnZ6spKJwJwjNTt2+eb3D54qv+F11IS642Bsa/YfCJno95e
 6R7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688040046; x=1690632046;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GmN0mOPrSrIqLPdkrcWJq7RQCZ1nY5zZSDkZNTPJKbY=;
 b=hPtlr2A4bO57zCMGiCBIEbBOqDOfiwgXfUVoa+MttJGC2vEBAKjmRf3lDSb2wPTAc3
 at4HztHzhiPRKWKYuh75zg7Zhctij9z1ZbOFh3AGjMAL7BO2DQDFUlEk8xmJrjTLnn69
 Wlx2y+boiSbr5RasiYmAZ6BLj4SEiEYnLx/ExAvIETMvq55zqYJpJRdIYAiXy5Ht5xtw
 FB0WEq4SWj6IJStE74YiLSOPiGnrvnwhUtGfDLe5EkGgap4i2N9C8JScaPXoBgRQJd9R
 kRrCO1F7G796Qtlnyqe34y4kvPnsn2rd9d111RPu/g/o2DToXYgJhMXMoIPrrEk0YFyu
 HXaw==
X-Gm-Message-State: AC+VfDxvGmE8eaNPDeLirfMyO23Lary2cxd5C+efHiAoCkO293Yfkf0R
 Os0elCJcLIH9W9fwpPLkgk+1KX42Lp/RZXk4Uag=
X-Google-Smtp-Source: ACHHUZ60M7E4PjJx8WUZ3va2fqYPO8zVG0iW8943E3stSHTSPL5zCsD7FF1fJqrXg3+ZPEiENC05pA==
X-Received: by 2002:a1c:4c16:0:b0:3fb:b637:22a7 with SMTP id
 z22-20020a1c4c16000000b003fbb63722a7mr1674666wmf.4.1688040046407; 
 Thu, 29 Jun 2023 05:00:46 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a056000104100b0031402a910edsm6398780wrx.86.2023.06.29.05.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 05:00:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 37BC91FFBB;
 Thu, 29 Jun 2023 13:00:45 +0100 (BST)
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
 <20230627160943.2956928-18-alex.bennee@linaro.org>
 <832d49b4-4d53-729e-c8aa-004a71bdf99f@linaro.org>
 <878rc4ymw3.fsf@linaro.org>
 <78c9de7e-b2ca-fc2c-67e1-b06908de01cc@linaro.org>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 17/36] plugins: force slow path when plugins
 instrument memory ops
Date: Thu, 29 Jun 2023 12:59:50 +0100
In-reply-to: <78c9de7e-b2ca-fc2c-67e1-b06908de01cc@linaro.org>
Message-ID: <87sfaaxytu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

> On 6/28/23 11:06, Alex Benn=C3=A9e wrote:
>>> I thought we dropped this patch until we could do something with TLB
>>> accesses.
>> I did suggest something like:
>> --8<---------------cut here---------------start------------->8---
>> modified   include/hw/core/cpu.h
>> @@ -80,10 +80,24 @@ DECLARE_CLASS_CHECKERS(CPUClass, CPU,
>>       typedef struct ArchCPU CpuInstanceType; \
>>       OBJECT_DECLARE_TYPE(ArchCPU, CpuClassType, CPU_MODULE_OBJ_NAME);
>>   +/**
>> + * typedef MMUAccessType - describe the type of access for cputlb
>> + *
>> + * When handling the access to memory we need to know the type of
>> + * access we are doing. Loads and store rely on read and write page
>> + * permissions where as the instruction fetch relies on execute
>> + * permissions. Additional bits are used for TLB access so we can
>> + * suppress instrumentation of memory when the CPU is probing.
>> + */
>>   typedef enum MMUAccessType {
>>       MMU_DATA_LOAD  =3D 0,
>>       MMU_DATA_STORE =3D 1,
>> -    MMU_INST_FETCH =3D 2
>> +    MMU_INST_FETCH =3D 2,
>> +    /* MMU Mask */
>> +    MMU_VALID_MASK =3D (MMU_DATA_LOAD | MMU_DATA_STORE | MMU_INST_FETCH=
),
>> +    /* Represents the CPU walking the page table */
>> +    MMU_TLB_ACCESS =3D 0x4,
>> +    MMU_TLB_LOAD =3D MMU_DATA_LOAD | MMU_TLB_ACCESS
>>   } MMUAccessType;
>>     typedef struct CPUWatchpoint CPUWatchpoint;
>> modified   accel/tcg/cputlb.c
>> @@ -1503,11 +1503,12 @@ static void notdirty_write(CPUState *cpu, vaddr =
mem_vaddr, unsigned size,
>>   }
>>     static int probe_access_internal(CPUArchState *env, target_ulong
>> addr,
>> -                                 int fault_size, MMUAccessType access_t=
ype,
>> +                                 int fault_size, MMUAccessType full_acc=
ess_type,
>>                                    int mmu_idx, bool nonfault,
>>                                    void **phost, CPUTLBEntryFull **pfull,
>>                                    uintptr_t retaddr)
>>   {
>> +    MMUAccessType access_type =3D full_access_type & MMU_VALID_MASK;
>>       uintptr_t index =3D tlb_index(env, mmu_idx, addr);
>>       CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
>>       target_ulong tlb_addr =3D tlb_read_idx(entry, access_type);
>> @@ -1546,7 +1547,9 @@ static int probe_access_internal(CPUArchState *env=
, target_ulong addr,
>>       /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
>>       if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY))
>>           ||
>> -        (access_type !=3D MMU_INST_FETCH && cpu_plugin_mem_cbs_enabled(=
env_cpu(env)))) {
>> +        (access_type !=3D MMU_INST_FETCH &&
>> +         !(full_access_type & MMU_TLB_ACCESS) &&
>> +         cpu_plugin_mem_cbs_enabled(env_cpu(env)))) {
>>           *phost =3D NULL;
>>           return TLB_MMIO;
>>       }
>> --8<---------------cut here---------------end--------------->8---
>> and then we can apply MMU_TLB_LOAD as the type in the page walking
>> code.
>> I wanted to know if that was the sort of thing you where thinking off or
>> if that is too ugly.
>
> It's not implausible, but probably not ideal.
>
>> The other option is a specific probe_access_* function for TLB type
>> operations.
>
> Or that, yes.
>
> I'm confused that you'd simply re-include this patch as-is when it has
> known errors.

I was hoping for some testing from the people that reported the fault.
Anyway this is what I have now:

--8<---------------cut here---------------start------------->8---
plugins: force slow path when plugins instrument memory ops

The lack of SVE memory instrumentation has been an omission in plugin
handling since it was introduced. Fortunately we can utilise the
probe_* functions to force all all memory access to follow the slow
path. We do this by checking the access type and presence of plugin
memory callbacks and if set return the TLB_MMIO flag.

We have to jump through a few hoops in user mode to re-use the flag
but it was the desired effect:

 ./qemu-system-aarch64 -display none -serial mon:stdio \
   -M virt -cpu max -semihosting-config enable=3Don \
   -kernel ./tests/tcg/aarch64-softmmu/memory-sve \
   -plugin ./contrib/plugins/libexeclog.so,ifilter=3Dst1w,afilter=3D0x40001=
808 -d plugin

gives (disas doesn't currently understand st1w):

  0, 0x40001808, 0xe54342a0, ".byte 0xa0, 0x42, 0x43, 0xe5", store, 0x40213=
010, RAM, store, 0x40213014, RAM, store, 0x40213018, RAM

And for user-mode:

  ./qemu-aarch64 \
    -plugin contrib/plugins/libexeclog.so,afilter=3D0x4007c0 \
    -d plugin \
    ./tests/tcg/aarch64-linux-user/sha512-sve

gives:

  1..10
  ok 1 - do_test(&tests[i])
  0, 0x4007c0, 0xa4004b80, ".byte 0x80, 0x4b, 0x00, 0xa4", load, 0x55008003=
70, load, 0x5500800371, load, 0x5500800372, load, 0x5500800373, load, 0x550=
0800374, load, 0x5500800375, load, 0x5500800376, load, 0x5500800377, load, =
0x5500800378, load, 0x5500800379, load, 0x550080037a, load, 0x550080037b, l=
oad, 0x550080037c, load, 0x550080037d, load, 0x550080037e, load, 0x55008003=
7f, load, 0x5500800380, load, 0x5500800381, load, 0x5500800382, load, 0x550=
0800383, load, 0x5500800384, load, 0x5500800385, load, 0x5500800386, lo
  ad, 0x5500800387, load, 0x5500800388, load, 0x5500800389, load, 0x5500800=
38a, load, 0x550080038b, load, 0x550080038c, load, 0x550080038d, load, 0x55=
0080038e, load, 0x550080038f, load, 0x5500800390, load, 0x5500800391, load,=
 0x5500800392, load, 0x5500800393, load, 0x5500800394, load, 0x5500800395, =
load, 0x5500800396, load, 0x5500800397, load, 0x5500800398, load, 0x5500800=
399, load, 0x550080039a, load, 0x550080039b, load, 0x550080039c, load, 0x55=
0080039d, load, 0x550080039e, load, 0x550080039f, load, 0x55008003a0, load,=
 0x55008003a1, load, 0x55008003a2, load, 0x55008003a3, load, 0x55008003a4, =
load, 0x55008003a5, load, 0x55008003a6, load, 0x55008003a7, load, 0x5500800=
3a8, load, 0x55008003a9, load, 0x55008003aa, load, 0x55008003ab, load, 0x55=
008003ac, load, 0x55008003ad, load, 0x55008003ae, load, 0x55008003af

(4007c0 is the ld1b in the sha512-sve)

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Robert Henry <robhenry@microsoft.com>
Cc: Aaron Lindsay <aaron@os.amperecomputing.com>

---
v2
 - allow TLB_MMIO to appear in user-mode probe_access
v3
 - checkpatch cleanups
v4
 - add new probe helper for mmu's, add check_mem_cbs to probe_internal

8 files changed, 94 insertions(+), 21 deletions(-)
include/exec/cpu-all.h            |  2 +-
include/exec/exec-all.h           | 23 ++++++++++++++++++++++
include/hw/core/cpu.h             | 17 +++++++++++++++++
accel/tcg/cputlb.c                | 40 ++++++++++++++++++++++++++++++++----=
---
accel/tcg/user-exec.c             |  8 ++++++--
target/arm/ptw.c                  | 13 ++++++-------
target/arm/tcg/sve_helper.c       |  4 ----
tests/tcg/aarch64/Makefile.target |  8 ++++++++

modified   include/exec/cpu-all.h
@@ -301,7 +301,7 @@ CPUArchState *cpu_copy(CPUArchState *env);
  * be signaled by probe_access_flags().
  */
 #define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
-#define TLB_MMIO            0
+#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
 #define TLB_WATCHPOINT      0
=20
 #else
modified   include/exec/exec-all.h
@@ -464,6 +464,29 @@ int probe_access_full(CPUArchState *env, vaddr addr, i=
nt size,
                       MMUAccessType access_type, int mmu_idx,
                       bool nonfault, void **phost,
                       CPUTLBEntryFull **pfull, uintptr_t retaddr);
+
+/**
+ * probe_access_mmu() - Like probe_access_full except cannot fault and
+ * doesn't trigger instrumentation.
+ *
+ * @env: CPUArchState
+ * @vaddr: virtual address to probe
+ * @size: size of the probe
+ * @access_type: read, write or execute permission
+ * @mmu_idx: softmmu index
+ * @phost: ptr to return value host address or NULL
+ * @pfull: ptr to return value CPUTLBEntryFull structure or NULL
+ *
+ * The CPUTLBEntryFull structure returned via @pfull is transient
+ * and must be consumed or copied immediately, before any further
+ * access or changes to TLB @mmu_idx.
+ *
+ * Returns: TLB flags as per probe_access_flags()
+ */
+int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
+                          MMUAccessType access_type, int mmu_idx,
+                          void **phost, CPUTLBEntryFull **pfull);
+
 #endif
=20
 /* Hide the qatomic_read to make code a little easier on the eyes */
modified   include/hw/core/cpu.h
@@ -976,6 +976,23 @@ void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWa=
tchpoint *watchpoint);
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
 #endif
=20
+/**
+ * cpu_plugin_mem_cbs_enabled() - are plugin memory callbacks enabled?
+ * @cs: CPUState pointer
+ *
+ * The memory callbacks are installed if a plugin has instrumented an
+ * instruction for memory. This can be useful to know if you want to
+ * force a slow path for a series of memory accesses.
+ */
+static inline bool cpu_plugin_mem_cbs_enabled(const CPUState *cpu)
+{
+#ifdef CONFIG_PLUGIN
+    return !!cpu->plugin_mem_cbs;
+#else
+    return false;
+#endif
+}
+
 /**
  * cpu_get_address_space:
  * @cpu: CPU to get address space from
modified   accel/tcg/cputlb.c
@@ -1513,13 +1513,14 @@ static int probe_access_internal(CPUArchState *env,=
 vaddr addr,
                                  int fault_size, MMUAccessType access_type,
                                  int mmu_idx, bool nonfault,
                                  void **phost, CPUTLBEntryFull **pfull,
-                                 uintptr_t retaddr)
+                                 uintptr_t retaddr, bool check_mem_cbs)
 {
     uintptr_t index =3D tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
     uint64_t tlb_addr =3D tlb_read_idx(entry, access_type);
     vaddr page_addr =3D addr & TARGET_PAGE_MASK;
     int flags =3D TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
+    bool force_mmio =3D check_mem_cbs && cpu_plugin_mem_cbs_enabled(env_cp=
u(env));
     CPUTLBEntryFull *full;
=20
     if (!tlb_hit_page(tlb_addr, page_addr)) {
@@ -1553,7 +1554,9 @@ static int probe_access_internal(CPUArchState *env, v=
addr addr,
     flags |=3D full->slow_flags[access_type];
=20
     /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
-    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY))) {
+    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY))
+        ||
+        (access_type !=3D MMU_INST_FETCH && force_mmio)) {
         *phost =3D NULL;
         return TLB_MMIO;
     }
@@ -1569,7 +1572,7 @@ int probe_access_full(CPUArchState *env, vaddr addr, =
int size,
                       uintptr_t retaddr)
 {
     int flags =3D probe_access_internal(env, addr, size, access_type, mmu_=
idx,
-                                      nonfault, phost, pfull, retaddr);
+                                      nonfault, phost, pfull, retaddr, tru=
e);
=20
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
@@ -1580,6 +1583,29 @@ int probe_access_full(CPUArchState *env, vaddr addr,=
 int size,
     return flags;
 }
=20
+int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
+                          MMUAccessType access_type, int mmu_idx,
+                          void **phost, CPUTLBEntryFull **pfull)
+{
+    void *discard_phost;
+    CPUTLBEntryFull *discard_tlb;
+
+    /* privately handle users that don't need full results */
+    phost =3D phost ? phost : &discard_phost;
+    pfull =3D pfull ? pfull : &discard_tlb;
+
+    int flags =3D probe_access_internal(env, addr, size, access_type, mmu_=
idx,
+                                      true, phost, pfull, 0, false);
+
+    /* Handle clean RAM pages.  */
+    if (unlikely(flags & TLB_NOTDIRTY)) {
+        notdirty_write(env_cpu(env), addr, 1, *pfull, 0);
+        flags &=3D ~TLB_NOTDIRTY;
+    }
+
+    return flags;
+}
+
 int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t retaddr)
@@ -1590,7 +1616,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr,=
 int size,
     g_assert(-(addr | TARGET_PAGE_MASK) >=3D size);
=20
     flags =3D probe_access_internal(env, addr, size, access_type, mmu_idx,
-                                  nonfault, phost, &full, retaddr);
+                                  nonfault, phost, &full, retaddr, true);
=20
     /* Handle clean RAM pages. */
     if (unlikely(flags & TLB_NOTDIRTY)) {
@@ -1611,7 +1637,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int=
 size,
     g_assert(-(addr | TARGET_PAGE_MASK) >=3D size);
=20
     flags =3D probe_access_internal(env, addr, size, access_type, mmu_idx,
-                                  false, &host, &full, retaddr);
+                                  false, &host, &full, retaddr, true);
=20
     /* Per the interface, size =3D=3D 0 merely faults the access. */
     if (size =3D=3D 0) {
@@ -1644,7 +1670,7 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr ad=
dr,
     int flags;
=20
     flags =3D probe_access_internal(env, addr, 0, access_type,
-                                  mmu_idx, true, &host, &full, 0);
+                                  mmu_idx, true, &host, &full, 0, false);
=20
     /* No combination of flags are expected by the caller. */
     return flags ? NULL : host;
@@ -1667,7 +1693,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState =
*env, vaddr addr,
     void *p;
=20
     (void)probe_access_internal(env, addr, 1, MMU_INST_FETCH,
-                                cpu_mmu_index(env, true), false, &p, &full=
, 0);
+                                cpu_mmu_index(env, true), false, &p, &full=
, 0, false);
     if (p =3D=3D NULL) {
         return -1;
     }
modified   accel/tcg/user-exec.c
@@ -745,6 +745,10 @@ static int probe_access_internal(CPUArchState *env, va=
ddr addr,
     if (guest_addr_valid_untagged(addr)) {
         int page_flags =3D page_get_flags(addr);
         if (page_flags & acc_flag) {
+            if ((acc_flag =3D=3D PAGE_READ || acc_flag =3D=3D PAGE_WRITE)
+                && cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+                return TLB_MMIO;
+            }
             return 0; /* success */
         }
         maperr =3D !(page_flags & PAGE_VALID);
@@ -767,7 +771,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, i=
nt size,
=20
     g_assert(-(addr | TARGET_PAGE_MASK) >=3D size);
     flags =3D probe_access_internal(env, addr, size, access_type, nonfault=
, ra);
-    *phost =3D flags ? NULL : g2h(env_cpu(env), addr);
+    *phost =3D (flags & TLB_INVALID_MASK) ? NULL : g2h(env_cpu(env), addr);
     return flags;
 }
=20
@@ -778,7 +782,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int s=
ize,
=20
     g_assert(-(addr | TARGET_PAGE_MASK) >=3D size);
     flags =3D probe_access_internal(env, addr, size, access_type, false, r=
a);
-    g_assert(flags =3D=3D 0);
+    g_assert((flags & ~TLB_MMIO) =3D=3D 0);
=20
     return size ? g2h(env_cpu(env), addr) : NULL;
 }
modified   target/arm/ptw.c
@@ -489,9 +489,9 @@ static bool S1_ptw_translate(CPUARMState *env, S1Transl=
ate *ptw,
         int flags;
=20
         env->tlb_fi =3D fi;
-        flags =3D probe_access_full(env, addr, 0, MMU_DATA_LOAD,
-                                  arm_to_core_mmu_idx(s2_mmu_idx),
-                                  true, &ptw->out_host, &full, 0);
+        flags =3D probe_access_full_mmu(env, addr, 0, MMU_DATA_LOAD,
+                                      arm_to_core_mmu_idx(s2_mmu_idx),
+                                      &ptw->out_host, &full);
         env->tlb_fi =3D NULL;
=20
         if (unlikely(flags & TLB_INVALID_MASK)) {
@@ -644,12 +644,11 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64=
_t old_val,
      */
     if (unlikely(!ptw->out_rw)) {
         int flags;
-        void *discard;
=20
         env->tlb_fi =3D fi;
-        flags =3D probe_access_flags(env, ptw->out_virt, 0, MMU_DATA_STORE,
-                                   arm_to_core_mmu_idx(ptw->in_ptw_idx),
-                                   true, &discard, 0);
+        flags =3D probe_access_full_mmu(env, ptw->out_virt, 0,
+                                      MMU_DATA_STORE, arm_to_core_mmu_idx(=
ptw->in_ptw_idx),
+                                      NULL, NULL);
         env->tlb_fi =3D NULL;
=20
         if (unlikely(flags & TLB_INVALID_MASK)) {
modified   target/arm/tcg/sve_helper.c
@@ -5688,9 +5688,6 @@ void sve_ldN_r(CPUARMState *env, uint64_t *vg, const =
target_ulong addr,
=20
     flags =3D info.page[0].flags | info.page[1].flags;
     if (unlikely(flags !=3D 0)) {
-#ifdef CONFIG_USER_ONLY
-        g_assert_not_reached();
-#else
         /*
          * At least one page includes MMIO.
          * Any bus operation can fail with cpu_transaction_failed,
@@ -5727,7 +5724,6 @@ void sve_ldN_r(CPUARMState *env, uint64_t *vg, const =
target_ulong addr,
             memcpy(&env->vfp.zregs[(rd + i) & 31], &scratch[i], reg_max);
         }
         return;
-#endif
     }
=20
     /* The entire operation is in RAM, on valid pages. */
--8<---------------cut here---------------end--------------->8---

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

