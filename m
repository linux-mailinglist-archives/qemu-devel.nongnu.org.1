Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D599AC6105
	for <lists+qemu-devel@lfdr.de>; Wed, 28 May 2025 07:01:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK8ug-0002jN-B8; Wed, 28 May 2025 01:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uK8ue-0002j8-B9
 for qemu-devel@nongnu.org; Wed, 28 May 2025 01:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uK8uc-000101-Br
 for qemu-devel@nongnu.org; Wed, 28 May 2025 01:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748408469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ln2H/lci0gR670gcl0e7/q+6MNmGrZ8jrHPXAbVgFrI=;
 b=fF260VYsFAL+TboY1plvp8wv5SxWDrdBuF/BunLrKMQJavKiFAPiQi+KY0cG7pTtaCY9cW
 gJL7Ws35Tc07zsGFmcsxx+6cKbJxstCbB1JpjBwPJr+sDaq5BOmtf51BoWgLpieLhfEYPe
 oVJlGGMO2iPlwl+WZjDUj2KZiIs+o0o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-tO4D9hI_PGCJxX0ee_2UmA-1; Wed,
 28 May 2025 01:01:05 -0400
X-MC-Unique: tO4D9hI_PGCJxX0ee_2UmA-1
X-Mimecast-MFC-AGG-ID: tO4D9hI_PGCJxX0ee_2UmA_1748408464
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EA97195609F; Wed, 28 May 2025 05:01:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22C7F195608D; Wed, 28 May 2025 05:01:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A98A721E6757; Wed, 28 May 2025 07:01:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  thuth@redhat.com,
 pbonzini@redhat.com,  richard.henderson@linaro.org,
 peter.maydell@linaro.org,  berrange@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH v4 00/15] qapi: remove all TARGET_* conditionals from
 the schema
In-Reply-To: <d2666050-5ff3-4807-87cf-dfaf43ae9c9f@linaro.org> (Pierrick
 Bouvier's message of "Tue, 27 May 2025 09:51:27 -0700")
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <87frgqnr79.fsf@pond.sub.org>
 <d2666050-5ff3-4807-87cf-dfaf43ae9c9f@linaro.org>
Date: Wed, 28 May 2025 07:01:01 +0200
Message-ID: <87msaxjpma.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 5/27/25 6:00 AM, Markus Armbruster wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> This series exposes all qmp commands for any target unconditionally, al=
lowing to
>>> compile QAPI generated code without any TARGET conditionals.
>>>
>>> Based on original RFC from Daniel P. Berrang=C3=A9:
>>> https://lore.kernel.org/qemu-devel/20250508135816.673087-1-berrange@red=
hat.com/
>> I picked a few nits.  I'm happy to address them in my tree without a
>> respin.  If you object to any, please let me know.
>>=20
>
> I'm ok if you want to take that in your tree, and address them directly.
> All the comments change requested are ok for me.
> I'll answer on individual commits for your questions.
>
> If you expect a respin on my side, let me know (from what I understand, i=
t's not expected at this point).

Correct.  Thanks!

[...]


