Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 906EA7A2E6C
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 09:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhQ9o-0007rB-GO; Sat, 16 Sep 2023 03:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qhQ9m-0007qh-5h
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 03:55:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qhQ9h-0004hN-Td
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 03:55:57 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Dx_+t9XwVlAAMpAA--.12111S3;
 Sat, 16 Sep 2023 15:55:42 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxeuR8XwVlgJcIAA--.19192S3; 
 Sat, 16 Sep 2023 15:55:40 +0800 (CST)
Subject: Re: [PATCH v6 54/57] target/loongarch: Implement xvshuf xvperm{i}
 xvshuf4i
From: gaosong <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, maobibo@loongson.cn
References: <20230914022645.1151356-1-gaosong@loongson.cn>
 <20230914022645.1151356-55-gaosong@loongson.cn>
Message-ID: <8c58b6b0-730c-36b1-c3f0-d4e51597c3e5@loongson.cn>
Date: Sat, 16 Sep 2023 15:55:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230914022645.1151356-55-gaosong@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxeuR8XwVlgJcIAA--.19192S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3uw1rZFyxGFWDKw17Zr1UJwc_yoWktw1fpa
 n8JF17Ar48XFWxXr1vyw45t3ZxWFsxKw15uwn3KF1rZrWDJFn8XFy0grZFkF43W3ZYqFy0
 vFsIkry7AFy2qacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.473, SPF_HELO_NONE=0.001,
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

Hi, Richard

Could you review this patch?  it's the lastet patch no review.

Thanks.
Song Gao


