Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7097E55DC
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 13:00:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0hCb-0005dP-88; Wed, 08 Nov 2023 06:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1r0hCW-0005cP-Af
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 06:58:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1r0hCU-0007Uf-Js
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 06:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699444703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Di52j8J4xehQTOGlqe6ncZ2U3glGdlfzn0O3n11O+Ag=;
 b=AEFuyYN4oBxX+rpVMdouVgcFwfTzy0q9K8BgKomKiRJAJ2cdN4LcGVWivVU0EjoQHJiYsH
 iSbzIFHet0fGrQxDEiii63P5NCTdEoVpFyVzm9uOV5EPxRaA3PnTuabi2KVSZZox5obRf2
 hk+n6goKOFgHxK8g8300lMRGqfKRH5w=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-bvTEUHGBNlqWWDtaXHCDqA-1; Wed, 08 Nov 2023 06:58:21 -0500
X-MC-Unique: bvTEUHGBNlqWWDtaXHCDqA-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-4ac460c95c7so1294960e0c.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 03:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699444701; x=1700049501;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Di52j8J4xehQTOGlqe6ncZ2U3glGdlfzn0O3n11O+Ag=;
 b=G+wy9HQb1Dm1+Q2hLriVnttY3E9DXMrEG2cmFgZZKhIfcHXJC4VIbHJnOJcIMjxE2x
 9LvPXJ+b7dQohQ/KbrCz1QW3insBSzT0L6FJTW9xjQJzMucgWnpp2lNooxzczhnbm/Va
 QEEB8PJEzT5jSvo0WIkMjUl3P+85Z7BDVLmJigA4t+G49qdGs/xUMrhqCDe2sO0W7akc
 H0dkr/GEt5Ao1D2ewkEWtVQUNOmnQCp+/BJ3rN/uxF9wl91Ljf1uMWNklCgFgmSCiu+e
 BgCnGZMqZh7tu/F61VVP4tVp7UqzGTN6gqKHmWP2wIZB4W0n+nFRQT4dwgHP7S7UUp3b
 yCpg==
X-Gm-Message-State: AOJu0YwigPhZr/fdBGflgD6sv09SiLtJwrNG1aMx6H6+PWraUYYEGeNG
 KCy2XcOvQ6YhrCsfkShq+TJ/HNCzYqI6WxokJL6Fi1COmnlA05lUyc+INrK1sj3y7CeIa6hQcHF
 Seoq/oGJrh4zB7AQPk199Cwse2J2KFFI=
X-Received: by 2002:a1f:9b0e:0:b0:48d:1fcd:9760 with SMTP id
 d14-20020a1f9b0e000000b0048d1fcd9760mr1491160vke.10.1699444701050; 
 Wed, 08 Nov 2023 03:58:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS8tqFixvSX6q3hBtYsxopwxPlCRu3QMQ4hwUZDQ4/EZNxW5SYZ9FuXmXTuShf5tSrpvPIcSKLT+LOn9SH9CQ=
X-Received: by 2002:a1f:9b0e:0:b0:48d:1fcd:9760 with SMTP id
 d14-20020a1f9b0e000000b0048d1fcd9760mr1491142vke.10.1699444700734; Wed, 08
 Nov 2023 03:58:20 -0800 (PST)
MIME-Version: 1.0
References: <7dfb93bd-314d-4d62-8bac-64f5fdf93c22@linaro.org>
 <CAJSP0QXY=HKE3eBVrsCiK3qoX5F8FjKT9FiU78xM2vapWQtQjQ@mail.gmail.com>
In-Reply-To: <CAJSP0QXY=HKE3eBVrsCiK3qoX5F8FjKT9FiU78xM2vapWQtQjQ@mail.gmail.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Wed, 8 Nov 2023 12:58:09 +0100
Message-ID: <CAA8xKjV_w6ZnHC_6zf782fpb3wHs=2v2fiaOTHL3kcgyVup-XA@mail.gmail.com>
Subject: Re: virtio-fs@redhat.com bouncing
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

On Wed, Nov 8, 2023 at 12:40=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Wed, 8 Nov 2023 at 19:05, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
> >
> > Hi Stefan,
> >
> > You are listed as virtiofs maintainer, see MAINTAINERS:
> >
> >    virtiofs
> >    M: Stefan Hajnoczi <stefanha@redhat.com>
> >    S: Supported
> >    F: hw/virtio/vhost-user-fs*
> >    F: include/hw/virtio/vhost-user-fs.h
> >    L: virtio-fs@redhat.com
> >
> > Mails sent to this list address are bouncing:
> >
> > <virtio-fs@redhat.com>: host int-mx-rdu2.corp.redhat.com[10.11.203.6]
> > said: 550
> >      5.1.1 <virtio-fs@redhat.com>: Recipient address rejected: User
> > unknown in
> >      local recipient table (in reply to RCPT TO command)
> >
> > Maybe the list need to be updated, like Daniel did with libvir-list@?
> > https://lore.kernel.org/qemu-devel/20231027095643.2842382-1-berrange@re=
dhat.com/
>
> Yes, it does. The new mailing list address has not been created yet.
> I'll update the MAINTAINERS file when the new mailing list becomes
> available in the coming days.
>
> > Looking at other lists, I also see secalert@:
> >
> >    $ git grep L:.*redhat MAINTAINERS
> >    MAINTAINERS:86:L: secalert@redhat.com
> >    MAINTAINERS:2231:L: virtio-fs@redhat.com
> >
> > So Cc'ing Michael / Mauro.
>
> I'm not sure about secalert. Thanks for CCing Michael and Mauro.

secalert@ is regularly monitored and working fine. Perhaps we can add
qemu-security@nongnu.org, in addition to secalert, to match what's
stated in the 'Security Process' page.

```
diff --git a/MAINTAINERS b/MAINTAINERS
index 8e8a7d5be5..af74d5487f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -83,6 +83,7 @@ Responsible Disclosure, Reporting Security Issues
 -------------------------------------------------
 W: https://wiki.qemu.org/SecurityProcess
 M: Michael S. Tsirkin <mst@redhat.com>
+L: qemu-security@nongnu.org
 L: secalert@redhat.com

 Trivial patches
```

> Thanks,
> Stefan
>

Thank you,
--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


