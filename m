Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C637262DB
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:31:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uBW-0005X7-DB; Wed, 07 Jun 2023 10:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q6uBU-0005Wt-Uu
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q6uBT-0005fD-Al
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686148246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFwp/KaY+YmJH7GX50ujqGPNxt9UjYdl+1jvhkAXJMw=;
 b=V676Z+30+AS2cJF/FvZrf/wV/7F22IHAVr2pd3A4+HnMtSyt0YTzq3FnOMCDbDyXGZTTIk
 mD87YHdtkKPI2mcXXX/+/o3alLUFUm8y4MRWvbEtmFEpD32XyaWPXw6BlluH+2NqYH0Xw6
 ubYuHRuMKhNK7BfhkAGbfM71Q8xs6Xc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-TnYKAn06OQybuGQyHqWx-Q-1; Wed, 07 Jun 2023 10:05:37 -0400
X-MC-Unique: TnYKAn06OQybuGQyHqWx-Q-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-565a1788f3fso124822297b3.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 07:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686146736; x=1688738736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FFwp/KaY+YmJH7GX50ujqGPNxt9UjYdl+1jvhkAXJMw=;
 b=ODoZ7T/7RYWFdJ447GciAo/KfQI9Apxesx0WInZ6c5C22luWoJV3N5n75usbjnLiyO
 kFGNTYBpJAE09S+pmtLsMwlEyluawPIpbd50YyKmTIzBUE2L6KPLL0jjN/HSfDkWiMlw
 7m/dfUJAvI6YjLaim23PMcWxM5QWXQ3LB1v/eZr5EXIWVWLQ0WQnXU5yinx8o3wCcYaj
 BGIEL6X/v5rTD4NdJ4mn24zGN2r1M/ueb5k7xauQlX+3gRsLle3F4hTcLs8ENREO0TJ5
 V3R4wK903StuVy5OeLA2P2TwTUI5UxqAszYr0gt/8ld4UCMSuvHIi3niqsFLT2q5RQK1
 nC2w==
X-Gm-Message-State: AC+VfDxOMNlsy3IYO3TI4YnyZ9bG8U8APQjEBVr+CsvzX62TgU+VwLZv
 onYVkt8gToyozFJNcwi4TM3yULwEI/4fzOc4bo+zGd72Dt8uHvN5jB0OFTSYrhWcBpxbu3zKEG9
 9gZbLJRXPsANVLuirLceJvJc1tvex/IzdexSFBH8=
X-Received: by 2002:a0d:dec4:0:b0:565:5478:713c with SMTP id
 h187-20020a0ddec4000000b005655478713cmr5652451ywe.0.1686146736227; 
 Wed, 07 Jun 2023 07:05:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/ud7v+kUrJt7ZAsVcf98L4sSpGvyLGGph3kUhwINMIgQhWLv+ctoTKp/d9muJojv0fROgJNjDEkgSZ41YqGE=
X-Received: by 2002:a0d:dec4:0:b0:565:5478:713c with SMTP id
 h187-20020a0ddec4000000b005655478713cmr5652437ywe.0.1686146735995; Wed, 07
 Jun 2023 07:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230602173328.1917385-1-eperezma@redhat.com>
 <1b6a29a4-575a-d04e-d60a-144a5ecc263e@tls.msk.ru>
In-Reply-To: <1b6a29a4-575a-d04e-d60a-144a5ecc263e@tls.msk.ru>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 7 Jun 2023 16:04:59 +0200
Message-ID: <CAJaqyWdcX8tOANFv-66OMFufPBw4sLb9+gqdpKboDtZnyiZQoQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: mask _F_CTRL_GUEST_OFFLOADS for vhost vdpa devices
To: mjt@tls.msk.ru
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Cindy Lu <lulu@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Hawkins Jiawei <yin31149@gmail.com>, Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Jun 7, 2023 at 12:08=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 02.06.2023 20:33, Eugenio P=C3=A9rez wrote:
> > QEMU does not emulate it so it must be disabled as long as the backend
> > does not support it.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >   net/vhost-vdpa.c | 1 +
> >   1 file changed, 1 insertion(+)
>
> Is it -stable material?
>

Yes, I forgot to CC qemu-stable here too.

Thanks!


