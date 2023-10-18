Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D97CD9F6
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 13:01:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt4Hf-0003o4-M8; Wed, 18 Oct 2023 07:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt4Hd-0003nM-FM
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt4Hb-0000DG-G1
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697626810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OD0SsVLHgIwSnBryw35mX8ohwPTcU5lSxzdTSPKBa9w=;
 b=LQr00itDm+bWcqEQ0Wvk5JKS6AcOTuboFlQTzMhsaoZr094t+so2w3NDzgKDWjfs3TWxWB
 1NMPmQ8YAjtUOKYd8NhPoZVxLkIFV5r9bEY605PPrAx5G6X43EdsymIXhMLO1gWAgLqVjQ
 sAUMkZU9npZvPe1y6SfvsziM79Ho5Qk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-CT5MZHmlNaanMn77AVZf6A-1; Wed, 18 Oct 2023 07:00:08 -0400
X-MC-Unique: CT5MZHmlNaanMn77AVZf6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80A4F88B76E
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 11:00:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6016F2026D4C
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 11:00:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6B68621E6A1F; Wed, 18 Oct 2023 13:00:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Andrea Bolognani
 <abologna@redhat.com>
Subject: Re: [PATCH v2 02/11] scripts: qapi: black format main.py
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-3-victortoso@redhat.com>
Date: Wed, 18 Oct 2023 13:00:07 +0200
In-Reply-To: <20231016152704.221611-3-victortoso@redhat.com> (Victor Toso's
 message of "Mon, 16 Oct 2023 17:26:55 +0200")
Message-ID: <87pm1crya0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

Victor Toso <victortoso@redhat.com> writes:

> flake8 complained:
>     ./main.py:60:1: E302 expected 2 blank lines, found 1
>
> Which is simple enough. My vim has black [0] enabled by default, so it
> did some extra formatting. I'm proposing to follow it.
>
> [0] https://black.readthedocs.io/en/stable/
>
> Signed-off-by: Victor Toso <victortoso@redhat.com>
> ---
>  scripts/qapi/main.py | 76 ++++++++++++++++++++++++++++----------------
>  1 file changed, 48 insertions(+), 28 deletions(-)

Is this all black hates about scripts/qapi/?

Did you configure it in any way, and if yes, how?

[...]


