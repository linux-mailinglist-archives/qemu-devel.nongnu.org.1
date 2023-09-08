Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0742798878
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:21:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecMT-0000Gn-1P; Fri, 08 Sep 2023 10:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qecMN-0000Fn-UK
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qecML-0001SH-GT
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694182880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A1dS1EXnlM9RWd0wh+RfSyvVwSxSLC59ZPlPSe8FASc=;
 b=Clkf7wOcOL6JzIR27sK5wxVtQIXnf76S8DxxJCzqnWV0EYrubasRJMk7F/mLbnKrxhnHDL
 QBDqAlFK4uvexKjC4C8wAsufHty7yFez733wXLHJ9Bu2UgHD0FY7ZXtwVC/9m1B2bthRXA
 2MxPJLoVyAn+r3YJCiiEym0o8i+5w6k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-12iET1RpOhy_kOQRVhuEAA-1; Fri, 08 Sep 2023 10:21:18 -0400
X-MC-Unique: 12iET1RpOhy_kOQRVhuEAA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2bd132e84b2so25349501fa.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 07:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694182877; x=1694787677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1dS1EXnlM9RWd0wh+RfSyvVwSxSLC59ZPlPSe8FASc=;
 b=nS6jQ6ylE1t92r/rb43lLtUgibUktSvAslkKXcpobl8bxJpsg01Mgrs5POidJ7tPIQ
 Hj4kDgtNNQHfY0P3ORc1hYmXhozQEgetKoM22ccyLZuCO6wX6y7mPfhz37BXbu7y+UE+
 sk4er51ZHDsjedK1oeNLKPyTS/V4lxAN0lbt4C2r1JsIFJeZxRfz3pPUkzj8H/7HY3ka
 DlWZlmj2LZAN8SJNVILq+tNe+MNMKeXIgxFvuXL+sqf7N3/CUNIBXWexGCFqMXqJBse/
 qOEO29t6yU6MEuN3tcdxVr9EAfPFxfHQIxLnkoD6CxBmU5BK7Pph9AEPj96eyqf3lPgP
 tXuw==
X-Gm-Message-State: AOJu0YzX22GzU4wqz6Fsb2r1/Sq7Qj1T/t71/pvpS42j9yG1Qr2ACt+X
 4K56KqAl5lEL6c1xV2Vt6FrfcLd6OsHVWMaAGi8ak+iRnVAfYj3LYKATFNjh5GAFCNI9qKl36lY
 f2MegbYuulYGH24s=
X-Received: by 2002:a05:651c:1045:b0:2bc:b6d9:4347 with SMTP id
 x5-20020a05651c104500b002bcb6d94347mr2191258ljm.20.1694182877348; 
 Fri, 08 Sep 2023 07:21:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5S1ApEeDZOEA9VyxycvmeUqDkKQGMjefRQBBSAj22aVACHinXBvIXcUT/WuqBgJ/TyuhDpA==
X-Received: by 2002:a05:651c:1045:b0:2bc:b6d9:4347 with SMTP id
 x5-20020a05651c104500b002bcb6d94347mr2191243ljm.20.1694182877045; 
 Fri, 08 Sep 2023 07:21:17 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 j9-20020a170906050900b00997e99a662bsm1077388eja.20.2023.09.08.07.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 07:21:12 -0700 (PDT)
Date: Fri, 8 Sep 2023 16:21:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 03/10] target/i386: Fix duplicated feature name in
 FEAT_KVM
Message-ID: <20230908162109.0878826d@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230908124534.25027-4-twiederh@redhat.com>
References: <20230908124534.25027-1-twiederh@redhat.com>
 <20230908124534.25027-4-twiederh@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri,  8 Sep 2023 14:45:27 +0200
Tim Wiederhake <twiederh@redhat.com> wrote:

> The mistake became apparent as there were two features with the same name
> in this cpuid leaf. The names are now in line with the documentation from
> https://kernel.org/doc/html/latest/virt/kvm/x86/cpuid.html

I'd describe what duplication breaks and it's effects.

and also why it's considered that it's safe to change names here.

> Fixes: 642258c6c7 ("kvm: add kvmclock to its second bit")
> Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f10d343935..f0fedf4b88 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -852,7 +852,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>      [FEAT_KVM] = {
>          .type = CPUID_FEATURE_WORD,
>          .feat_names = {
> -            "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
> +            "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock2",
>              "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
>              NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
>              "kvm-poll-control", "kvm-pv-sched-yield", "kvm-asyncpf-int", "kvm-msi-ext-dest-id",


