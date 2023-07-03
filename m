Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E862745576
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 08:25:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGCz4-0006ks-9J; Mon, 03 Jul 2023 02:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qGCz2-0006kb-1D
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qGCz0-0000t1-8D
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688365461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4pguoLjcaCAIS9WVe6zFE6TPqIxfCYwiZtN7MF4sCZg=;
 b=OsyuOEnZ10Q/uSclKbPay9cpea0LN23RDykOeWk2JrDKMF+RfyWPGuTGCegdnd8mkb6x7W
 8mIpyR9i+LiBsGjbEu0vYlWORNLI7UqRKeBHWBeHtXoL945+tVMErjdxpBW2uDoUJHATUO
 +RIOb3cxGjnZgQ5EP3FSxcfUv/+MHWI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-c2huEURqNPuUtegzHm5d1A-1; Mon, 03 Jul 2023 02:24:19 -0400
X-MC-Unique: c2huEURqNPuUtegzHm5d1A-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b66c262bd9so35628151fa.2
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 23:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688365458; x=1690957458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4pguoLjcaCAIS9WVe6zFE6TPqIxfCYwiZtN7MF4sCZg=;
 b=Sp1DZ1FO1ad4mx8Miq27gzp9RroE9O2BSLrRIp1bod0QdbdN2H7OFFJGTb+hCBzYqe
 tYmXDRaKe60On6oHgbdVm6mlLH4onG72/BW/kXpeX5xCPaS8ZkLrbvXgAinsly5l3oZ+
 yN0WolrxC4S0W4Sr0adbyUD0i/0Ec5rCdh0p0Y9oN4bY2r6MA8gWXaBKcaS8sF9qetIu
 FY7tAA8jrO7szGWYa9WkIhWmB231WlS+91DXDAD7byc/z7Rjt48rKCgyWFiq7OyWp121
 ANFjO8ayUplmbnTicca0wOQwZU81E4eLsQSbIJJUktmzko93QJUlpgJuchgx+7QF5LE2
 NWeA==
X-Gm-Message-State: ABy/qLbH3x+v2JDEBFckmhQaoNkfmWUuNiCOQjDbrerZ/AHyKMHu4Tl+
 k4Alj2YVvHtpXmY+Oi3KMfm0qyz2TcyYKRR9GeXfJ8/NnVg4yetjetB6N7rjzjWmoB3nLIBQqC/
 xAaZUpwPYIfCO47zCqs7xYitkYBL7bLk=
X-Received: by 2002:a2e:9856:0:b0:2b6:c349:e276 with SMTP id
 e22-20020a2e9856000000b002b6c349e276mr6236455ljj.20.1688365458173; 
 Sun, 02 Jul 2023 23:24:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFzrq8O/qIl0DKHbv7DMzy9u5Pj5n0e8ho6D4rJr/AfBuCEtuE4hh7YzwtZIOXPU5rm57lzQ4losHNal8mBI+o=
X-Received: by 2002:a2e:9856:0:b0:2b6:c349:e276 with SMTP id
 e22-20020a2e9856000000b002b6c349e276mr6236436ljj.20.1688365457865; Sun, 02
 Jul 2023 23:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230625015321.77987-1-bmeng@tinylab.org>
 <CAEUhbmXVL8YLEDgPhj9zxhAt70nMF5=TXn491-tCOxoHaF=+QA@mail.gmail.com>
In-Reply-To: <CAEUhbmXVL8YLEDgPhj9zxhAt70nMF5=TXn491-tCOxoHaF=+QA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 3 Jul 2023 14:24:06 +0800
Message-ID: <CACGkMEsirSC0Y-r_F+tvGim+S=uFB7LypjLjjjMz3htwdSj4ow@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] net: Pad short frames for network backends
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Bin Meng <bmeng@tinylab.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Helge Deller <deller@gmx.de>,
 Joel Stanley <joel@jms.id.au>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Jul 2, 2023 at 9:35=E2=80=AFAM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Sun, Jun 25, 2023 at 9:59=E2=80=AFAM Bin Meng <bmeng@tinylab.org> wrot=
e:
> >
> > The minimum Ethernet frame length is 60 bytes. For short frames with
> > smaller length like ARP packets (only 42 bytes), on a real world NIC
> > it can choose either padding its length to the minimum required 60
> > bytes, or sending it out directly to the wire. Such behavior can be
> > hardcoded or controled by a register bit. Similarly on the receive
> > path, NICs can choose either dropping such short frames directly or
> > handing them over to software to handle.
> >
> > On the other hand, for the network backends like SLiRP/TAP, they
> > don't expose a way to control the short frame behavior. As of today
> > they just send/receive data from/to the other end connected to them,
> > which means any sized packet is acceptable. So they can send and
> > receive short frames without any problem. It is observed that ARP
> > packets sent from SLiRP/TAP are 42 bytes, and SLiRP/TAP just send
> > these ARP packets to the other end which might be a NIC model that
> > does not allow short frames to pass through.
> >
> > To provide better compatibility, for packets sent from QEMU network
> > backends like SLiRP/TAP, we change to pad short frames before sending
> > it out to the other end, if the other end does not forbid it via the
> > nc->do_not_pad flag. This ensures a backend as an Ethernet sender
> > does not violate the spec. But with this change, the behavior of
> > dropping short frames from SLiRP/TAP interfaces in the NIC model
> > cannot be emulated because it always receives a packet that is spec
> > complaint. The capability of sending short frames from NIC models is
> > still supported and short frames can still pass through SLiRP/TAP.
> >
> > This series should be able to fix the issue as reported with some
> > NIC models before, that ARP requests get dropped, preventing the
> > guest from becoming visible on the network. It was workarounded in
> > these NIC models on the receive path, that when a short frame is
> > received, it is padded up to 60 bytes.
> >
> > Only the first 4 patches of the v5 series [1] were applied in QEMU 6.0,
> > and the reset was said to be queued for 6.1 but for some reason they
> > never landed in QEMU mainline.
> >
> > Hopefully this series will make it for QEMU 8.1.
> >
> > [1] https://lore.kernel.org/qemu-devel/859cd26a-feb2-ed62-98d5-764841a4=
68cf@redhat.com/
> >
> > Changes in v7:
> > - new patch: "hw/net: ftgmac100: Drop the small packet check in the rec=
eive path"
> >
>
> Ping?

I've queued this series.

Thanks

>


