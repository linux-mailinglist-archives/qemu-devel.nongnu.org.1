Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE693ACDFBE
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Jun 2025 16:00:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uModR-00009M-5o; Wed, 04 Jun 2025 09:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uModO-000091-Du
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uModN-0000uP-2R
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749045502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uen7lMaxnDgFWaglw6t9rnRNCNirUKu3wWyV9TMwV0s=;
 b=XEcDk60jJOcKR5NLDhJCCepz/fFJ/UshA2owoorIDzpvZy+MCCHHtxxnNaxH2nE1bw1NxY
 YylKm1jEOb7SHDDIK230uHYrHa8PcSxCbIYdnNySuSEKDtwU1Npu9RfSpUo3T0PU/tvk4g
 gAOQsEiCL0Z6zN4gHnorst8G9dlNsFA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-ZTkhFg2NPyO1poAEvjjwEA-1; Wed,
 04 Jun 2025 09:58:20 -0400
X-MC-Unique: ZTkhFg2NPyO1poAEvjjwEA-1
X-Mimecast-MFC-AGG-ID: ZTkhFg2NPyO1poAEvjjwEA_1749045499
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2613A1955DB8; Wed,  4 Jun 2025 13:58:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B69618003FD; Wed,  4 Jun 2025 13:58:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0DFAC21E6757; Wed, 04 Jun 2025 15:58:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Brian Song
 <hibriansong@gmail.com>
Subject: Re: [PATCH v2 16/21] block/export: Add multi-threading interface
In-Reply-To: <20250604132813.359438-17-hreitz@redhat.com> (Hanna Czenczek's
 message of "Wed, 4 Jun 2025 15:28:08 +0200")
References: <20250604132813.359438-1-hreitz@redhat.com>
 <20250604132813.359438-17-hreitz@redhat.com>
Date: Wed, 04 Jun 2025 15:58:16 +0200
Message-ID: <87bjr3sj5z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

Hanna Czenczek <hreitz@redhat.com> writes:

> Make BlockExportType.iothread an alternate between a single-thread
> variant 'str' and a multi-threading variant '[str]'.
>
> In contrast to the single-thread setting, the multi-threading setting
> will not change the BDS's context (and so is incompatible with the
> fixed-iothread setting), but instead just pass a list to the export
> driver, with which it can do whatever it wants.
>
> Currently no export driver supports multi-threading, so they all return
> an error when receiving such a list.
>
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

Acked-by: Markus Armbruster <armbru@redhat.com>


