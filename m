Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C23F1AC4DC0
	for <lists+qemu-devel@lfdr.de>; Tue, 27 May 2025 13:39:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJse2-0003CF-48; Tue, 27 May 2025 07:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJsdz-0003C7-PK
 for qemu-devel@nongnu.org; Tue, 27 May 2025 07:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJsdu-0001zY-RQ
 for qemu-devel@nongnu.org; Tue, 27 May 2025 07:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748345927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MzwVdnSuLY+al4xlJv9wx0qu8pmKduI9fr06ECG2PhQ=;
 b=c9ozZPlEIuKCS/Hz/PdSPwBEomAs2o/XjtaqF54gmB31uVmT8S4Jg3EZaGpRDnWL+SP2zv
 LDLhxIuVBhaWShJl2IoK/AOfAcqt4yceaxN/sbSQX9FKnR2FtAjrWOjv9ISZPjdglKSwtZ
 /RyUd3bPV2wFbHHiRhsbfCpN88cHrkk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-8xVI8TLZNWK4_DRrWGt4mQ-1; Tue,
 27 May 2025 07:38:42 -0400
X-MC-Unique: 8xVI8TLZNWK4_DRrWGt4mQ-1
X-Mimecast-MFC-AGG-ID: 8xVI8TLZNWK4_DRrWGt4mQ_1748345921
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7166019560AB; Tue, 27 May 2025 11:38:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBE3219560A3; Tue, 27 May 2025 11:38:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 474F121E675E; Tue, 27 May 2025 13:38:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  thuth@redhat.com,
 pbonzini@redhat.com,  richard.henderson@linaro.org,
 peter.maydell@linaro.org,  berrange@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH v4 09/15] qapi: make most CPU commands unconditionally
 available
In-Reply-To: <20250522190542.588267-10-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 22 May 2025 12:05:36 -0700")
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <20250522190542.588267-10-pierrick.bouvier@linaro.org>
Date: Tue, 27 May 2025 13:38:38 +0200
Message-ID: <875xhmqo5d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

You took authorship from Daniel.  Intentional?

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This removes the TARGET_* conditions from all the CPU commands
> that are conceptually target independent. Top level stubs are
> provided to cope with targets which do not currently implement
> all of the commands. Adjust the doc comments accordingly.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


