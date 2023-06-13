Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F4172EA3C
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 19:52:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q98A8-0008LI-JU; Tue, 13 Jun 2023 13:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q98A6-0008L6-44
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 13:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q98A4-0002dk-Ey
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 13:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686678631;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFPs25z9ezE4cIHbEHAQveoqKwE26PofVA7ddsZV9T8=;
 b=h32VV/OP3KQE+LQaBymNOg367EBRsM16rWYCMo/wtIY6MnH6wX1ZvNaUcCZtWgQH9SFvXw
 7UEmtdMQGZ7S8UgURoLXBuv+1hr3huk6kqhIrPvJnvDw+qXK3LV4AbQBdgzyahAPFsHB+U
 1Zmq5q9/uMZZV2hOSmqzXnxMz+TEmy4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-MKGnPPYzPlm497TOQwJM7g-1; Tue, 13 Jun 2023 13:50:28 -0400
X-MC-Unique: MKGnPPYzPlm497TOQwJM7g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f7eb414fcbso28186375e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 10:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686678626; x=1689270626;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MFPs25z9ezE4cIHbEHAQveoqKwE26PofVA7ddsZV9T8=;
 b=Jh07W+mH7LQzJouPUOBbEZbORsuOpO0vZ2jtNegeB67DqbMWz8AEpnJir/N8PqOMpJ
 Ty0Ipn7Lz8IW0Q2uAY4nR9OWly/wraDjUpLZEhvWLxbDci3bSvAAsjgfaDMRXSrOvnUM
 55KIRMZ++OuJSDMIVNDmPrzJlwxVEFiRuAS9hIUqV/zGCd2ESZJ3dAZ+ajL1YSuuOgtc
 ZqgmAboJBnmkYshrx4VBDFC92UNiGGG5PPj7NUUPuJ/xQ1asnIVgIy3lJXJvs2uNqGDA
 izDqAk8hD/mk1wvzwnBnViNUFl2/ux2xhNDmg2xuoud7+8DCDwUr368IzGMAjWs/HbU8
 +FLw==
X-Gm-Message-State: AC+VfDx8dnd3hqGz6oNlxuVvhTSDAZXmm/RASw24o0mNFDtFJ973A2cU
 4k3N1R954n3QkstcMUT6x2HLrInXUGp5xVe5Lp5moVSOfOh2kPEWtCTOJZtqftgUBhg2tiJkMiy
 ThQFBARN0fs88IFk=
X-Received: by 2002:a1c:790f:0:b0:3f7:e629:9f3 with SMTP id
 l15-20020a1c790f000000b003f7e62909f3mr9062047wme.16.1686678626430; 
 Tue, 13 Jun 2023 10:50:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4HotOaAfBGCmKz4m6diP+WpUT1Dm1nvnT4Ge3FYK6q+M9taA2DhF5vuO+mV9SI5Jg+8u1hmg==
X-Received: by 2002:a1c:790f:0:b0:3f7:e629:9f3 with SMTP id
 l15-20020a1c790f000000b003f7e62909f3mr9062031wme.16.1686678626000; 
 Tue, 13 Jun 2023 10:50:26 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 o6-20020a05600c378600b003f7cb42fa20sm15085418wmr.42.2023.06.13.10.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 10:50:25 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v5 6/8] migration: Implement dirty-limit
 convergence algo
