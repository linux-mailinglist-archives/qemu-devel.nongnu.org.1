Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1126B76171B
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 13:45:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOGTA-0004Dr-DE; Tue, 25 Jul 2023 07:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOGT2-0004Ay-Q8
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:44:41 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOGSy-0000tB-Uz
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:44:38 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fb73ba3b5dso8521351e87.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 04:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690285475; x=1690890275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dy6gUUpyY1tsrF+wYaTCl+emf+qhMnXdq96FnmbipUw=;
 b=mBABnQLzJMJSOzgeRCOJ+uLsVj0qidWA1BW8PiYLnPT7qTdIr8EKXssYqeYkqq1si3
 GNM1lReAB6Iu+1YKpxOXXuOk53GB0UmcEjcbEK9MXqQk6hrfFZWT8BNpTdIHrpWdWRA+
 IJ4NA6UZ2lsuu8KDlj6nM0QhUiq8eeIj3Ezp7QvmeOWsAoEQ8GsOrz+FrM6qW/518It7
 us6ykIJj7UMBXYJy9oRZtSAFuHWh6ZbBbn3iehYwuj4Z9K+SqSGsuQVxBzscExbMgL/m
 cJHkRbOBM2RCGCafzZYPJK2kJ+zlASsag+YIopZfudnXu0fDACN9Ylsd6Gfz3ZeKKmsp
 zQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690285475; x=1690890275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dy6gUUpyY1tsrF+wYaTCl+emf+qhMnXdq96FnmbipUw=;
 b=ZFelqZLY3ZC7MXhe4tLSZBgtmcUfh3X8dRGgmUJ4JusuNaIJQ0PiHcehM4nVQiupj0
 xA1AIAj8SvTnQjZMTC0CTH6Vt1xmvl3/sS/9nDcjNy+LgbY4UFpWaCUJe+enf9eIYKwL
 RkcTnvM0dD8gacKzBmqgVbIa9hzC8dzuLljPt4VW3vRFbh1eVQq0Wmd1Z/pK+/KiiiTF
 moMJdwWXTD1PSgOmtt0whTQkYdcVUO8X3i0klPm6cbGuG+g2JbXyhPLBL4I/0gXY7Bm2
 HYxXRJ//rEO2ivSWCqJi0VnxRGEi132xkYtu2PPR5m195aMzfgKv6vJlGE29tpKaIlHV
 eaEw==
X-Gm-Message-State: ABy/qLaQAhEb1zTi0gUTqSN/Nv5ZpFaQJjJvrFltCyg9pwATG8GyYFRR
 QZMfJz1GAOclV9W0Va3hu2egX2h7kHx6Zm7OQl1OFg==
X-Google-Smtp-Source: APBJJlG6ouAyNDUqNNATO2eaofQOsDQyLvEdBFDCDIBPGt1J/rKVAp8S2THc7guSRQ1CF5WtL8jrwSmfAQspTj2QmuE=
X-Received: by 2002:a05:6512:3a95:b0:4fd:d9e0:4d79 with SMTP id
 q21-20020a0565123a9500b004fdd9e04d79mr8122555lfu.6.1690285474964; Tue, 25 Jul
 2023 04:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230724165349.55714-1-thuth@redhat.com>
In-Reply-To: <20230724165349.55714-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2023 12:44:24 +0100
Message-ID: <CAFEAcA_kHEmP16N22CZqquc9JO9Xg+duv6ebWKwPAtkaMjcTOA@mail.gmail.com>
Subject: Re: [PULL 00/16] s390x fixes
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004e005006014e413e"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--0000000000004e005006014e413e
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jul 2023 at 17:53, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit
885fc169f09f5915ce037263d20a59eb226d473d:
>
>   Merge tag 'pull-riscv-to-apply-20230723-3' of
https://github.com/alistair23/qemu into staging (2023-07-24 11:34:35 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2023-07-24
>
> for you to fetch changes up to bd39b7b5f34c2f6b9272bf281ee0324cb07fc3ee:
>
>   tests/avocado/machine_s390_ccw_virtio: Skip the flaky virtio-gpu test
by default (2023-07-24 18:44:48 +0200)
>
> ----------------------------------------------------------------
> * Fix emulation of s390x instructions: CKSM, CLM, ICM, MC, CLGEBR(A)
> * Remove useless and non-working s390x migration avocado tests
> * Fix loongarch CSRRD CPUID instruction when running on s390x hosts
> * Disable flaky s390x virtio-gpu test by default
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.1
for any user-visible changes.

-- PMM

--0000000000004e005006014e413e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, 24 Jul 2023 at 17:53, Thomas Huth &lt;<a h=
ref=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br>&gt;<br>=
&gt; The following changes since commit 885fc169f09f5915ce037263d20a59eb226=
d473d:<br>&gt;<br>&gt; =C2=A0 Merge tag &#39;pull-riscv-to-apply-20230723-3=
&#39; of <a href=3D"https://github.com/alistair23/qemu">https://github.com/=
alistair23/qemu</a> into staging (2023-07-24 11:34:35 +0100)<br>&gt;<br>&gt=
; are available in the Git repository at:<br>&gt;<br>&gt; =C2=A0 <a href=3D=
"https://gitlab.com/thuth/qemu.git">https://gitlab.com/thuth/qemu.git</a> t=
ags/pull-request-2023-07-24<br>&gt;<br>&gt; for you to fetch changes up to =
bd39b7b5f34c2f6b9272bf281ee0324cb07fc3ee:<br>&gt;<br>&gt; =C2=A0 tests/avoc=
ado/machine_s390_ccw_virtio: Skip the flaky virtio-gpu test by default (202=
3-07-24 18:44:48 +0200)<br>&gt;<br>&gt; -----------------------------------=
-----------------------------<br>&gt; * Fix emulation of s390x instructions=
: CKSM, CLM, ICM, MC, CLGEBR(A)<br>&gt; * Remove useless and non-working s3=
90x migration avocado tests<br>&gt; * Fix loongarch CSRRD CPUID instruction=
 when running on s390x hosts<br>&gt; * Disable flaky s390x virtio-gpu test =
by default<br><div>&gt;</div><div><br></div><br>
Applied, thanks.<br>
<br>
Please update the changelog at <a href=3D"https://wiki.qemu.org/ChangeLog/8=
.1" rel=3D"noreferrer" target=3D"_blank">https://wiki.qemu.org/ChangeLog/8.=
1</a><br>
for any user-visible changes.<br>
<br>
-- PMM<br>
</div>

--0000000000004e005006014e413e--

