Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91881AC6186
	for <lists+qemu-devel@lfdr.de>; Wed, 28 May 2025 08:03:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK9rf-0005s7-3A; Wed, 28 May 2025 02:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uK9rb-0005rg-4y
 for qemu-devel@nongnu.org; Wed, 28 May 2025 02:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uK9rY-0008NR-Sc
 for qemu-devel@nongnu.org; Wed, 28 May 2025 02:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748412122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kkYpDK8nKrthR9ENytDWZIF6JEpVfNYGuhYw+orPvNw=;
 b=MjxDrykWHDFg2RPvynsSGOGWmfKOhMz9IWyFFge7CQKPo42SIQZ3Ob4f2j3WJE7kqhQRc/
 H/0UJQ9lvy3u07KSjIqTsMYOShB3hOT8HmNTNzSWEC7SZi2xh8vRtMmlGrjM3aGeyNN1lD
 piLIGOxKjNIRGxCce4Tno+2jhqiL0bk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-iT0Iwj4bPzCNycpYBiBDIw-1; Wed,
 28 May 2025 02:01:58 -0400
X-MC-Unique: iT0Iwj4bPzCNycpYBiBDIw-1
X-Mimecast-MFC-AGG-ID: iT0Iwj4bPzCNycpYBiBDIw_1748412117
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A663180087B; Wed, 28 May 2025 06:01:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B94F719560A3; Wed, 28 May 2025 06:01:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D47521E6757; Wed, 28 May 2025 08:01:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  thuth@redhat.com,
 pbonzini@redhat.com,  richard.henderson@linaro.org,
 peter.maydell@linaro.org,  berrange@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH v4 02/15] qapi: expand docs for SEV commands
In-Reply-To: <7510ffa1-e84d-4d59-8733-86f913e91799@linaro.org> (Pierrick
 Bouvier's message of "Tue, 27 May 2025 09:54:49 -0700")
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <20250522190542.588267-3-pierrick.bouvier@linaro.org>
 <87h616qoq2.fsf@pond.sub.org>
 <7510ffa1-e84d-4d59-8733-86f913e91799@linaro.org>
Date: Wed, 28 May 2025 08:01:54 +0200
Message-ID: <87iklljmst.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

> On 5/27/25 4:26 AM, Markus Armbruster wrote:

[...]

> All good for me.
> The only question that crossed my mind when you asked for those changes previously was: "Why does QAPI has it's own style, and not simply following the QEMU official style?"

Fair question!  It's down to the difference between code and
documentation text.

Humans tend to have trouble following long lines with their eyes (I sure
do).  Typographic manuals suggest to limit columns to roughly 60
characters for exactly that reason[*].

For code, four levels of indentation plus 60 characters of actual text
yields 76.  However, code lines can be awkward to break, and going over
80 can be less bad than an awkward line break.  Use your judgement.

Documentation text, however, tends to be indented much less: 6-10
characters of indentation plus 60 of actual text yields 66-70.  When I
reflowed the entire QAPI schema documentation to stay within that limit
(commit a937b6aa739), not a single line break was awkward.

> In the end, you choose which rules apply to this subsystem, and I have no strong opinion on whether it should be 70, 72 or 80 characters on the line, or if we prefer tabs to spaces (to make some analogy). I just think it's surprising to have a different coding style only here for arbitrary reasons.

I hope you understand my reasons better now :)


[*] https://en.wikipedia.org/wiki/Column_(typography)#Typographic_style


