Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E44D9B9366
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Nov 2024 15:37:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6slT-0005Qo-K3; Fri, 01 Nov 2024 10:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6slQ-0005QN-5k
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 10:36:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6sl7-0003K1-SH
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 10:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730471776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=phuG70xYIRufI08pEpWwEfclVc5apBVTg2vAQKfg030=;
 b=aO6THp7lHxzHaZk7jk+pNJ0JR4d2IFr6K88YoHIKr9KHk0qXSNLGkIltMjqYJv8dZOLiQ4
 dzGqQJGWvkwVuTjUsGO15LS+bwlUWSOCHRdGj2mzU72cvIKBqbOO2Zn4on65uRReWK8HPE
 zCX/9AQu7ivCJDwaA76NjWKuJIYHafw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-gMdMVOX7MHm5nnBxF8Ox8Q-1; Fri, 01 Nov 2024 10:36:12 -0400
X-MC-Unique: gMdMVOX7MHm5nnBxF8Ox8Q-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6cbe6ad0154so29483676d6.0
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 07:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730471772; x=1731076572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phuG70xYIRufI08pEpWwEfclVc5apBVTg2vAQKfg030=;
 b=RL6tuvFDjIRiZlMWPNzBbyLQLb6LCq9jPXwAyWgVvgT7bZfuLA/nh4a/4cbeb7r3t1
 flqoYlLkMmVbKbU6b6OAeqR9+0HoWdV8zN7bO39vLiccenqgW/MOCE4wKSU87wEpfLyK
 tkK4NqpKS2P6I07nD0M/msRt73opmnMqsOy+whVqx3W7RFvlT+FMsPts3bjCXqLG8pyR
 ytcdBVioqFaXGrvy1XSxAyw5Gi6BIkMxOfIi67aTxPnXcXPV/q6SlDEVQxZkOjzzjAHu
 gfSGiwZaxZuFrYWjGdzkcoBSQ9waUPw4XOFRTGU9RUSHO3m1CN08dJfScr5FBsntSO9X
 KGXg==
X-Gm-Message-State: AOJu0YwEo1DdsXSy4aUYIsRCpuPuPxx2YAVDZX9Yg5WPyO8+9NCwfRDk
 wbBzbUndBbhbi6x0OcAzOfPTcYZWQMAFOwmzwRK7+o5j6Bf+qOYr8vyv624c0LmfmrQJgJIT9Cy
 VwySqXrLYgbCpCJItRbbGVBUXIjTmoSDvWjsFlOl6zdyoDXeCqDqL
X-Received: by 2002:a05:6214:54c4:b0:6cb:f87f:f073 with SMTP id
 6a1803df08f44-6d35c0a4239mr52672826d6.6.1730471770759; 
 Fri, 01 Nov 2024 07:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCQWWYZSye5rCpq9ALA0IhGnEHCASvN+oLZT+CCgIP+3gHqpYJ+ZueTh4rtTR1erDjTpSi1w==
X-Received: by 2002:a05:6214:54c4:b0:6cb:f87f:f073 with SMTP id
 6a1803df08f44-6d35c0a4239mr52672666d6.6.1730471770483; 
 Fri, 01 Nov 2024 07:36:10 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d354184748sm19857016d6.131.2024.11.01.07.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 07:36:10 -0700 (PDT)
Date: Fri, 1 Nov 2024 10:36:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 3/5] migration: remove multifd check with postcopy
Message-ID: <ZyTnWYyHlrJUYQRB@x1n>
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-4-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029150908.1136894-4-ppandit@redhat.com>
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

On Tue, Oct 29, 2024 at 08:39:06PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Remove multifd capability check with Postcopy mode.
> This helps to enable both multifd and postcopy together.
> 
> Update migrate_multifd() to return false when migration
> reaches Postcopy phase. In Postcopy phase, source guest
> is paused, so the migration threads on the source stop
> sending/pushing data on the channels. The destination
> guest starts running and Postcopy threads there begin
> to request/pull data from the source side.
> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  migration/options.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index ad8d6989a8..47c5137d5f 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -266,7 +266,8 @@ bool migrate_multifd(void)
>  {
>      MigrationState *s = migrate_get_current();
>  
> -    return s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
> +    return s->capabilities[MIGRATION_CAPABILITY_MULTIFD]
> +            && !migration_in_postcopy();
>  }

We need to keep this as-is.. I'm afraid.

You can always do proper check with multifd & !postcopy in your use cases.

>  
>  bool migrate_pause_before_switchover(void)
> @@ -479,11 +480,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>              error_setg(errp, "Postcopy is not compatible with ignore-shared");
>              return false;
>          }
> -
> -        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
> -            error_setg(errp, "Postcopy is not yet compatible with multifd");
> -            return false;
> -        }
>      }
>  
>      if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
> -- 
> 2.47.0
> 

-- 
Peter Xu


