Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE22DAB7CB2
	for <lists+qemu-devel@lfdr.de>; Thu, 15 May 2025 06:41:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFQOD-0000lc-3O; Thu, 15 May 2025 00:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uFQOB-0000l0-Ho
 for qemu-devel@nongnu.org; Thu, 15 May 2025 00:40:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uFQO9-0000l4-Q1
 for qemu-devel@nongnu.org; Thu, 15 May 2025 00:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747284007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J8ZYlYkFbuaokyWFJRrnBH5LXTMBQvBXgQz+MqdS4gI=;
 b=E+fP42c6e2Mto5Zr3ew4/Eea/r81sYMEWwmK16hrgOf1a8Fp0nCAR1I0+0ihd2UIE7AAmn
 32FCicbKWN3bEq7sHklJ7i33CmwY50hh5Fppa9OSCTM53TjR7kIBgErY81pCcKMlVwZwXL
 PYJBdM+3sosacH2oUHNeqUt1Rn4llAI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-S-zcTIC5P96X8ZmF80EWmg-1; Thu,
 15 May 2025 00:40:03 -0400
X-MC-Unique: S-zcTIC5P96X8ZmF80EWmg-1
X-Mimecast-MFC-AGG-ID: S-zcTIC5P96X8ZmF80EWmg_1747284002
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B31A1800871; Thu, 15 May 2025 04:40:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8FA31955F24; Thu, 15 May 2025 04:40:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 312DA21E6768; Thu, 15 May 2025 06:39:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  alex.bennee@linaro.org,  stefanha@redhat.com,
 peter.maydell@linaro.org,  richard.henderson@linaro.org,
 pbonzini@redhat.com,  jsnow@redhat.com,  philmd@linaro.org,
 berrange@redhat.com,  thuth@redhat.com,  Michael Roth
 <michael.roth@amd.com>
Subject: Re: [PATCH 01/13] qapi: introduce 'runtime_if' for QAPI json
In-Reply-To: <20250507231442.879619-2-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Wed, 7 May 2025 16:14:31 -0700")
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-2-pierrick.bouvier@linaro.org>
Date: Thu, 15 May 2025 06:39:59 +0200
Message-ID: <878qmy5vxc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Consensus is to shelve this series, and eliminate target-specific
conditionals instead.  But let me scribble down a few notes for
posterity just in case we ever take it off the shelf again.

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This new entry can be used in QAPI json to specify a runtime conditional
> to expose any entry, similar to existing 'if', that applies at compile
> time, thanks to ifdef. The element is always defined in C, but not
> exposed through the schema and visit functions, thus being hidden for a
> QMP consumer.
>
> QAPISchemaIfCond is extended to parse this information. A first version
> was tried duplicating this, but this proved to be much more boilerplate
> than needed to pass information through all function calls.
>
> 'if' and 'runtime_if' can be combined elegantly on a single item,
> allowing to restrict an element to be present based on compile time
> defines, and runtime checks at the same time.

I understand the combination is "and", i.e. both conditions need to be
satisfied.

The syntax change I'd consider elegant (it's subjective!) is *none*.
Instead of

    'if': 'CONFIG_DINGS',
    'runtime_if': 'target_bums()'

use

    'if': ['all': ['CONFIG_DINGS', 'target_bums()']]

Might need semantic restrictions to simplify the implementation.

> Note: This commit only adds parsing of runtime_if, and does not hide
> anything yet.
>
> For review:
>
> - I don't really like "runtime_if" name.
>   What would make sense, IMHO, is to rename existing 'if' to 'ifdef',
>   and reuse 'if' for 'runtime_if'. Since it requires invasive changes, I
>   would prefer to get agreement before wasting time in case you prefer
>   any other naming convention. Let me know what you'd like.
>
> - As mentioned in second paragraph, I think our best implementation
>   would be to extend existing QAPISchemaIfCond, as it's really
>   complicated to extend all call sites if we have another new object.

I figure the alternative is an abstract type with two concrete subtypes,
one for each kind of conditional.

> - No tests/doc added at this time, as I prefer to wait that we decide
>   about naming and proposed approach first.

We'd need

* Positive test(s) in tests/qapi-schema/qapi-schema-test.json

* Negative tests similar to the ones with have for 'if'

* Documentation update docs/devel/qapi-code-gen.rst

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


