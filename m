Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7127411AB
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:50:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEUcl-0005aM-3a; Wed, 28 Jun 2023 08:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEUcc-0005Yt-4k
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEUcZ-0006In-Dm
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687956604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLbYQtYdsgVe7cRloOm8aCR/sl7QmDxHY+9JfRzEhb8=;
 b=gHscT68L7rKt+U5oTdi2Lf0pGxG4ux55pBBv4md46HSDNMDUO4R65XQjlVrRggmfNr2vxo
 z1Zml36SATU+5hGu5a+P/sUD8XbUOj5FCXTya61apRMkG9m9N7wkOxHRiF8huTbFEWGfio
 qGQnUp8WhwmtzlNh4feavgUgKyEPxSM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-t9tH72FZN3CNSKb5_QQ80g-1; Wed, 28 Jun 2023 08:50:03 -0400
X-MC-Unique: t9tH72FZN3CNSKb5_QQ80g-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-666e7b83930so2752248b3a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 05:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687956601; x=1690548601;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MLbYQtYdsgVe7cRloOm8aCR/sl7QmDxHY+9JfRzEhb8=;
 b=AoJVz0uU//0694skojpPNcdoyHJ4ruOUkgvVQ1vg5PLhxQKQ7Q6UdfhfU5KX+G0xOA
 mmP3z5bStvEYdN1WdxryZb2VuMZFx7OEXna6xncSx2uakhA4SV2l5SBBOlvMiTRxpuMl
 P5iq3cwUibwbXgM5TjGeIprYeqfdqhfxw3m2Wpa9wBVlGpUBpIms3RDqcTgcJoC5BjA/
 UgDDMGZWtqTSfzj3RwR3Yech4QVvMyBdql5bgfpmz5hbPhJPTX5mTeWQKoB97u7K6+uo
 Lo9IW+CicBYcfXxXVryTPOUueRGQYINvf6sqTUPzt9KOSC/mwfFjGBr/6s35lbhT+w2L
 BNbQ==
X-Gm-Message-State: AC+VfDxJpnwz7fPrHe0Hygfir5JzGoRnwNKGuD2FM+uuynjudT5fwy8n
 T8bGUKejtK2IWIJX2AhdOtrMVrGS0DIFDMu2hfDglhFzVzEAFpPJJfYEC3hUZivgIa6IQODoFEJ
 /PcdwTB/4RiJ6Pik=
X-Received: by 2002:a05:6a20:8e0c:b0:122:ff52:7331 with SMTP id
 y12-20020a056a208e0c00b00122ff527331mr20892183pzj.52.1687956601549; 
 Wed, 28 Jun 2023 05:50:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ41KwryvHcjuKxEMLzfRiqSfMhJYNIzLpfZ8+o4v36XuKgzyXJ46Y134u7dpRj6eiSfJA7ImA==
X-Received: by 2002:a05:6a20:8e0c:b0:122:ff52:7331 with SMTP id
 y12-20020a056a208e0c00b00122ff527331mr20892162pzj.52.1687956601207; 
 Wed, 28 Jun 2023 05:50:01 -0700 (PDT)
Received: from smtpclient.apple ([115.96.122.163])
 by smtp.gmail.com with ESMTPSA id
 d17-20020a170902b71100b001b034faf49csm7622904pls.285.2023.06.28.05.49.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Jun 2023 05:50:00 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: ARI and igb emulation
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <0cd0195d-cbc2-4727-4a54-6acf743303eb@daynix.com>
Date: Wed, 28 Jun 2023 18:19:56 +0530
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Lei Yang <leiyang@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E460631-2E82-46CA-AA3B-C31E99396661@redhat.com>
References: <ACCE3C63-50B6-4310-9DF6-F1BE759F5B1E@redhat.com>
 <1865ce6f-842c-d5dd-b43f-c2f36710c791@daynix.com>
 <0cd0195d-cbc2-4727-4a54-6acf743303eb@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
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



> On 28-Jun-2023, at 6:15 PM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> Adding CC.
>=20
> On 2023/06/28 21:24, Akihiko Odaki wrote:
>> On 2023/06/27 23:32, Ani Sinha wrote:
>>> Hi :
>>> I am proposing a patch in QEMU [1] which may or may not break ARI =
but I wanted to give my best shot in making sure I am not breaking =
anything with ARI enabled. I see that your igb emulation code enables =
ARI with its SRIOV emulation. I ran the qtest and avocado tests that are =
mentioned in [2] and they both pass. Is there anything else/any tweaks =
that I should be doing to make sure I am not breaking ARI with igb?
>>>=20
>>> Thanks for information,
>>> Ani
>>>=20
>>> 1. =
https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg05478.html
>>> 2. https://www.qemu.org/docs/master/system/devices/igb.html
>>>=20
>>>=20
>> This indeed resulted in the following error message with igb:
>> qemu-system-aarch64: PCI: slot 16 is not valid for igbvf, parent =
device only allows plugging into slot 0.
>> To reproduce the issue, add the following to QEMU command line:
>> -device pcie-root-port,id=3Dp -device igb,bus=3Dp
>> And enable 7 virtual functions on the guest. For Linux, see:
>> https://docs.kernel.org/PCI/pci-iov-howto.html
>> You may only enforce the slot number restriction only for devices =
without ARI. The slot number is assumed as 0 when ARI is enabled if I =
understand correctly.

So I guess mst was correct as to the reason why the previous conditional =
checks for !vf :-) Very interesting!=


