Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13232818AC6
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 16:06:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFbeE-000187-4c; Tue, 19 Dec 2023 10:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lrh2000@pku.edu.cn>)
 id 1rFbeA-00017u-LR
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 10:04:38 -0500
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net ([159.89.151.119])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lrh2000@pku.edu.cn>) id 1rFbe7-0007hj-GT
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 10:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To; bh=0rgeu6vAEx3lCMyvKlXZT0o2B2UQ
 XryGYyT4EjmmlRU=; b=Kk4sJOnHVHSe+W2wPVUkhlDYQIdIcXXabVUZBjSEl846
 15TYytTG609uuFCq5YD6ZbY9c5gwD2yqz6+ihJb4fd6Blvg/PtE+wNO7+AsNUyl1
 CyM+e/tt7dI3zaQoKq6XsVnr3LL0UgA3hRGVDir4kzjkJjfW0CzXyUT5UHuwF2o=
Received: from localhost (unknown [10.7.107.141])
 by front01 (Coremail) with SMTP id 5oFpogBnTkf0sIFlEmk8AQ--.57468S2;
 Tue, 19 Dec 2023 23:04:24 +0800 (CST)
Date: Tue, 19 Dec 2023 23:04:20 +0800
From: Ruihan Li <lrh2000@pku.edu.cn>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [PATCH] target/i386: Give IRQs a chance when resetting
 HF_INHIBIT_IRQ_MASK
Message-ID: <vtru73lhzn24ue6dlx3hbqm4y4dcqvrx2nvjnbbwozfix5h5wa@63tiijodka5c>
References: <20231210190147.129734-2-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210190147.129734-2-lrh2000@pku.edu.cn>
X-CM-TRANSID: 5oFpogBnTkf0sIFlEmk8AQ--.57468S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw47Ww1UCrWfWr43JFW5KFg_yoW5WF1Upa
 1xZwnFyw4kXFWDGanrJa1UXF1YyF4rKr1jkFn3tw1rKw4rKr9YqFn3KFW5KFW5WFWxuFya
 vr10vFyjva4UZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvG1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
 w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
 IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
 z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
 AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
 McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
 v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF
 04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4AY6r
 1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
 b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
 vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
 cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
 73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgECBWV12y0WcAAZsd
Received-SPF: pass client-ip=159.89.151.119; envelope-from=lrh2000@pku.edu.cn;
 helo=zg8tmtu5ljg5lje1ms4xmtka.icoremail.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi all,

On Mon, Dec 11, 2023 at 03:01:48AM +0800, Ruihan Li wrote:
> When emulated with QEMU, interrupts will never come in the following
> loop. However, if the NOP instruction is uncommented, interrupts will
> fire as normal.
> 
> 	loop:
> 		cli
>     		call do_sti
> 		jmp loop
> 
> 	do_sti:
> 		sti
> 		# nop
> 		ret
> 
> This behavior is different from that of a real processor. For example,
> if KVM is enabled, interrupts will always fire regardless of whether the
> NOP instruction is commented or not. Also, the Intel Software Developer
> Manual states that after the STI instruction is executed, the interrupt
> inhibit should end as soon as the next instruction (e.g., the RET
> instruction if the NOP instruction is commented) is executed.
> 
> This problem is caused because the previous code may choose not to end
> the TB even if the HF_INHIBIT_IRQ_MASK has just been reset (e.g., in the
> case where the RET instruction is immediately followed by the STI
> instruction), so that IRQs may not have a change to trigger. This commit
> fixes the problem by always terminating the current TB to give IRQs a
> chance to trigger when HF_INHIBIT_IRQ_MASK is reset.
> 
> Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> ---
> The same problem was discovered two years ago, see [StackOverflow][so].
> 
>  [so]: https://stackoverflow.com/questions/68135305/executing-ret-after-sti-doesnt-start-interrupts
> 
>  target/i386/tcg/translate.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 587d886..6b7deb5 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -2767,13 +2767,19 @@ static void gen_bnd_jmp(DisasContext *s)
>  static void
>  do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
>  {
> +    bool inhibit_reset;
> +
>      gen_update_cc_op(s);
>  
>      /* If several instructions disable interrupts, only the first does it.  */
>      if (inhibit && !(s->flags & HF_INHIBIT_IRQ_MASK)) {
>          gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
> -    } else {
> +        inhibit_reset = false;
> +    } else if (!inhibit && (s->flags & HF_INHIBIT_IRQ_MASK)) {
>          gen_reset_hflag(s, HF_INHIBIT_IRQ_MASK);
> +        inhibit_reset = true;
> +    } else {
> +        inhibit_reset = false;
>      }
>  
>      if (s->base.tb->flags & HF_RF_MASK) {
> @@ -2784,7 +2790,9 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
>          tcg_gen_exit_tb(NULL, 0);
>      } else if (s->flags & HF_TF_MASK) {
>          gen_helper_single_step(tcg_env);
> -    } else if (jr) {
> +    } else if (jr &&
> +               /* give irqs a chance to happen */
> +               !inhibit_reset) {
>          tcg_gen_lookup_and_goto_ptr();
>      } else {
>          tcg_gen_exit_tb(NULL, 0);
> -- 
> 2.43.0

A friendly ping.

Anyone here to confirm this BUG and/or comment on the patch?

Thanks,
Ruihan Li


