Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4837CDAE3
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 13:42:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt4vc-0007SU-Jl; Wed, 18 Oct 2023 07:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qt4vZ-0007SJ-Tl
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:41:30 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qt4vU-0007p0-Ue
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:41:28 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-581bca3ebb0so1504888eaf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 04:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697629284; x=1698234084; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fwV7PSa3sP6IOwckUBfMcJ1RWkT1o0wYNQ8FH2Qk+0M=;
 b=fpi1kOLzFhYaE0pj2fhCWT4Otnso9eZqI6WwF2qk4AnKOVGesmV/fHIJf5J8u6Vn6Z
 HQrZXbYDnnlwj5KdlrD1Gv2sQaKscjgZw6b+wGp/pi5PjO62Xfa16GdkaO4rCXPAodTM
 BuAJmrc2/utdrIgvXkP7JntGgKS0T+VvvcdQ2b9Rkonm8+asRP8dxj5RUPtCB3X5t0WN
 UY0QX1jw4LPSZAs+88so2oNpLlYPKFPN2AJo4t3GtIHz/qcZmmk5QLr2vQPchSN+2uPH
 hpwN3k1tWfop5N/1PZbj8pSFctQahcEOL2mct7mfYURaZOfNqb1kP+8rRTm3j8uHOpYq
 oqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697629284; x=1698234084;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fwV7PSa3sP6IOwckUBfMcJ1RWkT1o0wYNQ8FH2Qk+0M=;
 b=iXL1cIyRS0HhHMbnvHhZW6Fahm1WgDEQDk3ZSkIOrshsSd41HK7H9pdpkRNurEukQF
 wFY5YpmIDGzPY5jPjnt7Bb86Rcdjm8VNLMYXkIP8/Eiil9xeZ4CStPrOMOny7RPMhqYA
 roFXzSZhJqx8pzC3jCuXDPkEmzNefWzBk5F3pnxFr5JUycmLMmdTvhEdSZbRk1MksIcS
 RnrmT+SnmpnBQ0lt8KVXOmm3sLOGRImZ2HT4+ZsEDc90ct9m7bvOVoKUnEUABPVCZG7C
 4a1Z7kzMpyOKaQzNZPC3/aHGmVYaridgicCe5S8f7470kgItBKvJKTRJ6byNjSqtI/wU
 4+YQ==
X-Gm-Message-State: AOJu0YypaGUyw77j2gfF3Tl/OlrLhtDu9sbrSJXCGTRUYaBG1BhooxMQ
 X4Lrq0r9hd/LLfV94q5OiYcbXccMzXTe7/T+wE4=
X-Google-Smtp-Source: AGHT+IFmlSwfl48IOXLgenezXdaJkFVC5GwvMLicnj/pRSOHbqBYG6nYBNvr9oHSSF/zyF6fvfiRVNG0kV/YUiRd8rM=
X-Received: by 2002:a05:6820:218b:b0:581:ff09:62e4 with SMTP id
 ce11-20020a056820218b00b00581ff0962e4mr824622oob.2.1697629283708; Wed, 18 Oct
 2023 04:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231002203221.17241-1-lersek@redhat.com>
 <72e1adac-fe95-5650-536b-b70faab7b6d6@redhat.com>
In-Reply-To: <72e1adac-fe95-5650-536b-b70faab7b6d6@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 18 Oct 2023 07:41:11 -0400
Message-ID: <CAJSP0QU7S4HzPnDBxaSS6C7mZFvBWAVAh8bLMvRHj=aP59NqnA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
To: Laszlo Ersek <lersek@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 qemu devel list <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 18 Oct 2023 at 07:26, Laszlo Ersek <lersek@redhat.com> wrote:
>
> Hi Michael,
>
> still waiting for you to pick this up, please.
>
> In
> <http://mid.mail-archive.com/20231004122927-mutt-send-email-mst@kernel.org>,
> you wrote:
>
> > OK. I'll need to do another PR soonish since a bunch of patchsets
> > which I wanted in this PR had issues and I had to drop them.
> > v3 will be there.
>
> (Alt. link:
> <https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg01164.html>.)
>
> That was on 04 Oct 2023 -- exactly two weeks ago :(
>
> Stefan, can you perhaps apply this v3 series directly from the list?

Michael has been active over the past few days, so I think he'll
respond and send a pull request with your patches.

Stefan

>
> Thanks,
> Laszlo
>
> On 10/2/23 22:32, Laszlo Ersek wrote:
> > v2:
> >
> > - http://mid.mail-archive.com/20230830134055.106812-1-lersek@redhat.com
> > - https://patchwork.ozlabs.org/project/qemu-devel/cover/20230830134055.106812-1-lersek@redhat.com/
> >
> > v3 picks up tags from Phil, Eugenio and Albert, and updates the commit
> > message on patch#7 according to Eugenio's comments.
> >
> > Retested.
> >
> > Laszlo Ersek (7):
> >   vhost-user: strip superfluous whitespace
> >   vhost-user: tighten "reply_supported" scope in "set_vring_addr"
> >   vhost-user: factor out "vhost_user_write_sync"
> >   vhost-user: flatten "enforce_reply" into "vhost_user_write_sync"
> >   vhost-user: hoist "write_sync", "get_features", "get_u64"
> >   vhost-user: allow "vhost_set_vring" to wait for a reply
> >   vhost-user: call VHOST_USER_SET_VRING_ENABLE synchronously
> >
> >  hw/virtio/vhost-user.c | 216 ++++++++++----------
> >  1 file changed, 108 insertions(+), 108 deletions(-)
> >
> >
> > base-commit: 36e9aab3c569d4c9ad780473596e18479838d1aa
>
>

