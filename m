Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A337E70F2
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:55:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r19EB-0000Gn-76; Thu, 09 Nov 2023 12:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r19E7-0000FP-1b
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:53:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r19E5-0007fA-I6
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699552436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a0fl4fQp1QaaVWy9Tfb985DAe50h8i3x1sSj02zW82s=;
 b=Xnbw54QFejIEi58q2AOBjCyYyM+J1b6s/fTcBaEZDxXLP4nrqxZvKHEut9N3fzPWhXWMCu
 BApiYGY33StLozD4cwTRm0LaQGeDgzjP5zR7qwyW+NvYTSeUtwn3gXzELo3FuVlwKseomB
 CGVMqL0DpMZ3Vts1Bmeq9dQx1m+F1zg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-3emaeIX5OYOVzYVTo4efIw-1; Thu, 09 Nov 2023 12:53:55 -0500
X-MC-Unique: 3emaeIX5OYOVzYVTo4efIw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9dd89e2ce17so107486766b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 09:53:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699552433; x=1700157233;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0fl4fQp1QaaVWy9Tfb985DAe50h8i3x1sSj02zW82s=;
 b=lNcc32o9QYAoZWPs0EGuK1+OGjpajetqfhYDBwDaqwlYLR09O7oRnvieIEKN+V4kut
 VXXW4ac7+1th/4kAHpQzr+hN3sHzQLSgcajzj7gH8IU5T6RtnHPjk6eNzvBc7wlzIANK
 PMid2qgKvxw5pvTLHpxdgqRhGZb04h1CqR23+5svN63LkPmqBpz9KfeCQ1UoAwLjhcQ5
 0p624VANm8yPI6U0mbB3peUN6LyzM+KW5EuNEcOt00diXb0oE4GMnxgFxD0pZ/M6W1hZ
 X3HjqnTMj+z3VhnJXBHwJU4uLxL4AifAbmyyQnH50LMtY7m/REwYqYb8X9qm20cgs0C/
 Eu2A==
X-Gm-Message-State: AOJu0YwxbapnaydU+PDhJQgqxsbKQGn0gDoaO4snCU6wayRMnIRKMSht
 jYrF03228Dri0sQkY6ZyGSO28DuYzTnqWvhGJG9/Z3ycHeKUX7dQHJmHchFuLgfHn6/JK7tZRRw
 jRCcjuiiy/vXyfxT39uXqNxg=
X-Received: by 2002:a17:907:72c1:b0:9b6:aac1:6fa5 with SMTP id
 du1-20020a17090772c100b009b6aac16fa5mr4514756ejc.55.1699552432763; 
 Thu, 09 Nov 2023 09:53:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEudBHiPSmqGgeQBa3vWP+YFgVwOhjTYHJFPScrTk08tZO+3VzyoQza7NeitMtqvVautq7wFw==
X-Received: by 2002:a17:907:72c1:b0:9b6:aac1:6fa5 with SMTP id
 du1-20020a17090772c100b009b6aac16fa5mr4514743ejc.55.1699552432464; 
 Thu, 09 Nov 2023 09:53:52 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
 by smtp.gmail.com with ESMTPSA id
 bm25-20020a170906c05900b009c0c511bd62sm2814758ejb.197.2023.11.09.09.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 09:53:51 -0800 (PST)
Date: Thu, 9 Nov 2023 12:53:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] virtio-snd: check AUD_register_card return value
Message-ID: <20231109125334-mutt-send-email-mst@kernel.org>
References: <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>
 <CAFEAcA-XqkBqKt33pxXHv0Y81kShV1rZatgAYMJNxibBD1a_6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-XqkBqKt33pxXHv0Y81kShV1rZatgAYMJNxibBD1a_6A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Nov 09, 2023 at 04:25:04PM +0000, Peter Maydell wrote:
> On Thu, 9 Nov 2023 at 16:21, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >
> > AUD_register_card might fail. Even though errp was passed as an
> > argument, the call's return value was not checked for failure.
> 
> For whoever picks up this patch: we can add
> "Fixes Coverity CID 1523899" to the commit message.


Better:

Fixes: Coverity CID 1523899

> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >  hw/audio/virtio-snd.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > index a18a9949a7..ccf5fcf99e 100644
> > --- a/hw/audio/virtio-snd.c
> > +++ b/hw/audio/virtio-snd.c
> > @@ -1102,7 +1102,9 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
> >          return;
> >      }
> >
> > -    AUD_register_card("virtio-sound", &vsnd->card, errp);
> > +    if (!AUD_register_card("virtio-sound", &vsnd->card, errp)) {
> > +        return;
> > +    }
> >
> >      /* set default params for all streams */
> >      default_params.features = 0;
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM


