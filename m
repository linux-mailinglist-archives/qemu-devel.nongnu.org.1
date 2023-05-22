Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC86C70BF50
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:11:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15Jj-0004cx-Ae; Mon, 22 May 2023 09:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q15JU-0004bd-H5
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:11:00 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q15JR-0007Pp-V4
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:11:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f607e60902so3606355e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 06:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684761056; x=1687353056;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MAZUvg7d9dhLhvZm1URXq1BhSaBQXSEfBHTNs7EGTg=;
 b=BDcHbrY6a6WUb9E77zOY2CfMW8kwgE3zukNHBOfOSewNLzW6tnjOv1V2wPO9nUZ284
 Fqfk4cM8F84Re/CVTSyO0BVh2RR9Ovldl610CpHLHqu5zZGtRU6gIx5TCdmwLvAZSiok
 FB9nlMPtCAaxJwYKN7/n6tF/PGxMug8A1IE87wX7596+35wRAjvOlzBEgOgI8XOFGNRv
 BF1lcC8jQV0sB0HQhe/g67krNfbqWkxvI51PcX12cWTbW0rBZnm4eVnOvSeWSieXmLA9
 QFsJJ+PZ8zbPbGV2VXADsSZ6kFrtK8NTigbC4n2HNLZBskNewmPGTvqj9HL9XhCnFMxW
 UhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684761056; x=1687353056;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3MAZUvg7d9dhLhvZm1URXq1BhSaBQXSEfBHTNs7EGTg=;
 b=FYynekdRgaXBaw/+ONlu9fgo0ZSxrrt0SSIuoRlWs7tLIXYV0OAmfQzVaXNC8doLih
 /mqGNhXwafOrqWuvIIpOrffj8GZqfhZOPVenUp3yB08CusIOWT/ON1sHRyzWZ/yj3Zvh
 RY7ZaDhoApv9Z/cDFfaFvFsLtyg2aMJfV4vNgFijaE6nB84tpxhJoQnSYlQmshZ5n2dE
 Ba/D22WLqMaOhhBy6/NWlYJMi9Y50GDHsCmSwfNEmiMxnYhlbxlC3NSn1kp24WwzSWX6
 7rQGE4fjLDrFOt+7HtqbeQ+2lF4zn8HZBdhpSgKBOqGlXCx5aUCFvbJmiXnsb+cpK1Dh
 UpJA==
X-Gm-Message-State: AC+VfDyD5k+YQcCrWjdYGiSY92UnwykwJ/UhP5YvKVEjkQpWR70itEpX
 c2O24PiGjy16SeKwJqMqj2tMGw==
X-Google-Smtp-Source: ACHHUZ5QzUGzdp95hVlnI+Uh7SgHxJzNOJNCeq10HZ/+UXf4croXdGoswjspzfH7aNveDdfndaAA4Q==
X-Received: by 2002:a5d:4a02:0:b0:30a:8c0b:320d with SMTP id
 m2-20020a5d4a02000000b0030a8c0b320dmr3179355wrq.11.1684761055872; 
 Mon, 22 May 2023 06:10:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c5-20020adfe705000000b002c71b4d476asm7728071wrm.106.2023.05.22.06.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 06:10:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E82C01FFBB;
 Mon, 22 May 2023 14:10:54 +0100 (BST)
References: <87v8grlzu9.fsf@linaro.org>
 <CAJSP0QX+NeJ8Z5d+2ocUUVj4EGopxKT+trmEfacgvhE7TqCokQ@mail.gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, virtio-fs@redhat.com, Erik Schilling
 <erik.schilling@linaro.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Status of DAX for virtio-fs/virtiofsd?
Date: Mon, 22 May 2023 13:54:47 +0100
In-reply-to: <CAJSP0QX+NeJ8Z5d+2ocUUVj4EGopxKT+trmEfacgvhE7TqCokQ@mail.gmail.com>
Message-ID: <87zg5w5x5t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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


Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Wed, 17 May 2023 at 11:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> Hi Alex,
> There were two unresolved issues:
>
> 1. How to inject SIGBUS when the guest accesses a page that's beyond
> the end-of-file.
> 2. Implementing the vhost-user messages for mapping ranges of files to
> the vhost-user frontend.
>
> The harder problem is SIGBUS. An mmap area may be larger than the
> length of the file. Or another process could truncate the file while
> it's mmapped, causing a previously correctly sized mmap to become
> longer than the actual file. When a page beyond the end of file is
> accessed, the kernel raises SIGBUS.
>
> When this scenario occurs in the DAX Window, kvm.ko gets some type of
> vmexit (fault) and the code currently enters an infinite loop because
> it expects KVM memory regions to resolve faults. Since there is no
> page backing that part of the vma, the fault handling fails and the
> code loops trying to do this forever.
>
> There needs to be a way to inject this fault back into the guest.
> However, we did not found a way to do that. We considered Machine
> Check Exceptions (MCEs), x86 interrupts, and paravirtualized
> approaches. None of them looked like a clean and sane way to do this.
> The Linux maintainers for MCEs and kvm.ko were not excited about
> supporting this.
>
> So in the end, SIGBUS was never solved. It leads to a DoS because the
> host kernel will enter an infinite loop. We decided that until there
> is progress on SIGBUS, we can't go ahead with DAX Windows in
> production.

This certainly seems like something we'd need hypervisor specific
support for as well. In the Xen case pages aren't "owned" by the dom0
kernel (although it does track some of them) so the hypervisor would
need report the problem via some mechanism.

> The easier problem is adding new vhost-user messages. It does lead to
> a fundamental change in the vhost-user protocol: the presence of the
> DAX Window means there are memory ranges that cannot be accessed via
> shared memory. Imagine Device A has a DAX Window and Device B needs to
> DMA to/from it. That doesn't work because the mmaps happen inside the
> frontend (QEMU), so Device B doesn't have access to the current
> mappings. The fundamental change to vhost-user is that virtqueue
> descriptor mapping code must now deal with the situation where guest
> addresses are absent from the shared memory regions and instead send
> vhost-user protocol messages to read/write to/from bounce buffers
> instead. The rest of the device backend does not require modification.
> This is a slow path, but at least it works whereas currently the I/O
> would fail because the memory is absent. Other solutions to the
> vhost-user DMA problem exist, but this is the one that Dave and I last
> discussed.

This doesn't sound too dissimilar to cases we need to handle now in Xen
where access to memory is transitory and controlled by the hypervisor.

>
> In the end, there is still work to do to make the DAX Window
> supportable. There is experimental code out there that kind of works,
> but we felt it was incomplete.
>
> To your specific questions:
>
>>  * What VMM/daemon combinations has DAX been tested on?
>
> Only the experimental virtio-fs Kata Containers kernels and QEMU
> builds that were available a few years ago. I don't think the code has
> been rebased.
>
>>  * Isn't it time the vhost-user spec is updated?
>
> I don't know if Dave ever wrote the spec for or implemented the final
> version of the vhost-user protocol messages we discussed.
>
>>  * Is anyone picking up Dave's patches for the QEMU side of support?
>
> Not at the moment. It would be nice to support, but someone needs the
> energy/time/focus to deal with the outstanding issues I mentioned.
>
> If you want to work on it, feel free to include me. I can help dig up
> old discussions and give input.

I think in the short term we shall just concentrate on getting virtiofsd
working well in our Xen setup. We can certainly consider looking at DAX
again in our optimisation phase. We know it will help in performance so
its just down to the implementation details ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

