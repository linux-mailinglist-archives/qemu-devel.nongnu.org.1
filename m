Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DDCA60AC0
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Mar 2025 09:07:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt04a-0007kB-6D; Fri, 14 Mar 2025 04:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt04X-0007jr-JV
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 04:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt04U-0002Zd-F9
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 04:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741939627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gnCx8Dtq8jRX0uCSsquEgeHydz5Apf0wtj6x2LwP8F4=;
 b=ezW7AqP/A/OIcK+1R57MzNIJPVvVipRtTQabv46nNGTYqagSR2zHrM/Ejd+UHtQraXp2Ow
 3D6sT6wLwg9wGIc+s7HsJ1KAu+qX4DlFWzxijX7lOqSjFKklIe1FJldP/H5VHg0cYYCfhh
 P2MYhs36yhYQUSCMjYgWv0KEi4turxk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-vVXJAFBdN0KKCqDgJw64dQ-1; Fri,
 14 Mar 2025 04:07:04 -0400
X-MC-Unique: vVXJAFBdN0KKCqDgJw64dQ-1
X-Mimecast-MFC-AGG-ID: vVXJAFBdN0KKCqDgJw64dQ_1741939621
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F182B1800258; Fri, 14 Mar 2025 08:07:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBA8A19560AB; Fri, 14 Mar 2025 08:06:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02E5721E66C4; Fri, 14 Mar 2025 09:06:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Konstantin Kostiuk <kkostiuk@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 08/11] docs/qapi-domain: add namespaced index support
In-Reply-To: <20250313044312.189276-9-jsnow@redhat.com> (John Snow's message
 of "Thu, 13 Mar 2025 00:43:09 -0400")
References: <20250313044312.189276-1-jsnow@redhat.com>
 <20250313044312.189276-9-jsnow@redhat.com>
Date: Fri, 14 Mar 2025 09:06:40 +0100
Message-ID: <87tt7wt4rz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

John Snow <jsnow@redhat.com> writes:

> Generate an index-per-namespace for the QAPI domain. Due to a limitation
> with Sphinx's architecture, these indices must be defined during setup
> time and cannot be dynamically created on-demand when a namespace
> directive is encountered.
>
> Owing to that limitation, add a configuration value to conf.py that
> specifies which QAPI namespaces we'll generate indices for.
>
> Indices will be named after their namespace, e.g. the "QMP" namespace
> will generate to "qapi-qmp-index.html" and can be referenced using
> `qapi-qmp-index`.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

I'm going to state my understanding of a few things.  Please correct
misunderstandings, if any.

Before this patch, the QAPI domain creates a single index, and it's
named "QAPI Index".

It has "everything".

This patch adds one index per namespace.  There are none, yet.  The next
patch will add namespace "QMP", and the last patch adds "QGA" and "QSD".

Each of these indexes will have exactly the stuff in that namespace.

The QAPI Index continues to have everything.

The patch adding namespace "QMP" replaces the QEMU QMP Reference
Manual's link to the QAPI Index by a link to the QMP reference (the QAPI
index is no longer linked from anywhere).  At that time, their contents
is still identical, but that stops when the last patch enables the
transmogrifier more widely, so the replacement is clearly necessary.

Since we put everything QAPI in a namespace, the QAPI index has no
entries that aren't also in a namespace's index.

Since QSD's schema is a subset of QMP's, everything in the QSD index and
also in the QMP index.

The QAPI index has everything...  does it link to QMP's copy or QSD's
copy?  I checked block-commit, and it appears to link to QMP's.


