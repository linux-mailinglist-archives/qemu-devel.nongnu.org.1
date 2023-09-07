Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB9A797E02
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 23:37:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeMf2-0000Xf-Rm; Thu, 07 Sep 2023 17:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeMf1-0000WR-3o
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 17:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeMey-0006W3-Vo
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 17:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694122532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R2FgsEHwwYrVb0J0P90tugZ92d+GphQkrWM159sQxSM=;
 b=Z/xQwQKzxT6haSkTxCRG1RzmKlIiYs2vMFAaYAsvU8rBg/WPZjhSMMZLNfoObI4q5kMacB
 a0fTuSie/BO+4TU05MYFVkFY0ZOVg4F1uVCakJG1AVDztUUVfp9Nr8Um8ge2ya/g6vltdz
 rmQEjAHLLVT2Ty+q6p3990VIZ88E3vM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-n1jBrSXiM3KzaklyzPRNuA-1; Thu, 07 Sep 2023 17:35:28 -0400
X-MC-Unique: n1jBrSXiM3KzaklyzPRNuA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB76F101CA83;
 Thu,  7 Sep 2023 21:35:27 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4AD8403171;
 Thu,  7 Sep 2023 21:35:26 +0000 (UTC)
Date: Thu, 7 Sep 2023 16:35:25 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 2/8] qemu-nbd: define struct NbdClientOpts when
 HAVE_NBD_DEVICE is not defined
Message-ID: <247kci6felkbxwe4odtolqmjqahdyxpucxzsznfldv3xug2mgo@bldmzulilkjk>
References: <20230906093210.339585-1-den@openvz.org>
 <20230906093210.339585-3-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906093210.339585-3-den@openvz.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 06, 2023 at 11:32:04AM +0200, Denis V. Lunev wrote:
> This patch also drops definition of some locals in main() to avoid
> useless data copy.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  qemu-nbd.c | 60 ++++++++++++++++++++++++------------------------------
>  1 file changed, 27 insertions(+), 33 deletions(-)

> @@ -519,7 +519,6 @@ int main(int argc, char **argv)
>      const char *bindto = NULL;
>      const char *port = NULL;
>      char *sockpath = NULL;
> -    char *device = NULL;
>      QemuOpts *sn_opts = NULL;
>      const char *sn_id_or_name = NULL;
>      const char *sopt = "hVb:o:p:rsnc:dvk:e:f:tl:x:T:D:AB:L";
> @@ -582,16 +581,16 @@ int main(int argc, char **argv)
>      const char *tlshostname = NULL;
>      bool imageOpts = false;
>      bool writethrough = false; /* Client will flush as needed. */
> -    bool verbose = false;
> -    bool fork_process = false;
>      bool list = false;
>      unsigned socket_activation;
>      const char *pid_file_name = NULL;
>      const char *selinux_label = NULL;
>      BlockExportOptions *export_opts;
> -#if HAVE_NBD_DEVICE
> -    struct NbdClientOpts opts;
> -#endif
> +    struct NbdClientOpts opts = {
> +        .fork_process = false,
> +        .verbose = false,
> +        .device = NULL,
> +    };

Could also do 'struct NbdClietnOpts opts = {};' since you happen to be
zero-initializing, but this may not remain the case if more fields get
added to the struct, so I'm fine leaving it as written.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


