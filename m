Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF207DD130
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 17:07:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxrGk-0003gf-1s; Tue, 31 Oct 2023 12:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxrGX-0003X3-Dz
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:06:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxrGV-0000IZ-8b
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698768410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OmbfMfqhWKFH0ZGDg7p563CUzGon79pOwCdmE9MLu2Q=;
 b=eupR5KEZcwe51nl/rICSUvz5SPLInp8qQNn9OuwEwzxmxyS7sBenXx07eh7lc2DaA2b+hz
 C8toHjREg6A14WywUTRtWdKbOquJqh1JuNnXjpHNZxNXXWv4DLCMByrVfchE2kujikXEfL
 aQdPLVGX84zK78uliHh6GINfsfS7SXU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-vsEil0uDOWudfRSl7MCsSg-1; Tue, 31 Oct 2023 12:06:37 -0400
X-MC-Unique: vsEil0uDOWudfRSl7MCsSg-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5845213c8fcso618830eaf.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 09:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698768396; x=1699373196;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OmbfMfqhWKFH0ZGDg7p563CUzGon79pOwCdmE9MLu2Q=;
 b=ZOgr034rqqo+zpeQeOaR5ATldm9me6qHdC89g81Gpp8DwRZ+iUVaHMZ4R3JWPt8NXC
 YjigY3eYy3/C3dhpnVFHuX+XBvX0sYzSvMtpHlL3EhdvmWmGxnHziqVrQPecMuzEMeoo
 YQBrvd0u7OBM7TmkSLey4UsxQ6YUh+eNLuLdl7fwh5ydzB+Qjg1eLtIEdeEU/yVnjzoA
 5ZVMTU7K95EDVEaYUxL+FggIkHhU4aTgn9oUiHWpFuk1TpERrcw1nF5e240LZe181PQN
 G8JcSi7UVUcY7IxKTSMOCdcfdJdNvXFQ5yH3P3CfBrsbomPu7QX6c2utuj0nJv4x8PJd
 sI1g==
X-Gm-Message-State: AOJu0Yxij1GkWGpyHI9zuyGwzCwOx06KkhQ6rSY/q0BXftDv3QkHNueo
 gDgjF1O33g/3DHuJ25qSy3bj5PFEnOXi1pGWJW9PIIxCsCZWTZ/lJoGyATvnLbOZEy6LpP70Jx2
 w1qRcT/674bKbFo8=
X-Received: by 2002:a05:6358:f201:b0:169:4a72:2b84 with SMTP id
 jj1-20020a056358f20100b001694a722b84mr17777536rwb.1.1698768396446; 
 Tue, 31 Oct 2023 09:06:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIfkOpkqplqFE6Qt8wkphnAFsjuXsyoupW3dMni6NkWARItJj3W+uqPqqG7w71QAmrjhmqtw==
X-Received: by 2002:a05:6358:f201:b0:169:4a72:2b84 with SMTP id
 jj1-20020a056358f20100b001694a722b84mr17777506rwb.1.1698768396134; 
 Tue, 31 Oct 2023 09:06:36 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ev9-20020a0562140a8900b00670e0f71ff7sm646986qvb.90.2023.10.31.09.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 09:06:35 -0700 (PDT)
Date: Tue, 31 Oct 2023 12:06:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 13/29] migration: fixed-ram: Add URI compatibility check
Message-ID: <ZUEmCdoVO/0W5Sqh@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-14-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023203608.26370-14-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

On Mon, Oct 23, 2023 at 05:35:52PM -0300, Fabiano Rosas wrote:
> The fixed-ram migration format needs a channel that supports seeking
> to be able to write each page to an arbitrary offset in the migration
> stream.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 692fbc5ad6..cabb3ad3a5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -106,22 +106,40 @@ static bool migration_needs_multiple_sockets(void)
>      return migrate_multifd() || migrate_postcopy_preempt();
>  }
>  
> +static bool migration_needs_seekable_channel(void)
> +{
> +    return migrate_fixed_ram();
> +}
> +
>  static bool uri_supports_multi_channels(const char *uri)
>  {
>      return strstart(uri, "tcp:", NULL) || strstart(uri, "unix:", NULL) ||
>             strstart(uri, "vsock:", NULL);
>  }
>  
> +static bool uri_supports_seeking(const char *uri)
> +{
> +    return strstart(uri, "file:", NULL);
> +}
> +
>  static bool
>  migration_channels_and_uri_compatible(const char *uri, Error **errp)
>  {
> +    bool compatible = true;
> +
> +    if (migration_needs_seekable_channel() &&
> +        !uri_supports_seeking(uri)) {
> +        error_setg(errp, "Migration requires seekable transport (e.g. file)");
> +        compatible = false;

We may want to return directly after setting errp once, as error_setg() can
trigger assertion over "*errp==NULL" if below check will fail too.

> +    }
> +
>      if (migration_needs_multiple_sockets() &&
>          !uri_supports_multi_channels(uri)) {
>          error_setg(errp, "Migration requires multi-channel URIs (e.g. tcp)");
> -        return false;
> +        compatible = false;
>      }
>  
> -    return true;
> +    return compatible;
>  }
>  
>  static bool migration_should_pause(const char *uri)
> -- 
> 2.35.3
> 

-- 
Peter Xu


