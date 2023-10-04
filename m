Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E3D7B8B73
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 20:53:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo6zM-0002pz-Fh; Wed, 04 Oct 2023 14:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qo6zK-0002lE-KI
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qo6zJ-0006eB-4w
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696445568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DddTIybVWVNc8zLwqQmc8MOoX9OiOk5HxADC2aizs0=;
 b=Q/FhHxvQLv7wcu6GvVQKFYRKV50xSTT81bOhlIqIU+U8sMivMJcVtDpw3YMFgZbMrV+AM+
 gd7thCejeaB78HzHXZTl4WYLkvqHz1y87hDcjOy/kivwFz3S79zoEYTIvygd+lfQR+g4qd
 lKgzNJcEDF1XqVnZyXzFSVmKfaOSEzQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-V-7whs1PMwSWma5EqGAf0A-1; Wed, 04 Oct 2023 14:52:45 -0400
X-MC-Unique: V-7whs1PMwSWma5EqGAf0A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFAFE1C068C2;
 Wed,  4 Oct 2023 18:52:44 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAC10493113;
 Wed,  4 Oct 2023 18:52:43 +0000 (UTC)
Date: Wed, 4 Oct 2023 13:52:42 -0500
From: Eric Blake <eblake@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 11/16] util/cutils: Clean up global variable shadowing
 in get_relocated_path()
Message-ID: <pez3wruf7bfd452ojz4ep7yy3hgmyntmvx6qlnrrn3thd5mree@s53ocvicrdj5>
References: <20231004120019.93101-1-philmd@linaro.org>
 <20231004120019.93101-12-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231004120019.93101-12-philmd@linaro.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Oct 04, 2023 at 02:00:14PM +0200, Philippe Mathieu-Daudé wrote:
> Fix:
> 
>   util/cutils.c:1147:17: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>       const char *exec_dir = qemu_get_exec_dir();
>                   ^
>   util/cutils.c:1035:20: note: previous declaration is here
>   static const char *exec_dir;
>                      ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  util/cutils.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/util/cutils.c b/util/cutils.c
> index 25373198ad..b44718a6a2 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -1144,7 +1144,6 @@ char *get_relocated_path(const char *dir)
>  {
>      size_t prefix_len = strlen(CONFIG_PREFIX);
>      const char *bindir = CONFIG_BINDIR;
> -    const char *exec_dir = qemu_get_exec_dir();
>      GString *result;
>      int len_dir, len_bindir;
>  
> --

Took me a few seconds to see it, but since we have this just a few lines before:

const char *qemu_get_exec_dir(void)
{
    return exec_dir;
}

the deletion of the redundant local variable is just fine.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


