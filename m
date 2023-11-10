Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B74987E7DDD
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 17:44:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1UaJ-0004bU-VD; Fri, 10 Nov 2023 11:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=s8KG=GX=kaod.org=clg@ozlabs.org>)
 id 1r1UaI-0004bB-1x; Fri, 10 Nov 2023 11:42:18 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=s8KG=GX=kaod.org=clg@ozlabs.org>)
 id 1r1UaE-0001qc-Rf; Fri, 10 Nov 2023 11:42:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SRl3N4FW3z4x5s;
 Sat, 11 Nov 2023 03:42:08 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SRl3L4VyNz4x5p;
 Sat, 11 Nov 2023 03:42:06 +1100 (AEDT)
Message-ID: <b732ff28-a9f8-47d1-b9c1-259fc7f68774@kaod.org>
Date: Fri, 10 Nov 2023 17:42:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Content-Language: en-US
To: John Platts <john_platts@hotmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
Cc: "npiggin@gmail.com" <npiggin@gmail.com>,
 "danielhb413@gmail.com" <danielhb413@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <SN6PR05MB583705596093E9D2EFC8E4029DDEA@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB5837B5EF0D11E0A787EC30179DA5A@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB583760D0AEB19A3516E216329DAFA@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB58378D2FFC111C3C8482CA3A9DAEA@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB58370F778E36797C833A020E9DAEA@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB5837CB36DC040A4222172C949DAEA@SN6PR05MB5837.namprd05.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SN6PR05MB5837CB36DC040A4222172C949DAEA@SN6PR05MB5837.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=s8KG=GX=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello John,

On 11/10/23 16:37, John Platts wrote:
> The patch below fixes a bug in the VSX_CVT_FP_TO_INT and VSX_CVT_FP_TO_INT2
> macros in target/ppc/fpu_helper.c where a non-NaN floating point value from the
> source vector is incorrectly converted to 0, 0x80000000, or 0x8000000000000000
> instead of the expected value if a preceding source floating point value from
> the same source vector was a NaN.
> 
> The bug in the VSX_CVT_FP_TO_INT and VSX_CVT_FP_TO_INT2 macros in
> target/ppc/fpu_helper.c was introduced with commit c3f24257e3c0.
> 
> This patch also adds a new vsx_f2i_nan test in tests/tcg/ppc64 that checks that
> the VSX xvcvspsxws, xvcvspuxws, xvcvspsxds, xvcvspuxds, xvcvdpsxws, xvcvdpuxws,
> xvcvdpsxds, and xvcvdpuxds instructions correctly convert non-NaN floating point
> values to integer values if the source vector contains NaN floating point values.
> 
> Fixes: c3f24257e3c0 ("target/ppc: Clear fpstatus flags on helpers missing it")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1941
> Signed-off-by: John Platts <john_platts@hotmail.com>
> ---
>   target/ppc/fpu_helper.c         |  12 +-
>   tests/tcg/ppc64/Makefile.target |   2 +-
>   tests/tcg/ppc64/vsx_f2i_nan.c   | 304 ++++++++++++++++++++++++++++++++
>   3 files changed, 313 insertions(+), 5 deletions(-)
>   create mode 100644 tests/tcg/ppc64/vsx_f2i_nan.c

Please avoid email threading when sending a new version of the patch.
It gets burried in a thread and people (like me) might miss it.

Could you please run ./script/checkpatch.pl also and address this issue :

   https://gitlab.com/legoater/qemu/-/jobs/5510354902

Thanks,

C.

