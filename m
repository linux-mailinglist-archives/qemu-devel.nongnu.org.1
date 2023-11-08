Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2877E55B9
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 12:42:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0gvC-0003RX-KN; Wed, 08 Nov 2023 06:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0gv9-0003R9-Ck
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 06:40:31 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0gv7-0004TI-Nu
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 06:40:31 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5842c251d7cso3574374eaf.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 03:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699443628; x=1700048428; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yi8Z5kjdW7glNYel3iW9CZUr/OiPFv/nNW8kPmb4WwA=;
 b=Izws8r0kKsz0UrROCWHBcQnS6P607yn+tXwZoJsESqJVpddVcKAYtZFLfA7cCmVADe
 2/Oq1THv0D34X2LaLi4PU+BSWkXTobkql3YfyQka1OLt/mSG8SFRblIJzHpqR/GYH2E0
 8/z/Dq/9eLVZAhFhKuLKANWYqUk+WcSHnlaNju8Zq3zUF7wFGZrwETjj2RSrJwYzLrtn
 Rt+QtfOF28c++ja2qjy9UJYNhUK3C63JCytjrbslnsO7wxLLpBE3dYh+FjCMxna4lGlU
 SRazFpMyT/ovZZm6sOeFntZaZjDHXHJPCBNeVoi2AS9hPZ9PyGULdZWnEWcC/foL9ut2
 LW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699443628; x=1700048428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yi8Z5kjdW7glNYel3iW9CZUr/OiPFv/nNW8kPmb4WwA=;
 b=H6rrPbdKTQnBLoVkZtj6c0RziApATr0LSSOfueHWmYKgIr+IqyGDTyjLNXKfXofYK6
 oMfknlHzA5FidZ364qJpGmUwWaAXamOSoDA9IzalORSHkqQdMKveYEqteiHgVXPtluYU
 039wGtrn9dCMEULpPnm77oni9tk/uxU87yJVG9sxTq2T+rVhIbQRy7Be6bD0V7Dxgmtx
 iuT+rWfubU6upiCjgW3MyUY+pokourei4zWmOsc7eX7oFWV7u69IlnA6DSTyS2DfdZ6S
 9Kt9ljxuBen948aSvFCZQxRE1/zMhQBi84Wa4O6F5hir+3tNwbVkYkLdaVHGLUM/TOTy
 N4xA==
X-Gm-Message-State: AOJu0Ywz9pC3/ieXyWcpOsQIuUe3FPIIYD10mWlveA956Mj9mAP8Z4Vh
 X9Xobw645cHJOG/OXjeT1XKO2MwtwH22/Qux35g=
X-Google-Smtp-Source: AGHT+IGD++ynK8aqOk1AR52DzOMDQKm8xVM2V1MXei0tGpdByDNPPuREQTEt7hxES3rAmt4OKTwMVNghhUWSGH1kp14=
X-Received: by 2002:a4a:380e:0:b0:581:ea70:8a30 with SMTP id
 c14-20020a4a380e000000b00581ea708a30mr1346502ooa.7.1699443628211; Wed, 08 Nov
 2023 03:40:28 -0800 (PST)
MIME-Version: 1.0
References: <7dfb93bd-314d-4d62-8bac-64f5fdf93c22@linaro.org>
In-Reply-To: <7dfb93bd-314d-4d62-8bac-64f5fdf93c22@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 8 Nov 2023 19:40:16 +0800
Message-ID: <CAJSP0QXY=HKE3eBVrsCiK3qoX5F8FjKT9FiU78xM2vapWQtQjQ@mail.gmail.com>
Subject: Re: virtio-fs@redhat.com bouncing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Mauro Matteo Cascella <mcascell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 8 Nov 2023 at 19:05, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Hi Stefan,
>
> You are listed as virtiofs maintainer, see MAINTAINERS:
>
>    virtiofs
>    M: Stefan Hajnoczi <stefanha@redhat.com>
>    S: Supported
>    F: hw/virtio/vhost-user-fs*
>    F: include/hw/virtio/vhost-user-fs.h
>    L: virtio-fs@redhat.com
>
> Mails sent to this list address are bouncing:
>
> <virtio-fs@redhat.com>: host int-mx-rdu2.corp.redhat.com[10.11.203.6]
> said: 550
>      5.1.1 <virtio-fs@redhat.com>: Recipient address rejected: User
> unknown in
>      local recipient table (in reply to RCPT TO command)
>
> Maybe the list need to be updated, like Daniel did with libvir-list@?
> https://lore.kernel.org/qemu-devel/20231027095643.2842382-1-berrange@redh=
at.com/

Yes, it does. The new mailing list address has not been created yet.
I'll update the MAINTAINERS file when the new mailing list becomes
available in the coming days.

> Looking at other lists, I also see secalert@:
>
>    $ git grep L:.*redhat MAINTAINERS
>    MAINTAINERS:86:L: secalert@redhat.com
>    MAINTAINERS:2231:L: virtio-fs@redhat.com
>
> So Cc'ing Michael / Mauro.

I'm not sure about secalert. Thanks for CCing Michael and Mauro.

Thanks,
Stefan

