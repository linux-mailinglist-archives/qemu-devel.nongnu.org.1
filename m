Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A69798EFB
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 21:22:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeh2q-0005p3-6b; Fri, 08 Sep 2023 15:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeh2n-0005oB-JA
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 15:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeh2j-0004tq-BN
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 15:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694200882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rKy4vUa4gN4eZ0JfAuchexs+L75u0Ddus9nGICjZFEo=;
 b=Zkx2sLDhB0BG0xN6Yyz4MNkDiXOIEn3dbg8TrXKoLdAoymlUEmZu+e9pMq1BhgViNVoAVh
 DONDNR3k4idYZ+OYsW99tbcZIEYflKocANoWvYi6OAMTRPRizcslYJ3rHsrItHr9Kq6brB
 LijcWKyCWeFEmWA6anoLCdyNnj4635w=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-CPNsgSKsOhKaqjKpkYO7iA-1; Fri, 08 Sep 2023 15:21:21 -0400
X-MC-Unique: CPNsgSKsOhKaqjKpkYO7iA-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-44d3a5ccfc2so971649137.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 12:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694200881; x=1694805681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rKy4vUa4gN4eZ0JfAuchexs+L75u0Ddus9nGICjZFEo=;
 b=w/VctunqKKJsTo03xbuKhHrFWyf6rzwjUQCAjh61ipngHmiKgpQ6kBFBMzr3SSJ7ZY
 NUZ7gSINlLWWiyqssDYADjDI9Y+nrfhoGFegOtPydQgbEQIDgpcVH5HxeN6B6JGfcdb9
 YWjqdeaA8T+vTsaSE2FCB0OoFjzbDzskpQpK6Bt5nLsY9+sbNUQtTbNXoYRV9hl0V3Vu
 pdcl+GhuXKKLS1XnGea2hPAT9aJQFnKyMDPqaLDMsk+QjInkydpZBH/ahEroK9VLJxeS
 Gh2b68Quwd7UPj0UII6lgPsDi5nudHHJ68YuVLeOyDIWHIkhsjjzReMxOFcaELD0/8AM
 bVhw==
X-Gm-Message-State: AOJu0YwangYA2QtcWqfpvVRxr+/nQuHXRn01nwPdX61zT6YlRmDZNixV
 F6Z5zfrtY8Iox05c+M6l/VlqTh9ppBXGdRo7QAFhiZ68yGFrzNzALc0fAJ5tT0e9EreLAVti64b
 C/oLHN8BK3s4EeLeTQDbVbp6fBhQLUa4=
X-Received: by 2002:a67:fc01:0:b0:44e:d937:d28b with SMTP id
 o1-20020a67fc01000000b0044ed937d28bmr3568792vsq.10.1694200880863; 
 Fri, 08 Sep 2023 12:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtwt3qGx1NiSXW4EfHmkQ6hx65AnxdEezGDpUVLm387ai6JoPWigOnHqxmEalAryGDA8kQ3hIY4LFUBk7cE9Y=
X-Received: by 2002:a67:fc01:0:b0:44e:d937:d28b with SMTP id
 o1-20020a67fc01000000b0044ed937d28bmr3568775vsq.10.1694200880608; Fri, 08 Sep
 2023 12:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907154412.GA1550739@fedora> <ZPs3UB8W4lsOFnxW@redhat.com>
 <521ab2c6-f617-1a9e-fef6-29add2e62137@linaro.org>
 <ZPtW4PXsVTo83IpN@redhat.com> <ZPtZvXcQhIWA3Iu0@redhat.com>
In-Reply-To: <ZPtZvXcQhIWA3Iu0@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 8 Sep 2023 21:21:07 +0200
Message-ID: <CABgObfaNCLDWXYN82Qxus3wothUdOu9C_dh_7aw16x8NfWSOsQ@mail.gmail.com>
Subject: Re: [PULL 00/51] Build system, i386 changes for 2023-09-07
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 8, 2023 at 7:28=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote:
> Maybe the calls aren't eliminated because --enable-debug implies -O0?

My experience is that it will still fold simple dead code like "0 &&
foo()" or even "if (0) { ... }", but maybe it's a GCC vs. clang
difference. Philippe, I take it that you are looking at it?

Paolo

> Kevin
>
> > > What are your ./configure command options?
> >
> > '/home/kwolf/source/qemu/configure' '--cc=3Dclang' '--target-list=3Dx86=
_64-linux-user,x86_64-softmmu,arm-softmmu,aarch64-softmmu' '--enable-debug'=
 '--cxx=3Dclang++' '--disable-blkio'
> >
> > Kevin
> >
> > > >    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o:=
 in function `x86_cpu_filter_features':
> > > >    /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7158: u=
ndefined reference to `kvm_arch_get_supported_cpuid'
> > > >    /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/=
cpu.c:7159: undefined reference to `kvm_arch_get_supported_cpuid'
> > > >    /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/=
cpu.c:7160: undefined reference to `kvm_arch_get_supported_cpuid'
> > > >    /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/=
cpu.c:7161: undefined reference to `kvm_arch_get_supported_cpuid'
> > > >    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o:=
/home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7162: more undefin=
ed references to `kvm_arch_get_supported_cpuid' follow
> > > >    clang-15: error: linker command failed with exit code 1 (use -v =
to see invocation)
> > > >
> > > > In case it makes a difference, I'm using clang on F37.
> > > >
> > > > Kevin
> > >
>


