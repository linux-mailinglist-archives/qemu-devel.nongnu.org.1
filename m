Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1264385BFC3
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Feb 2024 16:22:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcRwp-00012Y-6t; Tue, 20 Feb 2024 10:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcRwn-00012O-6w
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:22:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcRwk-0006SS-Kd
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708442534;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVyNAl89MUxiHEn6yEpDl+j7Xvg8M1GxKet1iL+ILY4=;
 b=e++d2WTTgQDKvxWP9X8KuYao3EOOp29Z/61gXnfnC11Mb0Y+zX8U+Lnwj3MR6BvX94B/6a
 qEOK+Cggdgz4u7+3tEn+tpxMepAFInnV6p6zB1XLYfybL2L5PlOiJbJi78fJz67SDHz0pu
 vjM3ioV28PVIApCM97BzF/pLle2BrpU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-QuKfvedmN_iKLm1u0C5n8A-1; Tue, 20 Feb 2024 10:22:10 -0500
X-MC-Unique: QuKfvedmN_iKLm1u0C5n8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D85985A58A;
 Tue, 20 Feb 2024 15:22:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A7191C10C0E;
 Tue, 20 Feb 2024 15:22:09 +0000 (UTC)
Date: Tue, 20 Feb 2024 15:22:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com,
 eblake@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH 11/16] qapi: Recognize section tags and 'Features:' only
 after blank line
Message-ID: <ZdTDn05noU8Ah7lK@redhat.com>
References: <20240216145841.2099240-1-armbru@redhat.com>
 <20240216145841.2099240-12-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216145841.2099240-12-armbru@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

On Fri, Feb 16, 2024 at 03:58:35PM +0100, Markus Armbruster wrote:
> Putting a blank line before section tags and 'Features:' is good,
> existing practice.  Enforce it.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/qapi-code-gen.rst                 | 15 +++++++++------
>  scripts/qapi/parser.py                       | 11 ++++++++---
>  tests/qapi-schema/doc-duplicated-return.err  |  2 +-
>  tests/qapi-schema/doc-duplicated-return.json |  1 +
>  tests/qapi-schema/doc-duplicated-since.err   |  2 +-
>  tests/qapi-schema/doc-duplicated-since.json  |  1 +
>  tests/qapi-schema/doc-good.json              |  9 +++++++++
>  tests/qapi-schema/doc-invalid-return.err     |  2 +-
>  tests/qapi-schema/doc-invalid-return.json    |  1 +
>  9 files changed, 32 insertions(+), 12 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> @@ -574,9 +577,11 @@ def end_comment(self) -> None:
>      def _match_at_name_colon(string: str) -> Optional[Match[str]]:
>          return re.match(r'@([^:]*): *', string)
>  
> -    @staticmethod
> -    def _match_section_tag(string: str) -> Optional[Match[str]]:
> -        return re.match(r'(Returns|Since|Notes?|Examples?|TODO): *', string)
> +    def _match_section_tag(self, string: str) -> Optional[Match[str]]:
> +        if not self._first_line_in_paragraph:
> +            return None
> +        return re.match(r'(Returns|Since|Notes?|Examples?|TODO): *',
> +                        string)

I guess I have a minor worry that we're silently ignoring
these tags when there's no blank line. Could result in
docs silently rendering in the wrong way if (when) someone
forgets the blank line.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


