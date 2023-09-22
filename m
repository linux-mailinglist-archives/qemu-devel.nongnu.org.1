Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFAB7AB006
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 12:55:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjdnt-0008Hg-Or; Fri, 22 Sep 2023 06:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjdnr-0008H2-9l
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:54:31 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjdnp-0005Eq-Kt
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:54:31 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5031426b626so3140813e87.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695380068; x=1695984868; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oaPQ7MmR1Vr1ITNRNCWHhJqSeR8sTNfTIlLBgvGcm1Y=;
 b=I/9Ia5jtvMZJtFIZMNehFHj4UGbY4zm21OwyTsi/pGKikiO4QmJ1WNs434Kc6XwsYw
 BFI7OWt0x2+HkJTKayYXbAb+lFCVh6/mJWSbNiDEXYfLoNjbDMBifFaMJ7oayHomN0jF
 QJ87zi0+OIEQgoNB54B3YiV6KOer3C7SvQQp8Dh8zkgU7nDq2eZr7Gq2H99JUsx5TCZk
 Ja2dhySlL6R3ggJhDXJ/ITsXTXb5FVBJfJ3sGBfmYVDmr44ovw19BWPIxzR0c/6fbFy/
 5NR+vXxZ82PodPfDMNstVhAz42h20Z0GI9jvBlzL4nPakKz87NPxLg5dmhT2Cne5FHHO
 wXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695380068; x=1695984868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oaPQ7MmR1Vr1ITNRNCWHhJqSeR8sTNfTIlLBgvGcm1Y=;
 b=b+dm9cn0/YD1UFLGoln1UKBwtX+/hm94eKL/xgSFhIdvDoKHBpYkSpZ+SKdyCCyhGh
 +kh/WSR2udoGSd1n1VS6AbmwlA/UgCGuRIcvptQnhv27KzMdSsmHFLtsyHv90F8Lleam
 WUdYddw/KMDeygug/3xuDz2yjBkdA546vxAUIIWLXZSkfnSplKoEUtMmpKRqDCP+8NBw
 g5ag1wQVttOrrZQ7zmhVWkNu+Q0HnNcAFCWxbhaX3DDiU1ZZ05s8PLFcAeboA8Tm1Or1
 ZZjcYvq2BjL1zV9y9nfr0pNF6ztS10uG073nqWUQInXGnIRmHsxVrZtyRAmRlbgjt4I1
 /QDw==
X-Gm-Message-State: AOJu0Yxs4R9str5rlR3AVpgjpkp8ii6sAS5NcEfM2gFggoXLfjeGk8GU
 OAREJYYnWAXJ/oNXDl0pOnLSpyDt0wWk5CBAPfh/UQ==
X-Google-Smtp-Source: AGHT+IHx0xdRZyxIrExRavod1Vm7q9m1w2EZmf/4tVKw8VVdVeY4o5Kcq6mpZp0xjBAQEKhBA6FwqeiuL4jR6uBRmHI=
X-Received: by 2002:a05:6512:3a8e:b0:4fe:1681:9377 with SMTP id
 q14-20020a0565123a8e00b004fe16819377mr9006904lfu.44.1695380066321; Fri, 22
 Sep 2023 03:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230914145705.1648377-1-peter.maydell@linaro.org>
 <20230914145705.1648377-4-peter.maydell@linaro.org>
 <ZQ1tvgUOLga21EkF@google.com>
In-Reply-To: <ZQ1tvgUOLga21EkF@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2023 11:54:06 +0100
Message-ID: <CAFEAcA-uXuU9KGjwrMnppkpnED1XHTsWrz=0gSYvjfFNNpf1eg@mail.gmail.com>
Subject: Re: [PATCH 3/3] hw/arm/smmuv3: Advertise SMMUv3.1-XNX feature
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 22 Sept 2023 at 11:34, Mostafa Saleh <smostafa@google.com> wrote:
>
> Hi Peter,
>
> On Thu, Sep 14, 2023 at 03:57:05PM +0100, Peter Maydell wrote:
> > The SMMUv3.1-XNX feature is mandatory for an SMMUv3.1 if S2P is
> > supported, so we should theoretically have implemented it as part of
> > the recent S2P work.  Fortunately, for us the implementation is a
> > no-op.
> >
> > This feature is about interpretation of the stage 2 page table
> > descriptor XN bits, which control execute permissions.
> >
> > For QEMU, the permission bits passed to an IOMMU (via MemTxAttrs and
> > IOMMUAccessFlags) only indicate read and write; we do not distinguish
> > data reads from instruction reads outside the CPU proper.  In the
> > SMMU architecture's terms, our interconnect between the client device
> > and the SMMU doesn't have the ability to convey the INST attribute,
> > and we therefore use the default value of "data" for this attribute.
> >
> > We also do not support the bits in the Stream Table Entry that can
> > override the on-the-bus transaction attribute permissions (we do not
> > set SMMU_IDR1.ATTR_PERMS_OVR=1).
> >
> > These two things together mean that for our implementation, it never
> > has to deal with transactions with the INST attribute, and so it can
> > correctly ignore the XN bits entirely.  So we already implement
> > FEAT_XNX's "XN field is now 2 bits, not 1" behaviour to the extent
> > that we need to.
> >
> > Advertise the presence of the feature in SMMU_IDR3.XNX.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  hw/arm/smmuv3.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index 94d388fc950..d9e639f7c41 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -279,6 +279,7 @@ static void smmuv3_init_regs(SMMUv3State *s)
> >      s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
> >
> >      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, HAD, 1);
> > +    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
> May be this can be guarded when S2P is present? according the UM
> "In SMMUv3.1 and later, support for this feature is mandatory when
> stage 2 is supported, that is when SMMU_IDR0.S2P == 1."
> So I am not sure what it would mean for XNX and S1P only.

Mmm, I don't suppose it would confuse any guest code, but
it's probably safest to put in the if():

   if (FIELD_EX32(s->idr[0], IDR0, S2P) {
       /* XNX is a stage-2-specific feature */
       s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
   }

thanks
-- PMM

