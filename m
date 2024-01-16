Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E16982EFA9
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 14:22:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPjNQ-0000oW-B9; Tue, 16 Jan 2024 08:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPjN5-0000o6-7f
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:20:51 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPjN1-0002V7-4B
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:20:50 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5592d1bc4fbso2513160a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 05:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705411245; x=1706016045; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tkwoDVlLqRXVUSTuDgmc6wD0FLwW/mNGEfVVUweFZtI=;
 b=FedO34IENOC7TzPRlodF8oy79+E2eCVi35IK4JQdSOoQDBpgVcJcEzmvp4lIY19vz0
 oFoIMx8+tl0XIZVxJ7S4FgeFl71gJpXXykp01fdwyczXApuxoXfmtrSw5k1NznKp8uMU
 75EUdaA1JQrJGwZ+F+ODr7oWb7r/4XQz6zVsOYfIbCUn5J/ww/6dUqIxF+mY+930LYyE
 ehgvsofUf7TZQhmS1pGaF49SYqY3Uswspm7S36+ueG2ibS4yuUKHAxUbLv91HWUNX96d
 hUp7EC59LigQHz9ssdE5X+0KualjgmT1OdcGiB5hLOxtwYbIKbchsWnMTtbJ8G05qrHV
 ExoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705411245; x=1706016045;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tkwoDVlLqRXVUSTuDgmc6wD0FLwW/mNGEfVVUweFZtI=;
 b=osjKlNJpZW2d3M0dVIJTYV+psCjnkL12WYLKZse+aP07U8HPJOCu/N32EHc98dadMF
 Ie+yks2gQnluTtd5WXmzsipoY6eoXy+3+PDpWVHtMOC18vl7yPQA0nNjMC7I8KNXKT1s
 U//+H8xPZb/W5b9IVbeoIoZSbU+HsiXKICzGIO5JmZhV5G87kWYluMLiIPTcMa2+Fcxi
 l9C6ZK+zpoZBa9NUoDrZyPhiwkzEGQplZkQQyJRbZwKirfkkEoJ28Ebbq0k+f26IxVwO
 DVEgJU9Wtq1DEAEw9f63iqGlFIP4ATdF7zdZr0DWOYQk9yXpB9R2lNnyP+HQ+XBXeXEn
 x05w==
X-Gm-Message-State: AOJu0YzkhB/FogMbUIOJ+8wdOmrpx6ZCSkd6e5W2ixdve72BBODm2taa
 l7yRSJ5Z1JrE5CqPQj83wJQ8Bvn/5bNO7SyTvtFIKMk/jmzVSw==
X-Google-Smtp-Source: AGHT+IFf3PNzy6neZAfvNrUGcq0nwrIla5pa7a8rkXckZ5SDW7zrCsRHL9gyE6d//gv29fhbNcZ6vLTaznFdM8vQP0g=
X-Received: by 2002:a50:fa94:0:b0:54c:60f0:7511 with SMTP id
 w20-20020a50fa94000000b0054c60f07511mr3263070edr.35.1705411244810; Tue, 16
 Jan 2024 05:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-28-peter.maydell@linaro.org>
 <20240116130940.00002523@Huawei.com>
In-Reply-To: <20240116130940.00002523@Huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2024 13:20:33 +0000
Message-ID: <CAFEAcA-94-TeFw4AmTsuQaJROADaet8aWDEBXbt9H_gc1Fs6pg@mail.gmail.com>
Subject: Re: [PATCH 27/35] target/arm: Report VNCR_EL2 based faults correctly
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 16 Jan 2024 at 13:09, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 18 Dec 2023 11:32:57 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > If FEAT_NV2 redirects a system register access to a memory offset
> > from VNCR_EL2, that access might fault.  In this case we need to
> > report the correct syndrome information:
> >  * Data Abort, from same-EL
> >  * no ISS information
> >  * the VNCR bit (bit 13) is set
> >
> > and the exception must be taken to EL2.
> >
> > Save an appropriate syndrome template when generating code; we can
> > then use that to:
> >  * select the right target EL
> >  * reconstitute a correct final syndrome for the data abort
> >  * report the right syndrome if we take a FEAT_RME granule protection
> >    fault on the VNCR-based write
> >
> > Note that because VNCR is bit 13, we must start keeping bit 13 in
> > template syndromes, by adjusting ARM_INSN_START_WORD2_SHIFT.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Hi Peter,
>
> I'm getting an unhelpful crash on calling init in a guest
> running on top of an a76 emulated host with virtualization turned on.
>
> Run /sbin/init as init process
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007
> CPU: 1 PID: 1 Comm: init Not tainted 6.7.0+ #1119
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0xa0/0x128
>  show_stack+0x20/0x38
>  dump_stack_lvl+0x48/0x60
>  dump_stack+0x18/0x28
>  panic+0x380/0x3c0
>  do_exit+0x89c/0x9a0
>  do_group_exit+0x3c/0xa0
>  get_signal+0x968/0x970
>  do_notify_resume+0x21c/0x1460
>  el0_ia+0xa0/0xb0
>  el0t_64_sync_handler+0xd0/0x130
>  el0t_64_sync+0x190/0x198
> SMP: stopping secondary CPUs
> Kernel Offset: 0x2a8c93a00000 from 0xffff800080000000
> PHYS_OFFSET: 0xffff82f980000000
> CPU features: 0x0,00000001,7002014a,2101720b
> Memory Limit: none
> ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007 ]---
>
> Upstream kernel as of yesterday.  Nothing particular 'exciting' in the
> configurations. Not attempting to use Nested virt.
> -M virt,gic-version=3,virtualization=true
> -cpu cortex-a76 (happens with max as well but switched to a76 for testing
> to reduce possible sources of problems).
>
> Doesn't happen if single cpu in the guest, or if using gic v2 in both.
>
> Bisection points at this patch - so far no idea why but I've only
> just started digging into this.

Bisecting to this patch is a bit weird because at this point
in the series emulation of FEAT_NV2 should be disabled and
the code being added should never be used. You could put
an assert(0) into the code in translate-a64.c before the
call to syn_data_abort_vncr() and in arm_deliver_fault()
assert(!is_vncr) to confirm that we're not somehow getting
into this code for some non-FEAT_NV2 situation, I guess.

thanks
-- PMM

