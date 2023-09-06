Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E41793A8D
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 13:01:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdqH8-0002em-TS; Wed, 06 Sep 2023 07:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdqH7-0002eT-Bw
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 07:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdqH2-0001d6-GI
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 07:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693998038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jW5NboON/sBt4qhdphcskFFj7m6AhgAMih/indWa/c=;
 b=VbRIAett6yNxgp4j1TH3lMJCOx2TatcRdmFMUM36C8/90fzuJm900rKyNxHTBdtSIi1z7y
 371b7Wcdq90Er4wnNdoC7hDDn6Vp47PCGrwgRB2eXWT0PwylRZZYZXUwmA4ob5IVsTNnl4
 /xzE28XZ1WWAT5TQADSCX/7rYmCFQns=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-FOorD1_ZMhCnuIo_YeiJvA-1; Wed, 06 Sep 2023 07:00:36 -0400
X-MC-Unique: FOorD1_ZMhCnuIo_YeiJvA-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7a2627791d4so788556241.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 04:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693998036; x=1694602836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8jW5NboON/sBt4qhdphcskFFj7m6AhgAMih/indWa/c=;
 b=g0+baN6Wn5XhMdhsoLWl9nFUoBdkK72CnLIXdhEZlsD3Kc1Gf+xt7tv8sguihklmO4
 hcWSeq8Ow4N2Aa+Op92dgCcb0VeKI+7lCrsfOgSUV86igrwMVPylP/PkDIQYPuIsK+2r
 OhUzylOugzkIfKRTpgVuXlt00pbl/KganfWuvW2WQQ4IuWzW+uUZB2gs4FAEiiSSB5kC
 oAjUsdt5z6NZtnD4DUjAkKo3q/KtmQsnWv3M0gUV6/mi1mJ7+skswP5LJKRmp+EKo8Ov
 pnf9aXLeN9MwZzwua/rHFDllKa++Yy0LOjNeTgChWYigefNmcSh7ZmUKdk4DHXiCGBhI
 d7Xw==
X-Gm-Message-State: AOJu0Ywc5EWU2S+sN41EJC3EkKrsm7WQ2l1ksrZQd03KacPBbu403gUz
 WK8hksqnaXdF+YbV+YSX1nAaPCCoJcHfU6SNAcnI11HytBgXlrZEb3F1iF4Wgtja9BXK0w1gfv0
 Voci52PVmJ2Mut/jB+L8HavqufeqXv3E=
X-Received: by 2002:a05:6102:7b7:b0:44e:a3e9:68d4 with SMTP id
 x23-20020a05610207b700b0044ea3e968d4mr2215627vsg.30.1693998036169; 
 Wed, 06 Sep 2023 04:00:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE8si+Sr/TLA3qpscNz2A71xJqxCMRc/TiXZtVlMe6kTOUl+m0z9PktW8MDSWkpaIuQHD98if3FTGGWpyamrw=
X-Received: by 2002:a05:6102:7b7:b0:44e:a3e9:68d4 with SMTP id
 x23-20020a05610207b700b0044ea3e968d4mr2215619vsg.30.1693998035931; Wed, 06
 Sep 2023 04:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-66-marcandre.lureau@redhat.com>
 <cb0e2856-afdc-294b-d111-28be168eeed2@eik.bme.hu>
 <CAJ+F1CLxP7-8AS-4zSNLYtNVX_ZgR1rEBHzxgmCv3oJOiNU22g@mail.gmail.com>
In-Reply-To: <CAJ+F1CLxP7-8AS-4zSNLYtNVX_ZgR1rEBHzxgmCv3oJOiNU22g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 6 Sep 2023 13:00:24 +0200
Message-ID: <CABgObfYM02WRf4Q-JFCd5bRMo29tbnN-63NOXGtRKRe=3MPiEQ@mail.gmail.com>
Subject: Re: [PATCH 65/67] ppc/kconfig: make SAM460EX depend on PPC & PIXMAN
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 5, 2023 at 10:07=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> Indeed, and it is disabled not by Kconfig but by meson:
> system_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true:
> files('ati.c', 'ati_2d.c', 'ati_dbg.c'))

It's better to add a "depends on", so that it fails to compile with
--disable-pixman.  Without it, you're left with possible runtime
failures where boards expect ATI_VGA to be there.

Paolo


