Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E89B6A922B3
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Apr 2025 18:29:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5S5y-0006I1-Se; Thu, 17 Apr 2025 12:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5S5f-0006AY-KO
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5S5d-00072X-Hr
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744907266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WhByg6BfNjOrJafbpfrhi0KsFDKVhzvpYdn6UpxoDao=;
 b=QW3SPsuXeA4CdBih1aTKtfZAiriZgmvfTG1fRjbTB/j54CI7UHA078HCY2labexTao6OA6
 AE10egIr6yjDfcjprVrXj5sltggPA9cBFP/Iqjmumj0PCbUwFVViDpm3JxeGVCL8GaAaHY
 ZFbx+3SjMr+AsbKNY5hx2w8djx+hiyc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-8l9k2DZlOd2MY4aIjbLlTQ-1; Thu,
 17 Apr 2025 12:27:43 -0400
X-MC-Unique: 8l9k2DZlOd2MY4aIjbLlTQ-1
X-Mimecast-MFC-AGG-ID: 8l9k2DZlOd2MY4aIjbLlTQ_1744907262
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 972B71800876; Thu, 17 Apr 2025 16:27:42 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.121])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60E5F180045C; Thu, 17 Apr 2025 16:27:38 +0000 (UTC)
Date: Thu, 17 Apr 2025 11:27:36 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 1/2] file-posix: probe discard alignment on Linux
 block devices
Message-ID: <wk6gm5wkvnjmo23j45kzukscd3nyve62fvtkloggqnad6m3knf@ugym5o7hgd52>
References: <20250414201214.241351-1-stefanha@redhat.com>
 <20250414201214.241351-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414201214.241351-2-stefanha@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Apr 14, 2025 at 04:12:13PM -0400, Stefan Hajnoczi wrote:
> Populate the pdiscard_alignment block limit so the block layer is able
> align discard requests correctly.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/file-posix.c | 67 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 1 deletion(-)
> 

> +static int get_sysfs_u32_val(struct stat *st, const char *attribute,
> +                             uint32_t *u32)
> +{
> +    g_autofree char *str = NULL;
> +    const char *end;
> +    unsigned int val;
> +    int ret;
> +
> +    ret = get_sysfs_str_val(st, attribute, &str);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    /* The file is ended with '\n', pass 'end' to accept that. */
> +    ret = qemu_strtoui(str, &end, 10, &val);
> +    if (ret == 0 && end && *end == '\0') {

This doesn't match the comment.  If we expect the file contents to end
in \n, then this should be checking *end == '\n', not '\0'.

> +        *u32 = val;
> +    }
> +    return ret;
> +}
>  #endif
>  

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


