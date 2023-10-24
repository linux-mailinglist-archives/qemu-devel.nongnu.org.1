Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6347D53C5
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 16:19:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvIES-0004Eu-I2; Tue, 24 Oct 2023 10:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvIEP-0004Ea-Bp
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 10:18:05 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvIEN-0006mY-Ju
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 10:18:05 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5409bc907edso1383541a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698157081; x=1698761881; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GVf5GKYEkbbWJZp67v69J5LUNAHr90Ud544ODWp+lOM=;
 b=CxGIcPUgFsooB024M654U7LavvC+YuOc6H9lHD4ln8mlN1ldO05k3plfKqfPqwBwiu
 Xl4JkUn14gu2zmttBZGfJVlOWCmV2nCKWcVF/0fiIj1DDsxf37vGtseoHXosnQW5IM1E
 oZF6KYky3UnLOD/wUBrqFgGHF9n+0ZuHIqjemiH0TtieEKhttyHiCGmFAhATTc5oxhef
 uP06qwz+dBtTR/HK9iJ64XUw3u/xVH9s/mQA/ulhMAtI9SXg4FnciJKFq9bhBJlHjsVf
 KpUedZJdnAWYkW5kWYewp4nP43SJrdhykAjQEZNuu6vsCAoT+MFt2tElaT9+zBn5/E5N
 uHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698157081; x=1698761881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GVf5GKYEkbbWJZp67v69J5LUNAHr90Ud544ODWp+lOM=;
 b=dEnxUJiJPHARbdWgAkMQU2T867L7TCglom17e9aQwCSU3O0F7AkYKgtZsa172pDOCw
 //jrjw2NLAr0oAWpx0nOf8bI8D5El22a1JtnwsfYkXqvH0+Uut0MUW3F3ZFTRtAnCFzr
 nH4lWvUtbvVazWwbdn+W9zhJfVq7D5GOBN35d18d5GG1p4v6+yyFiwQT4TZvzV0xRJ/4
 mwXCJXsE6ghwDZU224SdgDy95CRbrsWq9AvZEtz+MmZUXAz9rMRyUl8JxOG/fUnkr3gF
 sFURvFFfGOJBaDLJ+Rc9rpLNbOISZa0Vu3LE978kCneeJPHnBSdfHeBjqI5NPU/mU3iW
 PfVg==
X-Gm-Message-State: AOJu0YynUsNOGgYh8pa+AqsfrnD+v2Tu+Lb8CyMVpNG0YqDeE+25EoQV
 jpruV8Eu1KZJD/C6XIJwG/3ndHMEFpLDwtBMDz8leQ==
X-Google-Smtp-Source: AGHT+IE1/FhITH3a8Xw+tiZGnKCev1c50Thkxrwa/6W53Oog8NDw3ilD4ejfnxXvB/8dzXHH7CuycSsZoduhy7tX0NE=
X-Received: by 2002:a50:cd1b:0:b0:530:a186:f8a8 with SMTP id
 z27-20020a50cd1b000000b00530a186f8a8mr9169821edi.37.1698157080714; Tue, 24
 Oct 2023 07:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231024094351.50464-1-quic_acaggian@quicinc.com>
 <CAFEAcA86trVBDe4zJr2Zv-EgWReY2M+yvU83Kc_8nGrjP4_tJg@mail.gmail.com>
 <aaafba0f-d6dc-a280-263c-afcc6b8f7e2b@quicinc.com>
 <CAFEAcA-gi3Up=7N-Y5-RyA0bi+4UHcE=MOryhWZ2rWQk67CrjQ@mail.gmail.com>
 <e2c97f1f-6dca-fe27-debc-19a3f6dcac8a@quicinc.com>
 <CAFEAcA-zjFQMjrfPuFfA5PC-eXZmRyjtnH_Fx1t+C90ECrO_jQ@mail.gmail.com>
 <e89e48d2-f0f1-c26c-79e1-964d41e0afd1@quicinc.com>
In-Reply-To: <e89e48d2-f0f1-c26c-79e1-964d41e0afd1@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Oct 2023 15:17:49 +0100
Message-ID: <CAFEAcA-T6mt+1sJx4FTWhYc3-er+MGcqCgNC=pbNS_osU-gpjA@mail.gmail.com>
Subject: Re: [RFC] mem: Fix mem region size when is UINT64_MAX
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Burton <quic_mburton@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 24 Oct 2023 at 14:38, Antonio Caggiano
<quic_acaggian@quicinc.com> wrote:
>
> +cc Mark which has a better understanding of our use case.
>
> On 24/10/2023 15:21, Peter Maydell wrote:
> > On Tue, 24 Oct 2023 at 13:31, Antonio Caggiano
> > <quic_acaggian@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 24/10/2023 14:00, Peter Maydell wrote:
> >>> On Tue, 24 Oct 2023 at 11:49, Antonio Caggiano
> >>> <quic_acaggian@quicinc.com> wrote:
> >>> Given that we don't run into this upstream, this leaves me
> >>> suspecting that the underlying problem is that a memory
> >>> region this big shouldn't be being registered to KVM in the
> >>> first place. Certainly the gpex PCI controller works fine
> >>> on the arm64 virt board under KVM, so maybe your board code
> >>> is doing something odd when it wires it up?
> >
> >> I think so, we use a MMIO system_memory, effectively using
> >> memory_region_init_io() instead of memory_region_init(). This is for
> >> registering our callbacks with a MemoryRegionOps.
> >>
> >> So, for a MMIO memory type, UINT64_MAX means "real" size rather than
> >> "all of the 64 bit address space"?
> >
> > For a memory region, in the creation APIs that take a uint64_t
> > size argument:
> >   * size 0 is (I think) not valid
> >   * 1..UINT64_MAX-1 mean "size is that many bytes"
> >   * UINT64_MAX means "size is 2^64 bytes"
> >   * there is no way to ask for (2^64)-1 bytes
> >
> > I am confused about why you say your system_memory is an
> > MMIO region with callbacks, though. The system_memory MR
> > is expected to be a pure "container" region, which has
> > no callbacks and simply is a place where we add other
> > subregions (which might be RAM, or IO, or whatever).
> >
>
> We use an MMIO system memory for our ops, which capture memory accesses
> and handle some of them, even though no memory region is actually
> backing the addresses.
>
> Does that means we are violating QEMU's expectations by modifing that
> from "container" to "MMIO"? This issue is just one consequence of such
> violation and there might be more potentially?

I think that's one of those things which in theory might be supposed
to work but which in practice might run into trouble, because nobody's
ever done it before. In particular it seems like it's not currently
compatible with KVM...

I can think of a few things it might be interesting to try as
workarounds:
 * leave the system_memory as a container, and fill it with
   two MMIO MemoryRegions at very-low-priority that split the
   2^64 space in half, so that neither of them runs into the
   "too big" issue
 * restrict the size to the guest cpu physical address space
   size (again, avoiding the "too big" problem)

In an ideal world the code in kvm_region_commit() could be
made to handle 2^64-sized MRs, at least for MMIO MRs (where
the eventual behaviour in kvm_set_phys_ram() is "nothing to
do"). 2^64-sized memory-backed MRs would need handling in
the kernel, but they're not possible since you can't get
that much host memory to start with :-)

-- PMM

