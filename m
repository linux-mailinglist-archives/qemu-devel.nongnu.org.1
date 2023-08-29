Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EF678C80D
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:54:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb05o-0005xk-TZ; Tue, 29 Aug 2023 10:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb05k-0005vu-TA
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb05e-000834-Cb
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693320789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fBVFd+qoQt2TgRrisD2K6gmspq2o8c+asRoc9j1e1tw=;
 b=Svpthx6FZYQQULYFCfBL71sY34mt1p/FVXOLpWkw0SbCVln1RtA+29cGt2EesiYTL3hq2I
 auncRaMAY8EBroJAItcxXSHPOPfS2DGIANu+hyb6MueDSIJjVhQe8x02GzNuja4HkpE6Vo
 TCrWd8uh9tz5jszIgoyvNaS5VRkVnRA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-tlYrhEB0NASPHaJciKTmZg-1; Tue, 29 Aug 2023 10:53:07 -0400
X-MC-Unique: tlYrhEB0NASPHaJciKTmZg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-63d2b88325bso8634296d6.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693320785; x=1693925585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBVFd+qoQt2TgRrisD2K6gmspq2o8c+asRoc9j1e1tw=;
 b=RhkTCLHbZ/K00vm1a5iQA+ZlUPmTLvubG6wBOa3CRV77Er4RqLxI1CVdqPBvpRuwEu
 TxCfmcjA7aF33hxkFku9I92x4OXW8AAXvXk3KlxcgqOPdFm+VnGm7F9avVzJJqRJQ4Hv
 YxQ0UhOVPVYXV0WbhCwgjnjHieQ7PF1YJxGJvhlh45fk5tXoLXxv/8T+meH//HFySu35
 sOqBf3PbZxwyYn02xlDrOIG4jzUGRvwTzQ2adYHbTX0EJ7aUuJgQgg8uQREkqjITxlWz
 +Aykzj27qcvbQIgg5dEiDXIxCJKadLyGeX+aIqcpNO+GduSuhTd8znw8q+LVTK2/E4m7
 2Wkg==
X-Gm-Message-State: AOJu0YzecRLKC88ZZavziV7+rWcrMX7p4w95mZXEdEHI1BLBRUPN4/0f
 QimIioSgadF5VYOq2Nyf2hL55LV9ukvZLOPDze09ZdJM9JDnRczvVyHa1HKWPn4ruE/OTeIvRpb
 1y638DGZzYMdrxtg=
X-Received: by 2002:ad4:5dc9:0:b0:63f:89d3:bf21 with SMTP id
 m9-20020ad45dc9000000b0063f89d3bf21mr33141077qvh.5.1693320785164; 
 Tue, 29 Aug 2023 07:53:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgh1bnG5nfhh3EDaCJc5iu7qNWp016FgbR0eLJmT5wgN0w9DLKQuqN8TKHANEXtRnmVyS/Hg==
X-Received: by 2002:ad4:5dc9:0:b0:63f:89d3:bf21 with SMTP id
 m9-20020ad45dc9000000b0063f89d3bf21mr33141060qvh.5.1693320784851; 
 Tue, 29 Aug 2023 07:53:04 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 p17-20020ae9f311000000b007677347e20asm3129694qkg.129.2023.08.29.07.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 07:53:04 -0700 (PDT)
Date: Tue, 29 Aug 2023 10:53:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
Subject: Re: [PATCH 5/6] vfio/migration: Block VFIO migration with postcopy
 migration
Message-ID: <ZO4GTnuqSORbvePL@x1n>
References: <20230828151842.11303-1-avihaih@nvidia.com>
 <20230828151842.11303-6-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828151842.11303-6-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Mon, Aug 28, 2023 at 06:18:41PM +0300, Avihai Horon wrote:
> diff --git a/migration/options.c b/migration/options.c
> index 1d1e1321b0..e201053563 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -499,6 +499,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>              error_setg(errp, "Postcopy is not yet compatible with multifd");
>              return false;
>          }
> +
> +        if (migration_vfio_mig_active()) {
> +            error_setg(errp, "Postcopy is not compatible with VFIO migration");
> +            return false;
> +        }

Hmm.. this will add yet another vfio hard-coded line into migration/..

What will happen if the vfio device is hot plugged after enabling
postcopy-ram here?

Is it possible to do it in a generic way?

I was thinking the only unified place to do such check is when migration
starts, as long as we switch to SETUP all caps are locked and doesn't allow
any change until it finishes or fails.

So, can we do this check inside vfio_save_setup(), allow vfio_save_setup()
to fail the whole migration early?  For example, maybe we should have an
Error** passed in, then if it fails it calls migrate_set_error, so
reflected in query-migrate later too.

Thanks,

>      }
>  
>      if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
> @@ -612,6 +617,16 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>      return true;
>  }

-- 
Peter Xu


