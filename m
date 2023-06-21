Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CD77390D5
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 22:36:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC4Xg-00063q-HE; Wed, 21 Jun 2023 16:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC4Xd-00063T-MB
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 16:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC4Xb-0007Zy-Qe
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 16:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687379698;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+iLdzV/Em04/sgfTq5BTurqyY8h9d9LGqxlS0m3thlk=;
 b=F38Vr7yPplu8VqlOPb1qkFx5wZkmpxbH6BiyXWM/W/xKMfr03SGJIXIQHpctlht/xnsOzm
 SEveDlrs4m8sWbOSHtVyEUHZ3quRHjpG1cB29bbc5Sb1LAJmcLxQIolqahCtCeju0VlBOX
 4jK577MTjegbLxfGjbph2UQtKYtr+8U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-tY2_VnUtOFOl6q7ZKH3XzQ-1; Wed, 21 Jun 2023 16:34:57 -0400
X-MC-Unique: tY2_VnUtOFOl6q7ZKH3XzQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f9b4d88f24so14342715e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 13:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687379696; x=1689971696;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+iLdzV/Em04/sgfTq5BTurqyY8h9d9LGqxlS0m3thlk=;
 b=Yo7b0qAbzpjDIt0pOWGWCqRKRktjg0TOLyB7b4b5ESwdey5eYFRcvJUkuH6hm0iL/b
 XfYYay3TLhZASr6VxHXUApRJ7LSnYhSdTXkKaNzxRbTGGGvHmMoYV1+bO1OcPmF2ufuo
 I3dIJPTvUPo6ash/jTHqGHRieeLWKRAc+QkLARYCfYO8WxuVYburBjzZFdCYtzxIQOPc
 op3cloQ1KXJ/kbldUyNSj4N+nftXd/XJH1zh1AResyLTXCbVG91ytIe//NggnwlNTn+O
 JXcuYFPwzDi1HSx3rGm1dvjCc82gJy7YNksIDgB+JG3x7ftziKtFehPYme8nYvkYgraq
 efHg==
X-Gm-Message-State: AC+VfDxuZCyNizU1jcAI2FBdoGUjDU8ogj+jRvtLV9hdhmqF/zbhTR8l
 hZEFONG2+cCude+BdV7h0rIUmMbdAmaEG0zcCnNyJ9oGOFKS2EVbiRgmpIJePtC9G100ml1xqYj
 NY7t+/acYpJZDb/Y=
X-Received: by 2002:a05:600c:cb:b0:3f9:b4a0:6061 with SMTP id
 u11-20020a05600c00cb00b003f9b4a06061mr140319wmm.34.1687379696333; 
 Wed, 21 Jun 2023 13:34:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4wpx8rT6xD5nmM1oSqFSzw38H2tlXIgdjdnQvs01S+hqDtRWUAYkOTEMMi6CwdjfXoWiMigA==
X-Received: by 2002:a05:600c:cb:b0:3f9:b4a0:6061 with SMTP id
 u11-20020a05600c00cb00b003f9b4a06061mr140306wmm.34.1687379696005; 
 Wed, 21 Jun 2023 13:34:56 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 q19-20020a1cf313000000b003f7361ca753sm16689965wmq.24.2023.06.21.13.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 13:34:55 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: peterx@redhat.com,  lei4.wang@intel.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] migration: enfocre multifd and postcopy preempt
 to be set before incoming
In-Reply-To: <20230606101910.20456-2-wei.w.wang@intel.com> (Wei Wang's message
 of "Tue, 6 Jun 2023 18:19:09 +0800")
References: <20230606101910.20456-1-wei.w.wang@intel.com>
 <20230606101910.20456-2-wei.w.wang@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 21 Jun 2023 22:34:54 +0200
Message-ID: <87ttv08sgh.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Wei Wang <wei.w.wang@intel.com> wrote:
> qemu_start_incoming_migration needs to check the number of multifd
> channels or postcopy ram channels to configure the backlog parameter (i.e.
> the maximum length to which the queue of pending connections for sockfd
> may grow) of listen(). So enforce the usage of postcopy-preempt and
> multifd as below:
> - need to use "-incoming defer" on the destination; and
> - set_capability and set_parameter need to be done before migrate_incoming
>
> Otherwise, disable the use of the features and report error messages to
> remind users to adjust the commands.
>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/options.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>

