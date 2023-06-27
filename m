Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC87E73FBEB
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:23:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7jK-0002JN-Kr; Tue, 27 Jun 2023 08:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE7jI-0002JC-B0
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:23:32 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE7jG-00042M-ME
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:23:32 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51d9865b8a2so2700717a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687868608; x=1690460608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1C4oWHOD8AhmznzOSZuhZbTEeIJtvw25tsY51Ub/eSE=;
 b=tfx+HWAnTAyg924AACjzgVguw6JzW1VMT9QUJVUVVB1M/AscX7wTplx7m1PUhuSTBM
 h2kgvEHfjXVEWakQitz8u3IcFbxmb5os47rcOh379SR4MNs67nlVoqFwT4/Q9FEW7M3r
 dqkyO4hj/+fGCNxXVzVQ8u80x3Kes+2EDut6UMIolkjmRyXmgrwAaMDgREM8VVCpwjtm
 4cfW/CcG74eiLqTiLZiEvfrli3UqszSM7GOSqzF4PO0SLMCTkis0djcuP2mpr8k7CnhG
 grEE/85XdMvGb6ZdfMvCINUkXCGcfFuHjddBuaf7J2FsO9CK9eTByk0pTJFl6NVflU96
 Anuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687868608; x=1690460608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1C4oWHOD8AhmznzOSZuhZbTEeIJtvw25tsY51Ub/eSE=;
 b=V+Y9TbcCqMJb6EnszBUTMWOR24LhJxJ53C5ZylReArXcOYci2+xuiFQvuzi5a0NAW5
 XksoZPpuyn2PnZ84SoLuK83nyHH4ThufFFJGw1N5t1wiiKYNSptiKWEezN2UjzyxFHzn
 65Odq6mtpYilul7QWUXKMSpROrb/NIDzjqkxA37itFeek5tKxyk29MbaRwKwQbyucLjJ
 aaOcIPjMxXqhCXawA+a44jrzF2SqWO1TFuo76Rotgpl9UxxWGI6krMZmtyIa/RLKcQV1
 p6jVFuH9cScGbddjupYMzjRHrRDjGPIAjG4ohk6IUcN9lLv5LKkV1HsD+Gk1XjS1YVh0
 1Liw==
X-Gm-Message-State: AC+VfDxXgSIE9tlxA7QVj9ItA+icnVZgmJ89ywe+r20BVvg5mNaM4Sa+
 FB+h+5vPmzt7xYFwdVKPyDlTlivnEDQs1wl/BGSHAg==
X-Google-Smtp-Source: ACHHUZ77HmhAhUmlm4w0U+UxUMdEkLZsGfnHH5VMqfybKVxm7qSJfQLUpHwd1gTdA0bI4yPZeMk1WY2Lc17OlwELfqc=
X-Received: by 2002:a05:6402:14c1:b0:51a:3760:b4c8 with SMTP id
 f1-20020a05640214c100b0051a3760b4c8mr21188766edx.14.1687868608676; Tue, 27
 Jun 2023 05:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230228093619.342575-1-eric.auger@redhat.com>
 <27fd657b-02e7-658c-4cc4-07a6c374a1b9@redhat.com>
In-Reply-To: <27fd657b-02e7-658c-4cc4-07a6c374a1b9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 13:23:17 +0100
Message-ID: <CAFEAcA_y2WHGU8xQ0Tw-UfdXF-FPbAV=mHA0vHYzoSz66VBoJQ@mail.gmail.com>
Subject: Re: [PATCH v3] target/arm: Add raw_writes ops for register whose
 write induce TLB maintenance
To: eric.auger@redhat.com
Cc: eric.auger.pro@gmail.com, richard.henderson@linaro.org, 
 pbonzini@redhat.com, qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 23 Jun 2023 at 17:43, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Peter,
>
> On 2/28/23 10:36, Eric Auger wrote:
> > Some registers whose 'cooked' writefns induce TLB maintenance do
> > not have raw_writefn ops defined. If only the writefn ops is set
> > (ie. no raw_writefn is provided), it is assumed the cooked also
> > work as the raw one. For those registers it is not obvious the
> > tlb_flush works on KVM mode so better/safer setting the raw write.
> >
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>
> If I am not wrong this patch fell into the cracks. Is it in a decent
> state now?

Oops, sorry about that. Yes, I think v3 looks good; I've
applied it to target-arm.next.

thanks
-- PMM

