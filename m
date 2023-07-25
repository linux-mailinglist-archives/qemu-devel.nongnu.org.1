Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF78F7621F8
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 21:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qONHX-0003oj-Va; Tue, 25 Jul 2023 15:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qONHW-0003ic-5A
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qONHU-0005ar-L3
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690311671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FrdzgtWgbiw64lZLdsOue6c32PJ3KvDczaqjN7K60WM=;
 b=cgqxErdZZl7wDS5+LbNF3mbQG0LQvlsXBt/4txwY2vjHZkdjj01hrYYNHWnFaQQTSZw+e7
 kqmA8Os6IufUYwvei5aaWFSnfVbnpV1a+eKLL88zT3VUB4neWFlXfvZckHCW22dQ370IWN
 hvTnERW5xGsCrflgcX34wBMlQqBpJOY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-jOh_49W0Pyyp4P-0rdx_PA-1; Tue, 25 Jul 2023 15:01:08 -0400
X-MC-Unique: jOh_49W0Pyyp4P-0rdx_PA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2683548c37cso725883a91.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 12:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690311668; x=1690916468;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FrdzgtWgbiw64lZLdsOue6c32PJ3KvDczaqjN7K60WM=;
 b=mIPkRU4fngYV767XIACcCVQKRH6EDAKyH09FYfYORcI3FUSlWdYAPELAq0VV4KrGyK
 HOCQJd8KPCIEcz0baPgBAt9F2JStB8sz8ePTKhYw/otAq8VybPXBijC4D2sMV2Xpbo+W
 o3DtXbUOsYiKGP7Wi/YHZrDyfILX7/VoNkHQAOkXQ+Z7NaPe/zY6TAnxl6myi6gTuxvr
 Yj/73AvO11N60lvaJetSm/vqrB7iuPCHLWE7M+4y1WbGh5UNXFnr300caJFasbq4p1kd
 VDESwkJ4YxDgFng9dSGzkKa1XLQKWNut/ic3gT5J/7Aggm9wiQqnCmjtmcTjagZfLVZ9
 OGHg==
X-Gm-Message-State: ABy/qLazcbOkchnNcO7y2kFpYCOq2LRqKHT3D+CmWx/nKFcfT7jRPh8h
 +FCqC/BeR1s1xScn0NDrpODnp1Mz+gugqyapoEZ097t0lTsiaDwdtR/0RhXFpwu8R0IBrwtS95Y
 o8pcOyfrxVFnigAprnNFqSOX/Aw11nps=
X-Received: by 2002:a17:90a:d983:b0:262:ebfd:ce44 with SMTP id
 d3-20020a17090ad98300b00262ebfdce44mr37435pjv.34.1690311667905; 
 Tue, 25 Jul 2023 12:01:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGKVOgtvV1jZlxKZOMTQG65umMLJS4LaVpFYO4S8BN77odx+AsiV8dCYNpp2TuzEG0zhk26v3ti5o9bdaPkoKo=
X-Received: by 2002:a17:90a:d983:b0:262:ebfd:ce44 with SMTP id
 d3-20020a17090ad98300b00262ebfdce44mr37419pjv.34.1690311667625; Tue, 25 Jul
 2023 12:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230609140844.202795-1-nks@flawful.org>
 <ZLe/VG5d6TEdp/MT@x1-carbon>
 <b58779ed-cecb-824b-019e-bc34e6b2258a@linaro.org>
In-Reply-To: <b58779ed-cecb-824b-019e-bc34e6b2258a@linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 25 Jul 2023 15:00:56 -0400
Message-ID: <CAFn=p-Y4Tw0eY=8yXxnzSA3kzwb36H0oysag=HD_8eMsPNwuDg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] misc AHCI cleanups
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

On Tue, Jul 25, 2023 at 9:04=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Niklas, John, Paolo, Kevin,
>
> On 19/7/23 12:47, Niklas Cassel wrote:
>
> >> Niklas Cassel (8):
> >>    hw/ide/ahci: remove stray backslash
> >>    hw/ide/core: set ERR_STAT in unsupported command completion
> >>    hw/ide/ahci: write D2H FIS when processing NCQ command
> >>    hw/ide/ahci: simplify and document PxCI handling
> >>    hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared
> >>    hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
> >>    hw/ide/ahci: fix ahci_write_fis_sdb()
> >>    hw/ide/ahci: fix broken SError handling
> >>
> >>   hw/ide/ahci.c             | 112 +++++++++++++++++++++++++++---------=
--
> >>   hw/ide/core.c             |   2 +-
> >>   tests/qtest/libqos/ahci.c | 106 +++++++++++++++++++++++++++---------
> >>   tests/qtest/libqos/ahci.h |   8 +--
> >>   4 files changed, 164 insertions(+), 64 deletions(-)
> >>
> >> --
> >> 2.40.1
> >>
> >>
> >
> > Hello Philippe,
> >
> > Considering that you picked up my patch,
> > "hw/ide/ahci: remove stray backslash" (patch 1/8 in this series),
> > and since John seems to have gone silent for 40+ days,
> > could you please consider taking this series through your misc tree?
>

40 days, ouch. I kept thinking it had been a week. Don't trust me with time=
.

> (First patch was a cleanup)
>
> Niklas, I don't feel confident enough :/
>
> John, Paolo, Kevin, do you Ack?
>
> Regards,
>
> Phil.

I'm staging it, but it's for next release. We'll get it in early and
it gives us a chance to fix anything that's amiss before the next RC
window.


