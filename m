Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADC7750A6D
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 16:06:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJaSs-0000Ip-I4; Wed, 12 Jul 2023 10:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qJaSo-0000Ib-0w; Wed, 12 Jul 2023 10:05:06 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qJaSm-0007Az-87; Wed, 12 Jul 2023 10:05:05 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b6a084a34cso108910101fa.1; 
 Wed, 12 Jul 2023 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689170701; x=1691762701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pXsrLA553mcDwr35AuRdOwTzPIYa2mIwAS8Mw4v/BRQ=;
 b=otxNButNE+CSNMvaUqXaCFJQcWKaLnfoN4dLE/NeJ2N2C5gcMYj99+5lTGN2T6IuGX
 2UwDSCDhLIBtLB1KKWvRKmiCq2qKM5krik+vclBHCe+wtpgWtR809d5Syxyf0ZPmpZKX
 d99Tb5YtKf7tyoxu/fNOMhAmASDLbc7XVB0KAWT2JA1GgCpHcQdCXzB2bp8zBZ/Wmf3i
 cZeIXIpeTR6kcKixVFhHH1Ky/6w1MyjdXazO7/NSvr8XHUJyDg/aGlUtvPdHzF/nJTC5
 Lr1hz6Q20QJoj5O+6pxY79xEcDxa4sXE7OIa1gljuWdu/VqygU+PP2hIViWvmqEvHVHD
 g3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689170701; x=1691762701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pXsrLA553mcDwr35AuRdOwTzPIYa2mIwAS8Mw4v/BRQ=;
 b=Jgy2/GbHU4672qvvx8+jKygf2bdp/ZjvTfssFttAmeaeqUslO0G/PSorR1szRdOxto
 1oNFm+bPulSWYl1CvTTEA/JMXF23ATUrmIjeucfajy6wm0IiPWo9EONsuXLDHNQQjSA1
 hiQhx42KpOYc6VXVzoGrxJ6Qg+DjmerM8slaMim194F2E5edDgdtH4jKGCqnu4Kvv8F2
 O6GBMucCRC7tbf6+D5GNSC3+Rm47BQmvV4iEiQDpEgypr6NCWjM9Rpu2gl7LRluk6hGq
 kLdeJRJeqm4qQKP+qBYPvZycVemq/J47UbyxCc69SlKWSJzHSmCvoKpGwQhJkO7EeF71
 XqAg==
X-Gm-Message-State: ABy/qLZLnUzc+oT44+HUlNStyT8pKkMzd+YC4On9BBANu9NptHlGNJY5
 gx9kmbD17nkdGeyWLd09vONbBGh/1Z8NBm+IL74=
X-Google-Smtp-Source: APBJJlHf4vO6M+og0d8vTcSQz4oo2Yxvtu5QghQ7H4GQ3tW8htorIqIiSwEUDtbjQArmA5at1aghtvQggOnrgcCOocE=
X-Received: by 2002:a2e:9909:0:b0:2b6:eefc:3e4f with SMTP id
 v9-20020a2e9909000000b002b6eefc3e4fmr16483313lji.21.1689170700941; Wed, 12
 Jul 2023 07:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230622010651.22698-1-yin31149@gmail.com>
 <CAJaqyWfr6XTz7qhMfYR7kJW_A409N7x6hcYQd2ypUD_p6kyc_g@mail.gmail.com>
 <CAKrof1O12p=7zf5jzJca0mtcyoYJHiR-5ubYLD1Q0aszWaKhoQ@mail.gmail.com>
 <20230710145208-mutt-send-email-mst@kernel.org>
 <CAKrof1PCqSKbLUy673eKF19w9_kAh3C6sdMC0nm-4BXUwAmktA@mail.gmail.com>
 <a33441e1-4e29-5e5d-33df-ffb52d3493ef@tls.msk.ru>
In-Reply-To: <a33441e1-4e29-5e5d-33df-ffb52d3493ef@tls.msk.ru>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Wed, 12 Jul 2023 22:04:49 +0800
Message-ID: <CAKrof1NUVxD5vajRmUu931gBPLK4utJWB_kVTHhROMv0OhKEiw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Increase out buffer size for CVQ commands
To: Michael Tokarev <mjt@tls.msk.ru>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, jasowang@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

=E5=9C=A8 2023/7/12 18:45, Michael Tokarev =E5=86=99=E9=81=93:
> 11.07.2023 04:48, Hawkins Jiawei wrote:
> ..
>> Sorry for not mentioning that I have moved the patch to the patch series
>> titled "Vhost-vdpa Shadow Virtqueue _F_CTRL_RX commands support" at [1].
>> The reason for this move is that the bug in question should not be
>> triggered until the VIRTIO_NET_CTRL_MAC_TABLE_SET command is exposed by
>> this patch series.
>
> Does this mean this particular change is not supposed to be applied to
> -stable,
> as the other change which exposes the bug isn't in any stable series?

Yes, you are right.

This bug is related to the VIRTIO_NET_CTRL_MAC_TABLE_SET command in SVQ,
and this command is not exposed in SVQ in any stable branch, so we do
not need to apply the patch to the -stable branch.

Thanks!

>
> Thanks,
>
> /mjt

