Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC73AC60F9
	for <lists+qemu-devel@lfdr.de>; Wed, 28 May 2025 06:57:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK8q7-0001AD-Bp; Wed, 28 May 2025 00:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uK8q5-0001A5-Er
 for qemu-devel@nongnu.org; Wed, 28 May 2025 00:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uK8q3-0000Q7-Nd
 for qemu-devel@nongnu.org; Wed, 28 May 2025 00:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748408186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XTwm8ZOtM4trNduT74c3RBBzRsOe72HBc1jJoqUBLBE=;
 b=LcSYxWFInXlMeNvQ8RabUI5e5yBWGde9skfiCMx4h4SRdUl9IN4jyUUsIgYtxCPSK30GSB
 coaIXLn9g0KdvtChpARUEheUSKur8yoxNJ4Nkm7ccD+dssbTdtFq2qqIst1Ce79DMGJOFi
 y54ru6XY/+3WJTgLMxKJYupwN7zsgc0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-3P2zRJfVNtWrc0aDzACc4Q-1; Wed,
 28 May 2025 00:56:22 -0400
X-MC-Unique: 3P2zRJfVNtWrc0aDzACc4Q-1
X-Mimecast-MFC-AGG-ID: 3P2zRJfVNtWrc0aDzACc4Q_1748408181
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4651419560AA; Wed, 28 May 2025 04:56:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1262195608D; Wed, 28 May 2025 04:56:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 11A5621E675E; Wed, 28 May 2025 06:56:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  thuth@redhat.com,
 pbonzini@redhat.com,  richard.henderson@linaro.org,
 peter.maydell@linaro.org,  berrange@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH v4 09/15] qapi: make most CPU commands unconditionally
 available
In-Reply-To: <47dae9a0-1a32-4d07-ba2c-1b777d21cad3@linaro.org> (Pierrick
 Bouvier's message of "Tue, 27 May 2025 09:56:27 -0700")
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <20250522190542.588267-10-pierrick.bouvier@linaro.org>
 <875xhmqo5d.fsf@pond.sub.org>
 <47dae9a0-1a32-4d07-ba2c-1b777d21cad3@linaro.org>
Date: Wed, 28 May 2025 06:56:18 +0200
Message-ID: <87v7pljpu5.fsf@pond.sub.org>
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

> On 5/27/25 4:38 AM, Markus Armbruster wrote:
>> You took authorship from Daniel.  Intentional?
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> This removes the TARGET_* conditions from all the CPU commands
>>> that are conceptually target independent. Top level stubs are
>>> provided to cope with targets which do not currently implement
>>> all of the commands. Adjust the doc comments accordingly.
>>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>=20
>
> Not intentional. As said in v3, I did a mistake and squashed this commit,=
 so I re-extracted it during an interactive rebase, "stealing" the authorsh=
ip along the way. You're welcome to change that back under Daniel's name.

Will do, thanks!


