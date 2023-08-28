Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C075B78A8D8
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 11:24:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaYSN-0000vZ-KG; Mon, 28 Aug 2023 05:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qaYSJ-0000v0-Vg; Mon, 28 Aug 2023 05:22:44 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qaYSH-0006iK-Ft; Mon, 28 Aug 2023 05:22:43 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52a3aa99bcdso4265466a12.0; 
 Mon, 28 Aug 2023 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693214559; x=1693819359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bsxxk6CIKTnWxj+e3rfPdw+A7hgiJAieT872Kh5uh5g=;
 b=jJ8RxTED6J0BJNVogKjIaVZNv5zN8tp69Qa+U6AN3s6npUSAgSUwGGNBwTxYgWQhPT
 nlZwvJTsC9gKz62PYf0a3Gpz1kkZYtmsCdGUKg14Iyv01JgwMxDhXXPKb2ql0K6UQM0K
 Yl0FIzI7vhnhoDyBQ3KGuk1z2L33jD9yCGuimOvf5+pffJiHSWphx0W2LgaJh23jaySp
 xLrRenSJCPjqZdOHIn1pCJqW8AIp8pi0gIfHme89KEpWpGD094RQuqyMip7G6x4NlfgM
 uFsUElkzR8GJAAB1NduhtDEuTP91VJnzlF+Z4k/USofdPxxuml/TNMSWEfze0LsOY3Cq
 rKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693214559; x=1693819359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bsxxk6CIKTnWxj+e3rfPdw+A7hgiJAieT872Kh5uh5g=;
 b=YFc63MTdsP3Hmgv6c9dOcUI45ZNLy7msV53/gjpPTwZv2NFrAJcaflKkCqXwcIh7Om
 sFuiUtC0rkdQr7E/QFDbqGloFD/+MzKP6SscuWKsbSvhtEH7AByxXmKPrJrq8lBidA6t
 xuEzNnhVr2UCFEgLKMKCt21T2RgNc0X300iskUpedD10ct3VOStjBooFgCZELejAw0HD
 IQ88r/LMcJkOPNRB6PQbniuV6tkm0rpvp3FTHl36jgvnoD2OUlzTupcgeFz/OXUEh4zq
 UdfrKD95pkViwOQUKhp+NM6Dc+8ob5L0LWXPJGiMQdqhkDp07amJCYYQRzInKAjOo4gp
 4e7Q==
X-Gm-Message-State: AOJu0YwJC6be3lW2/EQS1wDt7KY/g3Jno8A0bNuCWwO/snlJsTMFCpWS
 3C3/0Poi2ru4aWqO9/0hoV62f1UJ98+6DZuLizWXl5K1urlVFgZ5
X-Google-Smtp-Source: AGHT+IFZKoPKw8up6sZAt5kvrKEE3XWbZOlQks/aZW+B2NOYh1lUGwv25u0retBb6ERE7+fLDRFksJZRc239vinpKFQ=
X-Received: by 2002:a05:6402:120a:b0:525:46b7:40f2 with SMTP id
 c10-20020a056402120a00b0052546b740f2mr17909213edw.21.1693214558648; Mon, 28
 Aug 2023 02:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <20230814085802.61459-3-faithilikerun@gmail.com>
 <20230821133131.GA37847@fedora>
In-Reply-To: <20230821133131.GA37847@fedora>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 28 Aug 2023 17:22:10 +0800
Message-ID: <CAAAx-8JL1ieece-noWNo3ZJ4fDD-x-Z4u+WOgsO4jnvpoqLqTw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] qcow2: add configurations for zoned format
 extension
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, hare@suse.de, Hanna Reitz <hreitz@redhat.com>, 
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x531.google.com
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

Though zone capacity is per-zone attribute, it remains same for all
zones in most cases. Referring to the NVMe ZNS spec, zone capacity
changes associate to RESET_ZONE op when the variable zone capacity bit
is '1'. It hasn't specifically tell what it is changed to. Current ZNS
emulation doesn't change zone capacity as well.

If the Variable Zone Capacity bit is cleared to =E2=80=980=E2=80=99 in the =
Zone
Operation Characteristics field in the Zoned
Namespace Command Set specific Identify Namespace data structure, then
this field does not change without a change to the format of the zoned
namespace.

If the Variable Zone Capacity bit is set to =E2=80=981=E2=80=99 in the Zone=
 Operation
Characteristics field in the Zoned
Namespace Command Set specific Identify Namespace data structure, then
the zone capacity may
change upon successful completion of a Zone Management Send command
specifying the Zone Send
Action of Reset Zone.

>
> > +    uint32_t nr_zones;
>
> Is this field necessary since it can be derived from other image
> options: nr_zones =3D DIV_ROUND_UP(total_length, zone_capacity)?

It can be dropped. I added this for reducing duplication. Thanks!

