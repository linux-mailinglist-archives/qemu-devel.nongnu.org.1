Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0511673D7B5
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:20:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfYp-0006I4-0W; Mon, 26 Jun 2023 02:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfYW-0006CG-KX; Mon, 26 Jun 2023 02:18:38 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfYU-0004BQ-EK; Mon, 26 Jun 2023 02:18:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqHht613Xz4wb3;
 Mon, 26 Jun 2023 16:18:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHhr1Qbvz4wZr;
 Mon, 26 Jun 2023 16:18:19 +1000 (AEST)
Message-ID: <eed9ab9e-9fe6-45a7-7cf7-4f465a3839dd@kaod.org>
Date: Mon, 26 Jun 2023 08:18:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: qemu-system-ppc64 option -smp 2 broken with commit
 20b6643324a79860dcdfe811ffe4a79942bca21e
Content-Language: en-US
To: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, harshpb@linux.ibm.com,
 richard.henderson@linaro.org, alex.bennee@linaro.org
References: <8780abd9-59ef-c452-bfee-c3bfbf275e51@linux.vnet.ibm.com>
 <a474146f-cd1d-b91a-eefd-596a1d08f772@kaod.org>
 <2bfdaf0e-4da6-00a4-aa2b-4615b05179be@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <2bfdaf0e-4da6-00a4-aa2b-4615b05179be@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hello Anushree


> Hello Cedric,
>
> As per your mail, I have created the gitlab issue https://gitlab.com/qemu-project/qemu/-/issues/1726.

Alex had a request for the bug report. If you have to time to provide
the data, it should help analyzing the issue.

Thanks,

C.


