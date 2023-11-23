Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D587F65ED
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:03:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6E32-00032E-W4; Thu, 23 Nov 2023 13:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r6E30-00031w-MR; Thu, 23 Nov 2023 13:03:30 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r6E2z-0005b6-1l; Thu, 23 Nov 2023 13:03:30 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41feb963f60so8880231cf.1; 
 Thu, 23 Nov 2023 10:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700762607; x=1701367407; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x3XJBl20EhSzSFrg8sgHrnSzvjZjQxO6fEKvxKIdeWc=;
 b=Ytomhx9onR/FaNMJlEZfZq1djaXiPG312C7klSkVT/5f4qV7TRpCw5iH29jcj/E2vy
 DkEaNNdpW3c2jIb+itQQ8Gvt9ldgxkbHwWhbnZ6pym0krqw9eixQnkikTAnx7uuCka4+
 +k5WHUuONoxUnoW6Dx/oirM+ExKP1fWkV97hL8YUFktUw09DGIgNDaxzejPxQ6Ic+Mms
 dDpAyCO6bCOAtnGgO4Cy9rFAi2JGRViFGjIpaKzfEdfwxUzPMpLaBm+s1y50V30KNK5k
 JVRhlhmBMf3nbRYNkOnuedvnpdhzLS8GuoA94oshXpOIc58f5nftF+nma2yXJuZukSyh
 dqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700762607; x=1701367407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x3XJBl20EhSzSFrg8sgHrnSzvjZjQxO6fEKvxKIdeWc=;
 b=gXUdNJvKzvBRPkpiMnkAhunlNnAe9uFrBi6Q7MJXenSjb0yVZldOsI4jxlOykbfibe
 pC62WnFUVQtRvybuorCYw/N6NMY3YPGBgYpvCZvjUeeICowzTDJe793gjyRowyYxeTPf
 Rr6rkCg9TPVBA1RP2FFry11e40+2lL/4fFn38BP+uF9ndqSznPLlFGu5PwOt3DqfhD8x
 CBXqgufujQxiwWTolmYFir/pRk+RnpbvzwAtQib0Rb6ng9I7w9mED15as4Z2c9a4tHpA
 ZsH98K9YQ0Sx/J0Py5QrHAYkZrkYah5RBp7mlSmPdO6vph2v+kc7ZNqg1omkLtU/zYWX
 jHMw==
X-Gm-Message-State: AOJu0YwW0ic6XY3JTcfzml+M2lTwwvMVWyqee1l6GyIS2oKsDjTYxQTG
 RCm6ohq2pfMttkRQkTmmaVpb1ZuKVTlyAdC13lw=
X-Google-Smtp-Source: AGHT+IHHxIOirLOdhRnqjjwfItz8ixXfkNu3gox8iL1zmE6qhEnzsXFLh2/ZULzFISLNj+XKBGa0DJ6neMYzjGZvolM=
X-Received: by 2002:a05:622a:13d0:b0:41c:c045:2c86 with SMTP id
 p16-20020a05622a13d000b0041cc0452c86mr6011717qtk.31.1700762607204; Thu, 23
 Nov 2023 10:03:27 -0800 (PST)
MIME-Version: 1.0
References: <20231119203116.3027230-1-dhoff749@gmail.com>
 <3c44d5a5-818b-46b6-a07f-af655a060032@linaro.org>
 <CAFXChKJrXAop188pTFcU0YNPocn_KyiAXiqWoES2F0_==VyO+Q@mail.gmail.com>
 <20231120042116-mutt-send-email-mst@kernel.org>
 <9282a606-794a-432c-8b56-fedf6af67768@linaro.org>
 <viiqn6gyn25xitens3ft4mp4lditlcrswstugct42t2kvpw6pi@3ftcrbxmuo3e>
 <CAFXChKKkRRNk72a57xSeJdYtXBss5W7KoEnQqUOVK9_xhc8NfQ@mail.gmail.com>
 <CAFXChK+OjteJ_rt5G5EWa+wexe8ZzL=8y+Z82mT_r3387h=0RQ@mail.gmail.com>
In-Reply-To: <CAFXChK+OjteJ_rt5G5EWa+wexe8ZzL=8y+Z82mT_r3387h=0RQ@mail.gmail.com>
From: Dan Hoffman <dhoff749@gmail.com>
Date: Thu, 23 Nov 2023 12:03:16 -0600
Message-ID: <CAFXChKLmVe34Qw21z_TvAV8PuDJfLMu7_2L+o1dXkA1WCLJ=Gg@mail.gmail.com>
Subject: Re: [PATCH v3] hw/i386: fix short-circuit logic with non-optimizing
 builds
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=dhoff749@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

I went ahead and wrote a clang-tidy pass that attempts to find other
cases of this behavior (i.e. compile-time short-circuit behavior that
could lead to undefined references). All of these cases should also be
caught by `-Wunreachable-code`, but that uncovers a lot and I'd like a
green light before I pursue that path (also some legitimate patterns
like file-local debug macro definitions will be flagged as warnings).
This check is intentionally broad (whether a symbol is defined is more
a property of the linker, so the compiler doesn't know).

I think this patch should be merged as-is (since it solves the
immediate functional issue I'm having) and I may submit a more
complete patch in the future that guards all references to
potentially-undefined KVM functions with `CONFIG_KVM_IS_POSSIBLE` or
something along those lines. Let me know what you think.

Here's some output from the clang-tidy pass against the current master branch.

```
../hw/i386/intel_iommu.c:4131:31: warning: function not declared in
this file is called from a short-circutable context
[misc-short-circuit-elision]
 4131 |         if (kvm_enabled() && !kvm_enable_x2apic()) {
      |                               ^
../hw/i386/x86.c:136:39: warning: function not declared in this file
is called from a short-circutable context [misc-short-circuit-elision]
  136 |         (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
      |                                       ^
../hw/i386/x86.c:422:27: warning: function not declared in this file
is called from a short-circutable context [misc-short-circuit-elision]
  422 |         kvm_enabled() && !kvm_hv_vpindex_settable()) {
      |                           ^
../hw/net/i82596.c:481:23: warning: function not declared in this file
is called from a short-circutable context [misc-short-circuit-elision]
  481 |     if (USE_TIMER && !timer_pending(s->flush_queue_timer)) {
      |                       ^
../hw/ppc/spapr.c:4543:27: warning: function not declared in this file
is called from a short-circutable context [misc-short-circuit-elision]
 4543 |     if (kvm_enabled() && !kvm_vcpu_id_is_valid(vcpu_id)) {
      |                           ^
../system/physmem.c:1913:27: warning: function not declared in this
file is called from a short-circutable context
[misc-short-circuit-elision]
 1913 |     if (kvm_enabled() && !kvm_has_sync_mmu()) {
      |                           ^
../target/i386/cpu.c:7125:27: warning: function not declared in this
file is called from a short-circutable context
[misc-short-circuit-elision]
 7125 |     if (kvm_enabled() && !kvm_hyperv_expand_features(cpu, errp)) {
      |                           ^
../target/s390x/diag.c:174:30: warning: function not declared in this
file is called from a short-circutable context
[misc-short-circuit-elision]
  174 |         if (kvm_enabled() && kvm_s390_get_hpage_1m()) {
      |                              ^
```

If any of you have any questions, feel free to let me know

