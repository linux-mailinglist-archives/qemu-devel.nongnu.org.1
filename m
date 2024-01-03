Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 053C8822E2D
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 14:26:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL1Fj-0007md-95; Wed, 03 Jan 2024 08:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL1Ff-0007mU-Ei
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 08:25:43 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL1Fd-0004VS-NE
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 08:25:43 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33723ad790cso3897536f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 05:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704288340; x=1704893140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQoCe0v/UMTuth4yG+nDSukSgH2xh1V+h4uUaaOkPvg=;
 b=i7XViizmzH/c+gTwNg0ZYWdSTDpA9AbmNWtRzdhwRZcM0nDKLSvLFVf+MQkigUbMh0
 By9zyIpxyStZdXpCwlFGSMp1IXcQ4dc2FQtU1wemqRbkkKE/SvVJ2DxWngGhINoptPZ+
 NH6XNRqc7H6M+7+QvJ4eP8LByh25fU8778iJJE1p7PzC+2yj4a7eUtmDJUISuZPJr8Hg
 qJxAF4oBtB0fTl3xfj9AhgRu+8uIXOOMkOWpEOZ9joTb7erbkkBNy3aPCB9Nw9H2WGDl
 Hdvs7E6qslkDsJHrZTNsBsgr2BY50EnHOInszlokO9iZbc2Jwl9RzfYlfmmmW1m1aw55
 CjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704288340; x=1704893140;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iQoCe0v/UMTuth4yG+nDSukSgH2xh1V+h4uUaaOkPvg=;
 b=eG/ELrPC9O/6Txb6OUwgQ4x0X6OYgB4N9gdnxeJrofsXq8gQb1g5s9Rn4ELmWkQoGd
 37FHz+Ffo+8oDNRkHcUci/2aQLJ4GKE2Y2UgmBLikyoZBzEaSwaG1RJl78C5Lg95ev1p
 bMf5RSjlcfe1F7+rs+HH04tYH2YhGPUuAcRPOd9Tve/eltnOr+iMHZBVUaYS7uijWOwV
 1dnwHWr+kpFFzLazI9yb7WBVc2zGlw5dWF+MTbs2nt4Al9xZID7AvQIr4SiUpwnyF+tI
 jwukQB7bRflLfuis6NSe8im/DGS8htvP8UzpQyTWfxhaESHbwEYAoY10Y+6aZff+8a9q
 yo6Q==
X-Gm-Message-State: AOJu0YxcZ0f/oJ1kEJnxambcuF3NDJb5J28d6c3mADC/W9aXZhTtvvlY
 4njPA8v1WhkAe1wWyIwXlEG0yh52EyGAVA==
X-Google-Smtp-Source: AGHT+IGTz2lTleX3X5epZzTAQnJuMV+3ZlHKHhdIh1E/erkcLXw/I3DulAf1nN9ah8o2UduQgdsZ1A==
X-Received: by 2002:adf:f243:0:b0:336:6cbc:7940 with SMTP id
 b3-20020adff243000000b003366cbc7940mr5921781wrp.63.1704288339937; 
 Wed, 03 Jan 2024 05:25:39 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z5-20020adff1c5000000b003366e974cacsm30730996wro.73.2024.01.03.05.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 05:25:39 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0EC4E5F926;
 Wed,  3 Jan 2024 13:25:39 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  qemu-devel@nongnu.org,  Gerd
 Hoffmann <kraxel@redhat.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v3 0/4] virtio: Refactor vhost input stub
In-Reply-To: <20231229090126.GA156812@leoy-huanghe.lan> (Leo Yan's message of
 "Fri, 29 Dec 2023 17:01:26 +0800")
References: <20231120043721.50555-1-leo.yan@linaro.org>
 <20231225110608-mutt-send-email-mst@kernel.org>
 <20231229090126.GA156812@leoy-huanghe.lan>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 03 Jan 2024 13:25:39 +0000
Message-ID: <87o7e2h7l8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Leo Yan <leo.yan@linaro.org> writes:

> Hi Michael,
>
> On Mon, Dec 25, 2023 at 11:06:35AM -0500, Michael S. Tsirkin wrote:
>> On Mon, Nov 20, 2023 at 12:37:17PM +0800, Leo Yan wrote:
>> > This series is to refactor vhost stub vhost-user-input.
>> >=20
>> > Since vhost input stub requires set_config() callback for communication
>> > event configurations between the backend and the guest, patch 01 is a
>> > preparison for support set_config() callback in vhost-user-base.
>> >=20
>> > The patch 02 is to add documentation for vhost-user-input.
>> >=20
>> > The patch 03 is to move virtio input stub from the input folder to the
>> > virtio folder.
>>=20
>> Thanks!
>> Now the release is out I'd like to apply this - can you please rebase on=
 latest master and
>> repost?
>
> Sure.  But I found it's not this patch series causing merging conflict.
>
> Since my patch series is based on Alex's patch series "virtio: cleanup
> vhost-user-generic and reduce c&p" [1], when applying Alex's patch
> series on the master branch, I found the confliction with below commeits:
>
>   91208dd297 ("virtio: i2c: Check notifier helpers for VIRTIO_CONFIG_IRQ_=
IDX")
>   298d4f892e ("vhost-user: fix the reconnect error")
>
> @Alex, could you rebase the patch set "virtio: cleanup
> vhost-user-generic and reduce c&p" and then I will resend my patch set?
>
> Thanks,
> Leo
>
> [1] https://lore.kernel.org/qemu-devel/20231107180752.3458672-1-alex.benn=
ee@linaro.org/
>
>> > The patch 04 derives vhost-user-input from vhost-user-base.  We reuse
>> > the common code from vhhost-user-base as possible and the input stub is
>> > simplized significantly.
>> >=20
>> > This patch set has been tested with the backend daemon:
>> >=20
>> >   # ./build/contrib/vhost-user-input/vhost-user-input \
>> > 		     -p /dev/input/event20 -s /tmp/input.sock
>> >=20
>> > The series is based on "[PATCH v8 0/7] virtio: cleanup
>> > vhost-user-generic and reduce c&p" which introduces vhost-user-base.
>> > Based-on: <20231107180752.3458672-1-alex.bennee@linaro.org>

I'll fix up and include this series in my next posting. Hopefully by the
end of this week.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

