Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A85709BD9
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:59:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q02VC-00047R-Sw; Fri, 19 May 2023 11:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q02V1-00043g-E5
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q02Uz-0003ML-9r
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684511908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjsuahXn1AG93Q8GsdhDVRDcw7mrbZe+PxTUQ3pRoDE=;
 b=iw752jZMinZ91Vhr9r9E+kigWYMvfu0Hm7cD3u3SGu2mDNd/9qIVUGNj82aGgrDKae2N20
 iANKQRu2KE21Sk9HnVH/OdAW4ezqdzio0EL95IoWZSrlCbEn18GWdJbcH5zJNWfg8XXtj8
 Guh94WJde3giFRqYkHoHj+UvHNjJnz4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-zZEKn8A1PLepYl2oEFuxmw-1; Fri, 19 May 2023 11:58:27 -0400
X-MC-Unique: zZEKn8A1PLepYl2oEFuxmw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-24dfafd26cbso3427745a91.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684511906; x=1687103906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hjsuahXn1AG93Q8GsdhDVRDcw7mrbZe+PxTUQ3pRoDE=;
 b=iNsqGFl/dvRCNrir2JgCjcz/BAr2wsHkrFbOlwSG2cH5XSV07+Z6pclJlTAmL1ayhG
 xGoePsL/MEwY2iuq8J2fEaFc3GvouWA+EiPersF01eolfpFAmSnfyH1Zmi21zcP5WfPf
 5nCAk74CqYIvLbmp+oEEGV9EAQb9/1GdpToBjKq6b6N8sTOUOU9ykw4NOPFxeFzNoilk
 W4CN6cQnio909nuNcTmhQ1AVfKJeyLvvYODwOVsXBAUIXb02kfNaIahTgwlXX4NtzEZH
 5jdFGmAo3DiIwlYC+etrzvQMTE896CAv94HRtdg38fV88uoQaaA8l0i/wr9Zhxa0tnLH
 zoJg==
X-Gm-Message-State: AC+VfDyOUkgSXkSgGVqmdkqClSz3dwyrBqH78A4WqjksGx0nOxDFh7JI
 ztlsEJ1o5npaqI8plxt3pECcQ/gvZ9aT0RJxqMmMCIRO6XnpdEsZTfdHHdxLJ8Rz/90FX8A/IMb
 iJiSDquVx45SFKyEscrgpU+uLRWNWGx0=
X-Received: by 2002:a17:90a:898f:b0:253:35aa:1378 with SMTP id
 v15-20020a17090a898f00b0025335aa1378mr2274663pjn.35.1684511906687; 
 Fri, 19 May 2023 08:58:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4aYgUaInbVH188cBVuj8N57B8tev30C2PoMZJUMJRoyJXT5bOXNBDhwfTnF7dWRjRnWkxmMfuxU1vxJC9DluU=
X-Received: by 2002:a17:90a:898f:b0:253:35aa:1378 with SMTP id
 v15-20020a17090a898f00b0025335aa1378mr2274653pjn.35.1684511906399; Fri, 19
 May 2023 08:58:26 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 May 2023 08:58:25 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20230425102545.162888-1-sunilvl@ventanamicro.com>
 <b520d913-27a9-dea5-53c8-af1cdd967ab2@canonical.com>
 <ZFiRr8d2zyAJlZJv@sunil-laptop>
 <CABJz62OTBEOMzcXLYc=DqRwH8N4DP=o0-kCfALwoREZVyOxLPg@mail.gmail.com>
 <ZFjbwh3CdljaHEZZ@sunil-laptop>
 <CABJz62P3u0d-ggQw-B_6AYTNu8Z9-TOs+UOn2vM8NNV0mQKR+Q@mail.gmail.com>
 <CAKmqyKMDf3F67=_Dq8oFOGG3Ft9hszfB6J2-U9DmSSvK0YKkMg@mail.gmail.com>
 <CABJz62OyYei7DtukTGsKA8oaRBewUR4nwZxx_8ONc0fKkZDuPQ@mail.gmail.com>
 <CAKmqyKMdtMLDxb8oO_EANODOxvdf2WUR-cSoog5BV1ib7SQ2zQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMdtMLDxb8oO_EANODOxvdf2WUR-cSoog5BV1ib7SQ2zQ@mail.gmail.com>
Date: Fri, 19 May 2023 08:58:25 -0700
Message-ID: <CABJz62PUDsOt1TK6z=-cCGDjFraKjS+yFEfCC_VmGWAG=hhq1g@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv: virt: Assume M-mode FW in pflash0 only when
 "-bios none"
To: Alistair Francis <alistair23@gmail.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, May 18, 2023 at 02:53:05PM +1000, Alistair Francis wrote:
> On Wed, May 17, 2023 at 6:45=E2=80=AFPM Andrea Bolognani <abologna@redhat=
.com> wrote:
> > On Wed, May 17, 2023 at 02:57:12PM +1000, Alistair Francis wrote:
> At one point we loaded Oreboot in in flash and booted from that. I
> think Oreboot then loaded OpenSBI into memory. The idea was to mimic
> what a physical board would do, so we could allow testing.
>
> It doesn't look like it's used any more.
>
> > Either way, assuming that there's a genuine reason why pflash must be
> > used, I think the behavior implemented in v1 (pflash0 is M-mode when
> > -bios none is used, S-mode otherwise) maps very well conceptually,
> > and results in behavior matching that of other architectures out of
> > the box. That's good enough for me :) I was just wondering whether we
> > could keep things even simpler.
>
> I don't see a reason to remove the boot from pflash if no -bios
> argument is supplied. If there is a good reason to, I think we can
> (via deprecation) but the current functionality seems fine to me.

Aligning with other architectures.

In the short term, we cause some minor pain to existing users,
although as noted above for the oreboot case there might not even be
any people still depending on this functionality at this point.

In the long run, we guarantee smooth operation across the stack by
not being different for being different's sake (e.g. requiring
pflash0 and pflash1 to be swapped compared to x86 and Arm, which is a
configuration that falls outside what can be described by the
firmware.json standard and thus can't be automatically applied by
libvirt).

--=20
Andrea Bolognani / Red Hat / Virtualization


