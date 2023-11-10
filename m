Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5837E7B1B
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:56:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1OE6-0003kl-Ds; Fri, 10 Nov 2023 04:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r1OE3-0003im-VB
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:54:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r1OE2-00023P-Gb
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699610093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XvJBbmCXznI3ibUJIAscKSehlY4c5J8jU7DDclzgRng=;
 b=Tare3kSmm8m/K9agT8UhJFUEoJY/zLfwOtShtIOrizlN/L6p2NlQXvzde0hhxn3jT/Rgt4
 ygFi1L26IvKzzBVBSypO7Hpq4ivGAYwqAJz1jHxBSCZMlenEwqECtxBfE328Ub6XL48Atd
 fFRrq8NXh5p2lD20KHZiZiCXi4drJRg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-heWWVWaOMWKK2nPrHgmgWw-1; Fri, 10 Nov 2023 04:54:52 -0500
X-MC-Unique: heWWVWaOMWKK2nPrHgmgWw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77a656e72beso209106085a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 01:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699610091; x=1700214891;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XvJBbmCXznI3ibUJIAscKSehlY4c5J8jU7DDclzgRng=;
 b=bOiDBgJ8wbNSiHkflnWDSyVq/t0wOSj03bZZTO1Vhn7li8AaZGmgsZmsLsdxAoDQpp
 /m+zTDbQJ8pWbmvMudZjgKxRaf7W2DULqLfMadXen8AwxHqDjYHT4L1jIRUdiaRWVsKT
 FNPaeIMnyPxOBCz2ys6O4tToUsQ7gY3a76pp0MvMlEW1iPSSNEpjDwTp29WwZt+xrVCT
 QiTLCS2EFO6D2sCi45go0iIthg/OBh9bFT75BKFVpAQL1TaT1IwNDF9DXnXsBpVAPtwC
 uk11cOBRMA79WvyHRDxSHYMUYHQt3glQNcHXbYwCjfaMOTZEbPh4uOF9q6a90yzqz8c9
 MQLg==
X-Gm-Message-State: AOJu0Yx7e3UkCe9aOSkW4dDsc0N6hIC061h+XmZl+B9YhoLYBecJA8Qu
 RyUIM9bibkA27toWokwrNqkxYScb7LbASH/h+8Qfh8JolZPcMRWMhbtG2da/++TDrmMdV1/8sSi
 e/O7eH49Eg4Gp3cendjOGbA5nwYT1MRBDF3q0A3Y=
X-Received: by 2002:a05:620a:8d12:b0:778:953e:3433 with SMTP id
 rb18-20020a05620a8d1200b00778953e3433mr6840399qkn.31.1699610091606; 
 Fri, 10 Nov 2023 01:54:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdKIgm/7TWAtSMFuTRWLvaYU5ow+FeAgyHIUI3N14WSpotBvuQRSHBPjbEBBmB2ft5/HpthPhpiZIF8/bVlww=
X-Received: by 2002:a05:620a:8d12:b0:778:953e:3433 with SMTP id
 rb18-20020a05620a8d1200b00778953e3433mr6840390qkn.31.1699610091431; Fri, 10
 Nov 2023 01:54:51 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Nov 2023 01:54:50 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-8-victortoso@redhat.com>
 <CABJz62PFopBRaMBc8Smtse9DJEy+0Qii7DtiTZGQdks3dXOdUw@mail.gmail.com>
 <s2ev3hammcfpjbkrk7zxisge4a2cqr2gyomt2htir66vinfyhe@tupvidmxywzv>
MIME-Version: 1.0
In-Reply-To: <s2ev3hammcfpjbkrk7zxisge4a2cqr2gyomt2htir66vinfyhe@tupvidmxywzv>
Date: Fri, 10 Nov 2023 01:54:50 -0800
Message-ID: <CABJz62Ncr+r7iHrbv+kAjjuNB8cGAdRyAS0Q7yj2On7XzGkyZw@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] qapi: golang: Generate qapi's union types in Go
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Nov 09, 2023 at 07:35:04PM +0100, Victor Toso wrote:
> On Thu, Nov 09, 2023 at 09:29:28AM -0800, Andrea Bolognani wrote:
> > Additionally, this would allow client code that *looks* at the
> > union to keep working even if actual data is later added to the
> > branch; client code that *creates* the union would need to be
> > updated, of course, but that would be the case regardless.
>
> I think it is better to not have code that is working to keep
> working in this case where Spice is implemented.
>
> Implementing Spice here would mean that a struct type
> SetPasswordOptionsSpice was created but because the code handling
> it before was using struct type Empty, it will not handle the new
> struct, leading to possible runtime errors (e.g: not handling
> username/password)
>
> A bool would be simpler, triggering compile time errors.

You've convinced me :) Let's leave it like this for now. Once we
start seriously thinking about compatibility across versions then we
might have to reconsider this, but it's going to be part of a much
bigger, much more fun conversation ;)

-- 
Andrea Bolognani / Red Hat / Virtualization


