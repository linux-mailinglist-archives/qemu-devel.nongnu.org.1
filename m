Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5EC7B78D9
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 09:38:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwSf-0001g1-Cx; Wed, 04 Oct 2023 03:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qnwSb-0001fe-Vt
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qnwSa-00053W-0M
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696405098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=20sB/DvL5Cxh8kBEhbDy7LFJgEmJc+drXR/RtHGjN1g=;
 b=Fe3bSLCfUroU1oHpnUkRJAk/bjZI09juVXjdEbDNeuhj0SySSNCcgJPgdd+BNTgYeMZ308
 T4JfmS0ntFsArweoPuW2G8FJgCHSf1d+ZUQQS4xFoWF1uQb192z7v65ochoIhXGeyk8oLG
 35CoWHUfhPef+/i2ah9VQBTEN17LAaU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416--zwwYrRpO4KHtKeQ5uftRw-1; Wed, 04 Oct 2023 03:38:05 -0400
X-MC-Unique: -zwwYrRpO4KHtKeQ5uftRw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9379E802D35;
 Wed,  4 Oct 2023 07:38:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C703400F0F;
 Wed,  4 Oct 2023 07:38:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 970B421E6904; Wed,  4 Oct 2023 09:38:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Brian Cain <bcain@quicinc.com>
Cc: <qemu-devel@nongnu.org>,  <richard.henderson@linaro.org>,
 <philmd@linaro.org>,  <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>,  <stefanha@redhat.com>,  <ale@rev.ng>,
 <anjo@rev.ng>,  <quic_mliebel@quicinc.com>,  <ltaylorsimpson@gmail.com>
Subject: Re: [PULL 0/2] hex queue
References: <20231004004806.1461248-1-bcain@quicinc.com>
Date: Wed, 04 Oct 2023 09:38:02 +0200
In-Reply-To: <20231004004806.1461248-1-bcain@quicinc.com> (Brian Cain's
 message of "Tue, 3 Oct 2023 17:48:04 -0700")
Message-ID: <87mswyltwl.fsf@pond.sub.org>
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

Looks like these patches haven't been posted to the list for (public)
review.  Needs to happen before a pull request.

Brian Cain <bcain@quicinc.com> writes:

> The following changes since commit 36e9aab3c569d4c9ad780473596e18479838d1aa:
>
>   migration: Move return path cleanup to main migration thread (2023-09-27 13:58:02 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/quic/qemu tags/pull-hex-20231003
>
> for you to fetch changes up to 53cdd26f1909fc45ad50a5eaa95dcfff06130e5f:
>
>   target/hexagon: fix some occurrences of -Wshadow=local (2023-10-03 17:02:29 -0700)
>
> ----------------------------------------------------------------
> Hexagon GETPC() and -Wshadow fixes
>
> ----------------------------------------------------------------
> Brian Cain (1):
>       target/hexagon: fix some occurrences of -Wshadow=local
>
> Matheus Tavares Bernardino (1):
>       target/hexagon: move GETPC() calls to top level helpers
>
>  target/hexagon/imported/alu.idef |  6 +--
>  target/hexagon/macros.h          | 19 +++++----
>  target/hexagon/mmvec/macros.h    |  2 +-
>  target/hexagon/op_helper.c       | 84 +++++++++++++++-------------------------
>  target/hexagon/op_helper.h       |  9 -----
>  target/hexagon/translate.c       | 10 ++---
>  6 files changed, 50 insertions(+), 80 deletions(-)


