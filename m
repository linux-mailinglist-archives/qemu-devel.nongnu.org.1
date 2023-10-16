Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A597CA740
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 13:57:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsMD8-0004Sw-9v; Mon, 16 Oct 2023 07:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qsMD5-0004PY-Jq
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:56:35 -0400
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qsMD3-0005Ze-Ek
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:56:35 -0400
Received: from blackfin.pond.sub.org
 (p200300d36f42770072c066a7e7963076.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f42:7700:72c0:66a7:e796:3076])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 6554C26A42
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 14:15:00 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E02721E6A26; Mon, 16 Oct 2023 13:56:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com
Subject: Re: [PATCH] qapi: Belatedly update CompatPolicy documentation for
 unstable
In-Reply-To: <20231009110449.4015601-1-armbru@redhat.com> (Markus Armbruster's
 message of "Mon, 9 Oct 2023 13:04:49 +0200")
Date: Mon, 16 Oct 2023 12:52:29 +0200
Lines: 9
References: <20231009110449.4015601-1-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Message-ID: <875y36ixw0.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Commit 57df0dff1a1 (qapi: Extend -compat to set policy for unstable
> interfaces) neglected to update the "Limitation" paragraph to mention
> feature 'unstable' in addition to feature 'deprecated'.  Do that now.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Queued.

