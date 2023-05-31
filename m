Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B09DB717AC4
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 10:54:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Hap-0000q1-Si; Wed, 31 May 2023 04:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1q4HaX-0000pF-Ec
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:53:49 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1q4HaS-0007rJ-SN
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:53:49 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R431e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0Vjx-02q_1685523216; 
Received: from 30.221.97.186(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0Vjx-02q_1685523216) by smtp.aliyun-inc.com;
 Wed, 31 May 2023 16:53:36 +0800
Message-ID: <c5222f99-10c1-18be-7d71-8267a6cdd40c@linux.alibaba.com>
Date: Wed, 31 May 2023 16:53:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC] Native Library Calls
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Yeqi Fu <fufuyqqqqqq@gmail.com>, qemu-devel@nongnu.org
References: <20230530142430.45834-1-fufuyqqqqqq@gmail.com>
 <8cb0d3d8-4f8b-7cae-ea46-3100280c1748@linux.alibaba.com>
 <87r0qxc4jr.fsf@linaro.org>
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <87r0qxc4jr.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -99
X-Spam_score: -10.0
X-Spam_bar: ----------
X-Spam_report: (-10.0 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2023/5/31 15:59, Alex Bennée wrote:
> LIU Zhiwei <zhiwei_liu@linux.alibaba.com> writes:
>
>> On 2023/5/30 22:24, Yeqi Fu wrote:
>>> This patch introduces a set of feature instructions for native calls
>>> and provides helpers to translate these instructions to corresponding
>>> native functions. A shared library is also implemented, where native
>>> functions are rewritten as feature instructions. At runtime, user
>>> programs load the shared library, and feature instructions are
>>> executed when native functions are called. This patch is applicable
>>> to user programs with architectures x86, x86_64, arm, aarch64, mips,
>>> and mips64. To build, compile libnative.c into a shared library for
>>> the user program's architecture
>> Hi Yeqi,
>>
>> It's an interesting feature.
>>
>> I want to know how does the user program load the native.so? From your
>> commit message, libnative.c will be compiled to the user program's
>> architecture.
>> Should I link my program with native.so at the link stage?
> The idea would be to use the LD_PRELOAD mechanism to get the translated
> linker to bind the new functions before the rest of the libraries are
> mapped. However I think we need to introduce a control flag to
> qemu-$ARCH to enable it, maybe something like:
>
>    qemu-$ARCH --native-bypass ./libnative.so $PROGNAME
>
> and then QEMU itself can setup LD_PRELOAD in the guest environment
> before it runs the program.

Does it mean that we have to replace all functions of the original 
library(libc.so here)? Only replace a few functions may break other 
functions in the same library.

Zhiwei

>
>> Thanks,
>> Zhiwei
>>
>>>    and run the
>>> '../configure --enable-user-native-call && make' command.
>>>
>>> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
>>> ---
>>>    include/exec/user/native-func.h      |  8 +++
>>>    libnative.c                          | 76 ++++++++++++++++++++++++++++
>>>    meson.build                          |  8 +++
>>>    meson_options.txt                    |  2 +
>>>    scripts/make-config-poison.sh        |  4 +-
>>>    scripts/meson-buildoptions.sh        |  4 ++
>>>    target/arm/helper.c                  | 47 +++++++++++++++++
>>>    target/arm/helper.h                  |  6 +++
>>>    target/arm/tcg/translate-a64.c       | 32 ++++++++++++
>>>    target/arm/tcg/translate.c           | 30 ++++++++++-
>>>    target/arm/tcg/translate.h           |  8 +++
>>>    target/i386/helper.h                 |  6 +++
>>>    target/i386/tcg/translate.c          | 20 ++++++++
>>>    target/i386/tcg/user/meson.build     |  1 +
>>>    target/i386/tcg/user/native_helper.c | 63 +++++++++++++++++++++++
>>>    target/mips/helper.h                 |  6 +++
>>>    target/mips/tcg/meson.build          |  1 +
>>>    target/mips/tcg/native_helper.c      | 55 ++++++++++++++++++++
>>>    target/mips/tcg/translate.c          | 22 +++++++-
>>>    19 files changed, 396 insertions(+), 3 deletions(-)
>>>    create mode 100644 include/exec/user/native-func.h
>>>    create mode 100644 libnative.c
>>>    create mode 100644 target/i386/tcg/user/native_helper.c
>>>    create mode 100644 target/mips/tcg/native_helper.c
>>>
>>> diff --git a/include/exec/user/native-func.h b/include/exec/user/native-func.h
>>> new file mode 100644
>>> index 0000000000..8eaac03299
>>> --- /dev/null
>>> +++ b/include/exec/user/native-func.h
>>> @@ -0,0 +1,8 @@
>>> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
>>> +#define NATIVE_MEMCPY 0x1001
>>> +#define NATIVE_MEMCMP 0x1002
>>> +#define NATIVE_MEMSET 0x1003
>>> +#define NATIVE_STRCPY 0x1004
>>> +#define NATIVE_STRCMP 0x1005
>>> +#define NATIVE_STRCAT 0x1006
>>> +#endif /* CONFIG_USER_NATIVE_CALL */
>>> diff --git a/libnative.c b/libnative.c
>>> new file mode 100644
>>> index 0000000000..cc65c8270c
>>> --- /dev/null
>>> +++ b/libnative.c
>>> @@ -0,0 +1,76 @@
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +
>>> +#define NATIVE_MEMCPY 0x1001
>>> +#define NATIVE_MEMCMP 0x1002
>>> +#define NATIVE_MEMSET 0x1003
>>> +#define NATIVE_STRCPY 0x1004
>>> +#define NATIVE_STRCMP 0x1005
>>> +#define NATIVE_STRCAT 0x1006
>>> +
>>> +void *memcpy(void *dest, const void *src, size_t n);
>>> +int memcmp(const void *s1, const void *s2, size_t n);
>>> +void *memset(void *s, int c, size_t n);
>>> +char *strcpy(char *dest, const char *src);
>>> +int strcmp(const char *s1, const char *s2);
>>> +char *strcat(char *dest, const char *src);
>>> +
>>> +#define STR_MACRO(str) #str
>>> +#define STR(num) STR_MACRO(num)
>>> +
>>> +#if defined(TARGET_X86_64) || defined(TARGET_I386)
>>> +
>>> +/* unused opcode */
>>> +#define __PREFIX_INSTR \
>>> +    ".byte 0x0f,0xff;"
>>> +
>>> +#define NATIVE_CALL_EXPR(func) \
>>> +    __PREFIX_INSTR             \
>>> +    ".word " STR(func) ";" : : :
>>> +#endif
>>> +
>>> +#if defined(TARGET_ARM) || defined(TARGET_AARCH64)
>>> +
>>> +/* unused syscall number */
>>> +#define __PREFIX_INSTR \
>>> +    "svc 0xff;"
>>> +
>>> +#define NATIVE_CALL_EXPR(func) \
>>> +    __PREFIX_INSTR             \
>>> +    ".word " STR(func) ";" : : :
>>> +
>>> +#endif
>>> +
>>> +#if defined(TARGET_MIPS) || defined(TARGET_MIPS64)
>>> +
>>> +/* unused bytes in syscall instructions */
>>> +#define NATIVE_CALL_EXPR(func) \
>>> +    ".long " STR((0x1 << 24) + (func << 8) + 0xC) ";" : : :
>>> +
>>> +#endif
>>> +
>>> +void *memcpy(void *dest, const void *src, size_t n)
>>> +{
>>> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMCPY));
>>> +}
>>> +
>>> +int memcmp(const void *s1, const void *s2, size_t n)
>>> +{
>>> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMCMP));
>>> +}
>>> +void *memset(void *s, int c, size_t n)
>>> +{
>>> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMSET));
>>> +}
>>> +char *strcpy(char *dest, const char *src)
>>> +{
>>> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCPY));
>>> +}
>>> +int strcmp(const char *s1, const char *s2)
>>> +{
>>> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCMP));
>>> +}
>>> +char *strcat(char *dest, const char *src)
>>> +{
>>> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCAT));
>>> +}
>>> diff --git a/meson.build b/meson.build
>>> index 0a5cdefd4d..04e99a4f25 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -2012,6 +2012,11 @@ have_virtfs_proxy_helper = get_option('virtfs_proxy_helper') \
>>>        .require(libcap_ng.found(), error_message: 'the virtfs proxy helper requires libcap-ng') \
>>>        .allowed()
>>>    +have_user_native_call = get_option('user_native_call') \
>>> +    .require(have_user, error_message: 'user_native_call requires user') \
>>> +    .require(targetos == 'linux', error_message: 'user_native_call requires Linux') \
>>> +    .allowed()
>>> +
>>>    if get_option('block_drv_ro_whitelist') == ''
>>>      config_host_data.set('CONFIG_BDRV_RO_WHITELIST', '')
>>>    else
>>> @@ -2853,6 +2858,9 @@ foreach target : target_dirs
>>>          error('Target @0@ is only available on a Linux host'.format(target))
>>>        endif
>>>        config_target += { 'CONFIG_LINUX_USER': 'y' }
>>> +    if have_user_native_call
>>> +      config_target += { 'CONFIG_USER_NATIVE_CALL': 'y' }
>>> +    endif
>>>      elif target.endswith('bsd-user')
>>>        if 'CONFIG_BSD' not in config_host
>>>          if default_targets
>>> diff --git a/meson_options.txt b/meson_options.txt
>>> index 90237389e2..148dfc99d8 100644
>>> --- a/meson_options.txt
>>> +++ b/meson_options.txt
>>> @@ -352,3 +352,5 @@ option('slirp_smbd', type : 'feature', value : 'auto',
>>>      option('hexagon_idef_parser', type : 'boolean', value : true,
>>>           description: 'use idef-parser to automatically generate TCG code for the Hexagon frontend')
>>> +option('user_native_call', type : 'feature', value : 'auto',
>>> +       description: 'use native code for user mode emulation')
>>> diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
>>> index 1892854261..cf2ba69949 100755
>>> --- a/scripts/make-config-poison.sh
>>> +++ b/scripts/make-config-poison.sh
>>> @@ -5,10 +5,12 @@ if test $# = 0; then
>>>    fi
>>>      # Create list of config switches that should be poisoned in
>>> common code...
>>> -# but filter out CONFIG_TCG and CONFIG_USER_ONLY which are special.
>>> +# but filter out CONFIG_TCG, CONFIG_USER_ONLY and CONFIG_USER_NATIVE_CALL
>>> +# which are special.
>>>    exec sed -n \
>>>      -e' /CONFIG_TCG/d' \
>>>      -e '/CONFIG_USER_ONLY/d' \
>>> +  -e '/CONFIG_USER_NATIVE_CALL/d' \
>>>      -e '/^#define / {' \
>>>      -e    's///' \
>>>      -e    's/ .*//' \
>>> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
>>> index 5714fd93d9..9e98db9eb7 100644
>>> --- a/scripts/meson-buildoptions.sh
>>> +++ b/scripts/meson-buildoptions.sh
>>> @@ -173,6 +173,8 @@ meson_options_help() {
>>>      printf "%s\n" '  tpm             TPM support'
>>>      printf "%s\n" '  u2f             U2F emulation support'
>>>      printf "%s\n" '  usb-redir       libusbredir support'
>>> +  printf "%s\n" '  user-native-call'
>>> +  printf "%s\n" '                  use native code for user mode emulation'
>>>      printf "%s\n" '  vde             vde network backend support'
>>>      printf "%s\n" '  vdi             vdi image format support'
>>>      printf "%s\n" '  vduse-blk-export'
>>> @@ -472,6 +474,8 @@ _meson_option_parse() {
>>>        --disable-u2f) printf "%s" -Du2f=disabled ;;
>>>        --enable-usb-redir) printf "%s" -Dusb_redir=enabled ;;
>>>        --disable-usb-redir) printf "%s" -Dusb_redir=disabled ;;
>>> +    --enable-user-native-call) printf "%s" -Duser_native_call=enabled ;;
>>> +    --disable-user-native-call) printf "%s" -Duser_native_call=disabled ;;
>>>        --enable-vde) printf "%s" -Dvde=enabled ;;
>>>        --disable-vde) printf "%s" -Dvde=disabled ;;
>>>        --enable-vdi) printf "%s" -Dvdi=enabled ;;
>>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>>> index 0b7fd2e7e6..03fbc3724b 100644
>>> --- a/target/arm/helper.c
>>> +++ b/target/arm/helper.c
>>> @@ -25,6 +25,7 @@
>>>    #include "sysemu/tcg.h"
>>>    #include "qapi/error.h"
>>>    #include "qemu/guest-random.h"
>>> +#include "exec/cpu_ldst.h"
>>>    #ifdef CONFIG_TCG
>>>    #include "semihosting/common-semi.h"
>>>    #endif
>>> @@ -12045,3 +12046,49 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
>>>        }
>>>    }
>>>    #endif
>>> +
>>> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
>>> +
>>> +#define NATIVE_FN_W_3W()           \
>>> +    target_ulong arg0, arg1, arg2; \
>>> +    arg0 = env->regs[0];           \
>>> +    arg1 = env->regs[1];           \
>>> +    arg2 = env->regs[2];
>>> +
>>> +void helper_native_memcpy(CPUARMState *env)
>>> +{
>>> +    CPUState *cs = env_cpu(env);
>>> +    NATIVE_FN_W_3W();
>>> +    void *ret;
>>> +    void *dest = g2h(cs, arg0);
>>> +    void *src = g2h(cs, arg1);
>>> +    size_t n = (size_t)arg2;
>>> +    ret = memcpy(dest, src, n);
>>> +    env->regs[0] = (target_ulong)h2g(ret);
>>> +}
>>> +
>>> +void helper_native_memcmp(CPUARMState *env)
>>> +{
>>> +    CPUState *cs = env_cpu(env);
>>> +    NATIVE_FN_W_3W();
>>> +    int ret;
>>> +    void *s1 = g2h(cs, arg0);
>>> +    void *s2 = g2h(cs, arg1);
>>> +    size_t n = (size_t)arg2;
>>> +    ret = memcmp(s1, s2, n);
>>> +    env->regs[0] = ret;
>>> +}
>>> +
>>> +void helper_native_memset(CPUARMState *env)
>>> +{
>>> +    CPUState *cs = env_cpu(env);
>>> +    NATIVE_FN_W_3W();
>>> +    void *ret;
>>> +    void *s = g2h(cs, arg0);
>>> +    int c = (int)arg1;
>>> +    size_t n = (size_t)arg2;
>>> +    ret = memset(s, c, n);
>>> +    env->regs[0] = (target_ulong)h2g(ret);
>>> +}
>>> +
>>> +#endif
>>> diff --git a/target/arm/helper.h b/target/arm/helper.h
>>> index 3335c2b10b..57144bf6fb 100644
>>> --- a/target/arm/helper.h
>>> +++ b/target/arm/helper.h
>>> @@ -1038,6 +1038,12 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_s, TCG_CALL_NO_RWG,
>>>    DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
>>>                       void, ptr, ptr, ptr, ptr, i32)
>>>    +#if defined(CONFIG_USER_ONLY)  &&
>>> defined(CONFIG_USER_NATIVE_CALL)
>>> +DEF_HELPER_1(native_memcpy, void, env)
>>> +DEF_HELPER_1(native_memcmp, void, env)
>>> +DEF_HELPER_1(native_memset, void, env)
>>> +#endif
>>> +
>>>    #ifdef TARGET_AARCH64
>>>    #include "tcg/helper-a64.h"
>>>    #include "tcg/helper-sve.h"
>>> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
>>> index 741a608739..a0ae96a2fd 100644
>>> --- a/target/arm/tcg/translate-a64.c
>>> +++ b/target/arm/tcg/translate-a64.c
>>> @@ -35,6 +35,7 @@
>>>    #include "cpregs.h"
>>>    #include "translate-a64.h"
>>>    #include "qemu/atomic128.h"
>>> +#include "exec/user/native-func.h"
>>>      static TCGv_i64 cpu_X[32];
>>>    static TCGv_i64 cpu_pc;
>>> @@ -42,6 +43,11 @@ static TCGv_i64 cpu_pc;
>>>    /* Load/store exclusive handling */
>>>    static TCGv_i64 cpu_exclusive_high;
>>>    +#if defined(CONFIG_USER_ONLY) && defined(TARGET_AARCH64) && \
>>> +    defined(CONFIG_USER_NATIVE_CALL)
>>> +bool native_call_status;
>>> +#endif
>>> +
>>>    static const char *regnames[] = {
>>>        "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7",
>>>        "x8", "x9", "x10", "x11", "x12", "x13", "x14", "x15",
>>> @@ -2292,6 +2298,12 @@ static void disas_exc(DisasContext *s, uint32_t insn)
>>>                    gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, 2);
>>>                    break;
>>>                }
>>> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
>>> +            else if (imm16 == 0xff) {
>>> +                native_call_status = true;
>>> +                break;
>>> +            }
>>> +#endif
>>>                gen_ss_advance(s);
>>>                gen_exception_insn(s, 4, EXCP_SWI, syndrome);
>>>                break;
>>> @@ -14203,6 +14215,26 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>>>        s->fp_access_checked = false;
>>>        s->sve_access_checked = false;
>>>    +#if defined(CONFIG_USER_ONLY)  &&
>>> defined(CONFIG_USER_NATIVE_CALL)
>>> +    if (native_call_status) {
>>> +        switch (insn) {
>>> +        case NATIVE_MEMCPY:
>>> +            gen_helper_native_memcpy(cpu_env);
>>> +            break;
>>> +        case NATIVE_MEMCMP:
>>> +            gen_helper_native_memcmp(cpu_env);
>>> +            break;
>>> +        case NATIVE_MEMSET:
>>> +            gen_helper_native_memset(cpu_env);
>>> +            break;
>>> +        default:
>>> +            unallocated_encoding(s);
>>> +        }
>>> +        native_call_status = false;
>>> +        return;
>>> +    }
>>> +#endif
>>> +
>>>        if (s->pstate_il) {
>>>            /*
>>>             * Illegal execution state. This has priority over BTI
>>> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
>>> index 7468476724..9d84cad960 100644
>>> --- a/target/arm/tcg/translate.c
>>> +++ b/target/arm/tcg/translate.c
>>> @@ -34,7 +34,7 @@
>>>    #include "exec/helper-gen.h"
>>>    #include "exec/log.h"
>>>    #include "cpregs.h"
>>> -
>>> +#include "exec/user/native-func.h"
>>>      #define ENABLE_ARCH_4T    arm_dc_feature(s, ARM_FEATURE_V4T)
>>>    #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
>>> @@ -58,6 +58,11 @@ TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
>>>    TCGv_i64 cpu_exclusive_addr;
>>>    TCGv_i64 cpu_exclusive_val;
>>>    +#if defined(CONFIG_USER_ONLY) && !defined(TARGET_AARCH64)  \
>>> +    && defined(CONFIG_USER_NATIVE_CALL)
>>> +bool native_call_status;
>>> +#endif
>>> +
>>>    #include "exec/gen-icount.h"
>>>      static const char * const regnames[] =
>>> @@ -8576,6 +8581,10 @@ static bool trans_SVC(DisasContext *s, arg_SVC *a)
>>>            if (s->fgt_svc) {
>>>                uint32_t syndrome = syn_aa32_svc(a->imm, s->thumb);
>>>                gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, 2);
>>> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
>>> +        } else if (a->imm == 0xff) {
>>> +            native_call_status = true;
>>> +#endif
>>>            } else {
>>>                gen_update_pc(s, curr_insn_len(s));
>>>                s->svc_imm = a->imm;
>>> @@ -9372,6 +9381,25 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>>>        insn = arm_ldl_code(env, &dc->base, pc, dc->sctlr_b);
>>>        dc->insn = insn;
>>>        dc->base.pc_next = pc + 4;
>>> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
>>> +    if (native_call_status) {
>>> +        switch (insn) {
>>> +        case NATIVE_MEMCPY:
>>> +            gen_helper_native_memcpy(cpu_env);
>>> +            break;
>>> +        case NATIVE_MEMCMP:
>>> +            gen_helper_native_memcmp(cpu_env);
>>> +            break;
>>> +        case NATIVE_MEMSET:
>>> +            gen_helper_native_memset(cpu_env);
>>> +            break;
>>> +        default:
>>> +            unallocated_encoding(dc);
>>> +        }
>>> +        native_call_status = false;
>>> +        return;
>>> +    }
>>> +#endif
>>>        disas_arm_insn(dc, insn);
>>>          arm_post_translate_insn(dc);
>>> diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
>>> index a9d1f4adc2..2291850f3c 100644
>>> --- a/target/arm/tcg/translate.h
>>> +++ b/target/arm/tcg/translate.h
>>> @@ -161,6 +161,14 @@ extern TCGv_i32 cpu_NF, cpu_ZF, cpu_CF, cpu_VF;
>>>    extern TCGv_i64 cpu_exclusive_addr;
>>>    extern TCGv_i64 cpu_exclusive_val;
>>>    +/*
>>> + * Indicate whether the next instruction is a native function call (true)
>>> + * or not (false).
>>> + */
>>> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
>>> +extern bool native_call_status;
>>> +#endif
>>> +
>>>    /*
>>>     * Constant expanders for the decoders.
>>>     */
>>> diff --git a/target/i386/helper.h b/target/i386/helper.h
>>> index e627a93107..6c91655887 100644
>>> --- a/target/i386/helper.h
>>> +++ b/target/i386/helper.h
>>> @@ -221,3 +221,9 @@ DEF_HELPER_3(rcrq, tl, env, tl, tl)
>>>    #endif
>>>      DEF_HELPER_1(rdrand, tl, env)
>>> +
>>> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
>>> +DEF_HELPER_1(native_memcpy, void, env)
>>> +DEF_HELPER_1(native_memcmp, void, env)
>>> +DEF_HELPER_1(native_memset, void, env)
>>> +#endif
>>> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
>>> index 91c9c0c478..068f594532 100644
>>> --- a/target/i386/tcg/translate.c
>>> +++ b/target/i386/tcg/translate.c
>>> @@ -33,6 +33,7 @@
>>>    #include "helper-tcg.h"
>>>      #include "exec/log.h"
>>> +#include "exec/user/native-func.h"
>>>      #define PREFIX_REPZ   0x01
>>>    #define PREFIX_REPNZ  0x02
>>> @@ -6806,6 +6807,25 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
>>>        case 0x1d0 ... 0x1fe:
>>>            disas_insn_new(s, cpu, b);
>>>            break;
>>> +    /* One unknown opcode for native call */
>>> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
>>> +    case 0x1ff:
>>> +        uint16_t sig = x86_lduw_code(env, s);
>>> +        switch (sig) {
>>> +        case NATIVE_MEMCPY:
>>> +            gen_helper_native_memcpy(cpu_env);
>>> +            break;
>>> +        case NATIVE_MEMSET:
>>> +            gen_helper_native_memset(cpu_env);
>>> +            break;
>>> +        case NATIVE_MEMCMP:
>>> +            gen_helper_native_memcmp(cpu_env);
>>> +            break;
>>> +        default:
>>> +            goto unknown_op;
>>> +        }
>>> +        break;
>>> +#endif
>>>        default:
>>>            goto unknown_op;
>>>        }
>>> diff --git a/target/i386/tcg/user/meson.build b/target/i386/tcg/user/meson.build
>>> index 1df6bc4343..490808bd65 100644
>>> --- a/target/i386/tcg/user/meson.build
>>> +++ b/target/i386/tcg/user/meson.build
>>> @@ -1,4 +1,5 @@
>>>    i386_user_ss.add(when: ['CONFIG_TCG', 'CONFIG_USER_ONLY'], if_true: files(
>>>      'excp_helper.c',
>>>      'seg_helper.c',
>>> +  'native_helper.c',
>>>    ))
>>> diff --git a/target/i386/tcg/user/native_helper.c b/target/i386/tcg/user/native_helper.c
>>> new file mode 100644
>>> index 0000000000..300e14d71a
>>> --- /dev/null
>>> +++ b/target/i386/tcg/user/native_helper.c
>>> @@ -0,0 +1,63 @@
>>> +/*
>>> + *  native function call helpers
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "cpu.h"
>>> +#include "exec/helper-proto.h"
>>> +#include "exec/exec-all.h"
>>> +#include "exec/cpu_ldst.h"
>>> +#include "tcg/helper-tcg.h"
>>> +#include "tcg/seg_helper.h"
>>> +
>>> +#ifdef TARGET_X86_64
>>> +#define NATIVE_FN_W_3W()           \
>>> +    target_ulong arg0, arg1, arg2; \
>>> +    arg0 = env->regs[R_EDI];       \
>>> +    arg1 = env->regs[R_ESI];       \
>>> +    arg2 = env->regs[R_EDX];
>>> +#else
>>> +/* linux x86 has several calling conventions. The following implementation
>>> +   is for the most commonly used cdecl calling convention. */
>>> +#define NATIVE_FN_W_3W()                                   \
>>> +    target_ulong arg0, arg1, arg2;                         \
>>> +    arg0 = *(target_ulong *)g2h(cs, env->regs[R_ESP] + 4); \
>>> +    arg1 = *(target_ulong *)g2h(cs, env->regs[R_ESP] + 8); \
>>> +    arg2 = *(target_ulong *)g2h(cs, env->regs[R_ESP] + 12);
>>> +#endif
>>> +
>>> +void helper_native_memcpy(CPUX86State *env)
>>> +{
>>> +    CPUState *cs = env_cpu(env);
>>> +    NATIVE_FN_W_3W();
>>> +    void *ret;
>>> +    void *dest = g2h(cs, arg0);
>>> +    void *src = g2h(cs, arg1);
>>> +    size_t n = (size_t)arg2;
>>> +    ret = memcpy(dest, src, n);
>>> +    env->regs[R_EAX] = (target_ulong)h2g(ret);
>>> +}
>>> +
>>> +void helper_native_memcmp(CPUX86State *env)
>>> +{
>>> +    CPUState *cs = env_cpu(env);
>>> +    NATIVE_FN_W_3W();
>>> +    int ret;
>>> +    void *s1 = g2h(cs, arg0);
>>> +    void *s2 = g2h(cs, arg1);
>>> +    size_t n = (size_t)arg2;
>>> +    ret = memcmp(s1, s2, n);
>>> +    env->regs[R_EAX] = ret;
>>> +}
>>> +
>>> +void helper_native_memset(CPUX86State *env)
>>> +{
>>> +    CPUState *cs = env_cpu(env);
>>> +    NATIVE_FN_W_3W();
>>> +    void *ret;
>>> +    void *s = g2h(cs, arg0);
>>> +    int c = (int)arg1;
>>> +    size_t n = (size_t)arg2;
>>> +    ret = memset(s, c, n);
>>> +    env->regs[R_EAX] = (target_ulong)h2g(ret);
>>> +}
>>> diff --git a/target/mips/helper.h b/target/mips/helper.h
>>> index de32d82e98..9fa949d78c 100644
>>> --- a/target/mips/helper.h
>>> +++ b/target/mips/helper.h
>>> @@ -589,6 +589,12 @@ DEF_HELPER_FLAGS_3(dmthlip, 0, void, tl, tl, env)
>>>    DEF_HELPER_FLAGS_3(wrdsp, 0, void, tl, tl, env)
>>>    DEF_HELPER_FLAGS_2(rddsp, 0, tl, tl, env)
>>>    +#if defined(CONFIG_USER_ONLY)  &&
>>> defined(CONFIG_USER_NATIVE_CALL)
>>> +DEF_HELPER_1(native_memcpy, void, env)
>>> +DEF_HELPER_1(native_memcmp, void, env)
>>> +DEF_HELPER_1(native_memset, void, env)
>>> +#endif
>>> +
>>>    #ifndef CONFIG_USER_ONLY
>>>    #include "tcg/sysemu_helper.h.inc"
>>>    #endif /* !CONFIG_USER_ONLY */
>>> diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
>>> index 7ee969ec8f..fb1ea64047 100644
>>> --- a/target/mips/tcg/meson.build
>>> +++ b/target/mips/tcg/meson.build
>>> @@ -22,6 +22,7 @@ mips_ss.add(files(
>>>      'txx9_translate.c',
>>>      'vr54xx_helper.c',
>>>      'vr54xx_translate.c',
>>> +  'native_helper.c',
>>>    ))
>>>    mips_ss.add(when: 'TARGET_MIPS64', if_true: files(
>>>      'tx79_translate.c',
>>> diff --git a/target/mips/tcg/native_helper.c b/target/mips/tcg/native_helper.c
>>> new file mode 100644
>>> index 0000000000..bfd9c92e17
>>> --- /dev/null
>>> +++ b/target/mips/tcg/native_helper.c
>>> @@ -0,0 +1,55 @@
>>> +/*
>>> + *  native function call helpers
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "cpu.h"
>>> +#include "exec/helper-proto.h"
>>> +#include "exec/exec-all.h"
>>> +#include "exec/cpu_ldst.h"
>>> +
>>> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
>>> +
>>> +#define NATIVE_FN_W_3W()                   \
>>> +    target_ulong arg0, arg1, arg2;         \
>>> +    arg0 = env->active_tc.gpr[4]; /*"a0"*/ \
>>> +    arg1 = env->active_tc.gpr[5]; /*"a1"*/ \
>>> +    arg2 = env->active_tc.gpr[6]; /*"a2"*/
>>> +
>>> +void helper_native_memcpy(CPUMIPSState *env)
>>> +{
>>> +    CPUState *cs = env_cpu(env);
>>> +    NATIVE_FN_W_3W();
>>> +    void *ret;
>>> +    void *dest = g2h(cs, arg0);
>>> +    void *src = g2h(cs, arg1);
>>> +    size_t n = (size_t)arg2;
>>> +    ret = memcpy(dest, src, n);
>>> +    env->active_tc.gpr[2] = (target_ulong)h2g(ret);
>>> +}
>>> +
>>> +void helper_native_memcmp(CPUMIPSState *env)
>>> +{
>>> +    CPUState *cs = env_cpu(env);
>>> +    NATIVE_FN_W_3W();
>>> +    int ret;
>>> +    void *s1 = g2h(cs, arg0);
>>> +    void *s2 = g2h(cs, arg1);
>>> +    size_t n = (size_t)arg2;
>>> +    ret = memcmp(s1, s2, n);
>>> +    env->active_tc.gpr[2] = ret;
>>> +}
>>> +
>>> +void helper_native_memset(CPUMIPSState *env)
>>> +{
>>> +    CPUState *cs = env_cpu(env);
>>> +    NATIVE_FN_W_3W();
>>> +    void *ret;
>>> +    void *s = g2h(cs, arg0);
>>> +    int c = (int)arg1;
>>> +    size_t n = (size_t)arg2;
>>> +    ret = memset(s, c, n);
>>> +    env->active_tc.gpr[2] = (target_ulong)h2g(ret);
>>> +}
>>> +
>>> +#endif
>>> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
>>> index a6ca2e5a3b..8236dfba21 100644
>>> --- a/target/mips/tcg/translate.c
>>> +++ b/target/mips/tcg/translate.c
>>> @@ -36,6 +36,7 @@
>>>    #include "qemu/qemu-print.h"
>>>    #include "fpu_helper.h"
>>>    #include "translate.h"
>>> +#include "exec/user/native-func.h"
>>>      /*
>>>     * Many sysemu-only helpers are not reachable for user-only.
>>> @@ -13591,7 +13592,26 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
>>>            gen_helper_pmon(cpu_env, tcg_constant_i32(sa));
>>>    #endif
>>>            break;
>>> -    case OPC_SYSCALL:
>>> +    case OPC_SYSCALL:  /* 00 00 00 0C */
>>> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
>>> +        if ((((ctx->opcode) >> 24) & 0xff) == 0x1) {
>>> +            uint16_t sig =  (ctx->opcode) >> 8 & 0xffff;
>>> +            switch (sig) {
>>> +            case NATIVE_MEMCPY:
>>> +                gen_helper_native_memcpy(cpu_env);
>>> +                break;
>>> +            case NATIVE_MEMSET:
>>> +                gen_helper_native_memset(cpu_env);
>>> +                break;
>>> +            case NATIVE_MEMCMP:
>>> +                gen_helper_native_memcmp(cpu_env);
>>> +                break;
>>> +            default:
>>> +                gen_reserved_instruction(ctx);
>>> +            }
>>> +            break;
>>> +        }
>>> +#endif
>>>            generate_exception_end(ctx, EXCP_SYSCALL);
>>>            break;
>>>        case OPC_BREAK:
>

