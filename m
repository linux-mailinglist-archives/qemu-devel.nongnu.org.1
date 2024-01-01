Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ECE821573
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Jan 2024 22:40:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKPzd-00052W-6N; Mon, 01 Jan 2024 16:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1rKPza-00052E-5l
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 16:38:38 -0500
Received: from bumble.birch.relay.mailchannels.net ([23.83.209.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1rKPzY-0004UO-AD
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 16:38:37 -0500
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id B7A202C23B0;
 Mon,  1 Jan 2024 21:38:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (unknown [127.0.0.6])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 4D3142C23A2;
 Mon,  1 Jan 2024 21:38:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1704145112; a=rsa-sha256;
 cv=none;
 b=MJpEnGmB1A5UAyl1LovopJ/bOSCIrOL6CC5uiX/etqk+qySNsFkevH2OGhoqiz0iCB8AsP
 +I2CO0ZOoWHQRnet15NvYJHckDMhoIpaX1TF9mwYyZlyTN2WmwZqvea3M2ilNTyf6RK7Gb
 qXUw6qptPV5BFqcCCR34O7fWmKUynSgy0VAg7pTDw5daA9+qMRL2pKsAy3/++YZS6GJ5Rl
 ynu19DNohXnEAh6mEodjQ5A4LJmO9hmomBpOEh/k5ZnkNN1/JqD/DumNoBQscvL6G5rHV4
 ssZtVrGrbzfrI+pRWxxl0IH1G4krTl0OOysoPpYq55TmuqRwwwDxXzgnfayPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1704145112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=O0Vl21gdkyhagidw/M2dwHYt+Cr9WGQFM2ryl4rjPyI=;
 b=CdFGMHEH24zr5oK45Kd3s2WP1C6g9Ni4htHiOR85UzI318Vusheow1JKKKHypLp9u+Kh0H
 Ppi7MuWt67IW0Ch8PxOkNF1rQlaVV/Rm6FDw1oTIN5l920BxXLMxSjaiaXMdbDNa8WmQpp
 tgXf1eLgs5RwvhW457RXXExDcW3GgUj6PN3vLV00am1yM9MuA7geRmix/+bAHkC8Ga/hrk
 26lXEPSYuKF0duPRNmsy3azG+MAGo5xiT9wN3CUyZGKSKS2nTRJCUA9rDzLeE/3ystPfFg
 ws4cc5sDPscExX4qtbxzj4q3uttU7m9LhuAUBKXkTDgYsI4Tel3JhWOQ4KFCxg==
ARC-Authentication-Results: i=1; rspamd-856c7f878f-c7md2;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Absorbed-Little: 255de27f6b2c3616_1704145112578_3752715891
X-MC-Loop-Signature: 1704145112578:4118686458
X-MC-Ingress-Time: 1704145112578
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.112.49.9 (trex/6.9.2); Mon, 01 Jan 2024 21:38:32 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4T3q9M5LQkz7v; 
 Mon,  1 Jan 2024 13:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1704145112;
 bh=O0Vl21gdkyhagidw/M2dwHYt+Cr9WGQFM2ryl4rjPyI=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=FsRknOZYYMye8JB9YiWefxLFqRqzGEg8hRUpqal1pZMKePAMHNSJ5PV8UW80iqQgN
 lHhOOGVMEMJnSzE8sz12n2+HwD9SxSup5nIwLnceE4ufmSeOXM8NbX3rmWEaQWPfjQ
 2LNaY1Lv1qdVWjeqh6apEhP93bqqHQzU4LdMuaT2K7/Vo62/9YsYcQvq8ikekq1vvk
 kUAJBl1v3N7xe8qJZwfJuFp7qrhR81jkU5w0tN+vG8JqOpSC7IncSFw2+sfxZ6bp3S
 HrgUqjf2hCTtC17wP1voCR19ABufyYub3Btb3q3dNLKD+930eBfq5buYiXls22y31y
 NzufqDtwc9AZw==
Date: Mon, 1 Jan 2024 13:38:28 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 4/4] hw/cxl/events: discard all event records during
 sanitation
Message-ID: <20240101213828.nxayq6ps3azk2eic@offworld>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
 <20231222090051.3265307-5-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231222090051.3265307-5-42.hyeyoo@gmail.com>
User-Agent: NeoMutt/20220429
Received-SPF: pass client-ip=23.83.209.25; envelope-from=dave@stgolabs.net;
 helo=bumble.birch.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 22 Dec 2023, Hyeonggon Yoo wrote:

>Per spec 8.2.9.9.5.1 Sanitize (Opcode 4400h), sanitize command should
>delete all event logs. Introduce cxl_discard_all_event_logs() and call
>this in __do_sanitization().

lgtm

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>---
> hw/cxl/cxl-events.c         | 13 +++++++++++++
> hw/cxl/cxl-mailbox-utils.c  |  1 +
> include/hw/cxl/cxl_device.h |  1 +
> 3 files changed, 15 insertions(+)
>
>diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
>index bee6dfaf14..837b18ab47 100644
>--- a/hw/cxl/cxl-events.c
>+++ b/hw/cxl/cxl-events.c
>@@ -141,6 +141,19 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
>     return cxl_event_count(log) == 1;
> }
>
>+void cxl_discard_all_event_records(CXLDeviceState *cxlds)
>+{
>+    CXLEventLogType log_type;
>+    CXLEventLog *log;
>+
>+    for (log_type = 0; log_type < CXL_EVENT_TYPE_MAX; log_type++) {
>+        log = &cxlds->event_logs[log_type];
>+        while (!cxl_event_empty(log)) {
>+            cxl_event_delete_head(cxlds, log_type, log);
>+        }
>+    }
>+}
>+
> CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
>                                  uint8_t log_type, int max_recs,
>                                  size_t *len)
>diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>index efeb5f8174..2ade351d82 100644
>--- a/hw/cxl/cxl-mailbox-utils.c
>+++ b/hw/cxl/cxl-mailbox-utils.c
>@@ -1150,6 +1150,7 @@ static void __do_sanitization(CXLType3Dev *ct3d)
>             memset(lsa, 0, memory_region_size(mr));
>         }
>     }
>+    cxl_discard_all_event_records(&ct3d->cxl_dstate);
> }
>
> /*
>diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>index 5618061ebe..8f05dd9beb 100644
>--- a/include/hw/cxl/cxl_device.h
>+++ b/include/hw/cxl/cxl_device.h
>@@ -604,6 +604,7 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
>                                  size_t *len);
> CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
>                                    CXLClearEventPayload *pl);
>+void cxl_discard_all_event_records(CXLDeviceState *cxlds);
>
> void cxl_event_irq_assert(CXLType3Dev *ct3d);
>
>-- 
>2.39.3
>

