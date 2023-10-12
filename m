Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA91F7C75C8
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 20:22:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr0Is-0005Rg-Sv; Thu, 12 Oct 2023 14:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qr0Io-0005RK-Lq; Thu, 12 Oct 2023 14:20:55 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qr0Ii-0004fq-92; Thu, 12 Oct 2023 14:20:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:4c13:0:640:3c7:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 2FE3F61117;
 Thu, 12 Oct 2023 21:20:30 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a401::1:4] (unknown
 [2a02:6b8:b081:a401::1:4])
 by mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id SKk3Mq6OemI0-mwtRtytf; Thu, 12 Oct 2023 21:20:29 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697134829;
 bh=s668twSg3fgY9JIr0sW6RkjlVfs7+k7h2IO4fL1VR0M=;
 h=Subject:From:Cc:To:Date:Message-ID;
 b=mH0aafPI//9SdS/LMp3W3vDpTuu9lD6KOOdp1ac7hVhyG4ceC7XcN0c9YoW+q7kRy
 eKwxIoaKOrdhyGKZaMB4iRGAabEQfIVKYGYO2EFLcinlH6wvTbYrQwIp5jtjOX2c1e
 hV19tqIz3sXUZnNwAcKsJGDmSjgB/YVdM+ynA+30=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <06ea0a74-f10e-4625-bdf1-0caa805b2af7@yandex-team.ru>
Date: Thu, 12 Oct 2023 21:20:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 yc-core@yandex-team.ru, Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Denis Plotnikov <den-plotnikov@yandex-team.ru>, Kevin Wolf <kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: vhost-user question about VHOST_USER_F_PROTOCOL_FEATURES
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Hi all!

We now have a problem in downstream:

We have a vhost-user server, which doesn't support VHOST_USER_SET_VRING_ENABLE. As I understand, vhost-user specification allows it. So the server behaves as follows:

1. in GET_FEATURES, it sets VHOST_USER_F_PROTOCOL_FEATURES, to report support for protocol features.

2. if this flag VHOST_USER_F_PROTOCOL_FEATURES is set in SET_FEATURES, it reports an error

In my opinion, this doesn't violate the specification, maybe I'm wrong.

Newer QEMU, after commits

     02b61f38d357490 "hw/virtio: incorporate backend features in features"
     
     and
     
     4daa5054c599c8a
       "vhost: enable vrings in vhost_dev_start() for vhost-user devices"

actually doesn't support such behavior, as QEMU assumes that if we have the flag in GET_FEATURES, it is supported by SET_FEATURES.


I don't see any possibility to clearly support in QEMU both servers which supports vring enable/disable and older servers that doesn't.

=====

I also want to clarify,

1. is "feature negotiated" means set both in GET_FEATURES and SET_FEATURES, as this term is not directly defined.

2. What VHOST_USER_SET_VRING_ENABLE should do for vhost-user-blk? What meant by "side effects" in this case? All IO requests should just fail, not touching the actual storage?

3. Except for VHOST_USER_SET_VRING_ENABLE, there is another command require not just VHOST_USER_F_PROTOCOL_FEATURES being present in GET_FEATURES, but "negotiated" i.e., as I understand being then set in SET_OPTIONS by client. That's VHOST_USER_SET_SLAVE_REQ_FD. Why? Is it a mistake?

4. Also, in VHOST_USER_SET_FEATURES definition:

          Feature bit ``VHOST_USER_F_PROTOCOL_FEATURES`` signals
   back-end support for ``VHOST_USER_GET_PROTOCOL_FEATURES`` and
   ``VHOST_USER_SET_PROTOCOL_FEATURES``.


That seems wrong, as the flag in SET command is about vring enable/disable related behavior.

-- 
Best regards,
Vladimir

