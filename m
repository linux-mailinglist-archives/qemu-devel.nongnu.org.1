Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6BDB10743
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Jul 2025 12:02:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueslz-00006q-Te; Thu, 24 Jul 2025 06:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ueslh-0008Vc-2W
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uesla-0004EV-Nn
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753351293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=yN9U1uWXjs0dAC+lVVdPkW3s4JH/XhtfkAhtLEDbLLM=;
 b=KHIh2yHiS1mXbrOs65OTcFyzemWMfM8cP+NR9NFLu7nBmTvpQYZp0gX5RM4i9FF7oJzDHA
 sBOO3tI5kd0JnAscNp+Hah57iz+Kqh6kLPQ4wb0fQ6L+uLS7qAtTWk9u6I+eqkIJysdiN7
 gEv6ioVfVFBIsIO3tf0S7qMvAw7WPm8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-C1K3dQp6Mhy3nsz_iye5Wg-1; Thu,
 24 Jul 2025 06:01:29 -0400
X-MC-Unique: C1K3dQp6Mhy3nsz_iye5Wg-1
X-Mimecast-MFC-AGG-ID: C1K3dQp6Mhy3nsz_iye5Wg_1753351285
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D60C8180A25E; Thu, 24 Jul 2025 10:01:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8ED2618001DB; Thu, 24 Jul 2025 10:01:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E109B21E6A27; Thu, 24 Jul 2025 12:01:22 +0200 (CEST)
Resent-To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Thu, 24 Jul 2025 12:01:22 +0200
Resent-Message-ID: <87qzy5nc0d.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 1/1] docs/qapi-domain: Improve QAPI indices
In-Reply-To: <87qzy6qc5p.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 24 Jul 2025 09:29:54 +0200")
References: <20250523180809.41211-1-jsnow@redhat.com>
 <20250523180809.41211-2-jsnow@redhat.com>
 <87qzy6qc5p.fsf@pond.sub.org>
Date: Thu, 24 Jul 2025 11:35:34 +0200
Message-ID: <87o6taorrt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Lines: 13
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Alright, that was a tad long.  Here's the shortest feedback I can give.

Thesis: the prime use case for the index is looking up commands and
events.  See my long reply for why.

Usability baseline: an index page with links "A", ... "Z" at the top,
each linking to a flat list of commands and events starting with that
letter, in case-insensitive alphabetical order.

The longest list is "Q": 83 entries.  Most lists are 20 entries or less.

Whatever index page design we choose, it should not be substantially
worse in usability for the prime use case than this baseline.


