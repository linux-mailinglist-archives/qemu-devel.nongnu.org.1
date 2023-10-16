Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEB97CA6B4
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 13:27:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsLjj-0002ue-NQ; Mon, 16 Oct 2023 07:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qsLjh-0002tz-U1; Mon, 16 Oct 2023 07:26:13 -0400
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qsLjg-0007cD-4Q; Mon, 16 Oct 2023 07:26:13 -0400
Received: from blackfin.pond.sub.org (p4fd04c8c.dip0.t-ipconnect.de
 [79.208.76.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 9AB9526A12;
 Mon, 16 Oct 2023 13:44:32 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ECEAE21E6A1F; Mon, 16 Oct 2023 13:26:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,  qemu-stable@nongnu.org
Subject: Re: [PATCH v3 1/4] migration/qmp: Fix crash on setting tls-authz
 with null
In-Reply-To: <20230905162335.235619-2-peterx@redhat.com> (Peter Xu's message
 of "Tue, 5 Sep 2023 12:23:32 -0400")
Date: Mon, 16 Oct 2023 08:05:05 +0200
Lines: 20
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-2-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Message-ID: <874jiqkdvb.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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

Advice for next time...

Peter Xu <peterx@redhat.com> writes:

> QEMU will crash if anyone tries to set tls-authz (which is a type
> StrOrNull) with 'null' value.  Fix it in the easy way by converting it to
> qstring just like the other two tls parameters.

Include a reproducer whenever practical.  Helps backporters.  It would
have been practical here:

  QEMU will crash if anyone tries to set tls-authz (which is a type
  StrOrNull) with 'null' value.  Reproducer:

      {"execute": "migrate-set-parameters", "arguments": {"tls-authz": null}}

  Fix it in the easy way by converting it to qstring just like the other
  two tls parameters.

[...]

