Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F7F7D57CE
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:18:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvK5W-0002K4-4g; Tue, 24 Oct 2023 12:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvK5K-0002Hg-OY
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvK5I-0007e7-HC
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698164197;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4l/JYcVag3ltF7J2N8MhSrGvmgKhfevO2dAcFS12D1o=;
 b=fXLwhIzQs/fqJLVyvvXWRqBFdwkqAWvDt6jw02fEjziEUn+f2FhtbeUpy3CNbtSSw9lQT7
 BTtJOd/Mv6JA6MZPWRVp2qclXj6EiNVtzdREu5ELrxmm9AVAh4kqMy9wXE2f3hiWRpqR/2
 HysL6Akm/s/8+HclI+bzSmNaNGtjVgc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-FrDKxzfSONymGu6_2MHe4Q-1; Tue, 24 Oct 2023 12:16:30 -0400
X-MC-Unique: FrDKxzfSONymGu6_2MHe4Q-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c50d4a1a33so35449401fa.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698164189; x=1698768989;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4l/JYcVag3ltF7J2N8MhSrGvmgKhfevO2dAcFS12D1o=;
 b=aIHkjAqvfjkhyfbrn3ukfHa6+o1Ib437um7y232brwfP4+dwneemmikIcX/BSYr/zJ
 i1hX3BN94lDv4xCOyURIO1+iP3Vrlwg/b52Kv9r/luChg4KWMGtTNcB8lWqfVLZFnpqy
 cJ2nlJEETpOWqvpuT7mlEnLRH3LHbNEKVE82jI1GF/JRZ0EZT8nYiRYXK695ruyWI2zG
 Jfkur8NTQdTm58GTG+BHA2iIjg0D2pGc75TzmGj51d7YuTibnkqcMxn5YaX4dWtG3pQ/
 Nd7AJmi5Q0XZ+HOtC8j4lQARtRQiomir683b/3z61Unm9oR/j0etfQa65tHEE+2pkWg6
 +SVQ==
X-Gm-Message-State: AOJu0Ywvmodc5bbfhwBF81q4bOytHrTPufYJ7+EHESMM1zcEIpsRzWTk
 rXjUm/hEVZd+QcAQyiUYtZVrjCGEePsb63OckA4784NfzVq4AOpERjqiAkZiGakaobUGjf+/i4f
 yWNE1ar/YGuRDzkg=
X-Received: by 2002:a2e:7218:0:b0:2c5:4a0:f3cb with SMTP id
 n24-20020a2e7218000000b002c504a0f3cbmr8324963ljc.11.1698164189219; 
 Tue, 24 Oct 2023 09:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKV59SRU90us5xe+eP286M9WHKQKbJDN2SmalfK9l06cnCOOWHIZ4Er/I2htJBPwh4/j+tBA==
X-Received: by 2002:a2e:7218:0:b0:2c5:4a0:f3cb with SMTP id
 n24-20020a2e7218000000b002c504a0f3cbmr8324939ljc.11.1698164188786; 
 Tue, 24 Oct 2023 09:16:28 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 ay10-20020a05600c1e0a00b00405442edc69sm14623371wmb.14.2023.10.24.09.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 09:16:27 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhijian Li <lizhijian@fujitsu.com>,  Markus
 Armbruster <armbru@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Thomas
 Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] migration: Stop migration immediately in RDMA error
 paths
In-Reply-To: <20231024154008.512222-1-peterx@redhat.com> (Peter Xu's message
 of "Tue, 24 Oct 2023 11:40:08 -0400")
References: <20231024154008.512222-1-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 18:16:27 +0200
Message-ID: <878r7sknc4.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> In multiple places, RDMA errors are handled in a strange way, where it only
> sets qemu_file_set_error() but not stop the migration immediately.
>
> It's not obvious what will happen later if there is already an error.  Make
> all such failures stop migration immediately.
>
> Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>
> v2:
> - One more line squashed into to fix the build error...  Please ignore v1,
>   sorry for the noise.
>
> This patch is based on Thomas's patch:
>
> [PATCH v2] migration/ram: Fix compilation with -Wshadow=local
> https://lore.kernel.org/r/20231024092220.55305-1-thuth@redhat.com
>
> Above patch should have been queued by both Markus and Juan.
> ---
>  migration/ram.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 212add4481..1473bb593a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3034,11 +3034,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>      ret = rdma_registration_start(f, RAM_CONTROL_SETUP);
>      if (ret < 0) {
>          qemu_file_set_error(f, ret);
> +        return ret;

I agree

>      }
>  
>      ret = rdma_registration_stop(f, RAM_CONTROL_SETUP);
>      if (ret < 0) {
>          qemu_file_set_error(f, ret);
> +        return ret;

I agree

>      }
>  
>      migration_ops = g_malloc0(sizeof(MigrationOps));
> @@ -3104,6 +3106,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>          ret = rdma_registration_start(f, RAM_CONTROL_ROUND);
>          if (ret < 0) {
>              qemu_file_set_error(f, ret);
> +            goto out;

Seems sensible

>          }
>  
>          t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> @@ -3208,8 +3211,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>      rs->last_stage = !migration_in_colo_state();
>  
>      WITH_RCU_READ_LOCK_GUARD() {
> -        int rdma_reg_ret;
> -
>          if (!migration_in_postcopy()) {
>              migration_bitmap_sync_precopy(rs, true);
>          }
> @@ -3217,6 +3218,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>          ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
>          if (ret < 0) {
>              qemu_file_set_error(f, ret);
> +            break;

Please
              return ret;


We can do exactly the same with pages < 0.

>          }
>  
>          /* try transferring iterative blocks of memory */
> @@ -3240,9 +3242,10 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>  
>          ram_flush_compressed_data(rs);
>  
> -        rdma_reg_ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
> -        if (rdma_reg_ret < 0) {
> -            qemu_file_set_error(f, rdma_reg_ret);
> +        ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
> +        if (ret < 0) {
> +            qemu_file_set_error(f, ret);
> +            break;
>          }
>      }

And if we return here, we can just drop the:

    if (ret < 0) {
        return ret;
    }


At the ext of the loop.

Later, Juan.


