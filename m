Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C32EA769686
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 14:41:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQSBh-0007Lh-BY; Mon, 31 Jul 2023 08:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQSBf-0007Kc-6l
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:39:47 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQSBd-0001ue-HF
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:39:46 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52222562f1eso6675649a12.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690807184; x=1691411984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/XiD5kf5yxuft+dYYppI1TYu3hyIMtw7QNRYgFpVgTo=;
 b=j+MnGbvFwgOYCDYHck1BKz7teqZ/SZgv6MSXarJjXhdoEj9aXX1lfMyjaWbGJQHWF0
 c/nkBzx79mimAh4DtTvtTKwq5lAj8ed6okFV2w+YL9B7q72Opa+Z3ZuJiBDetpDFNy39
 hSHz1efnm7aGxHsR9ZDMqItmzfNchnIp26oeBCdZ55ZUk6C3O4bBhmgKLiC+fspFZq0n
 BdV+MztQV/iZcvtNCs+gfTWVu1iFnCZHVX9jeqElYh9XdXyr8oz0gRWw4IZUhpM0g7Zu
 3qSDQIkeaEnFBJryVowF1qMTkVRBTerpB9xWHITvqQ7AfLepO42HVJAX9DjFS7H5EnXQ
 O4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690807184; x=1691411984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/XiD5kf5yxuft+dYYppI1TYu3hyIMtw7QNRYgFpVgTo=;
 b=enID0sdgqR893QolXpKfzIUUHwz2ETLo0B/xrJbDFn4AJ9a7IQkbgyDD7Q6gD0zpWX
 dILEt3GumQ2Px/D6LI7D0jub78JWoUAjI4Yrbya8n9e7OU07cP3nPqgwZU9yoHYN73tp
 /6pWeETvsURAi4earr+APO57QdtajwQK9wXx8yIqaruRIYVey/2jnha+xgcF2YYJy1Fb
 NXjUYHpQG+ys1hE2KLCpBG92s+x7wX5+SYwBgQu0ICnGcCX3LXkPe70dzKBGDaGSsyS9
 7Azzc+ps4pd2nj7aE9ssS595JtaOciUZc5iCA/xkonn4PGSSSVPIH9rk+6TL0kAP7YGU
 2XVg==
X-Gm-Message-State: ABy/qLYjoXw9iTcYmGDk7ug6FGLHWyssjcmPVy5CXEH8W1E09ykhxvMP
 BI2pozlKtTkthxDfE0I8s3HC9L0bPQaLRp1q412gsQ==
X-Google-Smtp-Source: APBJJlFLD2Vt+WrevBHfPfWrff7Fzd24Uzq+iYqVRnT0dKZbh/RgPUdRAh73BWHP0SDEfD+hytslL3HajOGkiK/zWPY=
X-Received: by 2002:a05:6402:1208:b0:51e:1af0:3a90 with SMTP id
 c8-20020a056402120800b0051e1af03a90mr8538827edw.37.1690807183801; Mon, 31 Jul
 2023 05:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230730234840.1989974-1-gshan@redhat.com>
 <af597a7c-5580-ffc5-d435-dd7e0ccc63d2@redhat.com>
In-Reply-To: <af597a7c-5580-ffc5-d435-dd7e0ccc63d2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2023 13:39:32 +0100
Message-ID: <CAFEAcA8Uc7S4oBzKi_9AGCEkNdeZX1U73bvit6RmQo8_A7QLoA@mail.gmail.com>
Subject: Re: [PATCH] kvm: Fix crash by initializing kvm_state early
To: David Hildenbrand <david@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 pbonzini@redhat.com, philmd@linaro.org, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 31 Jul 2023 at 08:18, David Hildenbrand <david@redhat.com> wrote:
>
> On 31.07.23 01:48, Gavin Shan wrote:
> > Runs into core dump on arm64 and the backtrace extracted from the
> > core dump is shown as below. It's caused by accessing @kvm_state which
> > isn't initialized at that point due to commit 176d073029 ("hw/arm/virt:
> > Use machine_memory_devices_init()"), where the machine's memory region
> > is added ealier than before.
>
> s/ealier/earlier/
>
> >
> >      main
> >      qemu_init
> >      configure_accelerators
> >      qemu_opts_foreach
> >      do_configure_accelerator
> >      accel_init_machine
> >      kvm_init
> >      virt_kvm_type
> >      virt_set_memmap
> >      machine_memory_devices_init
> >      memory_region_add_subregion
> >      memory_region_add_subregion_common
> >      memory_region_update_container_subregions
> >      memory_region_transaction_begin
> >      qemu_flush_coalesced_mmio_buffer
> >      kvm_flush_coalesced_mmio_buffer
> >
> > Fix it by initializing @kvm_state early. With this applied, no crash
> > is observed on arm64.

> As an alternative, we might simply do nothing in
> kvm_flush_coalesced_mmio_buffer(), in case kvm_state is not setup yet.
> We don't have any notifier registered in that case.

Yes, this seems better I think -- conceptually kvm_init()
probably ought to first set up the accelerator state and
then set kvm_state last, so that other code that looks
at the kvm_state global either sees NULL or else a
completely valid state, not a possibly half-initialised
one. (We should probably also NULL the global in the
error-exit path, though I imagine we're about to exit
in that case.)

Is somebody able to write/test a patch for that today?
Ideally we'd fix this for tomorrow's rc...

thanks
-- PMM

