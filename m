Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF8D7B6C62
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:53:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qngkJ-000177-D0; Tue, 03 Oct 2023 10:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qngk4-0000w1-Gm
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qngk3-00030g-06
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696344677;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DjXIZ2CWM41fKOzi7qQW6EXnvo1UnMhCGOJcl95Z8/U=;
 b=cBsHF9aIgnmbu2Dft9RPt0S1/IgIjgoTzJY8GYGzu6zPaZ9jp50EfQTF4jSBQJMm/bakqD
 Ts46Mhe0GKixCda8G4WTa2h9qhw16xDgYyCXZRwFdEwN+xzqtScVAop12nEKT2uCrLVxaX
 wH748/cSqoWQ5+p+VfO+gxXrMILnCOU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-uHBlFkUWO8S9ukB-Z07H2g-1; Tue, 03 Oct 2023 10:51:16 -0400
X-MC-Unique: uHBlFkUWO8S9ukB-Z07H2g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-321726b0238so765103f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 07:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696344674; x=1696949474;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DjXIZ2CWM41fKOzi7qQW6EXnvo1UnMhCGOJcl95Z8/U=;
 b=Vk616cSPu1oh13hM7fNdQiMyb4KD7kOa0xQR5jDH9iIDdfVonPj65jJYctolJRH9gK
 Y5Btv+CNjOLUfN/+al1+BLCYtPe2cv7L0zzPjuo9juPjLd8kALypkq+BMR/KUJEZIisc
 UjaouccpMO5Yr7bvrQwTMM3xkcearH1LyYFc+OuRy+VIzfcaBe+PfP0gw6u+TGzsq4jo
 NwpSLbbItZxPCGq0tYq3fU9v0K0zJkLJcXd7R3TPJEWcbff4jOLhcJi/zL3h4MZipB/b
 Tid+bGG0hZi2oVin1pMV2LzC4DhVCg98zy4LNT16Ga3u0JdaBSONgFim8EvLUAPnedLp
 v2Hg==
X-Gm-Message-State: AOJu0YzFnxiINA4QEJqZ0/RaOm7ID1u/3eVQMl3ik5aTkh87vn5AP/MP
 A7p478Lk7OidK97QsoDXGwHSVZOYUCDLVh9Uc3W/m7j4k6hJbPSRf96dJp1gI3GVMeAk6AeBVbn
 JGIOWu9SnvkvNRZA23sdm5Nlc/Q==
X-Received: by 2002:a5d:5912:0:b0:320:1c4:e213 with SMTP id
 v18-20020a5d5912000000b0032001c4e213mr13728985wrd.1.1696344674617; 
 Tue, 03 Oct 2023 07:51:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC5YQ5P7GryGgISk2qgL885f+VTmiSJuEFe3iXuBlRXzPiW0sOpnUVdSui8bjFq6+H6Q25DQ==
X-Received: by 2002:a5d:5912:0:b0:320:1c4:e213 with SMTP id
 v18-20020a5d5912000000b0032001c4e213mr13728965wrd.1.1696344674272; 
 Tue, 03 Oct 2023 07:51:14 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m4-20020adffa04000000b0031980783d78sm1747188wrr.54.2023.10.03.07.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 07:51:13 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Add co-maintainers for migration
In-Reply-To: <20231003143847.9245-1-peterx@redhat.com> (Peter Xu's message of
 "Tue, 3 Oct 2023 10:38:47 -0400")
References: <20231003143847.9245-1-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 03 Oct 2023 16:51:12 +0200
Message-ID: <87r0mb69pb.fsf@secure.mitica>
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
> Per the qemu upstream call a few hours ago, proposing Fabiano and myself as
> the co-maintainer for migration subsystem to help Juan.
>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>
> Fabiano, would you please ack here publically to acknowledge that you're
> fine with it?  Thank you!
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Queed.

> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 81625f036b..fc6e09aa31 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3207,7 +3207,8 @@ F: scripts/checkpatch.pl
>  
>  Migration
>  M: Juan Quintela <quintela@redhat.com>
> -R: Peter Xu <peterx@redhat.com>
> +M: Peter Xu <peterx@redhat.com>
> +M: Fabiano Rosas <farosas@suse.de>
>  R: Leonardo Bras <leobras@redhat.com>
>  S: Maintained
>  F: hw/core/vmstate-if.c


