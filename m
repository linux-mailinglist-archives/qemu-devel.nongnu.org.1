Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C990E75BA4A
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 00:12:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMbrO-000708-4b; Thu, 20 Jul 2023 18:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qMbrC-0006zm-NK
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 18:10:48 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qMbrA-0006AT-OE
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 18:10:46 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-565db4666d7so888431eaf.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 15:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689891043; x=1690495843; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awjcUuFr1F/odCI00/XNiMlHHq1ON4Pli0mdmsSUg4A=;
 b=xtlzaX/HRNwn8L53MTT83AEFPkPLhDbG6rijtQ4OeyRprI2/zyqah/KFIHEykO4HlH
 JxjfMqkrodx/k/YFtNDOarIQN0cHq0I5h1zV34moIZqH0tqUOfndhAYgwLa08MluH3jp
 1Mtuy7QByx2EHuLFxBlGRn6BBJWbgXFy7LLh1WMApcPX5twyZzP3Vm1yYkyBDaK+08ll
 zxqQSy5zUHW4SUj8FkX1la2aclCV4l92WVkX9GA+kzR5QADLfQFB+CqiZAptn8s/Tzhe
 KbXIA4j3rbushkdu0m4G/yVhc/yFZeHLkfgRWVFbdyiQvh2DRMXCVDy6CQrG4bpOtzWH
 x6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689891043; x=1690495843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=awjcUuFr1F/odCI00/XNiMlHHq1ON4Pli0mdmsSUg4A=;
 b=gVI7HjtA60ulXELM/njfcyUWH+l3L0oRzLE54i+/Ag7wzuSafefV8o1AJHVjQoJep9
 lzqIP3xO9yzYQRx06GtThDtDf/YaaxCQTzzJgIzrkIi5roeuZswnqVZMhhWm9IoIh8Gk
 /aVO/O0tzVXtoURvol9LI3aDHSDXvBhHBX7ioaBGgwKpd+wFkbG2LrFmxU3qEXXZ7fri
 Ezq0JT5ka9ZgbVDiYLUaRYQgAgxDV9DcQ78+GLFFTe0dcg+b6HKkksvBSR8/cjwwlga7
 OXLzNp9uZcNoT4o8DvrbSc8IO9QHUurXkw1C76aGG7sJn6jIdzboGUG7iDbSZl8QjjpA
 EOAg==
X-Gm-Message-State: ABy/qLa19uO62Uk2HqTfM+GMwqwp5yllert5wHsOy8wDVT1xBpu7AVqU
 YOhoYVwZ2y5JPkRM1b+cafRxtYK2U5kj/uEguXUJ2g==
X-Google-Smtp-Source: APBJJlGtGD5lNcnXIxA/aPmOVDiJSz5dXdIgSS0OB83j4r+YEfhXjZiRM+KfbtvOU5UF1G9k6TfoDg4OMZSKVSgM8g4=
X-Received: by 2002:a4a:9250:0:b0:565:9e41:85d8 with SMTP id
 g16-20020a4a9250000000b005659e4185d8mr124916ooh.6.1689891042487; Thu, 20 Jul
 2023 15:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230704080628.852525-1-mnissler@rivosinc.com>
 <20230720184139.GE210977@fedora>
In-Reply-To: <20230720184139.GE210977@fedora>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Fri, 21 Jul 2023 00:10:31 +0200
Message-ID: <CAGNS4TY_iHxFYrAzsupPjp35i6cAYY+5bp-_oy+4P+FOB9QWyQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Support message-based DMA in vfio-user server
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, john.levon@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=mnissler@rivosinc.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Stefan,

I hope you had a great vacation!

Thanks for updating the mirror and your review. Your comments all make
sense, and I will address your input when I find time - just a quick
ack now since I'm travelling next week and will be on vacation the
first half of August, so it might be a while.

Thanks,
Mattias

On Thu, Jul 20, 2023 at 8:41=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Jul 04, 2023 at 01:06:24AM -0700, Mattias Nissler wrote:
> > This series adds basic support for message-based DMA in qemu's vfio-use=
r
> > server. This is useful for cases where the client does not provide file
> > descriptors for accessing system memory via memory mappings. My motivat=
ing use
> > case is to hook up device models as PCIe endpoints to a hardware design=
. This
> > works by bridging the PCIe transaction layer to vfio-user, and the endp=
oint
> > does not access memory directly, but sends memory requests TLPs to the =
hardware
> > design in order to perform DMA.
> >
> > Note that in addition to the 3 commits included, we also need a
> > subprojects/libvfio-user roll to bring in this bugfix:
> > https://github.com/nutanix/libvfio-user/commit/bb308a2e8ee9486a4c8b53d8=
d773f7c8faaeba08
> > Stefan, can I ask you to kindly update the
> > https://gitlab.com/qemu-project/libvfio-user mirror? I'll be happy to i=
nclude
> > an update to subprojects/libvfio-user.wrap in this series.
>
> Done:
> https://gitlab.com/qemu-project/libvfio-user/-/commits/master
>
> Repository mirroring is automated now, so new upstream commits will
> appear in the QEMU mirror repository from now on.
>
> >
> > Finally, there is some more work required on top of this series to get
> > message-based DMA to really work well:
> >
> > * libvfio-user has a long-standing issue where socket communication get=
s messed
> >   up when messages are sent from both ends at the same time. See
> >   https://github.com/nutanix/libvfio-user/issues/279 for more details. =
I've
> >   been engaging there and plan to contribute a fix.
> >
> > * qemu currently breaks down DMA accesses into chunks of size 8 bytes a=
t
> >   maximum, each of which will be handled in a separate vfio-user DMA re=
quest
> >   message. This is quite terrible for large DMA acceses, such as when n=
vme
> >   reads and writes page-sized blocks for example. Thus, I would like to=
 improve
> >   qemu to be able to perform larger accesses, at least for indirect mem=
ory
> >   regions. I have something working locally, but since this will likely=
 result
> >   in more involved surgery and discussion, I am leaving this to be addr=
essed in
> >   a separate patch.
> >
> > Mattias Nissler (3):
> >   softmmu: Support concurrent bounce buffers
> >   softmmu: Remove DMA unmap notification callback
> >   vfio-user: Message-based DMA support
> >
> >  hw/remote/vfio-user-obj.c |  62 ++++++++++++++++--
> >  softmmu/dma-helpers.c     |  28 --------
> >  softmmu/physmem.c         | 131 ++++++++------------------------------
> >  3 files changed, 83 insertions(+), 138 deletions(-)
>
> Sorry for the late review. I was on vacation and am catching up on
> emails.
>
> Paolo worked on the QEMU memory API and can give input on how to make
> this efficient for large DMA accesses. There is a chance that memory
> dispatch with larger sizes will be needed for ENQCMD CPU instruction
> emulation too.
>
> Stefan

