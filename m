Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF1375FA9F
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 17:19:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNxKv-0007dT-0R; Mon, 24 Jul 2023 11:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNxKr-0007d7-0V
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:18:57 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNxKo-0008WE-FB
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:18:56 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51e344efd75so9419645a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690211932; x=1690816732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YPPCWbd44Vruy274om05gXAL+ZBzTj85mAKvwFeVnKc=;
 b=zvTvwigEnWSAzGOnWI35j9gW97gDgATEJ50baYMDhijR+XuArR85RGhMAYZX/x+u90
 wPA9MEqvA9PzUhyV1ixiBz5nUfc7l4OC73FlS/XatGQ/LgYk/8513pwlcqRuA/N6ORHb
 imnlImqxxMArMoeAvXQXOy5BMbf75vyjAoIJSjJulfFfWP4Brm0LmfeYW39ZBZq8U7og
 Q+KVXyXAm5Pu/dVKwKt2GG94tsAZRAmELfNfEghjKm9hYB1NuNfHfcgAduBkwxoT+hb7
 W0zNjUOs1iz/sfIJZ1tdZlnWRvcMRIXbxitij8Gvy5XfbREF5p0adyh8qLHmfLGZ36ls
 Fkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690211932; x=1690816732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YPPCWbd44Vruy274om05gXAL+ZBzTj85mAKvwFeVnKc=;
 b=UvJ/IXLjlc4AEKGZs4uyOTj0HtOAef6YS/vzOVjyBYcsWxC9Ec4qzQ/i0bktOwAlHR
 bWFXfRf2oKdBJUEd+EyTgRMUM6A2r9d/gzspvOHom/Uil1OJemQAUf2PtoQlXJo69uKi
 HbLGBoav4cv6eT8BqC5sNbUjS9kDN31m2ZWf9Qm6Ctp7E7b8TeQsi/6aZde89IrXfYb8
 9+F6Ql+8UcPosRcM7Kgi1aegxCqBCy25QZEIoe+rpXY8fjmHhP7YaUY1OwUSZSVJJlg5
 Cxax+b8ddfxGhpthX3MKEXzuFi6HSF3xTPwlKabjI59N4AX4WEI37ULAPIM0B6f0Mk37
 OnrQ==
X-Gm-Message-State: ABy/qLajJdFGY5SVz/TbwDLvox/s8m6xn1k9A6fLaYRgOVXXpBtdC0HB
 zXaYYT2klA1QAwmlqGuNHLwCBqduI6Nc+MCu1TU3hw==
X-Google-Smtp-Source: APBJJlF/TT5r8kpCXNczfSgr/0C6E8XrrHSO03ZgfDc9xAj5Sauzo9LGd9cklqdH/jqHN4IWO82nqhxJ0HoU0I4Gygs=
X-Received: by 2002:aa7:d74f:0:b0:51e:421e:d209 with SMTP id
 a15-20020aa7d74f000000b0051e421ed209mr11151976eds.13.1690211932021; Mon, 24
 Jul 2023 08:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230615045241.5838-1-michael.roth@amd.com>
In-Reply-To: <20230615045241.5838-1-michael.roth@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 16:18:40 +0100
Message-ID: <CAFEAcA9LGhTehpftazkA1E2apKqQeWby6tJsEyy3air1L5xS+g@mail.gmail.com>
Subject: Re: [PATCH] docs/devel: Document the tarball publishing/release
 process
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Thu, 15 Jun 2023 at 05:54, Michael Roth <michael.roth@amd.com> wrote:
>
> This hopefully contains most of the information one would need to
> generate/publish QEMU tarballs and make the related announcements. The
> main goal is to quickly get others up to speed on the process so we can
> have multiple people able to handle releases at any point in time.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Michael Roth <michael.roth@amd.com>

Thanks for writing this up, and apologies for not having
got around to reading it for so long.

I should probably move the other parts of the process
currently documented at https://wiki.qemu.org/Merges
into a docs/devel file at some point.

> +Overview
> +--------
> +
> +Once an official release is tagged in the QEMU git tree by the current
> +upstream maintainer (for major releases), or current stable maintainer
> +(for stable releases), additional work is needed to generate/publish a
> +source tarball for consumption by distros, vendors, and end-users who
> +may not use git sources directly. A person involved in producing these
> +tarballs is referred to herein as a "release maintainer" (not to be
> +confused with the upstream/stable maintainers who are responsible for
> +managing/tagging the git trees from which the tarballs are generated).
> +
> +This documents provides an overview of this release process and is

"document"

> +mainly intended as a reference for current/prospective release maintainers
> +and other individuals involved in the release management process, but it
> +may also be useful to consumers of these source tarballs.

> +     # Sign the resulting tarballs
> +     gpg -b qemu-8.0.0.tar.bz2
> +     gpg -b qemu-8.0.0.tar.xz

Am I right that you currently use your personal GPG key for
release signing? We should probably think about what would
we would need to do if we wanted to change who does this
release process. But I don't know anywhere enough about gpg
to make sensible suggestions...

thanks
-- PMM

