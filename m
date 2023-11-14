Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DA87EB5C4
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:46:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2xTC-0003jC-MD; Tue, 14 Nov 2023 12:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2xTA-0003iS-BV
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:45:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2xT8-0005Sd-Vu
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699983897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e60Sl91e4yGRqtQU/klL2SS4cWB1dXPNtVTCFQdbmVM=;
 b=iUg9UM1d1mUYCtWPX1gGdlnKXeLrVFlxEECRDLZjZh5iNLw8u3CAztHTvlRi/WXqv9JTxC
 uX63fgjoFR6U1nx57JCaeyRMS5gTLdcgOJDTjQ3Aokl/OfzF0xUpZMT8vMCefTqSENlxxy
 aTESrk1mBGsvehtZoNvzSBq+1uytafc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-jcRFuntaNvO3LB_cUqpb0Q-1; Tue, 14 Nov 2023 12:44:52 -0500
X-MC-Unique: jcRFuntaNvO3LB_cUqpb0Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E282185A78A;
 Tue, 14 Nov 2023 17:44:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5E8F492BFD;
 Tue, 14 Nov 2023 17:44:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D9B9421E6A1F; Tue, 14 Nov 2023 18:44:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Dinah B <dinahbaum123@gmail.com>
Cc: qemu-devel@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 3/3] cpu, softmmu/vl.c: Change parsing of -cpu
 argument to allow -cpu cpu,help to print options for the CPU type similar
 to how the '-device' option works.
References: <20230730064057.357598-1-dinahbaum123@gmail.com>
 <20230730064057.357598-4-dinahbaum123@gmail.com>
 <87tttix39v.fsf@pond.sub.org>
 <CAH50XRepiYcR9_e0AtuwTk1Nn34TXvZ87F5VVWg3aSx8BRJHPg@mail.gmail.com>
 <87edkmt397.fsf@pond.sub.org>
 <CAH50XRcOF2Sa0psZt_trCM-F68iR_pgyb8VsqJ_byFtPPgJRaw@mail.gmail.com>
Date: Tue, 14 Nov 2023 18:44:50 +0100
In-Reply-To: <CAH50XRcOF2Sa0psZt_trCM-F68iR_pgyb8VsqJ_byFtPPgJRaw@mail.gmail.com>
 (Dinah B.'s message of "Tue, 14 Nov 2023 11:22:23 -0500")
Message-ID: <87leb0w7ot.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

Dinah B <dinahbaum123@gmail.com> writes:

> Hi,
>
> Is there a way to distinguish between qemu-system-* vs qemu-* builds?
> At first I thought #CONFIG_LINUX_USER might be it but not all non-mmu
> builds set this.

What are you trying to accomplish?


