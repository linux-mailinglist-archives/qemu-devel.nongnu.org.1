Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4D377E4E6
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 17:19:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWIIE-0001zQ-Fa; Wed, 16 Aug 2023 11:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWII7-0001yq-Rg
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWII3-0007Zu-HF
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692199099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B6+hKmxKNNMwptq+A7bOvAFO31xR0Hi/O7FMN9uxK9o=;
 b=ApzPXigH9YY4CG+xzIfBc5rr2ud4s6VRxS/YSk3oPLZnOfm4Z7A5swq+sPDrPUptlK7sVc
 TZlFDU0ObAyKULPRgXU4ENPsP+BXbTJeOa5aRhZvvRUA91/pLGGycPmotnbziYz8Dn6S5j
 h9cEXmJ4zpxCxUTj0DMcDAeTCGZvU10=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-OyDEyS0VOyWMsGUBq5nyDg-1; Wed, 16 Aug 2023 11:18:17 -0400
X-MC-Unique: OyDEyS0VOyWMsGUBq5nyDg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-40fa24ab5c8so18749071cf.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 08:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692199097; x=1692803897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6+hKmxKNNMwptq+A7bOvAFO31xR0Hi/O7FMN9uxK9o=;
 b=MKhyoof9Jn8WUzTTzD6Qr8X5mm7JD5QM/VPkYUpeaczCVPAmjjSau/u/TgWv4E0sa8
 PMjnLTmagjXTYul9eKiGt2UZRdGrjqfmbixytwl1TpRxXlhUoyZuR55YvVEsfIyW6vbi
 xyxZCCm0VqBSp0Or+wWZTrbj+4kQCF4RLKglzf6QHqNtipv9tgVSxXLLk7zq5Vtlys4i
 TYEVdRxiLUeMsTiIF3U8zn72Rel6ZsSqWvCthtaDRLBNal9mmSOZf9XiIBbq2hxQRwJm
 GdXUkk59QP0d3PbGy69D4eJrUNm1+3MQ0+VxVQ3B36VO6ewGyB3qd1JPdBblC5t0hipt
 5aDg==
X-Gm-Message-State: AOJu0Yzgx6GAtsRT0dWRwg2gd2k+RXoUGRK1qOkdCIC1R3O4cApO8d2t
 Gvgdz3hYm5cBPrkWyATK3xxkuSaQ3bModNx9caPUNS0s0rNJ7CN7+iH4RCfntRftksNRj1ptRjh
 v0YxqxyU7DdqF9Bc=
X-Received: by 2002:a05:622a:1aa4:b0:403:c2fa:83b with SMTP id
 s36-20020a05622a1aa400b00403c2fa083bmr2598465qtc.4.1692199097116; 
 Wed, 16 Aug 2023 08:18:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdx6Eb16AMW7S0+C9KUYLUeDbdQJNqRDb6/L0/1idR+8QZEqNko8AjdFHc4pVnpy66I7lUKA==
X-Received: by 2002:a05:622a:1aa4:b0:403:c2fa:83b with SMTP id
 s36-20020a05622a1aa400b00403c2fa083bmr2598442qtc.4.1692199096803; 
 Wed, 16 Aug 2023 08:18:16 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a3-20020ac84343000000b0040d6f2113efsm4617610qtn.58.2023.08.16.08.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 08:18:16 -0700 (PDT)
Date: Wed, 16 Aug 2023 11:18:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v4 8/8] migration: Add a wrapper to cleanup migration files
Message-ID: <ZNzot6bDD15S3U7u@x1n>
References: <20230816142510.5637-1-farosas@suse.de>
 <20230816142510.5637-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816142510.5637-9-farosas@suse.de>
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

On Wed, Aug 16, 2023 at 11:25:10AM -0300, Fabiano Rosas wrote:
> @@ -2003,6 +1980,8 @@ static int open_return_path_on_source(MigrationState *ms)
>          return -1;
>      }
>  
> +    migration_ioc_register_yank(qemu_file_get_ioc(ms->rp_state.from_dst_file));

I think I didn't really get why it wasn't paired before yesterday.  My
fault.

Registering from_dst_file, afaict, will register two identical yank objects
because the ioc is the same.

Should we make migration_file_release() not handle the unregister of
yank(), but leave that to callers?  Then we keep the rule of only register
yank for each ioc once.

We can also have yet another wrapper migration_file_release_with_yank() to
unregister the yank before calling migration_file_release().

-- 
Peter Xu


