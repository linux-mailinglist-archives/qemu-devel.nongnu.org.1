Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82880AC6A6B
	for <lists+qemu-devel@lfdr.de>; Wed, 28 May 2025 15:29:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKGpL-0001JW-57; Wed, 28 May 2025 09:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKGov-0001D4-3p
 for qemu-devel@nongnu.org; Wed, 28 May 2025 09:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKGos-0007bi-7a
 for qemu-devel@nongnu.org; Wed, 28 May 2025 09:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748438864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TX0YcX12Ra+mdpfG6QLuWm3MiEr73jksaOuvw43C2Bw=;
 b=hJOQyTQV6QYzVXyL3vXrkDFUr1T4mdLgxtqLlHV6kXav/ZU0Yv1zWQya74Qz8aMmoLWTo3
 S8xoFAfL3C2oK0+Otf/llzTP4TEOOCkqxxbMCL8qaukh2T49uG+VfIztAE85NSC/EoQFJB
 5nPdDj3YxxP/rjal8FZE69+oLVFzgR4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-Svb1liMfMxG-QKwlrEuWaA-1; Wed,
 28 May 2025 09:27:40 -0400
X-MC-Unique: Svb1liMfMxG-QKwlrEuWaA-1
X-Mimecast-MFC-AGG-ID: Svb1liMfMxG-QKwlrEuWaA_1748438860
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9A91195608C; Wed, 28 May 2025 13:27:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81D3219560AA; Wed, 28 May 2025 13:27:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C1DA821E675E; Wed, 28 May 2025 15:27:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  "open
 list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PULL 13/14] tests: Add iotest mirror-sparse for recent patches
In-Reply-To: <4s2evawxpxqfsub7gxqv6kv5pmfd7khxsna4bz7ai72oqpiadu@yvnvovvipauh>
 (Eric Blake's message of "Wed, 28 May 2025 07:40:04 -0500")
References: <20250515022904.575509-16-eblake@redhat.com>
 <20250515022904.575509-29-eblake@redhat.com>
 <874ix5ezgy.fsf@pond.sub.org>
 <4s2evawxpxqfsub7gxqv6kv5pmfd7khxsna4bz7ai72oqpiadu@yvnvovvipauh>
Date: Wed, 28 May 2025 15:27:36 +0200
Message-ID: <87bjrc3lx3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Eric Blake <eblake@redhat.com> writes:

> On Wed, May 28, 2025 at 01:39:25PM +0200, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>> > Prove that blockdev-mirror can now result in sparse raw destination
>> > files, regardless of whether the source is raw or qcow2.  By making
>> > this a separate test, it was possible to test effects of individual
>> > patches for the various pieces that all have to work together for a
>> > sparse mirror to be successful.
>> >
>> > Note that ./check -file produces different job lengths than ./check
>> > -qcow2 (the test uses a filter to normalize); that's because when
>> > deciding how much of the image to be mirrored, the code looks at how
>> > much of the source image was allocated (for qcow2, this is only the
>> > written clusters; for raw, it is the entire file).  But the important
>> > part is that the destination file ends up smaller than 3M, rather than
>> > the 20M it used to be before this patch series.
>> >
>> > Signed-off-by: Eric Blake <eblake@redhat.com>
>> > Message-ID: <20250509204341.3553601-28-eblake@redhat.com>
>> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> 
>> Fails for me:
>> 
>
>>     @@ -184,7 +184,7 @@
>>      {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
>>      {"return": {}}
>>      Images are identical.
>>     -Destination is sparse; expected sparse
>>     +Destination is unknown; expected sparse
>
> Looks like the same failure Fiona reported; does this fix it?
>
> https://lists.gnu.org/archive/html/qemu-devel/2025-05/msg05567.html

It does not.


