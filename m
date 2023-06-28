Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB4F740985
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 08:45:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEOvR-0001hC-4W; Wed, 28 Jun 2023 02:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEOvO-0001gx-Em
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEOvM-0000Xu-Ld
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687934707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ak6Uf6OtMwjY/tTOtgkZlKzUZDmtZt7TpBE5FVkSZA=;
 b=QBXugR2ocrHnFGJdv+K8M3PSosg3cf/qrNsPQL//FNzZJi13m3OtX5oyU6RMRqiyVoyfPz
 BLyX7rV41fph5lrxkhaaFXRhin19iswdgu62rqD5g5NbPQGVZ70rUgZfVcL1ZWYMc1EDhv
 mSt+CjuwZxmwW6e0dnL7+dsImGcMd9Q=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-EaUJUdhmNHa9qQWraf_HZA-1; Wed, 28 Jun 2023 02:45:06 -0400
X-MC-Unique: EaUJUdhmNHa9qQWraf_HZA-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1b81ec07321so9052085ad.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 23:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687934705; x=1690526705;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ak6Uf6OtMwjY/tTOtgkZlKzUZDmtZt7TpBE5FVkSZA=;
 b=NM48TRJeYOjJfG7rETxSc5tsZS58Gj+nf26hZhbZ5JUTLWi4o3hiRCjN9Pxkbstva1
 b20SWDhBN30EMlIv/XOR9cZHz88LF4jxsz5CIkxtdRHhyEn6y1lHMMwAd8/cnO5q44i8
 nQSyuAb7UeTQt0lz7SW25fWXehjXVp0bAq93ygmZ5HWFKdS508KARu/W8P2bDZGPhIj1
 kGM7MA+84MXIw1dm7Y0836steRspicCNfMUgSITpS9pQ+/LwsZ//oingYeWDP+XSTGWu
 Fa94sJFKtnvBgeHhYLul3Lfat+YqXyTVgS/HTQrjVIVMbrVmeyVFP4dp1uhwEUl14WWU
 B/7g==
X-Gm-Message-State: AC+VfDwnqm/yjitkyubJ8g2xw9VW1rmfTpt0CvF+Hk5KyVjTjtU8q4EF
 C8Jf/aWzfTe7z80hYT8VnKr+Uy4jSI750W+FZSO0q+MqnEHxo3pcRgrk9zyGhMwJLZc7IxM9Sdl
 cAOWHAiyXl4yTCUM=
X-Received: by 2002:a17:902:e744:b0:1b5:edd:e3c7 with SMTP id
 p4-20020a170902e74400b001b50edde3c7mr11170466plf.16.1687934705058; 
 Tue, 27 Jun 2023 23:45:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7XDBvjqgAT89vFu56iNFfgqat/77cUZ5cCZxVcSa9OrYy/3h7vUYmAllXEH4/EMfmRV3SFiA==
X-Received: by 2002:a17:902:e744:b0:1b5:edd:e3c7 with SMTP id
 p4-20020a170902e74400b001b50edde3c7mr11170455plf.16.1687934704766; 
 Tue, 27 Jun 2023 23:45:04 -0700 (PDT)
Received: from smtpclient.apple ([115.96.122.163])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a170902934600b001a65fa33e62sm6915815plp.154.2023.06.27.23.45.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Jun 2023 23:45:04 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PULL 52/53] vhost_net: add an assertion for TAP client backends
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <abab7a71-216d-b103-fa47-70bdf9dc0080@redhat.com>
Date: Wed, 28 Jun 2023 12:15:00 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A0C56F97-3830-4DF3-8BDD-D49611418056@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
 <0af710813dcde638379e3bece8f9b1bde31af2f6.1687782442.git.mst@redhat.com>
 <abab7a71-216d-b103-fa47-70bdf9dc0080@redhat.com>
To: =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
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



> On 28-Jun-2023, at 11:58 AM, C=C3=A9dric Le Goater <clg@redhat.com> =
wrote:
>=20
> Hello,
>=20
> On 6/26/23 14:30, Michael S. Tsirkin wrote:
>> From: Ani Sinha <anisinha@redhat.com>
>> An assertion was missing for tap vhost backends that enforces a =
non-null
>> reference from get_vhost_net(). Both vhost-net-user and =
vhost-net-vdpa
>> enforces this. Enforce the same for tap. Unit tests pass with this =
change.
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> Message-Id: <20230619041501.111655-1-anisinha@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>  hw/net/vhost_net.c | 1 +
>>  1 file changed, 1 insertion(+)
>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>> index c4eecc6f36..6db23ca323 100644
>> --- a/hw/net/vhost_net.c
>> +++ b/hw/net/vhost_net.c
>> @@ -507,6 +507,7 @@ VHostNetState *get_vhost_net(NetClientState *nc)
>>      switch (nc->info->type) {
>>      case NET_CLIENT_DRIVER_TAP:
>>          vhost_net =3D tap_get_vhost_net(nc);
>> +        assert(vhost_net);
>>          break;
>>  #ifdef CONFIG_VHOST_NET_USER
>>      case NET_CLIENT_DRIVER_VHOST_USER:
>=20
> A system of mine without vhost_net (old host kernel) is reaching this =
assert

We need to understand why this assertion is being hit. It could be a bug =
somewhere else.
What is the backtrace? What is the repro case?

> and works perfectly fine without. Should it be considered as a =
regression ?
>=20
> Thanks,
>=20
> C.
>=20


