Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F607BB3B4
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:01:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoghV-0003Uk-0W; Fri, 06 Oct 2023 05:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoghT-0003U8-MM
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoghR-0007Yt-HK
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696582843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wj8NMiErYzjtFLc1PkDwhRi8LfXx6c+ndO/ICSM33mU=;
 b=fRxzV297FKz+P/Xnxv209w3pumyGe6Hg0ckFBwGGrJ8KQthzNC0wfzsS/U3MkfW5rOLfFL
 DZCL1/qq0aMwBLf9I1lYaUNBkqU/YfqgFipqufwklv+o3L9RgCCfZbO9qJTZwULXGwfF0b
 YbNj7BLrzK6ro6zHZWl8/OVvyNHTYLU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-zNcErlNFPWmomehgYFynlA-1; Fri, 06 Oct 2023 05:00:38 -0400
X-MC-Unique: zNcErlNFPWmomehgYFynlA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 779B185A5BF;
 Fri,  6 Oct 2023 09:00:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 094EC215670B;
 Fri,  6 Oct 2023 09:00:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F3E3721E6904; Fri,  6 Oct 2023 11:00:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Brian Cain <bcain@quicinc.com>
Cc: <qemu-devel@nongnu.org>,  <richard.henderson@linaro.org>,
 <philmd@linaro.org>,  <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>,  <stefanha@redhat.com>,  <ale@rev.ng>,
 <anjo@rev.ng>,  <quic_mliebel@quicinc.com>,  <ltaylorsimpson@gmail.com>
Subject: Re: [PATCH v2 0/3] hexagon: GETPC() and shadowing fixes
References: <20231005222206.2784853-1-bcain@quicinc.com>
Date: Fri, 06 Oct 2023 11:00:34 +0200
In-Reply-To: <20231005222206.2784853-1-bcain@quicinc.com> (Brian Cain's
 message of "Thu, 5 Oct 2023 15:22:03 -0700")
Message-ID: <87cyxsp1l9.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Conflicts with recent commit ad75a51e84a (tcg: Rename cpu_env to
tcg_env).  Please rebase.


