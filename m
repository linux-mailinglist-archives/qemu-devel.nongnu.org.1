Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB898364CD
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 14:55:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRukG-000222-At; Mon, 22 Jan 2024 08:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rRukE-00021s-44
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:53:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rRukC-0004gU-AJ
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705931622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3n5plnQwZDoJkROn590VNCREeR6bQiO20qvxF8TWkTs=;
 b=aKd+eNR05l3Rkyte4kvPfQWCro35YwKWlHrXCbWFwK+Z5A8CnHcEy0gp4arjGQF68/ijbv
 saeqJYnl0V8xEKiKTxMGHRZAQbuQSPpdM1bZCRTDqFPn0R20Fx0BZZBU4NAkPVCT4MFVzq
 8Y6Zsoi9YJwSf/RxW82RJYZlLg+ROH8=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-O6_8UxKBNpy5Wm6drnmDvg-1; Mon, 22 Jan 2024 08:53:41 -0500
X-MC-Unique: O6_8UxKBNpy5Wm6drnmDvg-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-469a15fe491so2416475137.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 05:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705931620; x=1706536420;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3n5plnQwZDoJkROn590VNCREeR6bQiO20qvxF8TWkTs=;
 b=H1aCYQqkIRo97qDI6oFjD/wDhrd2SbRfD4zWtcHXlVALQxRjRdme6lumL5zlFILJAU
 NSXTsRPMv2DxNGHATvoJmslERF6EhATemMMq5E2MjJqUI4glvHgivNx50XObilyS4Byo
 t9jX1PBreFC2ew1mg5Mz++Ge5u1PPy5NuEJcE12sXVmFVcmemlUevZRHp1jFVzxpaYl/
 +29KQq1KLrpxPPW5mD1l/193W6N0HRynUmOApkVRFaPUhtmzi3h1jgZnYQT4gS/geoTu
 CfBLwdjKgcL4M54L1sW0aN1pClLkTtQOtkTDlPBKfxKSn2xG0DJL/aGqON8mgR8N0DTf
 KFlQ==
X-Gm-Message-State: AOJu0YwNQMetoSQoQUtVzhwLfjbFy/qqn+L3L9ubJsAU2/oR5osmXEBY
 17R58W6zqGjY1n+EVGFYAZlRlJyJN93f+VmCV3977wl4pyYXZsORJHWLfM5uo5zdPq52SNYTT8U
 am6zFfdsaLALcN/cxm4UA1dhoUuk9S+voDsT2B0hpZk/BlI2kL4hKao/Gbcvj3YLS9OXE3PNm9b
 CEIQC4mrryQv5V22ong++f80K9a2E=
X-Received: by 2002:a05:6102:f14:b0:469:b4d5:ba48 with SMTP id
 v20-20020a0561020f1400b00469b4d5ba48mr1018414vss.19.1705931619499; 
 Mon, 22 Jan 2024 05:53:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2mf8OJv+htM0T00cF2ZTJZzs89V6F2sae/6FRiI4z6FXREt7t0CnFrGnhPnBWYghMcRyQq7EQ6zHYOH3UHSE=
X-Received: by 2002:a05:6102:f14:b0:469:b4d5:ba48 with SMTP id
 v20-20020a0561020f1400b00469b4d5ba48mr1018401vss.19.1705931617741; Mon, 22
 Jan 2024 05:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20240122092409.280919-1-pbonzini@redhat.com>
 <c05bf905-de71-42c0-aeb6-9993bcbcbaca@redhat.com>
In-Reply-To: <c05bf905-de71-42c0-aeb6-9993bcbcbaca@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 22 Jan 2024 14:53:04 +0100
Message-ID: <CABgObfb46ioELeO6XaeMEog2az=hHpeyxVSQgJwaRwLOwK_TVw@mail.gmail.com>
Subject: Re: [PATCH] monitor: add dumpdtb command only in device-tree-enabled
 targets
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 22, 2024 at 2:40=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 22/01/2024 10.24, Paolo Bonzini wrote:
> > Remove the command altogether from targets that do not have device tree=
 support,
