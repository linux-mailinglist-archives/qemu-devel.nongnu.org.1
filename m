Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AF7741044
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:45:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETbf-00026t-3V; Wed, 28 Jun 2023 07:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qETba-00026U-2R
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qETbX-0004MH-JV
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687952698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzJQZgFjm3/PNyCBd1CFNlRzMh8oOLMQ4BRnr0y+RDs=;
 b=El0qr4bqH7OuuL+ZDsXyfLlm3+oRcRPKd3hLeUVU2PPdwM3FNGYESJMVoKavjXbarbPkKY
 Se+WZrhLp9+v5oVIIgN2+ZWSU0iGpqkDoTjLToc7oovh/0dxxIM9/g22+D4RkpZgHY4MZG
 YV5RFo8PW4oFjJIHCCfeJ3DyIKmeZ0g=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-FgKu8ZWaMiiSuRUHzd312Q-1; Wed, 28 Jun 2023 07:44:57 -0400
X-MC-Unique: FgKu8ZWaMiiSuRUHzd312Q-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-66700a28586so2620834b3a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 04:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687952696; x=1690544696;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fzJQZgFjm3/PNyCBd1CFNlRzMh8oOLMQ4BRnr0y+RDs=;
 b=BoLMpxX2mAC/GRayp62PVxWrSO6P4/I/7giH9yjsMZ2v439bpJQdLpAfLCOeL50iTk
 6KxDDrVljLQvsBqMSVVQMskRl4D9a7fI3ovKMahfROsIgsdqV+S9qT3V52rz1O6C9Uz/
 RaqKtrDdY7NLSg1eQPz+51fK/Jkf517Dxq9GB5yQ9mms2hc1rX20i0oxBPy905T385Py
 T9jrSk9pvAlkBO3/dOHMgX5r/mXv/7XO7KSaHP65XPJYMn+8KlMV5+S9clVl6PM0pkpp
 g2Qen+cd/Lqa0D9OK1MJ8iXZXlTgp2PiCZXNfeMmpBodjBpnJ1ZMAJoaJsKzSUtLb/81
 nMkg==
X-Gm-Message-State: AC+VfDwD4xdH2Z0F9Vbq8xDv09WPDtWWDLTMWq+DSn57mUc4zudpC4k8
 OIDfreukXDY9zC2sBJZtY06QnVV3SprAI6lYp9oRSC3CnnNLm1Ve5/vpQ4spWI2FXQqVDJ0L6mq
 zM09uAyCDFW2T7wk=
X-Received: by 2002:a05:6a00:14c5:b0:66a:4e26:5466 with SMTP id
 w5-20020a056a0014c500b0066a4e265466mr17961139pfu.6.1687952696115; 
 Wed, 28 Jun 2023 04:44:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49uejIidKmGUeJ+QkbUrpNmYjpE8GsIvEg7lt8XgwRhg8pzJQgt9jmRU2i98FMlLBGNloxxA==
X-Received: by 2002:a05:6a00:14c5:b0:66a:4e26:5466 with SMTP id
 w5-20020a056a0014c500b0066a4e265466mr17961118pfu.6.1687952695740; 
 Wed, 28 Jun 2023 04:44:55 -0700 (PDT)
Received: from smtpclient.apple ([115.96.122.163])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a62b409000000b00658670ebe7dsm6893864pfn.119.2023.06.28.04.44.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Jun 2023 04:44:55 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] net/vhost-net: do not assert on null pointer return from
 tap_get_vhost_net()
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230628074144-mutt-send-email-mst@kernel.org>
Date: Wed, 28 Jun 2023 17:14:51 +0530
Cc: Jason Wang <jasowang@redhat.com>, peter.maydell@linaro.org,
 lvivier@redhat.com, clg@redhat.com, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <39CDD356-542F-4CBF-B72F-8D96395CF1D7@redhat.com>
References: <20230628112804.36676-1-anisinha@redhat.com>
 <20230628074144-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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



> On 28-Jun-2023, at 5:12 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Wed, Jun 28, 2023 at 04:58:04PM +0530, Ani Sinha wrote:
>> When 'vhost=3Doff' or no vhost specific options at all are passed for =
the tap
>> net-device backend, tap_get_vhost_net() can return NULL. The function
>> net_init_tap_one() does not call vhost_net_init() on such cases and =
therefore
>> vhost_net pointer within the tap device state structure remains NULL. =
Hence,
>> assertion here on a NULL pointer return from tap_get_vhost_net() =
would not be
>> correct. Remove it and fix the crash generated by qemu upon =
initialization in
>> the following call chain :
>>=20
>> qdev_realize() -> pci_qdev_realize() -> virtio_device_realize() ->
>> virtio_bus_device_plugged() -> virtio_net_get_features() -> =
get_vhost_net()
>>=20
>> fixes: 0e994668d00c9c ("vhost_net: add an assertion for TAP client =
backends")
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>=20
> I added a bunch of tags and sent it upstream. Take a look
> at the pull request so you can do it yourself going
> forward, pls.

I thought only maintainers sends PR? Do you have any handy scripts?

>=20
>> ---
>> hw/net/vhost_net.c | 7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>> index 6db23ca323..6b958d6363 100644
>> --- a/hw/net/vhost_net.c
>> +++ b/hw/net/vhost_net.c
>> @@ -507,7 +507,12 @@ VHostNetState *get_vhost_net(NetClientState *nc)
>>     switch (nc->info->type) {
>>     case NET_CLIENT_DRIVER_TAP:
>>         vhost_net =3D tap_get_vhost_net(nc);
>> -        assert(vhost_net);
>> +        /*
>> +         * tap_get_vhost_net() can return NULL if a tap net-device =
backend is
>> +         * created with 'vhost=3Doff' option, 'vhostforce=3Doff' or =
no vhost or
>> +         * vhostforce or vhostfd options at all. Please see =
net_init_tap_one().
>> +         * Hence, we omit the assertion here.
>> +         */
>>         break;
>> #ifdef CONFIG_VHOST_NET_USER
>>     case NET_CLIENT_DRIVER_VHOST_USER:
>> --=20
>> 2.39.1
>=20


