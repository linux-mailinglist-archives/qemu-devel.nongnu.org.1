Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F708188C2
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 14:38:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFaHL-0004Pc-Fj; Tue, 19 Dec 2023 08:36:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFaHJ-0004P2-D8
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 08:36:57 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFaHH-0007RD-Ow
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 08:36:57 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50e2d00f99cso3626606e87.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 05:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702993013; x=1703597813; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QbJ3kv/f9Zy4T+D0KV+GQ//dY218+CcYZA6RqEYrMoc=;
 b=qgNef5Y72HwpE1Oolf6xMKHEiShwDs2Cjaa+fjamhEplk532vUY7FyPy6vKEhjY7q7
 AV/5fx/GOlWv7CUseN3NneQx+WVKHDbR4GPTy6GiigSQhK6tu1RhwMo04NJRgdj0Z0sh
 Xnfq3JqpmXlWah8CJ98GkRfIYss4etTo6eRaCq7vivgyTGt0v0ucQmZ2eTKeRBus95S3
 rKc8LhD33dfAHVJUY3Bh6rXesSjIgdw2UuUdXJeuVvpclJ36PpU0JQRz5E4nqBPCZao1
 6QvbuBGdFNudwvRWifJ4Q9uyWGs9zNslUK7IRdjIsgUn9FMP7JUPDsL+M3VenEgqr55N
 daQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702993013; x=1703597813;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QbJ3kv/f9Zy4T+D0KV+GQ//dY218+CcYZA6RqEYrMoc=;
 b=aw21m1ZG4/PKyisVHvtE3tr7CQ/27ic4/O2UyoiXwRK7KbPysLed0pvxwwzszO/bk8
 mHN4YxhDjfsl2tnzxSUX1BSUWhnAYjsitsbOxGOGL3tmaj6hLshPYpHsDQmjLnXS6wIj
 RRVCD3Y5FiqNdtZYmZdhb0QAR5e7cyyZYMI98HVMpS3ZzmJ+XviNS2qxWI+5dklQ4+Wc
 DBg4VgQsoySm1FadPViI3x/8OSdLii2Pi3mtM/E+Jnu2piOXmLHPaD9kQsFKQHV3yJuF
 aqIOl2bWPxJXloVhPbOageWhoJwE7k8YZHYzjTQkn85dovQGP3h5T5xVAfK2FR11rsqT
 anbg==
X-Gm-Message-State: AOJu0YzWGi9ZosshqCiMw4OjPZJ1zhos9LQ5HJX3W5ozwrQ+hEaLYzj2
 kmOsbDXKrS3l8TjvRE9P7zRRfVgFCz1wLmIPuyNJIg==
X-Google-Smtp-Source: AGHT+IHlQ29hWaYx0J2zx0bKj7CxQEUECr9bmDcjgM8MNuYNdRsmG2dHV1ISNuX/KCEkm16PGd7027Gx1l+Qc7+hKfI=
X-Received: by 2002:a19:8c4b:0:b0:50e:30b3:b905 with SMTP id
 i11-20020a198c4b000000b0050e30b3b905mr2212845lfj.44.1702993013263; Tue, 19
 Dec 2023 05:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20230302123029.153265-1-pbonzini@redhat.com>
 <20230302123029.153265-58-pbonzini@redhat.com>
In-Reply-To: <20230302123029.153265-58-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Dec 2023 13:36:41 +0000
Message-ID: <CAFEAcA92Rd7f3Ngn8_nYZCxJptAD2DcP+oHCiXii6vTHMCUamQ@mail.gmail.com>
Subject: Re: [PULL 57/62] hw/xen: Support MSI mapping to PIRQ
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw@amazon.co.uk>,
 Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Thu, 2 Mar 2023 at 12:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> The way that Xen handles MSI PIRQs is kind of awful.
>
> There is a special MSI message which targets a PIRQ. The vector in the
> low bits of data must be zero. The low 8 bits of the PIRQ# are in the
> destination ID field, the extended destination ID field is unused, and
> instead the high bits of the PIRQ# are in the high 32 bits of the address.

Hi; Coverity thinks this change introduced a locking error
(CID 1527403):


> @@ -1226,21 +1256,54 @@ int xen_evtchn_bind_pirq_op(struct evtchn_bind_pirq *pirq)
>          return -EINVAL;
>      }
>
> -    QEMU_LOCK_GUARD(&s->port_lock);
> +    QEMU_IOTHREAD_LOCK_GUARD();

We used to take the port_lock before looking at s->pirq[pirq->pirq].port,
but now we don't...

>      if (s->pirq[pirq->pirq].port) {
>          return -EBUSY;
>      }
>
> +    qemu_mutex_lock(&s->port_lock);

...until down here after that "exit if already allocated" check.
So Coverity thinks that two threads might both get into
the "take the lock, allocate a port, set the port field in the
struct" codepath simultaneously.

> +
>      ret = allocate_port(s, 0, EVTCHNSTAT_pirq, pirq->pirq,
>                          &pirq->port);
>      if (ret) {
> +        qemu_mutex_unlock(&s->port_lock);
>          return ret;
>      }
>
>      s->pirq[pirq->pirq].port = pirq->port;
>      trace_kvm_xen_bind_pirq(pirq->pirq, pirq->port);
>
> +    qemu_mutex_unlock(&s->port_lock);
> +

I think in practice the iothread-lock guard will prevent this,
but it does look rather odd. Is there a reason not to have
the port lock for the whole stretch of "check whether we've
already allocated this, and if not then allocate it" code ?

thanks
-- PMM

