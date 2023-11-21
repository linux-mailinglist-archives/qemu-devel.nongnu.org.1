Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6427F349D
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 18:12:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5UHl-0000y9-H3; Tue, 21 Nov 2023 12:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r5UHj-0000xf-B2
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:11:39 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r5UHa-0003N1-CN
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:11:39 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-332cb136335so1301819f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 09:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586688; x=1701191488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkOhM8dapNX+/sH8SYvgJ0qeJJ0Vp7T02f+Oy7bahps=;
 b=G1mWglEPWZtv/KDAGgGovp2ryUlet2D/8t324oQKskihFqAPU6MXwuUuNYegz+NqVY
 1oKG1y5s1UQB+LhwuvVwhgP+dYazUC9VQ4atNQa0HbBzAe8k453iRjUkwpHAW/zanAw7
 fLVXgswR6uVCMPk/JbPLiuDW7qHAi+fhGpZ4f20biVnmydqLgcGRwTlPsRNtEj7GjU0B
 Oo0wIsrCsegiH6cg06j8aKhHf7MBv0/bqOPABx5Igm6vGhXH7bdNgOyETBRR6fnYl4ZB
 HioLj8AV3uIM2iGLnNkZodeQoU440cESFXiJ0LdPnaSF+X0mPtfD4S7lf9VeDzPxCY9a
 dLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586688; x=1701191488;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vkOhM8dapNX+/sH8SYvgJ0qeJJ0Vp7T02f+Oy7bahps=;
 b=rvPSjQEvdGSyuzjX0IOBpKKu1PLuqzICGq/mGTOZIcRFHoV5AiuHXVq2T7woKWMpya
 7jc7AMprhIo2QfAd6IsZhczs3JPzkuqcXDoebzBAC2q28x0VPx3K40Hflx01iOmgkpbn
 D4CuxoVbQnX1A42sBLkPmAeAMB4Vxvd5ZaYBsUNyxIb6Wi5RoR5aB4hzS7mY5vZsC11T
 IgWweQ6ozznsWZbl9KftkkiNAMBCKU5hhK2Rm3azP5cOlyTR8iqsNSCPXspxY0OJPxBU
 7A7+ceFmViBPQcA3G2EDhGlsquB2RagH3Xb14hVdAt1zwIpD+kv3OcoPEi3+0uGk0GHQ
 mrkg==
X-Gm-Message-State: AOJu0YyxqcIKVUJn7Opt1+dqi5dlZoXAs9h8CmaJPNnApbKV6QjDtUzK
 VX4Z7spm1xyjgMd9/ipOE07yk8UGZvHTP/ibkXrhmQ==
X-Google-Smtp-Source: AGHT+IGnbzkxrnQ4vJpUZxexTGucP09lmWUtd9p8FeIwoOs1/P1HHCivEIi7CIRYY3huChSVTEGnjA==
X-Received: by 2002:a5d:59aa:0:b0:332:c9d8:c5f8 with SMTP id
 p10-20020a5d59aa000000b00332c9d8c5f8mr5292154wrr.9.1700586688478; 
 Tue, 21 Nov 2023 09:11:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 dd11-20020a0560001e8b00b0032db8f7f378sm14920839wrb.71.2023.11.21.09.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:11:28 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BF2935F74B;
 Tue, 21 Nov 2023 17:11:27 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: QEMU Summit Minutes 2023
In-Reply-To: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
 (Peter Maydell's message of "Thu, 13 Jul 2023 14:21:15 +0100")
References: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Tue, 21 Nov 2023 17:11:27 +0000
Message-ID: <87edgjf2v4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> QEMU Summit Minutes 2023
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> As usual, we held a QEMU Summit meeting at KVM Forum.  This is an
> invite-only meeting for the most active maintainers and submaintainers
> in the project, and we discuss various project-wide issues, usually
> process stuff. We then post the minutes of the meeting to the list as
> a jumping off point for wider discussion and for those who weren't
> able to attend.
>
<snip>
>
> Topic 2: Are we happy with the email workflow?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This was a topic to see if there was any consensus among maintainers
> about the long-term acceptability of sticking with email for patch
> submission and review -- in five years' time, if we're still doing it
> the same way, how would we feel about it?
>
> One area where we did get consensus was that now that we're doing CI
> on gitlab we can change pull requests from maintainers from via-email
> to gitlab merge requests. This would hopefully mean that instead of
> the release-manager having to tell gitlab to do a merge and then
> reporting back the results of any CI failures, the maintainer
> could directly see the CI results and deal with fixing up failures
> and resubmitting without involving the release manager. (This
> may have the disbenefit that there isn't a single person any
> more who looks at all the CI results and gets a sense of whether
> particular test cases have pre-existing intermittent failures.)

If we are keen to start processing merge requests for the 9.0 release we
really should consider how it is going to work before we open up the
taps post 8.2-final going out.

Does anyone want to have a go at writing an updated process for
docs/devel/submitting-a-pull-request.rst (or I guess merge-request) so
we can discuss it and be ready early in the cycle? Ideally someone who
already has experience with the workflow with other gitlab hosted
projects.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

