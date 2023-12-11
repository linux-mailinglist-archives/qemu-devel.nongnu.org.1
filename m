Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B030780BEFC
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 03:18:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCVrA-0000SD-Op; Sun, 10 Dec 2023 21:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lrh2000@pku.edu.cn>)
 id 1rCVr2-0000S3-F7
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 21:17:08 -0500
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net ([159.89.151.119])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lrh2000@pku.edu.cn>) id 1rCVqi-0000Gn-MN
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 21:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To; bh=9vgTC+v1HnZJciiLgM1nsZg27gnk
 ciH1vxpC3vtJVic=; b=RkLRYTNjHSFoWdpyxm/YaHrkg0Coc0MLvkkibl9manyt
 c5HLvI/IX6ZtXZjEVKgkUnfYvcuI+Pf++M72bL+L18JbNB760KlHgfQeiHJXKzGA
 TRDJ+/jLRa+jAnNJlfQvKZ6sVdiRWcbeOcajAKkdmeK7OSCf6Zm9P5Zzg+zIlHY=
Received: from localhost (unknown [10.7.136.133])
 by front01 (Coremail) with SMTP id 5oFpogAnLuoCcXZlC1KlAA--.19838S2;
 Mon, 11 Dec 2023 10:16:41 +0800 (CST)
Date: Mon, 11 Dec 2023 10:16:34 +0800
From: Ruihan Li <lrh2000@pku.edu.cn>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [PATCH] target/i386: Give IRQs a chance when resetting
 HF_INHIBIT_IRQ_MASK
Message-ID: <xv3hrcg5gi3ejilsxovpuj464mo7qrbit63l2a45l5nmynvaqu@up7ddcskbrt7>
References: <20231210190147.129734-2-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210190147.129734-2-lrh2000@pku.edu.cn>
X-CM-TRANSID: 5oFpogAnLuoCcXZlC1KlAA--.19838S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYT7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j
 6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
 MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s
 026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
 JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
 v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
 j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
 W8JbIYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEPBWVt8iwEdQAVs7
Received-SPF: pass client-ip=159.89.151.119; envelope-from=lrh2000@pku.edu.cn;
 helo=zg8tmtu5ljg5lje1ms4xmtka.icoremail.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon, Dec 11, 2023 at 03:01:48AM +0800, Ruihan Li wrote:
> [ .. ]
> 
> This problem is caused because the previous code may choose not to end
> the TB even if the HF_INHIBIT_IRQ_MASK has just been reset (e.g., in the
> case where the RET instruction is immediately followed by the STI
> instruction), so that IRQs may not have a change to trigger.

There is a typo. I mean "in the case where the STI instruction is
immediately followed by the RET instruction", not the other way around.

I'll send a V2 patch if necessary, but let's hear from others first.

Thanks,
Ruihan Li


