Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E357132E0
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 09:07:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2nzw-0004yt-FN; Sat, 27 May 2023 03:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2nzZ-0004yA-A6
 for qemu-devel@nongnu.org; Sat, 27 May 2023 03:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2nzW-0006aX-UG
 for qemu-devel@nongnu.org; Sat, 27 May 2023 03:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685171129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZsSaGIZLvCdOpmxVUUi3JSfYTLoxMAqjgExk2RD+pd0=;
 b=AJqYLpII1tdVL+BdoR/Qma5WWxTbx23HFCt3dk6oto5sxZpf4z4hIa/Hv0FcG6+QF3hiYR
 W0bOGAryoa7ey4PIYEpxstXaH91HoMB/vzOQmv4M3U+uhT+bwU9rO9SpXOFFJM2nEW2e++
 W5v9arVXZxhBfIveei8ZTcEg50rHYfQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-AwjCJUEvP2GFkklCIITl5Q-1; Sat, 27 May 2023 03:05:25 -0400
X-MC-Unique: AwjCJUEvP2GFkklCIITl5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE929185A78B;
 Sat, 27 May 2023 07:05:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91B1920296C6;
 Sat, 27 May 2023 07:05:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8820421E692E; Sat, 27 May 2023 09:05:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrei Gudkov <gudkov.andrei@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>,  <philmd@linaro.org>,
 <wangyanan55@huawei.com>,  <eblake@redhat.com>
Subject: Re: [PATCH] [query-memory-size-summary] Report page size
References: <3200757e8218f65f873e79ab84a4b8382fbfa099.1684483058.git.gudkov.andrei@huawei.com>
 <87jzwwo3yj.fsf@pond.sub.org>
Date: Sat, 27 May 2023 09:05:23 +0200
In-Reply-To: <87jzwwo3yj.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 25 May 2023 16:55:48 +0200")
Message-ID: <87leha1cgc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

One more thing: the convention for patch subjects is

    subsystem: purpose

Suggest

    qmp: Report page size in query-memory-size-summary


