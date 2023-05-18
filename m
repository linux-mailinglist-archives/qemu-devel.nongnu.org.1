Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D481A707EBE
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:03:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzbOZ-0008T9-LS; Thu, 18 May 2023 07:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzbOT-0008SU-BS
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzbOR-0004Sm-0f
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684407717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mn7QcjJfy6YbLBeMxAXbkMt7xL0H7aoYUxsPFn016Ho=;
 b=GCUvbVxJAje1SOuLQJFC0Ki615kNS+zwnxhO8EgqiGmeGone6KwF0oo98GNiFF7HDI8Fvc
 jKv+YzUTyyrmsl+mZ4a1759V844PfQH0XX9AsMOygLL8TDEiHtfcuKT5h+GOvZTcb56f16
 oGcPGsIEcWGpGlf04+6ifUQxYzAu46g=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-ywDby1rgNwOK5r0FlDhU7g-1; Thu, 18 May 2023 07:01:55 -0400
X-MC-Unique: ywDby1rgNwOK5r0FlDhU7g-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-643accc41a5so716651b3a.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684407714; x=1686999714;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mn7QcjJfy6YbLBeMxAXbkMt7xL0H7aoYUxsPFn016Ho=;
 b=Joe+lDY730MxvHv+wpJn04OJvYPQp1ALQvzrRoeGkL6U6nx5pbIb786idBXteF/vHU
 wSdgAyGx/XRB3mCO4yBH5mg9LkQXoGlg3tuv3lGxQIZlJgNcbg5lbr1YBlHhT1xyKdGj
 KN6ggGofWN3IsJF7fpFTojejLJ6OyxKJHZibKdhlViLHNpMhB2zJ571EZRPsntQiVJS3
 1sBky+LvaaNnY0tfaE/ZZklrnVEgXZcSHLJU+o0T4SYmDf5umcrOZzJANzfc0wAf6hQO
 baUrHBVPPC9ZlP36QCO34UeaF8AtSi1PFP+g9qOBfGH5Eq8kDfByq7xMVuN/BuWrc9an
 ++dw==
X-Gm-Message-State: AC+VfDwyirlpsUXLfpHvzoyjyEE/9VnrWz18LvQNF2i3x2XRp80GOWMx
 zaxINkWi6MR+P4a6RQ2aPfoPtR1Uakd3VIEL5+uNIagr4ErnPxwDKdXXtwuAEq7o975jXLgcpTA
 Hlm2i5VO8yx2kKAY=
X-Received: by 2002:a05:6a00:18a0:b0:646:7bc9:c480 with SMTP id
 x32-20020a056a0018a000b006467bc9c480mr3082336pfh.10.1684407714483; 
 Thu, 18 May 2023 04:01:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7vo1F7jIWvXS/dt6aE5gGd9JvJzMfpO0gsm4KKphDd8Po2a75rpBS55Q6yGD8N7lZzoYpmEw==
X-Received: by 2002:a05:6a00:18a0:b0:646:7bc9:c480 with SMTP id
 x32-20020a056a0018a000b006467bc9c480mr3082317pfh.10.1684407714141; 
 Thu, 18 May 2023 04:01:54 -0700 (PDT)
Received: from fc37-ani ([115.96.106.170])
 by smtp.googlemail.com with ESMTPSA id
 j26-20020a62e91a000000b00649ac17779csm1081981pfh.160.2023.05.18.04.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:01:53 -0700 (PDT)
Date: Thu, 18 May 2023 16:31:48 +0530 (IST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
In-Reply-To: <20230518063559-mutt-send-email-mst@kernel.org>
Message-ID: <d69e10b7-597d-913f-eb90-ed59b5b669f7@redhat.com>
References: <20230517101523-mutt-send-email-mst@kernel.org>
 <B6AD0FB1-CF05-4B4C-B58D-279422895E4D@redhat.com>
 <20230517103522-mutt-send-email-mst@kernel.org>
 <ED522229-5A71-40C2-AF2C-5D921B0B5D54@redhat.com> <87zg63m18g.fsf@linaro.org>
 <20230517112347-mutt-send-email-mst@kernel.org> <87r0rflzd4.fsf@linaro.org>
 <20230517120710-mutt-send-email-mst@kernel.org> <87ilcqnckm.fsf@linaro.org>
 <C2CC04A8-F0F1-4360-ABF0-1F8DF7768AB1@redhat.com>
 <20230518063559-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-1463778935-17322284-1684407713=:458984"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463778935-17322284-1684407713=:458984
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Thu, 18 May 2023, Michael S. Tsirkin wrote:

> On Thu, May 18, 2023 at 11:31:47AM +0530, Ani Sinha wrote:
> >
> >
> > > On 17-May-2023, at 9:50 PM, Alex Bennée <alex.bennee@linaro.org> wrote:
> > >
> > > ./tests/bios-tables-test --iasl-path ${CONFIG_IASL}
> > >
> > > and then you have the best of both worlds. You can run manually with a
> > > different path and you don't need to pollute config-host.h
> >
> > It could also be an environment variable set by meson. Then bios-tables-test can do a genenv() just like it does for verbosity etc. The environment can also be used by other tools that might need iasl in the future. We do not need to introduce new command line option.
>
> The annoying thing with both these approaches is they work
> less well than current code since iasl won't be invoked
> at all if you do not remember the magic variable to set
> or flag to pass. ATM it is self-contained.
>
> Can we split this variable out to config-test.h maybe?
> Then you can reconfigure with a different iasl and QEMU
> will not be rebuilt, just the tests.

TBH, it looks more and more like our previous approach was simple and
better before we started tying iasl to meson.
---1463778935-17322284-1684407713=:458984--


