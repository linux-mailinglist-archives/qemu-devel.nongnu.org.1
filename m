Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCE678B36A
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 16:45:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qadSj-0000Ie-D3; Mon, 28 Aug 2023 10:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qadSd-0000IA-Vz; Mon, 28 Aug 2023 10:43:24 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qadSa-0006pV-J4; Mon, 28 Aug 2023 10:43:23 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52a3ec08d93so4372487a12.2; 
 Mon, 28 Aug 2023 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693233798; x=1693838598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w2lTL1rmvjjFiWwcN3NTcLRSlo+IgOioi6dTOia3i40=;
 b=nr//QCPd1C1S0qFyhPnCbfCL67MM/IGfK99Zo2Esw0z+ZErAi0JzFc23ZcJXQrAYqx
 uQevSmUtkE7dMjG0z3q9I2vLleL1ToGuWv70RdgOOwtEg+9CSr7K/5jzimz4760+Y5E/
 //pHL/gLpt9tUvSTA1nM0/fFqqHSSQzHh2CqfRsa6W6sgh98a6rTFvFeRkd5v+YWVgYp
 +abO7BlawBfhXmDJx1BUlwTfNj0q+QMt+tzO41n9w7ab4aV0A6gFjPuvjlIJ0SYI6Ccp
 kaxDpidR0AqnFbWE9ImNid7YyMx+eqkAA1gya4FfE292FQoKk1TqQAsAr4rkCrOrxw6q
 TGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693233798; x=1693838598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w2lTL1rmvjjFiWwcN3NTcLRSlo+IgOioi6dTOia3i40=;
 b=H/WAcbySLMeT3GUv9WygH0GN04TrG2t1raP9IHMcwn+pDHQiQNRV+/KUKrcjn63jSe
 9/wFXqfS70wA7x/inR3uZXlfHLaLYkbj7B1WAQlj0qw5pGaD4IRHljFQkMHrbVvkaa+f
 xtd5h3wlhVCMqARmqhO+0XqdNljMBHrDl/bl/g4lzR3lJgh47uvuGYINn9JAu0F/lvtU
 WYjvOhaKJkZWz3BTCjyrA6xBEgyo8QFALJsFH8iOIGddJi5cltrbqHgNJPlsw+9alPiZ
 NtfBHB5uZ0LwjBLr/EOq4JuyJWVSXhmE5vlTLiMbZWgshnwz5a8Gb8uPFGZ/yuUWgY0t
 1fSA==
X-Gm-Message-State: AOJu0YzD7GMZ6RAaz/JMN9S3UVBaTB7lItiznZAQkDkGJUq/ijst5lD9
 JZYRnGNNjEqN3d3OrqH0k5X/WaWjHlzM94VK9bc=
X-Google-Smtp-Source: AGHT+IGYuQTqVL/f7FtWa81VlXEw6UOn+XJLkUu8ki847RwSHYsPrG0arezLKzhqqx920YYHKSS9jDR1Y2I+yuA7TVc=
X-Received: by 2002:a50:fb9a:0:b0:523:364b:e6a9 with SMTP id
 e26-20020a50fb9a000000b00523364be6a9mr18615102edq.38.1693233797696; Mon, 28
 Aug 2023 07:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <20230814085802.61459-3-faithilikerun@gmail.com>
 <20230821133131.GA37847@fedora>
In-Reply-To: <20230821133131.GA37847@fedora>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 28 Aug 2023 22:42:48 +0800
Message-ID: <CAAAx-8KqJDMK7tYzea1WmreOq6EMQyp-LrgnOpcjOdg2vE15JA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] qcow2: add configurations for zoned format
 extension
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, hare@suse.de, Hanna Reitz <hreitz@redhat.com>, 
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=B8=80 21:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Aug 14, 2023 at 04:58:00PM +0800, Sam Li wrote:
> > diff --git a/block/qcow2.h b/block/qcow2.h
> > index f789ce3ae0..3694c8d217 100644
> > --- a/block/qcow2.h
> > +++ b/block/qcow2.h
> > @@ -236,6 +236,20 @@ typedef struct Qcow2CryptoHeaderExtension {
> >      uint64_t length;
> >  } QEMU_PACKED Qcow2CryptoHeaderExtension;
> >
> > +typedef struct Qcow2ZonedHeaderExtension {
> > +    /* Zoned device attributes */
> > +    uint8_t zoned_profile;
> > +    uint8_t zoned;
> > +    uint16_t reserved16;
> > +    uint32_t zone_size;
> > +    uint32_t zone_capacity;
>
> Should zone capacity be stored individually for each zone (alongside the
> write pointer and other per zone metadata) instead of as a global value
> for all zones? My understanding is that NVMe ZNS does not have a global
> value and each zone could have a different zone capacity value.
>
> > +    uint32_t nr_zones;
>
> Is this field necessary since it can be derived from other image
> options: nr_zones =3D DIV_ROUND_UP(total_length, zone_capacity)?

Yes. The bs->total_sectors in refresh_limits is zero. Keeping a
persistent nr_zones helps assigning right value instead of zero.

The process is roughly like this:
*_qcow2_create: calculate nr_zones and write it to zoned_header
->  *_qcow2_update_header: update nr_zones
    ->  *_qcow2_read_extensions: read nr_zones in zoned_header to
Qcow2State and check if right (valid total size here)
      -> *_refresh_limits(): set bl.nr_zones to zoned_header.nr_zones

Sam

