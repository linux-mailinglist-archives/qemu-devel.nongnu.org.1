Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B417B9B71
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 09:43:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoJ0Y-00036f-J1; Thu, 05 Oct 2023 03:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoJ0R-00035y-Uo
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoJ0M-0003ja-2q
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696491760;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Pp0NnVzm7I6dnlaxGRZfT99kTtBFpWsg+LQ04jQ2o7A=;
 b=Co3kw8KmXaEJVAnQvkeEXXp+l00AHoD/KFMHZKf/vNsLlUJFBSgiZQoUvVnWGvKzBar9j1
 GV+gqP5OoDAqizqqJ6KZJNlHGN1FJGpmuJHC4HCNYG4bdjHApBnDgJQm4TcUsnOKc7aqL3
 n0FIJIx4YT7GfMSz7ZzIUw1XF/JlaL0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-34e82bg_NXaTHcIbBHenyQ-1; Thu, 05 Oct 2023 03:42:34 -0400
X-MC-Unique: 34e82bg_NXaTHcIbBHenyQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-502fff967ccso653830e87.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 00:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696491753; x=1697096553;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pp0NnVzm7I6dnlaxGRZfT99kTtBFpWsg+LQ04jQ2o7A=;
 b=amYeXCOY2r3b21GwYKCdXy3hnnqHa9rYWTl9Z8koa2g4PB5EVj/iiyn43KWaPQHSiA
 AN25hqMyoW+eVPkQsEyhmTNqgeoJ4wvVe6NUXf20K3YFAzFhix6+Ax0MboTQFeus//vZ
 nsXNrtSm8fOiOvChFwgofatrzGD5kdO1WQMD3dLgsBsyR0sJFz7wfJBQjZwsLHTPxCEW
 TJqTE9N4dgaAfN/qKyL7evIHqlCjTocd1xeaHTaK8zdBqgspv3UyIUmINthocYtnkU7y
 wbXxxMAMCaidShjTzk6yB+eEfV3K0jz7T7gO0shmdbMvGbr1FUNk5OwZ8sZneDX3yeQH
 OECw==
X-Gm-Message-State: AOJu0YxUhI/WxBu3LBspx4ON9zV3almXrOvwctP7DCueyeXL6TQXbBmF
 hA63HLi5Y0jw4dSoP/qTwIzXh5w3JaXHiTkixAXPt4VI/KduY4HHU1lUcMPDEl8P0HweZF9P594
 qMBmF6gfnp6FIIrU=
X-Received: by 2002:a19:9148:0:b0:504:2d54:b4d0 with SMTP id
 y8-20020a199148000000b005042d54b4d0mr3877508lfj.19.1696491753293; 
 Thu, 05 Oct 2023 00:42:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdEnEzDIAL6L/2zdAchsrjWlFNC8gZ0hYUdBuoSfkrD/5tdpMAkznGob0hNJvr9h/Hl5Wm2w==
X-Received: by 2002:a19:9148:0:b0:504:2d54:b4d0 with SMTP id
 y8-20020a199148000000b005042d54b4d0mr3877496lfj.19.1696491752916; 
 Thu, 05 Oct 2023 00:42:32 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 d9-20020adff849000000b0031fbbe347e1sm1104277wrq.65.2023.10.05.00.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 00:42:32 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 05/10] qemufile: Always return a verbose error
In-Reply-To: <20231004220240.167175-6-peterx@redhat.com> (Peter Xu's message
 of "Wed, 4 Oct 2023 18:02:35 -0400")
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-6-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 05 Oct 2023 09:42:31 +0200
Message-ID: <87edi9plaw.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> There're a lot of cases where we only have an errno set in last_error but
> without a detailed error description.  When this happens, try to generate
> an error contains the errno as a descriptive error.
>
> This will be helpful in cases where one relies on the Error*.  E.g.,
> migration state only caches Error* in MigrationState.error.  With this,
> we'll display correct error messages in e.g. query-migrate when the error
> was only set by qemu_file_set_error().
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Have to adjust due to the static missing from previous patch.


