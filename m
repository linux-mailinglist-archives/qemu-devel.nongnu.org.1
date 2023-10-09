Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC73A7BD33B
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:19:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpjbR-0001V1-NI; Mon, 09 Oct 2023 02:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qpjbM-0001U0-OJ
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:18:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qpjbH-0001YP-QX
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696832322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sk/PRbtp3k8OqUZHoG3z6ttA8thrJjC//Seqa2h990Y=;
 b=Mlqvgf85XEY92pGxNgak1K0Bq5UD5AhU37DNwCSJQ9dzbILUbDqXHvBPZTivlSbFuFf4iQ
 7DAjk2MSOF5Czpr+/am4Q2Z/2CCIdlapLZ7Lhtd3oJIIWMdbMkDuFEk2E3xh33BYsx3U3W
 f8n4kOg9LPdKXyCaVR7o9CvRBYDE2GI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-iYiXHqBuMEqdXIIwXpHyTQ-1; Mon, 09 Oct 2023 02:18:36 -0400
X-MC-Unique: iYiXHqBuMEqdXIIwXpHyTQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8FBE805BAC;
 Mon,  9 Oct 2023 06:18:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D1BA47AD4A;
 Mon,  9 Oct 2023 06:18:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5009C21E6904; Mon,  9 Oct 2023 08:18:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Brian Cain <bcain@quicinc.com>
Cc: <qemu-devel@nongnu.org>,  <armbru@redhat.com>,
 <richard.henderson@linaro.org>,  <philmd@linaro.org>,
 <peter.maydell@linaro.org>,  <quic_mathbern@quicinc.com>,
 <stefanha@redhat.com>,  <ale@rev.ng>,  <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>,  <ltaylorsimpson@gmail.com>
Subject: Re: [PATCH v3 0/3] hexagon: GETPC() fixes, shadowing fixes
References: <20231008220945.983643-1-bcain@quicinc.com>
Date: Mon, 09 Oct 2023 08:18:34 +0200
In-Reply-To: <20231008220945.983643-1-bcain@quicinc.com> (Brian Cain's message
 of "Sun, 8 Oct 2023 15:09:42 -0700")
Message-ID: <87bkd871z9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

I applied this series to my shadow-next in my public Git repository at
https://repo.or.cz/qemu/armbru.git.  I don't intend to include it in
pull requests, because it does more than just fix -Wshadow issues.
Don't think that'll be a problem.

Thanks!


