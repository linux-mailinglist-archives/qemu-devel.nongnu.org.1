Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD837A0192
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 12:23:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgjUb-0006vQ-QI; Thu, 14 Sep 2023 06:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1qgjUa-0006vD-2n
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1qgjUY-00021A-Kp
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694686953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FqX8lOJ41uE8j5Aro7DPdCAYaHGTLuTX661y5qinz9g=;
 b=DyvH3VZsuGYGmTTeaQFG2xHqLb+8YDNFOSgjatwna6YKIGOtZxf8Hgalbhrc9n4+7yQTpy
 4qSU0U3zlzM3kApchR7oL70XP0ckbbLyulLlCKw2Hgo3MdL79rZAA1rzJj56wY9fq8McWa
 h3+z4z6EHALVgPQGek6IYe4JcMneLZs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-X38XsjBuMzORDmRxnL7HeQ-1; Thu, 14 Sep 2023 06:22:30 -0400
X-MC-Unique: X38XsjBuMzORDmRxnL7HeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E42BB800045;
 Thu, 14 Sep 2023 10:22:29 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE97140C6EA8;
 Thu, 14 Sep 2023 10:22:28 +0000 (UTC)
Date: Thu, 14 Sep 2023 12:22:26 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: =?utf-8?B?0JzQuNGA0L7QvdC+0LIg0KHQtdGA0LPQtdC5INCS0LvQsNC00LjQvNC40YA=?=
 =?utf-8?B?0L7QstC40Yc=?= <mironov@fintech.ru>
Cc: "libvirt-security@redhat.com" <libvirt-security@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "sdl.qemu@linuxtesting.org" <sdl.qemu@linuxtesting.org>
Subject: Re: [sdl-qemu] [PATCH 1/1] No checks, dereferencing possible
Message-ID: <ZQLe4uI2xu1cKkB5@angien.pipo.sk>
References: <59e6590ea8a04de788f69709ea4c54f8@fintech.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59e6590ea8a04de788f69709ea4c54f8@fintech.ru>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
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

On Thu, Sep 14, 2023 at 09:44:16 +0000, Миронов Сергей Владимирович wrote:
> No checks, dereferencing possible.
> 
> 
> Return value of a function 'virDomainChrSourceDefNew'
> is dereferenced at qemu_command.c without checking
> for NULL, but it is usually checked for this function.

This description here doesn't make sense. You are checking the presence
of 'privateData' in 'virDomainVideoDef'.

> 
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 
> Fixes: 1f85f0967b ("ci: jobs.sh: Add back '--no-suite syntax-check --print-errorlogs'")
> 
> Signed-off-by: Sergey Mironov <mironov@fintech.ru>
> 
> ---
> src/qemu/qemu_command.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/qemu/qemu_command.c b/src/qemu/qemu_command.c
> index e84374b4cf..8d11972c88 100644
> --- a/src/qemu/qemu_command.c
> +++ b/src/qemu/qemu_command.c
> @@ -4698,6 +4698,8 @@ qemuBuildVideoCommandLine(virCommand *cmd,
>              g_autofree char *name = g_strdup_printf("%s-vhost-user", video->info.alias);
>              qemuDomainChrSourcePrivate *chrsrcpriv = QEMU_DOMAIN_CHR_SOURCE_PRIVATE(chrsrc);
> 
> +           if (chrsrc == NULL)
> +                   return -1;

This addition doesn't make sense as it's dead code. The private data is
always allocated and checked that it's non-NULL in the qemu driver via
the callback in virDomainVideoDefNew.

Do you have a call trace that would prove me otherwise?


