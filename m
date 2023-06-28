Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 875C874099D
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:12:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPKX-0002iQ-4k; Wed, 28 Jun 2023 03:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEPKR-0002iE-6h
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:11:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEPKN-00054Q-R5
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687936256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zbJ89e2wuqUPvfFVfAmSWxLmdGi3kAf8klNpcTmfdVA=;
 b=NPg5n/CwUW4g6WSA9pudR2H+39lAjdnR+elEfdd7gY+mymJQdqO8096C6j4N+ZWQ4Aknal
 cDURe+8yg7QW0dJ9dlWUpywIXlcwzhaBmc+zi4rc6IDGbNnnC4Wrblj7tJsnSAgRRdvp6U
 9uHmGmMvcWVhjakhZEkBXq0omoYiruM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-TA2srZTFOPyLdr5QsLqlmg-1; Wed, 28 Jun 2023 03:10:54 -0400
X-MC-Unique: TA2srZTFOPyLdr5QsLqlmg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-26337f5d2daso559255a91.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687936253; x=1690528253;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zbJ89e2wuqUPvfFVfAmSWxLmdGi3kAf8klNpcTmfdVA=;
 b=h0Q/baeZUq87yZWiYTKMnRHUTb+SP0Jt655R7J71fgnNhU2Ez+sU9e4yCxyTuAM4ME
 mOiXZwMiOJspwOVoOCmoxdXobWYT2Fvp53TY5aZ41N6eBv6Zw9JavvJVe8cN7lP1llzJ
 tCw+5+XYuqdK/UeCJ6jPUDzzyRV64TVvS8lB4GWSowgJgBvO/bXzHpsjRetPKvn6aKg2
 Zmlwk7UqOKS0zN/W3zaGnjw61QwAKtkabcLU7hrgYOaQqa7Zm7AivlLfZFqZd4CR8RVB
 eONCxD6XhjjJ9qGxrexYlA31rdwj4sfM3FEdgGqPE9ITVvpTW+vJ5kV6LYyKc4kpFroG
 isGw==
X-Gm-Message-State: AC+VfDz3rLsQlGBAi2fDnoyo04kekwID+dXjWeqTCedGd1xj+YwEqEnt
 o2PGm6OEBBex2s6zeQmcJ8EFNFMyMAMFrQtgtGbbEUL+g60EOROBiezE3H76SeTO5TW/JVDixzX
 W/JsmzL0JrLbe3fU=
X-Received: by 2002:a17:90b:4c46:b0:250:132a:5d93 with SMTP id
 np6-20020a17090b4c4600b00250132a5d93mr28531225pjb.49.1687936253751; 
 Wed, 28 Jun 2023 00:10:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ62O+z0Cvo0ufeob+R7qVvM0yVkA665qBBifR9it0aRzSymEDT2CrRMzfPS+LkPvvs7G50l7g==
X-Received: by 2002:a17:90b:4c46:b0:250:132a:5d93 with SMTP id
 np6-20020a17090b4c4600b00250132a5d93mr28531215pjb.49.1687936253443; 
 Wed, 28 Jun 2023 00:10:53 -0700 (PDT)
Received: from smtpclient.apple ([115.96.122.163])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a17090abd1100b0026309d57724sm3005365pjr.39.2023.06.28.00.10.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Jun 2023 00:10:53 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: ARI and igb emulation
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CACGkMEtv1w+D_SoiEDK8YnFQ23QFAPOr9bjHji_uhnZF9sLSQw@mail.gmail.com>
Date: Wed, 28 Jun 2023 12:40:49 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, akihiko.odaki@daynix.com,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E10303DB-04AE-41AD-A721-6BB96760EE47@redhat.com>
References: <ACCE3C63-50B6-4310-9DF6-F1BE759F5B1E@redhat.com>
 <20230627103454-mutt-send-email-mst@kernel.org>
 <25A57CF2-5027-48B7-A879-8DE8BDEF60B3@redhat.com>
 <CACGkMEtjPqWYcF_bPoSu9AjrYJFVsXMh+q4ADtdz5HMG64dVcg@mail.gmail.com>
 <E0FEFB1B-2282-4040-92AC-BDB46D65EA07@redhat.com>
 <CACGkMEtv1w+D_SoiEDK8YnFQ23QFAPOr9bjHji_uhnZF9sLSQw@mail.gmail.com>
To: Jason Wang <jasowang@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 28-Jun-2023, at 12:36 PM, Jason Wang <jasowang@redhat.com> wrote:
>=20
> On Wed, Jun 28, 2023 at 3:01=E2=80=AFPM Ani Sinha =
<anisinha@redhat.com> wrote:
>>=20
>>=20
>>=20
>>> On 28-Jun-2023, at 12:23 PM, Jason Wang <jasowang@redhat.com> wrote:
>>>=20
>>> On Tue, Jun 27, 2023 at 10:41=E2=80=AFPM Ani Sinha =
<anisinha@redhat.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On 27-Jun-2023, at 8:09 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>>=20
>>>>> On Tue, Jun 27, 2023 at 08:02:46PM +0530, Ani Sinha wrote:
>>>>>> Hi :
>>>>>> I am proposing a patch in QEMU [1] which may or may not break ARI =
but I wanted to give my best shot in making sure I am not breaking =
anything with ARI enabled. I see that your igb emulation code enables =
ARI with its SRIOV emulation. I ran the qtest and avocado tests that are =
mentioned in [2] and they both pass. Is there anything else/any tweaks =
that I should be doing to make sure I am not breaking ARI with igb?
>>>>>>=20
>>>>>> Thanks for information,
>>>>>> Ani
>>>>>>=20
>>>>>> 1. =
https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg05478.html
>>>>>> 2. https://www.qemu.org/docs/master/system/devices/igb.html
>>>>>>=20
>>>>>=20
>>>>> I think that just creates igb. to test ARI you need to add
>>>>> igbvf devices. Jason maintains it. But really pls go back on-list.
>>>>=20
>>>> +Jason
>>>> +qemu-devel
>>>>=20
>>>=20
>>> Yes, you need to at least create VFS and test some throughput on it
>>> (probably need a vIOMMU).
>>=20
>> Is there a test that I can run?
>>=20
>=20
> A simple netperf/iperf should be sufficient.

I meant a full test script that uses igb emulation with vfs etc. I =
really do not have time to set this whole thing up manually. Maybe =
something was used to test sriov and igb emulation while development and =
a test might have been committed in QEMU.


