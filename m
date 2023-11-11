Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C6C7E8B83
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 17:11:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1qYb-0004Pu-5r; Sat, 11 Nov 2023 11:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1qYV-0004PI-DU
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 11:09:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1qYT-0007Nt-Ry
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 11:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699718987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=22IE7fXv/QBpZIrnnuBoq+ow7hRrWW5GkZzjnTZm6+U=;
 b=dNWbLn4g3zrkfw4kbt9lkvv8ZHkMFyiHp3WNlYdEoDfd6TKC+PIZ08vfroTH0KCmL+Z3ec
 fS6CKSKK2xVg3OVc5IoM8ymPm35MnAq7A1bcFV68vr2R79LyVucc4quEuAvpsHb70OohYb
 Xxp+i57lYFOtZFNHnkv9NQYFXwSPYSM=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-xvjrk8CqOjOrflYCmQQnhA-1; Sat, 11 Nov 2023 11:09:45 -0500
X-MC-Unique: xvjrk8CqOjOrflYCmQQnhA-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7ba274ab2afso948093241.0
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 08:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699718985; x=1700323785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22IE7fXv/QBpZIrnnuBoq+ow7hRrWW5GkZzjnTZm6+U=;
 b=oZpDWCBF55M3bE4RtizpTmECzMveOj+osiS9LfVX1T6sDQZ0KZ6HFFp+9CyZktoU/H
 Ab8bo1YesWOftHlvZvUKQ3YrrdVJGmGjWEBaB/OBI+T8DZrYl+E63MD1d4/9Xp0fvJ6K
 Tqca1DgnPty0/j73PwRDykRBPzIWxwhCf73YtYe1i1rpdUUKQUsStmy35G+Rxc7t5U9D
 gkQOYOiYv7eicILdhxoWUM+CceOxZ0aUQBvWPb0lSXeJLLXajXjkwMqFgHRKQjDjD9Ql
 5yL18LpBVsN1K92BuA+nstnMlpME8+FkSnfuv8nY4PRp0FqJathRD5tlncyDDuHE07JK
 WJeQ==
X-Gm-Message-State: AOJu0YxtiU1y+4fGmSjwPc78dvgTsWK00MEgedq25KfkT2Mq2yOOF3BP
 WGyD3x3wKMUQrBZkDZFDiem1zsReiXjXbN2ey6WfIJKyIFNjfM6fRvZ8ARDoXoQXa2KsHGoerw4
 USzSDQYhER6FRoT6zHZQHHaTMH7cMSjg=
X-Received: by 2002:a67:e195:0:b0:45e:9611:7b71 with SMTP id
 e21-20020a67e195000000b0045e96117b71mr2103852vsl.27.1699718985337; 
 Sat, 11 Nov 2023 08:09:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjIxvLA6M0OiMBd3HP+FkWey0DtWNscdIdtAloCZ3YlYm3uddtn/yUl1rykiXI3ublZtiEHxH6g8QyOY5CXbA=
X-Received: by 2002:a67:e195:0:b0:45e:9611:7b71 with SMTP id
 e21-20020a67e195000000b0045e96117b71mr2103840vsl.27.1699718985070; Sat, 11
 Nov 2023 08:09:45 -0800 (PST)
MIME-Version: 1.0
References: <610aad34-da0b-4b8a-aa22-4ad19513ae28@tls.msk.ru>
In-Reply-To: <610aad34-da0b-4b8a-aa22-4ad19513ae28@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 11 Nov 2023 17:09:33 +0100
Message-ID: <CABgObfYMct5NwGuYtOsFdEYaV6U=Ahe8zMPc_8QRh5a-cs_SEQ@mail.gmail.com>
Subject: Re: disable-pie build
To: Michael Tokarev <mjt@tls.msk.ru>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
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

On Sat, Nov 11, 2023 at 3:40=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> Hi!
>
> It looks like --disable-pie configure, which uses -fno-pie -no-pie flags
> for the compiler, is broken: it does not not tell the *linker* about the
> option, so the link fails (at least on debian bookworm):

Looks good, if you can send a patch perhaps Stefan can apply it (or
someone else can handle it in my stead, because I'm away next week).

Paolo

> /usr/bin/ld: libcommon.fa.p/hw_core_cpu-common.c.o: relocation R_X86_64_3=
2 against `.rodata' can not be used when making a PIE object; recompile wit=
h
> -fPIE
> /usr/bin/ld: failed to set dynamic section sizes: bad value
>
> This is failing for *all* executables, including tests, qemu-img, etc.
>
> The following change fixes it:
>
> diff --git a/meson.build b/meson.build
> index a9c4f28247..0b7ca45d48 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -278,7 +278,8 @@ endif
>   # tries to build an executable instead of a shared library and fails.  =
So
>   # don't add -no-pie anywhere and cross fingers. :(
>   if not get_option('b_pie')
> -  qemu_common_flags +=3D cc.get_supported_arguments('-fno-pie', '-no-pie=
')
> +  qemu_common_flags +=3D cc.get_supported_arguments('-fno-pie')
> +  qemu_ldflags +=3D cc.get_supported_arguments('-no-pie')
>   endif
>
>   if not get_option('stack_protector').disabled()
>
>C