ÔÚ 2023/9/14 ÉÏÎç10:26, Song Gao Ð´µÀ:
> This patch includes:
> - XVSHUF.{B/H/W/D};
> - XVPERM.W;
> - XVSHUF4i.{B/H/W/D};
> - XVPERMI.{W/D/Q};
> - XVEXTRINS.{B/H/W/D}.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/helper.h                   |   3 +
>   target/loongarch/insns.decode               |  21 +++
>   target/loongarch/disas.c                    |  21 +++
>   target/loongarch/vec_helper.c               | 146 ++++++++++++++------
>   target/loongarch/insn_trans/trans_vec.c.inc |  30 +++-
>   5 files changed, 175 insertions(+), 46 deletions(-)
> 
> diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
> index fb489dda2d..b3b64a0215 100644
> --- a/target/loongarch/helper.h
> +++ b/target/loongarch/helper.h
> @@ -709,7 +709,10 @@ DEF_HELPER_FLAGS_4(vshuf4i_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
>   DEF_HELPER_FLAGS_4(vshuf4i_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
>   DEF_HELPER_FLAGS_4(vshuf4i_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
>   
> +DEF_HELPER_FLAGS_4(vperm_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>   DEF_HELPER_FLAGS_4(vpermi_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
> +DEF_HELPER_FLAGS_4(vpermi_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
> +DEF_HELPER_FLAGS_4(vpermi_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
>   
>   DEF_HELPER_FLAGS_4(vextrins_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
>   DEF_HELPER_FLAGS_4(vextrins_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
> diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
> index a325b861c1..64b67ee9ac 100644
> --- a/target/loongarch/insns.decode
> +++ b/target/loongarch/insns.decode
> @@ -2039,3 +2039,24 @@ xvilvh_b         0111 01010001 11000 ..... ..... .....    @vvv
>   xvilvh_h         0111 01010001 11001 ..... ..... .....    @vvv
>   xvilvh_w         0111 01010001 11010 ..... ..... .....    @vvv
>   xvilvh_d         0111 01010001 11011 ..... ..... .....    @vvv
> +
> +xvshuf_b         0000 11010110 ..... ..... ..... .....    @vvvv
> +xvshuf_h         0111 01010111 10101 ..... ..... .....    @vvv
> +xvshuf_w         0111 01010111 10110 ..... ..... .....    @vvv
> +xvshuf_d         0111 01010111 10111 ..... ..... .....    @vvv
> +
> +xvperm_w         0111 01010111 11010 ..... ..... .....    @vvv
> +
> +xvshuf4i_b       0111 01111001 00 ........ ..... .....    @vv_ui8
> +xvshuf4i_h       0111 01111001 01 ........ ..... .....    @vv_ui8
> +xvshuf4i_w       0111 01111001 10 ........ ..... .....    @vv_ui8
> +xvshuf4i_d       0111 01111001 11 ........ ..... .....    @vv_ui8
> +
> +xvpermi_w        0111 01111110 01 ........ ..... .....    @vv_ui8
> +xvpermi_d        0111 01111110 10 ........ ..... .....    @vv_ui8
> +xvpermi_q        0111 01111110 11 ........ ..... .....    @vv_ui8
> +
> +xvextrins_d      0111 01111000 00 ........ ..... .....    @vv_ui8
> +xvextrins_w      0111 01111000 01 ........ ..... .....    @vv_ui8
> +xvextrins_h      0111 01111000 10 ........ ..... .....    @vv_ui8
> +xvextrins_b      0111 01111000 11 ........ ..... .....    @vv_ui8
> diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
> index 74ae916a10..1ec8e21e01 100644
> --- a/target/loongarch/disas.c
> +++ b/target/loongarch/disas.c
> @@ -2574,3 +2574,24 @@ INSN_LASX(xvilvh_b,          vvv)
>   INSN_LASX(xvilvh_h,          vvv)
>   INSN_LASX(xvilvh_w,          vvv)
>   INSN_LASX(xvilvh_d,          vvv)
> +
> +INSN_LASX(xvshuf_b,          vvvv)
> +INSN_LASX(xvshuf_h,          vvv)
> +INSN_LASX(xvshuf_w,          vvv)
> +INSN_LASX(xvshuf_d,          vvv)
> +
> +INSN_LASX(xvperm_w,          vvv)
> +
> +INSN_LASX(xvshuf4i_b,        vv_i)
> +INSN_LASX(xvshuf4i_h,        vv_i)
> +INSN_LASX(xvshuf4i_w,        vv_i)
> +INSN_LASX(xvshuf4i_d,        vv_i)
> +
> +INSN_LASX(xvpermi_w,         vv_i)
> +INSN_LASX(xvpermi_d,         vv_i)
> +INSN_LASX(xvpermi_q,         vv_i)
> +
> +INSN_LASX(xvextrins_d,       vv_i)
> +INSN_LASX(xvextrins_w,       vv_i)
> +INSN_LASX(xvextrins_h,       vv_i)
> +INSN_LASX(xvextrins_b,       vv_i)
> diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
> index 2bbaee628b..6b61a5c447 100644
> --- a/target/loongarch/vec_helper.c
> +++ b/target/loongarch/vec_helper.c
> @@ -3381,57 +3381,65 @@ VILVH(vilvh_h, 32, H)
>   VILVH(vilvh_w, 64, W)
>   VILVH(vilvh_d, 128, D)
>   
> +#define SHF_POS(i, imm) (((i) & 0xfc) + (((imm) >> (2 * ((i) & 0x03))) & 0x03))
> +
>   void HELPER(vshuf_b)(void *vd, void *vj, void *vk, void *va, uint32_t desc)
>   {
> -    int i, m;
> -    VReg temp;
> +    int i, j, m;
> +    VReg temp = {};
>       VReg *Vd = (VReg *)vd;
>       VReg *Vj = (VReg *)vj;
>       VReg *Vk = (VReg *)vk;
>       VReg *Va = (VReg *)va;
> +    int oprsz = simd_oprsz(desc);
>   
> -    m = LSX_LEN/8;
> -    for (i = 0; i < m ; i++) {
> +    m = LSX_LEN / 8;
> +    for (i = 0; i < (oprsz / 16) * m; i++) {
> +        j = i < m ? 0 : 1;
>           uint64_t k = (uint8_t)Va->B(i) % (2 * m);
> -        temp.B(i) = k < m ? Vk->B(k) : Vj->B(k - m);
> +        temp.B(i) = k < m ? Vk->B(k + j * m): Vj->B(k + (j - 1) * m);
>       }
>       *Vd = temp;
>   }
>   
> -#define VSHUF(NAME, BIT, E)                                    \
> -void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
> -{                                                              \
> -    int i, m;                                                  \
> -    VReg temp;                                                 \
> -    VReg *Vd = (VReg *)vd;                                     \
> -    VReg *Vj = (VReg *)vj;                                     \
> -    VReg *Vk = (VReg *)vk;                                     \
> -                                                               \
> -    m = LSX_LEN/BIT;                                           \
> -    for (i = 0; i < m; i++) {                                  \
> -        uint64_t k  = ((uint8_t) Vd->E(i)) % (2 * m);          \
> -        temp.E(i) = k < m ? Vk->E(k) : Vj->E(k - m);           \
> -    }                                                          \
> -    *Vd = temp;                                                \
> +#define VSHUF(NAME, BIT, E)                                            \
> +void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)         \
> +{                                                                      \
> +    int i, j, m;                                                       \
> +    VReg temp = {};                                                    \
> +    VReg *Vd = (VReg *)vd;                                             \
> +    VReg *Vj = (VReg *)vj;                                             \
> +    VReg *Vk = (VReg *)vk;                                             \
> +    int oprsz = simd_oprsz(desc);                                      \
> +                                                                       \
> +    m = LSX_LEN / BIT;                                                 \
> +    for (i = 0; i < (oprsz / 16) * m; i++) {                           \
> +        j = i < m ? 0 : 1;                                             \
> +        uint64_t k  = ((uint8_t)Vd->E(i)) % (2 * m);                   \
> +        temp.E(i) = k < m ? Vk->E(k + j * m) : Vj->E(k + (j - 1) * m); \
> +    }                                                                  \
> +    *Vd = temp;                                                        \
>   }
>   
>   VSHUF(vshuf_h, 16, H)
>   VSHUF(vshuf_w, 32, W)
>   VSHUF(vshuf_d, 64, D)
>   
> -#define VSHUF4I(NAME, BIT, E)                                      \
> -void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
> -{                                                                  \
> -    int i;                                                         \
> -    VReg temp;                                                     \
> -    VReg *Vd = (VReg *)vd;                                         \
> -    VReg *Vj = (VReg *)vj;                                         \
> -                                                                   \
> -    for (i = 0; i < LSX_LEN/BIT; i++) {                            \
> -         temp.E(i) = Vj->E(((i) & 0xfc) + (((imm) >>               \
> -                           (2 * ((i) & 0x03))) & 0x03));           \
> -    }                                                              \
> -    *Vd = temp;                                                    \
> +#define VSHUF4I(NAME, BIT, E)                                               \
> +void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)          \
> +{                                                                           \
> +    int i, j, max;                                                          \
> +    VReg temp = {};                                                         \
> +    VReg *Vd = (VReg *)vd;                                                  \
> +    VReg *Vj = (VReg *)vj;                                                  \
> +    int oprsz = simd_oprsz(desc);                                           \
> +                                                                            \
> +    max = LSX_LEN / BIT;                                                    \
> +    for (i = 0; i < oprsz / (BIT / 8); i++) {                               \
> +        j = i < max ? 1 : 2;                                                \
> +        temp.E(i) = Vj->E(SHF_POS(i - ((j -1)* max), imm) + (j - 1) * max); \
> +    }                                                                       \
> +    *Vd = temp;                                                             \
>   }
>   
>   VSHUF4I(vshuf4i_b, 8, B)
> @@ -3440,38 +3448,92 @@ VSHUF4I(vshuf4i_w, 32, W)
>   
>   void HELPER(vshuf4i_d)(void *vd, void *vj, uint64_t imm, uint32_t desc)
>   {
> +    int i;
> +    VReg temp = {};
>       VReg *Vd = (VReg *)vd;
>       VReg *Vj = (VReg *)vj;
> +    int oprsz = simd_oprsz(desc);
>   
> -    VReg temp;
> -    temp.D(0) = (imm & 2 ? Vj : Vd)->D(imm & 1);
> -    temp.D(1) = (imm & 8 ? Vj : Vd)->D((imm >> 2) & 1);
> +    for (i = 0; i < oprsz / 16; i++) {
> +        temp.D(2 * i) = (imm & 2 ? Vj : Vd)->D((imm & 1) + 2 * i);
> +        temp.D(2 * i + 1) = (imm & 8 ? Vj : Vd)->D(((imm >> 2) & 1) + 2 * i);
> +    }
> +    *Vd = temp;
> +}
> +
> +void HELPER(vperm_w)(void *vd, void *vj, void *vk, uint32_t desc)
> +{
> +    int i, m;
> +    VReg temp = {};
> +    VReg *Vd = (VReg *)vd;
> +    VReg *Vj = (VReg *)vj;
> +    VReg *Vk = (VReg *)vk;
> +
> +    m = LASX_LEN / 32;
> +    for (i = 0; i < m ; i++) {
> +        uint64_t k = (uint8_t)Vk->W(i) % 8;
> +        temp.W(i) = Vj->W(k);
> +    }
>       *Vd = temp;
>   }
>   
>   void HELPER(vpermi_w)(void *vd, void *vj, uint64_t imm, uint32_t desc)
>   {
> +    int i;
> +    VReg temp = {};
> +    VReg *Vd = (VReg *)vd;
> +    VReg *Vj = (VReg *)vj;
> +    int oprsz = simd_oprsz(desc);
> +
> +    for (i = 0; i < oprsz / 16; i++) {
> +        temp.W(4 * i) = Vj->W((imm & 0x3) + 4 * i);
> +        temp.W(4 * i + 1) = Vj->W(((imm >> 2) & 0x3) + 4 * i);
> +        temp.W(4 * i + 2) = Vd->W(((imm >> 4) & 0x3) + 4 * i);
> +        temp.W(4 * i + 3) = Vd->W(((imm >> 6) & 0x3) + 4 * i);
> +    }
> +    *Vd = temp;
> +}
> +
> +void HELPER(vpermi_d)(void *vd, void *vj, uint64_t imm, uint32_t desc)
> +{
> +    VReg temp = {};
> +    VReg *Vd = (VReg *)vd;
> +    VReg *Vj = (VReg *)vj;
> +
> +    temp.D(0) = Vj->D(imm & 0x3);
> +    temp.D(1) = Vj->D((imm >> 2) & 0x3);
> +    temp.D(2) = Vj->D((imm >> 4) & 0x3);
> +    temp.D(3) = Vj->D((imm >> 6) & 0x3);
> +    *Vd = temp;
> +}
> +
> +void HELPER(vpermi_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
> +{
> +    int i;
>       VReg temp;
>       VReg *Vd = (VReg *)vd;
>       VReg *Vj = (VReg *)vj;
>   
> -    temp.W(0) = Vj->W(imm & 0x3);
> -    temp.W(1) = Vj->W((imm >> 2) & 0x3);
> -    temp.W(2) = Vd->W((imm >> 4) & 0x3);
> -    temp.W(3) = Vd->W((imm >> 6) & 0x3);
> +    for (i = 0; i < 2; i++, imm >>= 4) {
> +        temp.Q(i) = (imm & 2 ? Vd: Vj)->Q(imm & 1);
> +    }
>       *Vd = temp;
>   }
>   
>   #define VEXTRINS(NAME, BIT, E, MASK)                               \
>   void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
>   {                                                                  \
> -    int ins, extr;                                                 \
> +    int i, ins, extr, max;                                         \
>       VReg *Vd = (VReg *)vd;                                         \
>       VReg *Vj = (VReg *)vj;                                         \
> +    int oprsz = simd_oprsz(desc);                                  \
>                                                                      \
> +    max = LSX_LEN / BIT;                                           \
>       ins = (imm >> 4) & MASK;                                       \
>       extr = imm & MASK;                                             \
> -    Vd->E(ins) = Vj->E(extr);                                      \
> +    for (i = 0; i < oprsz / 16; i++) {                             \
> +        Vd->E(ins + i * max) = Vj->E(extr + i * max);              \
> +    }                                                              \
>   }
>   
>   VEXTRINS(vextrins_b, 8, B, 0xf)
> diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
> index 2b55ce4464..3d0b8bfb74 100644
> --- a/target/loongarch/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/insn_trans/trans_vec.c.inc
> @@ -61,6 +61,10 @@ static bool gen_xxxx_ptr(DisasContext *ctx, arg_vvvv *a,
>   static bool gen_vvvv_vl(DisasContext *ctx, arg_vvvv *a, uint32_t oprsz,
>                           gen_helper_gvec_4 *fn)
>   {
> +    if (!check_vec(ctx, oprsz)) {
> +        return true;
> +    }
> +
>       tcg_gen_gvec_4_ool(vec_full_offset(a->vd),
>                          vec_full_offset(a->vj),
>                          vec_full_offset(a->vk),
> @@ -72,13 +76,15 @@ static bool gen_vvvv_vl(DisasContext *ctx, arg_vvvv *a, uint32_t oprsz,
>   static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
>                        gen_helper_gvec_4 *fn)
>   {
> -    if (!check_vec(ctx, 16)) {
> -        return true;
> -    }
> -
>       return gen_vvvv_vl(ctx, a, 16, fn);
>   }
>   
> +static bool gen_xxxx(DisasContext *ctx, arg_vvvv *a,
> +                     gen_helper_gvec_4 *fn)
> +{
> +    return gen_vvvv_vl(ctx, a, 32, fn);
> +}
> +
>   static bool gen_vvv_ptr_vl(DisasContext *ctx, arg_vvv *a, uint32_t oprsz,
>                              gen_helper_gvec_3_ptr *fn)
>   {
> @@ -5217,17 +5223,33 @@ TRANS(vshuf_b, LSX, gen_vvvv, gen_helper_vshuf_b)
>   TRANS(vshuf_h, LSX, gen_vvv, gen_helper_vshuf_h)
>   TRANS(vshuf_w, LSX, gen_vvv, gen_helper_vshuf_w)
>   TRANS(vshuf_d, LSX, gen_vvv, gen_helper_vshuf_d)
> +TRANS(xvshuf_b, LASX, gen_xxxx, gen_helper_vshuf_b)
> +TRANS(xvshuf_h, LASX, gen_xxx, gen_helper_vshuf_h)
> +TRANS(xvshuf_w, LASX, gen_xxx, gen_helper_vshuf_w)
> +TRANS(xvshuf_d, LASX, gen_xxx, gen_helper_vshuf_d)
>   TRANS(vshuf4i_b, LSX, gen_vv_i, gen_helper_vshuf4i_b)
>   TRANS(vshuf4i_h, LSX, gen_vv_i, gen_helper_vshuf4i_h)
>   TRANS(vshuf4i_w, LSX, gen_vv_i, gen_helper_vshuf4i_w)
>   TRANS(vshuf4i_d, LSX, gen_vv_i, gen_helper_vshuf4i_d)
> +TRANS(xvshuf4i_b, LASX, gen_xx_i, gen_helper_vshuf4i_b)
> +TRANS(xvshuf4i_h, LASX, gen_xx_i, gen_helper_vshuf4i_h)
> +TRANS(xvshuf4i_w, LASX, gen_xx_i, gen_helper_vshuf4i_w)
> +TRANS(xvshuf4i_d, LASX, gen_xx_i, gen_helper_vshuf4i_d)
>   
> +TRANS(xvperm_w, LASX, gen_xxx, gen_helper_vperm_w)
>   TRANS(vpermi_w, LSX, gen_vv_i, gen_helper_vpermi_w)
> +TRANS(xvpermi_w, LASX, gen_xx_i, gen_helper_vpermi_w)
> +TRANS(xvpermi_d, LASX, gen_xx_i, gen_helper_vpermi_d)
> +TRANS(xvpermi_q, LASX, gen_xx_i, gen_helper_vpermi_q)
>   
>   TRANS(vextrins_b, LSX, gen_vv_i, gen_helper_vextrins_b)
>   TRANS(vextrins_h, LSX, gen_vv_i, gen_helper_vextrins_h)
>   TRANS(vextrins_w, LSX, gen_vv_i, gen_helper_vextrins_w)
>   TRANS(vextrins_d, LSX, gen_vv_i, gen_helper_vextrins_d)
> +TRANS(xvextrins_b, LASX, gen_xx_i, gen_helper_vextrins_b)
> +TRANS(xvextrins_h, LASX, gen_xx_i, gen_helper_vextrins_h)
> +TRANS(xvextrins_w, LASX, gen_xx_i, gen_helper_vextrins_w)
> +TRANS(xvextrins_d, LASX, gen_xx_i, gen_helper_vextrins_d)
>   
>   static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
>   {
> 


