Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D54C0CEB0
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Oct 2025 11:17:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKHU-0006GK-U5; Mon, 27 Oct 2025 06:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDKHS-0006G7-Aq
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDKHQ-0004sW-6c
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761560204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/4QCH25JEz2SPuST2J4Z+5Os08+y6fUy8gj9P85NJ64=;
 b=GZ2PGKKiCuYfNbK5xgeGpfNgePMGstZjUHmin4w576mZ6atnKyiADBCnmOE+wKTEmKCR+N
 V+5oWh52qgkC3mmY+r+79VulmD4IfIkY6xIXQk538/5n+fB99kddzAAMIu1AND0+V2qZnm
 64NgeTwozlvJhTBGEo8LXnj6KVucwiU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-onl6V3mkMzGlJYlRZVV_kQ-1; Mon,
 27 Oct 2025 06:16:26 -0400
X-MC-Unique: onl6V3mkMzGlJYlRZVV_kQ-1
X-Mimecast-MFC-AGG-ID: onl6V3mkMzGlJYlRZVV_kQ_1761560185
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AE241954225; Mon, 27 Oct 2025 10:16:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFFC93000223; Mon, 27 Oct 2025 10:16:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0953C21E6A27; Mon, 27 Oct 2025 11:16:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: peterx@redhat.com,  stefanb@linux.vnet.ibm.com,  farosas@suse.de,
 qemu-devel@nongnu.org,  berrange@redhat.com
Subject: Re: [PATCH v3 2/4] tmp_emulator: fix unset errp on error path
In-Reply-To: <20251025202649.1122420-3-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Sat, 25 Oct 2025 23:26:47 +0300")
References: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
 <20251025202649.1122420-3-vsementsov@yandex-team.ru>
Date: Mon, 27 Oct 2025 11:16:22 +0100
Message-ID: <87y0owodjd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Note, that called tpm_emulator_startup_tpm_resume() does error_report()
> failure paths, which could be turned into error_setg() to passthough an
> error. But, not on all error paths. Not saying about
> tpm_emulator_startup_tpm_resume() return -1 on failure and we mix it
> with -errno from tpm_emulator_set_state_blobs(). So, it all needs deeper
> refactoring, which is out of scope of this small fix.
>
> Fixes: 42e556fa3f7ac
>     "backends/tpm: Propagate vTPM error on migration failure"
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  backends/tpm/tpm_emulator.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index dacfca5ab7..aa69eb606f 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -961,6 +961,7 @@ static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
>      }
>  
>      if (tpm_emulator_startup_tpm_resume(tb, 0, true) < 0) {
> +        error_setg(errp, "Failed to resume tpm");
>          return -EIO;
>      }

Anti-pattern: we call error_report() (via
tpm_emulator_startup_tpm_resume(), tpm_emulator_set_buffer_size, ...)
from within an Error-setting function.  You need to convert the entire
nest of functions to Error.


