Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C415E7CF398
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:10:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtP1a-0001O0-TZ; Thu, 19 Oct 2023 05:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtP1Z-0001Ns-I4
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:09:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtP1Y-0000sn-0y
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697706539;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=n1cEteaF21nH0SCXqPADy+NEw3TzElj8VgX8VMLrFc4=;
 b=RKvSp19fjjaefWnZ1oWROBa50JJh1mZ1Q54D6o5ITyWscD8b5pTnttrgpGBYR8dJEKfdds
 4njdjd+iHGArEdjppXenNpOqTcATa84E6+KB/2XOvMX6B1ob5QAmhwkueTYK2xwNP+r8/r
 P9uA0XgEQ2PivmD1Hlos2BitGFLfWpI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-7JoLKaZDP4OIM056MxQfbA-1; Thu, 19 Oct 2023 05:08:55 -0400
X-MC-Unique: 7JoLKaZDP4OIM056MxQfbA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4074cdf2566so3057155e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 02:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697706534; x=1698311334;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n1cEteaF21nH0SCXqPADy+NEw3TzElj8VgX8VMLrFc4=;
 b=w+UhB92CMNBlvqUT+3XPykSMMQw+5fyDu7nP38UQZYsvOAiaB/U08RTXX+ahHBwpIS
 IOZMfoMdtlQBIe3hZpWq2XVzfC1boq56r6ueAqtX8zeyXQGkwS2DjjdMKHAvMX2kZn/H
 m9AxOF2aQXNMbb0FU8r00jBev1cM3wzpZaBp4trvd4uIri9lPSbM583Oato+6xCK02rr
 iBGgRfMBpGmVEBxQIxN0VUSq9nKL94wjBZ4aAq+paA82sYlD9/vS3DaD5v4L26m//79P
 /uG+pN2QP4kyzPGmLVMPGkpz21gZBHAB+aX591k4SM2SSxLGr7SZ6NbesTX+2joYhw54
 nj3w==
X-Gm-Message-State: AOJu0Yxv3s7wkgUm0OczoT2SlmvKyQfCrOpMGGtGWE4DliYif8gYFp9o
 1D8dIVT7QWhlkx7KpWE+vPy874mvs/fBGwwGny2x8rBhzsC+pXP1OzVIBrxjNca4B12+nBz3EpR
 /TfBlhcQJ4llV6qQ=
X-Received: by 2002:a05:600c:4b1c:b0:405:3ab3:e640 with SMTP id
 i28-20020a05600c4b1c00b004053ab3e640mr1050597wmp.20.1697706534777; 
 Thu, 19 Oct 2023 02:08:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH24RL7LkxdIld9ffYbPCbK3cw9ql00a0foaFYkfFsRwwE7TC41ZidRKz96koBUIuLLeX2N/Q==
X-Received: by 2002:a05:600c:4b1c:b0:405:3ab3:e640 with SMTP id
 i28-20020a05600c4b1c00b004053ab3e640mr1050583wmp.20.1697706534414; 
 Thu, 19 Oct 2023 02:08:54 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 j17-20020a05600c489100b0040776008abdsm3840021wmp.40.2023.10.19.02.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 02:08:53 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 2/6] migration/multifd: Stop checking p->quit in
 multifd_send_thread
In-Reply-To: <20231012140651.13122-3-farosas@suse.de> (Fabiano Rosas's message
 of "Thu, 12 Oct 2023 11:06:47 -0300")
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-3-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 11:08:53 +0200
Message-ID: <87o7gv6kt6.fsf@secure.mitica>
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

Fabiano Rosas <farosas@suse.de> wrote:
> We don't need to check p->quit in the multifd_send_thread() because it
> is shadowed by the 'exiting' flag. Ever since that flag was added
> p->quit became obsolete as a way to stop the thread.
>
> Since p->quit is set at multifd_send_terminate_threads() under the
> p->mutex lock, the thread will only see it once it loops, so 'exiting'
> will always be seen first.
>
> Note that setting p->quit at multifd_send_terminate_threads() still
> makes sense because we need a way to inform multifd_send_pages() that
> the channel has stopped.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>

But then should we remove the quit altogether?

> ---
>  migration/multifd.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index e26f5f246d..92ae61a50f 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -731,9 +731,6 @@ static void *multifd_send_thread(void *opaque)
>              if (flags & MULTIFD_FLAG_SYNC) {
>                  qemu_sem_post(&p->sem_sync);
>              }
> -        } else if (p->quit) {
> -            qemu_mutex_unlock(&p->mutex);
> -            break;
>          } else {
>              qemu_mutex_unlock(&p->mutex);
>              /* sometimes there are spurious wakeups */


