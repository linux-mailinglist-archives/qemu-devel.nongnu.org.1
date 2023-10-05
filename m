Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C54F7B9E3E
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 16:03:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoOrJ-00029E-SJ; Thu, 05 Oct 2023 09:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoOrH-0001zr-Ii
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoOrG-00029A-27
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696514260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+2trs+pn0FzpHh4ldTZyvhDpCwsferHAU6wyqY8t2GA=;
 b=JIgpptZlwW8r89fgXVEXjzXa+1btU9s5fSE78Jj1ofVqwkXtFWUP9XrpS9MeC1dNVoQ42J
 NgbVZUbpWBiM1GzCSF1+QdHsXzejne+i8PeMrDYaNAuWm2Hv29vUEsIPguXiP7Dw+6EapX
 do2QAreqyMq2yjR6Hy1wB5gOXSArkoM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-gwV2SMSVNkORLlANfl6Wjw-1; Thu, 05 Oct 2023 09:57:36 -0400
X-MC-Unique: gwV2SMSVNkORLlANfl6Wjw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF6CB2810D50;
 Thu,  5 Oct 2023 13:57:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6FDD493113;
 Thu,  5 Oct 2023 13:57:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF17A21E6904; Thu,  5 Oct 2023 15:57:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-trivial@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Leif Lindholm <quic_llindhol@quicinc.com>,
 qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: Add some unowned files to the SBSA-REF
 section
References: <20230929141918.397096-1-thuth@redhat.com>
Date: Thu, 05 Oct 2023 15:57:34 +0200
In-Reply-To: <20230929141918.397096-1-thuth@redhat.com> (Thomas Huth's message
 of "Fri, 29 Sep 2023 16:19:18 +0200")
Message-ID: <87r0m9xjch.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

Nominating for qemu-trivial.

Thomas Huth <thuth@redhat.com> writes:

> These files belong to the sbsa-ref machine and thus should
> be listed here.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 874234cb7b..fc415d3cea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -954,6 +954,9 @@ R: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/sbsa-ref.c
> +F: hw/misc/sbsa_ec.c
> +F: hw/watchdog/sbsa_gwdt.c
> +F: include/hw/watchdog/sbsa_gwdt.h
>  F: docs/system/arm/sbsa.rst
>  F: tests/avocado/machine_aarch64_sbsaref.py


