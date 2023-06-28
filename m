Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 161C97409A7
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:16:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPPN-0001WR-Iz; Wed, 28 Jun 2023 03:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qEPPL-0001Ui-5E
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qEPPG-0007Ze-7y
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687936561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9OIWNu1aJbqoqBFRwpPhm7lEjoMe9Qe3ZKm47TNmYI=;
 b=HnWLlI7ukSGVItNM6nVA1he1tNwFf7KHqVR8faEPWoW5hKtqX2eZLLY762KHedRtdig706
 a72eFmI7koiT78Y3jbdv30ajK2MvZpbqHH8lqntElPL7iHCIVZVGeIobDiOJtRkhpLB9x1
 U90EJXaKBq/IKJtorR7ajmwmqNztVb8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-mqOeqpInP3uxkED9alzyEg-1; Wed, 28 Jun 2023 03:15:59 -0400
X-MC-Unique: mqOeqpInP3uxkED9alzyEg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b699c5f238so28261551fa.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687936557; x=1690528557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9OIWNu1aJbqoqBFRwpPhm7lEjoMe9Qe3ZKm47TNmYI=;
 b=WP/5U3kV0PN0gXuRMDWCwUFCvcDiQeFiyjhI2ucNds60t4TdgubVCWphAtFroYPoWh
 goo0EWDqc63LRtvhMiIHisAWxVtzJLdGbF9Ycd57rlv5GYQo6kOnFID8TdI+IoEU9npZ
 JCXpXayQ+Dm7zrINxfDy8cUx1YvAoJCKZBZaU4YWpNtGFYDNdDWu4H8QBcgzssqZ3nR+
 9655nG7Yst7NZl9U2cRkr9+koY0RtuHa5J1BaEsa8QWReuboiMBqWjVQHEib9dlt9qBt
 5fNH87MeUp/RvPeXtxyBCqzJI6O0gfcInse54aexskX80nhGLjZLw7LSvJZyKMiyPrB+
 yXVA==
X-Gm-Message-State: AC+VfDySReAW0bak/6PQhZNzUBZhfYUhfsx3XwcwEWDBE0gBvm6LZJiq
 srwQUP57xOre/dc8nGgijz3j4QZJqbJ3XyRnYPShDhK02Wi2flzgwxcBIXH4MGRv02SGOKAvEB4
 gkExOr+mGiK0p12xaOhBio9fXptqn7s954J9liqxbqshX
X-Received: by 2002:a2e:7a17:0:b0:2b5:1b80:2637 with SMTP id
 v23-20020a2e7a17000000b002b51b802637mr16147449ljc.25.1687936557625; 
 Wed, 28 Jun 2023 00:15:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ430qwl8Juk93qfA7RlKxPatC65lY/TZB7Mcpqm9xsVcJuSGeAgDogIoWnjJQuzNfHla7thNm7LKI3t28EiK9Y=
X-Received: by 2002:a2e:7a17:0:b0:2b5:1b80:2637 with SMTP id
 v23-20020a2e7a17000000b002b51b802637mr16147438ljc.25.1687936557343; Wed, 28
 Jun 2023 00:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <ACCE3C63-50B6-4310-9DF6-F1BE759F5B1E@redhat.com>
 <20230627103454-mutt-send-email-mst@kernel.org>
 <25A57CF2-5027-48B7-A879-8DE8BDEF60B3@redhat.com>
 <CACGkMEtjPqWYcF_bPoSu9AjrYJFVsXMh+q4ADtdz5HMG64dVcg@mail.gmail.com>
 <E0FEFB1B-2282-4040-92AC-BDB46D65EA07@redhat.com>
 <CACGkMEtv1w+D_SoiEDK8YnFQ23QFAPOr9bjHji_uhnZF9sLSQw@mail.gmail.com>
 <E10303DB-04AE-41AD-A721-6BB96760EE47@redhat.com>
In-Reply-To: <E10303DB-04AE-41AD-A721-6BB96760EE47@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 15:15:46 +0800
Message-ID: <CACGkMEufBvDRu35idi=QL+kwyfF7YZnAz0nDYw7J8f9U1PDPEg@mail.gmail.com>
Subject: Re: ARI and igb emulation
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, akihiko.odaki@daynix.com, 
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Jun 28, 2023 at 3:10=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
>
>
>
> > On 28-Jun-2023, at 12:36 PM, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, Jun 28, 2023 at 3:01=E2=80=AFPM Ani Sinha <anisinha@redhat.com>=
 wrote:
> >>
> >>
> >>
> >>> On 28-Jun-2023, at 12:23 PM, Jason Wang <jasowang@redhat.com> wrote:
> >>>
> >>> On Tue, Jun 27, 2023 at 10:41=E2=80=AFPM Ani Sinha <anisinha@redhat.c=
om> wrote:
> >>>>
> >>>>
> >>>>
> >>>>> On 27-Jun-2023, at 8:09 PM, Michael S. Tsirkin <mst@redhat.com> wro=
te:
> >>>>>
> >>>>> On Tue, Jun 27, 2023 at 08:02:46PM +0530, Ani Sinha wrote:
> >>>>>> Hi :
> >>>>>> I am proposing a patch in QEMU [1] which may or may not break ARI =
but I wanted to give my best shot in making sure I am not breaking anything=
 with ARI enabled. I see that your igb emulation code enables ARI with its =
SRIOV emulation. I ran the qtest and avocado tests that are mentioned in [2=
] and they both pass. Is there anything else/any tweaks that I should be do=
ing to make sure I am not breaking ARI with igb?
> >>>>>>
> >>>>>> Thanks for information,
> >>>>>> Ani
> >>>>>>
> >>>>>> 1. https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg05478.=
html
> >>>>>> 2. https://www.qemu.org/docs/master/system/devices/igb.html
> >>>>>>
> >>>>>
> >>>>> I think that just creates igb. to test ARI you need to add
> >>>>> igbvf devices. Jason maintains it. But really pls go back on-list.
> >>>>
> >>>> +Jason
> >>>> +qemu-devel
> >>>>
> >>>
> >>> Yes, you need to at least create VFS and test some throughput on it
> >>> (probably need a vIOMMU).
> >>
> >> Is there a test that I can run?
> >>
> >
> > A simple netperf/iperf should be sufficient.
>
> I meant a full test script that uses igb emulation with vfs etc. I really=
 do not have time to set this whole thing up manually.

It's not that complicated, start a vm with vIOMMU + igb, create a vf
and run a quick netperf.

> Maybe something was used to test sriov and igb emulation while developmen=
t and a test might have been committed in QEMU.
>

No, there's a igb qtest but it looks to me it doesn't create vf. There
are also automated test scripts in avocado-vt which might require some
small tweaks to support igbvf.

Adding Lei for more thoughts.

Thanks


