Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5B37C8B89
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 18:45:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLGy-0000Yf-Jv; Fri, 13 Oct 2023 12:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qrLGw-0000YW-EP
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:44:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qrLGu-0007wR-Vo
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697215458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BrCsFKU6/6b27ugadRaxGL+aaYn/AJ7TD3MhsziMBx4=;
 b=C1wbwr0xqKI1m615QMRJiSqw2bH6Lbvdwd2qonHYkBuZ2zGOcTJ7FXSrgdyXHbOn8NIgRD
 VrTs//NaTGDBAeTvwjNPEPuTzWpPtcBJp4+6JLkxZhZ4AkOaqA3XnTQ6IWHOL/NjIGhpo5
 V7+7WbPLZfAU0I73B3CgRKnRyzTmU6k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-CUD_RJKYODu3gBFRdS4ANQ-1; Fri, 13 Oct 2023 12:43:58 -0400
X-MC-Unique: CUD_RJKYODu3gBFRdS4ANQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5056b17f0b9so2956517e87.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 09:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697215437; x=1697820237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BrCsFKU6/6b27ugadRaxGL+aaYn/AJ7TD3MhsziMBx4=;
 b=auCGcZcJMufhEUGDN3qo0KRWqKEPeuhi6zJSfkJIuwZrHuyV2UuQektUvbjxIo9CU8
 9q0aOrrlm8AMAl6p0WiUul3tqZR4oId9ltcWPRAFsFASUpr882VoCPi3DDECn19q283s
 cE7Q/Jazh5N0I/4rN7D/j1f0DYZl26hRmgvoaYxlQIWa6/rRZYHyH+kcRodJDB6ZVgwR
 Z+Wsjh1PJQEPYRuOoqON0Z4jXLbLbj8lGflVeYsyA77JXrJHQX1eDUafpmpdNWO/m/wf
 SGf8euThuZaDFHPbGrjroKn4/pDekzd/gy37sAqAWEB+ZHhgOgi4hY0wDaErcezQVTo5
 3fgQ==
X-Gm-Message-State: AOJu0Yxj7+LaTGABVBibLqpQQSzzhPH6nHLFykHYWkG8KYrYJuUpXP17
 kKMU4JZUWwO5EoZP7JUCNRUxTWlv5tVv+HPYGW8lG7Wh4atkmHQoqRJYaVX/D63hCqcECDRHLiq
 /t/5fI4n9y4ZJ+nSCIbb+IL0LUhljv3c=
X-Received: by 2002:a05:6512:31d2:b0:507:9797:304d with SMTP id
 j18-20020a05651231d200b005079797304dmr458025lfe.9.1697215437377; 
 Fri, 13 Oct 2023 09:43:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMAUq4eysoupUzC0Qd0gCUoJgrPy1Ra4scFXSjChqP9U74P346j0S36AAOF6Sdr6dzciz5zoKRnIWmmKAFniE=
X-Received: by 2002:a05:6512:31d2:b0:507:9797:304d with SMTP id
 j18-20020a05651231d200b005079797304dmr458016lfe.9.1697215436995; Fri, 13 Oct
 2023 09:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696185261.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1696185261.git.dxu@dxuuu.xyz>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 13 Oct 2023 19:43:45 +0300
Message-ID: <CAPMcbCqccA_LYhz08hr4XT3d08jqdFJPmt=WMTn+Nmzhk0cExw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Small fixes for qga
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com
Content-Type: multipart/alternative; boundary="0000000000003ad84c06079bc38b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000003ad84c06079bc38b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged

On Sun, Oct 1, 2023 at 9:39=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:

> These are two small fixes that fell out of [0]. Since we are not moving
> forward with that patchset, I thought it would be good to at least send
> the fixes that came out of it.
>
> See commits for more details.
>
> [0]:
> https://lore.kernel.org/qemu-devel/cover.1695034158.git.dxu@dxuuu.xyz/
>
> Daniel Xu (2):
>   qga: Fix memory leak when output stream is unused
>   qapi: qga: Clarify when out-data and err-data are populated
>
>  qga/commands.c       | 4 ++--
>  qga/qapi-schema.json | 8 +++++---
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> --
> 2.42.0
>
>

--0000000000003ad84c06079bc38b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">merged<br></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Sun, Oct 1, 2023 at 9:39=E2=80=AFPM Daniel Xu=
 &lt;<a href=3D"mailto:dxu@dxuuu.xyz">dxu@dxuuu.xyz</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">These are two small fixe=
s that fell out of [0]. Since we are not moving<br>
forward with that patchset, I thought it would be good to at least send<br>
the fixes that came out of it.<br>
<br>
See commits for more details.<br>
<br>
[0]: <a href=3D"https://lore.kernel.org/qemu-devel/cover.1695034158.git.dxu=
@dxuuu.xyz/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/q=
emu-devel/cover.1695034158.git.dxu@dxuuu.xyz/</a><br>
<br>
Daniel Xu (2):<br>
=C2=A0 qga: Fix memory leak when output stream is unused<br>
=C2=A0 qapi: qga: Clarify when out-data and err-data are populated<br>
<br>
=C2=A0qga/commands.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++--<br>
=C2=A0qga/qapi-schema.json | 8 +++++---<br>
=C2=A02 files changed, 7 insertions(+), 5 deletions(-)<br>
<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div>

--0000000000003ad84c06079bc38b--


