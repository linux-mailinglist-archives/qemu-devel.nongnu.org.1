Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 729227CB3AD
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 22:06:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsTqJ-00015P-NY; Mon, 16 Oct 2023 16:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1qsTqG-000151-Ap
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 16:05:32 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1qsTq9-0005Py-1r
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 16:05:31 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c5087d19a6so42705801fa.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 13:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1697486722; x=1698091522;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8KyP587cR0OS43yzXGPAz0ILpCo1XRGNXYcQ07Wk9A=;
 b=Y2eP+ZOZKavkcTIS8tgzEHnayVOZ3FGLBI6wEjudOwj/In/6o2HTqilZ1y7dUyUla9
 KVO2H0Tpy7Y5RkRdDbI+XzvKZ8H4KO42pIzdYV+yy5DxCgYpylkb2OPAz01dHuF5fg7M
 ND832UhyNdBPbNwmA07beTK2iMMAUPlObQqo5CPWLVRY0/yBkJoShV0Lw0tkRGfhEZCt
 q8tSF8KB/TpJF7JA+1omjTdDsmAlnZo+TYYd4WfMurjoFEgH0u+0azhcwH+W6LdUUQY7
 HNhXU6hQ4sttHeQsCJnU+cwoaUfGhSCyixoHfSea4IjhBHT0jm7+acQ8mUUnfYQeZj2E
 szsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697486722; x=1698091522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8KyP587cR0OS43yzXGPAz0ILpCo1XRGNXYcQ07Wk9A=;
 b=nLfV2I6CHxVIsoDcV0NYoHJguA6muAvyoN/WhLPkNz1PV8L9PgSn3iS8Y46t2n/LgS
 tJO1PqZ6xSvdbV6MmAa7QL8E2iFFph0xTF+GQgH16haAQhMgz5R1FvyKii/+utT/CvLN
 kiJN+TmElja8Lj7oa18qhKkhSPaMYsqU+jdkKp1cQGY7Yvtlbkh0bwpOTuPbcdrHc6Sz
 zVjncGgjZ8R28R09on+tpnfBfqY63wIJ4CdgWoDvW+OXmgc3hqL2v6y9rMkAXj20rMIp
 0yZZUBl8ADOElCjT6wDQ5nZGI0/yQhQwo25l2kThbv/EzcD6jmTAs2cG3GpouYCxl33Y
 OORw==
X-Gm-Message-State: AOJu0YwpX1T1WoTN2XZK+anOztbdQwLeJCPjMxxc1D8R/h5RFZ+QRyLM
 /XUmaitZ6t3dBMELA+4gCObVtd+KsXO5SfI4TFb9OA==
X-Google-Smtp-Source: AGHT+IFk99i9t4AJ4l9O7dw4/Zg3KUd7uWH+DHtVfBgrwp7AJgjlKIrIMo8GBU6kVlhljkFrHnlS5DshWU/V+Q3Z8eA=
X-Received: by 2002:a05:651c:552:b0:2c5:12c4:5ff with SMTP id
 q18-20020a05651c055200b002c512c405ffmr273746ljp.17.1697486722256; Mon, 16 Oct
 2023 13:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230922140914.13906-1-phil@philjordan.eu>
 <4319fcd1-981c-4ef0-b6b9-1f7f57c1c4ca@redhat.com>
 <CAGCz3vuF1=Ee6_G+23QJD-u+-cY0jVJW8kz9Lrgz+KAoMMy1=w@mail.gmail.com>
 <CABgObfaCFS08LgJ2cYKLdqD=cquW3i475fvZFMnA4ih5r+vnGA@mail.gmail.com>
