Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B83B170458D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 08:51:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyoVQ-0002rR-LM; Tue, 16 May 2023 02:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pyoVI-0002rJ-J6
 for qemu-devel@nongnu.org; Tue, 16 May 2023 02:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pyoVG-0007mR-MB
 for qemu-devel@nongnu.org; Tue, 16 May 2023 02:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684219785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G9hgqXLPefDQsHFHvaAXudBpXCInib/5Y/ky/CRoxuI=;
 b=FLaifYGDsH15ZES8AA7F9BiobWWV5/LkHs3JErJP7t/KRWU/tJuwPfzXzH0uKBmOiImV7O
 JqNINnsCeb9Absvq5cee6hAzWItOhuM571+2ggTC3Mca7XPTw1sMo8bmqTxs7f/Qfk+CiG
 5FAEh1kFWAB7+h2p/KFhR3cYWs3hnkg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-cPJad1SjN3KmXkiT_Yc-JA-1; Tue, 16 May 2023 02:49:41 -0400
X-MC-Unique: cPJad1SjN3KmXkiT_Yc-JA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 408983C0ED47;
 Tue, 16 May 2023 06:49:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 176842166B31;
 Tue, 16 May 2023 06:49:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 06BAD21E6806; Tue, 16 May 2023 08:49:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 0/3] docs/interop: Convert QMP related txt docs to rst
References: <20230515162245.3964307-1-peter.maydell@linaro.org>
Date: Tue, 16 May 2023 08:49:40 +0200
In-Reply-To: <20230515162245.3964307-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 15 May 2023 17:22:42 +0100")
Message-ID: <87v8gsvkhn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> This patchset deals with a couple of the old .txt files
> that are still hanging around in docs/interop: qmp-spec.txt
> and qmp-intro.txt. Patch 1 converts qmp-spec to rST and
> integrates it into the manual. Patch 2 takes the only
> interesting parts of qmp-intro.txt (the example command
> lines) and puts those into qemu-options.hx so we can
> delete the old .txt file.

Queued.  Thanks!


