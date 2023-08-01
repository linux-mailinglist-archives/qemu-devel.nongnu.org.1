Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3AD76BAD6
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 19:10:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQssS-0006fm-14; Tue, 01 Aug 2023 13:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qQssI-0006fR-Jz
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qQssE-0004Cs-WD
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690909767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7TYdUQSbsMdQlXtHfoM5M3lYMBKRaXC7t6qTUsDgJ84=;
 b=A1S7Pn+52ECq5EszXFpCY0D1mz/MVto4Z1YeQrfpqIQBHD8SICdbJp5t2b1YRi5X2IpFu+
 xXsoQbfeHE3mTicVecxVeQt0eMiJELN6u/2Gqa9Gg771F6L8eKEX90GXV6PlYF9Wr52xTr
 S+sn2q7kgm4pe4XVqjYKbkL9FjYyzns=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426--ys7HvB1NkWh1H4lSg9l_g-1; Tue, 01 Aug 2023 13:09:25 -0400
X-MC-Unique: -ys7HvB1NkWh1H4lSg9l_g-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76c8e07cbe9so102935385a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 10:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690909765; x=1691514565;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7TYdUQSbsMdQlXtHfoM5M3lYMBKRaXC7t6qTUsDgJ84=;
 b=MDEn2m/YTWpPf7A5zj0ntVSfJDMgrr1YG5qNuKj3bv5luRcHdEh4kvKaeouQBzMTq6
 jSpyMHQsYFyR8n570DEVdM8e5LLUnrZdQyyNInTms1fO3bh8EbUo00UpBpKvGHwVHB/w
 hea4cjfFEKgE3Guhg/2yJOSCU6fy3ddqu3gBTAEXTBXWN02N1i4o4DeIT/yzmCzaQdst
 wyoEdMrZHlmnPqRGfgNuQ8Gnf20ehbBWWp2j1saqsa3KNusFncxNxzeXzne1twD7QvOr
 d5e+LJ1pMf4X/RFPp31Zw3mOyBfpfmd6nCiG57IIwEeSL2Khns8nS1KFUnu9p+Rs2wPW
 1WTw==
X-Gm-Message-State: ABy/qLY0/FvtYH7+9USqXbjYJxz72kZW1Mde2SpefuaKXHcB7TkqNjbK
 bJd23+9XtpneOcfTRcvgKpxLNuPBdI9la6WsJdod4YnhNiXQqk0QD2SZMfoK9MBVwe8Mhj5fxWx
 +dmwQ/oTe8EnrpAU=
X-Received: by 2002:a05:620a:2a05:b0:76c:c782:de60 with SMTP id
 o5-20020a05620a2a0500b0076cc782de60mr2061860qkp.4.1690909765135; 
 Tue, 01 Aug 2023 10:09:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHvAPKlX6rFjJPNAYdOVKtEd2UYKnjJ6suC2euGTiq8NWnPWXgkyVwwOaiPDjVFk7B60+Zqxw==
X-Received: by 2002:a05:620a:2a05:b0:76c:c782:de60 with SMTP id
 o5-20020a05620a2a0500b0076cc782de60mr2061839qkp.4.1690909764826; 
 Tue, 01 Aug 2023 10:09:24 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 27-20020a05620a079b00b00767da9b6ae9sm4283810qka.11.2023.08.01.10.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 10:09:24 -0700 (PDT)
Date: Tue, 1 Aug 2023 13:09:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrei Gudkov <gudkov.andrei@huawei.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, leobras@redhat.com,
 eblake@redhat.com, armbru@redhat.com
Subject: Re: [PATCH] migration/calc-dirty-rate: millisecond precision period
Message-ID: <ZMk8QmJ1fjghgwXD@x1n>
References: <8571da37847f9bb39b84e62ef4998e68ef3c10d1.1688028297.git.gudkov.andrei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8571da37847f9bb39b84e62ef4998e68ef3c10d1.1688028297.git.gudkov.andrei@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Jun 29, 2023 at 11:59:03AM +0300, Andrei Gudkov wrote:
> Introduces alternative argument calc-time-ms, which is the
> the same as calc-time but accepts millisecond value.
> Millisecond precision allows to make predictions whether
> migration will succeed or not. To do this, calculate dirty
> rate with calc-time-ms set to max allowed downtime, convert
> measured rate into volume of dirtied memory, and divide by
> network throughput. If the value is lower than max allowed
> downtime, then migration will converge.
> 
> Measurement results for single thread randomly writing to
> a 24GiB region:
> +--------------+--------------------+
> | calc-time-ms | dirty-rate (MiB/s) |
> +--------------+--------------------+
> |          100 |               1880 |
> |          200 |               1340 |
> |          300 |               1120 |
> |          400 |               1030 |
> |          500 |                868 |
> |          750 |                720 |
> |         1000 |                636 |
> |         1500 |                498 |
> |         2000 |                423 |
> +--------------+--------------------+
> 
> Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>

Andrei, do you plan to enhance the commit message and data in a repost?  I
assume you may want to have your data points updated after the discussion,
and it won't need to be in a rush as it will only land 8.2.

The patch itself looks fine to me:

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


