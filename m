Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4C67A49AB
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 14:31:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiDOw-0008Qy-HP; Mon, 18 Sep 2023 08:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiDOt-0008MR-Te
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:30:52 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiDOr-0006xF-MT
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:30:51 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so5581723a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 05:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695040248; x=1695645048; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SY4rJ1so3Y3G/Oh1NGT+gAHv4edXIXMZpfv68X4XS08=;
 b=Eo3uRzwQRwcg3HqJwkjng5ueUIrGgS+bPPPEQnVNj1iWD06EbD83y8q56ZfrBlNTbL
 lk69SJz8IicyVJLu+JOr2iSfHQHSk9KkFh73+bDsFvlmfOkYLfC4I3VeLBq7lYDr3vtc
 8Fp+4J4VbK9l5xQIGycg3cXODmXyBPJaHer5GZ7w24NTdnlcWkeKtSvr4bIT/T2rxqVQ
 RRZcwBxqfz2IVTZaJgjKJUzm+XKqyOD5mDv8+nnXUwvC064vA0N8ukPxOtkYVaTb827+
 qrasz0WYg5T5lkk5Rb5EZ2j/iCG1G0WzUV+ekQ8jwBzzL4hnUrTAz18VJO9Rts4jfxrJ
 meJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695040248; x=1695645048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SY4rJ1so3Y3G/Oh1NGT+gAHv4edXIXMZpfv68X4XS08=;
 b=kDIIXU33jYLpgORfxsIT0y+2Gw0RFQuZL0la8bNVr1IrJiyCfeJdkVAUA/SawKWpn9
 3Zoh6G+3Dl9FRIl2UeeaMvJr2EPPnPs9eYWapvK6D9iz38LRabIu2MrpX7lAYC16GLkV
 ZUoWV+8fb0uRYkzNufYtrZ0QRhZhMTk56KJ4F5Bpkoqg0m5Lu1LjHbwL4z8b+ScnkPy6
 8hYZGfWM4iehIgoU1Sfqw37iSufzMAFTeXaUsXIM50258BBPVvswHGFiYJlz07+kH4qT
 X/UgzTjmDkI/BqgMTZ71v3QweijOvGGS0TvbZSIWv72Lk2ba141LK/hZuRevk7y6qARc
 hGEg==
X-Gm-Message-State: AOJu0YzDsQpaMzjuLgnKa2JJfwEKYYJ724kaY3UxSKdpYK5iVH1M/Exm
 +hM637xBF7txDQHjnz9aQBFV8Ga10o20sGy9xM2FEQ==
X-Google-Smtp-Source: AGHT+IFahZlqwdtcyOW6kXETt1EJiiVhD3tc575YQuyWZg+2gbhaGO812o5FP468K+30GG3ummPfBLSxTLZR2od7zz8=
X-Received: by 2002:a50:ec99:0:b0:52f:b1c6:c8a2 with SMTP id
 e25-20020a50ec99000000b0052fb1c6c8a2mr6404805edr.17.1695040247956; Mon, 18
 Sep 2023 05:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230915170153.10959-1-viktor@daynix.com>
 <87e98b7f-3402-4d1a-a1b2-7493aa963a65@daynix.com>
In-Reply-To: <87e98b7f-3402-4d1a-a1b2-7493aa963a65@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2023 13:30:29 +0100
Message-ID: <CAFEAcA87WB=9QnWD0i9SHeH3Y9qCbM19SSNtRZ-xnxu=q1OnYA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] elf2dmp: improve Win2022, Win11 and large dumps
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor@daynix.com>, annie.li@oracle.com,
 kkostiuk@redhat.com, 
 qemu-devel@nongnu.org, yan@daynix.com, viktor.prutyanov@phystech.edu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, 15 Sept 2023 at 18:13, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> On 2023/09/16 2:01, Viktor Prutyanov wrote:
> > Windows Server 2022 and Windows 11 require more careful kernel PE image
> > search and handling of PDB than previous Windows versions.
> > Also, improve support of large ELF dump files, dumps with unaligned
> > memory ranges and with big number of ranges.
> >
> > Viktor Prutyanov (5):
> >    elf2dmp: replace PE export name check with PDB name check
> >    elf2dmp: introduce physical block alignment
> >    elf2dmp: introduce merging of physical memory runs
> >    elf2dmp: use Linux mmap with MAP_NORESERVE when possible
> >    elf2dmp: rework PDB_STREAM_INDEXES::segments obtaining
> >
> >   contrib/elf2dmp/addrspace.c |  31 +++++++-
> >   contrib/elf2dmp/addrspace.h |   1 +
> >   contrib/elf2dmp/main.c      | 154 ++++++++++++++++++++----------------
> >   contrib/elf2dmp/pdb.c       |  15 +---
> >   contrib/elf2dmp/pdb.h       |   2 +-
> >   contrib/elf2dmp/qemu_elf.c  |  68 +++++++++++++---
> >   contrib/elf2dmp/qemu_elf.h  |   2 +
> >   7 files changed, 177 insertions(+), 96 deletions(-)
> >
>
> For the whole series:
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Thanks for reviewing this. I'll take the patches via the
arm tree, unless anybody would prefer them to take a different
route upstream.

-- PMM

