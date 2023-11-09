Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC87E7E71CF
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 19:58:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1ADx-0001jR-Ji; Thu, 09 Nov 2023 13:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r1ADw-0001h9-57
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:57:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r1ADu-0006vG-P4
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699556269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3zSW0ND6mhlUYh6z2ZYzl7B8mtM47oZvn/oWM0bkJp4=;
 b=DieL+yNlkzYFAvflHW2TFXmn108H1bRlgkiDLyg+Fv9PbuDTgnpQqLHermZYI0iFpc2ee2
 zl3n7v0oQchncT8+shYx1Ij0MHzFJ+Kg8ol9XXwwDwPh/HoT+jogy2WEOEuZf6Ab63XD1f
 z+qQbm2nHkmJpp9sYY2DYKB7jzAPu1U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-Lx74c1YOO0GzC9F2-R7kNg-1; Thu, 09 Nov 2023 13:57:46 -0500
X-MC-Unique: Lx74c1YOO0GzC9F2-R7kNg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-41e1ecf3350so3336971cf.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 10:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699556266; x=1700161066;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zSW0ND6mhlUYh6z2ZYzl7B8mtM47oZvn/oWM0bkJp4=;
 b=cJdevXmn08Y2t7RvIhBJgbUfgal5b9UmA0+1DjcnZm6jC5JU3fh+7C+Fp3PD1UHRO1
 +fADwNmkU4Qre6b9RxS+tCgZsZUqIZLcSPY49y/PdsDuRjKYcT1LuZQyX7bonfabDSXM
 iSIC1J4eM5/a7q6CBCRSZp4i67BB7hEq11GlFFv/YJOB581Ue+HXQUpEt4w2oeYWmk6C
 Hzqyu18P9OpKOl8rqxERPU+ziCRLWLWGU7A+5/j2ln182dNoJqhf14/pmAm5qJOmIi1W
 DTfyBVB/YxdmhzSoYWqxldtKxrvBaboDXikmgtKGvDvUfc49y8E4/BQ7RCMD1xdjz3h+
 U6Hg==
X-Gm-Message-State: AOJu0YztUtre0bik6ZYHPK3yD1OHZPAV2wplqKitgaEUSLbo9nMR8N1n
 ZTJiFpBVD7v+puC/DLJeK42MHB0LydP/J3kgK0U+d7G77XmWfAiH4fBEDnTp4r8AZ4skey4sNM4
 i/oqxx32BTQ4ukOU0xvvaK5o=
X-Received: by 2002:a05:622a:250d:b0:403:c2fa:83b with SMTP id
 cm13-20020a05622a250d00b00403c2fa083bmr6939595qtb.4.1699556266225; 
 Thu, 09 Nov 2023 10:57:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENI5UfkQrExkngSqIj0EEI2Vg82/KJeNnEAlIrAYj7zutED4bl45gg37hn69SvZ0XFscKemw==
X-Received: by 2002:a05:622a:250d:b0:403:c2fa:83b with SMTP id
 cm13-20020a05622a250d00b00403c2fa083bmr6939579qtb.4.1699556265926; 
 Thu, 09 Nov 2023 10:57:45 -0800 (PST)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 cj17-20020a05622a259100b004196a813639sm2187411qtb.17.2023.11.09.10.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 10:57:45 -0800 (PST)
Date: Thu, 9 Nov 2023 13:57:44 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH 1/2] migration: Report error in incoming migration
Message-ID: <ZU0rqJv0IHzaY5aW@x1n>
References: <20231109165856.15224-1-farosas@suse.de>
 <20231109165856.15224-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109165856.15224-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Nov 09, 2023 at 01:58:55PM -0300, Fabiano Rosas wrote:
> We're not currently reporting the errors set with migrate_set_error()
> when incoming migration fails.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 28a34c9068..cca32c553c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -698,6 +698,13 @@ process_incoming_migration_co(void *opaque)
>      }
>  
>      if (ret < 0) {
> +        MigrationState *s = migrate_get_current();
> +
> +        if (migrate_has_error(s)) {
> +            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> +                error_report_err(s->error);
> +            }
> +        }

What's the major benefit of dumping this explicitly?

And this is not relevant to the multifd problem, correct?

>          error_report("load of migration failed: %s", strerror(-ret));
>          goto fail;
>      }
> -- 
> 2.35.3
> 

-- 
Peter Xu


