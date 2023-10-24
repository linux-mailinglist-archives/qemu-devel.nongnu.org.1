Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 859E87D51BB
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 15:26:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvHMm-0005ra-FL; Tue, 24 Oct 2023 09:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvHMM-0005WF-0G
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:22:15 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvHMJ-00034z-9o
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:22:13 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53e04b17132so6925803a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 06:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698153729; x=1698758529; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ltC+SFNsQV58H2/zQWiZffmRWkX7m7WSExit5sl3mHg=;
 b=RfolXM/4rB0kxWM+hdA+DlMcuoDmd8/+kui1D8n4pBFtTsMJYea3+yfY8NiVo1yxOe
 ooakmxxd3IS0C/3rtqNMvyBRLwgFOsP7TPKfxO6o5WWfR451+9SxtSzfodjWmfba9HZh
 M0tEG4AUuZt/sUsC+Tmn8pzmNpv/30varqWc9iFAYvBolYUEKET+BurKm+fVuxCRZ5Jv
 qZk6kP/svaZq+ZJXsFX/Xm/j3cfgDBdkjKa/Mt9L01m1L1QgPwsFN74vt+AuewF2jnyd
 sOZFAnQcqKGKrG8dMGDs3eh7myyofPuQUkqtLWWqukrPx7RDmqAu/gJPEhXKvUOoKuY0
 dMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698153729; x=1698758529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ltC+SFNsQV58H2/zQWiZffmRWkX7m7WSExit5sl3mHg=;
 b=Z5ceGoryEim3cqR/LFSdV8sUDoXz9LOrcIJhDJihHB4FxLFECZ2N6Jm+0mTm+0O2cm
 3jalze/IKJCr3KS6SvJRZzdyfHC4pezSNn1qMzTiY3oTHawQxnryXggpfo/RpcV+bVfF
 5XUakIvJijXiETBSN47tAlPX6EcCuPTdICZoZx1K8p4KrjBNRCvaa0CXZ5ux7J7m9blT
 9evSjiPrBNu2eoukC4l8BfLDA0TGjzVBVEGNkHRrwitsNEvf55vzj9cHp6RRMfMoyw+q
 v28obaJWgTmVhUWHiDN79HP0957LMydAvoKEveJJF0wHHxNcGrbY/vvKksHJ5B6Essci
 2n2w==
X-Gm-Message-State: AOJu0Yz8ynqviXfV+6joV1Fw4b4MeNW0dzZiSSxZjMEx0s8lv5ctGTuq
 afcsOjX7LptCCPZeLjjq+LpA/ZyqhnFsR764eqap+g==
X-Google-Smtp-Source: AGHT+IGJSP3PIG1LbqzA4rCDC/ls6Mpj1C3ucmcF+LPbta2covprbGgT7tfiGg3F8teWYo4Y8aPsUO4APtLmr79kAgQ=
X-Received: by 2002:a50:c35c:0:b0:53d:b6ac:5f64 with SMTP id
 q28-20020a50c35c000000b0053db6ac5f64mr8820882edb.18.1698153729302; Tue, 24
 Oct 2023 06:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231024094351.50464-1-quic_acaggian@quicinc.com>
 <CAFEAcA86trVBDe4zJr2Zv-EgWReY2M+yvU83Kc_8nGrjP4_tJg@mail.gmail.com>
 <aaafba0f-d6dc-a280-263c-afcc6b8f7e2b@quicinc.com>
 <CAFEAcA-gi3Up=7N-Y5-RyA0bi+4UHcE=MOryhWZ2rWQk67CrjQ@mail.gmail.com>
 <e2c97f1f-6dca-fe27-debc-19a3f6dcac8a@quicinc.com>
In-Reply-To: <e2c97f1f-6dca-fe27-debc-19a3f6dcac8a@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Oct 2023 14:21:57 +0100
Message-ID: <CAFEAcA-zjFQMjrfPuFfA5PC-eXZmRyjtnH_Fx1t+C90ECrO_jQ@mail.gmail.com>
Subject: Re: [RFC] mem: Fix mem region size when is UINT64_MAX
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 24 Oct 2023 at 13:31, Antonio Caggiano
<quic_acaggian@quicinc.com> wrote:
>
>
>
> On 24/10/2023 14:00, Peter Maydell wrote:
> > On Tue, 24 Oct 2023 at 11:49, Antonio Caggiano
> > <quic_acaggian@quicinc.com> wrote:
> > Given that we don't run into this upstream, this leaves me
> > suspecting that the underlying problem is that a memory
> > region this big shouldn't be being registered to KVM in the
> > first place. Certainly the gpex PCI controller works fine
> > on the arm64 virt board under KVM, so maybe your board code
> > is doing something odd when it wires it up?

> I think so, we use a MMIO system_memory, effectively using
> memory_region_init_io() instead of memory_region_init(). This is for
> registering our callbacks with a MemoryRegionOps.
>
> So, for a MMIO memory type, UINT64_MAX means "real" size rather than
> "all of the 64 bit address space"?

For a memory region, in the creation APIs that take a uint64_t
size argument:
 * size 0 is (I think) not valid
 * 1..UINT64_MAX-1 mean "size is that many bytes"
 * UINT64_MAX means "size is 2^64 bytes"
 * there is no way to ask for (2^64)-1 bytes

I am confused about why you say your system_memory is an
MMIO region with callbacks, though. The system_memory MR
is expected to be a pure "container" region, which has
no callbacks and simply is a place where we add other
subregions (which might be RAM, or IO, or whatever).

thanks
-- PMM

