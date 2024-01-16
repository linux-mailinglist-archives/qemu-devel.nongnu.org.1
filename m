Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC43182F1A7
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:36:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPlTe-0002rU-9i; Tue, 16 Jan 2024 10:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPlTb-0002rE-IE
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:35:43 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPlTZ-0001fH-TK
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:35:43 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5534dcfdd61so17645790a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705419340; x=1706024140; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5/HxhFNv2D0FhjaUowOiVQsUgxb47pxbOi1FkGS7kjk=;
 b=dG948k5z2kWIV/jF9+UO9kSGiEBSwooDc9Rtw44CSV7fRlGNfEjoHYHMjPq50TY3FE
 gDIwbYgrppqxfACGrl4rsGTOw2pAUEc4F1eJaASwxxJfPCZIJRLKuMUt0H8UlyhpzcKC
 gJRmblQxVUTRGBKxIcVar97Cgk1IGTv/6sabqHRIKbr01r+dMqI7u/ByMchGqWczNnfP
 7TW4FDX1FQBvL9EIbS7uc3mCNIZ+8rl6AniZFyqSMJnghDF3k6FkugxzRYuEa8VRnVMY
 ccvvytrodXYR/1m7Hwf+t8ACLWEQoYfAGxX9PBp5tPXUI81U6+pbBRmfXDSz4vNdVgcg
 cKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705419340; x=1706024140;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5/HxhFNv2D0FhjaUowOiVQsUgxb47pxbOi1FkGS7kjk=;
 b=u1MQ8P5vf1a4WkP6X8KvHuuSBPm4o6fcfINIMDuAemf4PDCi3+71OOj/5Bfjd019gr
 f6aRswRZPnxpHsEdUuPcyWQ1BQwOx+VDPIGC9z+VKWDRwk+m028H0td47FdaXm3j6M0u
 U0I4RDWy9QNHQa1aYLazdDSNsoFo26xL/2URYGzkqGdFYvvfIsHDyzzCn6ZVm2Nygknm
 6YQnCCJA5Nb8Qr4HV+Zef+jXomxue5rNvIT3A5Gop5VIo+oGxsYGqi0DMp6nPDO+Kr/a
 HVhQ0jivOqboZORBNZE18Wq7p4nkC1S6BXRnVhuXAM7ZTeNOuzt3/Msd6d3OQkX1YX2g
 gVxA==
X-Gm-Message-State: AOJu0YxbuJ6Lq4ZU9CNe9VZbcufL99+6QiPvB87HSaCPvPFL9xMkWic1
 yvQBOYqfltwk+ObqYa9qW5mKuSAe190PF0LSrVTR1LYyXvybvhbolnPpLZrz
X-Google-Smtp-Source: AGHT+IHlhGpNVMFHYRoZwDnx620uYLkgEz63nS3nYDkC+lXqRSskY7kMAG+L9qy30RkzVBe1vzW4Jhjbj3KEWAY6aZ8=
X-Received: by 2002:a05:6402:1747:b0:558:308f:db04 with SMTP id
 v7-20020a056402174700b00558308fdb04mr6919837edx.18.1705419340383; Tue, 16 Jan
 2024 07:35:40 -0800 (PST)
MIME-Version: 1.0
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-28-peter.maydell@linaro.org>
 <20240116130940.00002523@Huawei.com>
 <CAFEAcA-94-TeFw4AmTsuQaJROADaet8aWDEBXbt9H_gc1Fs6pg@mail.gmail.com>
 <20240116145051.000004f7@Huawei.com>
 <CAFEAcA8=CK00w_Yk-X=+6cm2X5BWSiTw7_y6uQN8qyFHF4-iFg@mail.gmail.com>
 <20240116152919.00001571@Huawei.com>
In-Reply-To: <20240116152919.00001571@Huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2024 15:35:29 +0000
Message-ID: <CAFEAcA-txzOZ_Z0x3n+idTLp-3QevV_Jpur74kdCOhFmBy1Atw@mail.gmail.com>
Subject: Re: [PATCH 27/35] target/arm: Report VNCR_EL2 based faults correctly
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 16 Jan 2024 at 15:29, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 16 Jan 2024 14:59:15 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > On Tue, 16 Jan 2024 at 14:50, Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Tue, 16 Jan 2024 13:20:33 +0000
> > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > > > Bisecting to this patch is a bit weird because at this point
> > > > in the series emulation of FEAT_NV2 should be disabled and
> > > > the code being added should never be used. You could put
> > > > an assert(0) into the code in translate-a64.c before the
> > > > call to syn_data_abort_vncr() and in arm_deliver_fault()
> > > > assert(!is_vncr) to confirm that we're not somehow getting
> > > > into this code for some non-FEAT_NV2 situation, I guess.
> > >
> > > Not that, but surprisingly is_vncr == true.
> > > in arm_deliver_fault()
> > >
> > > Frigging that to be false gets me up and running. I'll see
> > > if I can figure out why it is set.
> >
> > I don't know if this is the cause, but looking again at the
> > line that sets is_vncr I see at least one obvious bug:
> >
> >     bool is_vncr = (mmu_idx != MMU_INST_FETCH) &&
> >         (env->exception.syndrome & ARM_EL_VNCR);
> >
> > is testing the wrong variable -- the first part
> > of the condition should be "access_type != MMU_INST_FETCH".
> >
> > If you fix that does the failure go away ?
> Ah - indeed that fixes it.
>
> I guess that makes sense. Presumably the bit is used for
> something else for instruction fetches.
>
> Thanks for your quick help!

Thanks for testing -- I'll send out a proper patch in
a bit.

-- PMM

