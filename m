Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 114FC82D44A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:48:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPGm3-0000Yp-Ms; Mon, 15 Jan 2024 01:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPGm1-0000Yg-MI
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:48:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPGlz-0000hQ-ML
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705301319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2mgUON4oOE++q9Sa58Xl5OdQKDGJhktmZE9K1jCUJx4=;
 b=gfe/EXdqSgSM90MHoZ+FdpFcnhTqMIK7+r1ZRX4g1i5Ln30UIvKZv6qG9WuFQmysLEjT/6
 ia0YMH9XAN/6PMCbFke3MMDzgjGD47j8egLPJMv23thQwrMIGrHrbs/0fQS00sQhpdCKQ5
 SwmV9ReKtdXb/vfyzpYJPO0UYNPjrB0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-vYbBFSYBOPe77EdPAVFw2Q-1; Mon, 15 Jan 2024 01:48:36 -0500
X-MC-Unique: vYbBFSYBOPe77EdPAVFw2Q-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-28df183249bso1050267a91.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 22:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705301316; x=1705906116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mgUON4oOE++q9Sa58Xl5OdQKDGJhktmZE9K1jCUJx4=;
 b=LoeL0fxgCiIt+S+thq807UxgEX1nwQBtfdR89rFrRE7Sa/4xuswSIwGPC1+wPTnKkK
 MY6jKvf6OY4Go2qWvPW6sJgUXB34D4xG1dQhypDmCM+hWF9wFxZqWv6vD4ATnwxrsDQx
 bNN5G2M/pBcBPiRI4K6jFP8Pnunx0BZz4MmvZm5tqD8K+JhHo13Bsi9r2yGMoSkJsX1c
 +GBkcZOd+KrUVjLC/83NaNsOjwJEg7PlcdPlLhApmubehgZM2VXLvStejUoBHvrMvHzW
 USbL9SDFozrVTNVBP326P2fWdw+lgBazexat1b3jBY8m7WPBbNXnE/JbXPY4c9BFDTzD
 OXYg==
X-Gm-Message-State: AOJu0YyBn9vtZEM7RA8Qb13gpB+RYMfczhqcXn6rN9YhqDivkXFH6Plx
 PijTkO9eXfQ/fdoQDshhpUKsfxBBfDIGLdiegPyDJzdc3y8lAVaInL6sclrCSXp+osFDhH4sZA/
 l9Zw9doiJMOzeBrJXt5lqfPY=
X-Received: by 2002:a17:90b:1e47:b0:28e:4761:cfff with SMTP id
 pi7-20020a17090b1e4700b0028e4761cfffmr2406160pjb.0.1705301315975; 
 Sun, 14 Jan 2024 22:48:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3+ajELU5PvpkvErXnWRCZ4OCrAviSdJOUHphecW48/cEvT7yHlndIyPNEYvHwsLszEQFmIQ==
X-Received: by 2002:a17:90b:1e47:b0:28e:4761:cfff with SMTP id
 pi7-20020a17090b1e4700b0028e4761cfffmr2406151pjb.0.1705301315708; 
 Sun, 14 Jan 2024 22:48:35 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 sc4-20020a17090b510400b0028b89520c7asm8922680pjb.9.2024.01.14.22.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 22:48:35 -0800 (PST)
Date: Mon, 15 Jan 2024 14:48:24 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V2 04/11] migration: remove migration_in_postcopy parameter
Message-ID: <ZaTVOF7aPV-n7gKY@x1n>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
 <1705071910-174321-5-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1705071910-174321-5-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Fri, Jan 12, 2024 at 07:05:03AM -0800, Steve Sistare wrote:
>  bool migration_in_incoming_postcopy(void)
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index b3cd229..e43a93f 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -580,7 +580,7 @@ static int migration_state_notifier(NotifierWithReturn *notifier,
>      if (migration_in_setup(s)) {
>          spice_server_migrate_start(spice_server);
>      } else if (migration_has_finished(s) ||
> -               migration_in_postcopy_after_devices(s)) {
> +               migration_in_postcopy_after_devices()) {

This can be a reply also to your other email: my previous suggestion of
using PRECOPY_DONE should apply here, where we can convert this chunk into:

  } else if (event == MIG_EVENT_PRECOPY_DONE) {...}

Because PRECOPY_DONE should also cover the notification from
postcopy_start(), then we can drop migration_in_postcopy_after_devices()
completely, I think.

-- 
Peter Xu


