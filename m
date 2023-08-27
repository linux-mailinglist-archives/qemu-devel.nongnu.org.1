Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D83789BB0
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 09:11:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qa9uM-0000lV-Qh; Sun, 27 Aug 2023 03:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qa9uD-0000lD-D7
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 03:09:53 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qa9uA-0003Vu-1w
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 03:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rr/qfc9Tg+PQhoqoWZC+1s9H+//27yQPrWAI7kAd/CE=; b=FxyhdT/4h8VOMWDgWvTLQVwNDJ
 uQt942I7j4ijfog3n6bMytPLgn3GbWrqqsDxmIk47BJ2V2Rno53FVTAjksAnkT8YyaOm3PfPGriel
 YWb6kkuxrU/uGaFxy2DnsRQpAUVBwuFV3fcUUUMDUa1Au4gCfRp395SatSF0rgE/17YU=;
Date: Sun, 27 Aug 2023 09:09:42 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, anton.kochkov@proton.me
Subject: Re: [PATCH 05/10] target/tricore: Implement ftohp insn
Message-ID: <z2hqeuxwnmwuc7pxoogvxghk2ngs2oqdpms4n6iiqxwtpspsc6@qz6iu56qxv2d>
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
 <20230826160242.312052-6-kbastian@mail.uni-paderborn.de>
 <5598bd01-6d2e-5661-8cb5-aa5a49b22ffd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5598bd01-6d2e-5661-8cb5-aa5a49b22ffd@linaro.org>
X-IMT-Source: Extern
X-IMT-rspamd-score: 4
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.27.70017, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.20.602000
X-Sophos-SenderHistory: ip=84.184.52.128, fs=17163396, da=180729248, mc=21,
 sc=0, hc=21, sp=0, fso=17163396, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::15;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=shirlock.uni-paderborn.de
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

On Sat, Aug 26, 2023 at 09:55:05PM -0700, Richard Henderson wrote:
> On 8/26/23 09:02, Bastian Koppelmann wrote:
> > +uint32_t helper_ftohp(CPUTriCoreState *env, uint32_t arg)
> > +{
> > +    float32 f_arg = make_float32(arg);
> > +    uint32_t result = 0;
> > +    int32_t flags = 0;
> > +
> > +    if (float32_is_infinity(f_arg)) {
> > +        if (float32_is_neg(f_arg)) {
> > +            return  HP_NEG_INFINITY;
> > +        } else {
> > +            return  HP_POS_INFINITY;
> > +        }
> > +    } else if (float32_is_any_nan(f_arg)) {
> > +        if (float32_is_signaling_nan(f_arg, &env->fp_status)) {
> > +            flags |= float_flag_invalid;
> > +        }
> > +        result = float16_set_sign(result, arg >> 31);
> > +        result = deposit32(result, 10, 5, 0x1f);
> > +        result = deposit32(result, 8, 2, extract32(arg, 21, 2));
> > +        result = deposit32(result, 0, 8, extract32(arg, 0, 8));
> > +        if (extract32(result, 0, 10) == 0) {
> > +            result |= (1 << 8);
> > +        }
> > +    } else {
> > +        set_flush_to_zero(0, &env->fp_status);
> > +        result = float32_to_float16(f_arg, true, &env->fp_status);
> > +        set_flush_to_zero(1, &env->fp_status);
> > +        flags = f_get_excp_flags(env);
> > +    }
> 
> All of this is standard behaviour.  All you need is the final else case.

Unfortunately not quite. For NANs the top 2 and lower 8 output mantissa bits need to be
set to the top 2 and lower 8 input mantissa bits respectively. This behaviour is
unique to ftohp and hptof, so I don't think we should specialize it in
parts64_default_nan().

Cheers,
Bastian

