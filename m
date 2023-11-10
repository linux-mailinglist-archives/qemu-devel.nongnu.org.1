Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C31E7E7B86
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 11:56:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1PBE-0003af-Fk; Fri, 10 Nov 2023 05:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1PB8-0003aG-M3
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 05:55:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1PB7-000705-4r
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 05:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699613756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HC6ViVtSZpmTqFoLN1KgicOiJRg6vudC4xOxGgnzFOU=;
 b=ebKeEs6a5jiLg3XKEE/oCuiXnMeATugHbtlrFpRVFlYC/hOdZ1XC2OTtJrNB/f/qKCua0b
 fXliKxdkZ0EQDcVq/ONqibhzaRFRpsaNNWBmHSz6fhb9jUljukSqlbQb4DZ3OJBfJ0aq82
 NsUtLgaXG4WsxVdgfvYD2mZxOX8J06k=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-jxJHfy-DOHy6NhC_q6YENg-1; Fri, 10 Nov 2023 05:55:54 -0500
X-MC-Unique: jxJHfy-DOHy6NhC_q6YENg-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7b9f0314231so605026241.3
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 02:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699613754; x=1700218554;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HC6ViVtSZpmTqFoLN1KgicOiJRg6vudC4xOxGgnzFOU=;
 b=tCpYyM3ixlaWJc3w95UOFY0X4Bt9cgO3oKIuucWXdWzu7CDlBRX8hBxpGBN0P1xhw6
 tPgESuABF4L7ViHs5KBQJjdQrIdVBrOOxts9CloAizHP+W+Hx1VGTl2dfFB9HpIlILYQ
 /n5pxxdFNznq+jh2RN8/OErOZpejL++Kpsr2mPRqvcxCQjFw80YprgbTdC2vbT0vHhwl
 MmgyKIBXvnbPOo4yMJZdfHmu3rfmRir69cOGMptlyPtlle2soRwo0WGmuWzfSxWjibgR
 HAfsoDQgax3UxKT7NrgGgAklcdTNu1nY2wHgv9I5fNyrW+n4ajOSUZexlBUACPEqU1E/
 EpSw==
X-Gm-Message-State: AOJu0YxV9qSHhBqBJGzU83SLVDTAoPbWKI97ZbqlpKK0PBMfCmTG53H6
 eWRoKlv//a9iCBxNSNfrLz7EeIQs7kaAKua8SygTh4zW29XC0BIMX9E56G7yYTj47JUj+u4ffbY
 8vEasK+5Oe0Us8n4rbeJLvVxhPJ2uIec=
X-Received: by 2002:a05:6102:e0c:b0:45f:101c:16d5 with SMTP id
 o12-20020a0561020e0c00b0045f101c16d5mr9787914vst.19.1699613754128; 
 Fri, 10 Nov 2023 02:55:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3FuABxWgVVME1NntmTi8NOGK9oJsG+Gwcs7DF0NMK1jhVvO1EQeGmM+xCEqGqKDKaK4sOG/f8WSoaZm7a+i8=
X-Received: by 2002:a05:6102:e0c:b0:45f:101c:16d5 with SMTP id
 o12-20020a0561020e0c00b0045f101c16d5mr9787896vst.19.1699613753856; Fri, 10
 Nov 2023 02:55:53 -0800 (PST)
MIME-Version: 1.0
References: <20231110093325.917900-1-pbonzini@redhat.com>
 <95788d03-b854-996c-b8e3-981c79a1bb6c@eik.bme.hu>
In-Reply-To: <95788d03-b854-996c-b8e3-981c79a1bb6c@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 10 Nov 2023 11:55:41 +0100
Message-ID: <CABgObfaROkW3f+YNmFLSN5rKX9BW197aPM2gBXPqx+1t34-GkA@mail.gmail.com>
Subject: Re: [PATCH] tests: respect --enable/--disable-download for Avocado
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On Fri, Nov 10, 2023 at 11:00=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu=
> wrote:
> > +if test "$download" =3D "enabled" ; then
> > +    mkvenv_online_flag=3D" --online"
>
> Is leading space before -- intended? It does not seem to matter at usees
> below.

Maybe it's paranoia but I was worried that some shells would mess up
"echo --foo". They did in the past, but it was many years ago.  It would
be useful to add a

print() {
  printf '%s\n' "$*"
}

shell function but this was not the right patch to do it.

Paolo

> Regards,
> BALATON Zolatn
>
> > fi
> >
> > if test "$docs" !=3D "disabled" ; then
> >     if ! $mkvenv ensuregroup \
> > -         $mkvenv_flags \
> > +         $(test "$docs" =3D "enabled" && echo "$mkvenv_online_flag") \
> >          ${source_path}/pythondeps.toml docs;
> >     then
> >         if test "$docs" =3D "enabled" ; then
> > @@ -1631,6 +1631,7 @@ if test "$container" !=3D no; then
> > fi
> > echo "SUBDIRS=3D$subdirs" >> $config_host_mak
> > echo "PYTHON=3D$python" >> $config_host_mak
> > +echo "MKVENV_ENSUREGROUP=3D$mkvenv ensuregroup $mkvenv_online_flag" >>=
 $config_host_mak
> > echo "GENISOIMAGE=3D$genisoimage" >> $config_host_mak
> > echo "MESON=3D$meson" >> $config_host_mak
> > echo "NINJA=3D$ninja" >> $config_host_mak
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index dab1989a071..c9d1674bd07 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -111,7 +111,7 @@ quiet-venv-pip =3D $(quiet-@)$(call quiet-command-r=
un, \
> >
> > $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
> >       $(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
> > -     $(PYTHON) python/scripts/mkvenv.py ensuregroup --online $< avocad=
o
> > +     $(MKVENV_ENSUREGROUP) $< avocado
> >       $(call quiet-command, touch $@)
> >
> > $(TESTS_RESULTS_DIR):
> >
>


