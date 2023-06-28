Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A8C741450
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:54:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEWXL-0008Ax-IC; Wed, 28 Jun 2023 10:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEWXJ-0008An-QZ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEWXI-0005mg-0H
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687963967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SNCrF5j0nZRJHr0wwmZ6xgk8m0HIA4JgPFpXcOacCc=;
 b=FkcI+u6ie/C3NNx3KOXCqg8K+ID3Tm4ecpNASpW3RuEy3ufK+S/Dt3r6n+TD9sEJCxzM1T
 S2NxdCrVcXxcLpiqKemoh01+SK+aWHLtIvO/NWP63VCdfDlR65Xg3Ig3VftvBnvouupfxv
 CcIBqVBIRrg8GhQYQL/KYu+FqxKimco=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-tsbe6yE5OCWqshZBnm6CeQ-1; Wed, 28 Jun 2023 10:52:42 -0400
X-MC-Unique: tsbe6yE5OCWqshZBnm6CeQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3a034580b21so5607135b6e.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 07:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687963961; x=1690555961;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5SNCrF5j0nZRJHr0wwmZ6xgk8m0HIA4JgPFpXcOacCc=;
 b=kCKQZKhqiyK70t8P4993wZC+kl0kNvTr73jI39ExvUTda+pqeI0jO6Ju3aSUoabp4G
 kq0UeelO+4bQW5mDA2uM3wahw0mpi1/G1BrMPVzXOWXcHoAVrZGdLhr7qoKlIm2bUGBK
 X3+wIZW37J1svyknt2OEsSQlaR8+EWgip/gVCTN/nDaHlDrnEReUm6/yROv/XkuGy9Hw
 0PBp5BcDJzI1h6g9BwKudfHNqrWEM/OHEoeQHB6NH85NmCWfTCTyrSAioUiNrDAyiQa4
 lGI9VHgdtqJeoCimmZMwvlxWE0hJaRufUcrXzopN9fssEYpi8V3b8LtKSBEBh2g0zlYH
 OrQg==
X-Gm-Message-State: AC+VfDw7ekSSy0vkOkw6tIRwusLRpT4BUgyO/QwoBuIYfJcBVFOV4UT/
 muaudwmQbvxVHNekKA4ri1Dh9r4mHPUImISnd5avDdimpWjg4Q1NCaBZrXlWvsGwPKK/yOJ4yIW
 LNre4L/7/Sg/e6DU=
X-Received: by 2002:a05:6808:494:b0:3a1:f237:ec62 with SMTP id
 z20-20020a056808049400b003a1f237ec62mr5887837oid.48.1687963960876; 
 Wed, 28 Jun 2023 07:52:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+3ZF5EuQUs/L6SMtNhpN6VhXGSjvuKXjTHCtbrMurYFk0xNrcHkE/A0C47MqzGOtaZ98Meg==
X-Received: by 2002:a05:6808:494:b0:3a1:f237:ec62 with SMTP id
 z20-20020a056808049400b003a1f237ec62mr5887823oid.48.1687963960625; 
 Wed, 28 Jun 2023 07:52:40 -0700 (PDT)
Received: from smtpclient.apple ([115.96.122.163])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a17090a800100b002599ef80ab9sm9679579pjn.3.2023.06.28.07.52.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Jun 2023 07:52:40 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] net/vhost-net: do not assert on null pointer return from
 tap_get_vhost_net()
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <1b6f267c-5815-5da8-7e3d-c4c145c8b8c9@linaro.org>
Date: Wed, 28 Jun 2023 20:22:35 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F08DC244-CB93-4CEE-922F-3A1CF3986D7A@redhat.com>
References: <20230628112804.36676-1-anisinha@redhat.com>
 <20230628074144-mutt-send-email-mst@kernel.org>
 <39CDD356-542F-4CBF-B72F-8D96395CF1D7@redhat.com>
 <1b6f267c-5815-5da8-7e3d-c4c145c8b8c9@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
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



> On 28-Jun-2023, at 5:20 PM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 28/6/23 13:44, Ani Sinha wrote:
>>> On 28-Jun-2023, at 5:12 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>=20
>>> On Wed, Jun 28, 2023 at 04:58:04PM +0530, Ani Sinha wrote:
>>>> When 'vhost=3Doff' or no vhost specific options at all are passed =
for the tap
>>>> net-device backend, tap_get_vhost_net() can return NULL. The =
function
>>>> net_init_tap_one() does not call vhost_net_init() on such cases and =
therefore
>>>> vhost_net pointer within the tap device state structure remains =
NULL. Hence,
>>>> assertion here on a NULL pointer return from tap_get_vhost_net() =
would not be
>>>> correct. Remove it and fix the crash generated by qemu upon =
initialization in
>>>> the following call chain :
>>>>=20
>>>> qdev_realize() -> pci_qdev_realize() -> virtio_device_realize() ->
>>>> virtio_bus_device_plugged() -> virtio_net_get_features() -> =
get_vhost_net()
>>>>=20
>>>> fixes: 0e994668d00c9c ("vhost_net: add an assertion for TAP client =
backends")
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>=20
>>> I added a bunch of tags and sent it upstream. Take a look
>>> at the pull request so you can do it yourself going
>>> forward, pls.
>> I thought only maintainers sends PR? Do you have any handy scripts?
>=20
> =
https://github.com/stefanha/git-publish/blob/master/git-publish.pod#sendin=
g-pull-requests

Cool! Thanks Phil! Will check this and talk to Stefan.


