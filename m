Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFC77B5CA8
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 23:50:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnQmf-0006OH-6P; Mon, 02 Oct 2023 17:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qnQme-0006O9-6f
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qnQmc-0007Jb-Nh
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696283331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNo1DHIFHykuJKq/yL78fXBv1AJXmWXgR2n/oFzO3zg=;
 b=agWFuuGrNz9xWlpNzAzQODI4NcPoX2EiUFYzjzDdhel532Df6gcdZtBvSHED4ZZKRHxazp
 WPBND2r6/5dBXaqIsLhH1CpyKttnxHpSZhVFwpsxhW6ZQvJRGDR2UtrKj8mwOBYkJILWhu
 X9WOYonM78ygtJ4T14qwTFfPx/FIwwo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-eTkuWfrMPQ--rVWsnr-npg-1; Mon, 02 Oct 2023 17:48:49 -0400
X-MC-Unique: eTkuWfrMPQ--rVWsnr-npg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-27779f49458so242360a91.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 14:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696283329; x=1696888129;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XNo1DHIFHykuJKq/yL78fXBv1AJXmWXgR2n/oFzO3zg=;
 b=ZnRj6pIPSZjaslb+34PVw+awExPA/RRmDpMrthMhwa+iolmkkekIpKCKdbpv9ssjXx
 qvcqWji4x2uGsNqM8fPyLHK7kiXmf9dQb1oIUeJTVpn62MufuP7ZPoccQnqRDGuZ4G62
 yEUS2ewhZrdPEWu3xBagxn6TbKdbgJzE/rf7wPPaGJjrqmmpovMf/XLlvY5guFM6+UCp
 c1Ofv+nNhwJLG+obSCHmGNojaJYfgILQeBpwv4b7NvU8nagoLioaYluf7ETrTYXEFwjy
 6AL/nIs486grIS+Qs1eORTm/SK8kkhe9L8ndGSq23OFWGCpcJ3YhAIkr2Jb2UxjFOiNt
 FAFA==
X-Gm-Message-State: AOJu0Yz52tPxNHgWYA3RHQD4s96ZKeHrJR0NO1o2akPTcjPe1vXz+TIU
 l24WLBjNZkaU+28XdZEDAAiXjYc3qdzpiJqt5To8aGb6ccImwCl2hTUTzXHcFBfIZtFAppiSlCB
 h1c2brYEDZOmQWjzqrL6COEXt1Xm2HJQ=
X-Received: by 2002:a17:90a:17c5:b0:274:87e8:7ce1 with SMTP id
 q63-20020a17090a17c500b0027487e87ce1mr12312843pja.39.1696283328791; 
 Mon, 02 Oct 2023 14:48:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3tulIsAn/k2uiLyz8NxyDQhYdfwGqfkBMBMeXXEf49wdS0PL2UMaLnkxxayKNA8NGdf5Sfb0zt6Rket/vUJs=
X-Received: by 2002:a17:90a:17c5:b0:274:87e8:7ce1 with SMTP id
 q63-20020a17090a17c500b0027487e87ce1mr12312830pja.39.1696283328478; Mon, 02
 Oct 2023 14:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-3-victortoso@redhat.com>
 <ZRWTBpWn4m3rrGMZ@redhat.com>
 <b6kkamv3owggxi4vthdrqxrlcplbykp5cnnb7lihll7buv5kda@py5hclv6oqjc>
 <ZRbE7tlQaWAn+nwP@redhat.com>
In-Reply-To: <ZRbE7tlQaWAn+nwP@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 2 Oct 2023 17:48:37 -0400
Message-ID: <CAFn=p-ay5kGcj+nbakBTDbxSDwGg29zrSNwp2kFft7aaMgq5Hg@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] qapi: golang: Generate qapi's alternate types in Go
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Victor Toso <victortoso@redhat.com>, qemu-devel@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

On Fri, Sep 29, 2023 at 8:37=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Sep 29, 2023 at 02:23:22PM +0200, Victor Toso wrote:
> > Hi,
> >
> > On Thu, Sep 28, 2023 at 03:51:50PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > > On Wed, Sep 27, 2023 at 01:25:37PM +0200, Victor Toso wrote:
> > > > This patch handles QAPI alternate types and generates data structur=
es
> > > > in Go that handles it.
> > >
> > > This file (and most others) needs some imports added.
> > > I found the following to be required in order to
> > > actually compile this:
> >
> > This was by design, I mean, my preference. I decided that the
> > generator should output correct but not necessarly
> > formatted/buildable Go code. The consumer should still use
> > gofmt/goimports.
> >
> > Do you think we should do this in QEMU? What about extra
> > dependencies in QEMU with go binaries?
>
> IMHO the generator should be omitting well formatted and buildable
> code, otherwise we need to wrap the generator in a second generator
> to do the extra missing bits.
>

Unless there's some consideration I'm unaware of, I think I agree with
Dan here - I don't *think* there's a reason to need to do this in two
layers, unless there's some tool that magically fixes/handles
dependencies that you want to leverage as part of the pipeline here.


