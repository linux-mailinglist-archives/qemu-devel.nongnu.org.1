Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5C57AD9F2
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:18:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmPA-0007Wh-U4; Mon, 25 Sep 2023 10:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qkmP4-0007W3-81
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:17:38 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qkmP2-0002XB-Qs
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:17:38 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-57ad95c555eso3652238eaf.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695651455; x=1696256255; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l84vuzEaTKTpz5sjeghKZ7vuXmyqJO9zC9weD/O2Q6Q=;
 b=dSOtB1+lBMYL9xTcu7uaWfKjcfsI32j0p2hw3JgObl44PIaq8OvKnmgJE2FnyPweJK
 y0o5vzOqMGCphSbrDQOgdl45T5SBsvCQCLGG7LmVbb7taiXBF4PuCMQm/lFqT/8D8t6D
 PC7UBUHU86Oo9s3wykeh6CO8HoYSpaK+SGfVKv+kLEkJe6ZNelHX6xC1qhzFbwhHi1ET
 QbLK5Dk5H/gtX+hHjSNtPN0/3uedf88YxVKrJV571OSWW/+YP0JLeU751dDOfvZcceGY
 sm/0Y7FPBMSyAccmdVKH6v4VgqvudXN2yudkwHK0EFHSsyJPRFGhxYD9WcHnTTKbLoEr
 q8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695651455; x=1696256255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l84vuzEaTKTpz5sjeghKZ7vuXmyqJO9zC9weD/O2Q6Q=;
 b=Tiz1pN6wLvLPH4sMW/fJu5s5yZLHDckhrGACL4mjX7PQCqXrbu3GDEqn/vyPnlIUEA
 rl3FzafSsbtIu4VD2Nr82+ZD+0vAV8u/p92rlBliNbsxQiP00X0EN6MWO+5jYL39olsf
 nkyFEEDXB8t3y1E7ub/rJ4Ct6fxGgiWJs40ESrX0dAFmfQ1WJ7yxKK6wKe+PW8XrHUGN
 xPJwYWq5jdRyGTxZZZ7bis4+ww2Te6GpGJ5jZy3td1OIm5n8IRbRRlVb+kwZPH4vSa3r
 LkBzJrjmdoqOobNDJNF2Q9Aeryw+d2Rkf+q6tO4W0qgmjH+ngUBuSHETAq9CuDyJ2Q2D
 oPcQ==
X-Gm-Message-State: AOJu0YwwXoiEsBf0TjMIPEfPtAEuj5yN9UErlX1mkHCh+oQzS1rqgRvI
 GZSQcwE/EEE6M026z8zYBtC/rm3difNy+w13A4w=
X-Google-Smtp-Source: AGHT+IFzxnRArp8JIfC71bIbs4jeiMIuH1yjs4S0d2bjp0pqaJjFEQe2h+tD2v9yOoId1yXDNzGxtNXRq3LSrjT6WCA=
X-Received: by 2002:a4a:671a:0:b0:57b:38f1:7f69 with SMTP id
 f26-20020a4a671a000000b0057b38f17f69mr5313315ooc.4.1695651455133; Mon, 25 Sep
 2023 07:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230811143423.3258788-1-i.maximets@ovn.org>
 <68d6bc20-a67f-0c96-a5e2-431b99fdf767@ovn.org>
In-Reply-To: <68d6bc20-a67f-0c96-a5e2-431b99fdf767@ovn.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 25 Sep 2023 10:17:22 -0400
Message-ID: <CAJSP0QWE_UzoAycg149c2KGiduCkvCyj-BUJNaxck6yu5vyNPQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: don't zero out memory region cache for
 indirect descriptors
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc34.google.com
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

On Mon, 25 Sept 2023 at 07:18, Ilya Maximets <i.maximets@ovn.org> wrote:
>
> On 8/11/23 16:34, Ilya Maximets wrote:
> > Lots of virtio functions that are on a hot path in data transmission
> > are initializing indirect descriptor cache at the point of stack
> > allocation.  It's a 112 byte structure that is getting zeroed out on
> > each call adding unnecessary overhead.  It's going to be correctly
> > initialized later via special init function.  The only reason to
> > actually initialize right away is the ability to safely destruct it.
> > Replacing a designated initializer with a function to only initialize
> > what is necessary.
> >
> > Removal of the unnecessary stack initializations improves throughput
> > of virtio-net devices in terms of 64B packets per second by 6-14 %
> > depending on the case.  Tested with a proposed af-xdp network backend
> > and a dpdk testpmd application in the guest, but should be beneficial
> > for other virtio devices as well.
> >
> > Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> > ---
> >
> > Version 2:
> >
> >   * Introduced an initialization function, so we don't need to compare
> >     pointers in the end. [Stefan]
> >   * Removed the now unused macro. [Jason]
> >
> >  hw/virtio/virtio.c    | 20 +++++++++++++++-----
> >  include/exec/memory.h | 16 +++++++++++++---
> >  2 files changed, 28 insertions(+), 8 deletions(-)
>
> Kind reminder.
>
> This patch was posted quite some time ago and it has 2 reviewed/acked-by tags.
> Just making sure it didn't fall through the cracks.

This should go through Michael's tree.

Stefan

>
> Best regards, Ilya Maximets.
>

