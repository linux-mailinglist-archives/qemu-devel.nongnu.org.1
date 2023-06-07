Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB399725A54
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 11:27:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6pRb-00047z-UC; Wed, 07 Jun 2023 05:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6pRY-00047b-7f
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6pRI-0003l3-Sf
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686130008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XaRFo6R3K024Gv6B8gdhMrTECP1g7P8XX+H3Ll9MpPM=;
 b=ExicqDJkE0if02GvGBTr9r+iHOHRXlSkl0On1akGuUBTCbrE9Gffnn4ZUEqng/F0iUyjPQ
 GDQrT230RR3aWXgsa7ybqt4Jx5cccSpr5h5jWj3AwhZHV/k0cRgT+YOuGSw1peOIQTmRBk
 jrzMyRruadgsQRrXLf07kyUX9qIhy6E=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-B3U5tdKQOEKvYMV28xU3Xg-1; Wed, 07 Jun 2023 05:26:47 -0400
X-MC-Unique: B3U5tdKQOEKvYMV28xU3Xg-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-45e95f53dfbso1066676e0c.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 02:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686130006; x=1688722006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XaRFo6R3K024Gv6B8gdhMrTECP1g7P8XX+H3Ll9MpPM=;
 b=B/cyp5uPEmzZ7Hb4PmEa4Dmext6nHiucC8qQwZeaKAEWR2j8hMnitS1C40pcWhOFpS
 xdPeF33c1v59Na7az3kT3ABtgk3zxjwYybpix0xZjQT0o5v+WtRrJ1d0bk+Fjb+qQU03
 uvJVVeo0Th0bORh4uLMt/zUF82UlfmRwnowBcI7t9gsu8Drb+0/nwlfGuXyZjiY2YuwY
 0HJiLfUZUbQHpq0qSlp86XJyutknoalkAMchV2F8/Zntuk44qru4bNgz/WHdFcW1eMGE
 QteduaafwRGN4HSJd5Lk/9a22O48M1NYH6pkBtCg4hwGg+ck2/p4vMe8cHZ8nrlvnOip
 RY2A==
X-Gm-Message-State: AC+VfDwbXsyKpNvW1idFXxDDD5Uh96qgnguegK9sci7BPlGN3/JcB7V8
 jQwDdaxX1QwvZ65O+eF67cdbNKL/URwdXAL8iLU4CDBXiew5TAWxsTqc7Y+XGsoN6hDhXgdsyGy
 eV4AzJPVe+UmOMcZhqAYhk9X/SjhnHKE=
X-Received: by 2002:a05:6102:21b:b0:439:6a84:a396 with SMTP id
 z27-20020a056102021b00b004396a84a396mr747564vsp.33.1686130006648; 
 Wed, 07 Jun 2023 02:26:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5EgmqMo96n1CNLDYZvyx8G2yzzNk+5wFpmTaOZZtrO066y+xaHBrz17VVLC8RUcgOHtaePcClSwTWkFkKpsAY=
X-Received: by 2002:a05:6102:21b:b0:439:6a84:a396 with SMTP id
 z27-20020a056102021b00b004396a84a396mr747562vsp.33.1686130006344; Wed, 07 Jun
 2023 02:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230607090336.59424-1-pbonzini@redhat.com>
 <f1c785b1-beac-55e1-7da9-d9a5f1ab77ff@linaro.org>
In-Reply-To: <f1c785b1-beac-55e1-7da9-d9a5f1ab77ff@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 7 Jun 2023 11:26:35 +0200
Message-ID: <CABgObfYJA=K0TXZP4tqaHrTG4N+nsFCOJsvLNM3-mXWsVY84cA@mail.gmail.com>
Subject: Re: [PATCH] meson: fix "static build" entry in summary
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 7, 2023 at 11:09=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 7/6/23 11:03, Paolo Bonzini wrote:
> > Fixes: a0cbd2e8496 ("meson: use prefer_static option", 2023-05-18)
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   meson.build | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/meson.build b/meson.build
> > index 553c8e0b9c5..34d0444ffbb 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -4088,7 +4088,7 @@ summary_info +=3D {'QEMU_LDFLAGS':      ' '.join(=
qemu_ldflags)}
> >   summary_info +=3D {'profiler':          get_option('profiler')}
> >   summary_info +=3D {'link-time optimization (LTO)': get_option('b_lto'=
)}
> >   summary_info +=3D {'PIE':               get_option('b_pie')}
> > -summary_info +=3D {'static build':      config_host.has_key('CONFIG_ST=
ATIC')}
> > +summary_info +=3D {'static build':      get_optin('prefer_static')}
>
> Typo 'get_option'.

Yeah, sent after testing but before committing the obvious fix. :(

Paolo

> >   summary_info +=3D {'malloc trim support': has_malloc_trim}
> >   summary_info +=3D {'membarrier':        have_membarrier}
> >   summary_info +=3D {'debug graph lock':  get_option('debug_graph_lock'=
)}
>


