Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
Delivered-To: lists+qemu-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IsqEdWtb2nxEwAAu9opvQ
	(envelope-from <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>)
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 17:31:17 +0100
X-Original-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDB44793E
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 17:31:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi9Iu-0001t8-Lk; Tue, 20 Jan 2026 05:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vi9Is-0001iq-Ql
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:49:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vi9Ir-0000fO-0T
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768906178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZM3K3Tbck9r3d+UwJrgrMb67JD1AdDh3wepHCi4qrmM=;
 b=XNfPHcdkXlyzwm7R0yQd4fdfP0FRvAHdxhiiN1VnndaIVNSbbPngczYTigP1+lcufvb8LJ
 P2QgfcEzrGDfMf3f8VkHFSLrcT0G8h3HdT2Rryz0qLFtHecnUERGa+aELHBfnYUvMG9yRb
 wxfpf6ySchZrJ8U0hXma0KhDBwR97oA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-Yq_2BwxwM6KvsAXwd5NNOg-1; Tue,
 20 Jan 2026 05:49:35 -0500
X-MC-Unique: Yq_2BwxwM6KvsAXwd5NNOg-1
X-Mimecast-MFC-AGG-ID: Yq_2BwxwM6KvsAXwd5NNOg_1768906173
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB0DA1956050; Tue, 20 Jan 2026 10:49:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30C2118004D8; Tue, 20 Jan 2026 10:49:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B89DA21E692D; Tue, 20 Jan 2026 11:49:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,  qemu-devel@nongnu.org,  Phil
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Stefan Hajnoczi
 <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  John Snow <jsnow@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] MAINTAINERS: add maintainer for docs/
In-Reply-To: <b33bfa26-5f41-4bad-9911-37d0b58618dd@linaro.org> (Pierrick
 Bouvier's message of "Mon, 19 Jan 2026 10:47:49 -0800")
References: <20260115203529.2713193-1-pierrick.bouvier@linaro.org>
 <88cdd7fb-059b-4ce2-9db6-57700aad0571@redhat.com>
 <467c2bca-af39-4e00-b8ea-9e38c1f16e54@linaro.org>
 <dce4a763-d64a-4ef3-be05-9c24080c8003@redhat.com>
 <b33bfa26-5f41-4bad-9911-37d0b58618dd@linaro.org>
Date: Tue, 20 Jan 2026 11:49:30 +0100
Message-ID: <87o6moh83p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
X-Spamd-Result: default: False [-0.71 / 15.00];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MAILLIST(-0.20)[mailman];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:209.51.188.0/24:c];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pierrick.bouvier@linaro.org,m:thuth@redhat.com,m:qemu-devel@nongnu.org,m:philmd@linaro.org,m:stefanha@redhat.com,m:peter.maydell@linaro.org,m:berrange@redhat.com,m:alex.bennee@linaro.org,m:pbonzini@redhat.com,m:jsnow@redhat.com,m:richard.henderson@linaro.org,m:farosas@suse.de,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[armbru@redhat.com,qemu-devel-bounces@nongnu.org];
	TAGGED_FROM(0.00)[lists,qemu-devel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[qemu-devel@nongnu.org];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armbru@redhat.com,qemu-devel-bounces@nongnu.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.gnu.org:rdns,lists.gnu.org:helo,linaro.org:email];
	TAGGED_RCPT(0.00)[qemu-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:22989, ipnet:209.51.188.0/24, country:US];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DEDB44793E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

[...]

> I tend to see series as an atomic change, expecting them to be pulled as a whole. Thus, I expect, maybe wrongly, that isolated doc patches will be pulled with the concerned series.

Your expectation matches how I work as overall QAPI schema maintainer.
Most patch series modifying qapi/ aren't about the QAPI schema.  I
routinely review just the QAPI part, and leave the remainder and the
merging to the actual subject matter maintainers.

[...]


