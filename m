Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E5C7436EE
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:22:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF9Nc-00030d-VQ; Fri, 30 Jun 2023 04:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qF9Na-00030A-0w
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qF9NY-000202-0m
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688113278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2P2yPcsJA9sRXWE+8SLPKKzCY/t1iQxHtX7E/v/gtY=;
 b=UuS7vnaGg+HeLGP7b2wRyfDg8G74T85dUeojcdmovWpxbFsvbjAIwFY91MppwU7m3zp3D1
 EG0UWxAq9jQUknabiexOCJzyDJNAWADVUud6mMeub7fVkAK9JDikjxavUlhuXpsVk18uF/
 XVONJ59YU+cxBCGDcqD4kmiA0kT83es=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-g9QSryF9MzG7xSsgp--1Qg-1; Fri, 30 Jun 2023 04:21:15 -0400
X-MC-Unique: g9QSryF9MzG7xSsgp--1Qg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b69c1614a9so16029311fa.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 01:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688113274; x=1690705274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y2P2yPcsJA9sRXWE+8SLPKKzCY/t1iQxHtX7E/v/gtY=;
 b=XEOU80s2H2L3bFizAWZ+i5it4Ja4he2acu/2JRpDEVSuqrkvgLQ8GhDVK8U8yFqzpK
 Lq1zx8kdVTuRh6yvVEyYZDFrEyWD/CMnmxObscmvv9J26VF8ZCKHye8YeC6AmnWt0By+
 l3LQHt3g5UQo4dVXaoxmLeRzarw6IyELZU10m38DrsJ5KJr3j8IaaLMSVeg3PyQVJi7y
 O9f+n7m5jiVcU3CNaJMuxsmh9O9ocZS3eBILxSLDz9XkUh7f9ROlRCoT6+WutmExD5l2
 Z9/hi8IR21NDmRLP+U1YkfyWb2k3pBarClz/8WNIZBHvWZ4ScZx4K0UZKWAR8wHxuMh/
 YVhQ==
X-Gm-Message-State: ABy/qLZgUUcZqEers155BV0xKdNkJqzZE/BBDXVd5zWcZT530G4zoo40
 q2tWM0p2cREBj8ZZ3UsvcLKrLFejulb/Dkn6uTIku4kgo+A596Bp/MHN8nOHDt5aWdkNuVie1j1
 bTjGX/pbPWEoz0/Bd9m70KdvHQ8oXUDE=
X-Received: by 2002:a2e:8893:0:b0:2b6:a7a7:3607 with SMTP id
 k19-20020a2e8893000000b002b6a7a73607mr1572736lji.49.1688113274192; 
 Fri, 30 Jun 2023 01:21:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFB0012bEFNIakYfK8DVy//iKazHnLxTW+0UPoyXrH7szERo7xGWw+ehWOh8PGRaSEn8ddfrmRy8Gh3ZJLA7Ig=
X-Received: by 2002:a2e:8893:0:b0:2b6:a7a7:3607 with SMTP id
 k19-20020a2e8893000000b002b6a7a73607mr1572724lji.49.1688113273895; Fri, 30
 Jun 2023 01:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230614221026.56950-1-andrew@daynix.com>
 <CACGkMEsDw8sUeJB340f8cdqEFnQRXccDxq6pe+87KDzOBMHZpg@mail.gmail.com>
 <ZJ6MfLs+yLx/yQyV@redhat.com>
In-Reply-To: <ZJ6MfLs+yLx/yQyV@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Jun 2023 16:21:02 +0800
Message-ID: <CACGkMEsmKH=U7zYt6wtznjW6tcr=VvCkGfZJrfuUxWg1Ces31Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] eBPF RSS through QMP support.
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Andrew Melnychenko <andrew@daynix.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, 
 qemu-devel@nongnu.org, yuri.benditovich@daynix.com, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 30, 2023 at 4:04=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Jun 30, 2023 at 01:06:22PM +0800, Jason Wang wrote:
> > On Thu, Jun 15, 2023 at 6:29=E2=80=AFAM Andrew Melnychenko <andrew@dayn=
ix.com> wrote:
> > >
> > > This series of patches provides the ability to retrieve eBPF program
> > > through qmp, so management application may load bpf blob with proper =
capabilities.
> > > Now, virtio-net devices can accept eBPF programs and maps through pro=
perties
> > > as external file descriptors. Access to the eBPF map is direct throug=
h mmap()
> > > call, so it should not require additional capabilities to bpf* calls.
> > > eBPF file descriptors can be passed to QEMU from parent process or by=
 unix
> > > socket with sendfd() qmp command.
> > >
> > > Possible solution for libvirt may look like this: https://github.com/=
daynix/libvirt/tree/RSS_eBPF (WIP)
> > >
> > > Changes since v2:
> > >  * moved/refactored QMP command
> > >  * refactored virtio-net
> >
> > I've queued this series, but a question left:
> >
> > mmap() support for eBPF maps is not supported from day0, should we
> > fallback to syscall for the OS that doesn't support that?
>
> How recent is mmap() support ?

I don't check.

> Is it difficult to do a fallback ?

Nope, but it requires privilege if we go with a syscall.

>
> As since is a new feature,

But it modifies the old rss loading code, no?

-    for (; i < len; ++i) {
-        if (bpf_map_update_elem(ctx->map_indirections_table, &i,
-                                indirections_table + i, 0) < 0) {
-            return false;
-        }
-    }
+    memcpy(ctx->mmap_indirections_table, indirections_table,
+            sizeof(*indirections_table) * len);

> there's no inherant expectation of support
> for arbitrary old platforms. So only worth investing in a fallback if
> it is easy, or there's a very compelling reason to support certain
> old platforms.

The reason is that we support eBPF RSS with syscall based map updating
in the past if Qemu was running with privilege. With this series, it
won't work if the kernel doesn't support mmap.

Thanks

>
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


