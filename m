Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C225769761
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 15:21:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQSon-0004e5-T1; Mon, 31 Jul 2023 09:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQSom-0004dp-Qu
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:20:12 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQSol-0004CM-3x
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:20:12 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fb960b7c9dso7191017e87.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 06:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690809609; x=1691414409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3fTGuRHfQ2/nduWwidbkv5hI5CRHgBXRPClWv91aVhg=;
 b=dr48OPmIVKDtH0ryzajWlUYmRBaxTvpIhdrVQ/84Q3Z1R5IB93Of5daKuv2jJifIry
 Bk10Qmi8I5cioMTZ+yHqjzyme3FCQ+9BlcRdYegFrv8A7+AU88JgLa5e2jgRUWvOoOvh
 nsHG7eLDVlwTX6yon0uc0YS4mPpyN4WU3sFmLjx6EUfLcfmx8khDCK4Y9NSxhHo6vYwU
 iOaKqDZLnR9MtWRLOvxl//CCGzPGTqMhX5jTcfoIy2nAkfpluk1nlFabZ3AC51NWiuj2
 /Hpo7/ZkYWATCG5Z0sSB5WejCicLO0M1I/TAl8rYirr5hDSvWsuS5hW71Ci9hd6Q21Pc
 CC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690809609; x=1691414409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3fTGuRHfQ2/nduWwidbkv5hI5CRHgBXRPClWv91aVhg=;
 b=L+qmwnzCRvRyzbcezTmBr4++zE1K3F981bKfkjiPGIzFwZW+WAhL+r6B2EAAA+r2lp
 IiToyLZyaEFj4GiDh5ogNKQ2tPZF263Fb3V+kZOWStC86Tl5CWwcmMN+ErvIY1PHqUBh
 v/NbRee8E+BYo93bfUcHVY6k+FD2b9c+VDKzrglBxCqJN/m5RseEJ7gJVgEu2gUNGYOm
 M6FvAEyn7N9ZJqh94tUzomO+2Y6CM6IPEcZe99KhaF9ttqphQxAQXFi4ZulS9zsrPYeB
 z59k+wCqDROjW3nyWuqVUHBOBb9W/GTsOjx4Ryv3I+vIMCAs8gn9BcOwpMou8cPrNu55
 XRhA==
X-Gm-Message-State: ABy/qLZmqZSG0o6mYWqapzu4gHbDh3baR72K5dja7RdJcb0Y6B3Bz3fP
 rhD6MEQDIDaqW+rnXZsnc0i4T86FV86DDOF1HTa7Lw==
X-Google-Smtp-Source: APBJJlH9OJrMY5P2CGb32l+AKODx60EFsE7M1DELAOTXMr3WZVc/BF0ZCkUiiZC0x2yLWpkOv6qGCIZjyaTVFdcjfZE=
X-Received: by 2002:a05:6512:36c8:b0:4fe:2d93:2b51 with SMTP id
 e8-20020a05651236c800b004fe2d932b51mr3084517lfs.27.1690809609163; Mon, 31 Jul
 2023 06:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230731125946.2038742-1-gshan@redhat.com>
 <008f4ae2-c5bb-3570-3ec9-4ace4b5c4788@redhat.com>
In-Reply-To: <008f4ae2-c5bb-3570-3ec9-4ace4b5c4788@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2023 14:19:58 +0100
Message-ID: <CAFEAcA-HTMxVwdVQT1Mx4eQ0OjwFGX5xbrch6OSOe-WMScgq-w@mail.gmail.com>
Subject: Re: [PATCH v2] kvm: Fix crash due to access uninitialized kvm_state
To: David Hildenbrand <david@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 pbonzini@redhat.com, philmd@linaro.org, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

On Mon, 31 Jul 2023 at 14:00, David Hildenbrand <david@redhat.com> wrote:
>
> On 31.07.23 14:59, Gavin Shan wrote:
> > Runs into core dump on arm64 and the backtrace extracted from the
> > core dump is shown as below. It's caused by accessing uninitialized
> > @kvm_state in kvm_flush_coalesced_mmio_buffer() due to commit 176d073029
> > ("hw/arm/virt: Use machine_memory_devices_init()"), where the machine's
> > memory region is added earlier than before.
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
> > Fix it by bailing early in kvm_flush_coalesced_mmio_buffer() on the
> > uninitialized @kvm_state. With this applied, no crash is observed on
> > arm64.
> >
> > Fixes: 176d073029 ("hw/arm/virt: Use machine_memory_devices_init()")
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > ---
> > v2: Bail early in kvm_flush_coalesced_mmio_buffer() on the uninitialized
> >      @kvm_state and improved changelog        (David/Peter)
> > ---
> >   accel/kvm/kvm-all.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 373d876c05..7b3da8dc3a 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -2812,7 +2812,7 @@ void kvm_flush_coalesced_mmio_buffer(void)
> >   {
> >       KVMState *s = kvm_state;
> >
> > -    if (s->coalesced_flush_in_progress) {
> > +    if (!s || s->coalesced_flush_in_progress) {
> >           return;
> >       }
> >
>
> Thanks Gavin!
>
> Reviewed-by: David Hildenbrand <david@redhat.com>



Applied to target-arm.next, thanks.

-- PMM

