Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 520A27B2FC7
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 12:12:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmAS7-00043g-Ui; Fri, 29 Sep 2023 06:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1qmAS5-00041y-Dj
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 06:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1qmAS3-0007Uj-RQ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 06:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695982225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AmW8J85dENOAgEDN98oOAMNFnCixUejLydCPc+GbG3c=;
 b=DffnLZPYGtjrAi3uF88ecCYPz6jzzs+fj8tujT71CQv8gsFEc36NDgR6QVuNdpOHQHLHuF
 GapC42fkSeauj/PS0wvZQ6YLYbjaOej80TAOuBRdqi3MuSW+Wy0DnyEPpnjTbuTvQ0uJbV
 wjKqDe+Umo11Aiw76BoQygDdsbuQWBg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-nXxkpJhyO9iyhiRw3vtksA-1; Fri, 29 Sep 2023 06:10:24 -0400
X-MC-Unique: nXxkpJhyO9iyhiRw3vtksA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4197fa36adaso3014321cf.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 03:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695982223; x=1696587023;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AmW8J85dENOAgEDN98oOAMNFnCixUejLydCPc+GbG3c=;
 b=N/D0u5Sl99jp0XSXAJWbZRQb8kyENjXAUDL4dXXksksgHl0g+Fd5rwA2guGq/EtmmU
 2fEAYO9Wu1y4doKRm1B5ss2oVpKm8AzjKzfz9PebdskH08ElBZ83akK1Zn7Fd5q4erV8
 XpLE6Gdqv93dLpsHiAQkw2+YuT01Rrgm07zLpBn+4f1LK7QWHIePWqPK2jR6OOyZU+2m
 MrTR5tRwxoO3VM4/PIDsV5ph8wyiCigmolrFJFWZ/HtZdrmHlOmAm1ecSAOr0ce7upxQ
 Bbkgi9UU/leK+V73+TM9UaL1IyEuQfvrSQKFQK1hH3Dy3NfbhBMNTl1n0EoLPc+UXdfb
 TRuw==
X-Gm-Message-State: AOJu0Yw6lVJxddb7QB10R8RgQvwKcE1qBvw5U7P3Ay4UDGJAsoNlPw95
 jsTRloVuIJIfcEtlF+R4+GmstnwsMLgwVADlX3z4bOhCwD2NRdiPzpu65J8UyH6HLIefm7xbt3H
 HcyWAkvqhW1XFwZ0OTxfb/mjgZHK6Gvw=
X-Received: by 2002:ac8:5c15:0:b0:417:974f:5619 with SMTP id
 i21-20020ac85c15000000b00417974f5619mr3925863qti.68.1695982223520; 
 Fri, 29 Sep 2023 03:10:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMqtlgfRoQb+JKnv7VH1zy/ZAkYDdiQ+eTWqfyJRTVDSty4jVOK2Kw8mNQE4NmAP1E1wRtqpR6w/D31D0p0qU=
X-Received: by 2002:ac8:5c15:0:b0:417:974f:5619 with SMTP id
 i21-20020ac85c15000000b00417974f5619mr3925848qti.68.1695982223218; Fri, 29
 Sep 2023 03:10:23 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 29 Sep 2023 03:10:22 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20230926194951.183767-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
In-Reply-To: <20230926194951.183767-1-dbarboza@ventanamicro.com>
Date: Fri, 29 Sep 2023 03:10:22 -0700
Message-ID: <CABJz62N_czR3BneV0iqxMfce_V0V7zVvyAe-r62cOsT13-mCrQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] riscv: RVA22U64 profile support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 26, 2023 at 04:49:44PM -0300, Daniel Henrique Barboza wrote:
> Based-on: 20230926183109.165878-1-dbarboza@ventanamicro.com
> ("[PATCH 0/2] riscv: add extension properties for all cpus")
>
> Hi,
>
> These patches implements the base profile support for qemu-riscv and the
> first profile, RVA22U64.
>
> As discussed in this thread [1] we're aiming for a flag that enables all
> mandatory extensions of a profile. Optional extensions were left behind
> and must be enabled by hand if desired. Since this is the first profile
> we're adding, we'll need to add the base framework as well.
>
> The RVA22U64 profile was chosen because qemu-riscv implements all its
> extensions, both mandatory and optional. That includes 'zicntr' and
> 'zihpm', which we support for awhile but aren't adverting to userspace.
>
> Other design decisions made:
>
> - disabling a profile flag does nothing, i.e. we won't mass disable
>   mandatory extensions of the rva22U64 profile if the user sets
>   rva22u64=false;

Wouldn't it make more sense to error out when this is requested?

Silently ignoring an explicit request made by the user is pretty much
never a good idea in my experience.

-- 
Andrea Bolognani / Red Hat / Virtualization


