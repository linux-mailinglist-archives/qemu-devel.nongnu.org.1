Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD807DCF33
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:27:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpi6-0005sq-Pp; Tue, 31 Oct 2023 10:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxpi4-0005sN-KK
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxpi0-00079g-IS
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698762427;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RJtTLKkQMxlWtu25jkcATIyN3947dtAMogIf8bXecMw=;
 b=U6IQgeoidL4QZ4fv5J5X2Pp1dOO1zBzhhIBOahVdjYSDum3WOgHuO95VKCigkbUR8IkmaT
 KfPvN2ej00Hb2FJ6GUWhsk1sNPQtYvK8bYf1YOigKPQF17xJGJJtRvWLrPuSjg5YshhUGf
 TIusZ49WwMrnQn4pymsKL/B6S/tFbVQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-QIDAS92ZNF22nZkFLwFQuw-1; Tue, 31 Oct 2023 10:26:46 -0400
X-MC-Unique: QIDAS92ZNF22nZkFLwFQuw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c51e44a4dbso57914671fa.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698762405; x=1699367205;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJtTLKkQMxlWtu25jkcATIyN3947dtAMogIf8bXecMw=;
 b=aQpktda4vYSBhG9Xwb2ZBgDD5UToiRNq0K5ZnsUIN0dtlZEUMKoVO5G78cv9sowLf4
 snomML7BlT0LMkizupoFqzH/OwJSSoDETwMICvQDkwsaUM9d6ggwYPihk5Wen5oapla6
 feRn6bx3eaUJRd/35glhv1dq46H5q/vbuy9dM3NxSn1H96Pjf+l8wskQRjgIBjPElquG
 5n9XC4e4SE49pva4Ay3cHFGXDVKF79OYdDM9MftnU0nXd1Eom2hX5Kv9CGskr8hFB0st
 Fcy3HxJTy0LcNRAu7tBMtg2mYeql/t1D/vue5OUYBcSDXNK1uLG4tvVGedl3Qfkdajto
 dpHQ==
X-Gm-Message-State: AOJu0YwU16BI7mNtmmgEWAI/jMUofFYVCeaQ6M4zG9Jso1tScoMtIGvs
 MKkGuhSqvlRlTmHJBSCb57L7phNWABO1V/xUQoWq2NnLeEOdB8nlWrpUD0BbuaAlDAGla1NTJJq
 RxjGGJdB+d+QZ+4s=
X-Received: by 2002:a2e:7411:0:b0:2bc:dcd6:97b1 with SMTP id
 p17-20020a2e7411000000b002bcdcd697b1mr9550565ljc.47.1698762404783; 
 Tue, 31 Oct 2023 07:26:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3YG28mKLcDUz5a6VY0ax58+cus/wDcPota+Bx0lN+UmE/bu3BxV7n62uDXX9LsjUGy39JRQ==
X-Received: by 2002:a2e:7411:0:b0:2bc:dcd6:97b1 with SMTP id
 p17-20020a2e7411000000b002bcdcd697b1mr9550553ljc.47.1698762404432; 
 Tue, 31 Oct 2023 07:26:44 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l26-20020a05600c1d1a00b0040839fcb217sm1983710wms.8.2023.10.31.07.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:26:43 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Xiaohui Li
 <xiaohli@redhat.com>
Subject: Re: [PATCH v4 2/5] migration: Allow network to fail even during
 recovery
In-Reply-To: <20231017202633.296756-3-peterx@redhat.com> (Peter Xu's message
 of "Tue, 17 Oct 2023 16:26:30 -0400")
References: <20231017202633.296756-1-peterx@redhat.com>
 <20231017202633.296756-3-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 15:26:42 +0100
Message-ID: <87il6m7tr1.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> Normally the postcopy recover phase should only exist for a super short
> period, that's the duration when QEMU is trying to recover from an
> interrupted postcopy migration, during which handshake will be carried out
> for continuing the procedure with state changes from PAUSED -> RECOVER ->
> POSTCOPY_ACTIVE again.
>
> Here RECOVER phase should be super small, that happens right after the
> admin specified a new but working network link for QEMU to reconnect to
> dest QEMU.
>
> However there can still be case where the channel is broken in this small
> RECOVER window.
>
> If it happens, with current code there's no way the src QEMU can got kicked
> out of RECOVER stage. No way either to retry the recover in another channel
> when established.
>
> This patch allows the RECOVER phase to fail itself too - we're mostly
> ready, just some small things missing, e.g. properly kick the main
> migration thread out when sleeping on rp_sem when we found that we're at
> RECOVER stage.  When this happens, it fails the RECOVER itself, and
> rollback to PAUSED stage.  Then the user can retry another round of
> recovery.
>
> To make it even stronger, teach QMP command migrate-pause to explicitly
> kick src/dst QEMU out when needed, so even if for some reason the migration
> thread didn't got kicked out already by a failing rethrn-path thread, the
> admin can also kick it out.
>
> This will be an super, super corner case, but still try to cover that.
>
> One can try to test this with two proxy channels for migration:
>
>   (a) socat unix-listen:/tmp/src.sock,reuseaddr,fork tcp:localhost:10000
>   (b) socat tcp-listen:10000,reuseaddr,fork unix:/tmp/dst.sock
>
> So the migration channel will be:
>
>                       (a)          (b)
>   src -> /tmp/src.sock -> tcp:10000 -> /tmp/dst.sock -> dst
>
> Then to make QEMU hang at RECOVER stage, one can do below:
>
>   (1) stop the postcopy using QMP command postcopy-pause
>   (2) kill the 2nd proxy (b)
>   (3) try to recover the postcopy using /tmp/src.sock on src
>   (4) src QEMU will go into RECOVER stage but won't be able to continue
>       from there, because the channel is actually broken at (b)
>
> Before this patch, step (4) will make src QEMU stuck in RECOVER stage,
> without a way to kick the QEMU out or continue the postcopy again.  After
> this patch, (4) will quickly fail qemu and bounce back to PAUSED stage.
>
> Admin can also kick QEMU from (4) into PAUSED when needed using
> migrate-pause when needed.
>
> After bouncing back to PAUSED stage, one can recover again.
>
> Reported-by: Xiaohui Li <xiaohli@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2111332
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
> -void migration_rp_wait(MigrationState *s)
> +int migration_rp_wait(MigrationState *s)
>  {
> +    /* If migration has failure already, ignore the wait */
> +    if (migrate_has_error(s)) {
> +        return -1;
> +    }
> +
>      qemu_sem_wait(&s->rp_state.rp_sem);
> +
> +    /* After wait, double check that there's no failure */
> +    if (migrate_has_error(s)) {
> +        return -1;
> +    }
> +
> +    return 0;
>  }

Shouldn't this be bool?

We have (too many) functions in migration that returns 0/-1 and set an
error, I think we should change them to return bool.  Or even just test
if err is set.

Later, Juan.


