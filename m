Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9B473B6F0
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:15:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCffv-00085G-Ab; Fri, 23 Jun 2023 08:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfft-00083M-25
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:14:01 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCffr-0006uA-9l
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:14:00 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f85966b0f2so660167e87.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687522437; x=1690114437;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ku2DJUXAZ0KHZBqBXn9ArIju334XbbveUJQ30cnzqd0=;
 b=KmgyfP0cX9f0WYNxU/LvXAkWEkEuFQzK5bck7lr+hwfOTQtUiwf+fdArfhi5/7Z0yl
 VqnYy2fI5Z3VUVQry8yOkT2ntnjy5IK97uG455gO2agdHC0BDpHMuBg73QwWAU6Z2UYL
 O//aCHZxx/juhqH/gowH160is054TpLm5M6p0rzk5YVOE26u01Jh1ZaH0MhLF1vCFB4a
 fvVDlhrLi6Er5bKO6wHgq7QaZRhfbC6uPVbj6hnCFLDcp3bKJvPHJ3LuaDFa5yVlDw68
 T6cKBB4p1Z/qYTmo5OmfBIfBsMgAEPDkPv9gFiKR1G1NTFhWXpdvOZhufFWqxk2t9/3e
 UfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522437; x=1690114437;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ku2DJUXAZ0KHZBqBXn9ArIju334XbbveUJQ30cnzqd0=;
 b=XIVppfWjKvYKMmfAWD+JY0v0XZR+ivBE+rDoteE2Wgum05DHyIZIMsCB6BuSd39wjf
 i5pWYw4raC6H4kQCrqU+hGJ3Bx+OZnvhci6jY7vIN8CS02U19lZNc5+nBMz1qiJPyMhZ
 LmkC3g12Fpk7DFDu2L6AHw50kmD7CqOnpsrf4E0/N6ZZR69cbwimMeNZe7ef793nTAMb
 Er1D0WP52OjHjoVLK0DjnGvFoSpX9dTDjvTPkE4A4Lh6uxSRdGgj4CYsWaZroZoBK7RN
 bdxu4WfBaVsK8ZfjWS4yK5ko8sdnLnaYarpRSYzNEWy9/nB/y2Nsy5AeM5pY9aQjZcES
 rMPw==
X-Gm-Message-State: AC+VfDy7GmVO+Ay2uXhvimkd2DWuyBO3K7XS5dPOnvG+VNvuMHXbeZEJ
 gvsar1vAkH3lszx1JhHyaH6rhuzGDA4GSqyDxI2Jpg==
X-Google-Smtp-Source: ACHHUZ64KL813CBG1U9F8bSbmSK74gQmhqkAXCBRrrUianzNsqJQRF2RnKk4oQk7UpHDoQ272pP0ITNXzn0Eg+uPepQ=
X-Received: by 2002:a19:3813:0:b0:4f8:7697:5207 with SMTP id
 f19-20020a193813000000b004f876975207mr7991648lfa.23.1687522436880; Fri, 23
 Jun 2023 05:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230526170010.574-1-Jonathan.Cameron@huawei.com>
 <20230623025836-mutt-send-email-mst@kernel.org>
 <20230623130622.00004d02@Huawei.com>
In-Reply-To: <20230623130622.00004d02@Huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2023 13:13:45 +0100
Message-ID: <CAFEAcA-c9qmn0S87Am6a=XBjJ2peBVyBYfqdFBgC3RPw8rGmrg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] hw/cxl: Poison get, inject, clear
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>, 
 linux-cxl@vger.kernel.org, linuxarm@huawei.com, 
 Ira Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Dave Jiang <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

On Fri, 23 Jun 2023 at 13:07, Jonathan Cameron via
<qemu-devel@nongnu.org> wrote:
>
> On Fri, 23 Jun 2023 02:59:44 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
> > On Fri, May 26, 2023 at 06:00:06PM +0100, Jonathan Cameron wrote:
> > > v8: Formatting fixes for QMP docs from Markus Armbruster (thanks!)
> >
> > This and other patches add a bunch of over-80 chars lines.  I'm not
> > going to intervene here as cxl has lots of them but maybe scan over cxl
> > codebase and shorten where appropriate.
> > Thanks!
>
> Will add it to the todo list and will pay more attention to this for
> future series.
>
> Some annoyingly complex register names make it tricky but I'm sure we
> can do better if not necessarily perfectly!

The coding style says:

# Lines should be 80 characters; try not to make them longer.
#
# Sometimes it is hard to do, especially when dealing with QEMU subsystems
# that use long function or symbol names. If wrapping the line at 80 columns
# is obviously less readable and more awkward, prefer not to wrap it; better
# to have an 85 character line than one which is awkwardly wrapped.
#
# Even in that case, try not to make lines much longer than 80 characters.

so if it would be obviously worse to wrap the line you can
make it longer than 80 chars.

-- PMM

