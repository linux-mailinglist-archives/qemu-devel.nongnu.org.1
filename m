Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D1C7DD6FB
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 21:17:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxvAK-0006jh-7i; Tue, 31 Oct 2023 16:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxvAI-0006jW-WF
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:16:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxvAH-00030E-BQ
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698783399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yOgoBxE4nsw317C6pSx6aqlazhPisf2NS0K6nEMNNbI=;
 b=IRijgHIvFkhbBC+gvGHvAq0dNB+jGWv4eGuuWKhPclaDtDFpZ/ZQz/O2/mOIJw9dJABi90
 F8JpWkGnZ7dKCFyDEcC1BUmJeRPxSP2mNO3tjRx6L33sA3d/yC8Ad47Q7J1cCMZomIojAI
 ZQglfKvdhF0u1lEhBNyZM/i21cH5+pk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-9MeUIar8OKym-QI1SZdZFg-1; Tue, 31 Oct 2023 16:16:38 -0400
X-MC-Unique: 9MeUIar8OKym-QI1SZdZFg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7789cde7421so63041585a.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 13:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698783098; x=1699387898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOgoBxE4nsw317C6pSx6aqlazhPisf2NS0K6nEMNNbI=;
 b=r5Dedsx5uV/y7cKd3wSfIF1jqM3nTCyLPUyWUvgTmKIFeRhJft6IxxJcIV5Nhef59y
 jhMCwi2D+iqpMI2lDULh3ApOsncQTJv+4easrED7g78uAbePVwpHeqCK6MaVDPCeGm11
 9A1+PjA1TvYX8eKJmO7N5cJwUS3hrzBmoy3NdCIEXVWOz2y5LkWGNXf+Yx8fk7QjUxkP
 xDvP5o8FURCMb5OqRHV9AAMNZWnMRTedMHmH8TOX2zu1whrrmcOuuwaEAtkx/B+D+xcr
 mpKJZJNzqG0G8ecuUED3HLgKLGSjKeubnkuWOxEfqmWi7wyrSpkC1gSVdkiPsyzS4Sby
 /bJg==
X-Gm-Message-State: AOJu0Yz2DVA0IDuxCy0hZVp3JRKnsUqCZSms89X3gApxcXxDoG/5GbbC
 YVoWGLF5w8Vah7lI66BBchGPGdRKSwrnPjGErt4c0GBKv+VTLv9FwiVbE/lRVHSXDO4tv3a4GRH
 hbgR5tXXct0hDzn8=
X-Received: by 2002:a05:620a:26a4:b0:773:ad1f:3d5b with SMTP id
 c36-20020a05620a26a400b00773ad1f3d5bmr13158431qkp.0.1698783098070; 
 Tue, 31 Oct 2023 13:11:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY+TJTKB2Dea77tZ34iog8QiMAzdY/yXuYbr4uuMT0cwCu11ymNeEJec3iwOwIqpxLzkAmgg==
X-Received: by 2002:a05:620a:26a4:b0:773:ad1f:3d5b with SMTP id
 c36-20020a05620a26a400b00773ad1f3d5bmr13158418qkp.0.1698783097734; 
 Tue, 31 Oct 2023 13:11:37 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a14-20020a05620a02ee00b0076f21383b6csm786754qko.112.2023.10.31.13.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 13:11:37 -0700 (PDT)
Date: Tue, 31 Oct 2023 16:11:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 19/29] migration/multifd: Add outgoing QIOChannelFile
 support
Message-ID: <ZUFfd8GmSY3XilZv@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-20-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023203608.26370-20-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

On Mon, Oct 23, 2023 at 05:35:58PM -0300, Fabiano Rosas wrote:
> Allow multifd to open file-backed channels. This will be used when
> enabling the fixed-ram migration stream format which expects a
> seekable transport.
> 
> The QIOChannel read and write methods will use the preadv/pwritev
> versions which don't update the file offset at each call so we can
> reuse the fd without re-opening for every channel.
> 
> Note that this is just setup code and multifd cannot yet make use of
> the file channels.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/file.c      | 64 +++++++++++++++++++++++++++++++++++++++++--
>  migration/file.h      | 10 +++++--
>  migration/migration.c |  2 +-
>  migration/multifd.c   | 14 ++++++++--
>  migration/options.c   |  7 +++++
>  migration/options.h   |  1 +
>  6 files changed, 90 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/file.c b/migration/file.c
> index cf5b1bf365..93b9b7bf5d 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -17,6 +17,12 @@
>  
>  #define OFFSET_OPTION ",offset="
>  
> +static struct FileOutgoingArgs {
> +    char *fname;
> +    int flags;
> +    int mode;
> +} outgoing_args;
> +
>  /* Remove the offset option from @filespec and return it in @offsetp. */
>  
>  static int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
> @@ -36,13 +42,62 @@ static int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
>      return 0;
>  }
>  
> +static void qio_channel_file_connect_worker(QIOTask *task, gpointer opaque)
> +{
> +    /* noop */
> +}
> +
> +static void file_migration_cancel(Error *errp)
> +{
> +    MigrationState *s;
> +
> +    s = migrate_get_current();
> +
> +    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> +                      MIGRATION_STATUS_FAILED);

This doesn't sound right to set FAILED here, then call cancel() afterwards
(which will try to set it to CANCELLING).

For socket based, multifd sets error and kick main in
multifd_new_send_channel_cleanup().  Can it be done similarly, rather than
calling migration_cancel()?

> +    migration_cancel(errp);
> +}

-- 
Peter Xu


