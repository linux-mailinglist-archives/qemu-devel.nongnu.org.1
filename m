Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C987EC99F
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 18:25:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Jd8-0003nL-Uu; Wed, 15 Nov 2023 12:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r3Jd7-0003n7-4u
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:24:45 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r3Jd5-00057J-Au
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:24:44 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-586b512ba0aso3240242eaf.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 09:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700069081; x=1700673881; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OZIbJ/zXqlqmOxjpbYGlY5znVEsIl1YL6vxfbdnWV08=;
 b=aulu5B06VNvgsSBLj+EkPlSAgkgVstKQbF18qT/wJz/OOm8jFJQavzfdp4XmyvV2a6
 OGXuZFjAyIfjgEn888d0f1/RsNDFU2fjqzOpVDFV/m5hCif/q/+NfBP95c726ELJ23Ep
 ljeTurd3uxmx9LTgETG/olPf34FfXGKEltas3LCEqZIkHYN3GaZ8QMBvtDn9eC8g/vdO
 hm4PAV8N20TBPe+06s1hsgYFS5OHyS34IKbIsxnft8RUcBxi91xjIkd5LUERqUDOrV0W
 89CZgp1DVb25kfnXuoFufARQhkZvE2m/+eL2d8KEDI6Jc4b3HzYbnuu+o6xynoSAy1Ih
 uJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700069081; x=1700673881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OZIbJ/zXqlqmOxjpbYGlY5znVEsIl1YL6vxfbdnWV08=;
 b=SggP2M6FHCSEEPuljskj/amdQ5B7owWf2mfurvBT0TI+pMY4KgGjxBuEH7/rKYEMvy
 yILnaTSLGALc1KSPrM8nJwC7m7k1E2XEIYYH3j4g+vWb0vlsBKfUaJmsLMSI1Xy2ol+h
 xroCPzUcVhHQD6Rcd22M+fo1auMUKXmuZ5O4JnlGT8xRR93MKQJ0sopu4zpomsYoz7GE
 iSg2ywZAupu1kKomWBXFC/IZykE/ZJyP429Wt9djv0dDggm1cGd9uU2Hr2qrjqQgriWJ
 oYax13WGY8uZOz9o6gPPUrdhtnu1myluco5QMWGOM5HialTHpDF2iijnjP1YbvGs6lJy
 B3Bw==
X-Gm-Message-State: AOJu0YwcsLX603A36BP3CPJh+P+t+OuhT9ZyEAgGEpfIsYwbo2tnHBWI
 5tvgl5dAexGuUaZ7HDyw5gEbyR4RWyJrg6Lm6GM=
X-Google-Smtp-Source: AGHT+IFOPdNYCelEs8uYYtlBLGiI2LMzhQ1/UoPaXSZAjMSCnCFO/1FdvItKs1j7LcAlLbeGvmrJ7Pyk0XOa83mk498=
X-Received: by 2002:a4a:2452:0:b0:581:9066:49 with SMTP id
 v18-20020a4a2452000000b0058190660049mr12227250oov.0.1700069081426; 
 Wed, 15 Nov 2023 09:24:41 -0800 (PST)
MIME-Version: 1.0
References: <20231114003644.7026-1-michael.christie@oracle.com>
 <20231114003644.7026-3-michael.christie@oracle.com>
 <bucsvfqgs73w73tt4l5z35smccpebjq36hcozpgrkeydm3jumj@zisakm4noecq>
 <20231115125718.GA301867@fedora>
 <04faa337-d0dc-4683-a05f-2dee0dea0eb4@oracle.com>
In-Reply-To: <04faa337-d0dc-4683-a05f-2dee0dea0eb4@oracle.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 15 Nov 2023 12:24:29 -0500
Message-ID: <CAJSP0QXxjCyORGg70gEjSA6OynsS=FmsAZOV1h-XcU1kLNRHKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] vhost-scsi: Add support for a worker thread per
 virtqueue
To: Mike Christie <michael.christie@oracle.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, fam@euphon.net, 
 jasowang@redhat.com, mst@redhat.com, pbonzini@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 15 Nov 2023 at 11:57, Mike Christie <michael.christie@oracle.com> wrote:
>
> On 11/15/23 6:57 AM, Stefan Hajnoczi wrote:
> > On Wed, Nov 15, 2023 at 12:43:02PM +0100, Stefano Garzarella wrote:
> >> On Mon, Nov 13, 2023 at 06:36:44PM -0600, Mike Christie wrote:
> >>> This adds support for vhost-scsi to be able to create a worker thread
> >>> per virtqueue. Right now for vhost-net we get a worker thread per
> >>> tx/rx virtqueue pair which scales nicely as we add more virtqueues and
> >>> CPUs, but for scsi we get the single worker thread that's shared by all
> >>> virtqueues. When trying to send IO to more than 2 virtqueues the single
> >>> thread becomes a bottlneck.
> >>>
> >>> This patch adds a new setting, virtqueue_workers, which can be set to:
> >>>
> >>> 1: Existing behavior whre we get the single thread.
> >>> -1: Create a worker per IO virtqueue.
> >>
> >> I find this setting a bit odd. What about a boolean instead?
> >>
> >> `per_virtqueue_workers`:
> >>     false: Existing behavior whre we get the single thread.
> >>     true: Create a worker per IO virtqueue.
> >
> > Me too, I thought there would be round-robin assignment for 1 <
> > worker_cnt < (dev->nvqs - VHOST_SCSI_VQ_NUM_FIXED) but instead only 1
> > and -1 have any meaning.
> >
> > Do you want to implement round-robin assignment?
> >
>
> It was an int because I originally did round robin but at some point
> dropped it. I found that our users at least:
>
> 1. Are used to configuring number of virtqueues.
> 2. In the userspace guest OS are used to checking the queue to CPU
> mappings to figure out how their app should optimize itself.
>
> So users would just do a virtqueue per vCPU or if trying to reduce
> mem usage would do N virtqueues < vCPUs. For both cases they just did the
> worker per virtqueue.
>
> However, I left it an int in case in the future someone wanted
> the future.

Okay. I have a slight preference for a vq_workers bool parameter in
that case. An int parameter can be added later if the number of
workers need to be specified. But if you want to keep -1/1 then I
guess it's fine unless someone else has a strong opinion.

Stefan