In-Reply-To: <168618975839.6361.17407633874747688653-6@git.sr.ht>
 (hyman@git.sr.ht's message of "Thu, 08 Jun 2023 00:12:40 +0800")
References: <168618975839.6361.17407633874747688653-6@git.sr.ht>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 13 Jun 2023 19:50:24 +0200
Message-ID: <87ttvbckv3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

~hyman <hyman@git.sr.ht> wrote:
> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>

To speed thinkng up, 1-5 are included on next Migration PULL request.

> Implement dirty-limit convergence algo for live migration,
> which is kind of like auto-converge algo but using dirty-limit
> instead of cpu throttle to make migration convergent.
>
> Enable dirty page limit if dirty_rate_high_cnt greater than 2
> when dirty-limit capability enabled, Disable dirty-limit if
> migration be cancled.

Nit: canceled.

>
> Note that "set_vcpu_dirty_limit", "cancel_vcpu_dirty_limit"
> commands are not allowed during dirty-limit live migration.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>


> + * Enable dirty-limit to throttle down the guest
> + */
> +static void migration_dirty_limit_guest(void)
> +{
> +    static int64_t quota_dirtyrate;

quota_dirtyrate deserves at least a comment.

I guess it means the current quota_dirty_rate that is set, but no clue.

> +    MigrationState *s =3D migrate_get_current();
> +
> +    /*
> +     * If dirty limit already enabled and migration parameter
> +     * vcpu-dirty-limit untouched.
> +     */
> +    if (dirtylimit_in_service() &&
> +        quota_dirtyrate =3D=3D s->parameters.vcpu_dirty_limit) {
> +        return;
> +    }
> +
> +    quota_dirtyrate =3D s->parameters.vcpu_dirty_limit;
> +
> +    /* Set or update quota dirty limit */
> +    qmp_set_vcpu_dirty_limit(false, -1, quota_dirtyrate, NULL);

Care to explain why do we have to "reset" the quota?  Or why we can't
set it when the user issues the command, only when we throttle the guest?

> +    trace_migration_dirty_limit_guest(quota_dirtyrate);
> +}
> +

Split this patch in two:

a - the logic change
b - the introduction of dirty limit.


Old code:

    /* During block migration the auto-converge logic incorrectly detects
     * that ram migration makes no progress. Avoid this by disabling the
     * throttling logic during the bulk phase of block migration. */
    if (blk_mig_bulk_active()) {
        return;
    }

    if (migrate_auto_converge()) {
        /* The following detection logic can be refined later. For now:
           Check to see if the ratio between dirtied bytes and the approx.
           amount of bytes that just got transferred since the last time
           we were in this routine reaches the threshold. If that happens
           twice, start or increase throttling. */

        if ((bytes_dirty_period > bytes_dirty_threshold) &&
            (++rs->dirty_rate_high_cnt >=3D 2)) {
            trace_migration_throttle();
            rs->dirty_rate_high_cnt =3D 0;
            mig_throttle_guest_down(bytes_dirty_period,
                                    bytes_dirty_threshold);
        }
    }

New code:
    /*
     * The following detection logic can be refined later. For now:
     * Check to see if the ratio between dirtied bytes and the approx.
     * amount of bytes that just got transferred since the last time
     * we were in this routine reaches the threshold. If that happens
     * twice, start or increase throttling.
     */

    if ((bytes_dirty_period > bytes_dirty_threshold) &&
        (++rs->dirty_rate_high_cnt >=3D 2)) {
        rs->dirty_rate_high_cnt =3D 0;
        /*
         * During block migration the auto-converge logic incorrectly detec=
ts
         * that ram migration makes no progress. Avoid this by disabling the
         * throttling logic during the bulk phase of block migration
         */
        if (blk_mig_bulk_active()) {
            return;
        }

        if (migrate_auto_converge()) {
            trace_migration_throttle();
            mig_throttle_guest_down(bytes_dirty_period,
                                    bytes_dirty_threshold);
        } else if (migrate_dirty_limit()) {
            migration_dirty_limit_guest();
        }
    }

Questions:

- Why are we changing blk_mig_bulk_active() position?

  I think that the old code have it in the right place.  Additionally,
  you just changefd to this version a couple of patches agon.




>                                   int64_t cpu_index,
>                                   Error **errp)
>  {
> +    MigrationState *ms =3D migrate_get_current();
> +
>      if (!kvm_enabled() || !kvm_dirty_ring_enabled()) {
>          return;
>      }
> @@ -453,6 +455,15 @@ void qmp_cancel_vcpu_dirty_limit(bool has_cpu_index,
>          return;
>      }
>=20=20
> +    if (migration_is_running(ms->state) &&
> +        (!qemu_thread_is_self(&ms->thread)) &&
> +        migrate_dirty_limit() &&
> +        dirtylimit_in_service()) {
> +        error_setg(errp, "can't cancel dirty page limit while"
> +                   " migration is running");

Error message is bad or wrong.
You can cancel the dirty page, you ust need to be on the main thread.

Or I am missing something?



> +        return;
> +    }
> +
>      dirtylimit_state_lock();
>=20=20
>      if (has_cpu_index) {
> @@ -488,6 +499,8 @@ void qmp_set_vcpu_dirty_limit(bool has_cpu_index,
>                                uint64_t dirty_rate,
>                                Error **errp)
>  {
> +    MigrationState *ms =3D migrate_get_current();
> +
>      if (!kvm_enabled() || !kvm_dirty_ring_enabled()) {
>          error_setg(errp, "dirty page limit feature requires KVM with"
>                     " accelerator property 'dirty-ring-size' set'")
> @@ -504,6 +517,15 @@ void qmp_set_vcpu_dirty_limit(bool has_cpu_index,
>          return;
>      }
>=20=20
> +    if (migration_is_running(ms->state) &&
> +        (!qemu_thread_is_self(&ms->thread)) &&
> +        migrate_dirty_limit() &&
> +        dirtylimit_in_service()) {
> +        error_setg(errp, "can't cancel dirty page limit while"
> +                   " migration is running");
> +        return;
> +    }

If you use such a complex expression twice, I think that creating a
helper function is a good idea.

Later, Juan.


