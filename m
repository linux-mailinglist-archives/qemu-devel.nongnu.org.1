Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 574F87BB11E
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 07:13:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qod7m-0006M3-1d; Fri, 06 Oct 2023 01:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qod7i-0006Id-Us
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 01:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qod7f-0003mW-J5
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 01:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696569094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVP/1yyGc4/jcMQ4P2FpnJg2RxQTM7tIjj30cwKJAjQ=;
 b=aA1zHCZvKeBKiNeJm1e84jnid8PJaq9BwhuDKOtJG/2F/c5dslgDDxiU2Ya/vLJbLFVpzD
 emdmTW0C7vPVnpbPA585V+08ACBu64mkhoz2SQ9DV+mj3R0Ei11wewdhYpYAFrsS9kHekI
 32OMH73tzsjbv7Ubh3H1TIjF0zZy9Yk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-LigBRkeWNquKfRccyAntJA-1; Fri, 06 Oct 2023 01:11:18 -0400
X-MC-Unique: LigBRkeWNquKfRccyAntJA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5344aaf2703so1437417a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 22:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696569077; x=1697173877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LVP/1yyGc4/jcMQ4P2FpnJg2RxQTM7tIjj30cwKJAjQ=;
 b=DRxcrULm0EftDPqHpvU6+PwiWcY1Rk+eGMr7ZvY8yteq4sY1qfdcFaFcGLjX1rLPVu
 BSUxAtTIwv2NFGZh6q1kah5CRvIqjC9zd9Taje98pNGOBfcYwfMdO3f3LjtURhQBb8Kv
 69KmsGY7Ul1iQFLvFOZrVN2D0vll8wigDNV4qznTQkai5FqQkEG6gIl9IqKeB3gHSwiC
 B7JkJxzy3p7aRFRwhJbVXtwXhRu2Yiw92250X9GykYjiu71yAjApn494gs5hthSdVjp2
 v8pB1A2F+p47KxbRzAl1qmYevc6QVOADtaNnyJ00vg61FryT3HdHVC65/OsVKwE0TiF/
 Hr5g==
X-Gm-Message-State: AOJu0YzjW4pOJpoFy/jTzqt8u/MPCSHAuDbC7PdDfa6qsU/a9PchC4Hz
 Fz1i+lnF58/4FPqjoVKxXdN+cjjU54brE5KsUEktKOJNVWAWIGHRQXJ1arcnNc6R17YVL2rVCvM
 dBGw2Y20hbFH7Oj6HWOXd7q/PlHuScWY=
X-Received: by 2002:a05:6402:134d:b0:525:6661:dc90 with SMTP id
 y13-20020a056402134d00b005256661dc90mr5927133edw.25.1696569077008; 
 Thu, 05 Oct 2023 22:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX+dpvMa7zA5ekz/+xE+1TQN4tx2QuHtzIiLc8lN/yXKkRFBnYiQqoI9InLw98WY77nGquUfFz5pVafT5t54M=
X-Received: by 2002:a05:6402:134d:b0:525:6661:dc90 with SMTP id
 y13-20020a056402134d00b005256661dc90mr5927126edw.25.1696569076754; Thu, 05
 Oct 2023 22:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231006045256.395696-1-thuth@redhat.com>
In-Reply-To: <20231006045256.395696-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 6 Oct 2023 09:11:04 +0400
Message-ID: <CAMxuvayYOu6ikkWV9PZsjwLd+=AWBnjrbcaV=Kqeo9_MnqzU_Q@mail.gmail.com>
Subject: Re: [PATCH] scripts/xml-preprocess: Make sure this script is invoked
 via the right Python
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 6, 2023 at 8:53=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote=
:
>
> If a script is executable and has a shebang line, Meson treats it as
> a normal executable, so that this script here is run via the "python3"
> binary in the $PATH. However, "python3" might not be in the $PATH at
> all, or it might be a wrong version, so we should make sure to run
> this script via the Python version that has been chosen for the QEMU
> build process. The best way to do this is to remove the executable bit
> from the access mode bits. (See also commit 4b424c757188f7a4)
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1918
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

thanks

> ---
>  scripts/xml-preprocess.py | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100755 =3D> 100644 scripts/xml-preprocess.py
>
> diff --git a/scripts/xml-preprocess.py b/scripts/xml-preprocess.py
> old mode 100755
> new mode 100644
> --
> 2.41.0
>


