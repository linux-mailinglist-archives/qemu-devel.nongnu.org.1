Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E167C7F7279
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:11:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6U50-0000YP-1m; Fri, 24 Nov 2023 06:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1r6U4w-0000W7-OR; Fri, 24 Nov 2023 06:10:35 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1r6U4u-0006US-Uz; Fri, 24 Nov 2023 06:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RTiUCB0mh65O1ToYbUrrgwA7VXWe7X+LMv7xW29d8hg=; b=Yp/HmrRMa30R/47XHqCLi0ZorV
 6YcRxXCyS7VmEhHLpeWNK/1nI9Z5gLwXqZbvWJXq02vAGcY0LnZOTtm4VDuhU9jhDS3JeVcbepeEv
 sO3Y3a8DAcE2H/rO8BbvrEQeqlAtoydk3d6qszPiMVrf/PbyWoCKwMJXLs7zSaqwP3q0=;
Date: Fri, 24 Nov 2023 12:10:09 +0100
To: Samuel Tardieu <sam@rfc1149.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Alessandro Di Federico <ale@rev.ng>
Subject: Re: [PATCH] target/hexagon/idef-parser/prepare: use env to invoke bash
Message-ID: <mq4raa32vxh2b5on5pztsrocu4mqzej3sxhflr3na7lq4anxm5@nygwh4srb2ar>
References: <20231123211506.636533-1-sam@rfc1149.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231123211506.636533-1-sam@rfc1149.net>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 23/11/23, Samuel Tardieu wrote:
> This file is the only one involved in the compilation process which
> still uses the /bin/bash path.
> 
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> ---
>  target/hexagon/idef-parser/prepare | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hexagon/idef-parser/prepare b/target/hexagon/idef-parser/prepare
> index 72d6fcbd21..cb3622d4f8 100755
> --- a/target/hexagon/idef-parser/prepare
> +++ b/target/hexagon/idef-parser/prepare
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/usr/bin/env bash
>  
>  #
>  #  Copyright(c) 2019-2021 rev.ng Labs Srl. All Rights Reserved.
> -- 
> 2.42.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