This bit is wrong

> @@ -998,11 +1013,22 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>  
>      /* x_checkpoint_delay is now always positive */
>  
> -    if (params->has_multifd_channels && (params->multifd_channels < 1)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "multifd_channels",
> -                   "a value between 1 and 255");
> -        return false;
> +    if (params->has_multifd_channels) {
> +        if (params->multifd_channels < 1) {
> +            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                       "multifd_channels",
> +                       "a value between 1 and 255");
> +            return false;
> +        }
> +        if (migrate_incoming_started()) {
> +            MigrationState *ms = migrate_get_current();
> +
> +            ms->capabilities[MIGRATION_CAPABILITY_MULTIFD] = false;
> +            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                       "multifd_channels",
> +                       "must be set before incoming starts");
> +            return false;
> +        }
>      }
>  
>      if (params->has_multifd_zlib_level &&

# Start of tls tests
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-3655124.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3655124.qmp,id=char0 -mon chardev=char0,mode=control -display none -accel kvm -accel tcg -name source,debug-threads=on -m 150M -serial file:/tmp/migration-test-5QEX61/src_serial -drive file=/tmp/migration-test-5QEX61/bootsect,format=raw    2>/dev/null -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-3655124.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3655124.qmp,id=char0 -mon chardev=char0,mode=control -display none -accel kvm -accel tcg -name target,debug-threads=on -m 150M -serial file:/tmp/migration-test-5QEX61/dest_serial -incoming unix:/tmp/migration-test-5QEX61/migsocket -drive file=/tmp/migration-test-5QEX61/bootsect,format=raw    2>/dev/null -accel qtest
# {
#     "error": {
#         "class": "GenericError",
#         "desc": "Parameter 'multifd_channels' expects must be set before incoming starts"
#     }
# }
**
ERROR:../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:1259:qtest_vqmp_assert_success_ref: assertion failed: (qdict_haskey(response, "return"))
not ok /x86_64/migration/postcopy/recovery/tls/psk - ERROR:../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:1259:qtest_vqmp_assert_success_ref: assertion failed: (qdict_haskey(response, "return"))
Bail out!
Aborted (core dumped)

This is the tests that fails.

        qtest_add_func("/migration/postcopy/preempt/plain", test_postcopy_preempt);

I am dropping that change and let the others, which are right.

I think what we should do is changing that check to:


static bool migration_has_started(void)
{
    MigrationIncomingState *mis = migration_incoming_get_current();

    if (mis->state != MIGRATION_STATUS_NONE) {
       return true;
    }
    MigrationState *ms = migration_get_current();
    if (mis->state != MIGRATION_STATUS_NONE) {
       return true;
    }
    return false;
}

And for all the parameters that can't be changed after migration has
started do:

    if (params->has_multifd_channels) {
        if (params->multifd_channels < 1) {
            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                       "multifd_channels",
                       "a value between 1 and 255");
            return false;
        }
        if (migration_has_started()) {
            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                       "multifd_channels",
                       "must be set before migration starts");
            return false;
        }
     }

Forr all parameters, can they be changed after migration has started:

compress_level: NO
compress_threads: NO
compress_wait_thread: NO
decompress_threads: NO
throttle_trigger_threshold: MAYBE
cpu_throttle_initial: NO
cpu_throttle_increment: NO?
cpu_throotle_tailslow: NO?
tls_creds: NO
tls_hostname: NO
max_bandwidth: YES
downtime_limit: YES
x_checkpoint_delay: NO?
block_incremental: NO
multifd_channels: NO
multifd_compression: NO
multifd_zlib_devel: NO
multifd_zstd_level: NO
xbzrle_cache_size: YES
max_cpu_throttle: YES?
announce_*: YES (but it shouldn't.  There is no good reason for changing
                 it in the middle of migration.  But no harm either)
block_bitmap_mapping: NO?
zero_copy_send: NO
vcpu_dirty_limit_period: NO?
vcpu_dirty_limit: NO?

For capabilities, I think none make sense to change after migration starts.

What do you think?

Later, Juan.


