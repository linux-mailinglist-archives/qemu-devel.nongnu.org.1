Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B8A772A0C
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:04:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2iB-0007r8-At; Mon, 07 Aug 2023 12:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT2hv-0007kF-94
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:03:47 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT2hq-0003sI-4k
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:03:46 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52229f084beso6761677a12.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691424213; x=1692029013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BqlSwqtWfZFqPtWTSC0dyvu40q9wfFn8aMWpB6TpW/4=;
 b=tEChj8Bc+w61pBjQ8J8bB69EID36WaOzA7T5I0qrLMuSNTh3D2mW6PvWJmh9ZrDIFf
 NNosjYO5E0VMsTKHqjzMhTtp94ASnydwYKpuBFe7x5KSHZZrcw0ollt2TvuW5vQvVRh9
 VtHIKTEjkzMNAnthz97RioF45IB7YhOfMyGh0uh5TjTRZOrC5pbPYdrfoAHIo+N/wtYD
 PTPJbO7OhjPtt8ZiQSW/Uxwwv5yrhV5tubNf/wOteJdj7yxttpzL1K8PSSDstY9c4O1n
 f94fuJEm0jGV2dd0nSEMKU8oJbVWdf/IzpD8OxkYpLlcrdENT9kF1hCuEtrWLup+E7f6
 EjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691424213; x=1692029013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BqlSwqtWfZFqPtWTSC0dyvu40q9wfFn8aMWpB6TpW/4=;
 b=D69941WGnSu43/1glI8wGiper9WxRIcmukt08ZcCmd5JIooRNXSRK55S7siOw4Mak/
 nW27U0SoOr0ulwJCxFpdiYBZQhf0J6N4gRR3T1fXikP/O0zoeZ8BBAvLOMIujMPMD7/n
 GqKC/j7V9zhOkDPmiQBRyYS0LLshnVQIZe4OaCf7U4CeuO25/AsULxsUSIB+j7R4y59Z
 IBfskCTzmypdEY6S/lhxBKxKHQf+K0rCbSQY9hO/zhhzKhcPtUqYkzc0JAY+BYIEB4d/
 84rdoQS+7S47jdxNU+ZnZRKCreZB6qJI3/nLV/eAOQtHTLIGh2wuSoEqx2SR4/K1qMje
 w9Uw==
X-Gm-Message-State: AOJu0YwATzTGODGkQgtULRzAzREbTVBAWqbyRyvXtwqcJDeY7EYB4ub9
 MeG98lqZRACMsBtYVjQZdXGPl8c6C3IbpD79ccFtXw==
X-Google-Smtp-Source: AGHT+IGzQc3H95rd4st1PU6xJZFL5cgI1wGqjquI3GUQC0csHgvfwIxEz4aPu0T88fjMbj0d3iNnP4VTZaCT2d7clxk=
X-Received: by 2002:a05:6402:754:b0:522:806b:8f4a with SMTP id
 p20-20020a056402075400b00522806b8f4amr8483142edy.32.1691424213242; Mon, 07
 Aug 2023 09:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230805180214.57198-1-richard.henderson@linaro.org>
 <CACPK8XdWpOhwKrdxh+NoMMkP=63g7ib1PdXSrR8f1snAsLu8Nw@mail.gmail.com>
 <609387ae-de8e-61bf-842a-b277ecfc345c@linaro.org>
In-Reply-To: <609387ae-de8e-61bf-842a-b277ecfc345c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Aug 2023 17:03:21 +0100
Message-ID: <CAFEAcA9fc75qiPFnx5435Bv9dy9UBUNT-bPo4iLmgi26Mv=dcw@mail.gmail.com>
Subject: Re: [PATCH] configure: Fix linux-user host detection for riscv64
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 7 Aug 2023 at 17:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/7/23 01:26, Joel Stanley wrote:
> > On Sat, 5 Aug 2023 at 18:02, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Mirror the host_arch variable from meson.build, so that we
> >> probe for the correct linux-user/include/host/ directory.
> >
> > This broke all of the linux-user targets for me on a ppc64le host.
> > None show up when running configure --help, and trying to select one
> > with --target-list errors out:
> >
> >    ERROR: Unknown target name 'aarch64-linux-user'
> >
> > Reverting this patch restores the old behaviour.
> >
> > This test is the one that fails with the patch applied:
> >
> > if [ "$linux_user" != no ]; then
> >      if [ "$targetos" = linux ] && [ -d
> > "$source_path/linux-user/include/host/$host_arch" ]; then
> >          linux_user=yes
> >
> > WIth your patch $host_arch is ppc64le. Previously the line was:
> >
> >   if [ "$linux_user" != no ]; then
> >       if [ "$targetos" = linux ] && [ -d
> > "$source_path/linux-user/include/host/$cpu" ]; then
> >        linux_user=yes
> >
> > The directory needs to be /linux-user/include/host/ppc64 for even for ppc64le.
> >
> > You've put the new test just above the switch statement that does
> > normalisation of the host CPU name. Could add riscv to that switch
> > statement instead of adding the host_arch variable?
> >
> > @@ -508,6 +501,9 @@ case "$cpu" in
> >       cpu="ppc64"
> >       CPU_CFLAGS="-m64 -mlittle-endian" ;;
> >
> > +  riscv*)
> > +    cpu="riscv" ;;
> > +
> >     s390)
> >       CPU_CFLAGS="-m31" ;;
> >     s390x)
>
> Grr.  No, I cannot simply do that, because passing "riscv" and not "riscv64" to meson also
> breaks things.  See e3e477c3 and 887cba85.
>
> I'll figure out something else.

Did you see Paolo's patchset?
https://patchew.org/QEMU/20230807094807.471646-1-pbonzini@redhat.com/

-- PMM