In-Reply-To: <CABgObfaCFS08LgJ2cYKLdqD=cquW3i475fvZFMnA4ih5r+vnGA@mail.gmail.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Mon, 16 Oct 2023 22:05:10 +0200
Message-ID: <CAGCz3vvZFNvcqrUXccg+JBeu2ZJoEMU0uJwvWeGBXF9AHdjT0w@mail.gmail.com>
Subject: Re: [PATCH 0/3] hvf x86 correctness and efficiency improvements
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, dirty@apple.com,
 qemu-devel@nongnu.org, rbolshakov@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: neutral client-ip=2a00:1450:4864:20::22e;
 envelope-from=lists@philjordan.eu; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

On Mon, 16 Oct 2023 at 18:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > switching to hv_vcpu_run_until() WITHOUT hv_vcpu_interrupt()
> > causes some very obvious problems where the vCPU simply
> > doesn't exit at all for long periods.)
>
> Yes, that makes sense. It looks like hv_vcpu_run_until() has an
> equivalent of a "do ... while (errno =3D=3D EINTR)" loop inside it.

Thinking about this some more, I wonder if it's worth putting together
some test code to check empirically how signals and hv_vcpu_interrupt
interact with each of the 2 vcpu_run implementations. It should be
pretty straightforward to establish whether calling hv_vcpu_interrupt
*before* hv_vcpu_run*() causes an instant exit when it is called, and
whether the signal causes hv_vcpu_run() to exit. (Based on observed
behaviour, I'm already pretty confident hv_vcpu_run_until() ignores
signals until it exits for other reasons.)

> > 1. hv_vcpu_run() exits very frequently, and often there is actually
> > nothing for the VMM to do except call hv_vcpu_run() again. With
> > Qemu's current hvf backend, each exit causes a BQL acquisition,
> > and VMs with a bunch of vCPUs rapidly become limited by BQL
> > contention according to my profiling.
>
> Yes, that should be fixed anyway, but I agree it is a separate issue.

I've locally got a bunch of very messy patches for reducing BQL
acquisition in the x86 HVF vCPU loop. I found it difficult to make
much of a real difference however, and the code gets a lot harder to
follow.

- Decoding instructions that need emulating can be done outside the
lock. Actually running the instruction typically ends up causing an
action that needs it though, so the win isn't that big.
- With hv_vcpu_run() there are a bunch of (EPT fault) exits that don't
really need anything in particular to be done. Or instead of detecting
those outside the lock you can switch to hv_vcpu_run_until() which
avoids those exits altogether.
- KVM's vCPU loop calls into MMIO faults without the BQL, but they
acquire it internally I think?
- Going from xAPIC to x2APIC reduces the number of exits, and using
MSRs is a bit quicker than walking the memory hierarchy, so that
definitely helps too, but the APIC implementation still needs the BQL
held, and untangling that is probably harder than switching to an
in-kernel APIC.

Beyond that: there's a good chance that turning the BQL into a
read-write lock would help, but that's a much bigger undertaking than
I'm currently willing to entertain!


Re hvf fd:
> I think fd and the HVF type should be placed in an anonymous union.

Taking a look at the code and thinking through the implications, I'm
not actually sure what the intention of the union is? IIRC Qemu is
built with strict aliasing rules disabled, but there seems little
point in actively using union aliasing here? We can just as easily
modify this block at the top of hvf_int.h:

#ifdef __aarch64__
#include <Hypervisor/Hypervisor.h>
#else
#include <Hypervisor/hv.h>
#endif

to something like:

#ifdef __aarch64__
#include <Hypervisor/Hypervisor.h>
typedef hv_vcpu_t hvf_vcpu_id;
#else
#include <Hypervisor/hv.h>
typedef hv_vcpuid_t hvf_vcpu_id;
#endif

And then:

struct AccelCPUState {
    hvf_vcpu_id fd;
    void *exit;
    =E2=80=A6

Or perhaps this variant, if we want AccelCPUState to have consistent
size/alignment properties, we can use a union after all, but never
actually use the fd_padding field:

struct AccelCPUState {
    union {
        hvf_vcpu_id fd;
        uint64_t fd_padding;
    };
    void *exit;
    =E2=80=A6

(Or is that what you were thinking of with the union idea in the first plac=
e?)


Thanks,
Phil

