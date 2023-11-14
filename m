Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B27827EB0C3
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 14:22:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2tM9-0000E6-19; Tue, 14 Nov 2023 08:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2tLw-00009R-Oz
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:21:17 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2tLv-0000Wk-2j
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:21:16 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-540c54944c4so11304138a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 05:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699968073; x=1700572873; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JdxmbrIi+h2LJQZ3W6CRYV+Xqy1ExBQdhYEjD5um7Dc=;
 b=XzWAVwZQMSFR4RdttcH5UIo58RWwc5kGVp6/3cGdcg/GEn+pPkP7ZorxanksTWOGih
 o1gJLLJQPINgbCDcoP+gpHKhR/AdYZPPrXeadk9n+rmE4zz2wPBGgr6dZICEWVq9MBv+
 gldqgqJYETo7JBsVgCeyuzj2ftsiDWRARVbv03RsO1bnY5jSpEcOUm0v1/kDjcmUdVO3
 mVIiNmN8rB/PA4a1x76bqQHG/X+UQV7/Vfa6E3LYPx31omSS+HPfX+mR68EZVS51NLa6
 yNpA/Q/Pdk7KavDXblDuBslaSG4M27OszU4PylIh2UqfIeLDu6A0LFB1ZpNb6rnsJbLG
 8UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699968073; x=1700572873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JdxmbrIi+h2LJQZ3W6CRYV+Xqy1ExBQdhYEjD5um7Dc=;
 b=vZdZaUT4u904C3eUiaPWAEpgax0ze3uJkKOerxsvOgUgARvk9o0zZ9TyXbAFdUdESf
 NH2qAaC01wm+j3lVGlbH7I350OjyCCWXTOIn2r3VAFCnQIo30q09VhmYhy97xQTrEx0+
 5NxVUiC1kWuZoXvC7SOVps/+Bnex85anm+S05Zj2ydjZd0j2R1nhD+tCXWuPiaowxTRk
 jK3o/jTnEEZwNMOLvYrW+gy+Gbu4ek4/b0DdhfFqWu4HPMzVn1J2R7slWl1TneDXMMJs
 v9cxuDoTY2metzlJqgRWQw7+w4IvJo7cWmZvdBs4kuS+meXCpSA1w8OX/oAzTOC5uqmj
 QacA==
X-Gm-Message-State: AOJu0Yxc2uyrON4wdXl7niBvjs4nxBnIOPl824yVCnrGkZhiPVFgDU54
 ZkODR0niMXYYCf8iSf5OAhBKUujKiAsPXcNwRlUgBA==
X-Google-Smtp-Source: AGHT+IEdB40nOOtz0F449s5NxyJIeA9hmye/eB21OeffjLolhZ9Ix+qbF674xB9bxqoaaygd28utThjhZ2eEdv1RxGk=
X-Received: by 2002:a05:6402:1e8f:b0:542:f0af:21e6 with SMTP id
 f15-20020a0564021e8f00b00542f0af21e6mr2195918edf.14.1699968073035; Tue, 14
 Nov 2023 05:21:13 -0800 (PST)
MIME-Version: 1.0
References: <20231114130415.283228-1-thuth@redhat.com>
In-Reply-To: <20231114130415.283228-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Nov 2023 13:21:01 +0000
Message-ID: <CAFEAcA_LcmowH28KG9LXRQRPFkAbmDCoPz5RDDK0TG+Am-p73w@mail.gmail.com>
Subject: Re: [PATCH] qom/object: Limit type names to alphanumerical and some
 few special characters
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 14 Nov 2023 at 13:05, Thomas Huth <thuth@redhat.com> wrote:
>
> QOM names currently don't have any enforced naming rules. This
> can be problematic, e.g. when they are used on the command line
> for the "-device" option (where the comma is used to separate
> properties). To avoid that such problematic type names come in
> again, let's restrict the set of acceptable characters during the
> type registration.
>
> Ideally, we'd apply here the same rules as for QAPI, i.e. all type
> names should begin with a letter, and contain only ASCII letters,
> digits, hyphen, and underscore. However, we already have so many
> pre-existing types like:
>
>     486-x86_64-cpu
>     cfi.pflash01
>     power5+_v2.1-spapr-cpu-core
>     virt-2.6-machine::hotplug-handler
>     aspeed.i2c.slave::vmstate-if
>     pc-i440fx-3.0-machine::nmi

I think all these '::' are specifically interface types --
see type_initialize_interface(), which constructs the
interface type name by gluing together the class name and
the interface name with a '::'. The rule we ought to be
requiring for ':' I think is "no : in the type name, unless
it is the one generated by type_initialize_interface()".

I think we could do that by having the type_name_is_valid()
checks done in:
 * type_initialize_interface(), on ti->name and interface_type->name
 * type_register_internal(), on info->name

If we do that, can we take ':' out of the list of characters
we permit in type_name_is_valid() ?

thanks
-- PMM

