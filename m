Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13859B087ED
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Jul 2025 10:30:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucK03-0000VU-6c; Thu, 17 Jul 2025 04:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucJzw-0000Mt-DQ
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucJzu-0001nT-JO
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752740984;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NI5vqa5AfsIw7zbPY1WJZ2O1b+eF0vavD2CCyQaqS6o=;
 b=byW/Td7aIQHhmFRoyxwKchptBqNhrcAc+LyOsj/nBWH93y9qnH7brijXhoZfWYySHUB5tH
 R18wfnx31gH6qxJPYYrnQvjimYJpNHU9u0HVEo+r7jwiwPMopq6kIyfOMw/8pzB4Dg8npt
 uUOpGO3c4aw3l+m913+D171ubnGx3KQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-5DdtKHt5O5ylBaRkI1pDfg-1; Thu,
 17 Jul 2025 04:29:40 -0400
X-MC-Unique: 5DdtKHt5O5ylBaRkI1pDfg-1
X-Mimecast-MFC-AGG-ID: 5DdtKHt5O5ylBaRkI1pDfg_1752740980
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E60F6195FD2B; Thu, 17 Jul 2025 08:29:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.171])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96E5B30001B9; Thu, 17 Jul 2025 08:29:34 +0000 (UTC)
Date: Thu, 17 Jul 2025 09:29:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, michael.roth@amd.com,
 kkostiuk@redhat.com, jsnow@redhat.com
Subject: Re: [PATCH 2/4] qga: Remove trivial "Returns:" sections
Message-ID: <aHi0aAG7mZtBWAnz@redhat.com>
References: <20250717082117.3767754-1-armbru@redhat.com>
 <20250717082117.3767754-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717082117.3767754-3-armbru@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 17, 2025 at 10:21:15AM +0200, Markus Armbruster wrote:
> The QAPI doc generator recently started to auto-generate return
> documentation when there is no "Returns:" section (commit 636c96cd77d
> "qapi: Fix undocumented return values by generating something").
> Remove "Returns:" sections where the auto-generated text is obviously
> no worse.  For instance, guest-info's documentation changes from
> 
>     Return:
>        GuestAgentInfo -- GuestAgentInfo
> 
> to
> 
>     Return:
>        GuestAgentInfo
> 
> The auto-generated returns all are in the exact same spot.
> 
> We did this for qapi/ in commit 0462da9d6b1 (qapi: remove trivial
> "Returns:" sections).
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qga/qapi-schema.json | 25 -------------------------
>  1 file changed, 25 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


