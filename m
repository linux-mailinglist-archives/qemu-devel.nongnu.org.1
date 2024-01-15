Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F1782D57B
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 10:03:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPIrX-0002fa-Gy; Mon, 15 Jan 2024 04:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPIrV-0002d0-C3
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:02:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPIrK-0001AB-6w
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705309336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8JCjJqkTyBv3knU4BB6FG91YnlWnYj08TjG3nHk9u8=;
 b=OkTussfX0vOWugzMNUK95LAm3+qYPlimGiSBi42Rd58VDJpae58fh1GuyrSvnDxMOpVSMS
 VAx639tDPUENA0/0CZJngpkQ6uusO27QSl+U4QIxPiwBjGKcA8WV7cuC9zLzaqXa4KX6K9
 zjsirxUnxFy51/AhyrxF2xYtjBUM2Jc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-siT3J_MoMoG5FcpELcMdIQ-1; Mon, 15 Jan 2024 04:02:14 -0500
X-MC-Unique: siT3J_MoMoG5FcpELcMdIQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-28df9917b59so371244a91.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 01:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705309333; x=1705914133;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p8JCjJqkTyBv3knU4BB6FG91YnlWnYj08TjG3nHk9u8=;
 b=WCjWEpTCW4OqtFdNTb3Dc63SQCQmQoas4ZRfzxo3tAuTVm6/0BJ7CBOYXaJrNPk7r5
 sF6ceiTvquG3GKfcqO3K/ztZdiy9aTfbvjMNY5UPoVgtYvjKwbNVm7vEus9WzBhM18S4
 90kgGxjGwB4PflBr6nLTZQKUqTrUwXekPi3bKz557B8Y7R2lEcu4cnBgf5oGc+H8lps1
 5gkwzhnkMur32q/Oudju9i+EpcDLslPBZWHzZh/20Co6mtH6YcJs7YPTCv2G54P7YA8C
 7BZdcw92MrqjJdgAYCkvw2xItQlCQyCTWAwMi4dZnMojxfhCfr2QkuYTLq+IpWt3vdeh
 cFbQ==
X-Gm-Message-State: AOJu0YxJxwAwo00DoFHbeDE87+ben/TBbTJfw3mF8PUqjU4CoY5q81Hs
 qYSsTV7b0C/GnfLCfzVw48v2oa088qSeiMe9wixvNhCTDH/594L40p+zVkEa7qBLCOjTVNYvsh0
 YWKG1gZLJH+LsSre9+are30E=
X-Received: by 2002:a17:90a:734c:b0:28e:1e79:c5c2 with SMTP id
 j12-20020a17090a734c00b0028e1e79c5c2mr7020366pjs.1.1705309333493; 
 Mon, 15 Jan 2024 01:02:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7XLtd89cSEsX6GyOKY4tU03VuqurEJfUVKQazWxocYgf5kxJYxyh//Q4vKKAm1fexYvsLnw==
X-Received: by 2002:a17:90a:734c:b0:28e:1e79:c5c2 with SMTP id
 j12-20020a17090a734c00b0028e1e79c5c2mr7020346pjs.1.1705309333213; 
 Mon, 15 Jan 2024 01:02:13 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 w9-20020a170902a70900b001d49f61cb64sm7089939plq.262.2024.01.15.01.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 01:02:12 -0800 (PST)
Date: Mon, 15 Jan 2024 17:01:59 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 07/30] migration: Add fixed-ram URI compatibility
 check
Message-ID: <ZaT0h7wnXDc-5K4-@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127202612.23012-8-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Mon, Nov 27, 2023 at 05:25:49PM -0300, Fabiano Rosas wrote:
> The fixed-ram migration format needs a channel that supports seeking
> to be able to write each page to an arbitrary offset in the migration
> stream.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> - avoided overwriting errp in compatibility check
> ---
>  migration/migration.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 28a34c9068..897ed1db67 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -135,10 +135,26 @@ static bool transport_supports_multi_channels(SocketAddress *saddr)
>             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK;
>  }
>  
> +static bool migration_needs_seekable_channel(void)
> +{
> +    return migrate_fixed_ram();
> +}
> +
> +static bool transport_supports_seeking(MigrationAddress *addr)
> +{
> +    return addr->transport == MIGRATION_ADDRESS_TYPE_FILE;
> +}

What about TYPE_FD?  Is it going to be supported later?

> +
>  static bool
>  migration_channels_and_transport_compatible(MigrationAddress *addr,
>                                              Error **errp)
>  {
> +    if (migration_needs_seekable_channel() &&
> +        !transport_supports_seeking(addr)) {
> +        error_setg(errp, "Migration requires seekable transport (e.g. file)");
> +        return false;
> +    }
> +
>      if (migration_needs_multiple_sockets() &&
>          (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) &&
>          !transport_supports_multi_channels(&addr->u.socket)) {
> -- 
> 2.35.3
> 

-- 
Peter Xu


