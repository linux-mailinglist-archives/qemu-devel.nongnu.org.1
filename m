Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBC2802A8D
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 04:39:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9zml-00033D-Jg; Sun, 03 Dec 2023 22:38:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1r9zmj-00032x-DR
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 22:38:17 -0500
Received: from snail.cherry.relay.mailchannels.net ([23.83.223.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1r9zmh-00032T-Pf
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 22:38:17 -0500
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 7909B800B67;
 Mon,  4 Dec 2023 03:38:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a311.dreamhost.com (unknown [127.0.0.6])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 2716E801018;
 Mon,  4 Dec 2023 03:38:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1701661092; a=rsa-sha256;
 cv=none;
 b=aHs3ukfQ4sw1m+vNJHdD0LU0gpLSHEXeJ8S2we9tYMjxP4gVfDiIp8abYUBxkEbP6kzavQ
 AnjKhbrCO5y9glSfA0c41JrolClJD9TZrFz1PyQTnuQqqYXExTOC5e9O2eKAXgMCHnAGvX
 TFS3q5/upQiMocrmBzByUxLzQR/KdPOAVDxMW6m00V4hvs4Nq+8AwXPFPI1afPUxbX5LG4
 jf0Qdw4qMTAEG5dyaSKXJhJK2GFMzlvsNG+23SnNhZFpATlwzC+Vjd0B6JETcCLmyR8Mao
 JLDeB0om+vnaq8MGcJANjttA078mz5bp3yfHiKK6YWozrOp4T2Cj0nprNnZJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1701661092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=K74d7xxd+yCSw1VxCQFc6NKaxbaBwygmtdYYlXUMchQ=;
 b=zUd1ONiGiL7ikhb4eVWvW4FqtDYx+5xbuaxiqCNrv5EOEWbz0HviCDlUo3l+fo8IPCCSiV
 z9/+VX63ZXgtqOBM8ambHiXvpgy5ttOSMUTli8N2dQwO98ZbMSOiOKi0jd3iP6nyMw2Y/D
 m/sJJExcef2mJgmT020v/y1/1GlsWt39S/avkIb106YBLknxNIvmBVdkymPmZYms6A/OMd
 723SqebdSQ2j3gjAj99R8SGVTOWqU41RwzRXrExcddBjl296BtEx54/lE4+OTzus0lbnfI
 4s6Ucu/V74EfmPu76XX+0zf4MlXOvZEPnM7OQYzwMI6ZgYtRUogPWOhXuQsnLA==
ARC-Authentication-Results: i=1; rspamd-d88d8bd54-t8ckq;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tart-Print: 49f1210f1c359cf8_1701661092304_1841656037
X-MC-Loop-Signature: 1701661092304:3664548144
X-MC-Ingress-Time: 1701661092304
Received: from pdx1-sub0-mail-a311.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.117.248.75 (trex/6.9.2); Mon, 04 Dec 2023 03:38:12 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a311.dreamhost.com (Postfix) with ESMTPSA id 4Sk8Wl4QBQzJH; 
 Sun,  3 Dec 2023 19:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1701661091;
 bh=K74d7xxd+yCSw1VxCQFc6NKaxbaBwygmtdYYlXUMchQ=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=HxiqZdjW1h1o49/nT3ICO/bvKc/Kuk1pvxYqImo9WvMHE0bggmtGox2wnDoa7dNIN
 mo8GAta0tc85RbljGYW6KKIZ/wGn/TJPPZ9U1mXratkG0vUOHwXAk4GsmCoCHbWzoT
 81yOfYgapsENUkKTSEpscoVSt6+V4Xq4+/ncFub1MjxL04ofaFU1OeV5SXLEx5wGKL
 g0K8SDhzXm3ZrPolWfhalaqxW49q1qPQC38HFCmpOHQZ2xbRrqT4XKYWdkjw5ZQX45
 5kJU/GYE5E5mKCgowrD7RLmNsxn4qXYtkWF84T7Z7Jg01BI0f4G5YoPjKVr/f5WjaC
 OlupKiYtTwQog==
Date: Sun, 3 Dec 2023 19:38:08 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Fan Ni <fan.ni@samsung.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-cxl@lore.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v1 1/2] hw/cxl/device: read from register values in
 mdev_reg_read()
Message-ID: <20231204033808.77k4r2zub5lzi7ad@offworld>
References: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
 <20231127105830.2104954-2-42.hyeyoo@gmail.com>
 <20231127202702.zkqomoapz2iprpra@offworld>
 <20231130163253.00002140@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231130163253.00002140@Huawei.com>
User-Agent: NeoMutt/20220429
Received-SPF: pass client-ip=23.83.223.170; envelope-from=dave@stgolabs.net;
 helo=snail.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, 30 Nov 2023, Jonathan Cameron wrote:

>If you mean generally harden the code we haven't fixed up for
>big endian systems then fair enough - that indeed needs doing.

Yes, that was a braino, sorry for the confusion.

>Tricky to be sure we got it all right though unless we have a big
>endian arch to test on...

Indeed.

