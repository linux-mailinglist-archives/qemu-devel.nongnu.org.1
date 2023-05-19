Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9037093D6
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwbD-0007Bf-RC; Fri, 19 May 2023 05:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzwbB-0007BA-A7
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzwb9-0007KH-NX
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684489230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZGgVYN47MlADJxwCDbKhu3cWwXO+cXZGL4Db8KNAS4k=;
 b=E8LotmrOAFY9kgropqKNtrlCsM8K/8DyOFpxd36xBKl36SIMdxOrHaN1DsCKTRZMF3G99z
 f53k2vgFUdoJV95b8+11ofQ6liNpS5VBLcU0ec6JqE42yF3lMVKggko35IGpT3FfegAkZL
 CRyj/yB5eC+8HIAfBGJOEx4fhNcDDqI=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-dtfqgCb7PEaV2U3rT8ES5w-1; Fri, 19 May 2023 05:40:29 -0400
X-MC-Unique: dtfqgCb7PEaV2U3rT8ES5w-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-780e23ab096so990663241.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 02:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684489229; x=1687081229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZGgVYN47MlADJxwCDbKhu3cWwXO+cXZGL4Db8KNAS4k=;
 b=G8sKROuFOU97eh9A3Fj+2JlVWPS+iY2KYe1paJt1eUeOF5kqGm2nX/ud+u76YDFZ4v
 BSJXIq012tJVdPOPPIjhXFyeVqIscB6rzJ0nbgLQ4wch1WgcSdKC8CGr7kmZcaG9LQRO
 7b1eF3oMxa+kz9fzcLshKhNkUD4fP9mYismEvGyPGgfDBtHMPqpRNCsLK+FlHlixMGiA
 QCWKjvhbu0P6qGUW7iTOtl9FPB6ezxowLfBTOExvRk1EBTpzzW6v+hH6ucQu0yPgQnul
 dYYzc7CWhg/syZUvaPguQ/Zhobt/ZXbFPwUMEJPmxBCriuAICHJYdZnU9pNdXLEACRfS
 oSaA==
X-Gm-Message-State: AC+VfDzbDBUNWBpCmwZ9peA6nHWnBxOnyl+imhnNOyQ1oZQceilv7pGc
 AjidpzN+Z9f5YNuElt/ovD1Qi3gYRblnj/5oDRcEJANW7AYtOze70cmrWOvAjc+R112obLj7wHl
 ke5L1HIeNIVIpKP86P6ImEZa8JJnVKPHBQpm4N6A=
X-Received: by 2002:a05:6102:2459:b0:436:120:c91f with SMTP id
 g25-20020a056102245900b004360120c91fmr454104vss.4.1684489228786; 
 Fri, 19 May 2023 02:40:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Jr8Np96qjurgukmsWH9bRkBgcUJxKssnUrJJYBKYwK85nPSGAxqAJ9dxF/P9e/xKDYTMSQ/K99TUNj7K2UYc=
X-Received: by 2002:a05:6102:2459:b0:436:120:c91f with SMTP id
 g25-20020a056102245900b004360120c91fmr454097vss.4.1684489228549; Fri, 19 May
 2023 02:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230519085647.1104775-1-pbonzini@redhat.com>
 <CAFEAcA-nMG_5u4pADASoQNF_MCCXHMCB3APTtVLohzTzCmJ3cQ@mail.gmail.com>
 <ZGdCL3Ka2JSeo+XD@redhat.com>
In-Reply-To: <ZGdCL3Ka2JSeo+XD@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 May 2023 11:40:16 +0200
Message-ID: <CABgObfbtWuRmma2fynUV=O3wexz4TBTfG4CxaDyR7VeA7mDkMg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] meson: use subprojects for bundled projects
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 marcandre.lureau@redhat.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 19, 2023 at 11:32=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
> Maybe we can none the less wire up libvirt-ci into wrap, or alternatively
> since its python, could we make our new venv setup tools put libvirt-ci
> into the venv ?

libvirt-ci is used from the source tree so I think it doesn't even fit
into the venv. It's not unlike the roms.

> Paolo mentioned the float stuff as future work, but not sure what his
> plans are specifically?

No plans in particular---after all the whole meson conversion was like
"let's try to find a day every month to proceed", and these two
submodules are not particularly big. I know it's doable but I heard
there were plans of embedding it too, so I left it aside and focused
on the more interesting ones.

Paolo

> Feels like we should be able to figure out some way to get rid of all
> the submodules though, except for the roms, which are special and ok to
> leave IMHO
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


