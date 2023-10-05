Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2EB7B9CAD
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 13:07:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoMBJ-0004qj-PG; Thu, 05 Oct 2023 07:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoMBG-0004qP-8p
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 07:06:11 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoMBC-0001Ix-4p
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 07:06:10 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3231d6504e1so809461f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 04:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696503962; x=1697108762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PA4Uf/bGM1iRf5RFAi6BKe64UH/qk2KI1I6Wp58zwUM=;
 b=ZFU4aj8fHwUJTCu1Swo597Yndx6Q0OdV4ow1BTEW8W6HH1Y9+hdNxlf8HyAAbcdg/c
 Md2DCx1G/2bhXmLam3wv5sytXVVxRIIRbC4HozXTznta+vqPKyVSB7JiYIylhhOFmwL0
 Dd21c83VeUf5QtWTkfNbvYGPrMBLlMSUl46QeQamvO/EdnG+KN8K/j6zLM9NfnDuVxAp
 c5XHeonvn0Tq8MuwK5quumSG8RlpEUH6eKFA2Eux7onzkPqFvzwgx6uYRLSVw15lMY6h
 tH/lQ+MyBMn0AjVGOq9WXG5EcryH9AtvmPIpBJ9xgG+iMB56DLz1K3tVHzrTnFvLOHvn
 VRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696503962; x=1697108762;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PA4Uf/bGM1iRf5RFAi6BKe64UH/qk2KI1I6Wp58zwUM=;
 b=PbwIgoNsCVJP/bnYA1EE+GPDgPTFP3fDvrkw+6k+qNigmgaicxXdapb8aHLRSNlU/K
 ILdAe74j4KnrgphNA1NJ85QMmEcMwfgrQVWnTCSUxVeo/Z8KeoPV/o2tg9JWJNevpg9s
 QdvT3Y3HBUIgo07truNFDcShzyGU1+ypucUIVp4tQGLX3z0Axhr9mjRJ7dRktb07XiUY
 IreAzWv72kawUIucOvQTgVJqtHlt1HPER998+8Sth9J8Ccg9FE+kNKM+cd2SoOQR+S0B
 yo4Ol24O5K36nUA+Vjex/6ZFRsxrKX8je0OkmJ/KjPU9yDdlHdlT9QWbhQdantNCjNCV
 mpqQ==
X-Gm-Message-State: AOJu0Yw/yMJzTo1Cl0DmgwqcikN1BjIBXyvTG4j+jB1WjgXnz87SXiqR
 muYHi/WWEXeCQbJVvE9XKtGqRujh6HrnYkLOadQ=
X-Google-Smtp-Source: AGHT+IH9wSn/rROu1gyXPpAkyxDiFRsRvoJgR4YCBx8ThY65uTITXfupkvnGnby+gaGWmSSFp32MRg==
X-Received: by 2002:a5d:680d:0:b0:319:83e4:bbbf with SMTP id
 w13-20020a5d680d000000b0031983e4bbbfmr5038275wru.20.1696503962403; 
 Thu, 05 Oct 2023 04:06:02 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 p1-20020adfce01000000b003258934a4bfsm1527504wrn.36.2023.10.05.04.06.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 04:06:01 -0700 (PDT)
Message-ID: <d0380a09-62e3-d296-6d3d-3ffbc2b9eca3@linaro.org>
Date: Thu, 5 Oct 2023 13:05:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] target/hexagon: fix some occurrences of -Wshadow=local
To: Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, quic_mathbern@quicinc.com, stefanha@redhat.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com
References: <20231004123957.1732915-1-bcain@quicinc.com>
 <20231004123957.1732915-3-bcain@quicinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004123957.1732915-3-bcain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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

Hi Matheus,

