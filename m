Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B287EA196
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:02:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2aIw-0004Iv-9r; Mon, 13 Nov 2023 12:00:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r2aIc-0004DF-JS
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:00:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r2aIa-0003HM-Mo
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699894831;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ke0I3hj/zyNokb5NbokgD8RE7oBwMJxzs481lGhfDdY=;
 b=B/fVvggf5cc5rD0j6iN/lf0YwaKyaf5uemwchP2lJgMUC1rchf2bM5fnaem2am5zKo6vEL
 bVZHfmtiKvGQG/2bLpeRhDWlm6JQ/YttC8UA6Norlw+AibZJezPXfYtiuAgB1P0/V2a3ur
 uK35AseQUH0qIZIHb0IUl9urmvgrPmI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-e_ySB_eQOFKkTAW8AiX7jA-1; Mon,
 13 Nov 2023 12:00:29 -0500
X-MC-Unique: e_ySB_eQOFKkTAW8AiX7jA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03F3C1C07551;
 Mon, 13 Nov 2023 17:00:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F30CC5031;
 Mon, 13 Nov 2023 17:00:27 +0000 (UTC)
Date: Mon, 13 Nov 2023 17:00:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] tests/qemu-iotests/149: Use more inclusive language
 in this test
Message-ID: <ZVJWKdDYSeeEthmD@redhat.com>
References: <20231113165642.62012-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231113165642.62012-1-thuth@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Nov 13, 2023 at 05:56:42PM +0100, Thomas Huth wrote:
> Let's use 'unsupported_configs' and 'tested_configs' here instead
> of non-inclusive words.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Use different wordings (suggested by Paolo)
> 
>  tests/qemu-iotests/149     | 16 +++++++++-------
>  tests/qemu-iotests/149.out |  8 ++++----
>  2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
> index 2ae318f16f..2a8bb5787f 100755
> --- a/tests/qemu-iotests/149
> +++ b/tests/qemu-iotests/149
> @@ -518,7 +518,7 @@ configs = [
>  
>  ]
>  
> -blacklist = [
> +unsupported_configs = [
>      # We don't have a cast-6 cipher impl for QEMU yet
>      "cast6-256-xts-plain64-sha1",
>      "cast6-128-xts-plain64-sha1",
> @@ -528,17 +528,19 @@ blacklist = [
>      "twofish-192-xts-plain64-sha1",
>  ]
>  
> -whitelist = []
> +# Optionally test only the configurations in the LUKS_CONFIG
> +# environment variable
> +tested_configs = None
>  if "LUKS_CONFIG" in os.environ:
> -    whitelist = os.environ["LUKS_CONFIG"].split(",")
> +    tested_configs = os.environ["LUKS_CONFIG"].split(",")
>  
>  for config in configs:
> -    if config.name in blacklist:
> -        iotests.log("Skipping %s in blacklist" % config.name)
> +    if config.name in unsupported_configs:
> +        iotests.log("Skipping %s (cipher not supported)" % config.name)

s/cipher/config/  - this is about more than just ciphers - it is the
combination of algorithms (cipher, hash, ivgen).

>          continue
>  
> -    if len(whitelist) > 0 and config.name not in whitelist:
> -        iotests.log("Skipping %s not in whitelist" % config.name)
> +    if tested_configs is not None and config.name not in tested_configs:
> +        iotests.log("Skipping %s (not in LUKS_CONFIG)" % config.name)

This is essentially at the demand of the person invoking it, so I'd
say

  s/not in LUKS_CONFIG/by user request/



>          continue
>  
>      test_once(config, qemu_img=False)
> diff --git a/tests/qemu-iotests/149.out b/tests/qemu-iotests/149.out
> index 2cc5b82f7c..3c731bdf95 100644
> --- a/tests/qemu-iotests/149.out
> +++ b/tests/qemu-iotests/149.out
> @@ -470,7 +470,7 @@ sudo cryptsetup -q -v luksClose qiotest-145-cast5-128-cbc-plain64-sha1
>  # Delete image
>  unlink TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img
>  
> -Skipping cast6-256-xts-plain64-sha1 in blacklist
> +Skipping cast6-256-xts-plain64-sha1 (cipher not supported)
>  # ================= dm-crypt aes-256-cbc-plain-sha1 =================
>  # Create image
>  truncate TEST_DIR/luks-aes-256-cbc-plain-sha1.img --size 4194304MB
> @@ -1297,7 +1297,7 @@ sudo cryptsetup -q -v luksClose qiotest-145-twofish-128-xts-plain64-sha1
>  # Delete image
>  unlink TEST_DIR/luks-twofish-128-xts-plain64-sha1.img
>  
> -Skipping twofish-192-xts-plain64-sha1 in blacklist
> +Skipping twofish-192-xts-plain64-sha1 (cipher not supported)
>  # ================= dm-crypt serpent-128-xts-plain64-sha1 =================
>  # Create image
>  truncate TEST_DIR/luks-serpent-128-xts-plain64-sha1.img --size 4194304MB
> @@ -1534,8 +1534,8 @@ sudo cryptsetup -q -v luksClose qiotest-145-serpent-192-xts-plain64-sha1
>  # Delete image
>  unlink TEST_DIR/luks-serpent-192-xts-plain64-sha1.img
>  
> -Skipping cast6-128-xts-plain64-sha1 in blacklist
> -Skipping cast6-192-xts-plain64-sha1 in blacklist
> +Skipping cast6-128-xts-plain64-sha1 (cipher not supported)
> +Skipping cast6-192-xts-plain64-sha1 (cipher not supported)
>  # ================= dm-crypt aes-256-xts-plain64-sha224 =================
>  # Create image
>  truncate TEST_DIR/luks-aes-256-xts-plain64-sha224.img --size 4194304MB
> -- 
> 2.41.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


