Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBF978A11F
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 21:01:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaKzL-0006IP-QP; Sun, 27 Aug 2023 14:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qaKzH-0006IG-Px
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 14:59:51 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qaKzE-0001x6-8u
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 14:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gdMeMo+zG2IVMgyaP5cO4Q9a7gzdC7BuCX7921bN1bU=; b=K9iKD9qhJmOBfNYSRVGO1HvAo6
 QuFN2zXXXfWcMOzrahtB9VJzjsYugHIDUbPAlQ9PLBSnLOFgqJ9rzy+LL22qzBxO6lzEe3ezxtzYB
 p0/BlN5TkrNYKJpdAG7IDZD+A5Mt1QVfLSAxP4vIuKKbSmfDupYWdj5yJocGk/Uz5as0=;
Date: Sun, 27 Aug 2023 20:59:39 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, anton.kochkov@proton.me
Subject: Re: [PATCH 04/10] target/tricore: Implement FTOU insn
Message-ID: <vx6t7q5hjacrs33mtqzqilzh7y2eizdlk54ezim3dtp2uh2cfs@vkfkza47vt5u>
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
 <20230826160242.312052-5-kbastian@mail.uni-paderborn.de>
 <f8f824f3-add2-a6ea-1e78-48aa9d1b6e56@linaro.org>
 <a5atencg3p7r5yad5ybg75c6clr6ofk24xm2j2yw2pct6wb6bs@5onnabp3kkyg>
 <58ad531d-82aa-d0fe-a830-a41f5b465cb1@linaro.org>
 <aiwaftbattdfzjd4dr5hw62ux4spong5yjpi54b7te4ybq64ty@b5k42n7yhuck>
 <59ca80e3-7e00-ebd8-1e1f-23ef1d828b8c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59ca80e3-7e00-ebd8-1e1f-23ef1d828b8c@linaro.org>
X-IMT-Source: Extern
X-IMT-rspamd-score: 4
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.27.185117, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.27.602000
X-Sophos-SenderHistory: ip=84.184.52.128, fs=17205994, da=180771846, mc=23,
 sc=0, hc=23, sp=0, fso=17205994, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::18;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=nylar.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Aug 27, 2023 at 11:32:03AM -0700, Richard Henderson wrote:
> On 8/27/23 09:36, Bastian Koppelmann wrote:
> > On Sun, Aug 27, 2023 at 07:49:52AM -0700, Richard Henderson wrote:
> > > On 8/27/23 04:07, Bastian Koppelmann wrote:
> > > > On Sat, Aug 26, 2023 at 09:50:51PM -0700, Richard Henderson wrote:
> > > > > On 8/26/23 09:02, Bastian Koppelmann wrote:
> > > > > > +uint32_t helper_ftou(CPUTriCoreState *env, uint32_t arg)
> > > > > > +{
> > > > > > +    float32 f_arg = make_float32(arg);
> > > > > > +    uint32_t result;
> > > > > > +    int32_t flags = 0;
> > > > > > +
> > > > > > +    if (float32_is_any_nan(f_arg)) {
> > > > > > +        result = 0;
> > > > > > +        flags |= float_flag_invalid;
> > > > > > +    } else if (float32_lt_quiet(f_arg, 0, &env->fp_status)) {
> > > > > > +        result = 0;
> > > > > > +        flags = float_flag_invalid;
> > > > > > +    } else {
> > > > > > +        result = float32_to_uint32(f_arg, &env->fp_status);
> > > > > > +        flags = f_get_excp_flags(env);
> > > > > > +    }
> > > > > 
> > > > > You should allow softfloat to diagnose the special cases, and negative -> 0
> > > > > is standard behaviour.  Therefore:
> > > > 
> > > > You're right. However, there is one special case, negative -> 0 ought to raise
> > > > float_flags_invalid.
> > > 
> > > https://gitlab.com/qemu-project/qemu/-/blob/master/fpu/softfloat-parts.c.inc?ref_type=heads#L1162
> > 
> > Lets say the exponent is negative and the sign is negative, then we raise
> > float_flag_inexact and we never reach the code you mentioned here. However,
> > TriCore HW raises float_flag_invalid as well in that case. This is what I'm
> > catching with float32_lt_quiet() in the same manner as ftouz.
> 
> Hmph.  Buggy hardware.  You'd better document this special case,
> that less-than-zero is detected before rounding.

Will do. I'll do the same for ftouz.

> 
> I presume -0.0 does not raise invalid, that the bug does not extend that far?

Yes, -0.0 does not raise invalid.

Cheers,
Bastian

