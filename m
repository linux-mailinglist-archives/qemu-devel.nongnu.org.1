Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC12D744C00
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 03:37:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFm0A-0001Je-Fe; Sat, 01 Jul 2023 21:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1qFm08-0001Hv-2j; Sat, 01 Jul 2023 21:35:44 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1qFm05-0007fY-Gc; Sat, 01 Jul 2023 21:35:43 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbc244d307so32768425e9.1; 
 Sat, 01 Jul 2023 18:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688261732; x=1690853732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5j0ylvlbGyI2o543n1+Hlev2yR/lbdvBfoJ89tLrDBU=;
 b=kUlmuVb298DiS/8NqG1XMgkdQY+KnESkwbVtFR6RaOyeAXaCGiIMsVJfHc6ipDPeoF
 CykiaxFV52/HM1oLtW/ESvQYl5XjcfK0c2O+j+Poq403vsILbcM8CyPuBjsmMfbfYQNz
 ZW1e0wGMB7/knGs8SjKYw8Ri7iNh5dMxarlGhbJRHTv7tF+DNKg5pAX3bWYpuY8Mo8AR
 WEsEsr6R0r25w0rOuwAIIgH9Znq8gxnShOd1UjSrrTQtFGvTD+GRZLC9+TmXvoa+38ZD
 AIKZiVzX3EuK7tZvmXPWyrL9G1CR3z7cxrCzsBlVdAVxu2DKJ4NfF50WnkJ98zh1B0sO
 ca6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688261732; x=1690853732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5j0ylvlbGyI2o543n1+Hlev2yR/lbdvBfoJ89tLrDBU=;
 b=YYHlU1dD7b4QHrY5iKJh+EumEczgNpnGHZ6plJFK1lxP6vNXf8bHaQw07dnZwtj/Ea
 80MjIWxhg1mkEPzf6qPiyPD/yPMH3+fGEOUuuoBBYV3JNLvT+ADBDsG0+fhB6lLSRkhz
 OwuIUan2dCBMlZpgRQ32wyN2ZxXJzwVWoAf3XBZaS3XDJa2G3d4H6O9K/td32rLMh4Jc
 Cp1VyC/37br6fx5S/pImWdfBgPdhVUdu+/C7YWzcfKsf4Zno9EXc3peP8qnDYsX7vkfe
 StxnQt+FRVVbqUbEstsySmJq2lRB9NULSKerr4tTnrrB2wycipn40LaSJUx0+SthMQ/y
 WSig==
X-Gm-Message-State: AC+VfDzQSHL+L8hx4+DdFhZLSUOY58PW7LiKR0FV47XRoo3GRgniWAKw
 YjT95OoylVdNjyDWeux1bUnvWwbtVtvz+DlF+JA=
X-Google-Smtp-Source: ACHHUZ6RVIoJiRGvO+UFE6c5hvfOhonPYIF9yfI16wLqbFoqULZRXa9XXASbGKcBOhgJW3wWQnEB+KQ1UG5P+UmnavI=
X-Received: by 2002:a05:600c:b54:b0:3f9:846:d892 with SMTP id
 k20-20020a05600c0b5400b003f90846d892mr5564867wmr.9.1688261731941; Sat, 01 Jul
 2023 18:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230625015321.77987-1-bmeng@tinylab.org>
In-Reply-To: <20230625015321.77987-1-bmeng@tinylab.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 2 Jul 2023 09:35:19 +0800
Message-ID: <CAEUhbmXVL8YLEDgPhj9zxhAt70nMF5=TXn491-tCOxoHaF=+QA@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] net: Pad short frames for network backends
To: Bin Meng <bmeng@tinylab.org>
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Helge Deller <deller@gmx.de>,
 Joel Stanley <joel@jms.id.au>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun, Jun 25, 2023 at 9:59=E2=80=AFAM Bin Meng <bmeng@tinylab.org> wrote:
>
> The minimum Ethernet frame length is 60 bytes. For short frames with
> smaller length like ARP packets (only 42 bytes), on a real world NIC
> it can choose either padding its length to the minimum required 60
> bytes, or sending it out directly to the wire. Such behavior can be
> hardcoded or controled by a register bit. Similarly on the receive
> path, NICs can choose either dropping such short frames directly or
> handing them over to software to handle.
>
> On the other hand, for the network backends like SLiRP/TAP, they
> don't expose a way to control the short frame behavior. As of today
> they just send/receive data from/to the other end connected to them,
> which means any sized packet is acceptable. So they can send and
> receive short frames without any problem. It is observed that ARP
> packets sent from SLiRP/TAP are 42 bytes, and SLiRP/TAP just send
> these ARP packets to the other end which might be a NIC model that
> does not allow short frames to pass through.
>
> To provide better compatibility, for packets sent from QEMU network
> backends like SLiRP/TAP, we change to pad short frames before sending
> it out to the other end, if the other end does not forbid it via the
> nc->do_not_pad flag. This ensures a backend as an Ethernet sender
> does not violate the spec. But with this change, the behavior of
> dropping short frames from SLiRP/TAP interfaces in the NIC model
> cannot be emulated because it always receives a packet that is spec
> complaint. The capability of sending short frames from NIC models is
> still supported and short frames can still pass through SLiRP/TAP.
>
> This series should be able to fix the issue as reported with some
> NIC models before, that ARP requests get dropped, preventing the
> guest from becoming visible on the network. It was workarounded in
> these NIC models on the receive path, that when a short frame is
> received, it is padded up to 60 bytes.
>
> Only the first 4 patches of the v5 series [1] were applied in QEMU 6.0,
> and the reset was said to be queued for 6.1 but for some reason they
> never landed in QEMU mainline.
>
> Hopefully this series will make it for QEMU 8.1.
>
> [1] https://lore.kernel.org/qemu-devel/859cd26a-feb2-ed62-98d5-764841a468=
cf@redhat.com/
>
> Changes in v7:
> - new patch: "hw/net: ftgmac100: Drop the small packet check in the recei=
ve path"
>

Ping?

