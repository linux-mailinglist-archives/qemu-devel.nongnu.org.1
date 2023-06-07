Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C20726723
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 19:22:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wrU-0008Df-IU; Wed, 07 Jun 2023 13:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q6wrS-0008DX-0a
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:22:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q6wrL-0007ZO-6k
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:22:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 18909B614;
 Wed,  7 Jun 2023 20:22:08 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C4013A562;
 Wed,  7 Jun 2023 20:22:06 +0300 (MSK)
Message-ID: <aaedf466-cd54-e505-f7cd-713d9ece302c@tls.msk.ru>
Date: Wed, 7 Jun 2023 20:22:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] 9pfs: prevent opening special files (CVE-2023-2861)
Content-Language: en-US
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Mauro Matteo Cascella <mcascell@redhat.com>,
 yw s <ywsplz@gmail.com>, shawtao1125@gmail.com, jkli@xidian.edu.cn,
 shenwenbo@zju.edu.cn
References: <E1q6w7r-0000Q0-NM@lizzy.crudebyte.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <E1q6w7r-0000Q0-NM@lizzy.crudebyte.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

07.06.2023 19:29, Christian Schoenebeck wrote:
> The 9p protocol does not specifically define how server shall behave when
> client tries to open a special file, however from security POV it does
> make sense for 9p server to prohibit opening any special file on host side
> in general. A sane Linux 9p client for instance would never attempt to
> open a special file on host side, it would always handle those exclusively
> on its guest side. A malicious client however could potentially escape
> from the exported 9p tree by creating and opening a device file on host
> side.
> 
> With QEMU this could only be exploited in the following unsafe setups:
> 
>    - Running QEMU binary as root AND 9p 'local' fs driver AND 'passthrough'
>      security model.
> 
> or
> 
>    - Using 9p 'proxy' fs driver (which is running its helper daemon as
>      root).
> 
> These setups were already discouraged for safety reasons before,
> however for obvious reasons we are now tightening behaviour on this.
> 
> Fixes: CVE-2023-2861
> Reported-by: Yanwu Shen <ywsPlz@gmail.com>
> Reported-by: Jietao Xiao <shawtao1125@gmail.com>
> Reported-by: Jinku Li <jkli@xidian.edu.cn>
> Reported-by: Wenbo Shen <shenwenbo@zju.edu.cn>
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Revived-by: Michael Tokarev <mjt@tls.msk.ru>

Thank you!

/mjt

