Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7D87BC8A3
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 17:35:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp9Ix-00012i-W8; Sat, 07 Oct 2023 11:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qp9Iu-00012a-Ex
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 11:33:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qp9Is-0004X4-Qp
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 11:33:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 46F49285AB;
 Sat,  7 Oct 2023 18:33:21 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 527652D83C;
 Sat,  7 Oct 2023 18:33:13 +0300 (MSK)
Message-ID: <0de0450d-754a-4f1a-bfb4-9534e772a018@tls.msk.ru>
Date: Sat, 7 Oct 2023 18:33:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/21] vfio queue
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Auger <eauger@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20231006062005.1040296-1-clg@redhat.com>
 <1e2652d6-c10b-9b65-6e2c-7903574d501a@redhat.com>
 <3ea30f06-aeea-8e66-a8ed-75a9292a415f@redhat.com>
 <1c19badf-0c65-4ee0-61a0-e653b7be89bf@redhat.com>
 <58d75d69-cfd8-903e-c0a1-f95acc64bfd0@redhat.com>
 <1d87070c-2561-c6da-1380-9e3e13bcd844@redhat.com>
 <a0feb302-2490-8e3c-a54a-47bc8671f11e@redhat.com>
 <27807aad-57c1-ca10-f697-a2848d32c826@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <27807aad-57c1-ca10-f697-a2848d32c826@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

07.10.2023 13:14, Cédric Le Goater wrote:

> Please send a v5 for "Prerequisite changes for IOMMUFD support" with the
> fixes we talked about. I will rebuild a PR next week.

Can you push the first bugfix at least, so it will not miss stable-8.1.2?

Thanks,

/mjt

