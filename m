Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8B2A28A5A
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Feb 2025 13:33:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfeaK-0004TB-AR; Wed, 05 Feb 2025 07:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfea1-0004Ro-L7
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:32:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfeZy-0001GW-Hp
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738758749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ehjN23UhFLOEmMg/5tKtfppC4JFaMbK0Ow+1rDoliVo=;
 b=ZgpRBHUDMEgyBShLcNKyNW84Xlb0Y9S2eUPTBWPxZV6jY5SN1DXFljZpV2FLy/O1AamsUs
 U63EQtFPdN+oiiF2rEmMtVy1VGMdR5D4ce1yQL70XXqTpavWKBn3LIzsRAN898dLoack5F
 SZdDVXeAI8JE53axg7MFPlCIY/hsaqA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-U5A50OZTPn2gbVlkgZ3HUQ-1; Wed,
 05 Feb 2025 07:32:25 -0500
X-MC-Unique: U5A50OZTPn2gbVlkgZ3HUQ-1
X-Mimecast-MFC-AGG-ID: U5A50OZTPn2gbVlkgZ3HUQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F047B195608E; Wed,  5 Feb 2025 12:32:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.40])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E11E01800872; Wed,  5 Feb 2025 12:32:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 88EE621E6A28; Wed, 05 Feb 2025 13:32:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Alireza Sanaee
 <alireza.sanaee@huawei.com>,  Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 qemu-devel@nongnu.org,  kvm@vger.kernel.org
Subject: Re: [PATCH v7 RESEND 0/5] i386: Support SMP Cache Topology
In-Reply-To: <20250110145115.1574345-1-zhao1.liu@intel.com> (Zhao Liu's
 message of "Fri, 10 Jan 2025 22:51:10 +0800")
References: <20250110145115.1574345-1-zhao1.liu@intel.com>
Date: Wed, 05 Feb 2025 13:32:19 +0100
Message-ID: <87jza4zi5o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Zhao Liu <zhao1.liu@intel.com> writes:

> Hi folks,
>
> This is my v7 resend version (updated the commit message of origin
> v7's Patch 1).

If anything changed, even if it's just a commit message, make it a new
version, not a resend, to avoid confusion.  Next time :)

[...]


