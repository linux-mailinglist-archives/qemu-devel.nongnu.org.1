Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D77047D99E7
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 15:34:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwMxT-00010u-D4; Fri, 27 Oct 2023 09:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qwMxQ-0000yR-CZ
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qwMxO-0005pN-Qc
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698413575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=450b3mr6yOYDLMxgbf0t6LptV89FMDyj6ALWop66s74=;
 b=f2g/wZvOx1uYiLygF4B25i4E+zIQkdh7dvmrnr8SPAMI2JSh6jgrc3Y23k8GG4Yy4hvz+Q
 X6ISxJV/gTR9qR9I97RveGjo++I6lx6qvhoIOlMBYiKPkW+q8WK3x9IIH4/v0sllm9L0oG
 j4j5Y+l/61xR8SWGkpb66tC88lDwPIc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-XNWwzqJnPs61kAncDvHCGQ-1; Fri,
 27 Oct 2023 09:32:54 -0400
X-MC-Unique: XNWwzqJnPs61kAncDvHCGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 184DD28237E0;
 Fri, 27 Oct 2023 13:32:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBCBBC1596D;
 Fri, 27 Oct 2023 13:32:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DFB5B21E6A1F; Fri, 27 Oct 2023 15:32:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: zhujun2 <zhujun2@cmss.chinamobile.com>
Cc: qemu-devel@nongnu.org,  mst@redhat.com,  imammedo@redhat.com,
 anisinha@redhat.com,  thuth@redhat.com,  lvivier@redhat.com
Subject: Re: [PATCH] tests: Fix printf format string in acpi-utils.c
References: <20231027030930.7739-1-zhujun2@cmss.chinamobile.com>
Date: Fri, 27 Oct 2023 15:32:50 +0200
In-Reply-To: <20231027030930.7739-1-zhujun2@cmss.chinamobile.com>
 (zhujun2@cmss.chinamobile.com's message of "Thu, 26 Oct 2023 20:09:30
 -0700")
Message-ID: <87sf5w198d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

zhujun2 <zhujun2@cmss.chinamobile.com> writes:

> Inside of acpi_fetch_table() arguments are
> printed via fprintf but '%d' is used to print @flags (of type
> uint). Use '%u' instead.
>
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>

Please sign off with your real name.

You should be able to automate this by putting

    [user]
            email = armbru@redhat.com
            name = Markus Armbruster

into ~/.gitconfig or git/config.


