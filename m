Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC547F75E3
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 15:03:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Wlc-0007Xq-K6; Fri, 24 Nov 2023 09:02:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r6Wla-0007XS-0B
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 09:02:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r6WlY-00051Z-Fa
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 09:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700834562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pJHsJefe7UpU7FYOFmc88yFSMkblI0T4hCDsW39+JXU=;
 b=hpsQfe2FIanVVQ5ul1bSO0j4p9vxFBuWymHFScSz6fo9BenW7wli9XYvWkKjRpycroAj3y
 v6hY7d3Qeo52uWPWun51narRo1q81zmmAz6/TkfkgW6MOisx4QENcb9hFUErMMIR8P4gep
 QDp3fQIoByA76hdpbs2CGlAtJCQz4qc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-p3bY8lyOMmydBp2rkDPc9w-1; Fri,
 24 Nov 2023 09:02:41 -0500
X-MC-Unique: p3bY8lyOMmydBp2rkDPc9w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B53133810B2A;
 Fri, 24 Nov 2023 14:02:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7958D492BE7;
 Fri, 24 Nov 2023 14:02:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 73C4B21E6A1F; Fri, 24 Nov 2023 15:02:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel Hoffman <dhoff749@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] hw/core: define stack variable to NULL to fix qtest
 with sanitizers
References: <20231124015312.544422-1-dhoff749@gmail.com>
 <93f7ee3e-a92f-4b18-bf16-2169c8b2791d@linaro.org>
 <87sf4vgtir.fsf@pond.sub.org>
Date: Fri, 24 Nov 2023 15:02:39 +0100
In-Reply-To: <87sf4vgtir.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 24 Nov 2023 14:39:24 +0100")
Message-ID: <87edgfgsg0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Daniel, please have a look at Kevin's patch:

    Subject: [PATCH for-8.2 1/2] qdev: Fix crash in array property getter
    Date: Tue, 21 Nov 2023 18:34:15 +0100 (2 days, 20 hours, 26 minutes ago)
    Message-ID: <20231121173416.346610-2-kwolf@redhat.com>
    https://lore.kernel.org/qemu-devel/20231121173416.346610-2-kwolf@redhat.com/

Does it fix your sanitizer run?


