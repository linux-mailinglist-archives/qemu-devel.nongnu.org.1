Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD491746911
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 07:41:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGYlt-0002XZ-II; Tue, 04 Jul 2023 01:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGYla-0002Wh-2R
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 01:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGYlW-0003K1-NP
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 01:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688449192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4gKI+fcM3QTsUpzOI8TdAowmhfWzmBfCT4hlBb0eQ0=;
 b=eNYj1o3xf6WbeO24e5Wr/vZZndu0Gj4h2piX5YCb70Dqng5EPhpI0bJhUnJ+r5cfTNk7PT
 JOF+Tv9OeaB2TkEC+xjFGHPNPyhVV8ovqL/X3j+Dpy/5w9xgoeqUh2ifGMnXLqQXMm024p
 RDy8tdeKIHfHDsBJFkTxXwOo+Ah7xks=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-NldwVD1UPNStK4IhyzBTjA-1; Tue, 04 Jul 2023 01:39:49 -0400
X-MC-Unique: NldwVD1UPNStK4IhyzBTjA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1b7dd5bca25so57658445ad.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 22:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688449188; x=1691041188;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t4gKI+fcM3QTsUpzOI8TdAowmhfWzmBfCT4hlBb0eQ0=;
 b=CeocXMzWzIxQ+nPaCS9JHgLJrW2HBYmYkfEg9Kop3PhWMPCyiE2QDQlRbm6AsPeCsx
 z3HKfgeCJT1aLQtOWGzWNe8BHrzkNJzRVORrLRrvCLpyH0yJUDd34nHNAnAgM2AGZ7JS
 crPVQIQoe3m+6qoJAWQPkaCXQLubFmcU6tYFOJeVz63qkS+qZauTaED48WDTph2nTOIo
 qhfJJCraq9CX3r6keqyV/BW1auZ6FhCAffIrRAcUkqFwdthxKhxR8gHqP68zX1V+2AL2
 CYMxUdlS+OiN63aHO3T9D7dtUqoK4t0Gq1G9wsFZ7g5sriKqFpVp/nPeqeN+VPrJb3/O
 BIgw==
X-Gm-Message-State: ABy/qLbTXz9r3pE7vA588fWWn2P+UNoPyvsf+VzkQAAhvOMHn8yqBpog
 hjCdjfPLK1zcCG33k2SrnuN9lGiszYr/lW/h8jp07mpyKjooq+BQX5Vdl6g0kAJX1BuP0RN2Gtd
 H389igKgkoKsRg9E=
X-Received: by 2002:a17:902:a518:b0:1b8:9958:e14b with SMTP id
 s24-20020a170902a51800b001b89958e14bmr2935573plq.10.1688449188632; 
 Mon, 03 Jul 2023 22:39:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH4MUoqv1vRnwy4qcHt4/H/DzoWQw6aVTHc/VBR7E6fl9v/9aWcijraeQTKQU+uYf8UYOf9xw==
X-Received: by 2002:a17:902:a518:b0:1b8:9958:e14b with SMTP id
 s24-20020a170902a51800b001b89958e14bmr2935568plq.10.1688449188368; 
 Mon, 03 Jul 2023 22:39:48 -0700 (PDT)
Received: from smtpclient.apple ([115.96.131.170])
 by smtp.gmail.com with ESMTPSA id
 im16-20020a170902bb1000b001b564563f32sm5129940plb.186.2023.07.03.22.39.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Jul 2023 22:39:47 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <d6368f95-3adf-9d49-82b4-a138a32010a4@daynix.com>
Date: Tue, 4 Jul 2023 11:09:43 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D23A8D44-FA51-44C7-8AE3-65B10CDB0976@redhat.com>
References: <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
 <20230630043734-mutt-send-email-mst@kernel.org>
 <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
 <20230630055717-mutt-send-email-mst@kernel.org>
 <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
 <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
 <bf351f8b-1c8a-8a7a-7f44-17c9ba18f179@daynix.com>
 <DFB3B0B7-1F61-4779-9833-2AF1BA3BDFA6@redhat.com>
 <2ffee496-ec63-ad04-a90b-8c2fadbf3657@daynix.com>
 <20230702005916-mutt-send-email-mst@kernel.org>
 <63B46F8F-A52C-4BFC-BAFD-06ACAF2AA6E1@redhat.com>
 <d6368f95-3adf-9d49-82b4-a138a32010a4@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 04-Jul-2023, at 10:31 AM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> On 2023/07/03 15:08, Ani Sinha wrote:
>>> On 02-Jul-2023, at 10:29 AM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>=20
>>> On Sat, Jul 01, 2023 at 04:09:31PM +0900, Akihiko Odaki wrote:
>>>> Yes, I want the slot number restriction to be enforced. If it =
worries you
>>>> too much for regressions, you may implement it as a warning first =
and then
>>>> turn it a hard error when the next development phase starts.
>>>=20
>>> That's not a bad idea.
>> If we had not enforced the check strongly, the tests that we fixed =
would not get noticed.
>=20
> Perhaps so, but we don't have much time before feature freeze. I =
rather want to see the check implemented as warning in 8.1 instead of =
delaying the initial implementation of the check after 8.1 (though I =
worry if it's already too late for 8.1.)

The feature hard freeze window starts from 12th of next week. So I am =
still debating whether to keep the hard check or just have a warning. If =
the hard check causes regressions, we can always revert it to a warning =
later.=


