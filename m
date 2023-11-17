Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF1F7EEB0B
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 03:30:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3obJ-0000Uc-2C; Thu, 16 Nov 2023 21:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r3obG-0000UB-Mu
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 21:28:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r3obF-0000I0-1l
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 21:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700188131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0ymwrbU24RHNFL/YBU+MbSMEepRsGgh4iA3W1I/qrI=;
 b=cVEJuJ2bIonSEvTb6ha1mCI7FDSA6WAeOQ5tepGf0c8GeFi4h497DUfD5XOKek8qglr6f1
 YRmgdzU5jeTFNtoFqnxC2LgExYffIZXDVqXgM/BjHmxJyB+tQycgbgbBm/moEJWXjd0622
 kx9y6SzuXkTWUPPHFtKK3xdrPGORpMI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-FlcO8YO-OwqBxt18hjagnA-1; Thu, 16 Nov 2023 21:28:49 -0500
X-MC-Unique: FlcO8YO-OwqBxt18hjagnA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507be692ce4so1422171e87.2
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 18:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700188128; x=1700792928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y0ymwrbU24RHNFL/YBU+MbSMEepRsGgh4iA3W1I/qrI=;
 b=YKpCHfhj8PvqWc+K1F5V4V8dMUHad1xfeQ/EvUgVKh5vbPvgfUHeyc3fXRKwsqZ5Qr
 mNlWbzL2tYZmqz2CzphJLnzGDtPl3XwM4J59YTXsgs8yL+6EpDMycDo2c4L4ztzgp8WN
 Jo8aQS7xdiOZuXsiNXkDy4d3GZYsn/iSMr5IA6ktTX8yDvKYwAFJLEYGlbpFEyFdgya9
 MVpYCYNQAgLpeyGXwdVRGpLV05GsiewxEM/V3dJRsNL3r1bPRpUL2foki6nqoUHB3jUh
 JOv//se1l+ZkydfB1+ab3Ya2sPQ9msYyjASv99BVInZ8c9d4zrFMNR2kd50tgTm6ARqb
 mnoA==
X-Gm-Message-State: AOJu0YyEsJD4RHze2Crltiokddl9jgq/kTyaWSeigcCQXbYTge/iwp5S
 CdYn++/s2NTMbSn/eRs9YGMk/UNiVnzQ+P9fAriKwqvpngoazfcm8u3l+t+ll9k4jb8PtaGgmoP
 dtNPzGzUtuosI9jVl7402Knh4lQIa/Kk=
X-Received: by 2002:a05:6512:3e5:b0:503:36cb:5438 with SMTP id
 n5-20020a05651203e500b0050336cb5438mr10837173lfq.21.1700188128558; 
 Thu, 16 Nov 2023 18:28:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLgfV7X4OEx6svVeEF+1aIxjk2NO3diXCYgSgLmJSzhgcLoA3n7BHk8bGwntwGEjToZsfbkK3PH91c1HM2zVc=
X-Received: by 2002:a05:6512:3e5:b0:503:36cb:5438 with SMTP id
 n5-20020a05651203e500b0050336cb5438mr10837169lfq.21.1700188128158; Thu, 16
 Nov 2023 18:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20231114030937.5461-1-jasowang@redhat.com>
 <3feb59f0c647f23f078cd0bb60af9e56f0845230.camel@infradead.org>
In-Reply-To: <3feb59f0c647f23f078cd0bb60af9e56f0845230.camel@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Nov 2023 10:28:36 +0800
Message-ID: <CACGkMEvtqUWrrNzwjR1Y5kR7GV_q9Dfx69+tagCcOBnTpuEdxQ@mail.gmail.com>
Subject: Re: [PULL 0/2] Net patches
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 17, 2023 at 12:49=E2=80=AFAM David Woodhouse <dwmw2@infradead.o=
rg> wrote:
>
> On Tue, 2023-11-14 at 11:09 +0800, Jason Wang wrote:
> > The following changes since commit 69680740eafa1838527c90155a7432d51b8f=
f203:
> >
> >   Merge tag 'qdev-array-prop' of https://repo.or.cz/qemu/kevin into sta=
ging (2023-11-11 11:23:25 +0800)
> >
> > are available in the git repository at:
> >
> >   https://github.com/jasowang/qemu.git tags/net-pull-request
> >
> > for you to fetch changes up to d90014fc337ab77f37285b1a30fd4f545056be0a=
:
> >
> >   igb: Add Function Level Reset to PF and VF (2023-11-13 15:33:37 +0800=
)
>
> Hi Jason,
>
> I note this doesn't include the net_cleanup() fix from
> https://lore.kernel.org/qemu-devel/20231115172723.1161679-2-dwmw2@infrade=
ad.org/
>

Yes, it's in the list of patches that need review and it seems fine.

> Do you mind if I submit that in a pull request with the other fixes
> from that series?

I've queued this for rc1. Pull request will be sent no later than 21st.

Thanks

>
> Thanks.