> 
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 03150a0f10..4b3dcad5d1 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -2880,20 +2880,22 @@ uint64_t helper_XSCVSPDPN(uint64_t xb)
>   #define VSX_CVT_FP_TO_INT(op, nels, stp, ttp, sfld, tfld, sfi, rnan)         \
>   void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)             \
>   {                                                                            \
> +    int all_flags = 0;                                                       \
>       ppc_vsr_t t = { };                                                       \
>       int i, flags;                                                            \
>                                                                                \
> -    helper_reset_fpstatus(env);                                              \
> -                                                                             \
>       for (i = 0; i < nels; i++) {                                             \
> +        helper_reset_fpstatus(env);                                          \
>           t.tfld = stp##_to_##ttp##_round_to_zero(xb->sfld, &env->fp_status);  \
>           flags = env->fp_status.float_exception_flags;                        \
> +        all_flags |= flags;                                                  \
>           if (unlikely(flags & float_flag_invalid)) {                          \
>               t.tfld = float_invalid_cvt(env, flags, t.tfld, rnan, 0, GETPC());\
>           }                                                                    \
>       }                                                                        \
>                                                                                \
>       *xt = t;                                                                 \
> +    env->fp_status.float_exception_flags = all_flags;                        \
>       do_float_check_status(env, sfi, GETPC());                                \
>   }
>   
> @@ -2945,15 +2947,16 @@ VSX_CVT_FP_TO_INT128(XSCVQPSQZ, int128, 0x8000000000000000ULL);
>   #define VSX_CVT_FP_TO_INT2(op, nels, stp, ttp, sfi, rnan)                    \
>   void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)             \
>   {                                                                            \
> +    int all_flags = 0;                                                       \
>       ppc_vsr_t t = { };                                                       \
>       int i, flags;                                                            \
>                                                                                \
> -    helper_reset_fpstatus(env);                                              \
> -                                                                             \
>       for (i = 0; i < nels; i++) {                                             \
> +        helper_reset_fpstatus(env);                                          \
>           t.VsrW(2 * i) = stp##_to_##ttp##_round_to_zero(xb->VsrD(i),          \
>                                                          &env->fp_status);     \
>           flags = env->fp_status.float_exception_flags;                        \
> +        all_flags |= flags;                                                  \
>           if (unlikely(flags & float_flag_invalid)) {                          \
>               t.VsrW(2 * i) = float_invalid_cvt(env, flags, t.VsrW(2 * i),     \
>                                                 rnan, 0, GETPC());             \
> @@ -2962,6 +2965,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)             \
>       }                                                                        \
>                                                                                \
>       *xt = t;                                                                 \
> +    env->fp_status.float_exception_flags = all_flags;                        \
>       do_float_check_status(env, sfi, GETPC());                                \
>   }
>   
> diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
> index 1d08076756..553f0b1367 100644
> --- a/tests/tcg/ppc64/Makefile.target
> +++ b/tests/tcg/ppc64/Makefile.target
> @@ -12,7 +12,7 @@ config-cc.mak: Makefile
>   -include config-cc.mak
>   
>   ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)
> -PPC64_TESTS=bcdsub non_signalling_xscv
> +PPC64_TESTS=bcdsub non_signalling_xscv vsx_f2i_nan
>   endif
>   $(PPC64_TESTS): CFLAGS += -mpower8-vector
>   
> diff --git a/tests/tcg/ppc64/vsx_f2i_nan.c b/tests/tcg/ppc64/vsx_f2i_nan.c
> new file mode 100644
> index 0000000000..89ab997ef5
> --- /dev/null
> +++ b/tests/tcg/ppc64/vsx_f2i_nan.c
> @@ -0,0 +1,304 @@
> +#include <stdio.h>
> +#include "qemu/compiler.h"
> +
> +typedef vector float vsx_float32_vec_t;
> +typedef vector double vsx_float64_vec_t;
> +typedef vector signed int vsx_int32_vec_t;
> +typedef vector unsigned int vsx_uint32_vec_t;
> +typedef vector signed long long vsx_int64_vec_t;
> +typedef vector unsigned long long vsx_uint64_vec_t;
> +
> +#define DEFINE_VSX_F2I_FUNC(SRC_T, DEST_T, INSN)                       \
> +static inline vsx_##DEST_T##_vec_t                                     \
> +    vsx_convert_##SRC_T##_vec_to_##DEST_T##_vec(vsx_##SRC_T##_vec_t v) \
> +{                                                                      \
> +    vsx_##DEST_T##_vec_t result;                                       \
> +    asm(#INSN " %x0, %x1" : "=wa" (result) : "wa" (v));                \
> +    return result;                                                     \
> +}
> +
> +DEFINE_VSX_F2I_FUNC(float32, int32, xvcvspsxws)
> +DEFINE_VSX_F2I_FUNC(float32, uint32, xvcvspuxws)
> +DEFINE_VSX_F2I_FUNC(float32, int64, xvcvspsxds)
> +DEFINE_VSX_F2I_FUNC(float32, uint64, xvcvspuxds)
> +DEFINE_VSX_F2I_FUNC(float64, int32, xvcvdpsxws)
> +DEFINE_VSX_F2I_FUNC(float64, uint32, xvcvdpuxws)
> +DEFINE_VSX_F2I_FUNC(float64, int64, xvcvdpsxds)
> +DEFINE_VSX_F2I_FUNC(float64, uint64, xvcvdpuxds)
> +
> +static inline vsx_float32_vec_t vsx_float32_is_nan(vsx_float32_vec_t v)
> +{
> +    vsx_float32_vec_t abs_v;
> +    vsx_float32_vec_t result_mask;
> +    const vsx_uint32_vec_t f32_pos_inf_bits = {0x7F800000U, 0x7F800000U,
> +                                               0x7F800000U, 0x7F800000U};
> +
> +    asm("xvabssp %x0, %x1" : "=wa" (abs_v) : "wa" (v));
> +    asm("vcmpgtuw %0, %1, %2"
> +        : "=v" (result_mask)
> +        : "v" (abs_v), "v" (f32_pos_inf_bits));
> +    return result_mask;
> +}
> +
> +static inline vsx_float64_vec_t vsx_float64_is_nan(vsx_float64_vec_t v)
> +{
> +    vsx_float64_vec_t abs_v;
> +    vsx_float64_vec_t result_mask;
> +    const vsx_uint64_vec_t f64_pos_inf_bits = {0x7FF0000000000000ULL,
> +                                               0x7FF0000000000000ULL};
> +
> +    asm("xvabsdp %x0, %x1" : "=wa" (abs_v) : "wa" (v));
> +    asm("vcmpgtud %0, %1, %2"
> +        : "=v" (result_mask)
> +        : "v" (abs_v), "v" (f64_pos_inf_bits));
> +    return result_mask;
> +}
> +
> +#define DEFINE_VSX_BINARY_LOGICAL_OP_INSN(LANE_TYPE, OP_NAME, OP_INSN)    \
> +static inline vsx_##LANE_TYPE##_vec_t vsx_##LANE_TYPE##_##OP_NAME(        \
> +    vsx_##LANE_TYPE##_vec_t a, vsx_##LANE_TYPE##_vec_t b)                 \
> +{                                                                         \
> +    vsx_##LANE_TYPE##_vec_t result;                                       \
> +    asm(#OP_INSN " %x0, %x1, %x2" : "=wa" (result) : "wa" (a), "wa" (b)); \
> +    return result;                                                        \
> +}
> +
> +DEFINE_VSX_BINARY_LOGICAL_OP_INSN(float32, logical_and, xxland)
> +DEFINE_VSX_BINARY_LOGICAL_OP_INSN(float64, logical_and, xxland)
> +DEFINE_VSX_BINARY_LOGICAL_OP_INSN(int32, logical_and, xxland)
> +DEFINE_VSX_BINARY_LOGICAL_OP_INSN(uint32, logical_and, xxland)
> +DEFINE_VSX_BINARY_LOGICAL_OP_INSN(int64, logical_and, xxland)
> +DEFINE_VSX_BINARY_LOGICAL_OP_INSN(uint64, logical_and, xxland)
> +
> +DEFINE_VSX_BINARY_LOGICAL_OP_INSN(float32, logical_andc, xxlandc)
> +DEFINE_VSX_BINARY_LOGICAL_OP_INSN(float64, logical_andc, xxlandc)
> +
> +DEFINE_VSX_BINARY_LOGICAL_OP_INSN(float32, logical_or, xxlor)
> +DEFINE_VSX_BINARY_LOGICAL_OP_INSN(float64, logical_or, xxlor)
> +DEFINE_VSX_BINARY_LOGICAL_OP_INSN(int32, logical_or, xxlor)
> +DEFINE_VSX_BINARY_LOGICAL_OP_INSN(uint32, logical_or, xxlor)
> +DEFINE_VSX_BINARY_LOGICAL_OP_INSN(int64, logical_or, xxlor)
> +DEFINE_VSX_BINARY_LOGICAL_OP_INSN(uint64, logical_or, xxlor)
> +
> +static inline vsx_int32_vec_t vsx_mask_out_float32_vec_to_int32_vec(
> +    vsx_int32_vec_t v)
> +{
> +    return v;
> +}
> +static inline vsx_uint32_vec_t vsx_mask_out_float32_vec_to_uint32_vec(
> +    vsx_uint32_vec_t v)
> +{
> +    return v;
> +}
> +static inline vsx_int64_vec_t vsx_mask_out_float32_vec_to_int64_vec(
> +    vsx_int64_vec_t v)
> +{
> +    return v;
> +}
> +static inline vsx_uint64_vec_t vsx_mask_out_float32_vec_to_uint64_vec(
> +    vsx_uint64_vec_t v)
> +{
> +    return v;
> +}
> +
> +static inline vsx_int32_vec_t vsx_mask_out_float64_vec_to_int32_vec(
> +    vsx_int32_vec_t v)
> +{
> +#if HOST_BIG_ENDIAN
> +    const vsx_int32_vec_t valid_lanes_mask = {-1, 0, -1, 0};
> +#else
> +    const vsx_int32_vec_t valid_lanes_mask = {0, -1, 0, -1};
> +#endif
> +
> +    return vsx_int32_logical_and(v, valid_lanes_mask);
> +}
> +
> +static inline vsx_uint32_vec_t vsx_mask_out_float64_vec_to_uint32_vec(
> +    vsx_uint32_vec_t v)
> +{
> +    return (vsx_uint32_vec_t)vsx_mask_out_float64_vec_to_int32_vec(
> +        (vsx_int32_vec_t)v);
> +}
> +
> +static inline vsx_int64_vec_t vsx_mask_out_float64_vec_to_int64_vec(
> +    vsx_int64_vec_t v)
> +{
> +    return v;
> +}
> +static inline vsx_uint64_vec_t vsx_mask_out_float64_vec_to_uint64_vec(
> +    vsx_uint64_vec_t v)
> +{
> +    return v;
> +}
> +
> +static inline void print_vsx_float32_vec_elements(FILE *stream,
> +                                                  vsx_float32_vec_t vec)
> +{
> +    fprintf(stream, "%g, %g, %g, %g", (double)vec[0], (double)vec[1],
> +            (double)vec[2], (double)vec[3]);
> +}
> +
> +static inline void print_vsx_float64_vec_elements(FILE *stream,
> +                                                  vsx_float64_vec_t vec)
> +{
> +    fprintf(stream, "%.17g, %.17g", vec[0], vec[1]);
> +}
> +
> +static inline void print_vsx_int32_vec_elements(FILE *stream,
> +                                                vsx_int32_vec_t vec)
> +{
> +    fprintf(stream, "%d, %d, %d, %d", vec[0], vec[1], vec[2], vec[3]);
> +}
> +
> +static inline void print_vsx_uint32_vec_elements(FILE *stream,
> +                                                 vsx_uint32_vec_t vec)
> +{
> +    fprintf(stream, "%u, %u, %u, %u", vec[0], vec[1], vec[2], vec[3]);
> +}
> +
> +static inline void print_vsx_int64_vec_elements(FILE *stream,
> +                                                vsx_int64_vec_t vec)
> +{
> +    fprintf(stream, "%lld, %lld", vec[0], vec[1]);
> +}
> +
> +static inline void print_vsx_uint64_vec_elements(FILE *stream,
> +                                                 vsx_uint64_vec_t vec)
> +{
> +    fprintf(stream, "%llu, %llu", vec[0], vec[1]);
> +}
> +
> +#define DEFINE_VSX_ALL_EQ_FUNC(LANE_TYPE, CMP_INSN)                   \
> +static inline int vsx_##LANE_TYPE##_all_eq(vsx_##LANE_TYPE##_vec_t a, \
> +                                           vsx_##LANE_TYPE##_vec_t b) \
> +{                                                                     \
> +    unsigned result;                                                  \
> +    vsx_##LANE_TYPE##_vec_t is_eq_mask_vec;                           \
> +    asm(#CMP_INSN ". %0, %2, %3\n\t"                                  \
> +        "mfocrf %1, 2"                                                \
> +        : "=v" (is_eq_mask_vec), "=r" (result)                        \
> +        : "v" (a), "v" (b)                                            \
> +        : "cr6");                                                     \
> +    return (int)((result >> 7) & 1u);                                 \
> +}
> +
> +DEFINE_VSX_ALL_EQ_FUNC(int32, vcmpequw)
> +DEFINE_VSX_ALL_EQ_FUNC(uint32, vcmpequw)
> +DEFINE_VSX_ALL_EQ_FUNC(int64, vcmpequd)
> +DEFINE_VSX_ALL_EQ_FUNC(uint64, vcmpequd)
> +
> +#define DEFINE_VSX_F2I_TEST_FUNC(SRC_T, DEST_T)                          \
> +static inline int test_vsx_conv_##SRC_T##_vec_to_##DEST_T##_vec(         \
> +    vsx_##SRC_T##_vec_t src_v)                                           \
> +{                                                                        \
> +    const vsx_##SRC_T##_vec_t is_nan_mask = vsx_##SRC_T##_is_nan(src_v); \
> +    const vsx_##SRC_T##_vec_t nan_src_v =                                \
> +        vsx_##SRC_T##_logical_and(src_v, is_nan_mask);                   \
> +    const vsx_##SRC_T##_vec_t non_nan_src_v =                            \
> +        vsx_##SRC_T##_logical_andc(src_v, is_nan_mask);                  \
> +                                                                         \
> +    const vsx_##DEST_T##_vec_t expected_result =                         \
> +        vsx_mask_out_##SRC_T##_vec_to_##DEST_T##_vec(                    \
> +            vsx_##DEST_T##_logical_or(                                   \
> +                vsx_convert_##SRC_T##_vec_to_##DEST_T##_vec(nan_src_v),  \
> +                vsx_convert_##SRC_T##_vec_to_##DEST_T##_vec(             \
> +                    non_nan_src_v)));                                    \
> +    const vsx_##DEST_T##_vec_t actual_result =                           \
> +        vsx_mask_out_##SRC_T##_vec_to_##DEST_T##_vec(                    \
> +            vsx_convert_##SRC_T##_vec_to_##DEST_T##_vec(src_v));         \
> +    const int test_result =                                              \
> +        vsx_##DEST_T##_all_eq(expected_result, actual_result);           \
> +                                                                         \
> +    if (unlikely(test_result == 0))                                      \
> +    {                                                                    \
> +        fputs("FAIL: Conversion of " #SRC_T " vector to " #DEST_T        \
> +              " vector failed\n",                                        \
> +              stdout);                                                   \
> +        fputs("Source values: ", stdout);                                \
> +        print_vsx_##SRC_T##_vec_elements(stdout, src_v);                 \
> +        fputs("\nExpected result: ", stdout);                            \
> +        print_vsx_##DEST_T##_vec_elements(stdout, expected_result);      \
> +        fputs("\nActual result: ", stdout);                              \
> +        print_vsx_##DEST_T##_vec_elements(stdout, actual_result);        \
> +        fputs("\n\n", stdout);                                           \
> +    }                                                                    \
> +                                                                         \
> +    return test_result;                                                  \
> +}
> +
> +
> +DEFINE_VSX_F2I_TEST_FUNC(float32, int32)
> +DEFINE_VSX_F2I_TEST_FUNC(float32, uint32)
> +DEFINE_VSX_F2I_TEST_FUNC(float32, int64)
> +DEFINE_VSX_F2I_TEST_FUNC(float32, uint64)
> +DEFINE_VSX_F2I_TEST_FUNC(float64, int32)
> +DEFINE_VSX_F2I_TEST_FUNC(float64, uint32)
> +DEFINE_VSX_F2I_TEST_FUNC(float64, int64)
> +DEFINE_VSX_F2I_TEST_FUNC(float64, uint64)
> +
> +static inline vsx_int32_vec_t vsx_int32_vec_from_mask(int mask)
> +{
> +    const vsx_int32_vec_t bits_to_test = {1, 2, 4, 8};
> +    const vsx_int32_vec_t vec_mask = {mask, mask, mask, mask};
> +    vsx_int32_vec_t result;
> +
> +    asm("vcmpequw %0, %1, %2"
> +        : "=v" (result)
> +        : "v" (vsx_int32_logical_and(vec_mask, bits_to_test)),
> +          "v" (bits_to_test));
> +    return result;
> +}
> +
> +static inline vsx_int64_vec_t vsx_int64_vec_from_mask(int mask)
> +{
> +    const vsx_int64_vec_t bits_to_test = {1, 2};
> +    const vsx_int64_vec_t vec_mask = {mask, mask};
> +    vsx_int64_vec_t result;
> +
> +    asm("vcmpequd %0, %1, %2"
> +        : "=v" (result)
> +        : "v" (vsx_int64_logical_and(vec_mask, bits_to_test)),
> +          "v" (bits_to_test));
> +    return result;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    const vsx_float32_vec_t f32_iota1 = {1.0f, 2.0f, 3.0f, 4.0f};
> +    const vsx_float64_vec_t f64_iota1 = {1.0, 2.0};
> +
> +    int num_of_tests_failed = 0;
> +
> +    for (int i = 0; i < 16; i++)
> +    {
> +        const vsx_int32_vec_t nan_mask = vsx_int32_vec_from_mask(i);
> +        const vsx_float32_vec_t f32_v =
> +            vsx_float32_logical_or(f32_iota1, (vsx_float32_vec_t)nan_mask);
> +        num_of_tests_failed +=
> +            (int)(!test_vsx_conv_float32_vec_to_int32_vec(f32_v));
> +        num_of_tests_failed +=
> +            (int)(!test_vsx_conv_float32_vec_to_int64_vec(f32_v));
> +        num_of_tests_failed +=
> +            (int)(!test_vsx_conv_float32_vec_to_uint32_vec(f32_v));
> +        num_of_tests_failed +=
> +            (int)(!test_vsx_conv_float32_vec_to_uint64_vec(f32_v));
> +    }
> +
> +    for (int i = 0; i < 4; i++)
> +    {
> +        const vsx_int64_vec_t nan_mask = vsx_int64_vec_from_mask(i);
> +        const vsx_float64_vec_t f64_v =
> +            vsx_float64_logical_or(f64_iota1, (vsx_float64_vec_t)nan_mask);
> +        num_of_tests_failed +=
> +            (int)(!test_vsx_conv_float64_vec_to_int32_vec(f64_v));
> +        num_of_tests_failed +=
> +            (int)(!test_vsx_conv_float64_vec_to_int64_vec(f64_v));
> +        num_of_tests_failed +=
> +            (int)(!test_vsx_conv_float64_vec_to_uint32_vec(f64_v));
> +        num_of_tests_failed +=
> +            (int)(!test_vsx_conv_float64_vec_to_uint64_vec(f64_v));
> +    }
> +
> +    printf("%d tests failed\n", num_of_tests_failed);
> +    return (int)(num_of_tests_failed != 0);
> +}


