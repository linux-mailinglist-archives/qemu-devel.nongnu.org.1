Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CB7763EC5
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 20:45:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOilB-0006Ik-77; Wed, 26 Jul 2023 13:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qOil8-0006GV-Qy
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:57:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qOil7-0006Jh-23
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690394232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EBQSZSTRvSf5kFl9PNozYmR+l5P+cSVCx5LGFbGqtEQ=;
 b=M7G257O38pjDQwSibnxIVtbiWakRQEh/GyxgcixOgWRv4+how4Ss7DFe1n+KNv5YDA/plk
 TRLUFeqTjc3SEvmX2AiAYCRHOImyN/e8aADE2NIcmUkj3Tb2VW8OjS/n9QZwrCMQJX9ubx
 4PqmEIqTr6e/kbK7yMTMRRvHJ6/83I8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-684-NkPbJlhdMl6CmJ_EIxMWoA-1; Wed, 26 Jul 2023 13:57:08 -0400
X-MC-Unique: NkPbJlhdMl6CmJ_EIxMWoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61166805951;
 Wed, 26 Jul 2023 17:57:08 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C69444094DC1;
 Wed, 26 Jul 2023 17:57:07 +0000 (UTC)
Date: Wed, 26 Jul 2023 12:57:06 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 1/1] qemu-nbd: regression with arguments passing into
 nbd_client_thread()
Message-ID: <5arr3gmamjxaev6wgwyewnc6ij2wl3oddmju5r2n6lx4rgfcoz@wejhxbmrzyon>
References: <20230726145247.297454-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726145247.297454-1-den@openvz.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 26, 2023 at 04:52:47PM +0200, Denis V. Lunev wrote:
> Unfortunately
>     commit 03b67621445d601c9cdc7dfe25812e9f19b81488
>     Author: Denis V. Lunev <den@openvz.org>
>     Date:   Mon Jul 17 16:55:40 2023 +0200
>     qemu-nbd: pass structure into nbd_client_thread instead of plain char*
> has introduced a regression. struct NbdClientOpts resides on stack inside
> 'if' block. This specifically means that this stack space could be reused
> once the execution will leave that block of the code.
> 
> This means that parameters passed into nbd_client_thread could be
> overwritten at any moment.
> 
> The patch moves the data to the namespace of main() function effectively
> preserving it for the whole process lifetime.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: <qemu-stable@nongnu.org>
> ---
>  qemu-nbd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 5b2757920c..7a15085ade 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -589,6 +589,7 @@ int main(int argc, char **argv)
>      const char *pid_file_name = NULL;
>      const char *selinux_label = NULL;
>      BlockExportOptions *export_opts;
> +    struct NbdClientOpts opts;
>  
>  #ifdef CONFIG_POSIX
>      os_setup_early_signal_handling();
> @@ -1145,7 +1146,7 @@ int main(int argc, char **argv)
>      if (device) {
>  #if HAVE_NBD_DEVICE
>          int ret;
> -        struct NbdClientOpts opts = {
> +        opts = (struct NbdClientOpts) {

Does this case a compiler warning for an unused variable when
HAVE_NBD_DEVICE is not set?  If so, the solution is to also wrap the
declaration in the same #if.  I'll see if I can figure out the CI
enough to prove (or disprove) my theory on a BSD machine which likely
lacks HAVE_NBD_DEVICE.

With that addressed, I'm fine with:

Reviewed-by: Eric Blake <eblake@redhat.com>

and I will queue it through my NBD tree in time for 8.1-rc2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


