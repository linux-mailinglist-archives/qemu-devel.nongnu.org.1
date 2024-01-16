Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ADD82EAD7
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 09:25:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPeje-0002sS-G4; Tue, 16 Jan 2024 03:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPejc-0002rx-2H
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 03:23:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPeja-0003uQ-9s
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 03:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705393425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bHMQWhoV1jizHJXKzAtCOuTjIKTUEvDESSYy6fAQRjM=;
 b=IybCShJQKBkyQA7vn5+7VvybmDWMPE1R/O/3vnsN6AAP3wt/nhUw0tqEV/eI/ZKk1Qqzys
 73i6yUSbx1utbvJVnqE7KdiN4fUnYf+Qq4iW66tcthlACXhxYD2dNpcRaxF9dlm6QvIQQP
 /4XujO5CC7u0naEFcLfF3wlI925RJTg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-K5B2D90fNjupNTVBVOcNfw-1; Tue, 16 Jan 2024 03:23:43 -0500
X-MC-Unique: K5B2D90fNjupNTVBVOcNfw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6d724647a7fso1635834b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 00:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705393422; x=1705998222;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHMQWhoV1jizHJXKzAtCOuTjIKTUEvDESSYy6fAQRjM=;
 b=uWu9Gotlsm8lEotTqgJnrOMDwCbs0QVGaDkuuTYuO+mt3zZFG2Gfq/aUQ6Co0geNP7
 5DO5sNDKSFSgYe4LwCeRDwHUqXthyDgnaMCIZXtnmaadl3gu7udpDLGilkj73gAzqXqj
 eT/RaY99/LHWCApjciK/xV82ATqIYdbWtavyJATuHbLckrvsSPI4y8t5mk74LT98rRHx
 wR6ADzO9RKltb1lbRD3VzR/fbwf1ArXwWACykCsHw881OdEEPLU5A3uUSWFS82O47nYL
 dRRQUieVcSgZalsiJ1Ggej+pIcqscfaF3k0jbFV2BMqrYD31rUI7Ds4Es2cmSgw2RhXe
 05Rw==
X-Gm-Message-State: AOJu0YwixSwCHxcM5Yw/wJZKcQa5XbLho1G+piLo0a2VFxcn7TMYwZ54
 qQFZ9us+2XvWQsQ4XNWZuXSzTlJKZOOu8ABHUGxcbu60SyZg9jCfPJ7UWxsFNTEsncd9tpD8jGY
 MrY/r+I4py5ocyB8isRstwkw=
X-Received: by 2002:a05:6a20:24a8:b0:19a:56ef:b88a with SMTP id
 m40-20020a056a2024a800b0019a56efb88amr13103697pzd.3.1705393422258; 
 Tue, 16 Jan 2024 00:23:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLbDvjUC5UmDFL3dYupr4idvpYekiiSrLt6WS00p6Qg2lbTDCbWKGcChkW9844yOyQfTxb9A==
X-Received: by 2002:a05:6a20:24a8:b0:19a:56ef:b88a with SMTP id
 m40-20020a056a2024a800b0019a56efb88amr13103685pzd.3.1705393421933; 
 Tue, 16 Jan 2024 00:23:41 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 kq14-20020a170903284e00b001d3ec25614bsm8829022plb.24.2024.01.16.00.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 00:23:41 -0800 (PST)
Date: Tue, 16 Jan 2024 16:23:34 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 19/30] migration/ram: Ignore multifd flush when
 doing fixed-ram migration
Message-ID: <ZaY9Bl4GOD9BbumD@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-20-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127202612.23012-20-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Nov 27, 2023 at 05:26:01PM -0300, Fabiano Rosas wrote:
> Some functionalities of multifd are incompatible with the 'fixed-ram'
> migration format.
> 
> The MULTIFD_FLUSH flag in particular is not used because in fixed-ram
> there is no sinchronicity between migration source and destination so
> there is not need for a sync packet. In fact, fixed-ram disables
> packets in multifd as a whole.
> 
> However, we still need to sync the migration thread with the multifd
> channels at key moments:
> 
> - between iterations, to avoid a slow channel being overrun by a fast
> channel in the subsequent iteration;
> 
> - at ram_save_complete, to make sure all data has been transferred
>   before finishing migration;

[1]

> 
> Make sure RAM_SAVE_FLAG_MULTIFD_FLUSH is only emitted for fixed-ram at
> those key moments.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/ram.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 08604222f2..ad6abd1761 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1363,7 +1363,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>          pss->page = 0;
>          pss->block = QLIST_NEXT_RCU(pss->block, next);
>          if (!pss->block) {
> -            if (migrate_multifd() &&
> +            if (migrate_multifd() && !migrate_fixed_ram() &&
>                  !migrate_multifd_flush_after_each_section()) {
>                  QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
>                  int ret = multifd_send_sync_main(f);
> @@ -3112,7 +3112,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>          return ret;
>      }
>  
> -    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
> +    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
> +        && !migrate_fixed_ram()) {
>          qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>      }
>  
> @@ -3242,8 +3243,11 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>  out:
>      if (ret >= 0
>          && migration_is_setup_or_active(migrate_get_current()->state)) {
> -        if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
> -            ret = multifd_send_sync_main(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);
> +        if (migrate_multifd() &&
> +            (migrate_multifd_flush_after_each_section() ||
> +             migrate_fixed_ram())) {
> +            ret = multifd_send_sync_main(
> +                rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);

Why you want this one?  ram_save_iterate() can be called tens for each
second iiuc.

There's one more?  ram_save_complete():

    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
    }

IIUC that's the one you referred to at [1] above, not sure why you modified
the code in ram_save_iterate() instead.

>              if (ret < 0) {
>                  return ret;
>              }
> -- 
> 2.35.3
> 

Since the file migration added its whole new code in
multifd_send_sync_main(), now I'm hesitating whether we should just provide
multifd_file_sync_threads(), put file sync there, and call explicitly,
like:

  if (migrate_multifd()) {
    if (migrate_is_file()) {
       multifd_file_sync_threads();
    } else if (migrate_multifd_flush_after_each_section()) {
       multifd_send_sync_main();
    }
  }

It'll be much clearer that file goes into its own path and we don't need to
worry on fat eyes of those if clauses.  diff should be similar.

-- 
Peter Xu


