Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A6572CFC4
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 21:42:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8nQI-0001y3-AM; Mon, 12 Jun 2023 15:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q8nQF-0001xs-Ry
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q8nQE-00081L-Ag
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686598909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lp6P0f2wpD1/wiNvmbsVTX3xsf6/YziMkKFJOniIvkk=;
 b=ZXKWV5jPI4/nZPq2Xhj+1WaOXW0ohjBo4ma5QA0S5EHzm0FN54+dr1b3amOeK4/faXftF2
 P0JI/Ln4b4MFj7BLgGfGaK1gB7s+qpd9wLzjRHGx18Cng+oOJy8t1v4s9Ba8ZElDU+2SYb
 IkXdygezGwfxa53wMrIBQVhGzZJFa3M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-IoEmHu_FNzmiZhB-o8ed8Q-1; Mon, 12 Jun 2023 15:41:48 -0400
X-MC-Unique: IoEmHu_FNzmiZhB-o8ed8Q-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-74faf5008bbso100859085a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 12:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686598907; x=1689190907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lp6P0f2wpD1/wiNvmbsVTX3xsf6/YziMkKFJOniIvkk=;
 b=E0t+/YJdogi4bqITU1C6HqZ+YsF0h6Iv4HEJTsqJ8+rCvE1PQ6UjN3tiRnO0P9Ay3m
 nXIF6sbOAoccPhBttSiC5D03XR9Er337fGnvKvZH3QnMFiJdMvIjq0sV8bG/uqqYR6E8
 0yTSgEoeIR0qntaGuhMRgdko+J5zKVcLC+57nuffBIcwNvJ01xO70nHYhk727fqc8yEN
 C7J1bMR2vQ886VSLaEu/n8awrGuFz0BxP9UR4pBovAU9el4s4JZD6eM5RW5ohncoBxdR
 oEvOYa0pra4+xmp0FiDOaQXlqPgPltxQWAaY5UjtvcjbHAUY2hY28V1GtKNRh70oQCQs
 ptUg==
X-Gm-Message-State: AC+VfDyE99L+LrJvijOvX8JOMGQf/Wew0iCwUMk6YZH36LoHpu91wl5i
 EUPfoGq/IVmXL+62/g0/5anGZE9rDz1h+x/D0Col1hdhCQEISt/+9qmXzGLatL0AgLARKSZfE1I
 oqHq5PuYa/U9zpOk=
X-Received: by 2002:a05:6214:c4b:b0:629:e646:bdad with SMTP id
 r11-20020a0562140c4b00b00629e646bdadmr12929731qvj.4.1686598907523; 
 Mon, 12 Jun 2023 12:41:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6X2042Z60VSGd5HeewAJCDhwmWw4QRTCP8oVFXLS7UB9IlbTUAXlfUtNHeyGbaRE4k5IqpjA==
X-Received: by 2002:a05:6214:c4b:b0:629:e646:bdad with SMTP id
 r11-20020a0562140c4b00b00629e646bdadmr12929715qvj.4.1686598907265; 
 Mon, 12 Jun 2023 12:41:47 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a20-20020a0ca994000000b0062de1ed9d15sm1674178qvb.102.2023.06.12.12.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 12:41:46 -0700 (PDT)
Date: Mon, 12 Jun 2023 15:41:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Message-ID: <ZId0+HYF/ETLVri3@x1n>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230612193344.3796-5-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jun 12, 2023 at 09:33:42PM +0200, Juan Quintela wrote:
> Only "defer" is recommended.  After setting all migation parameters,
> start incoming migration with "migrate-incoming uri" command.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  docs/about/deprecated.rst | 7 +++++++
>  softmmu/vl.c              | 2 ++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 47e98dc95e..518672722d 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -447,3 +447,10 @@ The new way to modify migration is using migration parameters.
>  ``blk`` functionality can be acchieved using
>  ``migrate_set_parameter block-incremental true``.
>  
> +``-incoming uri`` (since 8.1)
> +'''''''''''''''''''''''''''''
> +
> +Everything except ``-incoming defer`` are deprecated.  This allows to
> +setup parameters before launching the proper migration with
> +``migrate-incoming uri``.
> +
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index b0b96f67fa..7fe865ab59 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -2651,6 +2651,8 @@ void qmp_x_exit_preconfig(Error **errp)
>      if (incoming) {
>          Error *local_err = NULL;
>          if (strcmp(incoming, "defer") != 0) {
> +            warn_report("-incoming %s is deprecated, use -incoming defer and "
> +                        " set the uri with migrate-incoming.", incoming);

I still use uri for all my scripts, alongside with "-global migration.xxx"
and it works.

Shall we just leave it there?  Or is deprecating it helps us in any form?

-- 
Peter Xu


