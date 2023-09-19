Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2D07A644B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 15:03:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiaNf-0005HS-OB; Tue, 19 Sep 2023 09:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiaNd-0005Fd-Ne
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 09:03:05 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiaNc-00082C-Bv
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 09:03:05 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4135f3d1213so32825061cf.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 06:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695128582; x=1695733382; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNAoqv0s7JsYLPBq0H5zDCBs2v4vAA9sU5i6RcGU4bg=;
 b=h14LYQsAr34ZaDHY9CP1xnCi+yYpgj+LSNdz3G7hKSkVPHw8IY0sgPXjtEja09l20l
 620FddOqgwwWNIkBUaKpZOVmm4GYmnDCXDphfhibBgxgXqRohuyIT3xDO9rsVNxsS+6e
 W7eibXDXtCk+l9Ljqq5dPOMstwPmeXKRjAPjezsDj6KY7oCtQsmkxwnZTw08vFfew+9R
 +uP9piR8Z+2s1mP4xD42ck9lwSj+34aRVgck3q+USNnuXIv6WPVpk9RCapl0UGDreMdx
 ri1Lngn2DVM4q0Ws1C9DV0FQCzfDmdUqh7cJMdC/MSulQoU7yAma1oxpiwlA4GrC+2N/
 j7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695128582; x=1695733382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bNAoqv0s7JsYLPBq0H5zDCBs2v4vAA9sU5i6RcGU4bg=;
 b=O0a/XzUd5pkbrXhDfLagMpagPvOCuQesf3ZXBGors1/5ICPCyEXJN+Z2NeqVdyzArD
 3X+coF5Peo4Hst1PRJ/EAnT6UBhfrtGljJ+wBfOhNOUuZnwmuR76A3VElvtBrp4JdoAu
 0DsWBKqWGTnqxzzQQeC4jhtS8XRiXYDuu05n2TSvVAEHfPnnUdva/4TLFiOi29+24Z2H
 8Iewmcq6Rx3XwaL8jTIGp1ZFDMf1kz/h9ABJi3ICz+PUjNq6wIqFmvOwXZ/nBH1oQhi3
 BGyjF1ypm0tJ0pwW+dUf5a5COxNtfVYTkDKArUdpbkRQ/r4oaeQghnOv4KNQkk8Pj1my
 m4qg==
X-Gm-Message-State: AOJu0YyRqKKNS1NhyOLsCStq3QzVJqZ97rukJGReFIZzJGNY+2NN9Qst
 YXxnQ2/qAyNPPjlTBCWkK9n2pBCLoxyRXt63tLc=
X-Google-Smtp-Source: AGHT+IEsopPLkpM9jlTC8uIW5wdAZMgj+hPX6NeAq1HbU+gFqOf3v6QEzXbZI4GiTeXC2fqCl9sZRf+m6SHHF/ZtVSM=
X-Received: by 2002:a05:622a:148f:b0:412:43a5:e5a4 with SMTP id
 t15-20020a05622a148f00b0041243a5e5a4mr13150963qtx.65.1695128582535; Tue, 19
 Sep 2023 06:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230918135206.2739222-1-marcandre.lureau@redhat.com>
 <20230918135206.2739222-10-marcandre.lureau@redhat.com>
 <298c446c-d165-0cca-aa03-f0d13cfa9c9e@redhat.com>
In-Reply-To: <298c446c-d165-0cca-aa03-f0d13cfa9c9e@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Sep 2023 17:02:51 +0400
Message-ID: <CAJ+F1C+83O2NNqBu6pCP4OjMkA9pSgA1tviDtUiaox1eGjXt2Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] vhost-user-gpu: skip VHOST_USER_GPU_UPDATE when
 !PIXMAN
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Tue, Sep 19, 2023 at 4:56=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 9/18/23 15:51, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > This simply means that 2d drawing updates won't be handled, but 3d
> > should work.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> How bad is this?  Is it worth making the device dependent on pixman
> altogether?
>

It will issue warnings for 2d commands, and display a blank output.
But 3d / dmabuf will be displayed.

(ideally, some day when QEMU won't do any graphics/ui, the
GPU/renderer process will issue the draw commands to a client
directly, without going through the QEMU process - using
org.qemu.Display1.Listener DBus interface)

--=20
Marc-Andr=C3=A9 Lureau

