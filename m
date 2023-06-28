Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82812740997
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:07:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPGP-0000om-KK; Wed, 28 Jun 2023 03:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qEPGO-0000nV-2x
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qEPGL-0003tb-Qq
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687936009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a+INeWBxW2YxHEZKtiGwzBrPaRyWMKBFnJ+LDMnR6jo=;
 b=FtX9pEK8gQnF/72o34G2XeVAyQ+wK01FwFt7tsWiI5lAyLhOgRlTd4iMu150RT0WPh4Z8q
 Dx7IbEDal3MNvgCBDKebBkQmXIM9FrOASluVgPcDm4FFiKR7iZC9bDkgT+nG+rT3WBagle
 2KQEf3GpOG9hTuy9JoIdgOGTpMIznuQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-RON8b2hsOWC4t9a6vy-2Jw-1; Wed, 28 Jun 2023 03:06:44 -0400
X-MC-Unique: RON8b2hsOWC4t9a6vy-2Jw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fb76659d37so2773346e87.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687936003; x=1690528003;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+INeWBxW2YxHEZKtiGwzBrPaRyWMKBFnJ+LDMnR6jo=;
 b=HGY53TMqaaubJsSetub5WoFuLdpzNjoCXn7LVIoHAg2w6/waLR1Hyl8WuEGalmP5WI
 m3N5pU+3FR7pFJV5D7Bqlem55Ksj32/akn6MKHz7dCENXmPEyu2+t5s54yl9KJqWKnSZ
 1wSMVkyJiZgzFcXzfC3JBS3r1TSWnBHG5LTFqPmxQ7UxJJx5vWjK8/gAf1bPLFc48l47
 I/3nd9KJCqKtjHEKPNhx3ovMvrmttlH23vnUXcs1FzGMrNmQOAovvvbDyaZT7L4Ji1Cw
 zrurfMK0hTK9B6S4ldqGwZ9o90ruIY9etfnE4A5uHa2h2Cpj73mcqt8B+ueIuoLHSGg7
 EPrw==
X-Gm-Message-State: AC+VfDzjcbph4rlJEKOSeI9IDDdwVtYDj5w/r0XGWg8vbcli2BANU+gT
 KnbRX2VuzNphiquTk3t2GQRa3SnLY4cFjaeEkRPhNElfCJC7W2eH9UufluY1REsX77c1R4T1dqt
 w9V3oRDyd1BYG7dfOPL1atCUU1eQEEOY=
X-Received: by 2002:a2e:95d7:0:b0:2b4:65bf:d7b with SMTP id
 y23-20020a2e95d7000000b002b465bf0d7bmr19259281ljh.2.1687936003296; 
 Wed, 28 Jun 2023 00:06:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4IZrVlS/36rOf5GXvIJVdqYFfoDGt7xo47bkJAEkQUf0nm4DvKnTk0fZhuNCiOQzh4dSp4DBRi/BQeQwmnTJ8=
X-Received: by 2002:a2e:95d7:0:b0:2b4:65bf:d7b with SMTP id
 y23-20020a2e95d7000000b002b465bf0d7bmr19259266ljh.2.1687936002953; Wed, 28
 Jun 2023 00:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <ACCE3C63-50B6-4310-9DF6-F1BE759F5B1E@redhat.com>
 <20230627103454-mutt-send-email-mst@kernel.org>
 <25A57CF2-5027-48B7-A879-8DE8BDEF60B3@redhat.com>
 <CACGkMEtjPqWYcF_bPoSu9AjrYJFVsXMh+q4ADtdz5HMG64dVcg@mail.gmail.com>
 <E0FEFB1B-2282-4040-92AC-BDB46D65EA07@redhat.com>
In-Reply-To: <E0FEFB1B-2282-4040-92AC-BDB46D65EA07@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 15:06:31 +0800
Message-ID: <CACGkMEtv1w+D_SoiEDK8YnFQ23QFAPOr9bjHji_uhnZF9sLSQw@mail.gmail.com>
Subject: Re: ARI and igb emulation
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, akihiko.odaki@daynix.com, 
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 28, 2023 at 3:01=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
>
>
>
> > On 28-Jun-2023, at 12:23 PM, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Jun 27, 2023 at 10:41=E2=80=AFPM Ani Sinha <anisinha@redhat.com=
> wrote:
> >>
> >>
> >>
> >>> On 27-Jun-2023, at 8:09 PM, Michael S. Tsirkin <mst@redhat.com> wrote=
:
> >>>
> >>> On Tue, Jun 27, 2023 at 08:02:46PM +0530, Ani Sinha wrote:
> >>>> Hi :
> >>>> I am proposing a patch in QEMU [1] which may or may not break ARI bu=
t I wanted to give my best shot in making sure I am not breaking anything w=
ith ARI enabled. I see that your igb emulation code enables ARI with its SR=
IOV emulation. I ran the qtest and avocado tests that are mentioned in [2] =
and they both pass. Is there anything else/any tweaks that I should be doin=
g to make sure I am not breaking ARI with igb?
> >>>>
> >>>> Thanks for information,
> >>>> Ani
> >>>>
> >>>> 1. https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg05478.ht=
ml
> >>>> 2. https://www.qemu.org/docs/master/system/devices/igb.html
> >>>>
> >>>
> >>> I think that just creates igb. to test ARI you need to add
> >>> igbvf devices. Jason maintains it. But really pls go back on-list.
> >>
> >> +Jason
> >> +qemu-devel
> >>
> >
> > Yes, you need to at least create VFS and test some throughput on it
> > (probably need a vIOMMU).
>
> Is there a test that I can run?
>

A simple netperf/iperf should be sufficient.

Thanks


