Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A450673A152
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:00:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJu5-00070Y-H6; Thu, 22 Jun 2023 08:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1qCJts-000706-97
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:59:00 -0400
Received: from esa14.hc2706-39.iphmx.com ([216.71.140.199])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1qCJtq-0000Qi-29
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:58:59 -0400
X-IronPort-RemoteIP: 209.85.160.198
X-IronPort-MID: 311855911
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:kuFKWqg235IWwUjiRZru4wBzX1613hIKZh0ujC45NGQN5FlHY01je
 htvCGDUbqmNYWHyfIwgb463p0sGsJ6Dy9AwGVA4rXgzEXsW8JqUDtmndXv9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZhSAgk/rOHvykU7Ss1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpKrfrbwP9TlK6q4mhA4AZkPaojUGL2zBH5MrpOfcldEFOlGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiM+t5qK23CulQRrukoPD8fwXG8M49m/c3Gd/
 /0W3XC4YV9B0qQhA43xWTEBe811FfQuFLMqvRFTGCFcpqHLWyKE/hlgMK05Fdwz3fhxOF9ey
 f47ImpRRR2Pg/3v3r3uH4GAhux7RCXqFIYWu3Ul1C2ASPh/EMCFTKLN6ttVmjw3g6iiH96EP
 5tfOWcpNUqYJUQeaj/7C7pn9AusrnD7YztUsnqfuOw673W7IAlZi+G0YIeIK4XTLSlTtkOgv
 Wz02HykOC8TD9uW1Aa83lm11vCayEsXX6pXTtVU7MVCmVCW2ykfBQMbUXO9pv+2jFP4XMhQQ
 3H44QIrpKk2sVW3F5zzBkzo5nGDuREYVpxbFOhSBByx95c4Kj2xXgAsJgOtovR93CPqbVTGD
 mO0ou4=
IronPort-HdrOrdr: A9a23:UfWWVaEKe7vhQUzDpLqEPceALOsnbusQ8zAXPiFKOGNom6mj/P
 xG88576faKskd2ZJhNo7y90eq7MArhHOdOkPQs1O6ZLXXbUQiTXf9fBOnZowEIQBeOjtK1vJ
 0IG8JD4bvLYmSS5vyW3ODXKbgdKKTuytHTuQ729QYXcei/UdAD0+8EYjzrdXGePDM2ZqbR46
 DsgvavDgDQHEgqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AVwca4Gjpga1T91jvelnnzJvPFDJuI1b60nHpHV+?=
 =?us-ascii?q?EC0VjEuG+RFOU5/p6nJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ae5JKbQ6OJlrATP/u3prM01MHxoxt27+gOmcVzK8?=
 =?us-ascii?q?4svKDPDFMAhu2lWSoF9o=3D?=
Received: from mail-qt1-f198.google.com ([209.85.160.198])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Jun 2023 08:58:53 -0400
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3ff415d5cd8so24493811cf.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 05:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1687438733; x=1690030733;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+BoM/bHbi/ZSyioPf90OQ/5BTkbs4ZO1yBtBN8HcvnY=;
 b=iBTb+ysU4UPVVWV1isIKjrO/CBqexX9i8rouHkrNAs5proFK2PK86+++WWrHTAgUye
 Z+XPC3RiaBQl1ZDoka6FvSvhbkNfF+9iBKjnhm+uLJzGsEWipqe2IEPR3wPqVHHAX1Uq
 5GIMyI8x3OcYpbtmRbPOjoN4kQ+Y9cz61BeMBR3gfJkhSeyVsIA7cSC/gS/V0NNbbVo3
 Gokmf1O7m26TXpi7BMYuxSrAhBHn+y9TzeI7Tcmprrsxv/ZdkDfYDKklvJThWvI+qgqx
 v7K5RqsLGIFTsXD3AI7sQgHcuIDSjFiaDnsA6wLSXHS4AxRYcuQ1sisSR+7RZ8a8okQ6
 V+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687438733; x=1690030733;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BoM/bHbi/ZSyioPf90OQ/5BTkbs4ZO1yBtBN8HcvnY=;
 b=MFSMxxNxr4TMm6eHo3nTE+yCE/k/Rl+0x5TIqdVzWyH3UY87Rb2ZP7Q1//f3XrbGnF
 dHso3e4GaCYQRHv79CbM/KHltDhvW2BJlskdea0F+UMtDFHKWmddtBloN8vKO9catNL1
 o4RrfeZElbaLxVJqjkF0sYrvqImfo4P+c46hs7ksQgDG9evQstgV8bNTq/mzaNyiQ+XZ
 mBV95ABHdhhKyX4CEIXpFkhiA564WWRcu3W+EF0hIqcXEpAsV7IEfUhYQ2v8QP1qW2rA
 ZtzMc3BbrmBbT/YO7RxByxmVVh5Kl3D7JHEwaboLEnN/3E4OL68A2zCSQYP22gplwhHv
 FuhQ==
