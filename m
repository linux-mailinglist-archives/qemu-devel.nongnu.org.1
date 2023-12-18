Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B46F4816C0A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:17:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBcg-0000QB-6z; Mon, 18 Dec 2023 06:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rFBcc-0008V1-TT
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:17:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rFBcL-00009X-HF
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702898220;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2+NP5l9lD00PRE1fUwUY0UjTW4fPOnATX1+rUMdFJ34=;
 b=RptTh2WQw1BlR+al3WRnx5/gpHR9Qu9VPspC27Wgb99FvYmv/dgRsqwjRx2Mz94N3qA35o
 /eD00ZDrcKFNKw8r6IswiDKaeJzbexG77TrrXoRYaVRFwYNzr8q2mSd7kJYbCL2zERS1IC
 WHMs8sIIGMmpKL4kFP/siEbHrnjsVLU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-eZ_AZN35P2S1zWftSXP0QQ-1; Mon, 18 Dec 2023 06:16:56 -0500
X-MC-Unique: eZ_AZN35P2S1zWftSXP0QQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85FE0185A7A7;
 Mon, 18 Dec 2023 11:16:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4D4D1C0652C;
 Mon, 18 Dec 2023 11:16:55 +0000 (UTC)
Date: Mon, 18 Dec 2023 11:16:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [v2 2/4] crypto: Introduce payload offset set function
Message-ID: <ZYAqJREQ5DVVXkfM@redhat.com>
References: <cover.1701879996.git.yong.huang@smartx.com>
 <7130b0b19c38bc4e92071198af54a56f8ba3597c.1701879996.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7130b0b19c38bc4e92071198af54a56f8ba3597c.1701879996.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Dec 07, 2023 at 12:37:43AM +0800, Hyman Huang wrote:
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  crypto/block.c         | 4 ++++
>  include/crypto/block.h | 1 +
>  2 files changed, 5 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

however, based on my comment in patch #3, I'm not convinced this method
is needed

> 
> diff --git a/crypto/block.c b/crypto/block.c
> index 7bb4b74a37..3dcf22a69f 100644
> --- a/crypto/block.c
> +++ b/crypto/block.c
> @@ -319,6 +319,10 @@ QCryptoHashAlgorithm qcrypto_block_get_kdf_hash(QCryptoBlock *block)
>      return block->kdfhash;
>  }
>  
> +void qcrypto_block_set_payload_offset(QCryptoBlock *block, uint64_t offset)
> +{
> +    block->payload_offset = offset;
> +}
>  
>  uint64_t qcrypto_block_get_payload_offset(QCryptoBlock *block)
>  {
> diff --git a/include/crypto/block.h b/include/crypto/block.h
> index 4f63a37872..b47a90c529 100644
> --- a/include/crypto/block.h
> +++ b/include/crypto/block.h
> @@ -312,4 +312,5 @@ void qcrypto_block_free(QCryptoBlock *block);
>  
>  G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoBlock, qcrypto_block_free)
>  
> +void qcrypto_block_set_payload_offset(QCryptoBlock *block, uint64_t offset);
>  #endif /* QCRYPTO_BLOCK_H */
> -- 
> 2.39.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


