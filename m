Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6B7743C4A
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 14:54:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFDct-0006Y4-Sy; Fri, 30 Jun 2023 08:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qFDco-0006X6-8R
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:53:22 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qFDcl-0004bq-N4
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:53:21 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-bacf685150cso1726451276.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 05:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688129598; x=1690721598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulcLUKgflyop2yJOkZUKHxiWiEHkPORtMU/LYZBwLGo=;
 b=iK0qqjQUo050mvYjxoxXYyQt9tnJ5L6cIw6WPJLY/iuEnvZKZtnau+fifeRH4FFwJl
 Hr3c9ayzeC8sTWzcciMQzPopwjT6uv26jB7sJ9JRyumzbZoPZ6QMomFTwIwu4MUSQUWL
 VdWZkg6Twvdo/vQHcY8VCM44F/NQSMzEWK4n82y3ba+STV8oD49AOUByoi3a38J9O1M6
 mfHlZFl/NEUx5PUEQ9R/IX5yfqx4UUdX6a9ZfSuSHR+TE140Yoh4JqOAKJb8W+VhkvCf
 QBFYw4aBiokWUcy6vwl6w0qWnISHR5pBFTiYVJTGhSogqgF6sLgOroIPPbmRIE+62HpA
 0Z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688129598; x=1690721598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ulcLUKgflyop2yJOkZUKHxiWiEHkPORtMU/LYZBwLGo=;
 b=LpJFpGV280WJcTP44axiY/vGGQW7WT5RHUeXKwnnY973+cz7vV7jlbGbVJatHQLveO
 VSKC7KVJFxc3bhqSsbO8nSLq6+z30naW0req4itf/iuUaMmN6qWeGNSC4zifQhISPWXS
 po94hU2G2vcZmy1PwVo3mEjh1oPdc9pxGjVwpUll8e/C8IMVcnVFe40KgqSuYqS1ur2t
 qIOim/t5kx/3qPEKFZKUvBb4Gfaa8FyCCMensiWEfCT3hl0gu2f4fii9ReZIdBD1NkWB
 Vtes4YjuxUGBqXLnTLMpPo2uRfw/TtZnEk7EdyonPR8I0WAQCD3AzUqbaSl8VkAdAX0Z
 kGLQ==
X-Gm-Message-State: ABy/qLYeWNLVlcxZat9G/qt6edt2Xk80kJrql/r+buL/eg8+stxykjPi
 QA74GmqhoE0BshnualORlzJV0ZcU8ZTYXj25anNWEA==
X-Google-Smtp-Source: APBJJlF9RHm7jV2NEQhqKJdMO460BMKhpI/pmQGXF9xZqy6q/39FiQetUrM17XDL5C2XhYJ441WgthCu8We8D3OD+qM=
X-Received: by 2002:a25:6814:0:b0:bfe:bf77:64fd with SMTP id
 d20-20020a256814000000b00bfebf7764fdmr2657760ybc.12.1688129598318; Fri, 30
 Jun 2023 05:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230614221026.56950-1-andrew@daynix.com>
 <CACGkMEsDw8sUeJB340f8cdqEFnQRXccDxq6pe+87KDzOBMHZpg@mail.gmail.com>
 <ZJ6MfLs+yLx/yQyV@redhat.com>
 <CACGkMEsmKH=U7zYt6wtznjW6tcr=VvCkGfZJrfuUxWg1Ces31Q@mail.gmail.com>
 <ZJ6Yfu1pDBT6zaoL@redhat.com>
In-Reply-To: <ZJ6Yfu1pDBT6zaoL@redhat.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Fri, 30 Jun 2023 15:53:07 +0300
Message-ID: <CABcq3pE8yOZBJT1z704Zzopcsn8JNcAVmg=Qi19S2js3FV_LhQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] eBPF RSS through QMP support.
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, armbru@redhat.com, 
 eblake@redhat.com, qemu-devel@nongnu.org, yuri.benditovich@daynix.com, 
 yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::b29;
 envelope-from=andrew@daynix.com; helo=mail-yb1-xb29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi all,
Thank you for your comments. I'll check the error/warning.

On Fri, Jun 30, 2023 at 11:55=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Fri, Jun 30, 2023 at 04:21:02PM +0800, Jason Wang wrote:
> > On Fri, Jun 30, 2023 at 4:04=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > >
> > > On Fri, Jun 30, 2023 at 01:06:22PM +0800, Jason Wang wrote:
> > > > On Thu, Jun 15, 2023 at 6:29=E2=80=AFAM Andrew Melnychenko <andrew@=
daynix.com> wrote:
> > > > >
> > > > > This series of patches provides the ability to retrieve eBPF prog=
ram
> > > > > through qmp, so management application may load bpf blob with pro=
per capabilities.
> > > > > Now, virtio-net devices can accept eBPF programs and maps through=
 properties
> > > > > as external file descriptors. Access to the eBPF map is direct th=
rough mmap()
> > > > > call, so it should not require additional capabilities to bpf* ca=
lls.
> > > > > eBPF file descriptors can be passed to QEMU from parent process o=
r by unix
> > > > > socket with sendfd() qmp command.
> > > > >
> > > > > Possible solution for libvirt may look like this: https://github.=
com/daynix/libvirt/tree/RSS_eBPF (WIP)
> > > > >
> > > > > Changes since v2:
> > > > >  * moved/refactored QMP command
> > > > >  * refactored virtio-net
> > > >
> > > > I've queued this series, but a question left:
> > > >
> > > > mmap() support for eBPF maps is not supported from day0, should we
> > > > fallback to syscall for the OS that doesn't support that?
> > >
> > > How recent is mmap() support ?
> >
> > I don't check.
> >
> > > Is it difficult to do a fallback ?
> >
> > Nope, but it requires privilege if we go with a syscall.
> >
> > >
> > > As since is a new feature,
> >
> > But it modifies the old rss loading code, no?
> >
> > -    for (; i < len; ++i) {
> > -        if (bpf_map_update_elem(ctx->map_indirections_table, &i,
> > -                                indirections_table + i, 0) < 0) {
> > -            return false;
> > -        }
> > -    }
> > +    memcpy(ctx->mmap_indirections_table, indirections_table,
> > +            sizeof(*indirections_table) * len);
> >
> > > there's no inherant expectation of support
> > > for arbitrary old platforms. So only worth investing in a fallback if
> > > it is easy, or there's a very compelling reason to support certain
> > > old platforms.
> >
> > The reason is that we support eBPF RSS with syscall based map updating
> > in the past if Qemu was running with privilege. With this series, it
> > won't work if the kernel doesn't support mmap.
>
> Oh right, yes, I missed that aspect. So yeah, we do need fallback.

Need to check if it is necessary to support the eBPF on an old kernel
that doesn't support mmap for eBPF.
eBPF RSS program itself would require kernel 5.5+.
If I am not mistaken, the mmap for eBPF was added in 5.5
I'll recheck it.

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