On 4/10/23 14:39, Brian Cain wrote:
> Of the changes in this commit, the changes in `HELPER(commit_hvx_stores)()`
> are less obvious.  They are required because of some macro invocations like
> SCATTER_OP_WRITE_TO_MEM().
> 
> e.g.:
> 
>      In file included from ../target/hexagon/op_helper.c:31:
>      ../target/hexagon/mmvec/macros.h:205:18: error: declaration of ‘i’ shadows a previous local [-Werror=shadow=compatible-local]
>        205 |         for (int i = 0; i < sizeof(MMVector); i += sizeof(TYPE)) { \
>            |                  ^
>      ../target/hexagon/op_helper.c:157:17: note: in expansion of macro ‘SCATTER_OP_WRITE_TO_MEM’
>        157 |                 SCATTER_OP_WRITE_TO_MEM(uint16_t);
>            |                 ^~~~~~~~~~~~~~~~~~~~~~~
>      ../target/hexagon/op_helper.c:135:9: note: shadowed declaration is here
>        135 |     int i;
>            |         ^
>      In file included from ../target/hexagon/op_helper.c:31:
>      ../target/hexagon/mmvec/macros.h:204:19: error: declaration of ‘ra’ shadows a previous local [-Werror=shadow=compatible-local]
>        204 |         uintptr_t ra = GETPC(); \
>            |                   ^~
>      ../target/hexagon/op_helper.c:160:17: note: in expansion of macro ‘SCATTER_OP_WRITE_TO_MEM’
>        160 |                 SCATTER_OP_WRITE_TO_MEM(uint32_t);
>            |                 ^~~~~~~~~~~~~~~~~~~~~~~
>      ../target/hexagon/op_helper.c:134:15: note: shadowed declaration is here
>        134 |     uintptr_t ra = GETPC();
>            |               ^~
> 
> Reviewed-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>   target/hexagon/imported/alu.idef |  6 +++---
>   target/hexagon/mmvec/macros.h    |  2 +-
>   target/hexagon/op_helper.c       |  9 +++------
>   target/hexagon/translate.c       | 10 +++++-----
>   4 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/target/hexagon/imported/alu.idef b/target/hexagon/imported/alu.idef
> index 12d2aac5d4..b855676989 100644
> --- a/target/hexagon/imported/alu.idef
> +++ b/target/hexagon/imported/alu.idef
> @@ -1142,9 +1142,9 @@ Q6INSN(A4_cround_rr,"Rd32=cround(Rs32,Rt32)",ATTRIBS(),"Convergent Round", {RdV
>               tmp128 = fSHIFTR128(tmp128, SHIFT);\
>               DST =  fCAST16S_8S(tmp128);\
>           } else {\
> -            size16s_t rndbit_128 =  fCAST8S_16S((1LL << (SHIFT - 1))); \
> -            size16s_t src_128 =  fCAST8S_16S(SRC); \
> -            size16s_t tmp128 = fADD128(src_128, rndbit_128);\
> +            rndbit_128 =  fCAST8S_16S((1LL << (SHIFT - 1))); \
> +            src_128 =  fCAST8S_16S(SRC); \
> +            tmp128 = fADD128(src_128, rndbit_128);\

Correct.

>               tmp128 = fSHIFTR128(tmp128, SHIFT);\
>               DST =  fCAST16S_8S(tmp128);\
>           }
> diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
> index a655634fd1..1ceb9453ee 100644
> --- a/target/hexagon/mmvec/macros.h
> +++ b/target/hexagon/mmvec/macros.h
> @@ -201,7 +201,7 @@
>       } while (0)
>   #define SCATTER_OP_WRITE_TO_MEM(TYPE) \
>       do { \
> -        uintptr_t ra = GETPC(); \
> +        ra = GETPC(); \

Hmm I'm not a big fan of having "public" macros (exposed in header)
which depend on local variable name. I'd rather rename the local 'ra'
variable.

That said, this macro is used twice, for 16/32bits, iterating on 8bits.
You could probably save some cycles using cpu_lduw_le_data_ra() /
cpu_ldl_be_data_ra(). If so, can be done later.

>           for (int i = 0; i < sizeof(MMVector); i += sizeof(TYPE)) { \
>               if (test_bit(i, env->vtcm_log.mask)) { \
>                   TYPE dst = 0; \
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 8ca3976a65..da10ac5847 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -132,10 +132,9 @@ void HELPER(gather_store)(CPUHexagonState *env, uint32_t addr, int slot)
>   void HELPER(commit_hvx_stores)(CPUHexagonState *env)
>   {
>       uintptr_t ra = GETPC();
> -    int i;
>   
>       /* Normal (possibly masked) vector store */
> -    for (i = 0; i < VSTORES_MAX; i++) {
> +    for (int i = 0; i < VSTORES_MAX; i++) {
>           if (env->vstore_pending[i]) {
>               env->vstore_pending[i] = 0;
>               target_ulong va = env->vstore[i].va;
> @@ -162,7 +161,7 @@ void HELPER(commit_hvx_stores)(CPUHexagonState *env)
>                   g_assert_not_reached();
>               }
>           } else {
> -            for (i = 0; i < sizeof(MMVector); i++) {
> +            for (int i = 0; i < sizeof(MMVector); i++) {
>                   if (test_bit(i, env->vtcm_log.mask)) {
>                       cpu_stb_data_ra(env, env->vtcm_log.va[i],
>                                       env->vtcm_log.data.ub[i], ra);

Correct.

> @@ -505,10 +504,8 @@ void HELPER(probe_pkt_scalar_store_s0)(CPUHexagonState *env, int args)
>   static void probe_hvx_stores(CPUHexagonState *env, int mmu_idx,
>                                       uintptr_t retaddr)
>   {
> -    int i;
> -
>       /* Normal (possibly masked) vector store */
> -    for (i = 0; i < VSTORES_MAX; i++) {
> +    for (int i = 0; i < VSTORES_MAX; i++) {

Correct.

>           if (env->vstore_pending[i]) {
>               target_ulong va = env->vstore[i].va;
>               int size = env->vstore[i].size;
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index c00254e4d5..a1c7cd6f21 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -553,7 +553,7 @@ static void gen_start_packet(DisasContext *ctx)
>       /* Preload the predicated registers into get_result_gpr(ctx, i) */
>       if (ctx->need_commit &&
>           !bitmap_empty(ctx->predicated_regs, TOTAL_PER_THREAD_REGS)) {
> -        int i = find_first_bit(ctx->predicated_regs, TOTAL_PER_THREAD_REGS);

Hmmm, matter of taste, in big functions where a very generic
variable is reused, reducing the scope seems safer (like you
did int commit_hvx_stores).

> +        i = find_first_bit(ctx->predicated_regs, TOTAL_PER_THREAD_REGS);
>           while (i < TOTAL_PER_THREAD_REGS) {
>               tcg_gen_mov_tl(get_result_gpr(ctx, i), hex_gpr[i]);
>               i = find_next_bit(ctx->predicated_regs, TOTAL_PER_THREAD_REGS,
> @@ -566,7 +566,7 @@ static void gen_start_packet(DisasContext *ctx)
>        * Only endloop instructions conditionally write to pred registers
>        */
>       if (ctx->need_commit && pkt->pkt_has_endloop) {
> -        for (int i = 0; i < ctx->preg_log_idx; i++) {
> +        for (i = 0; i < ctx->preg_log_idx; i++) {
>               int pred_num = ctx->preg_log[i];
>               ctx->new_pred_value[pred_num] = tcg_temp_new();
>               tcg_gen_mov_tl(ctx->new_pred_value[pred_num], hex_pred[pred_num]);

[...]

Preferably reworking SCATTER_OP_WRITE_TO_MEM:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Regards,

Phil.


