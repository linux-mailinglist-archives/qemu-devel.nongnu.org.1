Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9872D7A1C34
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 12:26:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh601-0005nV-5j; Fri, 15 Sep 2023 06:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qh5zz-0005lr-4g
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 06:24:31 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qh5zx-0002HR-Dg
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 06:24:30 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1a1fa977667so1114671fac.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 03:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694773468; x=1695378268;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jEC/JZEuGikfpWukm2CEVj3iB0m47LM3FSSx2Um2D0c=;
 b=bqSn/Au5AI4F+PB6GM3olD9wMpFcIbCQF5LnA1P6PmTvZy0UODpEJZTtfcfBRp8FrE
 6PATcHPSnKkHWBtekPtNk0qot51oJDA1BFHqIVxE3aImBEaYu/8gowb8wJgP/hPPATnQ
 DKRUkij5GLMJX/h+fO56G9jRzosnaVe/o2VDo4xqkdsYt5hy26nazp1vVdA00NCCKfjw
 oAhh6h+BqbNT7gzuXLyER3yHm/49sYP8PS0ou98tazWWGn1xRx39kjjHHIspeYI+45ZK
 4v4Zmiy0mNgDucOVIY6OBAIblcY3lyqxMT1Jh+VJv4RY+tQthGxywA5F/YS4wgtY86L3
 +NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694773468; x=1695378268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jEC/JZEuGikfpWukm2CEVj3iB0m47LM3FSSx2Um2D0c=;
 b=Cm5rEJLaFXoh/ckGGt2YUTmj4SDHwJF/fxQHgKjZHZ37tKwXNFE+/0ovVhdkHB6iAU
 gzaBhz2fA9jDOGIACc/kYNR8PuekyRIdCXUE20SAmJjCRBugsjZ0ZyxJwoDTJk1EnBem
 +L34tdyEDTuVB7rZeqUY19OrZfOdTPnwlZtKt0eF6sZJHYzhfWL/srlESxQ/eT/AXSzM
 r/AGSK5jbocM1WcHaFAJUXeeoxrKslmkOxuZKVW54brYcGlAMQywaYUYTlOItMgtSsfb
 D9mIroCV2aHdJUMPeaUH4Ck108XOEl7FgRCCn+Xo6UGfpT8QGeijE1bQcYF/rSMYghen
 DRWQ==
X-Gm-Message-State: AOJu0YzLI/URJLnXS+Hrt2qzHLgYIcqW/S8sl2b7YDT6JXHqpjGPG71C
 khxC38/YydX7Beh6QoRPb3aJL5TlE//ADeStOTyh7Q==
X-Google-Smtp-Source: AGHT+IGnfQmSPWVH7CQ8e+j4plRwoanSIcQytQ09U8teO93vPLYfQTtlBvnz7CnRnmOXcYWKX3/sLSBVnuoX0JFSAc4=
X-Received: by 2002:a05:6870:568a:b0:1ba:8307:9a13 with SMTP id
 p10-20020a056870568a00b001ba83079a13mr1551130oao.11.1694773467876; Fri, 15
 Sep 2023 03:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230907130410.498935-1-mnissler@rivosinc.com>
 <20230907130410.498935-6-mnissler@rivosinc.com>
 <20230914203252.GA1098343@fedora>
In-Reply-To: <20230914203252.GA1098343@fedora>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Fri, 15 Sep 2023 12:24:17 +0200
Message-ID: <CAGNS4Ta++Lx8AV42U1=zP3HbnVMbdKvTO1aDhn0Ka2j3XxR3rA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] vfio-user: Fix config space access byte order
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, john.levon@nutanix.com, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=mnissler@rivosinc.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Sep 14, 2023 at 10:32=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Thu, Sep 07, 2023 at 06:04:10AM -0700, Mattias Nissler wrote:
> > PCI config space is little-endian, so on a big-endian host we need to
> > perform byte swaps for values as they are passed to and received from
> > the generic PCI config space access machinery.
> >
> > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > ---
> >  hw/remote/vfio-user-obj.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> After some discussion about PCI Configuration Space endianness on IRC
> with aw, mcayland, and f4bug I am now happy with this patch:
>
> 1. Configuration space can only be accessed in 1-, 2-, or 4-byte
>    accesses.
> 2. If it's a 2- or 4-byte access then your patch adds the missing
>    little-endian conversion.
> 3. If it's a 1-byte access then there is (effectively) no byteswap in
>    the code path and the pci_dev->config[] array is already
>    little-endian.

Thanks for checking! This indeed relies on the
pci_host_config_{read,write}_common to be register-based access paths.
I have also experimentally verified that this works as expected using
a s390x build.

