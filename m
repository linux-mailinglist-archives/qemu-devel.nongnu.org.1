Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 428287E7199
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 19:36:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r19s3-0006bi-Qp; Thu, 09 Nov 2023 13:35:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r19s0-0006TO-Vh
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:35:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r19rz-0000jr-70
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699554910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3G/60C8tVI2fdp2p+VeUxhEsK8H7wTf6C243oHXhdEg=;
 b=PW5l50saskZkn7AWuZuS/0TM3uP+RDh34kPMmT5XAJWUi1dBVG6nWcE0n3nSdsD8zzAzy5
 oZMH8tgKZ28YAfQvu6A1CDT50EkQBGT0qBP56QXycMB0l76sWOZIqY0r9eJ3AEmc0M7PJc
 6HP1HDm2n0B89OutpnfpUB2Nun1Qkoo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-wJwfERDWOAm7j7UjTBQ8lA-1; Thu, 09 Nov 2023 13:35:08 -0500
X-MC-Unique: wJwfERDWOAm7j7UjTBQ8lA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-421aca7f03eso1381371cf.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 10:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699554908; x=1700159708;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3G/60C8tVI2fdp2p+VeUxhEsK8H7wTf6C243oHXhdEg=;
 b=B3JhQ2KzKGYNATdUTjTjbOl3exl592WOO1PDWLZdqW4KiGhsGD5jbyukwYKQZ06LGE
 Iw5a8dt21tehR8ttICLrSZnq51dHq4Ku+xbdxY3XI4ZPTKepk1ikDISKCxq28bVaJ1kY
 jX1Shw/BNszFHWk2AkvE1HLUmdWhMe/EyCqTt0BKS5n3HxZz3vNbYDuVZJUOlACBD06u
 Ojv+gNSontr893zFf86zDUxTkG9oV65PDmsMnYXHZx18Kz+0dnsL8jYYtK8InDjpHx/9
 R4lRoby2w6NHfgOKYLzoDcb7McKseJcI1U5PaVcz5NJExomgzdJjrkefiqzFZzaWQFKZ
 e30A==
X-Gm-Message-State: AOJu0Yx5gAYs+sjEjzQA2lnHlisxmZpqWLP4dGZZ3cm79L0LIATbmf/J
 ZLYWvV+lm9SlUm2aPHbA55DN0cvOUdUxVPyld4M0mWaIcHb2Qv6J1bQaddVAaOgI0FJ8conr7gn
 lrDicRsN6QL9V3RyUpR2S6QO4Oe88dcI=
X-Received: by 2002:a05:622a:8:b0:418:bdf:f4b with SMTP id
 x8-20020a05622a000800b004180bdf0f4bmr6469200qtw.6.1699554908168; 
 Thu, 09 Nov 2023 10:35:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk/g2rthxzKG+U3wqfJV1YxLvfVtgZ89HBcvFPNnBjHc3ysmVplK4LrqYzQVOkZt////3cRo4pfFM79mq5K7Y=
X-Received: by 2002:a05:622a:8:b0:418:bdf:f4b with SMTP id
 x8-20020a05622a000800b004180bdf0f4bmr6469183qtw.6.1699554907907; 
 Thu, 09 Nov 2023 10:35:07 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Nov 2023 10:35:07 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20231016152704.221611-1-victortoso@redhat.com>
Date: Thu, 9 Nov 2023 10:35:07 -0800
Message-ID: <CABJz62M1QnjdutHvPi9dyEueEU+BEfqK+xXeHw5GXeJaR+PcAA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] qapi-go: add generator for Golang interface
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
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

On Mon, Oct 16, 2023 at 05:26:53PM +0200, Victor Toso wrote:
> This patch series intent is to introduce a generator that produces a Go
> module for Go applications to interact over QMP with QEMU.
>
> This is the second iteration:
>  v1: https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg06734.html
>
> I've pushed this series in my gitlab fork:
> https://gitlab.com/victortoso/qemu/-/tree/qapi-golang-v2
>
> I've also generated the qapi-go module over QEMU tags: v7.0.0, v7.1.0,
> v7.2.6, v8.0.0 and v8.1.0, see the commits history here:
> https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v2-by-tags
>
> I've also generated the qapi-go module over each commit of this series,
> see the commits history here (using previous refered qapi-golang-v2)
> https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v2-by-patch

I've provided feedback on the various facets of the API in response
to the corresponding patch. Note that I've only addressed concerns
about the consumer-facing API: I have some notes about the
implementation as well, but that's something that we should be able
to easily change transparently so I didn't give it priority.

Overall, I think that the current API is quite close to being a solid
PoC that can be used as a starting point for further development.

-- 
Andrea Bolognani / Red Hat / Virtualization


