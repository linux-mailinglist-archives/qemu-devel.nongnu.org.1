Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E040579844D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeX48-00024S-Se; Fri, 08 Sep 2023 04:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qeX45-00023l-RF
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:09 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qeX42-0003rO-DJ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fef56f7248so19074065e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 01:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694162523; x=1694767323; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UjxBF6jjkhMf/hFHeZyE6a+2YSUIQA0tq7o+K5UPXKA=;
 b=HiWFia2PbrEF4uCXF38jw4sZZ2Cq/d4cleTpbSQWp15BIKg2NipVc3eF0XFAHwu717
 PhNs/RBEuaY4W/qQ1R+zbKWcWsUXVeoTcmpAxd+kr2nTXi7T44lOBvUEoMHWDf4/zG+A
 CfCHTaBiiKnXcBIGf67TEnkHsojx0neqM4TDAsABPbSw1jOSvccE2YwQZW+j9Y3C3/LX
 qiYFvRS5LCUrNpKlElM2PosuDeFjbjpBaGQ4vqVDxr7ramrxz4LPevTO22SsRHlTAMUq
 B3W5F8Xn4qS7vqDEm8+E4DR1LP1s4zLv0Kknbx0uo474xE39OW2QPd8zt9wsEVklOk86
 rFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694162523; x=1694767323;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UjxBF6jjkhMf/hFHeZyE6a+2YSUIQA0tq7o+K5UPXKA=;
 b=CR5XOxi3prIcTgGLLU+Gpt8V7Y1V7EAhKEl9ux0D0NirEi2V3iu+Wv2pcXh8oNU6xc
 sSEbQpjwHi70nJsiVvqyJxBviMkCiJ2uLqI7ZeRfQUDgISkrhCUI0XqYiEt3D6mRKURd
 jtwYdrmyj+eQCiT3tPDrz26mxxXn+hgZ7Fod2oTQXnXhVXdZAhsHlbFifW7JBMlfYnLE
 GPp+szYX2EIqtGo3Idc2eUUr0o1CjZCt88xKRrUI3v/slBIWPdJspUEzoxtfbbw1pYoi
 xYjJj9VGdDQCYIjsBcdpYZshm98pp44EJ0z/s6h2kdDYAFBEipuorysWweckbKh+DIAY
 wc6A==
X-Gm-Message-State: AOJu0Ywix+E/fertfYlcz8s2CCzXPGSI3tnJ0/zva3aOFFm79Fsq9qkC
 fxeUFudK+jiQQtZkotxr2O52wA==
X-Google-Smtp-Source: AGHT+IHTuLXLZHfe27K1s07haiW48sUeJVzNAV9aTtn75hkax4ayDfyRJnBrtKm1cVpQYe55sldW+w==
X-Received: by 2002:a05:600c:5120:b0:402:f517:9c07 with SMTP id
 o32-20020a05600c512000b00402f5179c07mr1332629wms.0.1694162523051; 
 Fri, 08 Sep 2023 01:42:03 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a5d408c000000b003142ea7a661sm1500224wrp.21.2023.09.08.01.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 01:42:02 -0700 (PDT)
Date: Fri, 8 Sep 2023 10:42:01 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Colton Lewis <coltonlewis@google.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 kvm@vger.kernel.org, Andrew Jones <andrew.jones@linux.dev>,
 qemu-trivial@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH] arm64: Restore trapless ptimer access
Message-ID: <20230908-c42425ed51b75d247052cfde@orel>
References: <20230831190052.129045-1-coltonlewis@google.com>
 <7d3615d0-d501-a28c-eebc-b3f7a599fc23@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d3615d0-d501-a28c-eebc-b3f7a599fc23@tls.msk.ru>
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 07, 2023 at 10:31:20PM +0300, Michael Tokarev wrote:
> 31.08.2023 22:00, Colton Lewis wrote:
> > Due to recent KVM changes, QEMU is setting a ptimer offset resulting
> > in unintended trap and emulate access and a consequent performance
> > hit. Filter out the PTIMER_CNT register to restore trapless ptimer
> > access.
> > 
> > Quoting Andrew Jones:
> > 
> > Simply reading the CNT register and writing back the same value is
> > enough to set an offset, since the timer will have certainly moved
> > past whatever value was read by the time it's written.  QEMU
> > frequently saves and restores all registers in the get-reg-list array,
> > unless they've been explicitly filtered out (with Linux commit
> > 680232a94c12, KVM_REG_ARM_PTIMER_CNT is now in the array). So, to
> > restore trapless ptimer accesses, we need a QEMU patch to filter out
> > the register.
> > 
> > See
> > https://lore.kernel.org/kvmarm/gsntttsonus5.fsf@coltonlewis-kvm.c.googlers.com/T/#m0770023762a821db2a3f0dd0a7dc6aa54e0d0da9
> > for additional context.
> > 
> > Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
> > ---
> >   target/arm/kvm64.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > index 4d904a1d11..2dd46e0a99 100644
> > --- a/target/arm/kvm64.c
> > +++ b/target/arm/kvm64.c
> > @@ -672,6 +672,7 @@ typedef struct CPRegStateLevel {
> >    */
> >   static const CPRegStateLevel non_runtime_cpregs[] = {
> >       { KVM_REG_ARM_TIMER_CNT, KVM_PUT_FULL_STATE },
> > +    { KVM_REG_ARM_PTIMER_CNT, KVM_PUT_FULL_STATE },
> >   };
> >   int kvm_arm_cpreg_level(uint64_t regidx)
> 
> While this patch itself is one-liner and trivial and all, I'd rather
> not apply this to the trivial-patches tree, - it requires a little
> bit more than trivial expertise in this area.
> 
> So basically, ping for qemu-arm@ ? :)
>

I agree that qemu-trivial should not have been CC'ed for this patch.

Thanks,
drew

