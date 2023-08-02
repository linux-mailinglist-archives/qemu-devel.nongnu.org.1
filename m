Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E25AB76CB50
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 12:55:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR9Tv-0004US-A5; Wed, 02 Aug 2023 06:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1qR9Tu-0004UB-9y
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 06:53:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1qR9Ts-0008PO-V5
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 06:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690973608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hVuYJepR8BRVHLs1CQEymotlSnLez8obfV94zNrQpbo=;
 b=QmaP0vJXSxRGMLq2QCFoIGeTpGQ7cO5vcOfezR+phGXJNv/YKP0Lch8gfIVKaQKYkp7r2w
 bZKyh38FPQFDCm8f01qiNZffWbt9oQh43EdEncCOqxl7ECvgq6dt0J8ylNvarCn9Q7ICtb
 SLAht3PNMKxe8Va2AHPbKB+Zw5qzH68=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-jeTQuYHxNx-xiGlE3rhppA-1; Wed, 02 Aug 2023 06:53:26 -0400
X-MC-Unique: jeTQuYHxNx-xiGlE3rhppA-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-48647dd0710so1453082e0c.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 03:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690973606; x=1691578406;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hVuYJepR8BRVHLs1CQEymotlSnLez8obfV94zNrQpbo=;
 b=S8C55qX/yA5fFFIpwZtjfqPdI86Q3JvqBbu96WEZVmQFVtiqx3rB08D3voyP5fHYDJ
 fAsETczyoMQU4LJ7VFXvWIKh9mwJS9wEaE6YbXDzyvdDxdAT7+C/MSKmFJ8OEIQmdxKK
 jhCBXFrnJd0R/Pf+gbB74am4tHCODo4s5OlB5MFeH0cx3dS+WLp3GBusOcXxM4os5Skh
 Caep4aEhjKyVvWBL5FkE5PjAd3uv9NDHqQg+KQswBtg1oO8gUL5sk44J4GB0qBToipqd
 YZFHIC8ei9xllFZBRNo+JBiUBYU9tqpTmGWYtMUxXLNSCP0H9cfDVcVNPZdW01JdFldQ
 j0Xg==
X-Gm-Message-State: ABy/qLYk+Thf5VuBio6btGzDt2zVpOug5DNhfLU8QKSxYwi3EIos7Z3M
 2usvGclS0BvGkhs8YQaU0is4f+Cf5GItvML/XFSdybjuO8/D0y5JtaQO0tlnIOAhyCF+aRsXtJc
 UMAd5xgqmr698mGc0SbWBnVfpdSgebcY=
X-Received: by 2002:a1f:3dc1:0:b0:486:3f56:1786 with SMTP id
 k184-20020a1f3dc1000000b004863f561786mr4718374vka.3.1690973606006; 
 Wed, 02 Aug 2023 03:53:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG+0rrUBpsFRGd0HPZRMI4bz/FAuNOkXa45Ck2Izur+ZOMAm6ckLkUCOW0+aYPoTJ3AvG6C7t+CXMbzilFnykE=
X-Received: by 2002:a1f:3dc1:0:b0:486:3f56:1786 with SMTP id
 k184-20020a1f3dc1000000b004863f561786mr4718368vka.3.1690973605768; Wed, 02
 Aug 2023 03:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230413203051.2344192-1-mjt@msgid.tls.msk.ru>
 <CAPMcbCqDEtMAQdzdryuiwj3afwoj5RCEC+nAhmCi40pF4kG9pw@mail.gmail.com>
 <bc40563e-ac10-3c45-6972-84468324549a@msgid.tls.msk.ru>
In-Reply-To: <bc40563e-ac10-3c45-6972-84468324549a@msgid.tls.msk.ru>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Wed, 2 Aug 2023 12:53:14 +0200
Message-ID: <CAA8xKjWeuqoj=8yvRVC9TMV+f5biEr7YoWZ5OyT5uRh-5LxqdA@mail.gmail.com>
Subject: Re: [PATCH 00/21] Patch Round-up for stable 7.2.2,
 freeze on 2023-04-20
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Michael,

> 13.04.2023 23:50, Konstantin Kostiuk wrote:
> > Hi Michael,
> >
> > You cherry-picked one of my patch qga/win32: Remove change action from MSI installer
> > but it is part of the CVE fix.
> >
> > Please cherry-pick one more patch.
> >
> > Original mail: https://patchew.org/QEMU/20230303192008.109549-1-kkostiuk@redhat.com/
> > <https://patchew.org/QEMU/20230303192008.109549-1-kkostiuk@redhat.com/>
>
> I planned to pick both but somehow ended up with just one.
>
> Thank you very much for this, picked up now!

I do not see the second part of the fix (commit 07ce178a "qga/win32:
Use rundll for VSS installation") in stable-7.2. Has it somehow fallen
through the cracks?

Thanks,

> /mjt
>


--
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


