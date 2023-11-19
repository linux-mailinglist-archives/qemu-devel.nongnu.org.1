Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B44187F08BA
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 21:04:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4o0K-0007qW-Gd; Sun, 19 Nov 2023 15:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r4o0G-0007q9-Iy
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 15:02:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r4o0E-0004qc-UW
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 15:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700424160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KPs+MPf+il2h+1WKCIJdtZY9kvzHjSwZ3wWSzFC8I0k=;
 b=h7G4v7ODqDuHciDxDvxJdOkGH75tMHQnLMH4cVJQNVY1z9pcRkooB02d77Gvjmep8G4+mj
 iBkOkNUnI5hldh89Owy7YbfLrwAQbUWKi9LKNeZTzDtX85t0LqZOX4kevUtXEvQQlewLuX
 P5UFPhxzH2MqmnIoXC+Juci5KNgnObM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-XQCILXuQM5ewnGEAForBIw-1; Sun, 19 Nov 2023 15:02:39 -0500
X-MC-Unique: XQCILXuQM5ewnGEAForBIw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-408534c3ec7so8208785e9.1
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 12:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700424158; x=1701028958;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KPs+MPf+il2h+1WKCIJdtZY9kvzHjSwZ3wWSzFC8I0k=;
 b=gkTc9d4Dx5O6O8RUaTUxnSdN7pSDBw6l5Lg2mmujQscwT/fzXu/AtBeTbgLRdEkyuN
 PZSIC7Qj78kexq9KpbhZkfs1pXw5IS+2xggPdnDa8zKkMU21vgXBaqYxtSR6UslI36NW
 DaUMAZPPN9D+Il1+m8ciIgczrwdnt/rx/lxRKtcHY2uHth96KOu3yQK6nktg9wJMqqH7
 hX/48MM1kSb9GR4GUPEIEgOWx6oKtSWc5apoTHx/yd59sArefCrt6T2lp1JYZ9InpJ62
 EIhRoROrILLzUHaJp9auDDjTSYQLWka1MrDKAmgL7VnKxBpLsdLHaXX218cJIjOFlP1h
 xTVQ==
X-Gm-Message-State: AOJu0YyrtBBC8dsd0jTFWaDGEc4d82wRRHC1j0H7w6s2Xb0727ZJJ9D3
 6VO6+jHDL9lVAEFtj2Zau5hLt4PzmtCcvzDGRowop9pIzI4a0y2enzHoHLO8pkoJX/Y+LZ3QuLc
 /ziNT47c3WXjEd4s=
X-Received: by 2002:a05:600c:19ca:b0:3fe:2b8c:9f0b with SMTP id
 u10-20020a05600c19ca00b003fe2b8c9f0bmr3596955wmq.23.1700424158102; 
 Sun, 19 Nov 2023 12:02:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUQ2FScfpyopMnWFg1/rDumyxWfcsukTIf8e788dbojzGEQPEfWu1EJBOMJP+gVE20zGKCUA==
X-Received: by 2002:a05:600c:19ca:b0:3fe:2b8c:9f0b with SMTP id
 u10-20020a05600c19ca00b003fe2b8c9f0bmr3596942wmq.23.1700424157734; 
 Sun, 19 Nov 2023 12:02:37 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f3:2252:367f:6745:f63f:d25])
 by smtp.gmail.com with ESMTPSA id
 dd11-20020a0560001e8b00b0032db8f7f378sm8877230wrb.71.2023.11.19.12.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 12:02:37 -0800 (PST)
Date: Sun, 19 Nov 2023 15:02:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Hoffman <dhoff749@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] hw/i386: fix short-circuit logic with non-optimizing
 builds
Message-ID: <20231119150225-mutt-send-email-mst@kernel.org>
References: <20231118182531.2619772-1-dhoff749@gmail.com>
 <20231119022223-mutt-send-email-mst@kernel.org>
 <CAFXChKJGE92WEfOWsE0=eSfSM55abCA4baOsoPE8V--iWU1GGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFXChKJGE92WEfOWsE0=eSfSM55abCA4baOsoPE8V--iWU1GGg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, Nov 19, 2023 at 11:03:54AM -0600, Dan Hoffman wrote:
> On Sun, Nov 19, 2023 at 1:23 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sat, Nov 18, 2023 at 10:25:31AM -0800, Daniel Hoffman wrote:
> > > `kvm_enabled()` is compiled down to `0` and short-circuit logic is
> > > used to remmove references to undefined symbols at the compile stage.
> > > Some build configurations with some compilers don't attempt to
> > > simplify this logic down in some cases (the pattern appears to be
> > > that the literal false must be the first term) and this was causing
> > > some builds to emit references to undefined symbols.
> > >
> > > Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
> >
> > Could we add a bit more detail here? Will help make sure
> > this does not break again in the future.
> 
> The configuration script was ran as such:  ../configure
> --without-default-features --target-list=x86_64-softmmu,i386-softmmu
> --enable-debug --enable-tcg-interpreter --enable-debug-tcg
> --enable-debug-mutex
> 
> I'm pretty sure the only relevant flags here are
> --without-default-features, --target-list including x86_64-softmmu and
> --enable-debug
> 
> The only error I see is this: [...]/hw/i386/x86.c:422:(.text+0x1004):
> undefined reference to `kvm_hv_vpindex_settable' (the other
> kvm_enabled() was moved for the sake of consistency). My compiler is
> clang (16.0.6).
> 
> I haven't looked into the heuristics or logic for how the compile-time
> short-circuit logic works, but I assumed only the first parameter is
> "guaranteed" to be checked for a literal false (guaranteed is in
> quotes because that's just how clang works, not because it's a feature
> of the language IIRC).
> 
> This pattern relies on somes subtle behavior with the compiler, so my
> suggestion going forward would be to not rely on code optimizations
> removing undefined references based on short-circuit logic (instead
> have some configuration macro defined that disables all relevant
> code). I'm a new contributor, so I submitted the minimum to make it
> work on my machine.
> 
> If you have any other questions, please let me know.
> 
> Thanks!

which compiler is this?

-- 
MST


