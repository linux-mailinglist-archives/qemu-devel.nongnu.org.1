Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D85D7B9D37
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 15:11:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoO7N-0004RL-6t; Thu, 05 Oct 2023 09:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoO7F-0004Pr-Gz
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:10:10 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoO7A-0003qa-4k
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:10:07 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:b9a4:0:640:eb37:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id C905B62FD7;
 Thu,  5 Oct 2023 16:09:59 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b584::1:2f] (unknown
 [2a02:6b8:b081:b584::1:2f])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id w9YM7W4OdOs0-vmFoIQeS; Thu, 05 Oct 2023 16:09:59 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696511399;
 bh=r5Sg/7xfknegKX6j7cr7vBPwkX6vTdCUuzYwPasDT78=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=FM+cIk7HrWugbdQDPShwP0MDVHDQ57jmcCOOsttTD88nBgIk4dhgOB6zynFx+4NVX
 h8ul3+f0AJVOHydOyl8+gxyxQdmqrQJVDyW6aaG3WVC/0P4Bys4s1g2WRWB8gE+NdP
 eFs9iinRE9gEhG/8+W0NHZi0j4o04pxKP0UGsPeE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3ee9dc9c-a18e-4ff4-84e9-8126a72b1b95@yandex-team.ru>
Date: Thu, 5 Oct 2023 16:09:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] softmmu/vl: improve select_machine() function
Content-Language: en-US
To: qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: yc-core@yandex-team.ru
References: <20230725174730.1185838-1-vsementsov@yandex-team.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230725174730.1185838-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 25.07.23 20:47, Vladimir Sementsov-Ogievskiy wrote:
>   - put machine name into error message (helps debugging CI)
>   - fix style (over-80 lines)
>   - use g_autoptr
>   - drop extra error propagation
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

ping ;)

-- 
Best regards,
Vladimir


