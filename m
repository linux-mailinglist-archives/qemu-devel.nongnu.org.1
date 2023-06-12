Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F231B72C9C9
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 17:22:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8jM0-0008LY-AB; Mon, 12 Jun 2023 11:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q8jLw-0008LL-46
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 11:21:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q8jLr-0005F3-6s
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 11:21:07 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QfwNT5wkbz6J70D;
 Mon, 12 Jun 2023 23:20:09 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 16:20:45 +0100
Date: Mon, 12 Jun 2023 16:20:44 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PULL 26/42] target/arm: Use tcg_gen_qemu_{ld, st}_i128 in
 gen_sve_{ld, st}r
Message-ID: <20230612162044.00002fdc@huawei.com>
In-Reply-To: <20230606094814.3581397-27-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
 <20230606094814.3581397-27-peter.maydell@linaro.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue,  6 Jun 2023 10:47:58 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Round len_align to 16 instead of 8, handling an odd 8-byte as part
> of the tail.  Use MO_ATOM_NONE to indicate that all of these memory
> ops have only byte atomicity.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20230530191438.411344-8-richard.henderson@linaro.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Early in debugging but a git bisect pointed at this patch causing:

ERROR:../../tcg/tcg.c:4317:temp_load: code should not be reached
Bail out! ERROR:../../tcg/tcg.c:4317:temp_load: code should not be reached
Aborted

Just after Run /sbin/init arm64 / virt running on an x86 host.
cpu max.

Just reverting this patch results in length check failures.
I reverted as follows


revert: Revert "target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sve_{ld, st}r"
revert: Revert "target/arm: Sink gen_mte_check1 into load/store_exclusive"
revert: Revert "target/arm: Load/store integer pair with one tcg operation"
revert: Revert "target/arm: Hoist finalize_memop out of do_gpr_{ld, st}"
revert: Revert "target/arm: Hoist finalize_memop out of do_fp_{ld, st}"
revert: Revert "target/arm: Pass memop to gen_mte_check1*"
revert: Revert "target/arm: Pass single_memop to gen_mte_checkN"
revert: Revert "target/arm: Check alignment in helper_mte_check"
revert: Revert "target/arm: Add SCTLR.nAA to TBFLAG_A64"
revert: Revert "target/arm: Relax ordered/atomic alignment checks for LSE2"
revert: Revert "target/arm: Move mte check for store-exclusive"

and all is good - obviously that's probably massive overkill.

Jonathan

