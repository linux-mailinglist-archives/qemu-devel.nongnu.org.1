Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 715A874E5F9
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 06:38:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ57F-0002ft-Si; Tue, 11 Jul 2023 00:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qJ57C-0002ff-Oi
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 00:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qJ57B-00050z-4G
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 00:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689050199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fNXxo64dBVxZ5SP01zwYeEI6vwhm8JsvsZbQ2GTUJ0Q=;
 b=f4hFmOP7e2TkUv1zsypw/YGqJsMP4501PhQv0OLLvoBo3mwihYt5/shOA24bBNU553VXF0
 tl6HlAojRPHCx4IUJV0NXacJY+CEIOJ38KzhiAWkTvakpJbc29DXfNbfQj8KjmJNRIjoHx
 Lmj2THk+pIhQynF9qsz0vNwH/EhysMw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-nwX-OvujNuarJpE66bYIcQ-1; Tue, 11 Jul 2023 00:36:38 -0400
X-MC-Unique: nwX-OvujNuarJpE66bYIcQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-26337f5d2daso8550787a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 21:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689050197; x=1691642197;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNXxo64dBVxZ5SP01zwYeEI6vwhm8JsvsZbQ2GTUJ0Q=;
 b=ZGv4QrNNjog7gme2P3DMBuqTKEz5ELU5B/tTQICjbX16pq6/mH3jrGWM+jg3ELT4Wn
 6i6wzYY51eGOYoTcmaJSNr92i46xKozGwg8+evt5C43weIsGdC5ONi5d4nqNuij5HDFO
 P8OqgZJu+AysNqAg22oqBmVEQlvgVerh9j2JyKsoVE7nfEKsC/m/szfJNL9jSN/+XCsO
 F8qUtHJheFvAmawYknreJph0X/LBfqDLyQ0fKjdCi2q/8o0adnYm06b6npTpuf7J3meO
 SS/XW5EN3ULH5IhrQTqWUfMhj7AXAE+JHfS6nGS6dSaUBDuWWXQOKbBP81KsARL/EGIp
 QGSQ==
X-Gm-Message-State: ABy/qLZpB1kfTHKY36dXiLGpXX/bOYcMrnNwAy1qC6IeL3XWhE1le2Ws
 nvEMVwyO0CCjOMRoJwvhckDrkHkUBM48GzN10Xp/vjYM1LS3N/iu/Cm2GzuybuqEqzCfMLGXcPB
 aLUS9R4RKcth77gE=
X-Received: by 2002:a17:90b:1647:b0:262:f039:f69b with SMTP id
 il7-20020a17090b164700b00262f039f69bmr15219334pjb.23.1689050197533; 
 Mon, 10 Jul 2023 21:36:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlElzpqDL3lAkhrREJXAWt3KvrLkaZdZkapaqVB1xAAzLMri1cxDAR7dHk4aYy6SFmMTm7l4Lw==
X-Received: by 2002:a17:90b:1647:b0:262:f039:f69b with SMTP id
 il7-20020a17090b164700b00262f039f69bmr15219318pjb.23.1689050197172; 
 Mon, 10 Jul 2023 21:36:37 -0700 (PDT)
Received: from smtpclient.apple ([116.73.134.124])
 by smtp.gmail.com with ESMTPSA id
 gx11-20020a17090b124b00b00263154aab24sm715060pjb.57.2023.07.10.21.36.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jul 2023 21:36:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v8 6/6] hw/pci: add comment explaining the reason for
 checking function 0 in hotplug
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <d616ff70-c975-674e-2501-9702655e6de5@tls.msk.ru>
Date: Tue, 11 Jul 2023 10:06:33 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6BB5171-09DA-4529-ABC0-2396164652D6@redhat.com>
References: <20230705115925.5339-1-anisinha@redhat.com>
 <20230705115925.5339-7-anisinha@redhat.com>
 <F99D12E7-135A-4A03-8B9D-1FF384FBCA5A@redhat.com>
 <20230710154155-mutt-send-email-mst@kernel.org>
 <878CC014-DC18-43CC-83D8-B2524EE09373@redhat.com>
 <9b2935a1-af38-3373-6441-c0179df0cbfb@tls.msk.ru>
 <F8856123-70CC-44FF-9E7A-E7E27DD07944@redhat.com>
 <d616ff70-c975-674e-2501-9702655e6de5@tls.msk.ru>
To: Michael Tokarev <mjt@tls.msk.ru>
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



> On 11-Jul-2023, at 9:43 AM, Michael Tokarev <mjt@tls.msk.ru> wrote:
>=20
> 11.07.2023 07:03, Ani Sinha wrote:
>>> On 11-Jul-2023, at 9:21 AM, Michael Tokarev <mjt@tls.msk.ru> wrote:
>>>=20
>>> 11.07.2023 06:46, Ani Sinha wrote:
>>>=20
>>>> Sure. Since this is only a comment addition, should I also CC =
qemu-trivial?
>>>=20
>>> A comment change does not mean the change is trivial.  It's a =
trivial in a sense
>>> the code changes are trivial (actually not-existent), but the =
meaning of the comment
>>> is not trivial at all. I for one know nothing about this.
>> This comment was already discussed in qemu-devel between me, mst and =
Igor. Perhaps you missed it.
>=20
> It doesn't matter really. The thing is that it needs explanation, =
hence it is not "trivial",
> that's what I tried to say. It is trivial for sure for someone who =
knows this particular
> subsystem well enough, - I'm not one of them ;)

That=E2=80=99s ok. I was commenting on your statement " I for one know =
nothing about this.=E2=80=9D  I wanted to make sure that people know =
that patches (at least those I post) are going though the qemu-devel =
list in a transparent way. It's up to those who are interested or have =
expertise in a certain area to monitor the list and review/comment on =
patches. If they want to be explicitly CC=E2=80=99d they can add =
themselves to MAINTAINERS. The tooling would ensure that they are added =
in the CC when certain files are updated or modified in the patches.=


