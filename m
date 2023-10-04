Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2C77B8608
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:01:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5F3-00056d-V1; Wed, 04 Oct 2023 13:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo5Es-00054u-Jx
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:00:46 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo5En-0003uG-Et
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:00:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C98C1F893;
 Wed,  4 Oct 2023 17:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696438836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o5gcbVQCzNDyA5fibEWE18INiNUE6IAqyvpTW4m7chI=;
 b=fDuynTRC8iCNp5X4G6yNnIbgZaRFk0pkrvptYxuWGW6aBJqL1bRR4GHwaQY/kWKNTbtZ/n
 qEifs698vcuSqVaAjwYoUhw711Mfr8nHdhAXWQx8+zi+VqJlu0KNOZoCV/SV0JW0GZJ8x8
 uA/noKyYltlbkvfBo00YJh2elEztixY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696438836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o5gcbVQCzNDyA5fibEWE18INiNUE6IAqyvpTW4m7chI=;
 b=uBjFeBEma4lmCeHIjvdtRZUYsckL3uuDddidZ+Fxo2bQBqwnnQ16wi3humJQEyAGVC/Mad
 qf51lgEM7TPri1CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 933C613A2E;
 Wed,  4 Oct 2023 17:00:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1smIFzOaHWXuSwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 04 Oct 2023 17:00:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 02/10] migration/rdma: Unfold
 ram_control_before_iterate()
In-Reply-To: <20231004124913.16360-3-quintela@redhat.com>
References: <20231004124913.16360-1-quintela@redhat.com>
 <20231004124913.16360-3-quintela@redhat.com>
Date: Wed, 04 Oct 2023 14:00:33 -0300
Message-ID: <87zg0ynwzy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Juan Quintela <quintela@redhat.com> writes:

> Once there:
> - Remove unused data parameter
> - unfold it in its callers.
> - change all callers to call qemu_rdma_registration_start()
> - We need to call QIO_CHANNEL_RDMA() after we check for migrate_rdma()
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> --
>
> initilazize rioc after checknig that rdma is enabled.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/qemu-file.h |  2 --
>  migration/rdma.h      |  7 +++++++
>  migration/qemu-file.c | 13 +------------
>  migration/ram.c       | 16 +++++++++++++---
>  migration/rdma.c      | 12 ++++--------
>  5 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index 03e718c264..d6a370c569 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -55,7 +55,6 @@ typedef int (QEMURamSaveFunc)(QEMUFile *f,
>                                size_t size);
>  
>  typedef struct QEMUFileHooks {
> -    QEMURamHookFunc *before_ram_iterate;
>      QEMURamHookFunc *after_ram_iterate;
>      QEMURamHookFunc *hook_ram_load;
>      QEMURamSaveFunc *save_page;
> @@ -127,7 +126,6 @@ void qemu_fflush(QEMUFile *f);
>  void qemu_file_set_blocking(QEMUFile *f, bool block);
>  int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
>  
> -void ram_control_before_iterate(QEMUFile *f, uint64_t flags);
>  void ram_control_after_iterate(QEMUFile *f, uint64_t flags);
>  void ram_control_load_hook(QEMUFile *f, uint64_t flags, void *data);
>  
> diff --git a/migration/rdma.h b/migration/rdma.h
> index de2ba09dc5..670c67a8cb 100644
> --- a/migration/rdma.h
> +++ b/migration/rdma.h
> @@ -22,4 +22,11 @@ void rdma_start_outgoing_migration(void *opaque, const char *host_port,
>  
>  void rdma_start_incoming_migration(const char *host_port, Error **errp);
>  
> +
> +#ifdef CONFIG_RDMA
> +int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags);
> +#else
> +static inline
> +int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags) { return 0; }
> +#endif
>  #endif
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 5e8207dae4..1a8170421f 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -32,6 +32,7 @@
>  #include "trace.h"
>  #include "options.h"
>  #include "qapi/error.h"
> +#include "rdma.h"
>  
>  #define IO_BUF_SIZE 32768
>  #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
> @@ -288,18 +289,6 @@ void qemu_fflush(QEMUFile *f)
>      f->iovcnt = 0;
>  }
>  
> -void ram_control_before_iterate(QEMUFile *f, uint64_t flags)
> -{
> -    int ret = 0;
> -
> -    if (f->hooks && f->hooks->before_ram_iterate) {
> -        ret = f->hooks->before_ram_iterate(f, flags, NULL);
> -        if (ret < 0) {
> -            qemu_file_set_error(f, ret);
> -        }
> -    }
> -}
> -
>  void ram_control_after_iterate(QEMUFile *f, uint64_t flags)
>  {
>      int ret = 0;
> diff --git a/migration/ram.c b/migration/ram.c
> index e4bfd39f08..407760b3a2 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -59,6 +59,7 @@
>  #include "qemu/iov.h"
>  #include "multifd.h"
>  #include "sysemu/runstate.h"
> +#include "rdma.h"
>  #include "options.h"
>  #include "sysemu/dirtylimit.h"
>  #include "sysemu/kvm.h"
> @@ -3054,7 +3055,10 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>          }
>      }
>  
> -    ram_control_before_iterate(f, RAM_CONTROL_SETUP);
> +    ret = qemu_rdma_registration_start(f, RAM_CONTROL_SETUP);
> +    if (ret < 0) {
> +        qemu_file_set_error(f, ret);

Markus' patch 23 will turn the return code from
qemu_rdma_registration_start() from -EIO into -1. Any code that uses
strerr to report it will now see an EPERM (-1).

We should someday give an Error argument to savevm functions and stop
using QEMUFile as an error carrier. Or perhaps add an Error pointer to
RAMState?

Anyway, out scope for this patch.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

