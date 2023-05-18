Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A30F707E4A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:41:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzb4U-0003Zd-5P; Thu, 18 May 2023 06:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzb4R-0003Yr-SF
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:41:19 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzb4Q-0000rm-Bw
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:41:19 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-50c8d87c775so2682455a12.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684406476; x=1686998476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lTt3zFMpAJqNwbSWIPbVPYPEKlusl//wZt073nB1KB8=;
 b=b0KD+y5kYNa+zByETkqDih1TobijtTssmn++qZmPw1mUCuWGtwlEMu02p3W2MYSc9M
 ng70vNI7UDCHVgbNEpWd/ikcH3a4mWAUZ4AMbDb/0oHR4lRBsDoyj+wC4YNsSOla9xG/
 swIUIi9OZzneh2fLKgHOxEsdzQwJ6iG0gspfvAx9nHLw2Efkfg8y7l4l+qA6N0Y/zWoZ
 UT7dju61FHff5MXg/yogTQZQpveTj3iILDaBI9CJOt95R3r3u155hZEKv+YgxzR0TjRO
 qrZUC1XZ6CTGi7IMrHomE+QlnAhcpnJgYz5vf6EoiWWLlE9YTgaOgictDG4XvlAfKIau
 Xdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684406476; x=1686998476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lTt3zFMpAJqNwbSWIPbVPYPEKlusl//wZt073nB1KB8=;
 b=kY9zB2KSg6hveUB4E01LqEXQ4Q4wL7q4ZejphYsmA3Lnk40/amKEy/LQh2FsLkq89s
 iQ1Dtfm5t6nLlFNbM4uf2AcRMZ6EFRhWCoclylO+S51XbinRBNrBAdlG3Lya91u0C24i
 jqB3aSJBcEpnoJnCFhW+OdpkuILpsT7jmaCtCEhOLBNHDiDJYWC5mPoQ/KMxuQimf2Ns
 GCP0Thzw8GryK5rxbH4g/4gX0UhL7B2m7kAQFP37gxPjYsfcgNT4SmwflJw+aS/HQ2gD
 43qYU8LTZTpKW4Pl14fdCJJdmh7t1IEW4pEWQFNs+MO8GDM5VARUEqaWwdJS9SmP+jdP
 NYqw==
X-Gm-Message-State: AC+VfDw7rEYJqgTud6iT9coGg/R/AhJZETgDrqPcTSb/8UTA1vzUHc/X
 Aeq5FHdIVuhw3wb+scFNHmifhqK2m829dNd5pCSu2g==
X-Google-Smtp-Source: ACHHUZ7uQSvyfAqOzDl/i1ueE5iELNZTz1ZqC0R6aZPvTlzrGpSj7gGYh3FJxaagLr04pPU0sEgJ1kL6j9CDTkA/G4k=
X-Received: by 2002:aa7:d8c7:0:b0:50b:c4fb:770f with SMTP id
 k7-20020aa7d8c7000000b0050bc4fb770fmr4778246eds.34.1684406476442; Thu, 18 May
 2023 03:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230421163734.1152076-1-peter.maydell@linaro.org>
 <48906545-7fdb-effb-8819-485a66226e2d@redhat.com>
In-Reply-To: <48906545-7fdb-effb-8819-485a66226e2d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 May 2023 11:41:05 +0100
Message-ID: <CAFEAcA8sBTe270z5JF87Z4bvd_6440uSDNafQ9p1aeejS7M66Q@mail.gmail.com>
Subject: Re: [PATCH] docs: Convert u2f.txt to rST
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 16 May 2023 at 17:54, Thomas Huth <thuth@redhat.com> wrote:
>
> On 21/04/2023 18.37, Peter Maydell wrote:
> > Convert the u2f.txt file to rST, and place it in the right place
> > in our manual layout. The old text didn't fit very well into our
> > manual style, so the new version ends up looking like a rewrite,
> > although some of the original text is preserved:
> >
> >   * the 'building' section of the old file is removed, since we
> >     generally assume that users have already built QEMU
> >   * some rather verbose text has been cut back
> >   * document the passthrough device first, on the assumption
> >     that's most likely to be of interest to users
> >   * cut back on the duplication of text between sections
> >   * format example command lines etc with rST
> >
> > As it's a short document it seemed simplest to do this all
> > in one go rather than try to do a minimal syntactic conversion
> > and then clean up the wording and layout.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   docs/system/device-emulation.rst |   1 +
> >   docs/system/devices/usb-u2f.rst  |  93 ++++++++++++++++++++++++++
> >   docs/system/devices/usb.rst      |   2 +-
> >   docs/u2f.txt                     | 110 -------------------------------
> >   4 files changed, 95 insertions(+), 111 deletions(-)
> >   create mode 100644 docs/system/devices/usb-u2f.rst
> >   delete mode 100644 docs/u2f.txt
>
> I'm not an expert at all in this area, but your changes look sane to me, so:
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks for the review; I'll take this via my target-arm
tree since I'm planning a pullreq anyway.

-- PMM

