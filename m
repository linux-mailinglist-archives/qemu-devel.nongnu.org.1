Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7E9B09AFF
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Jul 2025 07:47:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucdv1-0006xS-G8; Fri, 18 Jul 2025 01:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangzhijie@bosc.ac.cn>)
 id 1ucdtO-0005Wv-OJ; Fri, 18 Jul 2025 01:44:24 -0400
Received: from [115.124.28.3] (helo=out28-3.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangzhijie@bosc.ac.cn>)
 id 1ucdtL-0002FI-MQ; Fri, 18 Jul 2025 01:44:22 -0400
Received: from 172.38.29.107(mailfrom:zhangzhijie@bosc.ac.cn
 fp:SMTPD_---.dqh.dW4_1752817197 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 18 Jul 2025 13:39:58 +0800
Message-ID: <8eb973af-20f3-40d4-b611-15cb4933c5c0@bosc.ac.cn>
Date: Fri, 18 Jul 2025 13:39:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCIE-Host Support 64Bit resource for DesignwarePCIEHost
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 wangran@bosc.ac.cn, zhangjian@bosc.ac.cn, peter.maydell@linaro.org,
 andrew.smirnov@gmail.com, qemu-arm@nongnu.org
References: <20250715064400.2289152-1-zhangzhijie@bosc.ac.cn>
 <631BA6B2-268F-4DDC-9DA6-77697373A5DF@gmail.com>
 <0029ad6d-c25e-46d3-be2f-5d23087df287@bosc.ac.cn>
 <03BC71CC-647D-418E-88A3-7D66D858D2B5@gmail.com>
From: zhangzhijie <zhangzhijie@bosc.ac.cn>
In-Reply-To: <03BC71CC-647D-418E-88A3-7D66D858D2B5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.3 (deferred)
Received-SPF: pass client-ip=115.124.28.3; envelope-from=zhangzhijie@bosc.ac.cn;
 helo=out28-3.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Hi

在 2025/7/17 18:24, Bernhard Beschow 写道:
> Nice. Is there a datasheet (standalone or for the riscv SoC using this IP block) which you could provide? The QEMU emulation has some bugs which I'd like to fix.


I not got designedware datasheet. I read Linux kernel code and found 
this feature. I think  dw rc support on every machine if you want.

Thanks.