X-Gm-Message-State: AC+VfDybMMCmRdYQ2/Bnk9DEPfOu6i8s+5gJRlXwViM1AjKgNaC2cXMV
 orVV/yGilPArxtxQzNgpAiSvZM3Z7XyZAbKvP55iow117pXfrgse+pEjRyjyb8TEy6qSsh4g7fs
 nYTe9xUmEK5LlOaWIKJASfMJyNHkV8Q==
X-Received: by 2002:ac8:5bd1:0:b0:3fd:ecdc:1e26 with SMTP id
 b17-20020ac85bd1000000b003fdecdc1e26mr16565013qtb.13.1687438733169; 
 Thu, 22 Jun 2023 05:58:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6AnrEF0vR7cKGxeqvZskefL2llQnLdShEwgNdBvQBvQZEokbJtC8Za7jCw7QqqJkzWs1GYCg==
X-Received: by 2002:ac8:5bd1:0:b0:3fd:ecdc:1e26 with SMTP id
 b17-20020ac85bd1000000b003fdecdc1e26mr16564999qtb.13.1687438732927; 
 Thu, 22 Jun 2023 05:58:52 -0700 (PDT)
Received: from mozz.bu.edu (mozz.bu.edu. [128.197.127.33])
 by smtp.gmail.com with ESMTPSA id
 ey13-20020a05622a4c0d00b003f6a0fa022bsm3586675qtb.51.2023.06.22.05.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 05:58:52 -0700 (PDT)
Date: Thu, 22 Jun 2023 08:58:49 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Subject: Re: [PATCH] usb/dev-wacom: fix OOB write in usb_mouse_poll()
Message-ID: <20230622125844.6jqpn3gfxzgn4xnd@mozz.bu.edu>
References: <20230213174113.591632-1-mcascell@redhat.com>
 <20230329094253.jxn2ikrn646a2hi6@mozz.bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329094253.jxn2ikrn646a2hi6@mozz.bu.edu>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.140.199; envelope-from=alxndr@bu.edu;
 helo=esa14.hc2706-39.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, SPF_HELO_PASS=-0.001,
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

On 230329 0542, Alexander Bulekov wrote:
> On 230213 1841, Mauro Matteo Cascella wrote:
> > The guest can control the size of buf; an OOB write occurs when buf is 1 or 2
> > bytes long. Only fill in the buffer as long as there is enough space, throw
> > away any data which doesn't fit.
> > 
> > Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> 
> Tested-by: Alexander Bulekov <alxndr@bu.edu>
> 
> Thanks
> 

Ping. I don't think this made it in yet?

> > ---
> >  hw/usb/dev-wacom.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> > 
> > diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
> > index 7177c17f03..ca9e6aa82f 100644
> > --- a/hw/usb/dev-wacom.c
> > +++ b/hw/usb/dev-wacom.c
> > @@ -252,14 +252,20 @@ static int usb_mouse_poll(USBWacomState *s, uint8_t *buf, int len)
> >      if (s->buttons_state & MOUSE_EVENT_MBUTTON)
> >          b |= 0x04;
> >  
> > -    buf[0] = b;
> > -    buf[1] = dx;
> > -    buf[2] = dy;
> > -    l = 3;
> > -    if (len >= 4) {
> > -        buf[3] = dz;
> > -        l = 4;
> > +    l = 0;
> > +    if (len > l) {
> > +        buf[l++] = b;
> >      }
> > +    if (len > l) {
> > +        buf[l++] = dx;
> > +    }
> > +    if (len > l) {
> > +        buf[l++] = dy;
> > +    }
> > +    if (len > l) {
> > +        buf[l++] = dz;
> > +    }
> > +
> >      return l;
> >  }
> >  
> > -- 
> > 2.39.1
> > 
> > 

