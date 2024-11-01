Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F04DB9B935A
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Nov 2024 15:35:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6sjp-0004jA-7O; Fri, 01 Nov 2024 10:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6sjm-0004iw-PN
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 10:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6sjk-0002wM-Lf
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 10:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730471690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lSwP5ULCOh4RJsbMxvrPDO6naBOLR9VvPeinVp3IrJ8=;
 b=EwjK9ErL3uheY9XVJTnyvSigPVqPGgsilvfvxBNHUfutUI7RUc7ZKlyQWSoXobm7/STKBB
 IVoIOfB7UT8Ij+1MCDE+AceLKey5QD9DvG3/cudGlsyDKGNH+BJKMMttI4eGJc4I0/hlsM
 dr3E2ilVOz98HLY9Wcaf0WpVZYm+SRQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-ACLP3NfFO5KBMDGIDLynqQ-1; Fri, 01 Nov 2024 10:34:49 -0400
X-MC-Unique: ACLP3NfFO5KBMDGIDLynqQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6cbead8eb2bso36037746d6.3
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 07:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730471689; x=1731076489;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSwP5ULCOh4RJsbMxvrPDO6naBOLR9VvPeinVp3IrJ8=;
 b=sRP0vdrIHY1KbartWiW+hVPURUT6Julcl3CBqnSDgx46YU7VmAnH+99sWRFh2I/DQN
 c2iecCKTp9mCo9wmyIEzOCLePfm8uWUCGZFVB0kwIkI9y8rcltmF0kKVMOazCm3eX/GT
 O5N+1YdTdZwAfX5v1BFFm2fSf5cKnZcFoMCfp9z88KwHAlf6BoUIpKlMNJX8qxZwFDwP
 HPXTD9DLnJ7x1aN3pVs7MUj0Uux29nQz0Zmz2jRJCTJyryi/XXRLMhGSrX+OUCe9fl1r
 qOKxGyOWARxNB/iFLUJkUOnkalJCgsOZu84/pM5kLZJ6wPF5KMOEWqxSABM+H6ADnuwD
 gLpg==
X-Gm-Message-State: AOJu0YxtLnMP7RTm63JnP2d59bb4Jf8WQxhZB/ORoLRFZWj7NU6qwjTJ
 fSSp4tn6/09SwMXtISsytpANlSWSn2mokm3AU8Z6QIYXumL+cwxgCKk3g+YVKsrWcpMe9ZgrP+1
 ccHgRqCZm8m3gAnGlvcb2LUq9XW90ruzJtp0mtlug9OXGzSej9AEP
X-Received: by 2002:a05:6214:5b05:b0:6cb:ea54:7ac with SMTP id
 6a1803df08f44-6d351ab25e8mr98208226d6.13.1730471689294; 
 Fri, 01 Nov 2024 07:34:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETNiIl1yXrgJSVpLPbc81vFs12XfxIGDJWU9oZH5xVaWw1iYwMPTyZMekQWI9Z134U72UjiQ==
X-Received: by 2002:a05:6214:5b05:b0:6cb:ea54:7ac with SMTP id
 6a1803df08f44-6d351ab25e8mr98207876d6.13.1730471688940; 
 Fri, 01 Nov 2024 07:34:48 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fa5569sm19825116d6.19.2024.11.01.07.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 07:34:48 -0700 (PDT)
Date: Fri, 1 Nov 2024 10:34:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
Message-ID: <ZyTnBwpOwXcHGGPJ@x1n>
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-3-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029150908.1136894-3-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Prasad,

On Tue, Oct 29, 2024 at 08:39:05PM +0530, Prasad Pandit wrote:
> @@ -1612,6 +1615,10 @@ postcopy_preempt_send_channel_done(MigrationState *s,
>       * postcopy_qemufile_src to know whether it failed or not.
>       */
>      qemu_sem_post(&s->postcopy_qemufile_src_sem);
> +
> +    /* Send magic value to identify postcopy channel on the destination */
> +    uint32_t magic = cpu_to_be32(POSTCOPY_MAGIC);
> +    qio_channel_write_all(ioc, (char *)&magic, sizeof(magic), NULL);

As we discussed internally, we can't do this unconditionally.  We at least
some compat properties.  Or we need to see whether Fabiano's handshake can
simplify this, because the handshake will also re-design the channel
establishment protocol.

Thanks,

>  }
>  
>  static void
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index a6df1b2811..49e2982558 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -15,6 +15,9 @@
>  
>  #include "qapi/qapi-types-migration.h"
>  
> +/* Magic value to identify postcopy channel on the destination */
> +#define POSTCOPY_MAGIC  0x55667788U
> +
>  /* Return true if the host supports everything we need to do postcopy-ram */
>  bool postcopy_ram_supported_by_host(MigrationIncomingState *mis,
>                                      Error **errp);
> -- 
> 2.47.0
> 

-- 
Peter Xu