> > instead of leaving it nonfunctional.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   meson.build        | 2 --
> >   qapi/machine.json  | 2 +-
> >   hmp-commands.hx    | 2 +-
> >   system/meson.build | 2 +-
> >   4 files changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/meson.build b/meson.build
> > index de8e5ad67dc..6bf7f3eb685 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -3126,8 +3126,6 @@ if fdt_required.length() > 0 or get_option('fdt')=
.enabled()
> >     endif
> >   endif
> >
> > -config_host_data.set('CONFIG_FDT', fdt.found())
> > -
> >   vhost_user =3D not_found
> >   if host_os =3D=3D 'linux' and have_vhost_user
> >     libvhost_user =3D subproject('libvhost-user')
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index b6d634b30d5..c5e40857ba4 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -1828,4 +1828,4 @@
> >   ##
> >   { 'command': 'dumpdtb',
> >     'data': { 'filename': 'str' },
> > -  'if': 'CONFIG_FDT' }
> > +  'if': 'TARGET_NEEDS_FDT' }
> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > index 17b5ea839d9..f7263957240 100644
> > --- a/hmp-commands.hx
> > +++ b/hmp-commands.hx
> > @@ -1819,7 +1819,7 @@ ERST
> >           .flags      =3D "p",
> >       },
> >
> > -#if defined(CONFIG_FDT)
> > +#if defined(TARGET_NEED_FDT)
> >       {
> >           .name       =3D "dumpdtb",
> >           .args_type  =3D "filename:F",
> > diff --git a/system/meson.build b/system/meson.build
> > index 25e21172505..4e54f5d1a4b 100644
> > --- a/system/meson.build
> > +++ b/system/meson.build
> > @@ -32,7 +32,7 @@ if have_tpm
> >   endif
> >
> >   system_ss.add(when: seccomp, if_true: files('qemu-seccomp.c'))
> > -system_ss.add(when: fdt, if_true: files('device_tree.c'))
> > +system_ss.add(when: 'TARGET_NEED_FDT', if_true: [fdt, files('device_tr=
ee.c')])
>
> IIUC this does not work. For example, I applied your patch and tried to
> "make qemu-system-xtensa", I got:

xtensa is covered by the other patch I sent, but I (incorrectly)
thought these two would be independent and didn't send them as a
single thread.

> /usr/bin/ld: libcommon.fa.p/hw_core_guest-loader.c.o: in function
> `loader_insert_platform_data':
> /home/thuth/tmp/qemu-build/../../devel/qemu/hw/core/guest-loader.c:55:
> undefined reference to `qemu_fdt_add_subnode'
> /usr/bin/ld:
> /home/thuth/tmp/qemu-build/../../devel/qemu/hw/core/guest-loader.c:56:
> undefined reference to `qemu_fdt_setprop'
> /usr/bin/ld:
> /home/thuth/tmp/qemu-build/../../devel/qemu/hw/core/guest-loader.c:60:
> undefined reference to `qemu_fdt_setprop_string_array'
> /usr/bin/ld:
> /home/thuth/tmp/qemu-build/../../devel/qemu/hw/core/guest-loader.c:67:
> undefined reference to `qemu_fdt_setprop_string'
> /usr/bin/ld:
> /home/thuth/tmp/qemu-build/../../devel/qemu/hw/core/guest-loader.c:73:
> undefined reference to `qemu_fdt_setprop_string_array'
> collect2: error: ld returned 1 exit status
> ninja: build stopped: subcommand failed.
>
> system_ss is a common set, so you must not use a TARGET_* switch for
> deciding what goes into that set, or did I get that wrong?

You can use it; it's compiled once, and then (based on the per-target
configuration) the executable will or will not include the files that
depend on it, similar to devices.

Perhaps however it makes sense to turn it into a Kconfig symbol, as
that would make the use more clear. Or based on Phillippe's
suggestion, enabling device tree everywhere might make sense too.

Paolo


