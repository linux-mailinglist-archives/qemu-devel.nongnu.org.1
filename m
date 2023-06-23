Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A725373BA97
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 16:49:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCi5y-0002Jp-OT; Fri, 23 Jun 2023 10:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCi5w-0002JN-AK
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 10:49:04 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCi5u-0006EZ-LC
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 10:49:04 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51bea30ccbcso734618a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 07:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687531741; x=1690123741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33lRUmbAB6ZBFbg+mpHxAIUCBa32sX9XnJmwcXWIF4A=;
 b=EtthK2P6AdWa3CylukHDlzkb921ywnop2rlRMkQhGJJJnq2SGevmuJX/L55nmJv/kj
 /dASmPb2LOUgof3UmETwbzLI0L6HwZ8JPVysemgOVVrbOom4MMC1TZxIjL0FskQGJFlp
 b5UNchFG51p31QpZsMNEcKfYV0jkl+jUVXsZSuUEaYkDRMLcWbrI1nSeKu+5XZCCk+fF
 rhrmNjhiYukNmAGNbdK6M9FtKv5+ZBRjioYSDjuwxH2pgkImr10cFrFvEwS7hqbcf4cN
 H6oc60tCw5JoGDuHRTaKugmNGCbZmfjYM+AVTFGmJO5C289+JxvPa4c1W1Jmr7yIar6L
 nvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687531741; x=1690123741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33lRUmbAB6ZBFbg+mpHxAIUCBa32sX9XnJmwcXWIF4A=;
 b=gBPrpzgjPUN0vtB2C+tQDMWXdzEFpCkRH41KFa7ditLS2iE5VxPQ9/7kGpIOKp9//4
 iJKYB0N6jG4MG2t15+jsc0lvweoX28JTAMgw32f51xgsfecKDZk4tHMb8uphOfhwsZls
 Ytp65qN4wykkrRkVEb8WKKuD0MpZGCcDEmfv4vPyJ4U2nIXiUHr+C7FRNvfGLIlDR3f8
 w/vrydTa1iZgtkyPoPluH58dLTdXZrJAWR7SDyKLkFKrfPNFsbsMlM3Y5eamdm15AIi7
 opK6Ruo4gb9R/wr04pqae3VmSWtJP8xTqZbYYCJwUyCAYnnmtQid0WqhO2Rnd44zrMYH
 a0Kw==
X-Gm-Message-State: AC+VfDwPB/14Tfb7/uK/tR07YnMc/p6y+do+VvbO8xTdqdh9RLXRsoqU
 8iYhzmPyMD/VQzOgr3Pj0sJEyyIB9celWW7Fz46+jAim30JdlCZZ
X-Google-Smtp-Source: ACHHUZ7Z8jOiXwDuDUlY19wLITipF1zZja/iO2/HW+hyNnhOiJj69UcVi6Vw6FXWgvL1VrBW0+/OgAIzacOaqM5Q7cw=
X-Received: by 2002:a05:6402:31f3:b0:51b:cd57:7731 with SMTP id
 dy19-20020a05640231f300b0051bcd577731mr8394619edb.20.1687531740733; Fri, 23
 Jun 2023 07:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230302123029.153265-1-pbonzini@redhat.com>
 <20230302123029.153265-57-pbonzini@redhat.com>
In-Reply-To: <20230302123029.153265-57-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2023 15:48:49 +0100
Message-ID: <CAFEAcA9KXrRscf9QK2Z5Say91KDm7xRLMZGh4A1rQ1+0TCHtcA@mail.gmail.com>
Subject: Re: [PULL 56/62] hw/xen: Support GSI mapping to PIRQ
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw@amazon.co.uk>,
 Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 2 Mar 2023 at 12:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> If I advertise XENFEAT_hvm_pirqs then a guest now boots successfully as
> long as I tell it 'pci=3Dnomsi'.
>
> [root@localhost ~]# cat /proc/interrupts
>            CPU0
>   0:         52   IO-APIC   2-edge      timer
>   1:         16  xen-pirq   1-ioapic-edge  i8042
>   4:       1534  xen-pirq   4-ioapic-edge  ttyS0
>   8:          1  xen-pirq   8-ioapic-edge  rtc0
>   9:          0  xen-pirq   9-ioapic-level  acpi
>  11:       5648  xen-pirq  11-ioapic-level  ahci[0000:00:04.0]
>  12:        257  xen-pirq  12-ioapic-edge  i8042
> ...
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Paul Durrant <paul@xen.org>

Hi; Coverity points out an off-by-one error in this code
(CID 1508128):

> @@ -148,6 +148,9 @@ struct XenEvtchnState {
>      /* GSI =E2=86=92 PIRQ mapping (serialized) */
>      uint16_t gsi_pirq[IOAPIC_NUM_PINS];

The gsi_pirq[] array has IOAPIC_NUM_PINS elements...

> +bool xen_evtchn_set_gsi(int gsi, int level)
> +{
> +    XenEvtchnState *s =3D xen_evtchn_singleton;
> +    int pirq;
> +
> +    assert(qemu_mutex_iothread_locked());
> +
> +    if (!s || gsi < 0 || gsi > IOAPIC_NUM_PINS) {

...but here our guard on gsi is off-by-one, and
allows gsi =3D=3D IOAPIC_NUM_PINS through...

> +        return false;
> +    }
> +
> +    /*
> +     * Check that that it *isn't* the event channel GSI, and thus
> +     * that we are not recursing and it's safe to take s->port_lock.
> +     *
> +     * Locking aside, it's perfectly sane to bail out early for that
> +     * special case, as it would make no sense for the event channel
> +     * GSI to be routed back to event channels, when the delivery
> +     * method is to raise the GSI... that recursion wouldn't *just*
> +     * be a locking issue.
> +     */
> +    if (gsi && gsi =3D=3D s->callback_gsi) {
> +        return false;
> +    }
> +
> +    QEMU_LOCK_GUARD(&s->port_lock);
> +
> +    pirq =3D s->gsi_pirq[gsi];

...and we will reference off the end of the gsi_pirq[] array here.

> +    if (!pirq) {
> +        return false;
> +    }

Presumably the guard should be 'gsi >=3D IOAPIC_NUM_PINS' ?

thanks
-- PMM

