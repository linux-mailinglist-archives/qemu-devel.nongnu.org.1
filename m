Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ABD7E7AE3
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:31:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Nqt-0001Ld-OQ; Fri, 10 Nov 2023 04:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r1NqQ-0001Fp-23
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:30:31 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r1NqN-0005Em-Hk
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:30:29 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9e61e969b1aso72304566b.0
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 01:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699608625; x=1700213425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5S7USYSCfGgg9g9mYvxmn/Zdgy19yS2oTCfFTlk5WVY=;
 b=Lc3McOealI0SgxhDTSM0GC0xD0vlMNPm/bydr48n6Qzz8prpW6X367JMaUmw3zvvyW
 p5HAHjEZeSCsz1tUQVx4Rr4jq/gCJ3tSC2h9EKBNFtd/aG+Kgykdp/PBKDnfOJx5wgd3
 TdUN7IlNaQIey8LNlB8p6x0tyjx+duu7VeUVkkOic1z7t4pnCp2nRT2vpZztilcujKkv
 ov3mY4dkcPrVDRsD4RmhwLXgtT63nUbtu5Dyo2C8FO++mX70xGbJNb84aUMSHa/K2mSm
 OHhoT0/5pOZCTkXituEFsuOsbihjjlVcFDsVRyDJaqJbhp1gl41yYfy2/4ebkHLOr+5Y
 17Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699608625; x=1700213425;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5S7USYSCfGgg9g9mYvxmn/Zdgy19yS2oTCfFTlk5WVY=;
 b=AEXgQsAyoGOg5IdhXL7GdlMvgNxeJxNXdupBrCLZ1Rvfa9wanii8CBSW4rn+/n0m6N
 DoklLFtDAXpUcKCzzi0LjFIzMkhItFL2E9oLAn/9ERq2mIquBWZNl1G06AmfPpLudAuh
 LIoQegvCi+ciZIPJGT2XKdUvM2HeJBrCE4Hwn/tMifSNQz1X/K9Pis88pEXT173wb6Mw
 j5SmqIafEMAfsZgQ1U5wGKDYLVvwIt92VmCNalOXcphl5siotUPzAiQjZ1uXkP8Da6l8
 Q0eFtF5rKer/g+N8QFLoakI173PT4wBxqYfkJhQtk+84RsvqL4mgt96/8PBoc3bGH3Zb
 iCAg==
X-Gm-Message-State: AOJu0YzcvbrI6U7teY4W7Ni6N6ZT6ZzMA8ED96DZuA14bUDnDLDbz2FS
 k+ZIDuMNfSqGCaIiYrKgcFBVww==
X-Google-Smtp-Source: AGHT+IF00NEiVxXmPewSVhZ859IM03AqPyJYUczTeCzyurEffbKZGvDbC0pUDtZLfoDx40WXPkm/lA==
X-Received: by 2002:a17:907:3ea4:b0:9c3:b3cb:29ae with SMTP id
 hs36-20020a1709073ea400b009c3b3cb29aemr6408122ejc.47.1699608625386; 
 Fri, 10 Nov 2023 01:30:25 -0800 (PST)
Received: from meli.delivery (adsl-157.109.242.225.tellas.gr.
 [109.242.225.157]) by smtp.gmail.com with ESMTPSA id
 m6-20020a05600c3b0600b004077219aed5sm4664650wms.6.2023.11.10.01.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 01:30:24 -0800 (PST)
Date: Fri, 10 Nov 2023 11:26:53 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] virtio-snd: check AUD_register_card return value
User-Agent: meli 0.8.2
References: <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>
 <CAFEAcA-XqkBqKt33pxXHv0Y81kShV1rZatgAYMJNxibBD1a_6A@mail.gmail.com>
 <20231109125334-mutt-send-email-mst@kernel.org>
 <CAFEAcA9-tvxsoGoRksUSQpV-U=Pwc64CD0R17n-QkEwLA8OegA@mail.gmail.com>
 <20231109181752-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231109181752-mutt-send-email-mst@kernel.org>
Message-ID: <3wiem.x9bcv3ybznjq@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 10 Nov 2023 01:23, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>On Thu, Nov 09, 2023 at 06:03:15PM +0000, Peter Maydell wrote:
>> On Thu, 9 Nov 2023 at 17:53, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >
>> > On Thu, Nov 09, 2023 at 04:25:04PM +0000, Peter Maydell wrote:
>> > > On Thu, 9 Nov 2023 at 16:21, Manos Pitsidianakis
>> > > <manos.pitsidianakis@linaro.org> wrote:
>> > > >
>> > > > AUD_register_card might fail. Even though errp was passed as an
>> > > > argument, the call's return value was not checked for failure.
>> > >
>> > > For whoever picks up this patch: we can add
>> > > "Fixes Coverity CID 1523899" to the commit message.
>> >
>> >
>> > Better:
>> >
>> > Fixes: Coverity CID 1523899
>> 
>> I thought "Fixes:" as a header-line like that was for
>> the commit hash/subject of the commit the patch is fixing?
>> 
>> thanks
>> -- PMM
>
>This works for many other things
>e.g. gitlab issues (closes them). Fixes without : is much harder to
>distinguish from just general english text.
>qemu uses a mix of Fixes: Resolves: and Closes: .
>I don't see a real need for distinct tags for commit versus gitlab
>issue link: one can look at the contents to figure that out.

The "Fixes:" trailer is for commits.
In the kernel they use "Addresses-Coverity-ID: ..." but I can't find out 
if it's part of some automated workflow or just convention.

Example commit in torvalds/linux: 
5ad2e46030ad97de7fdbdaf63bb1af45c7caf3dd

