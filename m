Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEED756AFE
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 19:53:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLSO5-0002KV-QE; Mon, 17 Jul 2023 13:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLSO4-0002K8-1b
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 13:51:56 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLSO1-0004Px-ES
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 13:51:55 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5217ad95029so3287369a12.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689616311; x=1692208311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zN+VO/fUWek6CwK/1vfciKnmrFOisiX7toF7X5ar/m8=;
 b=qytZUyyTlDLRIBePdwm9eQYW0F6eo0RjaYNQNxCRQPfJBF7mjGXcBxxTFJJKICvB5x
 mKek5Wp2DpujRsLYwBMOll7NYVVJCLfSTzHOcn1iY5CVzfYIlcwlBBwQHPNQpe+RdhzL
 kftN66XqWSgkdWhjw+B7jMD1wKRpv7sGvRI+xRZRBz1WtxAqXjj3DiTym/opNI8SiPh6
 GzGBFFCBrQDMZGWMuZrWNklAY491NVT1ZCc/zv9PdMg6aQVrR8OpkFBtzI85BiKajSQj
 cWPTYzZsI4djEDkihujokvjlJxeHxXsawgfRgkv/GPdLSPfZAgbT8x6/CxjuHKMkmUWN
 SEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689616311; x=1692208311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zN+VO/fUWek6CwK/1vfciKnmrFOisiX7toF7X5ar/m8=;
 b=Vh36WjBf4v/1vn02i8M2QQYuVaSYPz+MvYnUZD15KOUGNO0KAPs8kBHSd8e+b0oov1
 R/n+GGlYI9u8B63nrCVgjHVt0v0J72NM2KH4y01obyiVfxhdAOwcHHbGlEN3ao2mzHzK
 Qkau8tPQhntEq7pVzpu+tkRxkWMabWzizOha+4L4DjmVaolW8fkXbvMhBcLZVrv1LclX
 tVFkghiBQp7kPUT5ospa6koFdFAudIJ5eNeSNk76eR/s3Qn5fs/SoXxzCkyYhQUaktsj
 6z5czNr9wSOVEeJ5a1NOV8qsj2rQ6Ywn6GQthPWNWsJNjbHFbyt0FVK3yHlj8j8CFtyc
 2UQg==
X-Gm-Message-State: ABy/qLZ9sYDRpax2jMSxLOp1aD26r2F0uavDPbwep3oFXMUMHOmfdMzn
 IenhRvJhgyi8j7fydHaa37tyzck9R9ffhNvB3hZMyw==
X-Google-Smtp-Source: APBJJlGQ/979iQcy50LrxrVgYICHpKgiGx01pfpFqJ8Khikdno4ufDfcUF1gcwlb0OZ3KBt2qfYAfgFC26YB8NysSlA=
X-Received: by 2002:a05:6402:503:b0:518:721e:f594 with SMTP id
 m3-20020a056402050300b00518721ef594mr12220674edv.37.1689616310780; Mon, 17
 Jul 2023 10:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230302123029.153265-1-pbonzini@redhat.com>
 <20230302123029.153265-57-pbonzini@redhat.com>
 <CAFEAcA9KXrRscf9QK2Z5Say91KDm7xRLMZGh4A1rQ1+0TCHtcA@mail.gmail.com>
 <4eb4c9868798cbfd2819c317a80037f4820b0502.camel@amazon.co.uk>
In-Reply-To: <4eb4c9868798cbfd2819c317a80037f4820b0502.camel@amazon.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2023 18:51:39 +0100
Message-ID: <CAFEAcA8MwTGEMYemuSy3xSQuy_we7XWVHPqD+1epTphu1R0prA@mail.gmail.com>
Subject: Re: [PATCH] i386/xen: fix off-by-one in xen_evtchn_set_gsi()
To: "Woodhouse, David" <dwmw@amazon.co.uk>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "paul@xen.org" <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 4 Jul 2023 at 16:13, Woodhouse, David <dwmw@amazon.co.uk> wrote:
>
> Coverity points out (CID 1508128) a bounds checking error. We need to check
> for gsi >= IOAPIC_NUM_PINS, not just greater-than.
>
> Also fix up an assert() that has the same problem, that Coverity didn't see.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  hw/i386/kvm/xen_evtchn.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
> index 3d810dbd59..0e9c108614 100644
> --- a/hw/i386/kvm/xen_evtchn.c
> +++ b/hw/i386/kvm/xen_evtchn.c
> @@ -1587,7 +1587,7 @@ static int allocate_pirq(XenEvtchnState *s, int type, int gsi)
>   found:
>      pirq_inuse_word(s, pirq) |= pirq_inuse_bit(pirq);
>      if (gsi >= 0) {
> -        assert(gsi <= IOAPIC_NUM_PINS);
> +        assert(gsi < IOAPIC_NUM_PINS);
>          s->gsi_pirq[gsi] = pirq;
>      }
>      s->pirq[pirq].gsi = gsi;
> @@ -1601,7 +1601,7 @@ bool xen_evtchn_set_gsi(int gsi, int level)
>
>      assert(qemu_mutex_iothread_locked());
>
> -    if (!s || gsi < 0 || gsi > IOAPIC_NUM_PINS) {
> +    if (!s || gsi < 0 || gsi >= IOAPIC_NUM_PINS) {
>          return false;
>      }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

