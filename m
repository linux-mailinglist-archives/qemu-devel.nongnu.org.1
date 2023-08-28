Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E0A78AA2B
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 12:19:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaZKY-0005yr-1Z; Mon, 28 Aug 2023 06:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qaZKW-0005ye-6C; Mon, 28 Aug 2023 06:18:44 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qaZKT-0008Ak-S1; Mon, 28 Aug 2023 06:18:43 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-525bd0b2b48so3871661a12.0; 
 Mon, 28 Aug 2023 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693217919; x=1693822719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VKrlEnzLLFPvZqAP4yuNtDtbaUsnsTMCZkanzfUgJg=;
 b=EGQ9c/2g/S8TPFyJNKTxPvT6ufwlw9LLJyLgUdQGWCEfNKEw55kwoXWUrSo9CzQEoQ
 ScrmUCfizRTetWDVJJyUpGpsq+OGiBH7C8bcOYIludLyDUr3QQI8pWP8ZqBTag5oRpUX
 4jKGzPHg7xt0yXsfwmrxFW+LOZgS1QVcMOuJlPk2QpqFBAY9ylXXrxQxoj6pDb3jAR9v
 AQQiF2Q+8VfYnPT2AFYQ3mPsJMBHAPEzXijYVSOMT8Nt5AYQobn2Ldf7JYhSjGVUqq8U
 4WPT+vhYjYrIYjuPZrt1CF48sGkLU1EthSr67iGF25c/I967cwhR4zKKuoC+a+w0xdaT
 JD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693217919; x=1693822719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/VKrlEnzLLFPvZqAP4yuNtDtbaUsnsTMCZkanzfUgJg=;
 b=gCodtU/iVJDRdjq3KcLsPau17pVO0xB1NNbG0/qQp3KUNnfqd6Doyx/+W4TiO5EhpP
 OTGAk3Wx4zWtHTxVZXEiRi6rbXsZxLHJMM52hM8qnTvWsWZZ14ZksnW+RVPNWwBDZIl3
 LdMuwYryqXwS9HC+9MGrStkC/KBxGWveLppgF42bWTEXXYE8UxQdMBiKEtjbYHtAvjho
 wlJYmkVq2Jfls2+PinRnoXhjNganF2whhUJSyadYD1nf3xjSOlEGbYHGF925UJ+oVsvE
 0c9KDbYH1B/saCMhGj6cvgL6YHufnBs4Q5/7odxy7xOB+MaalzCsg7jvAciN7Bs7r851
 zDXw==
X-Gm-Message-State: AOJu0YwKOukjMhHcLl388F9YuQ1102ckYH4pFGMbSyz/WKI79tlQozo+
 sttczUI0UsVV4AKvwJefo+KUFWYhogprajmW5Gg=
X-Google-Smtp-Source: AGHT+IHahbtTt6gZm+a79KAGhcqEklDm+s7m9TTmPWE5QU3c8MoM04GtOxEYTeAQ11abKukUpdudTgNZ7P/XnwArM/g=
X-Received: by 2002:aa7:d297:0:b0:527:fa8d:d409 with SMTP id
 w23-20020aa7d297000000b00527fa8dd409mr18907232edq.7.1693217918910; Mon, 28
 Aug 2023 03:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <20230814085802.61459-3-faithilikerun@gmail.com>
 <20230821133131.GA37847@fedora>
 <CAAAx-8JL1ieece-noWNo3ZJ4fDD-x-Z4u+WOgsO4jnvpoqLqTw@mail.gmail.com>
 <f1144d47-209d-c376-f179-1af2ad2d3f1b@kernel.org>
In-Reply-To: <f1144d47-209d-c376-f179-1af2ad2d3f1b@kernel.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 28 Aug 2023 18:18:09 +0800
Message-ID: <CAAAx-8KHyTNDKL6FvAifZmH6LW46U5ccM+c=Rp0Hf=XpbErczg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] qcow2: add configurations for zoned format
 extension
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>
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

Damien Le Moal <dlemoal@kernel.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=B8=80 18:13=E5=86=99=E9=81=93=EF=BC=9A
>
> On 8/28/23 18:22, Sam Li wrote:
> > Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=882=
1=E6=97=A5=E5=91=A8=E4=B8=80 21:31=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Mon, Aug 14, 2023 at 04:58:00PM +0800, Sam Li wrote:
> >>> diff --git a/block/qcow2.h b/block/qcow2.h
> >>> index f789ce3ae0..3694c8d217 100644
> >>> --- a/block/qcow2.h
> >>> +++ b/block/qcow2.h
> >>> @@ -236,6 +236,20 @@ typedef struct Qcow2CryptoHeaderExtension {
> >>>      uint64_t length;
> >>>  } QEMU_PACKED Qcow2CryptoHeaderExtension;
> >>>
> >>> +typedef struct Qcow2ZonedHeaderExtension {
> >>> +    /* Zoned device attributes */
> >>> +    uint8_t zoned_profile;
> >>> +    uint8_t zoned;
> >>> +    uint16_t reserved16;
> >>> +    uint32_t zone_size;
> >>> +    uint32_t zone_capacity;
> >>
> >> Should zone capacity be stored individually for each zone (alongside t=
he
> >> write pointer and other per zone metadata) instead of as a global valu=
e
> >> for all zones? My understanding is that NVMe ZNS does not have a globa=
l
> >> value and each zone could have a different zone capacity value.
> >
> > Though zone capacity is per-zone attribute, it remains same for all
> > zones in most cases. Referring to the NVMe ZNS spec, zone capacity
> > changes associate to RESET_ZONE op when the variable zone capacity bit
> > is '1'. It hasn't specifically tell what it is changed to. Current ZNS
> > emulation doesn't change zone capacity as well.
> >
> > If the Variable Zone Capacity bit is cleared to =E2=80=980=E2=80=99 in =
the Zone
> > Operation Characteristics field in the Zoned
> > Namespace Command Set specific Identify Namespace data structure, then
> > this field does not change without a change to the format of the zoned
> > namespace.
> >
> > If the Variable Zone Capacity bit is set to =E2=80=981=E2=80=99 in the =
Zone Operation
> > Characteristics field in the Zoned
> > Namespace Command Set specific Identify Namespace data structure, then
> > the zone capacity may
> > change upon successful completion of a Zone Management Send command
> > specifying the Zone Send
> > Action of Reset Zone.
>
> Regardless of the variable zone capacity feature, zone capacity is per zo=
ne and
> may be different between zones. That is why it is reported per zone in zo=
ne
> report. The IO path code should not assume that the zone capacity is the =
same
> for all zones.

How is zone capacity changed, by devices or commands? Can you give
some example please?

>
> For this particular case though, given that this is QCow2 emulation, limi=
ting
> ourselves to the same zone capacity for all zones is I think fine. But th=
at
> should be clearly stated somewhere may be...

I see. The qcow2 documentaion can add that.

>
> >
> >>
> >>> +    uint32_t nr_zones;
> >>
> >> Is this field necessary since it can be derived from other image
> >> options: nr_zones =3D DIV_ROUND_UP(total_length, zone_capacity)?
> >
> > It can be dropped. I added this for reducing duplication. Thanks!
>
> --
> Damien Le Moal
> Western Digital Research
>

