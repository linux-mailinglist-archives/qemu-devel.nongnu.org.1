Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E6C706E15
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:27:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJz1-0006ZW-Jc; Wed, 17 May 2023 12:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1pzJz0-0006ZM-D4
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:26:34 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1pzJyy-0004wn-9I
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:26:34 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-55a1462f9f6so8734657b3.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684340790; x=1686932790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UX4HKKHpNiRzFE0v0DdgFekowRAr8FyedNbPUk28AJM=;
 b=YVzI/wgRtBQx4tu240Krf5VZArDABoV5F8dslpeWUZLLyIWuHaFvqyraaIVlWNv44c
 aQck01zzosFejAn+yYYD9ClrPLpJ1GJDgZ9sKL9vFYW0uZJT0f3D8yD5ft/Lib+HUSfq
 wRSd0AZTPJ2VYnhnNRZmNSkD6+oGMRPSI3/h/f5UOF/Zvc9j4JOKCbTLgHEh1rpNmjOc
 euOJ4E/mSS4xGQb0A7dexFuL/jsZ68wzOcRZoVR3aYgASAt1jd/X2FvfkWO49zlFlTeE
 Zy8W7Cums0LOzHTB0KrGKHP2jsRY36fD+Zj+gocBrLXwGPlD2myiTlVkI6pLAQCo230J
 pE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684340790; x=1686932790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UX4HKKHpNiRzFE0v0DdgFekowRAr8FyedNbPUk28AJM=;
 b=jLeg+8JYAW9shAtlGZHhSEYLH2Xrrpct8JR1jxR1G8NK347xOgWVJsFQ53z8MFrERn
 jddtv6Z0uwuWg9geAMI0GEVnAKFhFs//J3viY7Kwj2T7BkeOmUfSE0eb6U8mBSX0Jeu9
 te0N7DPQWpVDtVekExGQVCX9GvyiyS3VeZjD59ZhqzFYGp9h895dxx4XQPJLK91Lxu+1
 FTd0ChThDfnesbthRk1DK1uU5TqfZM9Elx5j08si8WdxfcC1UsHiaHrJ5nh0e9sSajvJ
 aaJsy8S83exufN1eOGYFn0WXcd2SUspPY1delG/DVUstA6o/PCverXSkVr3r6s2HIpyq
 R+Fg==
X-Gm-Message-State: AC+VfDzX9BJgmot2nriCZByh8okjeIvnctoQWQmpGH5yPn16FFdhN17I
 YBDK7k6F2sq1PhVGEkIM55awLUIa29Zyq/e7U8w=
X-Google-Smtp-Source: ACHHUZ6nXIr6gLubJ5+WTp+vKIYuiQz8LDsr6h3EphqAMxpuPpB9aQHq5SAoNMW5mZxlqUT/8f/K6/wVgs1Q8CILPhM=
X-Received: by 2002:a0d:ca8b:0:b0:561:1de8:26cc with SMTP id
 m133-20020a0dca8b000000b005611de826ccmr14935923ywd.30.1684340790202; Wed, 17
 May 2023 09:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <87v8grlzu9.fsf@linaro.org>
In-Reply-To: <87v8grlzu9.fsf@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 17 May 2023 12:26:18 -0400
Message-ID: <CAJSP0QX+NeJ8Z5d+2ocUUVj4EGopxKT+trmEfacgvhE7TqCokQ@mail.gmail.com>
Subject: Re: Status of DAX for virtio-fs/virtiofsd?
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, virtio-fs@redhat.com, 
 Erik Schilling <erik.schilling@linaro.org>, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=stefanha@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 17 May 2023 at 11:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
Hi Alex,
There were two unresolved issues:

1. How to inject SIGBUS when the guest accesses a page that's beyond
the end-of-file.
2. Implementing the vhost-user messages for mapping ranges of files to
the vhost-user frontend.

The harder problem is SIGBUS. An mmap area may be larger than the
length of the file. Or another process could truncate the file while
it's mmapped, causing a previously correctly sized mmap to become
longer than the actual file. When a page beyond the end of file is
accessed, the kernel raises SIGBUS.

When this scenario occurs in the DAX Window, kvm.ko gets some type of
vmexit (fault) and the code currently enters an infinite loop because
it expects KVM memory regions to resolve faults. Since there is no
page backing that part of the vma, the fault handling fails and the
code loops trying to do this forever.

There needs to be a way to inject this fault back into the guest.
However, we did not found a way to do that. We considered Machine
Check Exceptions (MCEs), x86 interrupts, and paravirtualized
approaches. None of them looked like a clean and sane way to do this.
The Linux maintainers for MCEs and kvm.ko were not excited about
supporting this.

So in the end, SIGBUS was never solved. It leads to a DoS because the
host kernel will enter an infinite loop. We decided that until there
is progress on SIGBUS, we can't go ahead with DAX Windows in
production.

The easier problem is adding new vhost-user messages. It does lead to
a fundamental change in the vhost-user protocol: the presence of the
DAX Window means there are memory ranges that cannot be accessed via
shared memory. Imagine Device A has a DAX Window and Device B needs to
DMA to/from it. That doesn't work because the mmaps happen inside the
frontend (QEMU), so Device B doesn't have access to the current
mappings. The fundamental change to vhost-user is that virtqueue
descriptor mapping code must now deal with the situation where guest
addresses are absent from the shared memory regions and instead send
vhost-user protocol messages to read/write to/from bounce buffers
instead. The rest of the device backend does not require modification.
This is a slow path, but at least it works whereas currently the I/O
would fail because the memory is absent. Other solutions to the
vhost-user DMA problem exist, but this is the one that Dave and I last
discussed.

In the end, there is still work to do to make the DAX Window
supportable. There is experimental code out there that kind of works,
but we felt it was incomplete.

To your specific questions:

>  * What VMM/daemon combinations has DAX been tested on?

Only the experimental virtio-fs Kata Containers kernels and QEMU
builds that were available a few years ago. I don't think the code has
been rebased.

>  * Isn't it time the vhost-user spec is updated?

I don't know if Dave ever wrote the spec for or implemented the final
version of the vhost-user protocol messages we discussed.

>  * Is anyone picking up Dave's patches for the QEMU side of support?

Not at the moment. It would be nice to support, but someone needs the
energy/time/focus to deal with the outstanding issues I mentioned.

If you want to work on it, feel free to include me. I can help dig up
old discussions and give input.

Stefan

