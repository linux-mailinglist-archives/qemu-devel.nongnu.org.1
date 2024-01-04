Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3C4824452
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 16:00:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLPBw-0003Ks-9H; Thu, 04 Jan 2024 09:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLPBu-0003Kh-Tm
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:59:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLPBt-0006dg-0z
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704380363;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1wX/QG4ac9chsnNAp4cXbz6H6vlE1wNRlQKuak3jvcM=;
 b=c6m5onLtXX/cfd3Q0toCtG4WbyS4b0brNFeLqita3Y2oJRVASm1AnS0Fd9xOh8G4fzNdQl
 QZ8z2FN3QfNdBk900lVQmz/VKdbgW86dI3AhYgUt1SxDW8JplJkyEgePvOoDjlmbkX2IYZ
 2KqHX0QCIvvIkD+9VG7ChpYCX3psuvE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-wXhc0ltqOb2xuZH6aZ_3Qw-1; Thu,
 04 Jan 2024 09:59:20 -0500
X-MC-Unique: wXhc0ltqOb2xuZH6aZ_3Qw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27B3E28040B1;
 Thu,  4 Jan 2024 14:59:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10DEE492BF0;
 Thu,  4 Jan 2024 14:59:18 +0000 (UTC)
Date: Thu, 4 Jan 2024 14:59:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH RESEND v3 08/10] crypto: Introduce 'detached-header'
 field in QCryptoBlockInfoLUKS
Message-ID: <ZZbHxMnMJvwYvsAH@redhat.com>
References: <cover.1703482349.git.yong.huang@smartx.com>
 <0866d2a1e7011831570a377e02cddb5db4b7d855.1703482349.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0866d2a1e7011831570a377e02cddb5db4b7d855.1703482349.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Dec 25, 2023 at 01:45:10PM +0800, Hyman Huang wrote:
> When querying the LUKS disk with the qemu-img tool or other APIs,
> add information about whether the LUKS header is detached.
> 
> Additionally, update the test case with the appropriate
> modification.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  crypto/block-luks.c        | 2 ++
>  qapi/crypto.json           | 3 +++
>  tests/qemu-iotests/210.out | 4 ++++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index 474c7aee2e..c5e53b4ee4 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -1266,6 +1266,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>      block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
>      block->payload_offset =
>          qcrypto_block_luks_payload_offset(luks->header.payload_offset_sector);
> +    block->detached_header = (block->payload_offset == 0) ? true : false;

We shouldn't be looking at payload_offset for this - when we pass
in an enum flag to indicate detached header, we'll know directly.

>  
>      return 0;
>  
> @@ -1892,6 +1893,7 @@ static int qcrypto_block_luks_get_info(QCryptoBlock *block,
>      info->u.luks.master_key_iters = luks->header.master_key_iterations;
>      info->u.luks.uuid = g_strndup((const char *)luks->header.uuid,
>                                    sizeof(luks->header.uuid));
> +    info->u.luks.detached_header = block->detached_header;
>  
>      for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
>          slot = g_new0(QCryptoBlockInfoLUKSSlot, 1);
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index 8e81aa8454..336c880b5d 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -317,6 +317,8 @@
>  #
>  # @hash-alg: the master key hash algorithm
>  #
> +# @detached-header: whether the LUKS header is detached (Since 9.0)
> +#
>  # @payload-offset: offset to the payload data in bytes
>  #
>  # @master-key-iters: number of PBKDF2 iterations for key material
x> @@ -333,6 +335,7 @@
>             'ivgen-alg': 'QCryptoIVGenAlgorithm',
>             '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
>             'hash-alg': 'QCryptoHashAlgorithm',
> +           'detached-header': 'bool',
>             'payload-offset': 'int',
>             'master-key-iters': 'int',
>             'uuid': 'str',
> diff --git a/tests/qemu-iotests/210.out b/tests/qemu-iotests/210.out
> index 96d9f749dd..94b29b2120 100644
> --- a/tests/qemu-iotests/210.out
> +++ b/tests/qemu-iotests/210.out
> @@ -18,6 +18,7 @@ virtual size: 128 MiB (134217728 bytes)
>  encrypted: yes
>  Format specific information:
>      ivgen alg: plain64
> +    detached header: false
>      hash alg: sha256
>      cipher alg: aes-256
>      uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
> @@ -70,6 +71,7 @@ virtual size: 64 MiB (67108864 bytes)
>  encrypted: yes
>  Format specific information:
>      ivgen alg: plain64
> +    detached header: false
>      hash alg: sha1
>      cipher alg: aes-128
>      uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
> @@ -125,6 +127,7 @@ virtual size: 0 B (0 bytes)
>  encrypted: yes
>  Format specific information:
>      ivgen alg: plain64
> +    detached header: false
>      hash alg: sha256
>      cipher alg: aes-256
>      uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
> @@ -195,6 +198,7 @@ virtual size: 0 B (0 bytes)
>  encrypted: yes
>  Format specific information:
>      ivgen alg: plain64
> +    detached header: false
>      hash alg: sha256
>      cipher alg: aes-256
>      uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
> -- 
> 2.39.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


