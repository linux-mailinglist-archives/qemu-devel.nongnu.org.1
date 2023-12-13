Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1880B8120F6
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 22:54:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDXAL-000661-IQ; Wed, 13 Dec 2023 16:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rDXAJ-00065T-Jl
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 16:53:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rDXAI-0007HQ-1n
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 16:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702504392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9WVtzbBSgHDdg8O+fpi7aMJE7g86nkNV+Qgd/TB7Gmo=;
 b=RduBPYOBxsEz9SOZnlvDgegjU3y6DRm9tapKq7o4p1Scz1Kt0j1mzlKriEFlEu5UZELsoP
 DKREtVeZ0FjYyUy8nmT0tSHdbwLCxUtLQTTjxwAW4NQe5EX0kFnW0pRtDTXKtIWR83Dbmy
 NSZ4r834LUgMxfCQWqxG62hPkxzmIsk=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-p2y58jEFNqWJcHNkXsBgmg-1; Wed, 13 Dec 2023 16:53:10 -0500
X-MC-Unique: p2y58jEFNqWJcHNkXsBgmg-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7cb3b26b84eso432815241.2
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 13:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702504390; x=1703109190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9WVtzbBSgHDdg8O+fpi7aMJE7g86nkNV+Qgd/TB7Gmo=;
 b=werak5FTE9+pm0O123HNvaK/u/LPfZNNiuPecFpcLovLXqnpmis6d+XVfk3xF7dOkI
 gFgGAz6ZVQtPKN/1sfA1hyfMm6FSfurMgYNY5uSgY1f3syTzbsd22EHLEurNuKpO75GQ
 i4xmxLCNbx0WjQPTxS1OO/kkTInhRplFURH0Uk9AA605HgyAWO/aPWbMf3KmFBMqpZDY
 SALtDYFi6xyOxreVGYdKQtsZAx6lXXQJlvP60flnLF5UdA5KP4TBsvGSEKXgyPiBhkY0
 u3SMWiTiSyhnYNfejQPyeipRJamAh3y9cchFturDP4EYP7cAa+DLFU9zUxJXoMSHfN3a
 QOZQ==
X-Gm-Message-State: AOJu0YxFiv2Jt82nicBBoDV70+vKr34FChYyF0f3rdmGUD6KYtdWi3lP
 uQWffO7dXsK1Tloywnrw8ZpYj5m39/HpGMA/xV1WlTqXJDbe5I183Yz2BCT3t4VcZx0slFspyki
 LaIczXPjwGQBbG0/oiOy9odjzyd0WwfY=
X-Received: by 2002:a67:c085:0:b0:464:609d:6636 with SMTP id
 x5-20020a67c085000000b00464609d6636mr4129538vsi.14.1702504390328; 
 Wed, 13 Dec 2023 13:53:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxGUCMBcPhF1i6mU9L03hMVgZl202KhlaH0o3bQGgzdOgDBsvlSwD/jj1KdcOOJJWtd5Z8lyCH58qid3cGZ8Y=
X-Received: by 2002:a67:c085:0:b0:464:609d:6636 with SMTP id
 x5-20020a67c085000000b00464609d6636mr4129526vsi.14.1702504390076; Wed, 13 Dec
 2023 13:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <20231213211544.1601971-4-stefanha@redhat.com>
In-Reply-To: <20231213211544.1601971-4-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 13 Dec 2023 22:52:58 +0100
Message-ID: <CABgObfYWPVFcqa5bBhPMZuS-6hh=nAt=pHztL5YHSAQOwiarig@mail.gmail.com>
Subject: Re: [RFC 3/3] aio-posix: call ->poll_end() when removing AioHandler
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fiona Ebner <f.ebner@proxmox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Dec 13, 2023 at 10:15=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
> -    /* If a read is in progress, just mark the node as deleted */
> -    if (ctx->walking_handlers > 0) {
> -        QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node, node_del=
eted);
> -        return false;
> +    /* If polling was started on the node then end it now */
> +    if (ctx->poll_started && node->io_poll_end) {
> +        node->io_poll_end(node->opaque);
> +
> +        /* Poll one last time in case ->io_poll_end() raced with the eve=
nt */
> +        if (node->io_poll(node->opaque)) {
> +            poll_ready =3D true;
> +        }

Do you need this at all? If the caller is removing the handlers, they
should have put themselves in a state where they don't care about the
file descriptor becoming readable.

You still have to be careful because aio_bh_schedule_oneshot() can
trigger remote nested event loops (which can cause deadlocks and, I am
especially afraid, can take some time and invalidate the expectation
that you don't need to drop the BQL). But it does simplify this patch
quite a bit.

Paolo


