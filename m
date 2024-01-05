Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA9F825808
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 17:23:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmy7-00024A-Hr; Fri, 05 Jan 2024 11:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLmy6-000240-BU
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 11:22:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLmy4-0005It-KM
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 11:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704471763;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CtTP3RcB1BFXOijIa587SgItUpTvk6MoEyNysH5Q3ZI=;
 b=XwXUOOtn/csv1PbUJKkdL/YZs1xlo/w+q+VznAiSULDaXMtLJgp/nohoYwuqXsB0cvFtFU
 Cqc9qoKOEtG221f6KnWqw/Hze5EpwzAJhBRHm2B2UjGjzw9o6HmjBB9uO2qQj9W6aaKE//
 yw3Kupm0MDrAgKYI0/YlCjD+qw1I7rU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-nivwPJ6COW-Sz1vWKxqO5A-1; Fri, 05 Jan 2024 11:22:42 -0500
X-MC-Unique: nivwPJ6COW-Sz1vWKxqO5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF8F7101A58E;
 Fri,  5 Jan 2024 16:22:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 181ED3C27;
 Fri,  5 Jan 2024 16:22:40 +0000 (UTC)
Date: Fri, 5 Jan 2024 16:22:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] i386/sev: Nitpick at the error message's output
Message-ID: <ZZgszhW30kyNnbEj@redhat.com>
References: <c5033954155dfe256f650fc9ca2084c688356317.1704469721.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5033954155dfe256f650fc9ca2084c688356317.1704469721.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.679,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Sat, Jan 06, 2024 at 12:09:55AM +0800, Hyman Huang wrote:
> The incorrect error message was produced as a result of
> the return number being disregarded on the sev_kvm_init
> failure path.
> 
> For instance, when a user's failure to launch a SEV guest
> is caused by an incorrect IOCTL, the following message is
> reported:
> 
> kvm: sev_kvm_init: failed to initialize ret=-25 fw_error=0
> kvm: failed to initialize kvm: Operation not permitted
> 
> While the error message's accurate output should be:
> 
> kvm: sev_kvm_init: failed to initialize ret=-25 fw_error=0
> kvm: failed to initialize kvm: Inappropriate ioctl for device
> 
> Fix this by returning the return number directly on the
> failure path.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  target/i386/sev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 9a71246682..4a69ca457c 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -1019,7 +1019,7 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>  err:
>      sev_guest = NULL;
>      ram_block_discard_disable(false);
> -    return -1;
> +    return ret;
>  }

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


