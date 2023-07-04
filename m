Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3961746F73
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 13:12:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGdvB-00089E-Qu; Tue, 04 Jul 2023 07:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGdv9-00088g-HC
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGdv7-0006j4-Mz
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688469008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6qs8UEJGu8i2UMdHjt2RGhdUiW9bC5Hd+ARjr123cA=;
 b=A7qZA/hznLy7wXFdyMpFznWttCO1wbxQAf3NRGAVjLjwaPsCXcVgopoiuqvEqB0eVke7jX
 jiPXOl/XPtPAda317TZzWlw4EERxldZXsfKOsxdj8FTQpmRjZzbQQGk2Ii6EVUNwXmwXCG
 VJBumoixJEyhaDsMpPYAVvWiacYoftE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-LNNDbrgKOXiXYAv0bYTpSA-1; Tue, 04 Jul 2023 07:10:07 -0400
X-MC-Unique: LNNDbrgKOXiXYAv0bYTpSA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-666e3dad70aso7351998b3a.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 04:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688469006; x=1691061006;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n6qs8UEJGu8i2UMdHjt2RGhdUiW9bC5Hd+ARjr123cA=;
 b=Vwbq4IWY0+HI6gxu4TPXS5tYOuGx5UXpdGs5zvgRVD0KPwlS+VWFcaMizA+rI1BlnQ
 RJNIMA46FcI3d0UwKJfjKz9GwOQo9JrX91rYArm/HEKlPJbrUTF+qh2D10FuVWCJEvLf
 DkJAUnNTKGQvhemEyW6RPluJLIZ8jeiXNIhAZkYOsatwzMGDHbxwlly92zptE8XPrT4N
 4sH2GtRefAk+ZU3oqcwe8DjIfHYhuwJpJOmIoiABRLZZQHqPvpE8OCVXWzWmp+5lez9J
 UMBalqaywR7T0xnMH4N+kpc270B/6BqtGPnZjV+GlJ/zHIFYCYqNNxuqLw0nIgW9iCNf
 2tDg==
X-Gm-Message-State: ABy/qLa+hkmirkuKHRqSxJoVWdQVy0aBJ421pqyHS0Nh8fx5lmDGIF4e
 5cgdUOPPtoeB9o8ErMmW+C+0PMkPjrhaD/QddACC8cdnoaDj8T0JtXUxH+rwDzaFBq7iXz76Wui
 WBhsINXdKeRCWCx8=
X-Received: by 2002:a05:6a00:1591:b0:668:7b5b:c1aa with SMTP id
 u17-20020a056a00159100b006687b5bc1aamr18260811pfk.20.1688469006146; 
 Tue, 04 Jul 2023 04:10:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF2KRj+XdwgbBJFWZM4ASoYEHtAV7vx8p9vmzdAN8TSIkIMHocjthQZxkeo4zJamQkx2ZiYmA==
X-Received: by 2002:a05:6a00:1591:b0:668:7b5b:c1aa with SMTP id
 u17-20020a056a00159100b006687b5bc1aamr18260790pfk.20.1688469005797; 
 Tue, 04 Jul 2023 04:10:05 -0700 (PDT)
Received: from smtpclient.apple ([115.96.131.170])
 by smtp.gmail.com with ESMTPSA id
 21-20020aa79255000000b0065379c6d549sm15410411pfp.215.2023.07.04.04.10.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Jul 2023 04:10:05 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230704063545-mutt-send-email-mst@kernel.org>
Date: Tue, 4 Jul 2023 16:40:00 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7E7D174-BFD8-4468-A33A-DCED051D5145@redhat.com>
References: <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
 <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
 <bf351f8b-1c8a-8a7a-7f44-17c9ba18f179@daynix.com>
 <DFB3B0B7-1F61-4779-9833-2AF1BA3BDFA6@redhat.com>
 <2ffee496-ec63-ad04-a90b-8c2fadbf3657@daynix.com>
 <20230702005916-mutt-send-email-mst@kernel.org>
 <63B46F8F-A52C-4BFC-BAFD-06ACAF2AA6E1@redhat.com>
 <d6368f95-3adf-9d49-82b4-a138a32010a4@daynix.com>
 <D23A8D44-FA51-44C7-8AE3-65B10CDB0976@redhat.com>
 <DC9C1732-B33B-4A09-8CB4-6B02F422DD02@redhat.com>
 <20230704063545-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
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



> On 04-Jul-2023, at 4:06 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Jul 04, 2023 at 04:03:54PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 04-Jul-2023, at 11:09 AM, Ani Sinha <anisinha@redhat.com> wrote:
>>>=20
>>>=20
>>>=20
>>>> On 04-Jul-2023, at 10:31 AM, Akihiko Odaki =
<akihiko.odaki@daynix.com> wrote:
>>>>=20
>>>> On 2023/07/03 15:08, Ani Sinha wrote:
>>>>>> On 02-Jul-2023, at 10:29 AM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>>>=20
>>>>>> On Sat, Jul 01, 2023 at 04:09:31PM +0900, Akihiko Odaki wrote:
>>>>>>> Yes, I want the slot number restriction to be enforced. If it =
worries you
>>>>>>> too much for regressions, you may implement it as a warning =
first and then
>>>>>>> turn it a hard error when the next development phase starts.
>>>>>>=20
>>>>>> That's not a bad idea.
>>>>> If we had not enforced the check strongly, the tests that we fixed =
would not get noticed.
>>>>=20
>>>> Perhaps so, but we don't have much time before feature freeze. I =
rather want to see the check implemented as warning in 8.1 instead of =
delaying the initial implementation of the check after 8.1 (though I =
worry if it's already too late for 8.1.)
>>>=20
>>> The feature hard freeze window starts from 12th of next week. So I =
am still debating whether to keep the hard check or just have a warning. =
If the hard check causes regressions, we can always revert it to a =
warning later.
>>=20
>> mst?
>=20
> I'd go for a warning now. Let's see what triggers for users without
> actually breaking things too badly for them.

=F0=9F=A4=A6=F0=9F=8F=BB=


