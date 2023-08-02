Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C500776CA8D
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 12:14:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR8qV-00026o-KO; Wed, 02 Aug 2023 06:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5716a841a=graf@amazon.de>)
 id 1qR8qR-00026d-T1
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 06:12:43 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5716a841a=graf@amazon.de>)
 id 1qR8qM-0008Jc-5l
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 06:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1690971158; x=1722507158;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=DxUGgJSgmjRQXQyo0AMq9yRzPrxaMyPZCrwUVjb3/o0=;
 b=r1ZnLju8rU/oqxcbnLWZ3a8QH9Ppro/BetFfGE99NjDU5OgqXb9gKlXG
 FwlE7xSKrS6P8ibSRF/rb/2tC/lEvwyNjIKq1la4DxDJLhwt0bg9cY+iq
 NiIRpvdsn8N8GeKzaKc+OyOrUMmZMLFsk+nFPrTPsT+j86NjosdPoRkfP w=;
X-IronPort-AV: E=Sophos;i="6.01,248,1684800000"; d="scan'208";a="298253568"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-33001.sea14.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 10:12:21 +0000
Received: from EX19MTAUWC002.ant.amazon.com
 (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
 by email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com (Postfix)
 with ESMTPS id 413D046D0B; Wed,  2 Aug 2023 10:12:18 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 10:12:17 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 10:12:16 +0000
Message-ID: <53228bc7-64e0-1120-494a-1926fb2d716a@amazon.com>
Date: Wed, 2 Aug 2023 12:12:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hvf: Invalid ISV on data abort
Content-Language: en-US
To: Antonio Caggiano <quic_acaggian@quicinc.com>, <qemu-devel@nongnu.org>
CC: Mark Burton <quic_mburton@quicinc.com>
References: <0c8d712b-a890-26fb-cdee-88e686243ae7@quicinc.com>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <0c8d712b-a890-26fb-cdee-88e686243ae7@quicinc.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Precedence: Bulk
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.171.190.10;
 envelope-from=prvs=5716a841a=graf@amazon.de; helo=smtp-fw-33001.amazon.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

SGkgQW50b25pbywKCk9uIDAyLjA4LjIzIDExOjQzLCBBbnRvbmlvIENhZ2dpYW5vIHdyb3RlOgo+
Cj4gSGkgdGhlcmUsCj4KPiBJIGFtIHRyeWluZyB0byBicmluZyB1cCBhIGd1ZXN0IG9uIEhWRiwg
d2hpY2ggYXQgYSBjZXJ0YWluIHBvaW50IGlzCj4gdHJ5aW5nIHRvIHdyaXRlIHRvIGFuIGFyZWEg
b2YgbW1pbyBzcGFjZSBhbmQgaXQgdHJpZ2dlcnMgYSBkYXRhIGFib3J0Cj4gd2hlcmUgSVNWPTAg
KHRyYW5zbGF0aW9uIGZhdWx0IGxldmVsIDIpLgo+Cj4gSSB3b25kZXIgd2hhdCBjb3VsZCBjYXVz
ZSBpdCBhbmQgaG93IHRvIHJlY292ZXIuCgoKUUVNVSdzIEhWRiBpbXBsZW1lbnRhdGlvbiAtIGxp
a2UgS1ZNIC0gb25seSBzdXBwb3J0cyBNTUlPIGFjY2Vzc2VzIGZyb20gCmhhcmR3YXJlIGRlY29k
ZWQsICJzaW1wbGUiIGxvYWQvc3RvcmUgaW5zdHJ1Y3Rpb25zLiBJdCB3aWxsIG9ubHkgZXhlY3V0
ZSAKZ3Vlc3QgT1NzIHRoYXQgYXJlIGF3YXJlIG9mIHRoYXQgbGltaXRhdGlvbiBhbmQgbGltaXQg
TU1JTyBhY2Nlc3NlcyB0byAKdGhhdCBzZXQgb2YgaW5zdHJ1Y3Rpb25zLCBzdWNoIGFzIExpbnV4
LgoKSWYgeW91IHNlZSB0aGlzIGVmZmVjdCB3aXRoIGFuIGVubGlnaHRlbmVkIE9TLCB5b3UgYXJl
IG1vc3QgbGlrZWx5IApleHBvc2luZyBtZW1vcnkgdGhhdCB0aGUgZ3Vlc3QgZXhwZWN0cyB0byBi
ZSByZXByZXNlbnRlZCBhcyBSQU0gYXMgTU1JTy4KCgpUaGFua3MsCgpBbGV4CgoKCgoKQW1hem9u
IERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVy
bGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vp
c3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0
OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK


