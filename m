Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A12F4716088
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:52:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yow-0008AT-RP; Tue, 30 May 2023 08:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q3you-0008AJ-O9
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q3yot-00078B-AB
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685451082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dyR8bxYI0n+yVBfY+3U+fiZBpZPQmo9Zl75X2D+GeHU=;
 b=PRcAMP3id1pVstUR4jfXP5lELM7Ntm7PV9n08VnCkO6aW1wDbgUNp3Eih1jQGFIsNVEc4X
 /ObcMnhsccfyARGndXlpQU6+CQOzfTWInr9v/IftRRbyoEG2eE8X/CwXgD8x0U/8WEDels
 Rn/UXjD5v/+JT3dKenOk508FO1x5wRU=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-fXGDKvLeNYyAXEVn03eGEQ-1; Tue, 30 May 2023 08:51:19 -0400
X-MC-Unique: fXGDKvLeNYyAXEVn03eGEQ-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-43943014d7eso3706152137.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685451079; x=1688043079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dyR8bxYI0n+yVBfY+3U+fiZBpZPQmo9Zl75X2D+GeHU=;
 b=Wyyr7JNQFiOU66cA6e5nrxDQ7xRol546YFSJ6i1qqTKI2KtzJznNMfXgBigs7viCZA
 DoFGJKyga+2/rIVCytH+V68VRLQDYIQPeHvdE+WMz49PM3Pffhp+gxg2bkFx3CN1rf45
 ka6CsCQ8yXa+fykk2hFfw0SHB9VFEEomPOUpGglbtn3O6dRz3qlF8d1Yognpj1/TklKM
 XU25ER1rcXTyXxzy7sAukVeGrERZ8a6IypPkF0GkmzNM7jvamdvNWEH9kEZWw3g1HO7q
 l3ktZWoFZ5RfSHRittCU1RwasAWLhvnKraXt+SEN3ripl8WgX8kMNtAHx9Jh/eBvGx6t
 cq2Q==
X-Gm-Message-State: AC+VfDw36AJsAaf6yOpw3GcCbEizsdysd3Lzx2+QAt5HdWE06LcwZlsZ
 isUgWu0bRq4TB0ZBoCE3TxQhLV+uqjPBF0AvEZVHvTWxbn4kx7Xh7fcfimDaw46hpsuxL+U0lYh
 uCsS/EMRbka1oWFl1eGTTxT2SPmT2dM0=
X-Received: by 2002:a05:6102:e13:b0:434:c512:99d2 with SMTP id
 o19-20020a0561020e1300b00434c51299d2mr3764891vst.4.1685451078890; 
 Tue, 30 May 2023 05:51:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7V/MNMkxZCsw4TxoXCcgTNk/McIInMqVZg9c4EJW3Ny6DAfGFqpQTej1BGwnlRHartPnxubCxqFjjW66BdGPA=
X-Received: by 2002:a05:6102:e13:b0:434:c512:99d2 with SMTP id
 o19-20020a0561020e1300b00434c51299d2mr3764886vst.4.1685451078626; Tue, 30 May
 2023 05:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230527092851.705884-1-pbonzini@redhat.com>
 <20230527092851.705884-4-pbonzini@redhat.com>
 <ZHXq3fDd14O9yIcA@redhat.com>
In-Reply-To: <ZHXq3fDd14O9yIcA@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 May 2023 14:51:07 +0200
Message-ID: <CABgObfYkohfVakNq377LF8ZXmNhYEm69_ad48Ew6rmsiVo=Okw@mail.gmail.com>
Subject: Re: [PATCH 3/5] meson: subprojects: replace submodules with wrap files
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

On Tue, May 30, 2023 at 2:24=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> > +    if test -e "$source_path/.git"; then
> > +        echo "--disable-download specified but subprojects were not"
> > +        echo "checked out.  Please download subprojects."
>
> Building from tarball will be ok as we bundle everything affected. This
> errror will hit anyone building from git with --disable-download though.

Right, just like it hits people doing --with-git-submodule=3Dignore; but
you're right that --disable-download is more generic and therefore
this error is more likely to happen.

> How should developers/users download the subprojects ? Can we tell them
> what command is needed ?

For those that want to use --disable-download, I can include "meson
subprojects download" in the error message, e.g "Please invoke "meson
subprojects download" before configuring QEMU, or remove
--disable-download from the command line."

Paolo


