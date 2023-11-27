Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6815D7FA862
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:54:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7fnb-0001Qe-7J; Mon, 27 Nov 2023 12:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1r7fnX-0001QA-TH
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:53:31 -0500
Received: from aye.elm.relay.mailchannels.net ([23.83.212.6])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1r7fnW-0004l6-2Z
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:53:31 -0500
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 942536C2261;
 Mon, 27 Nov 2023 17:53:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a293.dreamhost.com (unknown [127.0.0.6])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 3CB6A6C3076;
 Mon, 27 Nov 2023 17:53:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1701107606; a=rsa-sha256;
 cv=none;
 b=dhd4CpoS5Yce8m6fNxOxqHPjvz2RgHEreDOLMZeRzOqudLlUfTUPEW/geIBy74a1wVBH5z
 1leRTXSIwcIR9rcyeCp4u89YWn/uTT1MvSt4w8GhAAxjusC78mjIcHIoW4Rbs7PGloXDza
 aU/0c91kZJIaaoBjSRhMVn2bn3/pVWj+CBfPc4DQU1qX7QstL59jytQ9oejk/ohxO2KRMB
 Ik4blamodD/4KPrNFFm/lDplPxJjiezQeQ6uQHFRD3wvf0T/G/UP7RTgJar6glh8Ib1Q5B
 Iy7DO3QuxdHnK77xBQeYEW0OSGs79ink/TSL1RDMQZDSeFaLifHjPCbCv3j5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1701107606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=l2Rddqf1SbcxobQdYgPmf5jp2coWaVPiQOtPhBImyTA=;
 b=K12+QbTMLgCHQbG42hSFQTaqO5RT8cU0B1Ia+5z1RsoiO8eQ8LZfC59LzdlfN221r6hO0j
 wZpSV6kx6+rr36I0f1JDEAJI9cQdqtxGblPaej9MrnW9G4NT6QNv4vcnte9qaUu8MUtBAM
 f3VWOO/pFumhWQuEi930p+PUQ2g9D2VXnpuCf7FFh/K0Go2yDNK8Xb0sK+8poYN/DpsWC+
 YWbLXbOXv3Hc/yzAkLQ3+NVRDvAMFKMRXN2jqSDf52BQi+GqjeFGNaTWH0UwxFKpNq9t0L
 j+vHfGtTQOr0mxOP+j5DW1E3n81Hp+h/H+5YWtcxeF/wxzamEELdmxqszmhzIA==
ARC-Authentication-Results: i=1; rspamd-696ff67dc8-kcr9t;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Ski-Gusty: 515996a668989749_1701107606407_477555257
X-MC-Loop-Signature: 1701107606407:1387709573
X-MC-Ingress-Time: 1701107606407
Received: from pdx1-sub0-mail-a293.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.104.134.238 (trex/6.9.2); Mon, 27 Nov 2023 17:53:26 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a293.dreamhost.com (Postfix) with ESMTPSA id 4SfCqn4yLwzDf; 
 Mon, 27 Nov 2023 09:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1701107606;
 bh=l2Rddqf1SbcxobQdYgPmf5jp2coWaVPiQOtPhBImyTA=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=fSQprkvNSLK+7zkfrfEHQVxlsHl3l6cmVFDkHEUPNNAIfWHW5JlLdLL5ueVZqgc0u
 4fuUqzpJWOaikZKdSn51Py7mJ540Emp+ekchVtjRvHw+f/xGkQkhTurjbPyI4Jh3wa
 rGsqOBaOz4yjT/oqjc8LEYm+YIobmsozy+gu3PGtFF9mYLrwOMzMtRlsgUgJeA3fJx
 UORzcESmeK2WHSuxqmANqAhj7XwL5nUeEeVGquHA2Q6Vv4nCqX2mVv8LJRYfRwpotM
 shLoZea23V2ZhYu17X0qRTgItONJpn5fF4/cSGC4bw5y/ptirSad4ru8hzwx5Zg+x3
 VLHyCrBhA0kxw==
Date: Mon, 27 Nov 2023 09:53:22 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 linux-cxl@lore.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 2/2] hw/mem/cxl_type3: allocate more vectors for MSI-X
Message-ID: <20231127175322.k3zt65vicd4o2ifv@offworld>
References: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
 <20231127105830.2104954-3-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231127105830.2104954-3-42.hyeyoo@gmail.com>
User-Agent: NeoMutt/20220429
Received-SPF: pass client-ip=23.83.212.6; envelope-from=dave@stgolabs.net;
 helo=aye.elm.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 27 Nov 2023, Hyeonggon Yoo wrote:

>commit 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background
>completion") enables notifying background command completion via MSI-X
>interrupt (vector number 9).
>
>However, the commit uses vector number 9 but the maximum number of
>entries is less thus resulting in error below. Fix it by passing
>nentries = 10 when calling msix_init_exclusive_bar().

Hmm yeah this was already set to 10 in Jonathan's tree, thanks for reporting.