> ---
>  target/arm/tcg/translate-sve.c | 95 +++++++++++++++++++++++++---------
>  1 file changed, 70 insertions(+), 25 deletions(-)
> 
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index d9d5810ddea..57051a4729a 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -4167,11 +4167,12 @@ TRANS_FEAT(UCVTF_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
>  void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
>                   int len, int rn, int imm)
>  {
> -    int len_align = QEMU_ALIGN_DOWN(len, 8);
> -    int len_remain = len % 8;
> -    int nparts = len / 8 + ctpop8(len_remain);
> +    int len_align = QEMU_ALIGN_DOWN(len, 16);
> +    int len_remain = len % 16;
> +    int nparts = len / 16 + ctpop8(len_remain);
>      int midx = get_mem_index(s);
>      TCGv_i64 dirty_addr, clean_addr, t0, t1;
> +    TCGv_i128 t16;
>  
>      dirty_addr = tcg_temp_new_i64();
>      tcg_gen_addi_i64(dirty_addr, cpu_reg_sp(s, rn), imm);
> @@ -4188,10 +4189,16 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
>          int i;
>  
>          t0 = tcg_temp_new_i64();
> -        for (i = 0; i < len_align; i += 8) {
> -            tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUQ);
> +        t1 = tcg_temp_new_i64();
> +        t16 = tcg_temp_new_i128();
> +
> +        for (i = 0; i < len_align; i += 16) {
> +            tcg_gen_qemu_ld_i128(t16, clean_addr, midx,
> +                                 MO_LE | MO_128 | MO_ATOM_NONE);
> +            tcg_gen_extr_i128_i64(t0, t1, t16);
>              tcg_gen_st_i64(t0, base, vofs + i);
> -            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
> +            tcg_gen_st_i64(t1, base, vofs + i + 8);
> +            tcg_gen_addi_i64(clean_addr, clean_addr, 16);
>          }
>      } else {
>          TCGLabel *loop = gen_new_label();
> @@ -4200,14 +4207,21 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
>          tcg_gen_movi_ptr(i, 0);
>          gen_set_label(loop);
>  
> -        t0 = tcg_temp_new_i64();
> -        tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUQ);
> -        tcg_gen_addi_i64(clean_addr, clean_addr, 8);
> +        t16 = tcg_temp_new_i128();
> +        tcg_gen_qemu_ld_i128(t16, clean_addr, midx,
> +                             MO_LE | MO_128 | MO_ATOM_NONE);
> +        tcg_gen_addi_i64(clean_addr, clean_addr, 16);
>  
>          tp = tcg_temp_new_ptr();
>          tcg_gen_add_ptr(tp, base, i);
> -        tcg_gen_addi_ptr(i, i, 8);
> +        tcg_gen_addi_ptr(i, i, 16);
> +
> +        t0 = tcg_temp_new_i64();
> +        t1 = tcg_temp_new_i64();
> +        tcg_gen_extr_i128_i64(t0, t1, t16);
> +
>          tcg_gen_st_i64(t0, tp, vofs);
> +        tcg_gen_st_i64(t1, tp, vofs + 8);
>  
>          tcg_gen_brcondi_ptr(TCG_COND_LTU, i, len_align, loop);
>      }
> @@ -4216,6 +4230,16 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
>       * Predicate register loads can be any multiple of 2.
>       * Note that we still store the entire 64-bit unit into cpu_env.
>       */
> +    if (len_remain >= 8) {
> +        t0 = tcg_temp_new_i64();
> +        tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUQ | MO_ATOM_NONE);
> +        tcg_gen_st_i64(t0, base, vofs + len_align);
> +        len_remain -= 8;
> +        len_align += 8;
> +        if (len_remain) {
> +            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
> +        }
> +    }
>      if (len_remain) {
>          t0 = tcg_temp_new_i64();
>          switch (len_remain) {
> @@ -4223,14 +4247,14 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
>          case 4:
>          case 8:
>              tcg_gen_qemu_ld_i64(t0, clean_addr, midx,
> -                                MO_LE | ctz32(len_remain));
> +                                MO_LE | ctz32(len_remain) | MO_ATOM_NONE);
>              break;
>  
>          case 6:
>              t1 = tcg_temp_new_i64();
> -            tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUL);
> +            tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUL | MO_ATOM_NONE);
>              tcg_gen_addi_i64(clean_addr, clean_addr, 4);
> -            tcg_gen_qemu_ld_i64(t1, clean_addr, midx, MO_LEUW);
> +            tcg_gen_qemu_ld_i64(t1, clean_addr, midx, MO_LEUW | MO_ATOM_NONE);
>              tcg_gen_deposit_i64(t0, t0, t1, 32, 32);
>              break;
>  
> @@ -4245,11 +4269,12 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
>  void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
>                   int len, int rn, int imm)
>  {
> -    int len_align = QEMU_ALIGN_DOWN(len, 8);
> -    int len_remain = len % 8;
> -    int nparts = len / 8 + ctpop8(len_remain);
> +    int len_align = QEMU_ALIGN_DOWN(len, 16);
> +    int len_remain = len % 16;
> +    int nparts = len / 16 + ctpop8(len_remain);
>      int midx = get_mem_index(s);
> -    TCGv_i64 dirty_addr, clean_addr, t0;
> +    TCGv_i64 dirty_addr, clean_addr, t0, t1;
> +    TCGv_i128 t16;
>  
>      dirty_addr = tcg_temp_new_i64();
>      tcg_gen_addi_i64(dirty_addr, cpu_reg_sp(s, rn), imm);
> @@ -4267,10 +4292,15 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
>          int i;
>  
>          t0 = tcg_temp_new_i64();
> +        t1 = tcg_temp_new_i64();
> +        t16 = tcg_temp_new_i128();
>          for (i = 0; i < len_align; i += 8) {
>              tcg_gen_ld_i64(t0, base, vofs + i);
> -            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUQ);
> -            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
> +            tcg_gen_ld_i64(t1, base, vofs + i + 8);
> +            tcg_gen_concat_i64_i128(t16, t0, t1);
> +            tcg_gen_qemu_st_i128(t16, clean_addr, midx,
> +                                 MO_LE | MO_128 | MO_ATOM_NONE);
> +            tcg_gen_addi_i64(clean_addr, clean_addr, 16);
>          }
>      } else {
>          TCGLabel *loop = gen_new_label();
> @@ -4280,18 +4310,33 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
>          gen_set_label(loop);
>  
>          t0 = tcg_temp_new_i64();
> +        t1 = tcg_temp_new_i64();
>          tp = tcg_temp_new_ptr();
>          tcg_gen_add_ptr(tp, base, i);
>          tcg_gen_ld_i64(t0, tp, vofs);
> -        tcg_gen_addi_ptr(i, i, 8);
> +        tcg_gen_ld_i64(t1, tp, vofs + 8);
> +        tcg_gen_addi_ptr(i, i, 16);
>  
> -        tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUQ);
> -        tcg_gen_addi_i64(clean_addr, clean_addr, 8);
> +        t16 = tcg_temp_new_i128();
> +        tcg_gen_concat_i64_i128(t16, t0, t1);
> +
> +        tcg_gen_qemu_st_i128(t16, clean_addr, midx, MO_LEUQ);
> +        tcg_gen_addi_i64(clean_addr, clean_addr, 16);
>  
>          tcg_gen_brcondi_ptr(TCG_COND_LTU, i, len_align, loop);
>      }
>  
>      /* Predicate register stores can be any multiple of 2.  */
> +    if (len_remain >= 8) {
> +        t0 = tcg_temp_new_i64();
> +        tcg_gen_st_i64(t0, base, vofs + len_align);
> +        tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUQ | MO_ATOM_NONE);
> +        len_remain -= 8;
> +        len_align += 8;
> +        if (len_remain) {
> +            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
> +        }
> +    }
>      if (len_remain) {
>          t0 = tcg_temp_new_i64();
>          tcg_gen_ld_i64(t0, base, vofs + len_align);
> @@ -4301,14 +4346,14 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
>          case 4:
>          case 8:
>              tcg_gen_qemu_st_i64(t0, clean_addr, midx,
> -                                MO_LE | ctz32(len_remain));
> +                                MO_LE | ctz32(len_remain) | MO_ATOM_NONE);
>              break;
>  
>          case 6:
> -            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUL);
> +            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUL | MO_ATOM_NONE);
>              tcg_gen_addi_i64(clean_addr, clean_addr, 4);
>              tcg_gen_shri_i64(t0, t0, 32);
> -            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUW);
> +            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUW | MO_ATOM_NONE);
>              break;
>  
>          default:


