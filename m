Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7023E821E7C
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 16:14:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKgTJ-00043V-9R; Tue, 02 Jan 2024 10:14:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rKgSv-0003zb-Ln
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 10:14:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rKgSr-000244-Av
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 10:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704208436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aDBU3usiNNfqIS9W0oir/LqYcsWyzQeGKV3csq2Krxk=;
 b=aeVhM29yJsWNtlhKKqf6srOfkfLCIVVE99p6MG7uFfwvsuZMzqh4EH1uH1tQQmzpN1U/OE
 fCNPYvoojWCHv5Ck5BPIrZx6w0IUwaoFK9o3lsX6tjSXryPJ89MqQNWgv1/t0x+IWIcAuL
 f+y/kkxqj38lZ2gQXbPPYqoc/b0w6wg=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-CEAombBhNgaWxM3mGQNUvw-1; Tue, 02 Jan 2024 10:13:54 -0500
X-MC-Unique: CEAombBhNgaWxM3mGQNUvw-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6dc0315c07eso5755669a34.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 07:13:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704208433; x=1704813233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aDBU3usiNNfqIS9W0oir/LqYcsWyzQeGKV3csq2Krxk=;
 b=JGv/vVp/7zkmVF5XDr4y7TPawdXsZcFMh6804YZXmOaSgHsE21gjOa6nLAVY8Zo1lF
 CjKee8jP9Xr/mZJFdQSS9sXDVNUHqeZ2hYEyVLKBf2uH3LtZ+Bbcr0pm9KXtKTgB2s50
 t1p7L/JPH3H7buul9wKIpUvltu94efGDmHKTVe+7j4DPI9di2cyEtsPFiXJEIJAZlCU+
 rXjZkywANms/XJZsmfse7xG2psFJpTC5szUY+029jxMU6ZkZqD8nBd2FchtoCUw4eg0z
 o8TKC6VTOwZbGO0G+WP5swNEKgGxt+BTsOo0BWvamh7iCSQwKZiox0ErLb22YyIT/rhY
 VJUA==
X-Gm-Message-State: AOJu0Ywri2gKXBQzJW2C4qjJfAmuhRny4lxzhl/yTNJCNSbYPgweDGtZ
 IFhEbpVaQ3VSS3enmd2/ubAZLt9jNP4Lab3TW40GES6XyRkxZAr7zcAS7VDLH/W935wsHdXzSKW
 k2gx+oOmS96RJYg3L3PqZOsxk7wCOaF4f0KfV9Ik=
X-Received: by 2002:a05:6830:16c8:b0:6dc:30d1:9ae0 with SMTP id
 l8-20020a05683016c800b006dc30d19ae0mr4186129otr.31.1704208433209; 
 Tue, 02 Jan 2024 07:13:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFr++NZL0EkjxfwI28c9AMEDRZhJ7SneBSYi5ksZhDCmHmQmlL6DS4HAlxLDmbf5Rl4la6yOqPMuxZdz+JhljI=
X-Received: by 2002:a05:6830:16c8:b0:6dc:30d1:9ae0 with SMTP id
 l8-20020a05683016c800b006dc30d19ae0mr4186118otr.31.1704208432975; Tue, 02 Jan
 2024 07:13:52 -0800 (PST)
MIME-Version: 1.0
References: <20231231093918.239549-1-pbonzini@redhat.com>
 <20231231093918.239549-2-pbonzini@redhat.com>
 <7ed77225-bd72-9cf1-bd57-eec34d6226c0@eik.bme.hu>
In-Reply-To: <7ed77225-bd72-9cf1-bd57-eec34d6226c0@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 2 Jan 2024 16:13:39 +0100
Message-ID: <CABgObfa4apRY0d28Bip=bww+H2G10Xvxu9rdTWUMP1pfr-1yuA@mail.gmail.com>
Subject: Re: [PATCH 1/8] vga: remove unused macros
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, Dec 31, 2023 at 5:01=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Sun, 31 Dec 2023, Paolo Bonzini wrote:
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> > hw/display/vga.c | 14 --------------
> > 1 file changed, 14 deletions(-)
> >
> > diff --git a/hw/display/vga.c b/hw/display/vga.c
> > index 37557c3442a..18d966ecd3e 100644
> > --- a/hw/display/vga.c
> > +++ b/hw/display/vga.c
> > @@ -103,12 +103,6 @@ const uint8_t gr_mask[16] =3D {
> > #define PAT(x) (x)
> > #endif
>
> While at it you could also move this definiton dows to where it's used so
> it's clear where it's needed.

In fact PAT() can be replaced with const_le32(), and GET_PLANE() can
use a byte swap, which is just as fast as tweaking the shift count these
days[1]:

#define GET_PLANE(data, p) ((cpu_to_le32(data) >> ((p) * 8)) & 0xff)

and it can even be inlined

Paolo

[1] see following instructions, only sparc is missing:

arm/aarch64 - rev
i386 - bswapl
loongarch - revb.2w
mips - wsbh + rotr
ppc - brw
riscv - rev8 ( + srli on riscv64)
s390 - lrvgr


