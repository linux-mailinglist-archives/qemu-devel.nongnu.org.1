Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4F680F172
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 16:47:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD4yB-0005zF-Ko; Tue, 12 Dec 2023 10:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rD4y7-0005yw-FO
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 10:46:47 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rD4xz-0003xq-Rp
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 10:46:45 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40c31f18274so53469885e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 07:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1702395996; x=1703000796; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+OemhjYOdKfIJ0/gpK1EfT3NR+zGX/WOIYWuBnon+Q0=;
 b=Kw/vfkmuQTaCwnao2PCTsnETeZfKAyHj7ajsI1/2lGzfu65crox4RjQZUXUVsIt1fu
 yCcBlsPd1Mb22cHmjKqn1aGMT+kjcqsArvgl3dbuWpNPOdYG/T+e5H2L3PsmdM/b1MS4
 eAEPnIjqQLQg+Yg5IFp1mxdchwtyI1IkcUOSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702395996; x=1703000796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+OemhjYOdKfIJ0/gpK1EfT3NR+zGX/WOIYWuBnon+Q0=;
 b=rtTehD5s05jYJvzUyax6+XVBdsqpH5SC4tO/5C7A5t5NmiyxJrkX8CrZ1nf/345Qbx
 UM1Kz03npmtFw2nMsyH5pzy8d2bzPuIm7GwDy+BDufJ8eeRz0b3DZ3yhbGbTCxj5uwDI
 rDfUAIg4xYKAaLbVBvNalZjuZbJoQ8MjeZpHJn/RXb4fN1fhISbeXHa7Ea2IIrEmsLVk
 JLrQnn8wRwMYOHwVPrHwlflTrMAfTGhL992Gi8FoigkPfAvahAm/R5mDZ0rDjOxNf5Kv
 74tRN8AKNqM35LNgFlAsfsqIMb2LGafOvt2nZP3j9+hVu1+1o6Quk1khErYNVI2UtFhW
 wRhQ==
X-Gm-Message-State: AOJu0YwhYbBMFsQd2VAFVryBkbrS4vG9w9LC70E8tc+5mskJjPqu36o/
 twR8WIjnHR5nSs0/238f4TzS/A==
X-Google-Smtp-Source: AGHT+IHFJf03PzPkPzri93AhUKK+6y6rmzVHTxe8snweg8/A/E89NVAc6nL29hqbLwBh9xoltAF5lw==
X-Received: by 2002:a05:600c:240d:b0:40c:34cd:1fe3 with SMTP id
 13-20020a05600c240d00b0040c34cd1fe3mr3102920wmp.83.1702395996279; 
 Tue, 12 Dec 2023 07:46:36 -0800 (PST)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 j6-20020adfe506000000b0033339e03a60sm11123474wrm.59.2023.12.12.07.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 07:46:36 -0800 (PST)
Date: Tue, 12 Dec 2023 15:46:35 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Julien Grall <julien@xen.org>, Greg Kurz <groug@kaod.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paul Durrant <paul@xen.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [RFC PATCH v4 4/6] xen: add option to disable legacy backends
Message-ID: <8b74d526-30b1-4ab7-86bc-98d954beacfb@perard>
References: <20231202014108.2017803-1-volodymyr_babchuk@epam.com>
 <20231202014108.2017803-5-volodymyr_babchuk@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202014108.2017803-5-volodymyr_babchuk@epam.com>
Received-SPF: permerror client-ip=2a00:1450:4864:20::336;
 envelope-from=anthony.perard@cloud.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Sat, Dec 02, 2023 at 01:41:22AM +0000, Volodymyr Babchuk wrote:
> diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
> index 9f9f137f99..03a55f345c 100644
> --- a/hw/xenpv/xen_machine_pv.c
> +++ b/hw/xenpv/xen_machine_pv.c
> @@ -37,7 +37,9 @@ static void xen_init_pv(MachineState *machine)
>      setup_xen_backend_ops();
>  
>      /* Initialize backend core & drivers */
> +#ifdef CONFIG_XEN_LEGACY_BACKENDS
>      xen_be_init();
> +#endif

There's more code that depends on legacy backend support in this
function: Call to xen_be_register() and xen_config_dev_nic() and symbol
xen_config_cleanup, and the code commented with "configure framebuffer".
I've tried to build this on x86.

>  
>      switch (xen_mode) {
>      case XEN_ATTACH:
> diff --git a/meson.build b/meson.build
> index ec01f8b138..c8a43dd97d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2219,6 +2222,7 @@ config_host_data.set('CONFIG_DBUS_DISPLAY', dbus_display)
>  config_host_data.set('CONFIG_CFI', get_option('cfi'))
>  config_host_data.set('CONFIG_SELINUX', selinux.found())
>  config_host_data.set('CONFIG_XEN_BACKEND', xen.found())
> +config_host_data.set('CONFIG_XEN_LEGACY_BACKENDS', have_xen_legacy_backends)

I don't know if "config_host_data" is the right place to have "#define
CONFIG_XEN_LEGACY_BACKENDS", but the alternative is probably to define a
Kconfig value, but I don't know if that would be correct as well.
I guess this is fine here, for now.


>  config_host_data.set('CONFIG_LIBDW', libdw.found())
>  if xen.found()
>    # protect from xen.version() having less than three components
> @@ -3049,6 +3053,7 @@ config_all += config_targetos
>  config_all += config_all_disas
>  config_all += {
>    'CONFIG_XEN': xen.found(),
> +  'CONFIG_XEN_LEGACY_BACKENDS': have_xen_legacy_backends,

I don't think this is useful here, or even wanted.
I think things added to config_all are used only in "meson.build" files,
for things like "system_ss.add(when: ['CONFIG_XEN_LEGACY_BACKENDS'] ..."
But you use "if have_xen_legacy_backends" instead, which is probably ok
(because objects also depends on CONFIG_XEN_BUS).

>    'CONFIG_SYSTEM_ONLY': have_system,
>    'CONFIG_USER_ONLY': have_user,
>    'CONFIG_ALL': true,
> diff --git a/meson_options.txt b/meson_options.txt
> index c9baeda639..91dd677257 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -77,6 +77,8 @@ option('nvmm', type: 'feature', value: 'auto',
>         description: 'NVMM acceleration support')
>  option('xen', type: 'feature', value: 'auto',
>         description: 'Xen backend support')
> +option('xen-legacy-backends', type: 'feature', value: 'auto',

Every other meson options are using '_', I haven't found any single '-'.
Shouldn't this new option follow the same trend and be named
"xen_legacy_backends" ?

> +       description: 'Xen legacy backends (9pfs, fb, qusb) support')

This description feels a bit wrong somehow. "Legacy backend" is internal
to QEMU's code, and meant that the backends are implemented using legacy
support that we want to retire. But the backends them self, as seen by
a guest aren't going to change, and are not legacy. Also, a few month
ago, "qnic" would have been part of the list. Maybe a description like
"Xen backends based on legacy support" might be more appropriate. I'm
not sure listing the different backend in the description is a good
idea, as we will have to remember to change it whenever one of those
backend is been upgraded.


Cheers,

-- 
Anthony PERARD

