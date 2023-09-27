Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E67627AFFD0
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 11:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlQkQ-0005kP-Tx; Wed, 27 Sep 2023 05:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlQkJ-0005kC-Ch
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:22:15 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlQkH-0002wu-Np
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:22:15 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5344d996bedso5295174a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 02:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695806532; x=1696411332; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CjmV6Vw36svKzJfO8ubl2chHHm5/JkDvWApKWCdx6hY=;
 b=eizqogNCM+bu3pgx5s1d4W3nEyKQfRABRYqdIsW+PGbiyasesfG58B97dJVHdaeyed
 IVsz+ps18rOiSy5G4vr/N5Qg/AD9p8V2GWdEROI6pj2iKzeIAmo5dqnzbCAICUbDlEtT
 C+hetKYvjub3BysHrT6vp/OVy+r/OspmBMe0Mu0IQSaeGox/92jntuLaflo99L08Xufy
 W6Ny79PTOo/Q9c5oEBgIxi68rIIALH7wrZCc36rQjM1tfR2PEWGC+7fnxh1SHzXJ45Fp
 42kz4Zg/aGMYJg0AMLc4XOOSgctrloHPfhBP5qUYFb4FMuV1AM0INquVQyd8lKvw7Quz
 z4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695806532; x=1696411332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CjmV6Vw36svKzJfO8ubl2chHHm5/JkDvWApKWCdx6hY=;
 b=iG3FCPyv1Abo99ZDVa3wLAw9yqC3v6PEPOULwh8kCJ03nHVeMQrHCmiAU2rtAFj7ET
 vce492IcKfqcnrl2rmwNTfmluVav5SNfxJqiF6bw9S1GCksbxWKkY2N5xx+vx7/twTc/
 NnbaZhv/pAd/ifXpNEamSxLYV1QP2GCL0DuIjZBGQq6OIYKyjeUoOQAPe8N4/jmQqXzX
 Kp7i/LxwSfXyy9tCSeDJL64iNUOYySgM5VKElDW2U6rCLJUbgl8Yhs/Fzzpes4xKhe2e
 7mYwEZakU6oSExUY7wwWJI4LURWigLdl8U9LxdMdc2HxLExfyuP5/ildWaq0YbkaQe+v
 DacQ==
X-Gm-Message-State: AOJu0YwYPF6QZ9nmevkjkJYZ1pEgGZPwkQkPBUCLkIQPenzums3Hi/lM
 FwN+jGosIAyUz6ARWI24fmTQSd7gx4kTer4TO21hPlsMfzCnHlvN
X-Google-Smtp-Source: AGHT+IFdKiYkfuL35X/2c+fEn6jF9hj9YErAmeFVlVo+qpcVmSwut59Sm2hXjWuYTEHgEbVxLTsQBmq9p4grkp2Ai3U=
X-Received: by 2002:a05:6402:3d7:b0:532:b5cb:114a with SMTP id
 t23-20020a05640203d700b00532b5cb114amr1533743edw.23.1695806531900; Wed, 27
 Sep 2023 02:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230926203946.3303600-2-eblake@redhat.com>
In-Reply-To: <20230926203946.3303600-2-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 Sep 2023 10:21:53 +0100
Message-ID: <CAFEAcA8zf4odT13FJF=MgSnCiZnRYDF5PDuL40CMe0KPh3kTNw@mail.gmail.com>
Subject: Re: [PATCH] maint: Tweak comment in mailmap to sound friendlier
To: eblake@redhat.com
Cc: qemu-devel@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 26 Sept 2023 at 21:41, <eblake@redhat.com> wrote:
>
> From: Eric Blake <eblake@redhat.com>
>
> Documenting that we should not add new lines to work around SPF
> rewrites sounds foreboding; the intent is instead that new lines here
> are okay, but indicate a second problem elsewhere in our build process
> that we should also consider fixing at the same time, to keep the
> section from growing without bounds.
>
> Mentioning DMARC alongside SPF may also help people grep for this
> scenario, as well as documenting the 'git config' workaround that can
> be used by submitters to avoid the munging issue in the first place.
>
> Fixes: 3bd2608d ("maint: Add .mailmap entries for patches claiming list authorship")
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>
> I'm sending this email with a temporary 'git config sendemail.from
> eblake@redhat.com', to see if the added advice actually adds the extra
> line. It did not show up in my editor window, though, so this patch
> may need further tweaking to get the instructions right.  Since I
> don't normally suffer from SPF/DMARC munging, I may not be the best
> person to test the right workaround.  Or maybe 'git config' does not
> yet have the right workaround already available as a turnkey solution
> we can suggest.

Well, the From: line appeared in my copy of the email, so I guess it works.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

