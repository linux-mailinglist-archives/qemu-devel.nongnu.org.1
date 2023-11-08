Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C13947E52F1
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 10:58:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fJe-0005SR-3g; Wed, 08 Nov 2023 04:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1r0fJb-0005OI-QA
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:57:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1r0fJZ-0002eK-38
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699437454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=spmQ47R8WQn8L1I5jybhLMjRjwNF1aBNAcIkSfDx7b0=;
 b=D4SPKLZirrUKwcEowtefaLsElTnVnykG/d6ArB0Oj+JBaRfQGqyJNKOcWJibzvXK339Vu4
 dddhWhPt24HA9lVNhaHxDO7DMhnjiTZ0jEfkIHqoZfEluh5nQMCXm6vc5VvNXw13mnyRy5
 DoPfy8n8vFn2OyXfLCxYyVs69A15ZgY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-NED14HMWMF-AUjc8T0zGUg-1; Wed, 08 Nov 2023 04:57:32 -0500
X-MC-Unique: NED14HMWMF-AUjc8T0zGUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17CC585D521;
 Wed,  8 Nov 2023 09:57:32 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3CDF2026D68;
 Wed,  8 Nov 2023 09:57:31 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: xianglai li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, maobibo@loongson.cn, zhaotianrui@loongson.cn,
 mst@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org,
 richard.henderson@linaro.org, peter.maydell@linaro.org,
 yangxiaojuan@loongson.cn
Subject: Re: [PATCH v1 1/9] linux-headers: Add KVM headers for loongarch
In-Reply-To: <20231108014141.2590657-2-lixianglai@loongson.cn>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20231108014141.2590657-1-lixianglai@loongson.cn>
 <20231108014141.2590657-2-lixianglai@loongson.cn>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 08 Nov 2023 10:57:30 +0100
Message-ID: <874jhwr2id.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Nov 08 2023, xianglai li <lixianglai@loongson.cn> wrote:

> From: zhaotianrui <zhaotianrui@loongson.cn>
>
> Update linux KVM headers about LoongArch KVM form linux
> kernel. Mainly contains some KVM structures and macro
> defines such as LoongArch KVM registers number, LoongArch
> fpu structure, exit reason of LoongArch IOCSR, etc.
>
> Signed-off-by: zhaotianrui <zhaotianrui@loongson.cn>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> ---
>  linux-headers/asm-loongarch/kvm.h | 108 ++++++++++++++++++++++++++++++
>  linux-headers/linux/kvm.h         |   9 +++
>  2 files changed, 117 insertions(+)
>  create mode 100644 linux-headers/asm-loongarch/kvm.h

This needs to be a full headers sync with a defined Linux kernel version
(e.g. with -rc1), not just the LoongArch parts.


