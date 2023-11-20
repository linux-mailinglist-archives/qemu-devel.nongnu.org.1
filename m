Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B11347F0F12
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 10:29:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r50aW-00036O-I0; Mon, 20 Nov 2023 04:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r50aU-000364-7F
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 04:29:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r50aS-0004s6-KX
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 04:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700472539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vWevTP/cS811Dy6gVvwoRlReBAit1jDPwGcQEpWTQIk=;
 b=icHpYBgyMaSWHijg7t2EAylaFY2DyzroIwxD1+SGE9UzAU8ULkmKVNI155foZUMw4iL4we
 MYRHtA/7lTPPs/x4MhDs2q5JGQUTDQkvgMCFOIUClG5gMISgQGSHvdXWj/N6BnVVtsncI3
 3gE3QJv4tvcMCUIThynDlWpqLjymxFE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-kQHbwkqQPga5FQCqaNfqXQ-1; Mon, 20 Nov 2023 04:28:57 -0500
X-MC-Unique: kQHbwkqQPga5FQCqaNfqXQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40b23aef363so3042275e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 01:28:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700472536; x=1701077336;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vWevTP/cS811Dy6gVvwoRlReBAit1jDPwGcQEpWTQIk=;
 b=UhmaqOB1atc//qB+r7Jo/3BWtZQSWo6qDnM2qsxw+qwvnhOUp44SPMFu7yzbJeTsLy
 G5t4ZQ8BY+v1ZfMw8IVUIkkJLtdB1CEHObK7vIF7mm9DyJlWZgajqapG1odcfzXDb42w
 0p+RiF3pxeRucxhue9jI/h4ONf7Ibzty9tQgM3w2zSiQIzwUM5QJHuRtCH0nJlTVvWTJ
 RsNYufGINd479oiVZaR6si6HJBtmqgQ78LgI7+V6xlqnp5FLrfBOO7oIm6v0h65n//y4
 OyVz9lwTqQUTRAK6gzAKnyWEv+tfa7t+LeV3X2/YNUg8gmKHR4xPUDT7SFmy4dQSngg8
 WDEg==
X-Gm-Message-State: AOJu0YxfNRdfthp948KbfZtMmATTsZrXkIzqgssACPnuCkgUK19+Sh4c
 mEZc6jCvS3ra/ZQzkwBpztiPkGWrwqIfBk7M/cdjjoLh98mwsKF8awADdh5Y5WsQDt6+eZhdZ6t
 9JXr9zakniEC8zDA=
X-Received: by 2002:a05:600c:1c0a:b0:408:3c8a:65ec with SMTP id
 j10-20020a05600c1c0a00b004083c8a65ecmr5187411wms.8.1700472536536; 
 Mon, 20 Nov 2023 01:28:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGsp8DTbImT3jK95kR8Z/THRmqvrDbRbbw5wiZ2HMbJDSkFdakgbGUyPK0ZppBPhW2g2mc9w==
X-Received: by 2002:a05:600c:1c0a:b0:408:3c8a:65ec with SMTP id
 j10-20020a05600c1c0a00b004083c8a65ecmr5187397wms.8.1700472536194; 
 Mon, 20 Nov 2023 01:28:56 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:626e:8b7b:4d17:fb61:4be1])
 by smtp.gmail.com with ESMTPSA id
 k5-20020adfe8c5000000b00331733a98ddsm7522041wrn.111.2023.11.20.01.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 01:28:55 -0800 (PST)
Date: Mon, 20 Nov 2023 04:28:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Hoffman <dhoff749@gmail.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH v3] hw/i386: fix short-circuit logic with non-optimizing
 builds
Message-ID: <20231120042116-mutt-send-email-mst@kernel.org>
References: <20231119203116.3027230-1-dhoff749@gmail.com>
 <3c44d5a5-818b-46b6-a07f-af655a060032@linaro.org>
 <CAFXChKJrXAop188pTFcU0YNPocn_KyiAXiqWoES2F0_==VyO+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFXChKJrXAop188pTFcU0YNPocn_KyiAXiqWoES2F0_==VyO+Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sun, Nov 19, 2023 at 07:34:58PM -0600, Dan Hoffman wrote:
> As far as I can tell, yes. Any optimization level above O0 does not have this
> issue (on this version of Clang, at least)

Aha, this is with -O0. That makes sense.
We have:
  ;;
  --enable-debug)
      # Enable debugging options that aren't excessively noisy
      meson_option_parse --enable-debug-tcg ""
      meson_option_parse --enable-debug-graph-lock ""
      meson_option_parse --enable-debug-mutex ""
      meson_option_add -Doptimization=0
      default_cflags='-O0 -g'


> On Sun, Nov 19, 2023 at 4:54 PM Philippe Mathieu-Daudé <philmd@linaro.org>
> wrote:
> 
>     Hi,
> 
>     On 19/11/23 21:31, Daniel Hoffman wrote:
>     > `kvm_enabled()` is compiled down to `0` and short-circuit logic is
>     > used to remove references to undefined symbols at the compile stage.
>     > Some build configurations with some compilers don't attempt to
>     > simplify this logic down in some cases (the pattern appears to be
>     > that the literal false must be the first term) and this was causing
>     > some builds to emit references to undefined symbols.
>     >
>     > An example of such a configuration is clang 16.0.6 with the following
>     > configure: ./configure --enable-debug --without-default-features
>     > --target-list=x86_64-softmmu --enable-tcg-interpreter
> 
>     Is the '--enable-debug' option triggering this?
> 
>     I'm surprised the order of conditions matters for code elision...
> 
>     > Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
>     > ---
>     >   hw/i386/x86.c | 15 ++++++++++++---
>     >   1 file changed, 12 insertions(+), 3 deletions(-)
>     >
>     > diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>     > index b3d054889bb..2b6291ad8d5 100644
>     > --- a/hw/i386/x86.c
>     > +++ b/hw/i386/x86.c
>     > @@ -131,8 +131,12 @@ void x86_cpus_init(X86MachineState *x86ms, int
>     default_cpu_version)
>     >       /*
>     >        * Can we support APIC ID 255 or higher?  With KVM, that requires
>     >        * both in-kernel lapic and X2APIC userspace API.
>     > +     *
>     > +     * kvm_enabled() must go first to ensure that kvm_* references are
>     > +     * not emitted for the linker to consume (kvm_enabled() is
>     > +     * a literal `0` in configurations where kvm_* aren't defined)
>     >        */
>     > -    if (x86ms->apic_id_limit > 255 && kvm_enabled() &&
>     > +    if (kvm_enabled() && x86ms->apic_id_limit > 255 &&
>     >           (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
>     >           error_report("current -smp configuration requires kernel "
>     >                        "irqchip and X2APIC API support.");
>     > @@ -418,8 +422,13 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>     >       }
>     >       cpu->thread_id = topo_ids.smt_id;
>     >   
>     > -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
>     > -        kvm_enabled() && !kvm_hv_vpindex_settable()) {
>     > +    /*
>     > +    * kvm_enabled() must go first to ensure that kvm_* references are
>     > +    * not emitted for the linker to consume (kvm_enabled() is
>     > +    * a literal `0` in configurations where kvm_* aren't defined)
>     > +    */
>     > +    if (kvm_enabled() && hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &
>     &
>     > +        !kvm_hv_vpindex_settable()) {
>     >           error_setg(errp, "kernel doesn't allow setting HyperV
>     VP_INDEX");
>     >           return;
>     >       }
> 
> 


