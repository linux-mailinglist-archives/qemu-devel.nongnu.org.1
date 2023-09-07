Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 259D679730F
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 16:26:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeFx2-0002Fi-18; Thu, 07 Sep 2023 10:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeFwz-0002FP-Vf
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 10:25:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeFwx-000224-E9
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 10:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694096734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eWrbNjnMqoWek1b6w6E8Dx7zZQkMjAp5yTuwlJyXq/A=;
 b=BVA3bjYYiE1zF0u1yMLY+ORcMZnJHf6Gq+j6oCUTqDaPYPUCh/j6DCgNMrSusPpfs6PwNd
 hLQuMgBCg8TCUGzGwIf2Xhy4baYwd7WfNWTOl+qXbIXMBd9DoCjqtpGcOzAw0R+58Ec81U
 MYCYUz43sh4+2glNJe8pDxPasBiaRhA=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-Hufp1zuuODmKqy9UWflVcg-1; Thu, 07 Sep 2023 10:25:32 -0400
X-MC-Unique: Hufp1zuuODmKqy9UWflVcg-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-48d10c6b0easo399738e0c.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 07:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694096732; x=1694701532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eWrbNjnMqoWek1b6w6E8Dx7zZQkMjAp5yTuwlJyXq/A=;
 b=i6jl9qOSrd7JZMkAr8OrzmM2lCqQzhsfROU2s7ydt5c0vvPk0iYThIBEpnmDxApj9z
 mcRvwihFv8ZrIKRZM80fRXy0lDbrCKAnqjD5oIahrO6RCKH7xwK88fHQ9iRuqRvHLlAl
 PAMj9+kyUIyvzytjniHpkT0Zph67NTmQjo845CsCqg0FyE15b4ZJYF+knZAJ4ND4vLgY
 YPi92ebDgb9JKXyQutAlm6bdHl2TEMugUqgxGjkT/TaInUDcfCzOyzEnEHIzr7xtBH0q
 oymiC/aoBbujb3xZ/P9HEYPSfOvbjzdRHJoARWBN/GP9Ktm5HjVwq5txzCgFs6+GYa39
 Cr9A==
X-Gm-Message-State: AOJu0YwCWUzpHAwEg8DR67Pfg+TDqjucimOIgWjSRuj19MjsSM0Yjo4L
 C3Q8CfN3/2gxe/kDEgrvyVzpIsu5Txs50ZpBHbp4m0Thnx8yunJfpUieHk1/bdIHwm8cN88zFmP
 nAhoodJ5Q8G/vrsUwMlHI+myqaIMogPY=
X-Received: by 2002:a05:6102:3553:b0:44e:9168:918e with SMTP id
 e19-20020a056102355300b0044e9168918emr6076568vss.29.1694096732242; 
 Thu, 07 Sep 2023 07:25:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3PHn2u8Ikckcg5SgqYP9phv+KP6SzTatdvs1+xMCFz0+7Dtj7tgw9Onv+hFNdP9QJh9vA+QAvX92ZToC/gUY=
X-Received: by 2002:a05:6102:3553:b0:44e:9168:918e with SMTP id
 e19-20020a056102355300b0044e9168918emr6076553vss.29.1694096732007; Thu, 07
 Sep 2023 07:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230906190141.1286893-1-stefanha@redhat.com>
 <1fa3ad95-c335-7e97-42f0-00dca5c5ba48@redhat.com>
 <20230907140006.GA1363873@fedora>
In-Reply-To: <20230907140006.GA1363873@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 7 Sep 2023 16:25:19 +0200
Message-ID: <CABgObfZXE+AupVGZTbm-W4RXbQPBiqSAgo+U4k1Eza=U1sortA@mail.gmail.com>
Subject: Re: [RFC 0/3] qmp: make qmp_device_add() a coroutine
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 kwolf@redhat.com, Maxim Levitsky <mlevitsk@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 7, 2023 at 4:00=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
> While I agree that the issue would not happen if monitor commands only
> ran in the iohandler AioContext, I don't think we can change that.
> When Kevin implemented coroutine commands in commit 9ce44e2ce267 ("qmp:
> Move dispatcher to a coroutine"), he used qemu_get_aio_context()
> deliberately so that AIO_WAIT_WHILE() can make progress.

Ah, you are referring to

+        /*
+         * Move the coroutine from iohandler_ctx to qemu_aio_context for
+         * executing the command handler so that it can make progress if i=
t
+         * involves an AIO_WAIT_WHILE().
+         */
+        aio_co_schedule(qemu_get_aio_context(), qmp_dispatcher_co);
+        qemu_coroutine_yield();

> I'm not clear on the exact scenario though, because coroutines shouldn't
> call AIO_WAIT_WHILE().

I think he meant "so that an AIO_WAIT_WHILE() invoked through a bottom
half will make progress on the coroutine as well".

However I am not sure the comment applies here, because
do_qmp_dispatch_bh() only applies to non-coroutine commands; that
commit allowed monitor commands to run in vCPU threads when they
previously weren't.

Thinking more about it, I don't like that the

    if (!!(cmd->options & QCO_COROUTINE) =3D=3D qemu_in_coroutine()) {
    }

check is in qmp_dispatch() rather than monitor_qmp_dispatch().

Any caller of qmp_dispatch() knows if it is in a coroutine or not.
qemu-ga uses neither a coroutine dispatcher nor coroutine commands.
QEMU uses non-coroutine dispatch for out-of-band commands (and we can
forbid coroutine + allow-oob at the same time), and coroutine dispatch
for the others.

So, moving out of coroutine context (through a bottom half) should be
done by monitor_qmp_dispatch(), and likewise moving temporarily out of
the iohandler context in the case of coroutine commands. In the case
of !req_obj->req you don't need to do either of those. qmp_dispatch()
can still assert that the coroutine-ness of the command matches the
context in which qmp_dispatch() is called.

Once this is done, I think moving out of coroutine context can use a
BH that runs in the iohandler context.


Paolo


