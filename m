Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A6873DB8C
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:38:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDig0-0004rk-E0; Mon, 26 Jun 2023 05:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDifj-0004rJ-Sq
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDifi-0002v5-HN
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687772290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eX8/+mHTPXUo0VjkApxipjdlErCELqUlZimb8rVXppo=;
 b=RkhxLYzdnpSijSphSZ/DV7P15/xPadTd3FOExEzHLkB49oa6Nuv2n9YEFBgryn7ycGyWr6
 TjyL0CimoVwQJo21ILvV84Jb8Jyf2HWgGEAwxt1F9TKtH4rezMWhFm4NLfxr6/ycsvwHac
 gzqMbHRs/k8b/RSraBL/+UfT8WuJXZU=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-EfPldMOyN2SERYpK1_839w-1; Mon, 26 Jun 2023 05:38:08 -0400
X-MC-Unique: EfPldMOyN2SERYpK1_839w-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-78ce07296b4so173228241.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 02:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687772287; x=1690364287;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eX8/+mHTPXUo0VjkApxipjdlErCELqUlZimb8rVXppo=;
 b=Q/jHq4Si8eX1UFu0eCsLcpdebpRotE+c4p41Quoj9f0Rd8tp3VevyzA33wEEeO867a
 G50oP+konaejCDvKdq6gHkNMJtN5cXeqZIORi2x73MeIYJ1hiRDfOor9rFEYqx0soPhL
 roJD2l3lyNSsaaegvpN54O6hrxFn+jg1iwtslITGSHYaLmWwo2BNA/QP/xTs+S86c7/4
 tAPjhVeebRqdYVrmfHJtPVRw2r+eKK4P6TUAqlC02GZBXUeskKCeDSpHyNXliqCkHbPn
 ct3EFQBlRgcAP/QSRFR3ogZrF0so/l+dnWf9LF52BIwYZhyPQ/P4MF8nUx7mpUSjdEYV
 qIeA==
X-Gm-Message-State: AC+VfDzZ6jVZZtG3puD2NY/Ordgk9XBk+ny87cWr2cCJvi0dcraApkz/
 ZqZJ2A84qYQWh9C6CvnrJR7kgS2+xeDxtknynkiAMe7sBommp/hMLa5Aydmuk9ui8pWcmdFvvIh
 n05//qWkLY+rzeO6n1eabGc7yWTe3mIDcgvWRK0U=
X-Received: by 2002:a67:ce91:0:b0:443:5632:66de with SMTP id
 c17-20020a67ce91000000b00443563266demr610492vse.16.1687772287678; 
 Mon, 26 Jun 2023 02:38:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7DZnpB1E4hbTO9q0QKK+qu0F5LWPT2ydxDA3hArtbQJbipA+HacdNIE7V6vC3FXlA5stsrnrVJU+STvQC6qTs=
X-Received: by 2002:a67:ce91:0:b0:443:5632:66de with SMTP id
 c17-20020a67ce91000000b00443563266demr610488vse.16.1687772287392; Mon, 26 Jun
 2023 02:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230626083317.144746-1-pbonzini@redhat.com>
 <ZJlYbXKwd4SxoaxY@redhat.com>
 <CABgObfa2ft-j0CdDyV78awrKu1nowXDSVxeqtQoFG_+qOp=6tw@mail.gmail.com>
 <ZJlcC0Qd7v71yuJm@redhat.com>
In-Reply-To: <ZJlcC0Qd7v71yuJm@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Jun 2023 11:37:54 +0200
Message-ID: <CABgObfZTA+Wbnkfz2WESTKbPjttdOM1DeikZJEYMJjs405tvkw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] target/i386: allow using named CPU modeles with
 user mode emulation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jun 26, 2023 at 11:36=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
> > > If someone wants Nehalem then they should be using qemu-x86_64.
> > > If someone wants qemu-i386 then they should be using an older
> > > named CPU model predating 'lm'.
> >
> > What you write is true for qemu-system-*, but the problem is that
> > qemu-user binaries are only able to run one ELF target. qemu-x86_64 is
> > not able to run i386 binaries, unlike a 64-bit kernel; and that's
> > really intrinsic in the design of qemu-user because implementing
> > multiple ABIs (including multiple definitions of structs and syscall
> > numbers) would require compiling the same files multiple times.
>
> Oh, right, yes, ignore my comment.

By the way it's possible that the above comment would not be true
anymore with the "one binary" work that is going on (though I'm not
sure if that applies to system emulation only). However, the effect on
speed for 32-bit hosts remains true until we ditch them altogether.

Paolo


