Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A237E7515
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 00:25:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1ENK-0000ZD-DN; Thu, 09 Nov 2023 18:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r1ENI-0000Yq-3m
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 18:23:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r1ENG-0007h7-DA
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 18:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699572224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=krirHpLY3NF1l4R6AocRMnd0g98z8isP+zedPUtsLRI=;
 b=Tf+lh3VQFD6JoU/Hr9YclNgjX4676tTKPSwpH/zLfZUW22eLNMEsD7Jo97KnknIyITwO9J
 /E5iTr4dhLgh5dUbegRv54YxMIQ1kNFO9DdJBv4r8ACoff8dq2xdT99qzPwS8tfoiAFitI
 SEQNkUv7fo9yR3Q0zBneztBJ48rqVJM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-Itx4uHaoOHOQnJY6VX07vQ-1; Thu, 09 Nov 2023 18:23:43 -0500
X-MC-Unique: Itx4uHaoOHOQnJY6VX07vQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9d223144f23so110917466b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 15:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699572222; x=1700177022;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krirHpLY3NF1l4R6AocRMnd0g98z8isP+zedPUtsLRI=;
 b=nGlTD4COH4w3DmXi9+t9SyhK88oXlvXzD1uT+W+FWuf7RGlRD8cc0HXfvigYCbaGAI
 Y8W4WcHIcV6wXduVh7gAQEW2gjj4lwP6jwPmdZAjpyK/VHDJL2Ydhtifsn1Q2/ftoLhC
 5xm4JD2mUGMsWqI7FzIR+2fvjCB+ei0r6Dr+brtOLi3LwySiTi0zlHvlHRGa40Z+rHkG
 c8mfkF9BJH1Aid8u3rUbTYvNfRIu1BCHWcVN7ZLtEMmvgPUMgwIPhDOmg4IPllQJ6gsl
 kOzlksH2Dwi+Tx3CerAPeJQNPohALvyY6HjseM4LyEuWzIGT6j5zKeNQr/kbplxL1xaK
 6TOg==
X-Gm-Message-State: AOJu0YxH0ycHzaBLSngxRPOrCT/ntGgwD/e/9Q6w2GEvH/+Q8ckGCjVe
 cFoscJJ186fXEVrgof4O1e28+Aa12UzoA9MQ6zypjVjIhdPqUlSUmGoj+vFP0dO6IIlj9afbDLk
 oPed/nq66E8TGLLQ=
X-Received: by 2002:a17:907:987:b0:9d5:9065:90aa with SMTP id
 bf7-20020a170907098700b009d5906590aamr5749667ejc.76.1699572222141; 
 Thu, 09 Nov 2023 15:23:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZWwG1dxK9YQdXnPJvsB17UlhQfTPwZk4Et1oDGym0bAZTYy1OG4E6K+r7OFjK99ZicoUkXQ==
X-Received: by 2002:a17:907:987:b0:9d5:9065:90aa with SMTP id
 bf7-20020a170907098700b009d5906590aamr5749654ejc.76.1699572221754; 
 Thu, 09 Nov 2023 15:23:41 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
 by smtp.gmail.com with ESMTPSA id
 s18-20020a170906455200b009de3641d538sm3140865ejq.134.2023.11.09.15.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 15:23:41 -0800 (PST)
Date: Thu, 9 Nov 2023 18:23:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] virtio-snd: check AUD_register_card return value
Message-ID: <20231109181752-mutt-send-email-mst@kernel.org>
References: <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>
 <CAFEAcA-XqkBqKt33pxXHv0Y81kShV1rZatgAYMJNxibBD1a_6A@mail.gmail.com>
 <20231109125334-mutt-send-email-mst@kernel.org>
 <CAFEAcA9-tvxsoGoRksUSQpV-U=Pwc64CD0R17n-QkEwLA8OegA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9-tvxsoGoRksUSQpV-U=Pwc64CD0R17n-QkEwLA8OegA@mail.gmail.com>
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

On Thu, Nov 09, 2023 at 06:03:15PM +0000, Peter Maydell wrote:
> On Thu, 9 Nov 2023 at 17:53, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Nov 09, 2023 at 04:25:04PM +0000, Peter Maydell wrote:
> > > On Thu, 9 Nov 2023 at 16:21, Manos Pitsidianakis
> > > <manos.pitsidianakis@linaro.org> wrote:
> > > >
> > > > AUD_register_card might fail. Even though errp was passed as an
> > > > argument, the call's return value was not checked for failure.
> > >
> > > For whoever picks up this patch: we can add
> > > "Fixes Coverity CID 1523899" to the commit message.
> >
> >
> > Better:
> >
> > Fixes: Coverity CID 1523899
> 
> I thought "Fixes:" as a header-line like that was for
> the commit hash/subject of the commit the patch is fixing?
> 
> thanks
> -- PMM

This works for many other things
e.g. gitlab issues (closes them). Fixes without : is much harder to
distinguish from just general english text.
qemu uses a mix of Fixes: Resolves: and Closes: .
I don't see a real need for distinct tags for commit versus gitlab
issue link: one can look at the contents to figure that out.

-- 
MST


