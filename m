Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F382BCC635
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Oct 2025 11:40:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v79bC-0002q5-93; Fri, 10 Oct 2025 05:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v79b7-0002po-WF
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 05:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v79az-0001N1-8Z
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 05:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760089160;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZsRfDQSEk8oeyj/ienSA5RBIJXRh8sHbtSYBY68kpbo=;
 b=KkBNQnx4oQj8+F5jNTv/UW5ZVL+4XPJw5Ne9Cbv8R8/Q6gOhx76F1saiM/DXIh8vVUPdGd
 y703DxdC1I22B3gxlhxRXETtKA5XZC+8epU9GsastDIItW9gRUvkX3yHTsEVXXdERM3HWd
 Pb5NraX9FsoYYviEc3Icqvw47CxLq8c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-1ONASgThNwSn-hXXheZ8Zg-1; Fri,
 10 Oct 2025 05:39:16 -0400
X-MC-Unique: 1ONASgThNwSn-hXXheZ8Zg-1
X-Mimecast-MFC-AGG-ID: 1ONASgThNwSn-hXXheZ8Zg_1760089155
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B43CE19560B1; Fri, 10 Oct 2025 09:39:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.177])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1F9A1955F22; Fri, 10 Oct 2025 09:39:13 +0000 (UTC)
Date: Fri, 10 Oct 2025 10:39:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/2] tests/functional: Set current time stamp of assets
 when using them
Message-ID: <aOjUPd5pu1C0sDaf@redhat.com>
References: <20251010093244.807544-1-thuth@redhat.com>
 <20251010093244.807544-2-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010093244.807544-2-thuth@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 10, 2025 at 11:32:42AM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We are going to remove obsolete assets from the cache, so keep
> the time stamps of the assets that we use up-to-date to have a way
> to detect stale assets later.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/qemu_test/asset.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index 2971a989d1e..251953ed99f 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -10,6 +10,7 @@
>  import os
>  import stat
>  import sys
> +import time
>  import unittest
>  import urllib.request
>  from time import sleep
> @@ -113,6 +114,11 @@ def _wait_for_other_download(self, tmp_cache_file):
>          self.log.debug("Time out while waiting for %s!", tmp_cache_file)
>          raise
>  
> +    def _save_time_stamp(self):
> +        with open(self.cache_file.with_suffix(".stamp"), 'w',
> +                  encoding='utf-8') as fh:
> +            fh.write(f"{int(time.time())}")

Rather than creating a parallel timestamp file, it feels like we could
just call  'os.utime(self.cache_file)' which will set atime + mtime
to the current timestamp, which we can check later with os.stat().

> +
>      def fetch(self):
>          if not self.cache_dir.exists():
>              self.cache_dir.mkdir(parents=True, exist_ok=True)
> @@ -120,6 +126,7 @@ def fetch(self):
>          if self.valid():
>              self.log.debug("Using cached asset %s for %s",
>                             self.cache_file, self.url)
> +            self._save_time_stamp()
>              return str(self.cache_file)
>  
>          if not self.fetchable():
> @@ -208,6 +215,7 @@ def fetch(self):
>              tmp_cache_file.unlink()
>              raise AssetError(self, "Hash does not match %s" % self.hash)
>          tmp_cache_file.replace(self.cache_file)
> +        self._save_time_stamp()
>          # Remove write perms to stop tests accidentally modifying them
>          os.chmod(self.cache_file, stat.S_IRUSR | stat.S_IRGRP)
>  
> -- 
> 2.51.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


