Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 657437E083D
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 19:35:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyyzz-0003Ws-48; Fri, 03 Nov 2023 14:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1qyyzx-0003Wi-Ul
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 14:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1qyyzw-0008Vw-Cj
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 14:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699036462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O8zNvBXd6S2P/7V6beCc7C1ZuMahbSq4vIlsc/6LbU4=;
 b=a161kyLZa4ggRfeu5zgqaI35UEa2WCMdeli7O8XXPUpJ+cFhNXHvZZCgML0JLXRcOVICWt
 tftobiaQyJ4u0Uf9TJztl6/681QG8B9yroAKksD/Spxw8I6ZqoIqnjLC/wJBqi1XXFnKU+
 DzRrr8xf2CmjiOKypZJhoEHRosZBbdk=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-SmJk_totNJin-wq25Eiz0A-1; Fri, 03 Nov 2023 14:34:20 -0400
X-MC-Unique: SmJk_totNJin-wq25Eiz0A-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6c0f174540cso3094426a34.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 11:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699036459; x=1699641259;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O8zNvBXd6S2P/7V6beCc7C1ZuMahbSq4vIlsc/6LbU4=;
 b=B1dCGElnm5WSTFG3xpfUbR2gBWjkW71/XnYFldKJQXORvWQF0nSKsNdeGOa+da7JuX
 x2gqHaQnWfv06u9hmDy5irMy2p3D0RjrJHkH3efD4O1q5y1Qi+1H2db72FKwmrhZyQ81
 fCdS0vc2a3N9yWl3fiL3C6FWgYDju+dlvQR8Za3LdZCKhml1Kn9uHmFBKUFSZ7RHfgjK
 Vnz97jnpTd9fdwh8Z54g8N+YfzcgPuyxcIgcm9BDKTcHt6+8J+0RYaZbijrUS+FRhyJL
 adr8r5NmQ2EL7PLZ4FdJ6L4s/Bi20YMc+rXxCO7Ufefiwfa/1ym6LNbwivv4XD8Dr4Nd
 Cy0g==
X-Gm-Message-State: AOJu0YxyrghPQvdJ8ie7/XxI2DXI3aVAZ11fG9e5oSo6fsaJTPyaIA+x
 9b4ueXmfegiQCEtX9uo43VT5gAsfdSnhrr/u7+F3rZTanvfDQLrqUa5Zjcenc0sEmuxm1p2zxUN
 Ba1t8NtVW1uDzftYYK8IyxkqEJkVzA24=
X-Received: by 2002:a05:6830:3103:b0:6d3:e5c:768f with SMTP id
 b3-20020a056830310300b006d30e5c768fmr11961421ots.11.1699036459594; 
 Fri, 03 Nov 2023 11:34:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXAzxBNAXTuKA5fTtKOWH0UcHpRySrRLobuwcPowzMX1G9p3Ax0AFNHEPy2FtaspKSb778AgPmQ5FSpZD29tI=
X-Received: by 2002:a05:6830:3103:b0:6d3:e5c:768f with SMTP id
 b3-20020a056830310300b006d30e5c768fmr11961409ots.11.1699036459324; Fri, 03
 Nov 2023 11:34:19 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Nov 2023 11:34:18 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <5drfnt5rr5jmjl7xv65355squ2zzjra23mdrk5q3avnbue4kqx@7pmoj2zwfggx>
 <CABJz62PV8s=Dmh9cpa-3cRaLdNmUnW5zo4MYUA3=6kDdW8QbcA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABJz62PV8s=Dmh9cpa-3cRaLdNmUnW5zo4MYUA3=6kDdW8QbcA@mail.gmail.com>
Date: Fri, 3 Nov 2023 11:34:18 -0700
Message-ID: <CABJz62MQ6oYMiPicbERYoV-DYozciDXB9p5mT11P4bsajYy+KA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] qapi-go: add generator for Golang interface
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Oct 31, 2023 at 09:42:10AM -0700, Andrea Bolognani wrote:
> On Fri, Oct 27, 2023 at 07:33:30PM +0200, Victor Toso wrote:
> > Hi,
> >
> > Daniel & Andrea, it would be great to have your take on the Go
> > side of this series. If we can agree with an acceptable
> > 'unstable' version of Go modules, we can start building on top of
> > this:
> >  - libraries/tools in Go to interact with QEMU
> >  - qapi specs to fix limitations (e.g: Data type names)
> >  - scripts/qapi library wrt to generating interfaces in other
> >    languages other than C
> >
> > I would love to have this prior to 8.2 feature freeze if the
> > idea and current code meet your expectations.
>
> Apologies for not providing any feedback so far. I'll do my best to
> get around to it by the end of the week.

Layering apologies on top of apologies: I started looking into this,
but I have since realized that I need some more time to page all the
months-old context back in and digest the whole thing. I'll continue
next week.

As an appetizer, one thing that I've noticed: you seem to ignore it
when gen:false is included in a command definition, so we get

  type DeviceAddCommand struct {
      MessageId string  `json:"-"`
      Driver    string  `json:"driver"`
      Bus       *string `json:"bus,omitempty"`
      Id        *string `json:"id,omitempty"`
  }

which I don't think will work as it can't handle even the example
used to document the command

  { "execute": "device_add",
    "arguments": { "driver": "e1000", "id": "net1",
                   "bus": "pci.0",
                   "mac": "52:54:00:12:34:56" } }

This command will probably require an ad-hoc implementation.

-- 
Andrea Bolognani / Red Hat / Virtualization


